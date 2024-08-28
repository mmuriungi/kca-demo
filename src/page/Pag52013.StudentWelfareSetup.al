page 52013 "Student Welfare Setup"
{
    ApplicationArea = All;
    Caption = 'Student Welfare Setup';
    PageType = Card;
    SourceTable = "Student Welfare Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Counseling Nos"; Rec."Counseling Nos")
                {
                    ToolTip = 'Specifies the value of the Counseling Nos field.', Comment = '%';
                }
                field("Leave Nos"; Rec."Leave Nos")
                {
                    ToolTip = 'Specifies the value of the Leave Nos field.', Comment = '%';
                }

                field("Club/Society Nos"; Rec."Club/Society Nos")
                {
                    ToolTip = 'Specifies the value of the Club/Society Nos field.', Comment = '%';
                }
            }
        }
    }
}
