page 51191 "Posted Direct Sales"

{
    CardPageID = "Posted Cafe Sales Header";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Shipment Header";
    SourceTableView = WHERE("Cash Sale Order" = FILTER(true));

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
                }
                field("Period Month"; Rec."Period Month")
                {
                }
                field("Paybill Amount"; Rec."Paybill Amount")
                {
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
                    if Confirm('Print Copy?', true) = false then Error('Cancelled!');
                    SalesShipmentHeader.Reset;
                    SalesShipmentHeader.SetRange(SalesShipmentHeader."No.", Rec."No.");
                    if SalesShipmentHeader.Find('-') then begin
                        // Load and Print Receipt Here
                        REPORT.Run(report::"copy sales receipt", true, TRUE, SalesShipmentHeader);
                    end;
                end;
            }
        }
    }

    var
        SalesShipmentHeader: Record "Sales Shipment Header";
}




