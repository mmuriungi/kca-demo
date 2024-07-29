/// <summary>
/// Page EXT-Dates List (ID 74557).
/// </summary>
page 52501 "EXT-Dates List"
{
    Caption = 'Timetable Days';
    PageType = List;
    SourceTable = "EXT-Dates";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date Code"; Rec."Date Code")
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

