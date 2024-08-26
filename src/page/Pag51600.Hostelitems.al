page 51600 "Hostel items"
{
    PageType = List;
    SourceTable = "Hostel Items";
    DeleteAllowed = false;
    CardPageId = "Store Items Card";



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

            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("UnitOfMeasure")
            {
                Caption = 'Unit Of Measure';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                image = UnitOfMeasure;
                RunObject = Page "Phamarcy Unit Of Measure";
                RunPageLink = "Item Code" = field("No.");
            }
        }
    }
}
