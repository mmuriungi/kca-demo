page 52092 "Questionnaire Instruction"
{
    Caption = 'Questionnaire Instruction';
    PageType = Card;
    SourceTable = "Questionnaire Instructions";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Survey Code"; Rec."Survey Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Code field.', Comment = '%';
                    Editable = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                    Editable = false;
                }
                field(Instructions; Rec.Instructions)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Instructions field.', Comment = '%';
                    MultiLine = true;
                }
            }
        }
    }
}
