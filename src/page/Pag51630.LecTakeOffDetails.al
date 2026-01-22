page 51630 "Lec Take Off Details"
{
    Caption = 'Lec Take Off Details';
    PageType = ListPart;
    SourceTable = "Lec TakeOff Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme field.', Comment = '%';
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Code field.', Comment = '%';
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Name field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(Lecturer; Rec.Lecturer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecturer field.', Comment = '%';
                }
                field("Lecturer Hall"; Rec."Lecturer Hall")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecturer Hall field.', Comment = '%';
                }
                field(Attended; Rec.Attended)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Attended field.', Comment = '%';
                }
            }
        }
    }
}
