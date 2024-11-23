page 52088 "Timetable Entry"
{
    ApplicationArea = All;
    Caption = 'Timetable Entry';
    PageType = ListPart;
    SourceTable = "Timetable Entry";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ToolTip = 'Specifies the value of the Unit Code field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field("Lecture Hall Code"; Rec."Lecture Hall Code")
                {
                    ToolTip = 'Specifies the value of the Lecture Hall Code field.', Comment = '%';
                }
                field("Lecturer Code"; Rec."Lecturer Code")
                {
                    ToolTip = 'Specifies the value of the Lecturer Code field.', Comment = '%';
                }
                field("Time Slot Code"; Rec."Time Slot Code")
                {
                    ToolTip = 'Specifies the value of the Time Slot Code field.', Comment = '%';
                }
            }
        }
    }
}
