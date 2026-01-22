codeunit 50100 "Student Def_Withdrawal Mgmt"
{
    trigger OnRun()
    begin
    end;

    procedure HandleApprovedDefermentWithdrawal(var StudentDefermentWithdrawal: Record "Student Deferment/Withdrawal")
    begin
        if StudentDefermentWithdrawal.Status <> StudentDefermentWithdrawal.Status::Approved then
            exit;

        case StudentDefermentWithdrawal."Request Type" of
            StudentDefermentWithdrawal."Request Type"::Deferment:
                HandleDeferment(StudentDefermentWithdrawal);
            StudentDefermentWithdrawal."Request Type"::Withdrawal:
                HandleWithdrawal(StudentDefermentWithdrawal);
        end;
    end;

    local procedure HandleDeferment(var StudentDefermentWithdrawal: Record "Student Deferment/Withdrawal")
    var
        CourseRegistration: Record "ACA-Course Registration";
        Customer: Record Customer;
    begin
        // Update course registrations
        CourseRegistration.Reset();
        CourseRegistration.SetRange("Student No.", StudentDefermentWithdrawal."Student No.");
        CourseRegistration.SetRange("Academic Year", StudentDefermentWithdrawal."Academic Year");
        CourseRegistration.SetRange(Semester, StudentDefermentWithdrawal."Semester");

        if CourseRegistration.FindLast() then begin
            CourseRegistration.Validate(Reversed, true);
            CourseRegistration.Validate("Stoppage Reason", 'DEFERRED');
            CourseRegistration.Modify(true);
        end;

        // Update customer record to indicate deferment
        if Customer.Get(StudentDefermentWithdrawal."Student No.") then begin
            Customer.Validate(Status, Customer.Status::Deferred);
            Customer.Modify(true);
        end;
    end;

    local procedure HandleWithdrawal(var StudentDefermentWithdrawal: Record "Student Deferment/Withdrawal")
    var
        CourseRegistration: Record "ACA-Course Registration";
        Customer: Record Customer;
    begin
        // Update course registrations
        CourseRegistration.Reset();
        CourseRegistration.SetRange("Student No.", StudentDefermentWithdrawal."Student No.");
        CourseRegistration.SetRange("Academic Year", StudentDefermentWithdrawal."Academic Year");
        CourseRegistration.SetRange(Semester, StudentDefermentWithdrawal."Semester");

        if CourseRegistration.FindLast() then begin
            CourseRegistration.Validate(Reversed, true);
            CourseRegistration.Validate("Stoppage Reason", 'WITHDRAWN');
            CourseRegistration.Modify(true);
        end;

        // Update customer record to indicate withdrawal
        if Customer.Get(StudentDefermentWithdrawal."Student No.") then begin
            Customer.Validate(Status, Customer.Status::Withdrawn);
            Customer.Validate(Blocked, Customer.Blocked::All);
            Customer.Modify(true);
        end;
    end;
}
