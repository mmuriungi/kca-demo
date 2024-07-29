page 51029 "HRM-Appraisal Evaluation Lines"
{
    PageType = List;
    SourceTable = "HRM-Appraisal Evaluations";
    SourceTableView = WHERE(Category = CONST("JOB SPECIFIC EVALUATION AREA"));

    layout
    {
        area(content)
        {
            repeater(Control1102755004)
            {
                Editable = false;
                ShowCaption = false;
            }
            field("Evaluation Code"; Rec."Evaluation Code")
            {
            }
            field("Evaluation Description"; Rec."Evaluation Description")
            {
            }
            field(Category; Rec.Category)
            {
            }
            field("Sub Category"; Rec."Sub Category")
            {
            }
        }
    }

    actions
    {
    }

    var
        YesNo: Boolean;
        HRAppraisalEvaluations: Record "PRL-Payroll Variations";
        HREmp: Record "HRM-Short Listed Applicant";
        HRAppraisalRatings: Record "HRM-Leave Requisition";
        TotalScore: Decimal;

    procedure TotScore()
    begin
    end;
}

