report 50974 "Casual Bank Schedule"
{
    ApplicationArea = All;
    Caption = 'Casual Bank Schedule';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("PRL-Casual Period Transactions"; "PRL-Casual Period Transactions")
        {

            DataItemTableView = SORTING("Employee Code", "Transaction Code", "Period Month", "Period Year", "Reference No") ORDER(Ascending) WHERE("Transaction Code" = FILTER('NPAY'));
            RequestFilterFields = "Payroll Period";
            column(CompName; CompanyInformation.Name)
            {
            }
            column(picture; CompanyInformation.Picture)
            { }

            column(CompAddress; CompanyInformation.Address + ' ' + CompanyInformation."Address 2")
            {
            }
            column(PhoneNo; CompanyInformation."Phone No." + ' ' + CompanyInformation."Phone No. 2")
            {
            }
            column(PeriodName; PayrollPeriods."Period Name")
            {
            }
            column(TransAmount; "PRL-Casual Period Transactions".Amount)
            {
            }
            column(EmpNames; HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name")
            {
            }
            column(EmpCode; "PRL-Casual Period Transactions"."Employee Code")
            {
            }
            column(AccNo; HRMEmployeeD."Bank Account Number")
            {
            }
            column(Branch; HRMEmployeeD."Branch Bank")
            {
            }
            column(MainBankcode; HRMEmployeeD."Main Bank")
            {
            }
            column(Mainbankname; HRMEmployeeD."Bank Name")
            { }
            column(Branchbank; HRMEmployeeD."Branch Bank")
            { }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);

                if HRMEmployeeD.Get("PRL-Casual Period Transactions"."Employee Code") then
                    if ((HRMEmployeeD."Employee Category" = 'PART-TIME') OR (HRMEmployeeD."Employee Category" = 'CONTRACT') AND (HRMEmployeeD."Employee Category" = 'PERMANENT'))
                         then
                        CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                if "PRL-Casual Period Transactions".GetFilter("PRL-Casual Period Transactions"."Payroll Period") = '' then Error('Specify a period on the filters');
                PayrollPeriods.Reset;
                PayrollPeriods.SetFilter("Date Openned", "PRL-Casual Period Transactions".GetFilter("PRL-Casual Period Transactions"."Payroll Period"));
                if PayrollPeriods.Find('-') then begin
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        CompanyInformation.Reset;
        if CompanyInformation.Find('-') then begin

        end;
    end;

    var
        Bank_ScheduleCaptionLbl: Label 'Bank Schedule';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        KBA_Branch_CodeCaptionLbl: Label 'KBA Branch Code';
        Period_TotalCaptionLbl: Label 'Period Total';
        Full_NamesCaptionLbl: Label 'Full Names';
        Net_PayCaptionLbl: Label 'Net Pay';
        TotalCaptionLbl: Label 'Total';
        PeriodTRans: Record "PRL-Casual Period Transactions";
        NPay: Decimal;
        TNpay: Decimal;
        GrantTotal: Decimal;
        PayrollPeriods: Record "PRL-Casual Payroll Periods";
        CompanyInformation: Record "Company Information";
        PRLBankStructure: Record "PRL-Bank Structure";
        HRMEmployeeD: Record "HRM-Employee C";

}
