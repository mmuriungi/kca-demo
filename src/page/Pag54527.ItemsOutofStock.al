page 54527 "Items Out of Stock"
{
    PageType = List;
    SourceTable = "POS Items";
    CardPageId = "POS Item";
    Editable = false;
    SourceTableView = where(Inventory = filter(<= 0));
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
                field(Quantity; Rec.Inventory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("ItemUnitofmeasure")
            {
                ApplicationArea = All;
                Caption = 'Unit of Measure';
                Image = UnitOfMeasure;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Pos Unit of measure";
                RunPageLink = "Item Code" = field("No.");
            }
        }
    }

}