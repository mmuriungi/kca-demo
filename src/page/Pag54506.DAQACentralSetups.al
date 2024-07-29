page 54506 "DAQA Central Setups"
{
    Caption = 'DAQA Central Setups';
    PageType = Card;
    SourceTable = "DAQA Setups";

    layout
    {

        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Orientation Nos"; Rec."Orientation Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Orientation Nos field.', Comment = '%';
                }
                field("Lec TakeOff Nos"; Rec."Lec TakeOff Nos")
                {
                    ApplicationArea = All;
                }
                field("Exam Admin Nos"; Rec."Exam Admin Nos")
                {
                    ApplicationArea = All;
                }
                field("Lecturer Experience Nos"; Rec."Lecturer Experience Nos")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
