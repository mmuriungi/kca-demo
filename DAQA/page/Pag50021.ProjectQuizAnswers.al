page 52089 "Project Quiz Answers"
{
    ApplicationArea = All;
    Caption = 'Project Quiz Answers';
    PageType = List;
    SourceTable = "Project Quiz Answers";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Semester Code"; Rec."Semester Code")
                {
                    ToolTip = 'Specifies the value of the Semester Code field.', Comment = '%';
                }
                field("Quiz No."; Rec."Quiz No.")
                {
                    ToolTip = 'Specifies the value of the Quiz No. field.', Comment = '%';
                }
                field(Question; Rec.Question)
                {
                    ToolTip = 'Specifies the value of the Question field.', Comment = '%';
                }
                field("Text Answer"; Rec."Text Answer")
                {
                    ToolTip = 'Specifies the value of the Text Answer field.', Comment = '%';
                }
                field("Boolean Answer"; Rec."Boolean Answer")
                {
                    ToolTip = 'Specifies the value of the Boolean Answer field.', Comment = '%';
                }
                field("Answered By"; Rec."Answered By")
                {
                    ToolTip = 'Specifies the value of the Answered By field.', Comment = '%';
                }
                field("Answered Date"; Rec."Answered Date")
                {
                    ToolTip = 'Specifies the value of the Answered Date field.', Comment = '%';
                }
                field("Number Answer"; Rec."Number Answer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number Answer field.', Comment = '%';
                }
                field("Answered By Email"; Rec."Answered By Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Answered By Email field.', Comment = '%';
                }
                field("Survey Code"; Rec."Survey Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Code field.', Comment = '%';
                }
                field("Period To"; Rec."Period To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period To field.', Comment = '%';
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
                field("Survey Name"; Rec."Survey Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Name field.', Comment = '%';
                }
            }
        }
    }
}
