page 54213 "Asset Incident List"
{
    CardPageID = "Asset Incident Card";
    Editable = false;
    PageType = List;
    SourceTable = "Asset Incident";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incident No."; Rec."Incident No.")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Incident Type"; Rec."Incident Type")
                {
                    ApplicationArea = All;
                }
                field("Date Reported"; Rec."Date Reported")
                {
                    Editable = false;
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

