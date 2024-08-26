page 51077 "TT-Days"
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
                RunObject = Page "TT-Daily Lessons";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Day Code" = FIELD("Day Code");
                ApplicationArea = All;
            }
        }
    }
}

