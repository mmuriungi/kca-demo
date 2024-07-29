page 55407 "Audit Assessment Card"
{
    PageType = Card;
    SourceTable = "Audit Asssessment Header";

    layout
    {
        area(content)
        {
            group(Group)
            {
                /* field(No; No)
                {
                } */
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                /* field(Department; Department)
                {
                } */
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field(Process; Rec.Process)
                {
                    ApplicationArea = All;
                }
                field(Scope; Rec.Scope)
                {
                    ApplicationArea = All;
                }
                field(Objective; Rec.Objective)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Ext. Document No"; Rec."Ext. Document No")
                {
                    ApplicationArea = All;
                }
                field("Current Location"; Rec."Current Location")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Modified on"; Rec."Modified on")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Assessment Start Date"; Rec."Assessment Start Date")
                {
                    ApplicationArea = All;
                }
                field("Assessment End Date"; Rec."Assessment End Date")
                {
                    ApplicationArea = All;
                }
                /* field(Asessor; Asessor)
                {
                } */
                field("Assessor Name"; Rec."Assessor Name")
                {
                    ApplicationArea = All;
                }
                field("Re-Assign Assessor"; Rec."Re-Assign Assessor")
                {
                    ApplicationArea = All;
                }
                field("Re-Assign Assessor Name"; Rec."Re-Assign Assessor Name")
                {
                    ApplicationArea = All;
                }
            }
            part("Risk Observations/Findings"; "Audit Assess Findings Listpart")
            {
                SubPageLink = "Risk Assessment Code" = FIELD(No);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Review)
            {
                Image = SendTo;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Send for Review', TRUE) = FALSE THEN ERROR('Cancelled');

                    IF (Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::"Re-Opened") THEN BEGIN


                        //check if assessment lines are empty
                        AuditAssessmentFindings.RESET;
                        AuditAssessmentFindings.SETFILTER(AuditAssessmentFindings."Risk Assessment Code", Rec.No);
                        IF NOT AuditAssessmentFindings.FINDFIRST THEN ERROR('Risk Assessment Lines cannot be empty');
                        Rec.Status := Rec.Status::Review;
                        Rec."Current Location" := Rec."Current Location"::"In Review";
                        Rec.MODIFY;
                    END
                    ELSE
                        MESSAGE('Document State must be open or Re-open');
                end;
            }
            action("Attach Document")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 1173;
                RunPageLink = "No." = FIELD(No),
                              User = FIELD("Created By");
                ApplicationArea = All;
            }
        }
    }

    var
        AuditAssessmentFindings: Record "Audit Assessment Findings";
}

