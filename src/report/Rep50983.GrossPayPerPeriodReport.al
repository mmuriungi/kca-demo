Report 50983 "Gross Pay Per Period Report"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Payroll/payroll Variance/SSR/Levi Management/Reports/SSR/GrossPayPerPeriod.rdl';

    dataset
    {
        dataitem(HRM; "HRM-Employee C")
        {
            RequestFilterFields = "Date Filter", "Transaction Code Filter";
            column(No_HRM; "No.")
            {
            }
            column(PostingGroup; "Posting Group")
            {
            }

            column(CompLogo; info.Picture)
            {

            }
            column(CompName; info.Name)
            {

            }
            column(Transaction_Code; "Transaction Code Filter")
            {

            }
            column(CompAddress; info.Address)
            {

            }
            column(CompEmail; info."E-Mail")
            {

            }
            column(CompPhone; info."Phone No.")
            {

            }
            column(CompUrl; info."Home Page")
            {

            }

            column(EndDate; format(EndDate))
            {

            }
            column(empname; hrm."First Name" + ' ' + HRM."Middle Name" + ' ' + HRM."Last Name")
            {

            }
            column(TransName; TransName)
            {

            }
            column(CTotal; CTotal)
            {

            }
            dataitem(Periods; "Accounting Period")
            {

                column(PariodDate; "Starting Date")
                {

                }
                column(PeriodName; PeriodName)
                {
                }

                column(period2; period2)
                {

                }
                column(Gpay; Gpay)
                {

                }


                trigger OnPreDataItem()
                begin


                    Periods.SetRange("Starting Date", StartDate, EndDate);
                    HRM.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);

                end;

                trigger OnAfterGetRecord()
                begin
                    PeriodName := GetPeriodName(Periods."Starting Date");

                    //period transactions
                    Hrm2.Reset();
                    Hrm2.SetRange("No.", HRM."No.");
                    Hrm2.SetFilter("Date Filter", '%1..%2', Periods."Starting Date", CalcDate('CM', "Starting Date"));
                    Hrm2.SetFilter("Transaction Code Filter", '%1', TransCode);
                    if Hrm2.Find('-') then begin
                        Hrm2.CalcFields("Transaction Totals");
                        Gpay := Hrm2."Transaction Totals";

                    end;
                end;
            }

            trigger OnAfterGetRecord()//Company
            begin
                PeriodName := GetPeriodName(Periods."Starting Date");
                TransName := GetTransactionName(TransCode);

                // Gpay := 0;

                //Opening Balance
                Hrm2.Reset();
                Hrm2.SetRange("No.", HRM."No.");
                Hrm2.SetFilter("Date Filter", '%1..%2', 0D, (StartDate - 1));
                if Hrm2.Find('-') then begin
                    Hrm2.CalcFields("Transaction Totals");
                end;

                //Closing Balance

                Hrm2.Reset();
                Hrm2.SetRange("No.", HRM."No.");
                Hrm2.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
                Hrm2.SetFilter("Transaction Code Filter", '%1', TransCode);
                if Hrm2.Find('-') then begin
                    Hrm2.CalcFields("Transaction Totals");
                    CTotal := Hrm2."Transaction Totals";
                end;

            end;

            trigger OnPreDataItem()//Company
            begin
                info.Get;
                info.CalcFields(Picture);


            end;
        }
    }

    var
        info: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        PeriodName: Text[30];
        period: Code[20];

        period2: Decimal;
        sno: Integer;
        Hrm2: Record "HRM-Employee C";
        RefDate: Date;

        BalBF: decimal;
        Gpay: decimal;
        BalCB: decimal;

        emp: Record "HRM-Employee C";
        empname: Text;
        TransCode: code[30];
        TransName: Text;
        CTotal: decimal;



    trigger OnPreReport()
    begin

        sno := 0;
        //if period = '' then begin
        StartDate := HRM.GetRangeMin("Date Filter");
        EndDate := HRM.GetRangeMax("Date Filter");
        TransCode := HRM.GetRangeMin("Transaction Code Filter");
        // message(format(TransCode));
        // end;s
    end;

    procedure GetPeriodName(var RefDate: Date): Text[30]
    var
        PeriodRec: Record "Accounting Period";
    begin
        IF PeriodRec.GET(RefDate) THEN
            exit(PeriodRec.Name + FORMAT(DATE2DMY(RefDate, 3)));
    end;

    procedure GetTransactionName(var tcode: code[30]): Text[40];
    var
        trans: Record "PRL-Transaction Codes";
    begin

        if trans.Get(tcode) then
            exit(trans."Transaction Name" + ' ' + trans."Transaction Code");

    end;
}