pageextension 50247 "ExtVendor List" extends "Vendor List"
{
    layout
    {

    }
    actions
    {
        addafter("Item Refe&rences")
        {
            action("Import Vendor")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import Vendors';
                ToolTip = 'Import Vendors.';
                Image = Import;
                // RunObject = xmlport "Import Vendors";
            }
        }

        addafter(PayVendor)
        {
            action("Vendr")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor Classification';
                Image = SuggestVendorPayments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "PROC-Vendor Classifications";
                RunPageLink = Vendor = field("No.");

            }
        }
    }
}