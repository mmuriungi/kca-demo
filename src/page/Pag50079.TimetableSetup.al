page 50079 "Timetable Setup"
{
    ApplicationArea = All;
    Caption = 'Timetable Setup';
    PageType = Card;
    SourceTable = "Timetable Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Maximum Students per class"; Rec."Maximum Students per class")
                {
                    ToolTip = 'Specifies the value of the Maximum Students per class field.', Comment = '%';
                }
                field("Maximum Students per Exam"; Rec."Maximum Students per Exam")
                {
                    ToolTip = 'Specifies the value of the Maximum Students per Exam field.', Comment = '%';
                }
            }
        }
    }
}
