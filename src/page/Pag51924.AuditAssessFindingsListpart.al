page 51924 "Audit Assess Findings Listpart"
{
    PageType = ListPart;
    SourceTable = "Audit Assessment Findings";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Risk Assessment Code"; Rec."Risk Assessment Code")
                {
                    ApplicationArea = All;
                }
                field(No; Rec.No)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Findings; Rec.Findings)
                {
                    ApplicationArea = All;
                }
                field(Risks; Rec.Risks)
                {
                    ApplicationArea = All;
                }
                field(Recommendations; Rec.Recommendations)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

