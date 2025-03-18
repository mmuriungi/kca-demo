page 50080 "Lecturer Timetable Constraints"
{
    ApplicationArea = All;
    Caption = 'Lecturer Timetable Constraints';
    PageType = List;
    SourceTable = "Lecturer Timetable Constraints";
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
                field("Lecturer No."; Rec."Lecturer No.")
                {
                    ToolTip = 'Specifies the value of the Lecturer No. field.', Comment = '%';
                }
                field("Constraint Type"; Rec."Constraint Type")
                {
                    ToolTip = 'Specifies the value of the Constraint Type field.', Comment = '%';
                }
                field("Day of The week"; Rec."Day of The week")
                {
                    ToolTip = 'Specifies the value of the Day of The week field.', Comment = '%';
                }
            }
        }
    }
}
