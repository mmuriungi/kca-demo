page 50171 "Work Plan Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Tender Plan Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("Workplan Code"; Rec."Workplan Code")
                {
                }
                field("Workplan Description"; Rec."Workplan Description")
                {
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                }
                field("Procurement Method Name"; Rec."Procurement Method Name")
                {
                }
            }
            part("Tender Subpage"; "Tender Subpage")
            {
                SubPageLink = "Tender No." = FIELD("No.");
            }
        }
    }

    actions
    {
    }
}

