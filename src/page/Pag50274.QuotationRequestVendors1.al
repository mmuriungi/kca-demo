page 50274 "Quotation Request Vendors1"
{
    PageType = Card;
    SourceTable = "PROC-Quotation Request Vendors";

    layout
    {
        area(content)
        {
            repeater(______________)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}