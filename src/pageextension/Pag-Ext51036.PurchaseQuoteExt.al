pageextension 51036 "Purchase Quote Ext" extends "Purchase Quote"
{
    layout
    {
        addafter("Vendor Shipment No.")
        {
            field("RFQ No."; Rec."RFQ No.")
            {
                ApplicationArea = All;
                editable = true;

            }
        }
        movebefore("RFQ No."; "Responsibility Center")
        movebefore("Vendor Shipment No."; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")

    }
}
