report 50946 "Payroll Variance Report 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\Layouts\Payroll Variance Report12.rdl';

    dataset
    {
        dataitem(DataItem1; "PRL-Period Transactions")
        {
            DataItemTableView = SORTING("Payroll Period", "Group Order", "Sub Group Order")
                                ORDER(Ascending)
                                WHERE("Group Order" = FILTER(<> 6));
            column(USERID; USERID)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(PerName; objPeriod."Period Name")
            {
            }
            column(PayPer; "Payroll Period")
            {
            }
            column(CurrPerName; PeriodName1)
            {
            }
            column(PrevPerName; PeriodName2)
            {
            }
            column(PeriodFilters; "Payroll Period")
            {
            }
            column(PrevAmount; PeriodTrans1.Amount)
            {
            }
            column(TransAmount; Amount)
            {
            }
            column(pic; companyinfo.Picture)
            {
            }
            column(Gtext; "Group Text")
            {
            }
            column(EmpCode; "Employee Code")
            {
            }
            column(TransCode; "Group Text")
            {
            }
            column(TransName; UPPERCASE("Transaction Name"))
            {
            }
            column(VarianceAmount; Amount - PeriodTrans1.Amount)
            {
            }
            column(GO; "Group Order")
            {
            }
            column(SGO; "Sub Group Order")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(seq; seq)
            {
            }

            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
                objEmp.RESET;
                objEmp.SETRANGE(objEmp."No.", "Employee Code");
                IF objEmp.FIND('-') THEN
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                CLEAR(statAmount);

                PeriodTrans1.RESET;
                PeriodTrans1.SETRANGE(PeriodTrans1."Employee Code", "Employee Code");
                PeriodTrans1.SETRANGE(PeriodTrans1."Group Text", "Group Text");
                PeriodTrans1.SETRANGE(PeriodTrans1."Payroll Period", EndPeriods);
                IF PeriodTrans1.FIND('-') THEN BEGIN

                END;
                objPeriod.RESET;
                IF objPeriod.GET("Payroll Period") THEN
                    IF "Group Text" = 'BASIC SALARY' THEN "Transaction Name" := 'BASIC';
                IF "Group Text" = 'GROSS PAY' THEN "Transaction Name" := 'GROSS';
                IF "Group Text" = 'DEDUCTIONS' THEN "Transaction Name" := 'DEDUCTIONS';
                IF "Group Text" = 'NET PAY' THEN "Transaction Name" := 'NET';

            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Payroll Period", '%1..%2', EndPeriods, StartPeriods);
                CLEAR(seq);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(EndPeriods; EndPeriods)
                {
                    Caption = 'Start Period';
                    Editable = true;
                    Enabled = true;
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
                }
                field(StartPeriods; StartPeriods)
                {
                    Caption = 'End Period';
                    TableRelation = "PRL-Payroll Periods"."Date Opened";

                    trigger OnValidate()
                    begin
                        IF StartPeriods <> 0D THEN BEGIN
                            PayPeriods2.RESET;
                            PayPeriods2.SETRANGE("Period Month", DATE2DMY((CALCDATE('<CM-2M+1D>', StartPeriods)), 2));
                            PayPeriods2.SETRANGE("Period Year", DATE2DMY((CALCDATE('<CM-2M+1D>', StartPeriods)), 3));
                            IF PayPeriods2.FIND('-') THEN BEGIN
                                EndPeriods := PayPeriods2."Date Opened";
                            END ELSE BEGIN
                                EndPeriods := 0D;
                            END;
                        END ELSE BEGIN
                            PayPeriods2.RESET;
                            PayPeriods2.SETRANGE(Closed, true);
                            IF PayPeriods2.FIND('-') THEN BEGIN
                                EndPeriods := PayPeriods2."Date Opened";
                            END ELSE BEGIN
                                EndPeriods := 0D;
                            END;
                        END;

                        //currp
                    end;
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

        IF companyinfo.GET() THEN
            companyinfo.CALCFIELDS(companyinfo.Picture);
        objPeriod.RESET;
        objPeriod.SETRANGE(Closed, true);
        IF objPeriod.FIND('-') THEN BEGIN
            StartPeriods := objPeriod."Date Opened";

            IF StartPeriods <> 0D THEN BEGIN
                PayPeriods2.RESET;
                PayPeriods2.SETRANGE("Period Month", DATE2DMY((CALCDATE('<CM-2M+1D>', StartPeriods)), 2));
                PayPeriods2.SETRANGE("Period Year", DATE2DMY((CALCDATE('<CM-2M+1D>', StartPeriods)), 3));
                IF PayPeriods2.FIND('-') THEN BEGIN
                    EndPeriods := PayPeriods2."Date Opened";
                END ELSE BEGIN
                    EndPeriods := 0D;
                END;
            END ELSE BEGIN
                PayPeriods2.RESET;
                PayPeriods2.SETRANGE(Closed, true);
                IF PayPeriods2.FIND('-') THEN BEGIN
                    EndPeriods := PayPeriods2."Date Opened";
                END ELSE BEGIN
                    EndPeriods := 0D;
                END;
            END;
        END;
    end;

    trigger OnPreReport()
    begin
        IF StartPeriods = 0D THEN ERROR('Specify the start period!');
        objPeriod.RESET;
        IF objPeriod.GET(StartPeriods) THEN PeriodName1 := objPeriod."Period Name";

        objPeriod.RESET;
        IF objPeriod.GET(EndPeriods) THEN PeriodName2 := objPeriod."Period Name";
    end;

    var
        PeriodTrans: Record "PRL-Period Transactions";
        PeriodTrans1: Record "PRL-Period Transactions";
        EmployeeName: Text[100];
        objEmp: Record "HRM-Employee C";
        objPeriod: Record "PRL-Payroll Periods";
        SelectedPeriod: Date;
        PeriodName1: Text[30];
        PeriodName2: Text[30];
        PeriodFilter: Text[30];
        companyinfo: Record 79;
        Gross_and_Net_pay_scheduleCaptionLbl: Label 'Gross and Net pay schedule';
        Basic_Pay_CaptionLbl: Label 'Basic Pay:';
        Gross_Pay_CaptionLbl: Label 'Gross Pay:';
        Net_Pay_CaptionLbl: Label 'Net Pay:';
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved by……………………………………………………..                Date……………………………………………';
        Totals_CaptionLbl: Label 'Totals:';
        StartPeriods: Date;
        EndPeriods: Date;
        statAmount: Decimal;
        seq: Integer;
        PayPeriods2: Record "PRL-Payroll Periods";
        PayPeriods1: Record "PRL-Payroll Periods";
}

