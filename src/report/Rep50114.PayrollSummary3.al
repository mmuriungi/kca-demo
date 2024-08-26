report 50114 "Payroll Summary 3"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payroll Summary 3.rdl';

    dataset
    {
        dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
        {

            DataItemTableView = SORTING("Group Order") ORDER(Ascending) WHERE("Group Order" = FILTER(1 | 3 | 4 | 7 | 8 | 9));
            column(DeptCodes; DimensionValue.Code)
            {
            }
            column(DeptName; DimensionValue.Name)
            {
            }

            column(UserId; CurrUser)
            {
            }
            column(DateToday; Today)
            {
            }
            column(PrintTime; Time)
            {
            }
            column(pic; info.Picture)
            {
            }
            column(TransCode; "PRL-Period Transactions"."Transaction Code")
            {
            }
            column(EmpCode; "PRL-Period Transactions"."Employee Code")
            {
            }
            column(TransName; "PRL-Period Transactions"."Transaction Name")
            {
            }
            column(GO; "PRL-Period Transactions"."Group Order")
            {
            }
            column(Perdate; "PRL-Period Transactions"."Payroll Period")
            {
            }
            column(amt; "PRL-Period Transactions".Amount)
            {
            }
            column(bal; "PRL-Period Transactions".Balance)
            {
            }
            column(EmpName; HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name")
            {
            }
            column(empcategory; HRMEmployeeD."Employee Category")
            {

            }
            column(PeriodName; prPayrollPeriods."Period Name")
            {
            }
            column(compName; info.Name)
            {
            }
            column(compAddress; info.Address)
            {
            }
            column(compPhone; info."Phone No.")
            {
            }
            column(pfno; pfno)
            {

            }
            column(staffname; staffname)
            {

            }

            trigger OnAfterGetRecord()
            begin

                HRMEmployeeD.Reset;
                HRMEmployeeD.SetRange("No.", "PRL-Period Transactions"."Employee Code");
                HRMEmployeeD.SetFilter("Employee Category", '<>%1|<>%2', 'CASUALS', 'PART-TIME');
                if HRMEmployeeD.Find('-') then begin
                    pfno := HRMEmployeeD."No.";
                    staffname := HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name";
                    DimensionValue.Reset;
                    DimensionValue.SetRange(DimensionValue."Dimension Code", 'COST CENTERS');
                    DimensionValue.SetRange(DimensionValue.Code, HRMEmployeeD."Department Code");
                    if DimensionValue.Find('-') then;
                end;
            end;

            trigger OnPreDataItem()
            begin
                "PRL-Period Transactions".SetRange("PRL-Period Transactions"."Payroll Period", periods);
                "PRL-Period Transactions".setfilter("Employee Category", '<>%1|<>%2', 'CASUALS', 'PART-TIME');
                prPayrollPeriods.Reset;
                prPayrollPeriods.SetRange("Date Opened", periods);
                if prPayrollPeriods.Find('-') then;

                if info.Get then info.CalcFields(Picture);
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
                    ApplicationArea = all;
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
        Users.Reset;
        Users.SetRange(Users."User Name", UserId);
        if Users.Find('-') then begin
            if Users."Full Name" = '' then CurrUser := Users."User Name" else CurrUser := Users."Full Name";
        end;
        prPayrollPeriods.Reset;
        prPayrollPeriods.SetRange(Closed, false);
        if prPayrollPeriods.Find('-') then;
        periods := prPayrollPeriods."Date Opened";
        if Info.Get() then
            Info.CalcFields(Info.Picture);

    end;

    var
        pfno: code[30];
        staffname: Text;
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
        info: Record "Company Information";
        Users: Record User;
        CurrUser: Code[100];
        Gpay: Decimal;
        Gpaytotal: Decimal;
        DimensionValue: Record "Dimension Value";
        HRMEmployeeD: Record "HRM-Employee C";
}

