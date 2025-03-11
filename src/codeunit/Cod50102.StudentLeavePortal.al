codeunit 50102 "Student Leave Portal"
{
    trigger OnRun()
    begin
    end;

    var
        ApprovMgmt: Codeunit "Approval Workflows V1";
        Variant: Variant;
        AffairsMgmt: Codeunit "Student Affairs Management";

    // Create a new student leave request
    procedure CreateStudentLeaveRequest(StudentNo: Code[20]; LeaveType: Option Regular,Compassionate; StartDate: Date; NoOfDays: Decimal; Reason: Text[250]) Result: Text
    var
        StudentLeave: Record "Student Leave";
        Customer: Record Customer;
        AcademicSetup: Record "ACA-General Set-Up";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LeaveNo: Code[20];
    begin
        // Validate student exists
        if not Customer.Get(StudentNo) then
            exit('Student not found');

        // Check if student has active status
        if not (Customer.Status = Customer.Status::Current) then
            exit('Only students with Current status can submit leave requests');

        // Create new request
        StudentLeave.Init();

        // Get number series
        StudentLeave."Leave No." := LeaveNo;
        StudentLeave."Student No." := StudentNo;
        StudentLeave."Leave Type" := LeaveType;
        StudentLeave."Start Date" := StartDate;
        StudentLeave."No of Days" := NoOfDays;
        StudentLeave.Reason := Reason;
        StudentLeave."Approval Status" := StudentLeave."Approval Status"::Open;
        StudentLeave."Posting Date" := Today;
        StudentLeave."Posting Type" := StudentLeave."Posting Type"::Leave;

        // Calculate end date and return date
        AffairsMgmt.calculateLeaveEndDate(StudentLeave);

        if StudentLeave.Insert(true) then begin
            Variant := StudentLeave;
            ApprovMgmt.CheckApprovalsWorkflowEnabled(Variant);
            ApprovMgmt.OnSendDocForApproval(Variant);
            Result := 'Leave request created successfully. Leave No: ' + LeaveNo;
        end
        else
            Result := 'Failed to create leave request';

        exit(Result);
    end;

    // Get list of leave requests for a student
    procedure GetStudentLeaveRequests(StudentNo: Code[20]) Result: Text
    var
        StudentLeave: Record "Student Leave";
        RequestList: Text;
    begin
        StudentLeave.Reset();
        StudentLeave.SetRange("Student No.", StudentNo);
        StudentLeave.SetCurrentKey("Start Date");
        StudentLeave.Ascending(false);

        if not StudentLeave.FindSet() then
            exit('No leave requests found');

        repeat
            RequestList += StudentLeave."Leave No." + '::' +
                          Format(StudentLeave."Leave Type") + '::' +
                          Format(StudentLeave."Start Date") + '::' +
                          Format(StudentLeave."End Date") + '::' +
                          Format(StudentLeave."No of Days") + '::' +
                          Format(StudentLeave."Approval Status") + ':::';
        until StudentLeave.Next() = 0;

        exit(RequestList);
    end;

    // Get details of a specific leave request
    procedure GetLeaveRequestDetails(LeaveNo: Code[20]) Result: Text
    var
        StudentLeave: Record "Student Leave";
    begin
        if not StudentLeave.Get(LeaveNo) then
            exit('Leave request not found');

        Result := StudentLeave."Leave No." + '::' +
                 StudentLeave."Student No." + '::' +
                 StudentLeave."Student Name" + '::' +
                 Format(StudentLeave."Leave Type") + '::' +
                 Format(StudentLeave."Start Date") + '::' +
                 Format(StudentLeave."End Date") + '::' +
                 Format(StudentLeave."Return Date") + '::' +
                 Format(StudentLeave."No of Days") + '::' +
                 StudentLeave.Reason + '::' +
                 Format(StudentLeave."Approval Status");

        if StudentLeave."Approval Status" <> StudentLeave."Approval Status"::Open then
            Result += '::' + StudentLeave."Approved By" + '::' +
                     Format(StudentLeave."Approval Date")
        else
            Result += '::::';

        exit(Result);
    end;

    // Cancel a leave request
    procedure CancelLeaveRequest(LeaveNo: Code[20]; StudentNo: Code[20]) Result: Text
    var
        StudentLeave: Record "Student Leave";
    begin
        if not StudentLeave.Get(LeaveNo) then
            exit('Leave request not found');

        if StudentLeave."Student No." <> StudentNo then
            exit('You can only cancel your own requests');

        if StudentLeave."Approval Status" <> StudentLeave."Approval Status"::Open then
            exit('Only open requests can be cancelled');

        StudentLeave.Delete(true);
        exit('Leave request cancelled successfully');
    end;

    // Check if student has pending leave requests
    procedure HasPendingLeaveRequests(StudentNo: Code[20]) Result: Boolean
    var
        StudentLeave: Record "Student Leave";
    begin
        StudentLeave.Reset();
        StudentLeave.SetRange("Student No.", StudentNo);
        StudentLeave.SetRange("Approval Status", StudentLeave."Approval Status"::Pending);

        Result := not StudentLeave.IsEmpty;
        exit(Result);
    end;

    // Get student's active leave status
}
