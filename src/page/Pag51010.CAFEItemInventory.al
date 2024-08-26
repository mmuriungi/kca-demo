page 51010 "CAFE-Item Inventory"
{
    Caption = 'CAFE-Item Inventory';
    PageType = List;
    CardPageId = "Cafe-Item Inventory Card";
    SourceTable = "CAT-Cafeteria Item Inventory";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No field.';
                }
                field(quantityInv; Rec.quantityInv)
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description field.';
                }

                field("Menu Date"; Rec."Menu Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Menu Date field.';
                }
                field("Price Per Item"; Rec."Price Per Item")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price Per Item field.';
                }
                field("Cash Sales"; Rec."Cash Sales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cash Sales field.';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field("Cafeteria Section"; Rec."Cafeteria Section")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cafeteria Section field.';
                }
                field("Credit Sales"; Rec."Credit Sales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Sales field.';
                }
                field("For Sale"; Rec."For Sale")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the For Sale field.';
                }

                field("Quantity Per Unit"; Rec."Quantity Per Unit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity Per Unit field.';
                }
                field("Quantity Sold"; Rec."Quantity Sold")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity Sold field.';
                }
                field("Quantity in Store"; Rec."Quantity in Store")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity in Store field.';
                }
                field("Re-Order Quantity"; Rec."Re-Order Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Re-Order Quantity field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
            }
        }
    }
}
