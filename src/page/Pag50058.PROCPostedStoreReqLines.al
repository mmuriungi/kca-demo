page 50058 "PROC-Posted Store Req. Lines"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "PROC-Store Requistion Lines";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(Type; Rec.Type)
                {
                }
                field("Issuing Store"; Rec."Issuing Store")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field("Quantity Requested"; Rec."Quantity Requested")
                {
                }
                field("Quantity To Issue"; Rec."Quantity To Issue")
                {
                }
                field("Quantity Issued"; Rec."Quantity Issued")
                {
                    Editable = false;
                }
                field("Qty in store"; Rec."Qty in store")
                {
                    Editable = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("Line Amount"; Rec."Line Amount")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

