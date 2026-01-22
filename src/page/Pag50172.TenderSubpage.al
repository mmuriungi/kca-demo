page 50172 "Tender Subpage"
{
    PageType = ListPart;
    SourceTable = "Tender Plan Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Stage; Rec.Stage)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Planned start date"; Rec."Planned start date")
                {
                }
                field("Planned end date"; Rec."Planned end date")
                {
                }
                field("Planned duration"; Rec."Planned duration")
                {
                }
                field("Actual start date"; Rec."Actual start date")
                {
                }
                field("Actual Duration"; Rec."Actual Duration")
                {
                }
                field("Actual end date"; Rec."Actual end date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

