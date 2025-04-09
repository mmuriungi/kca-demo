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
            }
        }
    }
}
