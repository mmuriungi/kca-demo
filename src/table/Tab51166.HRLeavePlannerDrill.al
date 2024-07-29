table 51166 "HR Leave Planner Drill"
{
    //DrillDownPageID = 50685;
    //LookupPageID = 50685;

    fields
    {
        field(1; "Application Code"; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Application Code" <> xRec."Application Code" THEN BEGIN
                    HRSetup.GET;
                    NoSeriesMgt.TestManual(HRSetup."Leave Planner Nos.");
                    "No series" := '';
                END;
            end;
        }
        field(3; "Leave Type"; Code[20])
        {
            TableRelation = "HRM-Leave Types".Code;

            trigger OnValidate()
            begin
                /*

               //RESET;
               //SETRANGE("Employee No",LeaveHeader."Employee No");
               IF LeaveHeader.FIND('-') THEN
               "Employee No":= LeaveHeader."Employee No";

               HRLeaveTypes.GET("Leave Type");
               HREmp.GET("Employee No");
               IF HREmp.Gender=HRLeaveTypes.Gender THEN
               EXIT
               ELSE
               ERROR('This leave type is restricted to the '+ FORMAT(HRLeaveTypes.Gender) +' gender')
               */

            end;
        }
        field(4; "Days Applied"; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin


                TESTFIELD("Leave Type");
                //CALCULATE THE END DATE AND RETURN DATE
                BEGIN
                    IF ("Days Applied" <> 0) AND ("Start Date" <> 0D) THEN
                        "Return Date" := DetermineLeaveReturnDate("Start Date", "Days Applied");
                    "End Date" := DeterminethisLeaveEndDate("Return Date");
                    MODIFY;
                END;
            end;
        }
        field(5; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                Month := DATE2DMY("Start Date", 2);
                Year := DATE2DMY("Start Date", 3);
                IF "Start Date" = 0D THEN BEGIN
                    "Return Date" := 0D;
                    EXIT;
                END ELSE BEGIN
                    IF DetermineIfIsNonWorking("Start Date") = TRUE THEN BEGIN
                        ;
                        ERROR('Start date must be a working day');
                    END;
                    VALIDATE("Days Applied");
                END;
            end;
        }
        field(6; "Return Date"; Date)
        {
            Caption = 'Return Date';
            Editable = false;
        }
        field(7; "Application Date"; Date)
        {
        }
        field(15; "Applicant Comments"; Text[250])
        {
        }
        field(17; "No series"; Code[30])
        {
        }
        field(28; Selected; Boolean)
        {
        }
        field(31; "Current Balance"; Decimal)
        {
        }
        field(3900; "End Date"; Date)
        {
            Editable = false;
        }
        field(3901; "Total Taken"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(3902; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3921; "E-mail Address"; Date)
        {
            Editable = false;
        }
        field(3924; "Entry No"; Integer)
        {
        }
        field(3929; "Start Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(3936; "Cell Phone Number"; Text[50])
        {
        }
        field(3937; "Request Leave Allowance"; Boolean)
        {
        }
        field(3939; Picture; BLOB)
        {
        }
        field(3940; Names; Text[100])
        {
        }
        field(3942; "Leave Allowance Entittlement"; Boolean)
        {
        }
        field(3943; "Leave Allowance Amount"; Decimal)
        {
        }
        field(3945; "Details of Examination"; Text[200])
        {
        }
        field(3947; "Date of Exam"; Date)
        {
        }
        field(3949; Reliever; Code[50])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin
                //DISPLAY RELEIVERS NAME
                IF HREmp.GET(Reliever) THEN
                    "Reliever Name" := HREmp.FullName;
            end;
        }
        field(3950; "Reliever Name"; Text[100])
        {
        }
        field(3952; Description; Text[30])
        {
        }
        field(3956; "Number of Previous Attempts"; Text[200])
        {
        }
        field(3961; "Employee No"; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin
                HREmp.RESET;
                HREmp.GET("Employee No");
                Names := HREmp."First Name" + ' ' + HREmp."Last Name";
            end;
        }
        field(3969; "Responsibility Center"; Code[10])
        {
            //TableRelation = "FIN-Responsibility Center".Code;
        }
        field(3970; "Approved days"; Integer)
        {

            trigger OnValidate()
            begin
                IF "Approved days" > "Days Applied" THEN
                    ERROR(TEXT001);
            end;
        }
        field(3971; "Annual Leave Account"; Decimal)
        {
        }
        field(3972; "Compassionate Leave Acc."; Decimal)
        {
        }
        field(3973; "Maternity Leave Acc."; Decimal)
        {
        }
        field(3974; "Paternity Leave Acc."; Decimal)
        {
        }
        field(3975; "Sick Leave Acc."; Decimal)
        {
        }
        field(3976; "Study Leave Acc"; Decimal)
        {
        }
        field(3977; OffDays; Decimal)
        {
        }
        field(3978; Month; Integer)
        {
        }
        field(3979; Year; Integer)
        {
        }
        field(3980; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
    }

    keys
    {
        key(Key1; "Application Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Application Code" = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup."Leave Planner Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Planner Nos.", xRec."No series", 0D, "Application Code", "No series");
        END;
    end;

    var
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit 396;
        UserSetup: Record 91;
        HREmp: Record "HRM-Employee C";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HRM-Leave Types";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        SMTP: Codeunit "Email Message";
        LeaveGjline: Record "HRM-Employee Leave Journal";
        "LineNo.": Integer;
        ApprovalComments: Record 455;
        URL: Text[500];
        sDate: Record 2000000007;
        Customized: Record "Customized Calendar Change";
        //HREmailParameters: Record 50562;
        //HRLeavePeriods: Record 50548;
        //HRJournalBatch: Record 50547;
        LeaveHeader: Record "HR Leave Planner Header";
        Names: Text[100];
        TEXT001: Label 'Days Approved cannot be more than applied days';

    procedure DetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    begin
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        REPEAT
            IF DetermineIfIncludesNonWorking("Leave Type") = FALSE THEN BEGIN
                fReturnDate := CALCDATE('1D', fReturnDate);
                IF DetermineIfIsNonWorking(fReturnDate) THEN
                    varDaysApplied := varDaysApplied + 1
                ELSE
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied - 1
            END
            ELSE BEGIN
                fReturnDate := CALCDATE('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            END;
        UNTIL varDaysApplied = 0;
        EXIT(fReturnDate);
    end;

    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[10]): Boolean
    begin
        IF HRLeaveTypes.GET(fLeaveCode) THEN BEGIN
            IF HRLeaveTypes."Inclusive of Non Working Days" = TRUE THEN
                EXIT(TRUE);
        END;
    end;

    procedure DetermineIfIsNonWorking(var bcDate: Date) Isnonworking: Boolean
    begin
        /*
        HRSetup.FIND('-');
        HRSetup.TESTFIELD(HRSetup."Base Calendar");
        BaseCalendarChange.SETFILTER(BaseCalendarChange."Base Calendar Code",HRSetup."Base Calendar");
        BaseCalendarChange.SETRANGE(BaseCalendarChange.Date,bcDate);
        IF BaseCalendarChange.FIND('-') THEN BEGIN
        IF BaseCalendarChange.Nonworking = TRUE THEN
        //ERROR('Start date can only be a Working Day Date');
        EXIT(TRUE);
        END;
        */
        HRSetup.FIND('-');
        HRSetup.TESTFIELD(HRSetup."Base Calendar");
        BaseCalendarChange.SETFILTER(BaseCalendarChange."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendarChange.SETRANGE(BaseCalendarChange.Date, bcDate);
        IF BaseCalendarChange.FIND('-') THEN BEGIN
            IF BaseCalendarChange.NonWorking = TRUE THEN
                //ERROR('Start date can only be a Working Day Date');
                EXIT(TRUE);
        END;

    end;

    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    begin
        ReturnDateLoop := TRUE;
        fEndDate := fDate;
        IF fEndDate <> 0D THEN BEGIN
            fEndDate := CALCDATE('-1D', fEndDate);
            WHILE (ReturnDateLoop) DO BEGIN
                IF DetermineIfIsNonWorking(fEndDate) THEN
                    fEndDate := CALCDATE('-1D', fEndDate)
                ELSE
                    ReturnDateLoop := FALSE;
            END
        END;
        EXIT(fEndDate);
    end;

    procedure NotifyApplicant()
    begin
        HREmp.GET("Employee No");
        HREmp.TESTFIELD(HREmp."Company E-Mail");

        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        // HREmailParameters.RESET;
        // HREmailParameters.SETRANGE(HREmailParameters."Associate With", HREmailParameters."Associate With"::General);
        // IF HREmailParameters.FIND('-') THEN BEGIN

        /*
      HREmp.TESTFIELD(HREmp."Company E-Mail");
      SMTP.CreateMessage(HREmailParameters."Sender Name",HREmailParameters."Sender Address",HREmp."Company E-Mail",
      HREmailParameters.Subject,'Dear'+' '+ HREmp."Plan No." +' '+
      HREmailParameters.Body+' '+"Application Code"+' '+ HREmailParameters."Body 2",TRUE);
      SMTP.Send();

 */
        MESSAGE('Leave applicant has been notified successfully');
    END;


}

