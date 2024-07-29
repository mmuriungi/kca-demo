/// <summary>
/// Page ELECT-Position Categories LKP (ID 60019).
/// </summary>
page 53617 "ELECT-Position Categories LKP"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ELECT-Position Categories";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field("Category Description"; Rec."Category Description")
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

