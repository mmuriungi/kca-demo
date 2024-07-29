page 51125 "HRM-Appraisal Supervisor Com."
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HRM-Appraisal Supervisor Com.";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Supervisor Comments"; Rec."Supervisor Comments")
                {
                }
                field("Mitigating Factor"; Rec."Mitigating Factor")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("Appraisal year Code", HRMAppraisalYears.Code);
    end;

    trigger OnOpenPage()
    begin
        HRMAppraisalYears.RESET;
        HRMAppraisalYears.SETRANGE(Closed, FALSE);
        IF HRMAppraisalYears.FIND('-') THEN
            Rec.SETFILTER("Appraisal year Code", HRMAppraisalYears.Code);
    end;

    var
        UserSetup: Record "User Setup";
        HRMAppraisalYears: Record "HRM-Appraisal Years";
        HRMAppraisalPeriods: Record "HRM-Appraisal Periods";
        editability: Boolean;
}

