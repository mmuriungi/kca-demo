page 54234 "Asset Info Register List"
{
    CardPageID = "Asset Info Register Card";
    Editable = false;
    PageType = List;
    SourceTable = "Asset Information Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Reg Code"; Rec."Reg Code")
                {
                    ApplicationArea = All;
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    ApplicationArea = All;
                }
                field("Cost of Asset"; Rec."Cost of Asset")
                {
                    ApplicationArea = All;
                }
                field("Date Acquired / Installed."; Rec."Date Acquired / Installed.")
                {
                    ApplicationArea = All;
                }
                field("Asset Category"; Rec."Asset Category")
                {
                    ApplicationArea = All;
                }
                field("Repairs and Maintenance Cost"; Rec."Repairs and Maintenance Cost")
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

