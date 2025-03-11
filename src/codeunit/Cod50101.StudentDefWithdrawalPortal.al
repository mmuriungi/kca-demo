codeunit 50101 "Student Def_Withdrawal Portal"
{
    trigger OnRun()
    begin
    end;

    var
        ApprovMgmt: Codeunit "Approval Workflows V1";
        Variant: Variant;
    // Create a new deferment or withdrawal request
    procedure CreateDefermentWithdrawalRequest(StudentNo: Code[20]; RequestType: Option Deferment,Withdrawal; StartDate: Date; EndDate: Date; AcademicYear: Code[20]; Semester: Code[20]; ProgrammeCode: Code[20]; Stage: Code[20]; Reason: Text[250]) Result: Text
    var
        StudentDefermentWithdrawal: Record "Student Deferment/Withdrawal";
        Customer: Record Customer;
        AcademicSetup: Record "ACA-General Set-Up";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RequestNo: Code[20];
    begin
        // Validate student exists
        if not Customer.Get(StudentNo) then
            exit('Student not found');

        // Check if student has active status
        if not (Customer.Status = Customer.Status::Current) then
            exit('Only students with Current status can submit deferment or withdrawal requests');

        // Create new request
        StudentDefermentWithdrawal.Init();

        // Get number series
        AcademicSetup.Get();
        AcademicSetup.TestField("Deferment/Withdrawal Nos");
        RequestNo := NoSeriesMgt.GetNextNo(AcademicSetup."Deferment/Withdrawal Nos", Today, true);

        StudentDefermentWithdrawal."No." := RequestNo;
        StudentDefermentWithdrawal."Student No." := StudentNo;
        StudentDefermentWithdrawal."Student Name" := Customer.Name;
        StudentDefermentWithdrawal."Request Type" := RequestType;
        StudentDefermentWithdrawal."Request Date" := Today;
        StudentDefermentWithdrawal."Start Date" := StartDate;

        if RequestType = RequestType::Deferment then begin
            StudentDefermentWithdrawal."End Date" := EndDate;
            if EndDate <> 0D then
                StudentDefermentWithdrawal."Return Date" := CalcDate('<1D>', EndDate);
        end;

        StudentDefermentWithdrawal."Academic Year" := AcademicYear;
        StudentDefermentWithdrawal."Semester" := Semester;
        StudentDefermentWithdrawal."Programme Code" := ProgrammeCode;
        StudentDefermentWithdrawal."Stage" := Stage;
        StudentDefermentWithdrawal.Reason := Reason;
        StudentDefermentWithdrawal.Status := StudentDefermentWithdrawal.Status::Open;

        if StudentDefermentWithdrawal.Insert(true) then begin
            Variant := StudentDefermentWithdrawal;
            ApprovMgmt.CheckApprovalsWorkflowEnabled(Variant);
            ApprovMgmt.OnSendDocForApproval(Variant);
            Result := 'Request created successfully. Request No: ' + RequestNo
        end
        else
            Result := 'Failed to create request';

        exit(Result);
    end;

    // Get list of deferment/withdrawal requests for a student
    procedure GetStudentDefermentWithdrawalRequests(StudentNo: Code[20]) Result: Text
    var
        StudentDefermentWithdrawal: Record "Student Deferment/Withdrawal";
        RequestList: Text;
    begin
        StudentDefermentWithdrawal.Reset();
        StudentDefermentWithdrawal.SetRange("Student No.", StudentNo);
        StudentDefermentWithdrawal.SetCurrentKey("Request Date");
        StudentDefermentWithdrawal.Ascending(false);

        if not StudentDefermentWithdrawal.FindSet() then
            exit('No deferment or withdrawal requests found');

        repeat
            RequestList += StudentDefermentWithdrawal."No." + '::' +
                          Format(StudentDefermentWithdrawal."Request Type") + '::' +
                          Format(StudentDefermentWithdrawal."Request Date") + '::' +
                          StudentDefermentWithdrawal."Academic Year" + '::' +
                          StudentDefermentWithdrawal."Semester" + '::' +
                          Format(StudentDefermentWithdrawal.Status) + ':::';
        until StudentDefermentWithdrawal.Next() = 0;

        exit(RequestList);
    end;

    // Get details of a specific deferment/withdrawal request
    procedure GetDefermentWithdrawalRequestDetails(RequestNo: Code[20]) Result: Text
    var
        StudentDefermentWithdrawal: Record "Student Deferment/Withdrawal";
    begin
        if not StudentDefermentWithdrawal.Get(RequestNo) then
            exit('Request not found');

        Result := StudentDefermentWithdrawal."No." + '::' +
                 StudentDefermentWithdrawal."Student No." + '::' +
                 StudentDefermentWithdrawal."Student Name" + '::' +
                 Format(StudentDefermentWithdrawal."Request Type") + '::' +
                 Format(StudentDefermentWithdrawal."Request Date") + '::' +
                 Format(StudentDefermentWithdrawal."Start Date") + '::';

        if StudentDefermentWithdrawal."Request Type" = StudentDefermentWithdrawal."Request Type"::Deferment then
            Result += Format(StudentDefermentWithdrawal."End Date") + '::' +
                     Format(StudentDefermentWithdrawal."Return Date") + '::'
        else
            Result += '::' + '::';

        Result += StudentDefermentWithdrawal."Academic Year" + '::' +
                 StudentDefermentWithdrawal."Semester" + '::' +
                 StudentDefermentWithdrawal."Programme Code" + '::' +
                 StudentDefermentWithdrawal."Stage" + '::' +
                 StudentDefermentWithdrawal.Reason + '::' +
                 Format(StudentDefermentWithdrawal.Status);

        if StudentDefermentWithdrawal.Status <> StudentDefermentWithdrawal.Status::Open then
            Result += '::' + StudentDefermentWithdrawal."Approved By" + '::' +
                     Format(StudentDefermentWithdrawal."Approval Date")
        else
            Result += '::::';

        exit(Result);
    end;

    // Cancel a deferment/withdrawal request
    procedure CancelDefermentWithdrawalRequest(RequestNo: Code[20]; StudentNo: Code[20]) Result: Text
    var
        StudentDefermentWithdrawal: Record "Student Deferment/Withdrawal";
    begin
        if not StudentDefermentWithdrawal.Get(RequestNo) then
            exit('Request not found');

        if StudentDefermentWithdrawal."Student No." <> StudentNo then
            exit('You can only cancel your own requests');

        if StudentDefermentWithdrawal.Status <> StudentDefermentWithdrawal.Status::Open then
            exit('Only open requests can be cancelled');

        StudentDefermentWithdrawal.Delete(true);
        exit('Request cancelled successfully');
    end;

    // Get current academic year and semester
    procedure GetCurrentAcademicYearAndSemester() Result: Text
    var
        AcademicYearSchedule: Record "ACA-Academic Year Schedule";
    begin


        exit(AcademicYearSchedule."Academic Year" + '::' + AcademicYearSchedule.Semester);
    end;

    // Get student programme and stage
    procedure GetStudentProgrammeAndStage(StudentNo: Code[20]) Result: Text
    var
        CourseRegistration: Record "ACA-Course Registration";
    begin
        CourseRegistration.Reset();
        CourseRegistration.SetRange("Student No.", StudentNo);
        CourseRegistration.SetRange(Reversed, false);
        CourseRegistration.SetCurrentKey("Registration Date");
        CourseRegistration.Ascending(false);

        if not CourseRegistration.FindFirst() then
            exit('No programme information found');

        exit(CourseRegistration.Programmes + '::' + CourseRegistration.Stage);
    end;

    // Check if student has pending deferment/withdrawal requests
    procedure HasPendingDefermentWithdrawalRequests(StudentNo: Code[20]) Result: Boolean
    var
        StudentDefermentWithdrawal: Record "Student Deferment/Withdrawal";
    begin
        StudentDefermentWithdrawal.Reset();
        StudentDefermentWithdrawal.SetRange("Student No.", StudentNo);
        StudentDefermentWithdrawal.SetRange(Status, StudentDefermentWithdrawal.Status::"Pending");

        Result := not StudentDefermentWithdrawal.IsEmpty;
        exit(Result);
    end;

    // Get student status information
    procedure GetStudentStatusInfo(StudentNo: Code[20]) Result: Text
    var
        Customer: Record Customer;
    begin
        if not Customer.Get(StudentNo) then
            exit('Student not found');

        Result := Format(Customer.Status);

        if Customer.Status = Customer.Status::Deferred then
            Result += '::Deferred'
        else if Customer.Status = Customer.Status::Withdrawn then
            Result += '::Withdrawn'
        else
            Result += '::Active';

        exit(Result);
    end;
}
