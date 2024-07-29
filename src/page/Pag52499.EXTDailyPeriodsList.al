/// <summary>
/// Page EXT-Daily Periods List (ID 74559).
/// </summary>
page 52499 "EXT-Daily Periods List"
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

