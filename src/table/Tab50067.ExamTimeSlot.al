table 50067 "Exam Time Slot"
{
    Caption = 'Exam Time Slot';
    DataClassification = ToBeClassified;
    LookupPageId = "Exam Time Slots";
    DrillDownPageId = "Exam Time Slots";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Start Time"; Time)
        {
            Caption = 'Start Time';

            trigger OnValidate()
            begin
                ValidateStartTime();
            end;
        }
        field(4; "End Time"; Time)
        {
            Caption = 'End Time';

            trigger OnValidate()
            begin
                ValidateEndTime();
            end;
        }
        field(5; "Duration (Hours)"; Decimal)
        {
            Caption = 'Duration (Hours)';
            DecimalPlaces = 2;
            Editable = false;
        }
        field(6; "Session Type"; Option)
        {
            Caption = 'Session Type';
            OptionMembers = Morning,Afternoon,Evening;
            OptionCaption = 'Morning,Afternoon,Evening';
        }
        field(7; Active; Boolean)
        {
            Caption = 'Active';
            InitValue = true;
        }
        field(8; "Default Break Time (Minutes)"; Integer)
        {
            Caption = 'Default Break Time (Minutes)';
            MinValue = 0;
            InitValue = 15;
        }
        field(9; "Setup Time Required (Minutes)"; Integer)
        {
            Caption = 'Setup Time Required (Minutes)';
            MinValue = 0;
            InitValue = 30;
        }
        field(10; "Max Continuous Hours"; Decimal)
        {
            Caption = 'Maximum Continuous Hours';
            DecimalPlaces = 2;
            MinValue = 0;
            InitValue = 3;
        }
        field(11; "Day of Week"; enum "Day of Week")
        {
            Caption = 'Day of Week';
        }
        field(12; "Valid From Date"; Date)
        {
            Caption = 'Valid From Date';

            trigger OnValidate()
            begin
                ValidateDateRange();
            end;
        }
        field(13; "Valid To Date"; Date)
        {
            Caption = 'Valid To Date';

            trigger OnValidate()
            begin
                ValidateDateRange();
            end;
        }
        field(14; "Semester Code"; Code[25])
        {
            Caption = 'Semester Code';
            TableRelation = "ACA-Semesters";

            trigger OnValidate()
            begin
                UpdateSemesterDates();
            end;
        }
        field(15; "Room Type Required"; Text[50])
        {
            Caption = 'Room Type Required';
            // For specific exam requirements (e.g., Lab, Computer Room)
        }
        field(16; "Maximum Students Per Room"; Integer)
        {
            Caption = 'Maximum Students Per Room';
            MinValue = 0;
        }
        field(17; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(18; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(19; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            Editable = false;
        }
        field(20; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(Key1; "Session Type", "Start Time")
        {
        }
        key(Key2; "Day of Week", "Start Time")
        {
        }
        key(Key3; "Valid From Date", "Valid To Date")
        {
        }
        key(Key4; "Semester Code", "Day of Week")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Creation Date" := CurrentDateTime;
        UpdateLastModified();
        CalculateDuration();
    end;

    trigger OnModify()
    begin
        UpdateLastModified();
        CalculateDuration();
    end;

    var
        Semester: Record "ACA-Semesters";

    local procedure ValidateStartTime()
    begin
        if "Start Time" = 0T then
            exit;

        if "End Time" <> 0T then
            CalculateDuration();

        case true of
            "Start Time" < 120000T:
                "Session Type" := "Session Type"::Morning;
            "Start Time" < 170000T:
                "Session Type" := "Session Type"::Afternoon;
            else
                "Session Type" := "Session Type"::Evening;
        end;

        if ("Start Time" < 080000T) or ("Start Time" > 200000T) then
            Error('Start time must be between 8:00 AM and 8:00 PM');
    end;

    local procedure ValidateEndTime()
    begin
        if "End Time" = 0T then
            exit;

        if "Start Time" = 0T then
            Error('Please enter Start Time first');

        if "End Time" <= "Start Time" then
            Error('End Time must be later than Start Time');

        CalculateDuration();

        if ("End Time" < 080000T) or ("End Time" > 200000T) then
            Error('End time must be between 8:00 AM and 8:00 PM');

        if "Duration (Hours)" > "Max Continuous Hours" then
            Error('Duration exceeds maximum continuous hours of %1', "Max Continuous Hours");
    end;

    local procedure ValidateDateRange()
    begin
        if ("Valid From Date" = 0D) or ("Valid To Date" = 0D) then
            exit;

        if "Valid To Date" < "Valid From Date" then
            Error('Valid To Date must be after Valid From Date');

        if "Semester Code" <> '' then begin
            if Semester.Get("Semester Code") then begin
                if ("Valid From Date" < Semester."Exam Start Date") or
                   ("Valid To Date" > Semester."Exam End Date") then
                    Error('Date range must be within semester exam period (%1 to %2)',
                          Semester."Exam Start Date",
                          Semester."Exam End Date");
            end;
        end;

        ValidateWeekday();
    end;

    local procedure ValidateWeekday()
    var
        StartDayOfWeek: Integer;
        EndDayOfWeek: Integer;
    begin
        if "Valid From Date" = 0D then
            exit;

        StartDayOfWeek := Date2DWY("Valid From Date", 1);
        if "Valid To Date" <> 0D then
            EndDayOfWeek := Date2DWY("Valid To Date", 1);

        if (StartDayOfWeek > 5) or (EndDayOfWeek > 5) then
            Error('Exam dates must be on weekdays (Monday to Friday)');

        if "Day of Week".AsInteger() + 1 <> StartDayOfWeek then
            Error('Day of week does not match the selected date');
    end;

    local procedure UpdateSemesterDates()
    begin
        if "Semester Code" = '' then
            exit;

        if Semester.Get("Semester Code") then begin
            Semester.TestField("Exam Start Date");
            Semester.TestField("Exam End Date");

            "Valid From Date" := Semester."Exam Start Date";
            "Valid To Date" := Semester."Exam End Date";
            ValidateDateRange();
        end;
    end;

    local procedure CalculateDuration()
    var
        DurationMS: Duration;
    begin
        if ("Start Time" = 0T) or ("End Time" = 0T) then
            exit;

        DurationMS := "End Time" - "Start Time";
        "Duration (Hours)" := DurationMS / 3600000;
    end;

    local procedure UpdateLastModified()
    begin
        "Last Modified By" := UserId;
        "Last Modified Date" := CurrentDateTime;
    end;
}