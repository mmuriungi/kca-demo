page 51640 "Hostel sub-store items"
{
    Caption = 'Hostel sub-store items';
    PageType = List;
    SourceTable = "Hostel Sub-Store";
    DeleteAllowed = false;
    SourceTableView = where("Item Category" = filter(<> assets));



    layout
    {
        area(Content)
        {
            repeater(General)
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
                field("Unit of measure"; Rec."Unit of measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of measure field.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventory field.';
                }
                field("item Category"; Rec."Item Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Drug Category field.';
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {

        }
    }
}