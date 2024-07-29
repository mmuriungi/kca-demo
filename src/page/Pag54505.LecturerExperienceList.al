page 54505 "Lecturer Experience List"
{
    Caption = 'Lecturer Experience List';
    CardPageId = "Lecturer Experience Card";
    PageType = List;
    SourceTable = "Lecturer Experience Form";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("PF No."; Rec."PF No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PF No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Departmement; Rec.Departmement)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Departmement field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field(School; Rec.School)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School field.', Comment = '%';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
            }
        }
    }
}
