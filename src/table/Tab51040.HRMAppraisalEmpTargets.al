table 51040 "HRM-Appraisal Emp. Targets"
{
    DrillDownPageID = "HRM-Appraisee Self Targets";
    LookupPageID = "HRM-Appraisee Self Targets";

    fields
    {
        field(1; "Reg. Transacton ID"; Code[20])
        {
            Editable = true;
        }
        field(2; "PF. No."; Code[20])
        {
            Editable = true;
            NotBlank = true;
        }
        field(3; "Appraisal Period Code"; Code[20])
        {
            Editable = true;
            NotBlank = false;
        }
        field(4; "Appraisal Job Code"; Code[20])
        {
            Editable = true;
            NotBlank = false;

            trigger OnValidate()
            begin

                CReg.Reset;
                CReg.SetRange(CReg."PF No.", "PF. No.");
                if CReg.Find('+') then begin
                    "Reg. Transacton ID" := CReg."Reg. Transacton ID";
                end;
                coreg.Reset;
                coreg.SetRange(coreg."Reg. Transacton ID", "Reg. Transacton ID");
                if coreg.Find('-') then begin
                    "Appraisal Period Code" := coreg."Appraisal Period Code";
                    "Appraisal year Code" := coreg."Appraisal Year Code";
                end;
            end;
        }
        field(7; "Appraisal Target Code"; Code[20])
        {
            Editable = true;
            NotBlank = true;
        }
        field(13; Taken; Boolean)
        {
        }
        field(17; "Total Score"; Decimal)
        {
            Editable = false;
        }
        field(61; "Final Score"; Decimal)
        {
            FieldClass = Normal;
        }
        field(62; "Created by"; Code[50])
        {
        }
        field(63; "Edited By"; Code[50])
        {
        }
        field(64; "Date created"; Date)
        {
        }
        field(65; "Date Edited"; Date)
        {
        }
        field(67; "Total Marks"; Decimal)
        {
        }
        field(72; "Entry No."; Integer)
        {
        }
        field(20016; "Staff Name"; Text[100])
        {
        }
        field(20023; "Individual Target"; Decimal)
        {
        }
        field(50005; "Agreed Performance Targets"; Text[100])
        {
            NotBlank = true;
        }
        field(50015; "Appraisal year Code"; Code[20])
        {
        }
        field(50085; "Supervisor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "Supervisor Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50088; "Individual Target Grade"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50089; "Individual Target Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50097; "Agreed Score"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Closed := true;
            end;
        }
        field(50098; "Agreed Score Grade"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Agreed Score Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Employee,Supervisor,HR';
            OptionMembers = Employee,Supervisor,HR;
        }
        field(50103; "Expected Performance Indicator"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Mid Year Review (Remarks)"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Appraisal Job Code", "Appraisal Target Code", "Appraisal Period Code", "Reg. Transacton ID", "PF. No.", "Appraisal year Code", "Supervisor No.")
        {
            SumIndexFields = "Final Score";
        }
        key(Key2; "PF. No.", "Appraisal Target Code")
        {
        }
        key(Key3; "PF. No.", "Final Score")
        {
        }
        key(Key4; "Appraisal Target Code")
        {
        }
        key(Key5; "Final Score")
        {
        }
        key(Key6; "Appraisal Period Code")
        {
        }
        key(Key7; "Total Marks")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if not UserSetup.Get(UserId) then Error('Invalid User Account!');
        UserSetup.TestField("Employee No.");
        "PF. No." := UserSetup."Employee No.";
        if HRMEmployeeC.Get(UserSetup."Employee No.") then "Appraisal Job Code" := HRMEmployeeC."Job Title";
        HRMAppraisalYears.Reset;
        HRMAppraisalYears.SetRange(Closed, false);
        if not HRMAppraisalYears.Find('-') then Error('There is no open appraisal year.');
        "Appraisal year Code" := HRMAppraisalYears.Code;

        HRMAppraisalPeriods.Reset;
        HRMAppraisalPeriods.SetRange("Period Code", HRMAppraisalYears.Code);
        //HRMAppraisalPeriods.SETRANGE(Closed,FALSE);
        if not HRMAppraisalPeriods.Find('-') then Error('There is no open period in the filters');
        "Appraisal Period Code" := HRMAppraisalPeriods."Period Code";
        "Created by" := UserId;
        "Date created" := Today;
    end;

    var
        coreg: Record "HRM-Appraisal Registration";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenSetup: Record "HRM-Appraisal Gen. Setup";
        TotalCost: Decimal;
        RecFound: Boolean;
        CReg: Record "HRM-Appraisal Registration";
        UnitsS: Record "HRM-Appraisal Targets";
        StudUnits: Record "HRM-Appraisal Emp. Targets";
        StudUnits2: Record "HRM-Appraisal Emp. Targets";
        UTaken: Integer;
        UFound: Boolean;
        CourseReg: Record "HRM-Appraisal Registration";
        Prog: Record "HRM-Appraisal Jobs";
        ExamR: Record "HRM-Appraisal Results";
        Studnits: Record "HRM-Appraisal Emp. Targets";
        ExamSetup: Record "HRM-Appraisal Res. Setup";
        HRMEmployeeC: Record "HRM-Employee C";
        UserSetup: Record "HRM-Setup";
        HRMAppraisalYears: Record "HRM-Appraisal Years";
        HRMAppraisalPeriods: Record "HRM-Appraisal Periods Set";
}

