page 54203 "Asset Transfer List Effected"
{
    CardPageID = "Asset Transfer Card";
    Editable = false;
    PageType = List;
    SourceTable = "Asset Transfer";
    SourceTableView = WHERE(Transferred = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = All;
                }
                field("Asset to Transfer"; Rec."Asset to Transfer")
                {
                    ApplicationArea = All;
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = All;
                }
                field("From Responsible Employee"; Rec."From Responsible Employee")
                {
                    ApplicationArea = All;
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = All;
                }
                field("To Responsible Employee"; Rec."To Responsible Employee")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Transferred; Rec.Transferred)
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

