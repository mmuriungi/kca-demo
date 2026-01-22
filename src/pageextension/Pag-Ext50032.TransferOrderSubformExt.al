pageextension 50032 "Transfer Order Subform Ext" extends "Transfer Order Subform"
{


    layout
    {
        addafter("Unit Of Measure Code")
        {

            field("Transfer-from Code"; Rec."Transfer-from Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the code of the location that items are transferred from.';
            }
            field("Quantity In Store"; Rec."Quantity In Store")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity In Store field.';
            }

        }
    }
}
