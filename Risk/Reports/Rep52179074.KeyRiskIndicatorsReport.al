report 52179074 "Key Risk Indicators Report"
{
    Caption = 'Key Risk Indicators Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Rep52179074.KeyRiskIndicatorsReport.rdl';

    dataset
    {
        dataitem(KeyRiskIndicators; "Key Risk Indicators")
        {
            RequestFilterFields = "KRI ID", "Related Risk ID", "Alert Status", "Department Code", Active;
            
            column(CompanyName; CompanyProperty.DisplayName())
            {
            }
            column(ReportTitle; 'Key Risk Indicators Report')
            {
            }
            column(PrintDate; Format(Today, 0, 4))
            {
            }
            column(KRI_ID; "KRI ID")
            {
            }
            column(KRI_Name; "KRI Name")
            {
            }
            column(Description; Description)
            {
            }
            column(Related_Risk_ID; "Related Risk ID")
            {
            }
            column(Current_Value; "Current Value")
            {
            }
            column(Target_Value; "Target Value")
            {
            }
            column(Threshold_Green; "Threshold - Green")
            {
            }
            column(Threshold_Yellow; "Threshold - Yellow")
            {
            }
            column(Threshold_Red; "Threshold - Red")
            {
            }
            column(Alert_Status; "Alert Status")
            {
            }
            column(Alert_Status_Text; Format("Alert Status"))
            {
            }
            column(Monitoring_Frequency; "Monitoring Frequency")
            {
            }
            column(Monitoring_Frequency_Text; Format("Monitoring Frequency"))
            {
            }
            column(Last_Measured_Date; Format("Last Measured Date"))
            {
            }
            column(Next_Measurement_Date; Format("Next Measurement Date"))
            {
            }
            column(Data_Source; "Data Source")
            {
            }
            column(Responsible_Person; "Responsible Person")
            {
            }
            column(Department_Code; "Department Code")
            {
            }
            column(Active; Active)
            {
            }
            column(Active_Text; format(Active))
            {
            }
            column(Measurement_Method; "Measurement Method")
            {
            }
            column(Performance_Indicator; GetPerformanceIndicator())
            {
            }
            column(Days_Since_Last_Measurement; GetDaysSinceLastMeasurement())
            {
            }
            column(Days_Until_Next_Measurement; GetDaysUntilNextMeasurement())
            {
            }
            
            dataitem(RiskRegister; "Risk Register")
            {
                DataItemLink = "Risk ID" = field("Related Risk ID");
                DataItemLinkReference = KeyRiskIndicators;
                
                column(Risk_Title; "Value at Risk")
                {
                }
                column(Risk_Category; Category)
                {
                }
                column(Risk_Status; Status)
                {
                }
                column(Risk_Owner; "Risk Owner")
                {
                }
                column(Inherent_Risk_Level; "Inherent Risk Level")
                {
                }
                column(Residual_Risk_Level; "Residual Risk Level")
                {
                }
            }
        }
    }

    requestpage
    {
        SaveValues = true;
        
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    
                    field(IncludeInactive; IncludeInactiveKRIs)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Inactive KRIs';
                        ToolTip = 'Include inactive Key Risk Indicators in the report.';
                    }
                    field(ShowOnlyAlerting; ShowOnlyAlertingKRIs)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Only Alerting KRIs';
                        ToolTip = 'Show only KRIs with Yellow or Red alert status.';
                    }
                    field(GroupByDepartment; GroupByDepartmentCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Group by Department';
                        ToolTip = 'Group KRIs by department code in the report.';
                    }
                }
            }
        }
    }

    var
        IncludeInactiveKRIs: Boolean;
        ShowOnlyAlertingKRIs: Boolean;
        GroupByDepartmentCode: Boolean;

    trigger OnPreReport()
    begin
        if not IncludeInactiveKRIs then
            KeyRiskIndicators.SetRange(Active, true);
            
        if ShowOnlyAlertingKRIs then
            KeyRiskIndicators.SetFilter("Alert Status", '%1|%2', KeyRiskIndicators."Alert Status"::Yellow, KeyRiskIndicators."Alert Status"::Red);
    end;

    local procedure GetPerformanceIndicator(): Text[20]
    begin
        case KeyRiskIndicators."Alert Status" of
            KeyRiskIndicators."Alert Status"::Green:
                exit('On Target');
            KeyRiskIndicators."Alert Status"::Yellow:
                exit('Warning');
            KeyRiskIndicators."Alert Status"::Red:
                exit('Critical');
            else
                exit('Not Set');
        end;
    end;

    local procedure GetDaysSinceLastMeasurement(): Integer
    begin
        if KeyRiskIndicators."Last Measured Date" <> 0D then
            exit(Today - KeyRiskIndicators."Last Measured Date")
        else
            exit(0);
    end;

    local procedure GetDaysUntilNextMeasurement(): Integer
    begin
        if KeyRiskIndicators."Next Measurement Date" <> 0D then
            exit(KeyRiskIndicators."Next Measurement Date" - Today)
        else
            exit(0);
    end;
}
