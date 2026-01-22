/// <summary>
/// Page PROC-Posted Store Req. Lines (ID 52178501).
/// </summary>
page 50262 "Posted Store Req. Lines"
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
                    ApplicationArea = All;
                }
                field("Issuing Store"; Rec."Issuing Store")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                }
                field("Quantity Requested"; Rec."Quantity Requested")
                {
                    ApplicationArea = All;
                }
                field("Quantity To Issue"; Rec."Quantity To Issue")
                {
                    ApplicationArea = All;
                }
                field("Quantity Issued"; Rec."Quantity Issued")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty in store"; Rec."Qty in store")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

