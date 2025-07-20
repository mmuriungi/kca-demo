page 52179091 "Legal Affairs Activities"
{
    PageType = CardPart;
    SourceTable = "Legal Affairs Cue";
    Caption = 'Legal Affairs Activities';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup("Case Management")
            {
                Caption = 'Case Management';
                
                field("Open Cases"; Rec."Open Cases")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Legal Case List";
                    ToolTip = 'Shows the number of open legal cases.';
                }
                field("Cases In Progress"; Rec."Cases In Progress")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Legal Case List";
                    ToolTip = 'Shows the number of cases in progress.';
                }
                field("High Priority Cases"; Rec."High Priority Cases")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Legal Case List";
                    ToolTip = 'Shows the number of high priority cases.';
                    StyleExpr = 'Unfavorable';
                }
                field("Court Dates This Week"; Rec."Court Dates This Week")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Legal Calendar Entry List";
                    ToolTip = 'Shows court dates scheduled for this week.';
                    StyleExpr = 'Attention';
                }
            }
            
            cuegroup("Compliance & Risk")
            {
                Caption = 'Compliance & Risk';
                
                field("Open Compliance Tasks"; Rec."Open Compliance Tasks")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Legal Compliance Task List";
                    ToolTip = 'Shows the number of open compliance tasks.';
                }
                field("Overdue Compliance Tasks"; Rec."Overdue Compliance Tasks")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Legal Compliance Task List";
                    ToolTip = 'Shows the number of overdue compliance tasks.';
                    StyleExpr = 'Unfavorable';
                }
                field("High Risk Assessments"; Rec."High Risk Assessments")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Legal Risk Assessment List";
                    ToolTip = 'Shows the number of high risk assessments.';
                    StyleExpr = 'Attention';
                }
            }
            
            cuegroup(Contracts)
            {
                Caption = 'Contracts';
                
                field("Active Contracts"; Rec."Active Contracts")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Projects List";
                    ToolTip = 'Shows the number of active contracts.';
                }
                field("Expiring Contracts"; Rec."Expiring Contracts")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Projects List";
                    ToolTip = 'Shows contracts expiring within 90 days.';
                    StyleExpr = 'Attention';
                }
            }
            
            cuegroup(Financial)
            {
                Caption = 'Financial';
                
                field("Pending Legal Invoices"; Rec."Pending Legal Invoices")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Legal Invoice List";
                    ToolTip = 'Shows the number of pending legal invoices.';
                }
                field("Total Legal Costs MTD"; Rec."Total Legal Costs MTD")
                {
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    ToolTip = 'Shows total legal costs for the current month.';
                }
            }
        }
    }
    
    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
    
    trigger OnAfterGetRecord()
    begin
        Rec.CalculateCueFieldValues();
    end;
}