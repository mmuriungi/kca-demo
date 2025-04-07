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
                field("Maximum Students (STEM)"; Rec."Maximum Students (STEM)")
                {
                    ApplicationArea = all;
                }
                field("Maximum Students (Non-STEM)"; Rec."Maximum Students (Non-STEM)")
                {

                    ApplicationArea = all;
                }
                field("Enable Labs for Exam"; Rec."Enable Labs for Exam")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
