pageextension 56615 "Detailled Customer Ledger" extends "Detailed Cust. Ledg. Entries"
{
    layout
    {
        addafter("Document No.")
        {

            field(Description; Rec.Description)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description field.';
            }
        }
        addafter(Amount)
        {
            field("Applied Cust. Ledger Entry No."; Rec."Applied Cust. Ledger Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Applied Cust. Ledger Entry No. field.';
            }
        }
    }

    actions
    {
        addafter("Unapply Entries")
        {
            action("Ledger Entries")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Customer Ledger Entries";
                RunPageLink = "Document No." = field("Document No."), "Customer No." = field("Customer No.");
            }
        }
    }
}