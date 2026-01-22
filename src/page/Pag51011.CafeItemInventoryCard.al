page 51011 "Cafe-Item Inventory Card"
{
    Caption = 'Cafe-Item Inventory Card';
    PageType = Card;
    SourceTable = "CAT-Cafeteria Item Inventory";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No field.';
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

                field("Advance Sales"; Rec."Advance Sales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Advance Sales field.';
                }
                field("Cafeteria Section"; Rec."Cafeteria Section")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cafeteria Section field.';
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
                field("Credit Sales"; Rec."Credit Sales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Sales field.';
                }
                field("Delay Cost on Return"; Rec."Delay Cost on Return")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Delay Cost on Return field.';
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
