page 50505 "HRM-Appraisal Goal Set. (B1)"
{
    PageType = ListPart;
    SourceTable = "HRM-Appraisal Goal Setting L";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Planned Targets/Objectives"; Rec."Planned Targets/Objectives")
                {
                    Editable = false;
                }
                field("Criteria/Target Date"; Rec."Criteria/Target Date")
                {
                    Editable = false;
                }
                field(Score; Rec.Score)
                {
                }
                field("Target Points (Total=100)"; Rec."Target Points (Total=100)")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        "Agreement With RatingEditable" := true;
        ScoreVisible := true;
        "Appraisal RatingVisible" := true;
    end;

    trigger OnOpenPage()
    begin

        HRAppraisalGoalSettingH.SetRange("Appraisal No", Rec."Appraisal No");
        if HRAppraisalGoalSettingH.Find('-') then
            if HRAppraisalGoalSettingH.Status = HRAppraisalGoalSettingH.Status::Open then begin
                "Agreement With RatingEditable" := false;
                "Appraisal RatingVisible" := false;
                ScoreVisible := false;
            end else begin
                "Agreement With RatingEditable" := true;
            end;
    end;

    var
        HRAppraisalGoalSettingH: Record "HRM-Appraisal Goal Setting H";
        [InDataSet]
        "Appraisal RatingVisible": Boolean;
        [InDataSet]
        ScoreVisible: Boolean;
        [InDataSet]
        "Agreement With RatingEditable": Boolean;
}

