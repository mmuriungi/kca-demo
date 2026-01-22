page 50561 "HRM-Appraisal Emp Targets-SUP"
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

