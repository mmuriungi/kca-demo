report 50973 "pr Casuals Bank Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/pr Casuals Bank Schedule.rdl';

    dataset
    {
        dataitem(DataItem4233; "PRL-Bank Structure")
        {
            DataItemTableView = SORTING("Bank Code", "Branch Code");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Bank Code", "Branch Code", "Period Filter";

            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(prBank_Structure__Bank_Name_; "Bank Name")
            {
            }
            column(prBank_Structure__Branch_Name_; "Branch Name")
            {
            }
            column(prBank_Structure__prBank_Structure___KBA_Branch_Code_; "KBA Branch Code")
            {
            }
            column(GrantTotal; GrantTotal)
            {
            }
            column(Bank_ScheduleCaption; Bank_ScheduleCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(prBank_Structure__Bank_Name_Caption; FIELDCAPTION("Bank Name"))
            {
            }
            column(prBank_Structure__Branch_Name_Caption; FIELDCAPTION("Branch Name"))
            {
            }
            column(KBA_Branch_CodeCaption; KBA_Branch_CodeCaptionLbl)
            {
            }
            column(Period_TotalCaption; Period_TotalCaptionLbl)
            {
            }
            column(prBank_Structure_Bank_Code; "Bank Code")
            {
            }
            column(prBank_Structure_Branch_Code; "Branch Code")
            {
            }
            column(periodLabel; GETFILTER("Period Filter"))
            {
            }
            column(period; period)
            {
            }
            column(perName; payper."Period Name" + ' CASUAL BANK SCHEDULE')
            {
            }
            column(Install; 'INTALMENT - ' + FORMAT(payper."Current Instalment"))
            {
            }
            dataitem(DataItem8631; "HRM-Employee C")
            {
                DataItemLink = "Branch Bank" = FIELD("Branch Code"),
               "Main Bank" = FIELD("Bank Code");
                DataItemTableView = WHERE(Status = FILTER(Active),
                                         "Employee Category" = FILTER('CASUALS' | 'CASUAL'));
                column(HR_Employee__No__; "No.")
                {
                }
                column(HR_Employee___First_Name_______HR_Employee___Middle_Name_______HR_Employee___Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
                {
                }
                column(HR_Employee__Bank_Account_Number_; "Bank Account Number")
                {
                }
                column(NPay; NPay)
                {
                }
                column(TNpay; TNpay)
                {
                }
                column(HR_Employee__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Full_NamesCaption; Full_NamesCaptionLbl)
                {
                }
                column(HR_Employee__Bank_Account_Number_Caption; FIELDCAPTION("Bank Account Number"))
                {
                }
                column(Net_PayCaption; Net_PayCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(HR_Employee_Branch_Bank; "Branch Bank")
                {
                }
                column(HR_Employee_Main_Bank; "Main Bank")
                {
                }
                column(KBA_Code; "Main Bank" + '' + "Branch Bank")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(NPay);
                    PeriodTRans.RESET;
                    PeriodTRans.SETRANGE(PeriodTRans."Employee Code", "No.");
                    PeriodTRans.SetFilter(PeriodTRans."Transaction Code", 'NPAY');
                    PeriodTRans.SETFILTER(PeriodTRans."Payroll Period", '=%1', period);
                    PeriodTRans.SETFILTER(PeriodTRans."Current Instalment", '=%1', Install);
                    IF PeriodTRans.FIND('-') THEN
                        NPay := PeriodTRans.Amount;

                    TNpay := TNpay + NPay;
                    GrantTotal := GrantTotal + NPay;
                    IF NPay = 0 THEN CurrReport.SKIP;
                end;
            }

            trigger OnPreDataItem()
            begin
                IF period = 0D THEN ERROR('Specify the period.');

                payper.RESET;
                payper.SETRANGE(payper."Date Openned", period);
                payper.SETRANGE(payper."Current Instalment", Install);
                IF payper.FIND('-') THEN BEGIN
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(PerFilter; period)
                {
                    Caption = 'Pay Period';
                    TableRelation = "PRL-Casual Payroll Periods"."Date Openned";
                }
                field(Instalment; Install)
                {
                    Caption = 'Instalment';
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
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        IF objPeriod.FIND('-') THEN;
        period := objPeriod."Date Openned";
        Install := objPeriod."Current Instalment";
    end;

    var
        PeriodTRans: Record "PRL-Casual Period Transactions";
        NPay: Decimal;
        TNpay: Decimal;
        GrantTotal: Decimal;
        Bank_ScheduleCaptionLbl: Label 'Bank Schedule';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        KBA_Branch_CodeCaptionLbl: Label 'KBA Branch Code';
        Period_TotalCaptionLbl: Label 'Period Total';
        Full_NamesCaptionLbl: Label 'Full Names';
        Net_PayCaptionLbl: Label 'Net Pay';
        TotalCaptionLbl: Label 'Total';
        period: Date;
        payper: Record "PRL-Casual Payroll Periods";
        objPeriod: Record "PRL-Casual Payroll Periods";
        Install: Integer;
}

