page 50436 "HRM-Job Requirements"
{
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HRM-Jobs";

    layout
    {
        area(content)
        {
            group("Job Specification")
            {
                Caption = 'Job Details';
                field("Job ID"; Rec."Job ID")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job Description"; Rec."Job Title")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
            }
            part("Job Requirement Lines"; "HRM-Applicant Qualif. lines")
            {
                Caption = 'Job Requirements';
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Job Requirements")
            {
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee Pay Element Summary";

                trigger OnAction()
                begin
                    HRJobReq.Reset;
                    HRJobReq.SetRange(HRJobReq."Job Id", Rec."Job ID");
                    if HRJobReq.Find('-') then begin
                        REPORT.Run(39003924, true, true, HRJobReq);
                    end;
                end;
            }
        }
    }

    var
        HRJobReq: Record "HRM-Job Requirement";
}

