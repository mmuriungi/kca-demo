page 50431 "HRM-Appraisal Form 2"
{
    PageType = Document;
    SourceTable = "HRM-Employee Appraisals";

    layout
    {
        area(content)
        {
            // part(Control1102755002;"HRM-Performance Plan")
            // {
            //     SubPageLink = "Employee No"=FIELD("Employee No"),
            //                   "Appraisal Type"=FIELD("Appraisal Type"),
            //                   "Appraisal Period"=FIELD("Appraisal Period"),
            //                   "Job ID"=FIELD("Job ID");
            // }
            // part(Control1102755003;"HRM-Career Developement Plan")
            // {
            //     SubPageLink = "Employee No"=FIELD("Employee No"),
            //                   "Appraisal Type"=FIELD("Appraisal Type"),
            //                   "Appraisal Period"=FIELD("Appraisal Period"),
            //                   "Job ID"=FIELD("Job ID");
            // }
            field("Agreement With Rating"; Rec."Agreement With Rating")
            {
            }
            field("General Comments"; Rec."General Comments")
            {
            }
            field(Date; Rec.Date)
            {
            }
            field(Control1102755004; '')
            {
                CaptionClass = Text19024403;
                ShowCaption = false;
                Style = Standard;
                StyleExpr = TRUE;
            }
            field(Control1102755001; '')
            {
                CaptionClass = Text19066736;
                ShowCaption = false;
                Style = Standard;
                StyleExpr = TRUE;
            }
            field(Control1102755000; '')
            {
                CaptionClass = Text19023489;
                ShowCaption = false;
                Style = Standard;
                StyleExpr = TRUE;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Preview)
            {
                Caption = 'Preview';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    EmployeeAppraisals.Reset;
                    EmployeeAppraisals.SetRange(EmployeeAppraisals."Employee No", Rec."Employee No");
                    EmployeeAppraisals.SetRange(EmployeeAppraisals."Appraisal Type", Rec."Appraisal Type");
                    EmployeeAppraisals.SetRange(EmployeeAppraisals."Appraisal Period", Rec."Appraisal Period");
                    if EmployeeAppraisals.Find('-') then
                        REPORT.RunModal(report::"Appraisal Form", true, false, EmployeeAppraisals);
                end;
            }
        }
    }

    var
        EmployeeAppraisals: Record "HRM-Employee Appraisals";
        Text19023489: Label 'Performance Plan (Part 1- Agreed Key Indicators)';
        Text19066736: Label 'Career Development Plan (Part 2 - To be established by both officer and supervisor)';
        Text19024403: Label 'Staff Member Review (Part 3 - Review of Ratings/Assessment by Supervisor )';
}

