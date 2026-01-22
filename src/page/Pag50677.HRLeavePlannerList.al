page 50677 "HR Leave Planner List"
{
    CardPageID = "HR Leave Planner Card";
    Editable = false;
    PageType = List;
    SourceTable = "HR Leave Planner Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field(HOD; Rec.HOD)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

