page 50063 "HR EffectedAsset Transfer List"
{
    CardPageID = "HR Effected Asset Transfer";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Asset Transfer Header";
    SourceTableView = WHERE(Transfered = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Current Holder"; Rec."Current Holder")
                {
                }
                field("Asset to Transfer"; Rec."Asset to Transfer")
                {
                }
                field("New Holder"; Rec."New Holder")
                {
                }
                field(Transfered; Rec.Transfered)
                {
                }
            }
        }
    }

    actions
    {
    }
}

