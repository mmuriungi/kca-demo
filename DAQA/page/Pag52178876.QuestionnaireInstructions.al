page 52091 "Questionnaire Instructions"
{
    ApplicationArea = All;
    Caption = 'Questionnaire Instructions';
    PageType = List;
    SourceTable = "Questionnaire Instructions";
    UsageCategory = Lists;
    CardPageId = "Questionnaire Instruction";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Survey Code"; Rec."Survey Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Code field.', Comment = '%';
                }
                field(Instructions; Rec.Instructions)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Instructions field.', Comment = '%';
                }
            }
        }
    }
}
