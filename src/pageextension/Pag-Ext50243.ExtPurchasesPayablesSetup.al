pageextension 50243 "ExtPurchases & Payables Setup" extends "Purchases & Payables Setup"
{
    layout
    {

        addafter("Vendor Nos.")
        {
            field("Quotation Request No"; Rec."Quotation Request No")
            {
                ApplicationArea = All;
            }
            field("Stores Requisition No"; Rec."Stores Requisition No")
            {
                ApplicationArea = All;
            }
            field("Requisition Default Vendor"; Rec."Requisition Default Vendor")
            {
                ToolTip = 'Specifies the value of the Requisition Default Vendor field.';
                ApplicationArea = All;
            }
            field("Internal Requisition No."; Rec."Internal Requisition No.")
            {
                ToolTip = 'Specifies the value of the Internal Requisition No. field.';
                ApplicationArea = All;
            }
            field("Procurement Year Code"; Rec."Procurement Year Code")
            {
                ToolTip = 'Specifies the value of the Procurement Year Code field.';
                ApplicationArea = All;
            }
            field("Tender No."; Rec."Tender No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Tender No. field.';
            }
            field("Bid No."; Rec."Bid No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bid No. field.';
            }
            field("Vendor Categories"; Rec."Vendor Categories")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Categories field.';
            }

        }
    }

}