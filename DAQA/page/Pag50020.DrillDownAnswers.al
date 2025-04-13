page 52057 "Drill Down Answers"
{
    ApplicationArea = All;
    Caption = 'Drill Down Answers';
    PageType = List;
    SourceTable = "Drill Down Answers";
    UsageCategory = Lists;
    
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
                field(Choice; Rec.Choice)
                {
                    ToolTip = 'Specifies the value of the Choice field.', Comment = '%';
                    ApplicationArea = All;
                }
            }
        }
    }
}
