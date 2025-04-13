page 52052 "Question Card"
{
    Caption = 'Question Card';
    PageType = Card;
    SourceTable = "Project Monitor Quiz";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Project No."; Rec."Project No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project No. field.', Comment = '%';
                }
                field("Survey Code"; Rec."Survey Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Code field.', Comment = '%';
                }
                field("Quiz No."; Rec."Quiz No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quiz No. field.', Comment = '%';
                }
                field("Question Category"; Rec."Question Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Question Category field.', Comment = '%';
                }
                field("Question Type"; Rec."Question Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Question Type field.', Comment = '%';
                }
                field("Period From"; Rec."Period From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period From field.', Comment = '%';
                }
                field("Period To"; Rec."Period To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period To field.', Comment = '%';
                }
                field("Requires Drill-Down"; Rec."Requires Drill-Down")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requires Drill-Down field.', Comment = '%';
                }

            }
            group("Question&")
            {
                Caption = 'Question';
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Question field.', Comment = '%';
                    MultiLine = true;
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
                RunPageLink = "Project No." = field("Project No."), "Quiz No." = field("Quiz No."), "Survey Code" = field("Survey Code");
            }
        }
    }
}
