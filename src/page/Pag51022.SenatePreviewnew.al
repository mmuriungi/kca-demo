page 51022 "Senate Preview(new)"
{
    Caption = 'Senate Preview(new)';
    PageType = List;
    SourceTable = "Senate Report New";
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.';
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field("Average"; Rec."Average")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Average field.';
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grade field.';
                }

                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }

            }
        }
    }
}
