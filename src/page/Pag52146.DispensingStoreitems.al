page 52146 "Dispensing Store items"
{
    ApplicationArea = All;
    Caption = 'Dispensing Store items';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;
    SourceTableView = where("Drug Category" = filter(Pharmacitical));


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
                field("Unit Cost"; rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventory field.';
                }
                field("Drug Category"; Rec."Drug Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Drug Category field.';
                }
                field("Reorder Threshold"; Rec."Reorder Threshold")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reorder threshold for the item.';
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
                RunObject = Page "Item Units of Measure";
                RunPageLink = "Item No." = field("No.");
            }
        }
    }
    trigger OnOpenPage()
    var
        Location: Record Location;
    begin
        Location.Reset();
        Location.SetRange("Pharmacy Category", Location."Pharmacy Category"::"Dispensing Store");
        if Location.FindFirst() then begin
            Rec.FilterGroup(2);
            Rec.SetFilter("Location Filter", '%1', Location.Code);
            Rec.FilterGroup(0);
        end;

    end;
}