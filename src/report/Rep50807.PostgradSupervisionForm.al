report 50807 "Postgrad Supervision Form"
{
    ApplicationArea = All;
    Caption = 'Postgrad Supervision Form';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './Layouts/Postgrad Supervision Form.docx';
    dataset
    {
        dataitem(SupervisionTracking; "Supervision Tracking")
        {
            column(AcademicYear; "Academic Year")
            {
            }
            column(DateCreated; "Date Created")
            {
            }
            column(DateMetWithSupervisor; "Date Met With Supervisor")
            {
            }
            column(DateWorkSubmitted; "Date Work Submitted")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(NatureofFeedback; "Nature of Feedback")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(SemesterCode; "Semester Code")
            {
            }
            column(StageofWork; "Stage of Work")
            {
            }
            column(Status; Status)
            {
            }
            column(StudentNo; "Student No.")
            {
            }
            column(StudentSigned; "Student Signed")
            {
            }
            column(SupervisorCode; "Supervisor Code")
            {
            }
            column(SupervisorSigned; "Supervisor Signed")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
