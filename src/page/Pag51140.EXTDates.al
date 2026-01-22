page 51140 "EXT-Dates"
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
                field("Day Order"; Rec."Day Order")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("`")
            {
                Caption = 'Daily Lessons';
                Image = AdjustExchangeRates;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "EXT-Daily Periods";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Date Code" = FIELD("Date Code");
                ApplicationArea = All;
            }
        }
    }
}

