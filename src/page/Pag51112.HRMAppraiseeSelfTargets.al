page 51112 "HRM-Appraisee Self Targets"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HRM-Appraisal Emp. Targets";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Appraisal Target Code"; Rec."Appraisal Target Code")
                {
                }
                field("Agreed Performance Targets"; Rec."Agreed Performance Targets")
                {

                }
                field("Expected Performance Indicator"; Rec."Expected Performance Indicator")
                {
                }
                field("Mid Year Review (Remarks)"; Rec."Mid Year Review (Remarks)")
                {
                }
                field("Individual Target"; Rec."Individual Target")
                {
                    Editable = editability;
                    Enabled = editability;
                }
                field("Agreed Score"; Rec."Agreed Score")
                {
                    Caption = 'Performance Appraisal Score';
                    Editable = false;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("My Comments")
            {
                Caption = 'My Comments';
                Image = Comment;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "HRM-Appraisal Appraisee Comm.";
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("PF. No.", '%1', UserSetup."Employee No.");
        Rec.SETFILTER("Appraisal year Code", HRMAppraisalYears.Code);
        IF Rec.Closed THEN editability := FALSE ELSE editability := TRUE
    end;

    trigger OnOpenPage()
    begin
        IF UserSetup.GET(USERID) THEN;
        IF UserSetup."Employee No." = '' THEN ERROR(USERID + ' is not mapped to employee in the user setup');
        Rec.SETFILTER("PF. No.", '%1', UserSetup."Employee No.");
        HRMAppraisalYears.RESET;
        HRMAppraisalYears.SETRANGE(Closed, FALSE);
        IF HRMAppraisalYears.FIND('-') THEN
            Rec.SETFILTER("Appraisal year Code", HRMAppraisalYears.Code);
        /*
        HRMAppraisalPeriods.RESET;
        HRMAppraisalPeriods.SETFILTER(Closed,'%1',FALSE);
        IF HRMAppraisalPeriods.FIND('-') THEN
          SETFILTER("Appraisal Period Code",HRMAppraisalPeriods.Code);
          */
        CLEAR(editability);
        IF Rec.Closed THEN editability := FALSE ELSE editability := TRUE

    end;

    var
        UserSetup: Record "User Setup";
        HRMAppraisalYears: Record "HRM-Appraisal Years";
        HRMAppraisalPeriods: Record "HRM-Appraisal Periods";
        editability: Boolean;
}

