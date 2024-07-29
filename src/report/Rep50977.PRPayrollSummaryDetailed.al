report 50977 "PR Payroll Summary - Detailed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll\Report\SSR\PRPayrollSummaryDetailed.rdl';

    dataset
    {
        dataitem(DataItem1; "PRL-Period Transactions")
        {
            RequestFilterFields = "Employee Code", "Payroll Period", "Department Code";
            column(TransactionCode_PRPeriodTransactions; "Transaction Code")
            {
            }
            column(Amount_PRPeriodTransactions; Amount)
            {
            }
            column(EmployeeCode_PRPeriodTransactions; "Employee Code")
            {
            }
            column(TransactionName_PRPeriodTransactions; "Transaction Name")
            {
            }
            column(PeriodMonth_PRPeriodTransactions; "Period Month")
            {
            }
            column(PeriodYear_PRPeriodTransactions; "Period Year")
            {
            }
            column(GlobalDimension1Code_PRPeriodTransactions; "Department Code")
            {
            }
            column(GroupOrder_PRPeriodTransactions; "Group Order")
            {
            }
            column(SubGroupOrder_PRPeriodTransactions; "Sub Group Order")
            {
            }
            column(FullName; FullName)
            {
            }
            column(RowNum; RowNum)
            {
            }
            column(HideDetails; HideDetails)
            {
            }

            trigger OnAfterGetRecord()
            begin
                FullName := '';
                RowNum := 0;

                IF "Employee Code" <> "Employee Code" THEN RowNum += 1;

                CLEAR(HREmp);
                HREmp.SETRANGE(HREmp."No.", "Employee Code");
                IF HREmp.FIND('-') THEN FullName := UPPERCASE(HREmp."First Name" + '' + HREmp."Middle Name" + '' + HREmp."Last Name");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(HideDetails; HideDetails)
                {
                    Caption = 'Hide Details';
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
        //HRCodeunit.fn_HRPRAccessList(USERID);

        IF PRLPeriodTransactions.GETFILTER("Payroll Period") = '' THEN BEGIN
            PRPayrollPeriods.RESET;
            PRPayrollPeriods.SETRANGE(PRPayrollPeriods.Closed, FALSE);
            IF PRPayrollPeriods.FIND('-') THEN BEGIN
                PRLPeriodTransactions.SETFILTER("Payroll Period", FORMAT(PRPayrollPeriods."Date Opened"));
            END;
        END;
    end;

    trigger OnPreReport()
    begin
        PRLPeriodTransactions.SETCURRENTKEY("Employee Code", "Period Month", "Period Year",
        "Group Order", "Sub Group Order");
    end;

    var
        HREmp: Record "HRM-Employee C";
        FullName: Text;
        RowNum: Integer;
        HideDetails: Boolean;
        PRPayrollPeriods: Record "PRL-Payroll Periods";
        PRLPeriodTransactions: Record "PRL-Period Transactions";
    //HRCodeunit: Codeunit "50000";
}

