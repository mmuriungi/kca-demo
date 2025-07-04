page 51223 "Cafeteria Menu Prices"
{
    ApplicationArea = All;
    Caption = 'Cafeteria Menu Prices';
    PageType = List;
    SourceTable = item;
    SourceTableView = order(ascending) where("Base Unit of Measure" = filter('portion'));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*  field("Meal Code"; Rec."Meal Code")
                 {
                     ToolTip = 'Specifies the value of the Meal Code field.';
                     ApplicationArea = All;
                 }
                 field("Meal Description"; Rec."Meal Description")
                 {
                     ToolTip = 'Specifies the value of the Meal Description field.';
                     ApplicationArea = All;
                 }
                 field("Meal Category"; Rec."Meal Category")
                 {
                     ToolTip = 'Specifies the value of the Meal Category field.';
                     ApplicationArea = All;
                 }
                 field(Active; Rec.Active)
                 {
                     ToolTip = 'Specifies the value of the Active field.';
                     ApplicationArea = All;
                 }
                 field("Quantity on Hand"; Rec."Quantity on Hand")
                 {
                     ToolTip = 'Specifies the value of the Quantity on Hand field.';
                     ApplicationArea = All;
                 }
                 field("Staff Price"; Rec."Staff Price")
                 {
                     ToolTip = 'Specifies the value of the Staff Price field.';
                     ApplicationArea = All;
                 }
                 field("Students Price"; Rec."Students Price")
                 {
                     ToolTip = 'Specifies the value of the Students Price field.';
                     ApplicationArea = All;
                 } */
                field("No."; Rec."No.")
                {
                    Caption = 'Meal Code';
                    ToolTip = 'Specifies the number of the item.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Meal Description';
                    ToolTip = 'Specifies a description of the item.';
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    Caption = 'Quantity';
                    ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Caption = 'Student Price';
                    ToolTip = 'Specifies the price for one unit of the item, in $.';
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ToolTip = 'Specifies the unit in which the item is held in inventory.';
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ToolTip = 'Specifies the inventory posting group. Links business transactions made for the item with an inventory account in the general ledger, to group amounts for that item type.';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        IF NOT UserSetup.FINDFIRST THEN ERROR('Access denied!');
        IF UserSetup."Can Update Price List" = FALSE THEN ERROR('Access denied!');
    end;

    var
        UserSetup: Record "ACA-Hostel Permissions X";
}
