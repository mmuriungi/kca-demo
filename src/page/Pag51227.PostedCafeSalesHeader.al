page 51227 "Posted Cafe Sales Header"
{
    PageType = Card;
    SourceTable = "Sales Shipment Header";
    SourceTableView = WHERE("Cash Sale Order" = FILTER(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Visible = false;
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    Visible = false;
                }
                field(Balance; Rec.Balance)
                {
                    Visible = false;
                }
                field("Sales Location Category"; Rec."Sales Location Category")
                {
                    Visible = false;
                }
                part("Posted Cafe Receipt Lines"; "Posted Cafe Receipt Lines")
                {
                    SubPageLink = "Document No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
    }
}

