codeunit 50031 "Validate User Permissions"
{
    // Check Access Permissions


    trigger OnRun()
    begin
    end;


    procedure validateUser(var RecType: Option " ",GL,Cust,Item,Supp,FA,Emp,Sal,CourseReg,prTrans,EmpTrans)
    var
        Usersetup: Record 91;
    begin
        IF NOT Usersetup.GET(USERID) THEN ERROR('You are not a Legitimate user. Please consult the system administrator.');
        /* IF RecType = RecType::FA THEN IF NOT (Usersetup."Create FA" = TRUE) THEN ERROR('You do not have permission to work on Fixed Assets.');
        IF RecType = RecType::Cust THEN IF NOT (Usersetup."Create Customer" = TRUE) THEN ERROR('You do not have permission to work on Customers.');
        IF RecType = RecType::Emp THEN IF NOT (Usersetup."Create Employee" = TRUE) THEN ERROR('You do not have permission to work on Employees.');
        IF RecType = RecType::CourseReg THEN IF NOT (Usersetup."Create Course_Reg" = TRUE) THEN ERROR('You do not have permission to work on Course Registrations.');
        IF RecType = RecType::GL THEN IF NOT (Usersetup."Create GL" = TRUE) THEN ERROR('You do not have permission to work on GL.');
        IF RecType = RecType::Item THEN IF NOT (Usersetup."Create Items" = TRUE) THEN ERROR('You do not have permission to work on Items.');
        IF RecType = RecType::Sal THEN IF NOT (Usersetup."Create Salary" = TRUE) THEN ERROR('You do not have permission to work on Salaries.');
        IF RecType = RecType::Supp THEN IF NOT (Usersetup."Create Supplier" = TRUE) THEN ERROR('You do not have permission to work on Suppliers');
        IF RecType = RecType::EmpTrans THEN IF NOT (Usersetup."Create Emp. Transactions" = TRUE) THEN ERROR('You do not have permission to work on Emp. transactions');
        IF RecType = RecType::prTrans THEN IF NOT (Usersetup."Create PR Transactions" = TRUE) THEN ERROR('You do not have permission to work on Transactions'); */
    end;
}

