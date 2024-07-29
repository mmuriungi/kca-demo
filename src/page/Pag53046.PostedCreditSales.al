page 53046 "Posted Credit Sales"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Shipment Header";
    SourceTableView = WHERE("Cash Sale Order" = FILTER(true),
                            "Credit Sale" = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Order No."; Rec."Order No.")
                {
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    Editable = true;
                }
                field("Order Date"; Rec."Order Date")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Posting Description"; Rec."Posting Description")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(PrintCopy)
            {
                Caption = 'Print Copy';
                Image = Copy;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // Print Receipt
                    IF CONFIRM('Print Copy?', TRUE) = FALSE THEN ERROR('Cancelled!');
                    SalesShipmentHeader.RESET;
                    SalesShipmentHeader.SETRANGE(SalesShipmentHeader."No.", Rec."No.");
                    IF SalesShipmentHeader.FIND('-') THEN BEGIN
                        // Load and Print Receipt Here
                        REPORT.RUN(65011, FALSE, TRUE, SalesShipmentHeader);
                    END;
                end;
            }
        }
    }

    var
        SalesShipmentHeader: Record "Sales Shipment Header";
}

