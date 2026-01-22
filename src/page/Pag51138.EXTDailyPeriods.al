page 51138 "EXT-Daily Periods"
{
    Caption = 'Timetable Daily Lessons';
    PageType = List;
    SourceTable = "EXT-Daily Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Code"; Rec."Period Code")
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

