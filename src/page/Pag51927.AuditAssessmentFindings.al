page 51927 "Audit Assessment Findings"
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
                    Editable = false;
                    Visible = false;
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
                field("Actions Taken"; Rec."Actions Taken")
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

    var
        hideCheckBox: Boolean;
        AuditAsssessmentHeader: Record "Audit Asssessment Header";
        AuditAssessmentFindings: Record "Audit Assessment Findings";
        statusz: Option;
}

