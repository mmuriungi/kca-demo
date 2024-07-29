page 51118 "HRM-Appraisal Emp Targets-HR"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HRM-Appraisal Emp. Targets";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Agreed Performance Targets"; Rec."Agreed Performance Targets")
                {
                    Caption = 'Agreed Performance Targets';
                }
                field("Expected Performance Indicator"; Rec."Expected Performance Indicator")
                {
                }
                field("Mid Year Review (Remarks)"; Rec."Mid Year Review (Remarks)")
                {
                }
                field("Individual Target"; Rec."Individual Target")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Agreed Score"; Rec."Agreed Score")
                {
                    Editable = false;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AppraisalReport)
            {
                Caption = 'Appraisal Report';
                Image = AdjustEntries;
                trigger OnAction()
                begin
                    HRMAppraisalEmpTargets.RESET;
                    HRMAppraisalEmpTargets.SETRANGE("Appraisal Period Code", Rec."Appraisal Period Code");
                    HRMAppraisalEmpTargets.SETRANGE("Appraisal year Code", Rec."Appraisal year Code");
                    HRMAppraisalEmpTargets.SETRANGE("PF. No.", Rec."PF. No.");
                    IF HRMAppraisalEmpTargets.FIND('-') THEN
                        REPORT.RUN(report::"HRM Appraisal Targets", TRUE, FALSE, HRMAppraisalEmpTargets);
                end;
            }
        }
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
        HRMAppraisalEmpTargets: Record "HRM-Appraisal Emp. Targets";
}

