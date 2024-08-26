pageextension 50026 "ExtPurchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        modify("Qty. to Invoice")
        {
            Editable = false;
        }
        addafter("Direct Unit Cost")
        {
            field("Unit Price "; Rec."Unit Price (LCY)")
            {
                // ApplicationArea = Suite;
                //  Editable = true;
            }
            field("Depreciation Book Code"; Rec."Depreciation Book Code")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("FA Posting Type"; Rec."FA Posting Type")
            {
                ApplicationArea = All;
                Editable = true;
            }

        }
        addafter(Description)
        {
            field("Descriptions"; Rec."Description 3")
            {
                ApplicationArea = All;
                Editable = true;
                MultiLine = true;
            }
        }
        addafter("Location Code")
        {
            field("Item Unit of Measure"; Rec."Unit of Measure")
            {
                Caption = 'Unit of Mearure';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Reference Unit of Measure field.';
            }
            // field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            // {
            //     ApplicationArea = all;
            //     Editable = true;
            //     Visible = true;
            // }
            // field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            // {
            //     ApplicationArea = all;
            //     Editable = true;
            //     Visible = true;
            // }
            /* field("Quantity Invoiced 2"; Rec."Quantity Invoiced")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Quantity Received 2"; Rec."Quantity Received")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Qty. Rcd."; Rec."Qty. Rcd. Not Invoiced")
            {
                Editable = true;
                ApplicationArea = All;

            }
            field("QTY. Not Received"; Rec."Qty. Rcd. Not Invoiced (Base)")
            {
                Editable = true;
                ApplicationArea = All;
            } */

        }
    }


}