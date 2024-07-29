page 54220 "Gatepass List"
{
    CardPageID = "Gate Pass Card";
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Gate Pass";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Gate Pass No."; Rec."Gate Pass No.")
                {
                    ApplicationArea = All;
                }
                field("Date Out"; Rec."Date Out")
                {
                    ApplicationArea = All;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = All;
                }
                field("Asset Transfer No"; Rec."Asset Transfer No")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    ApplicationArea = All;
                }
                field("Asset From Location"; Rec."Asset From Location")
                {
                    ApplicationArea = All;
                }
                field("Asset To Location"; Rec."Asset To Location")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Outlook; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

