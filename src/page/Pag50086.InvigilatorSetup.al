page 50086 "Invigilator Setup"
{
    ApplicationArea = All;
    Caption = 'Invigilator Setup';
    PageType = Card;
    SourceTable = "Invigilator Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("First 100"; Rec."First 100")
                {
                    ToolTip = 'Specifies the value of the First 100 field.', Comment = '%';
                }
                field("Next 50"; Rec."Next 50")
                {
                    ToolTip = 'Specifies the value of the Next 50 field.', Comment = '%';
                }
            }
        }
    }
}
