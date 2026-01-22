page 52048 "Supp Exam Units"
{
    ApplicationArea = All;
    Caption = 'Supp Exam Units';
    PageType = List;
    SourceTable = "Supp. Exam Units";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field(Programme; Rec.Programme)
                {
                    ToolTip = 'Specifies the value of the Programme field.', Comment = '%';
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ToolTip = 'Specifies the value of the Unit Code field.', Comment = '%';
                }
                field("Lecturer Code"; Rec."Lecturer Code")
                {
                    ToolTip = 'Specifies the value of the Lecturer Code field.', Comment = '%';
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ToolTip = 'Specifies the value of the Stage Code field.', Comment = '%';
                }
                field("Student Allocation"; Rec."Student Allocation")
                {
                    ToolTip = 'Specifies the value of the Student Allocation field.', Comment = '%';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.', Comment = '%';
                }
            }
        }
    }
}
