codeunit 50092 "PostGraduate Handler"
{
    procedure submitThesisPaper()
    begin

    end;

    procedure checkFeePolicyMet()
    begin

    end;

    procedure ApplyForSupervisor(StudentNo: Code[20]): Code[20]
    var
        PostgradStudent: Record "Customer";
        SupervisorApplication: Record "Postgrad Supervisor Applic.";
    begin
        PostgradStudent.Get(StudentNo);
        //PostgradStudent.TestField("Fee Policy Met", true);

        SupervisorApplication.Init();
        SupervisorApplication."No." := '';
        SupervisorApplication."Student No." := StudentNo;
        SupervisorApplication.Validate("Student No.");
        SupervisorApplication."Application Date" := Today;
        SupervisorApplication.Status := SupervisorApplication.Status::Open;
        if SupervisorApplication.Insert(true) then
            exit(SupervisorApplication."No.");
    end;

    procedure ApproveSupervisorApplication(ApplicationNo: Code[20])
    var
        SupervisorApplication: Record "Postgrad Supervisor Applic.";
        PostgradStudent: Record "Customer";
    begin
        SupervisorApplication.Get(ApplicationNo);
        SupervisorApplication.TestField(Status, SupervisorApplication.Status::Pending);
        SupervisorApplication.TestField("Assigned Supervisor Code");

        SupervisorApplication.Status := SupervisorApplication.Status::Approved;
        SupervisorApplication.Modify();

        PostgradStudent.Get(SupervisorApplication."Student No.");
        PostgradStudent."Supervisor No." := SupervisorApplication."Assigned Supervisor Code";
        PostgradStudent.Modify();

        SendNotificationToStudent(SupervisorApplication."Student No.", SupervisorApplication."Assigned Supervisor Code");
    end;

    procedure RejectSupervisorApplication(ApplicationNo: Code[20])
    var
        SupervisorApplication: Record "Postgrad Supervisor Applic.";
    begin
        SupervisorApplication.Get(ApplicationNo);
        SupervisorApplication.TestField(Status, SupervisorApplication.Status::Pending);

        SupervisorApplication.Status := SupervisorApplication.Status::Rejected;
        SupervisorApplication.Modify();
    end;

    local procedure SendNotificationToStudent(StudentNo: Code[20]; SupervisorCode: Code[20])
    var
        PostgradStudent: Record "Customer";
        Supervisor: Record "HRM-Employee C";
        NotificationMsg: Text;
    begin
        PostgradStudent.Get(StudentNo);
        Supervisor.Get(SupervisorCode);

        NotificationMsg := StrSubstNo('Dear %1,\Your "Postgrad Supervisor Applic."has been approved. Your assigned supervisor is %2 (%3).',
                                      PostgradStudent.Name, Supervisor.FullName(), Supervisor."E-Mail");

        //TODO

    end;

    procedure SubmitDocument(StudentNo: Code[20]; SubmissionType: Option "Concept Paper",Thesis): Code[20]
    var
        StudentSubmission: Record "Student Submission";
    begin
        StudentSubmission.Init();
        StudentSubmission."No." := '';
        StudentSubmission."Student No." := StudentNo;
        StudentSubmission."Submission Type" := SubmissionType;
        StudentSubmission."Submission Date" := Today;
        //StudentSubmission."Document Link" := DocumentLink;
        StudentSubmission.Status := StudentSubmission.Status::Open;
        StudentSubmission.Insert(true);
        UpdateStudentStage(StudentNo, SubmissionType);
        exit(StudentSubmission."No.");
    end;

    procedure ReviewSubmission(EntryNo: Integer; NewStatus: Option Submitted,Reviewed,Approved,Rejected)
    var
        StudentSubmission: Record "Student Submission";
    begin
        StudentSubmission.Get(EntryNo);
        StudentSubmission.Status := NewStatus;
        StudentSubmission.Modify();

        if NewStatus = StudentSubmission.Status::Approved then
            UpdateStudentStageOnApproval(StudentSubmission."Student No.", StudentSubmission."Submission Type");
    end;

    local procedure UpdateStudentStage(StudentNo: Code[20]; SubmissionType: Option "Concept Paper",Thesis)
    var
        PostgradStudent: Record "Customer";
    begin
        PostgradStudent.Get(StudentNo);
        case SubmissionType of
        // SubmissionType::"Concept Paper":
        //     PostgradStudent."Study Stage" := PostgradStudent."Study Stage"::"Concept Paper";
        // SubmissionType::Thesis:
        //     PostgradStudent."Study Stage" := PostgradStudent."Study Stage"::Thesis;
        end;
        PostgradStudent.Modify();
    end;

    local procedure UpdateStudentStageOnApproval(StudentNo: Code[20]; SubmissionType: Option "Concept Paper",Thesis)
    var
        PostgradStudent: Record "Customer";
    begin
        PostgradStudent.Get(StudentNo);
        case SubmissionType of
        // SubmissionType::"Concept Paper":
        //     PostgradStudent."Study Stage" := PostgradStudent."Study Stage"::Thesis;
        // SubmissionType::Thesis:
        //     PostgradStudent."Study Stage" := PostgradStudent."Study Stage"::Completed;
        end;
        PostgradStudent.Modify();
    end;

    procedure LogCommunication(StudentNo: Code[20]; SupervisorCode: Code[20]; Message: Text[2048]; SenderType: Option Student,Supervisor): Boolean
    var
        StudentCommunicationLog: Record "Postgrad Messages";
    begin
        StudentCommunicationLog.Init();
        StudentCommunicationLog."Student No." := StudentNo;
        StudentCommunicationLog."Supervisor Code" := SupervisorCode;
        StudentCommunicationLog."Communication Date" := CurrentDateTime;
        StudentCommunicationLog.Message := Message;
        StudentCommunicationLog."Sender Type" := SenderType;
        exit(StudentCommunicationLog.Insert(true));
    end;
}
