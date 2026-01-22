page 51651 "Cleared Stock"
{
    Caption = 'Cleared Stock';
    PageType = List;
    SourceTable = "POS Items Legacy";

    layout
    {
        area(Content)
        {
            repeater(general)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Serving Category"; Rec."Serving Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Serving Category field.';
                }
                field("Unit of measure"; Rec."Unit of measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of measure field.';
                }
                field("Cleared Stock"; Rec."Cleared Stock")
                {
                    Caption = 'Cleared Stock Inventory';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
            }
        }
    }
}
