report 50115 "Payroll Summary Depts."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payroll Summary Depts..rdl';

    dataset
    {
        dataitem(DataItem1000000007; "PRL-Period Transactions")
        {
            DataItemTableView = SORTING("Payroll Period", "Group Order", "Sub Group Order")
                                ORDER(Ascending)
                                WHERE("Group Order" = FILTER(1 | 3 | 4 | 7 | 8 | 9));
            column(GO; "Group Order")
            {
            }
            column(SGO; "Sub Group Order")
            {
            }
            column(DeptCodes; "Dimension Value".Code)
            {
            }
            column(DeptName; "Dimension Value".Name)
            {
            }
            column(DeptCodez; HRMEmployeeD."Department Code")
            {
            }
            column(DeptNames; HRMEmployeeD."Total Hours Worked")
            {
            }
            column(UserId; CurrUser)
            {
            }
            column(DateToday; TODAY)
            {
            }
            column(PrintTime; TIME)
            {
            }
            column(pic; info.Picture)
            {
            }
            column(PrintBy; 'PRINTED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(CheckedBy; 'CHECKED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(VerifiedBy; 'VERIFIED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(ApprovedBy; 'APPROVED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(BasicPayLbl; 'BASIC PAY')
            {
            }
            column(payelbl; 'PAYE.')
            {
            }
            column(nssflbl; 'NSSF')
            {
            }
            column(nhiflbl; 'NHIF')
            {
            }
            column(Netpaylbl; 'Net Pay')
            {
            }
            column(payeamount; payeamount)
            {
            }
            column(nssfam; nssfam)
            {
            }
            column(nhifamt; nhifamt)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(GrossPay; GrossPay)
            {
            }
            column(periods; 'PAYROLL SUMMARY for ' + FORMAT(periods, 0, 4))
            {
            }
            column(empNo; HRMEmployeeD."No.")
            {
            }
            column(empName; HRMEmployeeD."No." + ': ' + HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name")
            {
            }
            column(TransCode; "Transaction Code")
            {
            }
            column(TransName; "Transaction Name")
            {
            }
            column(TransAmount; Amount)
            {
            }
            column(TransBalance; Balance)
            {
            }
            column(OrigAmount; "Original Amount")
            {
            }

            trigger OnAfterGetRecord()
            begin
                HRMEmployeeD.RESET;
                HRMEmployeeD.SETRANGE("No.", "Employee Code");
                IF HRMEmployeeD.FIND('-') THEN BEGIN
                    "Dimension Value".RESET;
                    "Dimension Value".SETFILTER("Dimension Value"."Dimension Code", '%1|%2', 'DEPARTMENTS', 'DEPARTMENT');
                    "Dimension Value".SETFILTER("Dimension Value".Code, HRMEmployeeD."Department Code");
                    IF "Dimension Value".FIND('-') THEN BEGIN
                    END;
                END;
                //IF "PRL-Period Transactions"."Transaction Code" IN ['NPAY','PAYE','NSSF','NHIF','BPAY','GPAY'] THEN CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Payroll Period", '=%1', periods);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Period; periods)
                {
                    Caption = 'Period:';
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
        Users.RESET;
        Users.SETRANGE(Users."User Name", USERID);
        IF Users.FIND('-') THEN BEGIN
            IF Users."Full Name" = '' THEN CurrUser := Users."User Name" ELSE CurrUser := Users."Full Name";
        END;

        info.RESET;
        IF info.FIND('-') THEN info.CALCFIELDS(info.Picture);

        prPayrollPeriods.RESET;
        prPayrollPeriods.SETRANGE(Closed, FALSE);
        IF prPayrollPeriods.FIND('-') THEN BEGIN
            periods := prPayrollPeriods."Date Opened";
        END;

        IF periods = 0D THEN ERROR('Please Specify the Period first.');
        counts := 0;
        NetPayTotal := 0;
        BasicPayTotal := 0;
        payeamountTotal := 0;
        nssfamTotal := 0;
        nhifamtTotal := 0;
        TransCount := 0;
        showdet := TRUE;
        NetPay := 0;
        BasicPay := 0;
        CLEAR(TranscAmount);
        payeamount := 0;
        nssfam := 0;
        nhifamt := 0;
        GrossPay := 0;
    end;

    var
        prPayrollPeriods: Record "PRL-Payroll Periods";
        periods: Date;
        counts: Integer;
        prPeriodTransactions: Record "PRL-Period Transactions";
        TransName: array[1, 200] of Text[200];
        Transcode: array[1, 200] of Code[100];
        TransCount: Integer;
        TranscAmount: array[1, 200] of Decimal;
        TranscAmountTotal: array[1, 200] of Decimal;
        NetPay: Decimal;
        NetPayTotal: Decimal;
        showdet: Boolean;
        payeamount: Decimal;
        payeamountTotal: Decimal;
        nssfam: Decimal;
        nssfamTotal: Decimal;
        nhifamt: Decimal;
        nhifamtTotal: Decimal;
        BasicPay: Decimal;
        BasicPayTotal: Decimal;
        GrossPay: Decimal;
        GrosspayTotal: Decimal;
        prtransCodes: Record "PRL-Transaction Codes";
        info: Record 79;
        Users: Record 2000000120;
        CurrUser: Code[100];
        "Dimension Value": Record 349;
        HRMEmployeeD: Record "HRM-Employee C";
}

