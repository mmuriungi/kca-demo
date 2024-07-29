page 54303 "FLT-Ticket Authorizing Off."
{
    PageType = ListPart;
    SourceTable = "FLT-Ticket Authorizing Off.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Officer Line no."; Rec."Officer Line no.")
                {
                    ApplicationArea = All;
                }
                field("Ticket No."; Rec."Ticket No.")
                {
                    ApplicationArea = All;
                }
                field("Officer No."; Rec."Officer No.")
                {
                    ApplicationArea = All;
                }
                field("Officer Name"; Rec."Officer Name")
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

