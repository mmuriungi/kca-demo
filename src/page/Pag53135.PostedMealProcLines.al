page 53135 "Posted Meal-Proc. Lines"
{
    AutoSplitKey = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Meal-Proc. Batch Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // FreezeColumn = Control1000000041;
                field("Item Code"; Rec."Item Code")
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                }
                field("Production  Area"; Rec."Production  Area")
                {
                }
                field("BOM Count"; Rec."BOM Count")
                {
                    Editable = false;
                }
                field(Approve; Rec.Approve)
                {
                    Editable = false;
                }
                field(Reject; Rec.Reject)
                {
                    Editable = false;
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create Transfer Order")
            {
                Image = TransferOrder;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //TESTFIELD(Status,Status::Posted);
                    //"Transfer Order Created":="Transfer Order Created"::"1";
                    //CreateTransferOrder;
                end;
            }
        }
    }

    var
        ProductionCustProdSource: Record "Meal-Proc. BOM Prod. Source";
}

