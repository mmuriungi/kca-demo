/// <summary>
/// Page PROC-Store Requisition Line UP (ID 52178505).
/// </summary>
page 52178505 "PROC-Store Requisition Line UP"
{
    PageType = ListPart;
    SourceTable = "PROC-Store Requistion Lines";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Issuing Store"; Rec."Issuing Store")
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Quantity Requested"; Rec."Quantity Requested")
                {
                    ApplicationArea = all;
                }
                field("Quantity To Issue"; Rec."Quantity To Issue")
                {
                    ApplicationArea = all;
                }
                field("Quantity Issued"; Rec."Quantity Issued")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Qty in store"; Rec."In store")
                {
                    Caption = 'Qty in store';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = all;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = all;
                }


            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin
        IF QtyStore.GET(Rec."No.") THEN
            QtyStore.CALCFIELDS(QtyStore.Inventory);
        Rec."Qty in store" := QtyStore.Inventory;
    end;

    trigger OnOpenPage()
    begin
        //"Qty in store":=Item.Inventory;
        IF QtyStore.GET(Rec."No.") THEN
            QtyStore.CALCFIELDS(QtyStore.Inventory);
        Rec."Qty in store" := QtyStore.Inventory;
    end;

    var
        QtyStore: Record Item;
}

