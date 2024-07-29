page 52437 "TT-Days List"
{
    Caption = 'Timetable Days';
    PageType = List;
    SourceTable = "TT-Days";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Day Code"; Rec."Day Code")
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

