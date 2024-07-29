page 54206 "Maintenance Plan List"
{
    CardPageID = "Maintenance Plan Card";
    Editable = false;
    PageType = List;
    SourceTable = "Maintenance Plan";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Plan No."; Rec."Plan No.")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Planned Date"; Rec."Planned Date")
                {
                    ApplicationArea = All;
                }
                field("Dimension 1 Code"; Rec."Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension 2 Code"; Rec."Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

