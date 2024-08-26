page 51250 "CAT-Kitchen Inventory List"
{
    Editable = false;
    PageType = List;
    SourceTable = Item;
    // SourceTableView = WHERE("Location Filter"=CONST(KITCHEN));

    layout
    {
        area(content)
        {
            repeater(gs1)
            {
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                }
                field("Price Unit Conversion"; Rec."Price Unit Conversion")
                {
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                }
                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                }
                field("Cost is Adjusted"; Rec."Cost is Adjusted")
                {
                }
                field("Allow Online Adjustment"; Rec."Allow Online Adjustment")
                {
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                }
                field("Unit List Price"; Rec."Unit List Price")
                {
                }
                field("Budget Quantity"; Rec."Budget Quantity")
                {
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                }
                field(Inventory; Rec.Inventory)
                {
                }
            }
        }
    }

    actions
    {
    }
}

