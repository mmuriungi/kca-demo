page 54863 "HMS Laboratory Item Subform"
{
    PageType = ListPart;
    SourceTable = "HMS-Laboratory Item Usage";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
                field("Item Name"; Rec."Item Name")
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field("Item Unit Of Measure"; Rec."Item Unit Of Measure")
                {
                    Caption = 'Unit of measure';
                    ApplicationArea = All;
                }
                field("Item Quantity"; Rec."Item Quantity")
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

