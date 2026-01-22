page 52179046 "Audit Performance Metrics List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Audit Performance Metrics";
    Caption = 'Audit Performance Metrics';
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Metric ID"; Rec."Metric ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the metric ID.';
                }
                field("Period Type"; Rec."Period Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the period type.';
                }
                field("Period Start Date"; Rec."Period Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the period start date.';
                }
                field("Period End Date"; Rec."Period End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the period end date.';
                }
                field("Total Audits Planned"; Rec."Total Audits Planned")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies total audits planned.';
                }
                field("Total Audits Completed"; Rec."Total Audits Completed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies total audits completed.';
                }
                field("Total Findings"; Rec."Total Findings")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies total findings.';
                }
                field("Critical Findings"; Rec."Critical Findings")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies critical findings.';
                }
                field("High Risk Findings"; Rec."High Risk Findings")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies high risk findings.';
                }
                field("Compliance Score %"; Rec."Compliance Score %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies compliance score percentage.';
                }
                field("Audit Coverage %"; Rec."Audit Coverage %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies audit coverage percentage.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Generate Report")
            {
                ApplicationArea = All;
                Caption = 'Generate Performance Report';
                Image = Report;
                ToolTip = 'Generate performance metrics report.';
                
                trigger OnAction()
                begin
                    Message('Performance metrics report will be implemented.');
                end;
            }
            action("Refresh Metrics")
            {
                ApplicationArea = All;
                Caption = 'Refresh Metrics';
                Image = Refresh;
                ToolTip = 'Refresh performance metrics.';
                
                trigger OnAction()
                begin
                    Message('Performance metrics refreshed.');
                    CurrPage.Update();
                end;
            }
        }
    }
}