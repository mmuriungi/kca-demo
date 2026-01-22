page 52060 "Postgrad Activites Cue"
{
    PageType = CardPart;
    SourceTable = "Postgrad Activities Cue";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup(StudentActivities)
            {
                Caption = 'Student Activities';
                field(ActiveStudents; Rec.ActiveStudents)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "ACA-All Students List";
                    ToolTip = 'Shows the number of active postgraduate students';
                }
                field(PendingApplications; Rec.PendingApplications)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Supervisor Applications";
                    ToolTip = 'Shows the number of pending supervisor applications';
                }
                field(RecentSubmissions; Rec.RecentSubmissions)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Postgrad Submission List";
                    ToolTip = 'Shows the number of submissions in the last 30 days';
                }
            }
            cuegroup(SupervisorActivities)
            {
                Caption = 'Supervisor Activities';
                field(ActiveSupervisors; Rec.ActiveSupervisors)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "ACA-Lecturer List";
                    ToolTip = 'Shows the number of active supervisors';
                }
                field(SubmissionsToReview; Rec.SubmissionsToReview)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Postgrad Submission List";
                    ToolTip = 'Shows the number of submissions waiting for review';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        Rec.CalculateCueFieldValues();
    end;
}
