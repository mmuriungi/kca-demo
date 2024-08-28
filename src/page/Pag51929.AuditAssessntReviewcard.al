page 51929 "Audit Assessnt Review card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "Audit Asssessment Header";
    SourceTableView = WHERE(Status = FILTER(Review));

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(Nos; Rec.No)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                /* field(Department; Rec.Department)
                {
                } */
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = All;
                }
                field(Scope; Rec.Scope)
                {
                    ApplicationArea = All;
                }
                field(Process; Rec.Process)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
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
                field("Current Location"; Rec."Current Location")
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
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
            part("Risk Observations/Findings"; "Audit Assessment Findings")
            {
                SubPageLink = "Risk Assessment Code" = FIELD(No);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Re-Open Assessment")
            {
                Image = ReOpen;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec.Status = Rec.Status::Review THEN BEGIN

                        IF CONFIRM('This document will be reopened for review', TRUE) = FALSE THEN ERROR('Document Remains to be reviewed');

                        Rec.Status := Rec.Status::"Re-Opened";
                        Rec."Current Location" := Rec."Current Location"::"Re-opened";
                        Rec.MODIFY;
                    END
                    ELSE
                        MESSAGE('Invalid Flow of Document');
                end;
            }
            action(Archive)
            {
                Image = Archive;
                ApplicationArea = All;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                //The property 'PromotedOnly' can only be set if the property 'Promoted' is set to 'true'
                //PromotedOnly = true;

                trigger OnAction()
                begin
                    IF Rec.Status <> Rec.Status::Review
                      THEN
                        ERROR('Document must be in Review Stage');

                    Rec.TESTFIELD(Scope);
                    Rec.TESTFIELD(Objective);
                    Rec.TESTFIELD(Remarks);
                    Rec.TESTFIELD(Process);

                    //archive document
                    Rec.Status := Rec.Status::Completed;
                    Rec.Archived := TRUE;
                    Rec."Archived By" := USERID;
                    Rec."Archived On" := CREATEDATETIME(TODAY, TIME);
                    Rec.MODIFY;
                end;
            }
            action("Attached Document")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 1173;
                RunPageLink = "No." = FIELD(No);
                ApplicationArea = All;
            }
        }
    }
}

