page 51074 "TT-Daily Lessons"
{
    Caption = 'Timetable Daily Lessons';
    PageType = List;
    SourceTable = "TT-Daily Lessons";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lesson Code"; Rec."Lesson Code")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

