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
                
                field("Club/Society Nos"; Rec."Club/Society Nos")
                {
                    ToolTip = 'Specifies the value of the Club/Society Nos field.', Comment = '%';
                }
            }
        }
    }
}
