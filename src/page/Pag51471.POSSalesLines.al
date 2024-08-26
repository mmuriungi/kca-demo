page 51471 "POS Sales Lines"
{
    PageType = ListPart;
    SourceTable = "POS Sales Lines";

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
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(Inventory; Rec.Inventory)
                {
                    Caption = 'Available Quantity';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventory field.';
                }
                field(Price; Rec.Price)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Line Total"; Rec."Line Total")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Total field.';
                }
            }
        }
    }
}