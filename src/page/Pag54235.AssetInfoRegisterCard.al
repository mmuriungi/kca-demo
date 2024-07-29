page 54235 "Asset Info Register Card"
{
    PageType = Card;
    SourceTable = "Asset Information Register";

    layout
    {
        area(content)
        {
            group(Group)
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

