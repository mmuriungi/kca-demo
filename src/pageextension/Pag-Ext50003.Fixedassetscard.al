pageextension 50003 "Fixed assets card" extends "Fixed Asset Card"
{

    layout
    {
        addafter("Serial No.")
        {
            field("Asset Condition"; Rec."Asset Condition") { ApplicationArea = all; }

            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
            }
            field("Tag No"; Rec."Tag No")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Tag No field.';
            }
            field("Payment Voucher No."; Rec."Payment Voucher No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payment Voucher No. field.';
            }
            field("Source of Funds"; Rec."Source of Funds")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Source of Funds field.';
            }
            field("Make or Model"; Rec."Make or Model")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Make or Model field.';
            }
            field("Date of Delivery"; Rec."Date of Delivery")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Date of Delivery field.';
            }
            field("Date Placed in Use"; Rec."Date Placed in Use")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Date Placed in Use field.';
            }
            field("Last Physical Check"; Rec."Last Physical Check")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Last Physical Check field.';
            }
            field("Replacement Date"; Rec."Replacement Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Replacement Date field.';
            }
            field("Depreciation Rate"; Rec."Depreciation Rate")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Depreciation Rate field.';
            }
            field("Disposal Date"; Rec."Disposal Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Disposal Date field.';
            }
            field("Disposal Amount"; Rec."Disposal Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Disposal Amount field.';
            }
            field(Notes; Rec.Notes)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Notes field.';
                MultiLine = true;
            }
            field(Vendor; Rec.Vendor)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor field.';
            }
        }
        // Add changes to page layout here
        addlast(content)
        {
            field("Registration No."; rec."Registration No.")
            {
                ApplicationArea = all;
            }


        }
    }

    actions
    {
        // Add changes to page actions here
        addlast(processing)
        {
            action("Import Assets")
            {
                ApplicationArea = All;
                Caption = 'Import Assets';
                Image = Import;
                //RunObject = xmlport "Import Assets";
                ToolTip = 'Import Assets';
            }
            action("Import FA DEP")
            {
                ApplicationArea = All;
                Caption = 'Import FA DEP';
                Image = Import;
                // RunObject = xmlport "FA Depreciation book";
                ToolTip = 'Import FA Depreciation Book Code';
            }

        }
        modify("Main Asset")
        {
            Enabled = true;


        }
        modify("M&ain Asset Components")
        {
            Enabled = true;
            ApplicationArea = All;


        }
    }

    var
        myInt: Integer;
}