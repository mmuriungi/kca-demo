table 50919 "HRM-Emp. Leave Application"
{

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = false;
            TableRelation = "HRM-Employee C"."No.";
        }
        field(2; "Application Code"; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                "Application Date" := TODAY;
            end;
        }
        field(3; "Leave Code"; Code[20])
        {
            TableRelation = "HRM-Emp. Leaves"."Leave Code" WHERE("Employee No" = FIELD("Employee No"));
        }
        field(4; "Days Applied"; Decimal)
        {

            trigger OnValidate()
            begin

                IF ("Days Applied" <> 0) AND ("Start Date" <> 0D) THEN BEGIN
                    "Approved Days" := "Days Applied";
                    "End Date" := CalcEndDate("Start Date", "Days Applied") - 1;
                    "Return Date" := CalcReturnDate("End Date");
                END;
            end;
        }
        field(5; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                IF ("Days Applied" <> 0) AND ("Start Date" <> 0D) THEN BEGIN
                    "End Date" := CalcEndDate("Start Date", "Days Applied");
                    "Return Date" := CalcReturnDate("End Date");
                    "Approved End Date" := "End Date";

                END;
            end;
        }
        field(6; "End Date"; Date)
        {

            trigger OnValidate()
            begin
                //"Approved To Date":="To Date";
            end;
        }
        field(7; "Application Date"; Date)
        {
        }
        field(8; "Approved Days"; Decimal)
        {
        }
        field(9; "Approved Start Date"; Date)
        {
        }
        field(10; "Verified By Manager"; Boolean)
        {

            trigger OnValidate()
            begin
                "Verification Date" := TODAY;
            end;
        }
        field(11; "Verification Date"; Date)
        {
        }
        field(12; Status; Option)
        {
            OptionCaption = 'New,HOD Approval,Registrar,HR,Approved,Rejected,Canceled';
            OptionMembers = New,"HOD Approval",Registrar,HR,Approved,Rejected,Canceled;

            trigger OnValidate()
            begin

                IF (Status = Status::Approved) AND (xRec.Status <> Status::Approved) THEN BEGIN
                    ;
                    "Approval Date" := TODAY;
                    "Employee Leaves".RESET;
                    "Employee Leaves".SETRANGE("Employee Leaves"."Employee No", "Employee No");
                    "Employee Leaves".SETRANGE("Employee Leaves"."Leave Code", "Leave Code");
                    IF "Employee Leaves".FIND('-') THEN;
                    "Employee Leaves".Balance := "Employee Leaves".Balance - "Approved Days";
                    "Employee Leaves".MODIFY;

                END
                ELSE
                    IF (Status <> Status::Approved) AND (xRec.Status = Status::Approved) THEN BEGIN
                        "Approval Date" := TODAY;
                        "Employee Leaves".RESET;
                        "Employee Leaves".SETRANGE("Employee Leaves"."Employee No", "Employee No");
                        "Employee Leaves".SETRANGE("Employee Leaves"."Leave Code", "Leave Code");
                        IF "Employee Leaves".FIND('-') THEN;
                        "Employee Leaves".Balance := "Employee Leaves".Balance + "Approved Days";
                        "Employee Leaves".MODIFY;
                    END


            end;
        }
        field(13; "Approved End Date"; Date)
        {
        }
        field(14; "Approval Date"; Date)
        {
        }
        field(15; Comments; Text[250])
        {
        }
        field(16; Taken; Boolean)
        {
        }
        field(17; "Approval Status"; Option)
        {
            OptionCaption = 'Pending,1st Approval,2nd Approval,3rd Approval';
            OptionMembers = Pending,"1st Approval","2nd Approval","3rd Approval",Issued;
        }
        field(18; "HOD Status"; Option)
        {
            OptionCaption = ' ,Approve,Reject';
            OptionMembers = " ",Approve,Reject;
        }
        field(19; "Dean Status"; Option)
        {
            OptionCaption = ' ,Approve,Reject';
            OptionMembers = " ",Approve,Reject;
        }
        field(20; "Admin Status"; Option)
        {
            OptionCaption = ' ,Approve,Reject';
            OptionMembers = " ",Approve,Reject;
        }
        field(21; "HOD Approved By"; Code[20])
        {
        }
        field(22; "Dean Approved By"; Code[20])
        {
        }
        field(23; "Admin Approved By"; Code[20])
        {
        }
        field(24; "Return Date"; Date)
        {
        }
        field(50000; "Head of Department"; Code[20])
        {
        }
        field(50001; "Head of Department Name"; Text[150])
        {
        }
        field(50002; "HOD ID"; Code[20])
        {
        }
        field(50003; "Registry in Charge"; Code[20])
        {
        }
        field(50004; Registrar; Code[20])
        {
        }
        field(50005; "Records Officer"; Code[20])
        {
        }
        field(50006; "HOD Start Date"; Date)
        {
        }
        field(50007; "HOD Approved Days"; Integer)
        {
        }
        field(50008; "HOD Return Date"; Date)
        {
        }
        field(50009; "Approver Comment"; Text[150])
        {
        }
        field(50010; "HOD Comm"; Text[150])
        {
        }
        field(50011; "Registrar Comm"; Text[150])
        {
        }
        field(50012; "Records Officer Comm"; Text[150])
        {
        }
        field(50013; "Registry in Charge Comm"; Text[150])
        {
        }
        field(50014; "Head of Department Comments"; Text[150])
        {
        }
        field(50015; "Head of Department Approved"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Application Code", "Leave Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "Employee Leaves": Record "HRM-Emp. Leaves";
        BaseCalendar: Record "Base Calendar Change";
        CurDate: Date;
        LeaveTypes: Record "HRM-Leave Types";
        DayApp: Decimal;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EndDate: Date;
        BeginDate: Date;
        NextDate: Date;
        varDaysApplied: Integer;
        fDays: Integer;
        ReturnDateLoop: Boolean;
        Employee: Record "HRM-Employee C";
        fEmpNo: Code[30];
        EmpLeaveApps: Record "HRM-Emp. Leave Application";
        GeneralOptions: Record "HRM-Setup";
        "HR Set Up": Record "HRM-Human Resources Setup.";
        Levels: Integer;
        LEmployee: Record "HRM-Employee C";
        Approvals: Record "HRM-Recruitment Stages";
        "Leave Applications": Record "HRM-Human Resource Comments";
        CurrYear: Integer;
        CYSDate: Date;
        CYEDate: Date;
        CurrYearValue: Integer;
        Number: Integer;
        //SMTP: Codeunit "SMTP Mail";
        Names: Text[100];
        objPeriod: Record "PRL-Payroll Periods";
        PayPeriod: Date;
        CurrYearValue2: Integer;
        prCodes: Record "PRL-Transaction Codes";
        prTrans: Record "PRL-Employee Transactions";
        Payroll: Record "PRL-Salary Card";
        // Grades: Record 61622;
        Grd: Code[10];
        hrSetup: Record "HRM-Setup"
;
        mContent: Text[100];
        mSubject: Text[100];
        nonworking: Decimal;
        CurrDate: Date;
        NONWORKINDAYS: Integer;
        Users2: Record User;

    procedure DetermineIfIsNonWorking(var bcDate: Date): Boolean
    begin
        GeneralOptions.FIND('-');
        BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SETRANGE(BaseCalendar.Date, bcDate);
        IF BaseCalendar.FIND('-') THEN BEGIN
            IF BaseCalendar.Nonworking = TRUE THEN
                EXIT(TRUE);
        END;
    end;

    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[10]): Boolean
    begin
        IF LeaveTypes.GET(fLeaveCode) THEN BEGIN
            IF LeaveTypes."Inclusive of Non Working Days" = TRUE THEN
                EXIT(TRUE);
        END;
    end;

    procedure DetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    begin
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        REPEAT
            IF DetermineIfIncludesNonWorking("Leave Code") = FALSE THEN BEGIN
                fReturnDate := CALCDATE('1D', fReturnDate);
                IF DetermineIfIsNonWorking(fReturnDate) THEN BEGIN
                    varDaysApplied := varDaysApplied + 1;
                END ELSE
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied + 1
            END
            ELSE BEGIN
                fReturnDate := CALCDATE('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            END;
        UNTIL varDaysApplied = 0;
        EXIT(fReturnDate);
    end;

    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    begin
        ReturnDateLoop := TRUE;
        fEndDate := fDate;
        IF fEndDate <> 0D THEN BEGIN
            fEndDate := CALCDATE('1D', fEndDate);
            WHILE (ReturnDateLoop) DO BEGIN
                IF DetermineIfIsNonWorking(fEndDate) THEN
                    fEndDate := CALCDATE('-1D', fEndDate)
                ELSE
                    ReturnDateLoop := FALSE;
            END
        END;
        EXIT(fEndDate);
    end;

    procedure GetPayPeriod()
    begin
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        IF objPeriod.FIND('-') THEN
            PayPeriod := objPeriod."Date Opened";
    end;

    procedure CalcEndDate(SDate: Date; LDays: Integer) LEndDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
    begin

        SDate := SDate - 1;
        EndLeave := FALSE;
        WHILE EndLeave = FALSE DO BEGIN
            IF NOT DetermineIfIsNonWorking(SDate) THEN
                DayCount := DayCount + 1;
            SDate := SDate + 1;
            IF DayCount > LDays THEN
                EndLeave := TRUE;
        END;
        LEndDate := CALCDATE('-1D', SDate);
    end;

    procedure CalcReturnDate(EndDate: Date) RDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        LEndDate: Date;
    begin
        EndLeave := FALSE;
        LEndDate := EndDate + 1;
        EndDate := EndDate + 1;
        WHILE EndLeave = FALSE DO BEGIN
            IF DetermineIfIsNonWorking(EndDate) THEN BEGIN
                DayCount := DayCount + 1;
                EndDate := EndDate + 1;

            END ELSE BEGIN
                EndLeave := TRUE;
            END;
        END;
        RDate := LEndDate + DayCount;
    end;
}

