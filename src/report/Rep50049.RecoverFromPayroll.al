report 50049 "Recover From Payroll"
{
    ApplicationArea = All;
    Caption = 'Recover From Payroll';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(PaymentHeader; "FIN-Imprest Header")
        {
            column(No; "No.")
            {
            }
            trigger OnAfterGetRecord()
            begin

                Objeperiod.reset;
                Objeperiod.SetFilter(Objeperiod.Closed, '=%1', false);
                if Objeperiod.Find('-') then begin
                    Periodmoth := Objeperiod."Period Month";
                    periodYear := Objeperiod."Period Year";
                    PayrallPeriod := Objeperiod."Date Opened";

                    if Objeperiod.Find('-') then begin
                        PaymentHeader.reset;
                        PaymentHeader.SetFilter(Posted, '=%1', true);
                        PaymentHeader.SetFilter("Posted To Payroll", '=%1', false);
                        PaymentHeader.SetFilter("Expected Date of Surrender", '<=%1', Today);


                        IF PaymentHeader.Find('-') THEN begin
                            // TotalRec := PaymentHeader.Count;


                            repeat
                                //Create surrender
                                ImpSur.Reset;
                                ImpSur.SetRange("Created Via Recovery", true);
                                ImpSur.SetRange(Posted, false);
                                ImpSur.SetRange("Imprest Issue Doc. No", PaymentHeader."No.");
                                if not ImpSur.FindFirst() then begin
                                    repeat
                                        NextSurNo := NoSeriesMgt.GetNextNo('SURR', 0D, TRUE);
                                        ImpSur.Init();
                                        ImpSur.No := NextSurNo;
                                        ImpSur."Surrender Date" := TODAY;
                                        ImpSur."Account Type" := ImpSur."Account Type"::Customer;
                                        ImpSur."Account No." := PaymentHeader."Account No.";
                                        ImpSur.Validate("Account No.");

                                        ImpSur."Imprest Issue Doc. No" := PaymentHeader."No.";
                                        ImpSur.Validate("Imprest Issue Doc. No");
                                        ImpSur."Created Via Recovery" := true;
                                        ImpSur.Validate("Created Via Recovery");
                                        ImpSur."post via Recovery" := true;
                                        ImpSur.Status := ImpSur.Status::Approved;
                                        //ImpSur.Validate("post via Recovery");


                                        ImpSur.Insert();


                                    until ImpSur.Next() = 0;

                                    // CommitBudgetSurrender(ImpSur);
                                    //postimprest(ImpSur);





                                end;



                                EmpTransactions.reset;
                                EmpTransactions.SetRange("Employee Code", PaymentHeader."Account No.");
                                EmpTransactions.SetRange("Transaction Code", 'D-0001');
                                EmpTransactions.SetRange("Payroll Period", PayrallPeriod);
                                EmpTransactions.SetRange("Period Month", Periodmoth);
                                EmpTransactions.SetRange("Period Year", periodYear);
                                if not EmpTransactions.Find('-') then begin
                                    PaymentHeader.CalcFields("Total Net Amount");
                                    EmpTransactions.Init();
                                    EmpTransactions."Employee Code" := PaymentHeader."Account No.";
                                    EmpTransactions."Transaction Code" := 'D-0001';
                                    EmpTransactions.Validate("Transaction Code");
                                    EmpTransactions.Amount := PaymentHeader."Total Net Amount";
                                    EmpTransactions."Period Month" := Periodmoth;
                                    EmpTransactions."Period Year" := periodYear;
                                    EmpTransactions."Payroll Period" := PayrallPeriod;
                                    EmpTransactions."Recurance Index" := 1;
                                    EmpTransactions.Insert();
                                end;
                                //if ImprestDetails."Acc interest Amount" <> 0 then begin
                                EmpTransactions.reset;
                                EmpTransactions.SetRange("Employee Code", PaymentHeader."Account No.");
                                EmpTransactions.SetRange("Transaction Code", 'D-0002');
                                EmpTransactions.SetRange("Payroll Period", PayrallPeriod);
                                EmpTransactions.SetRange("Period Month", Periodmoth);
                                EmpTransactions.SetRange("Period Year", periodYear);
                                if not EmpTransactions.Find('-') then begin
                                    PaymentHeader.CalcFields("Total Net Amount");
                                    EmpTransactions.Init();
                                    EmpTransactions."Employee Code" := PaymentHeader."Account No.";
                                    EmpTransactions."Transaction Code" := 'D-0002';
                                    EmpTransactions.Validate("Transaction Code");
                                    //GenledSetup.get;
                                    //interest := genlegSetUp."Interest %";
                                    EmpTransactions.Amount := PaymentHeader."Total Net Amount" * 0.1584;
                                    EmpTransactions."Period Month" := Periodmoth;
                                    EmpTransactions."Period Year" := periodYear;
                                    EmpTransactions."Payroll Period" := PayrallPeriod;
                                    EmpTransactions."Recurance Index" := 1;
                                    EmpTransactions.Insert();



                                end;



                            until PaymentHeader.Next() = 0;



                        end;
                        PaymentHeader."Posted To Payroll" := true;
                        PaymentHeader."Transfer By" := UserId;
                        PaymentHeader."Date Transfered" := Today;
                        PaymentHeader."Time Transfered" := TIME;
                        PaymentHeader."Interest Charged" := true;
                        PaymentHeader."Interest Transfered" := TRUE;
                        PaymentHeader.Modify();
                        //Message('Recovered  from  Payroll Succesfull');

                    end;

                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var

        Objeperiod: Record "PRL-Payroll Periods";
        EmpTransactions: Record "PRL-Employee Transactions";
        Periodmoth: Integer;
        periodYear: Integer;
        PayrallPeriod: date;
        TotalRec: Integer;
        TotalRec2: Integer;
        ImpSur: Record "FIN-Imprest Surr. Header";
        ImpsurrLines: Record "FIN-Imprest Surrender Details";
        gensetup: record "Cash Office Setup";
        NextSurNo: code[20];
        NoSeriesMgt: Codeunit 396;
}
