page 54210 "Actual Maintenance List"
{
    CardPageID = "Actual Maintenance Card";
    Editable = false;
    PageType = List;
    SourceTable = "Actual Maintenance ";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Maintenance No."; Rec."Maintenance No.")
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
                field("Plan No."; Rec."Plan No.")
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

