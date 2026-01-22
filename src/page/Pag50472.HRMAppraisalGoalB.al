page 50472 "HRM-Appraisal Goal (B)"
{
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Functions,NextPage';
    SourceTable = "HRM-Appraisal Goal Setting H";
    SourceTableView = WHERE(Status = CONST(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Importance = Promoted;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Importance = Promoted;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Importance = Promoted;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    Importance = Promoted;
                }
                field("Appraisal Stage"; Rec."Appraisal Stage")
                {
                }
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
            }
            part("PERSONAL GOALS/OBJECTIVES"; "HRM-Appraisal Goal Set. (B1)")
            {
                Caption = 'PERSONAL GOALS/OBJECTIVES';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
            }
            part(SF; "HRM-Appraisal Evaluation Line")
            {
                Caption = 'PERSONAL PROFESSIONAL ATTRIBUTES';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
            }
        }
        area(processing)
        {
            action("&Next Page")
            {
                Caption = '&Next Page';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Page "HRM-Appraisal Goal Setting";
                RunPageLink = "Appraisal No" = FIELD("Appraisal No");

                trigger OnAction()
                begin
                    //FORM.RUNMODAL(39005843
                    //PAGE.RUN(39003985,Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if HREmp.Get(Rec."Employee No") then Begin
            //  "Job Title":=HREmp."Job Title";

        end;
    end;

    var
        //HRAppraisalEvaluationAreas: Record "HRM-Job Assessment  lines";
        HRAppraisalEvaluations: Record "PRL-Payroll Variations";
        HRAppraisalEvaluationsF: Page "HRM-Appraisal Evaluation Lines";
        HREmp: Record "HRM-Short Listed Applicant";
}

