report 51339 "PayslipTest"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './Layouts/paySlipTest.rdl';
    RDLCLayout = './Layouts/paySlipTest.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("HRM-Employee C"; "HRM-Employee C")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(CompName; compInfo.Name)
            {
            }
            column(pic; compInfo.Picture)
            {

            }
            column(EmpNo; "HRM-Employee C"."No.")
            {
            }
            column(Names; "HRM-Employee C"."Last Name" + ' ' + "HRM-Employee C"."Middle Name" + ' ' + "HRM-Employee C"."First Name")
            {
            }

            column(DOJ; "HRM-Employee C"."Date Of Join")
            {
            }
            column(PinNo; "HRM-Employee C"."PIN Number")
            {
            }
            column(PeriodFilter; Periods)
            {
            }
            column(LegnthOfService; LegnthOfService)
            {
            }
            column(PayslipMessage; PRLPayrollPeriods."Payslip Message")
            {
            }
            column(Grade_Level; "Grade Level")
            {

            }
            column(Salary_Grade; "Salary Grade")
            {

            }
            column(Job_Name; "Job Name")
            {

            }
            column(Department_Name; "Department Name")
            {

            }
            column(Campus; Campus)
            {

            }
            column(ClosureSectionRemark; ' ')
            {
            }

            column(AccNo; "HRM-Employee C"."Bank Account Number")
            {
            }
            column(bankBranch; bankBranch)
            {

            }
            column(bankName; bankName)
            {

            }

            dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                column(GroupText; "PRL-Period Transactions"."Group Text")
                {
                }
                column(TransCode; "PRL-Period Transactions"."Transaction Code")
                {
                }
                column(TransName; "PRL-Period Transactions"."Transaction Name")
                {
                }
                column(TransAmount; "PRL-Period Transactions".Amount)
                {
                }
                column(TransBalance; "PRL-Period Transactions".Balance)
                {
                }
                column(GO; "PRL-Period Transactions"."Group Order")
                {
                }
                column(PerName; PerName)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //"PRL-Period Transactions".SETCURRENTKEY("PRL-Period Transactions"."Group Order");

                    if "PRL-Period Transactions"."Group Text" = 'GROSS PAY' then CurrReport.Skip;
                    if "PRL-Period Transactions"."Group Text" = 'STATUTORIES' then "PRL-Period Transactions"."Group Text" := 'DEDUCTIONS';
                end;

                trigger OnPreDataItem()
                begin
                    PRLPayrollPeriods.Reset;
                    PRLPayrollPeriods.SetRange("Date Opened", Periods);
                    if PRLPayrollPeriods.Find('-') then begin
                        PerName := PRLPayrollPeriods."Period Name";
                    end;
                    "PRL-Period Transactions".SetFilter("PRL-Period Transactions"."Payroll Period", '=%1', Periods);
                    //periodFilter := "HRM-Employee C".GetFilter("HRM-Employee C"."Period Filter");
                    // Periods := "HRM-Employee C".GetRangeMin("HRM-Employee C"."Period Filter");
                    // "PRL-Period Transactions".SetFilter("PRL-Period Transactions"."Payroll Period", '=%1', Periods);
                    //"PRL-Period Transactions".SETCURRENTKEY("PRL-Period Transactions"."Group Order");
                end;
            }
            trigger OnPreDataItem()
            begin

            end;

            trigger OnAfterGetRecord()
            begin
                Periods := "HRM-Employee C".GetRangeMin("HRM-Employee C"."Period Filter2");
                Clear(LegnthOfService);
                if "HRM-Employee C"."Date Of Join" <> 0D then
                    LegnthOfService := HRDates.DetermineAge_Years("HRM-Employee C"."Date Of Join", "HRM-Employee C"."Date Filter");

                PRLBankStructure.Reset;
                PRLBankStructure.SetRange(PRLBankStructure."Bank Code", "HRM-Employee C"."Main Bank");
                if PRLBankStructure.Find('-') then begin
                end;

                if "HRM-Employee C"."Bank Account Number" = '' then "HRM-Employee C"."Bank Account Number" := 'No Banking Data';
                hrEmp.Reset();
                hrEmp.SetRange("No.", "HRM-Employee C"."No.");
                if hrEmp.Find('-') then begin
                    bankBranch := "HRM-Employee C"."Branch Bank Name";
                    bankName := "HRM-Employee C"."Main Bank Name";
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
                field(PerNamePeriods; Periods)
                {
                    ApplicationArea = all;
                    Caption = 'Period Filter';
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        compInfo.Reset;
        if compInfo.Find('-') then begin
        end;
        if compInfo.Get() then
            compInfo.CalcFields(compInfo.Picture);

        PRLPayrollPeriods.Reset;
        PRLPayrollPeriods.SetRange(Closed, false);
        PRLPayrollPeriods.SetFilter("Payroll Code", 'PAYROLL');
        if PRLPayrollPeriods.Find('-') then Periods := PRLPayrollPeriods."Date Opened";
    end;

    trigger OnPreReport()
    begin
        //report bug fixes
        // if (Periods = 0D) and ("HRM-Employee C"."Period Filter" <> 0D) then
        //     Periods := "HRM-Employee C"."Period Filter"
        // else
        //     Periods := Periods;
        //
        //if Periods = 0D then Error('Specify the date filter!');


    end;

    var
        HRDates: Codeunit "HR Dates";
        PerName: Code[50];
        PRLPayrollPeriods: Record "PRL-Payroll Periods";
        Periods: Date;
        LegnthOfService: Code[50];
        compInfo: Record "Company Information";
        PRLBankStructure: Record "PRL-Bank Structure";
        periodFilter: Text[50];
        hrEmp: Record "HRM-Employee C";
        bankBranch: Text[100];
        bankName: text[100];
}

