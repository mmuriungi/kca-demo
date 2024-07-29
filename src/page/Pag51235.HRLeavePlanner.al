page 51235 "HR Leave Planner"
{
    PageType = ListPart;
    SourceTable = "HR Leave Planner Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff No."; Rec."Staff No.")
                {
                    Editable = false;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    Editable = false;
                }
                field(January; Rec.January)
                {
                }
                field(Feburuary; Rec.Feburuary)
                {
                }
                field(March; Rec.March)
                {
                }
                field(April; Rec.April)
                {
                }
                field(May; Rec.May)
                {
                }
                field(June; Rec.June)
                {
                }
                field(July; Rec.July)
                {
                }
                field(August; Rec.August)
                {
                }
                field(September; Rec.September)
                {
                }
                field(October; Rec.October)
                {
                }
                field(November; Rec.November)
                {
                }
                field(December; Rec.December)
                {
                }
                field(Year; Rec.Year)
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                }
                field("Document Number"; Rec."Document Number")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

