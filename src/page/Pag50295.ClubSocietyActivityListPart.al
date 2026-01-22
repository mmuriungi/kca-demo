page 50295 "Club/Society Activity ListPart"
{
    PageType = ListPart;
    SourceTable = "Club/Society Activity";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Activity Date"; Rec."Activity Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
