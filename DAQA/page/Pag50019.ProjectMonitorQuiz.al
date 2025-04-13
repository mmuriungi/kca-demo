page 52056 "Project Monitor Quiz"
{
    ApplicationArea = All;
    Caption = 'Project Monitor Quiz';
    PageType = List;
    SourceTable = "Project Monitor Quiz";
    UsageCategory = Lists;
    CardPageId = "Question Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Project No."; Rec."Project No.")
                {
                    ToolTip = 'Specifies the value of the Project No. field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Quiz No."; Rec."Quiz No.")
                {
                    ToolTip = 'Specifies the value of the Quiz No. field.', Comment = '%';
                    ApplicationArea = All;
                }
                field(Question; Rec.Question)
                {
                    ToolTip = 'Specifies the value of the Question field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Period From"; Rec."Period From")
                {
                    ToolTip = 'Specifies the value of the Period From field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Period To"; Rec."Period To")
                {
                    ToolTip = 'Specifies the value of the Period To field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Question Type"; Rec."Question Type")
                {
                    ToolTip = 'Specifies the value of the Question Type field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Question Category"; Rec."Question Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Question Category field.', Comment = '%';
                }
                field("Requires Drill-Down"; Rec."Requires Drill-Down")
                {
                    ToolTip = 'Specifies the value of the Requires Drill-Down field.', Comment = '%';
                    ApplicationArea = All;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ToolTip = 'Specifies the value of the Mandatory field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Activates Question"; Rec."Activates Question")
                {
                    ToolTip = 'Specifies the value of the Activates Question field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Activates Based On Answer"; Rec."Activates Based On Answer")
                {
                    ToolTip = 'Specifies the value of the Activates Based On Answer field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Activates Based On Value"; Rec."Activates Based On Value")
                {
                    ToolTip = 'Specifies the value of the Activates Based On Value field.', Comment = '%';
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ShowDrillDown)
            {
                ApplicationArea = All;
                Caption = 'Drill Down Answers';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Drill Down Answers";
                RunPageLink = "Project No." = field("Project No."), "Quiz No." = field("Quiz No.");
            }
        }
    }
}
