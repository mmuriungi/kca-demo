page 54465 "Lecturer Experience Card"
{
    Caption = 'Lecturer Experience Card';
    PageType = Card;
    SourceTable = "Lecturer Experience Form";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PF No."; Rec."PF No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PF No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Departmement; Rec.Departmement)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Departmement field.', Comment = '%';
                }
                field(School; Rec.School)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
            }
            part("Lecturer Units"; "Lecturer Units")
            {
                ApplicationArea = All;
                SubPageLink = Lecturer = field("PF No."), Semester = field(Semester);
            }
            part("Lecturer Exp Results"; "Lec Experience Results")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No."), "PF No." = field("PF No."), Semester = field(Semester);
            }
        }
    }
}
