table 52177860 "Training Evaluation Header"
{

    fields
    {
        field(1; "Training Evaluation No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Training Evaluation No." <> xRec."Training Evaluation No." then begin
                    HRSetup.Get;
                    HRSetup.TestField("Training Evaluation Nos");
                    NoSeriesManagement.TestManual(HRSetup."Training Evaluation Nos");
                end;
            end;
        }
        field(2; "Training Name"; Code[500])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Location"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Commencement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Duration; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Scheduled Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; UserID; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Personal No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            trigger Onvalidate()
            var
                Employee: Record Employee;
            begin
                if Employee.get("Personal No.") then
                    "Name of participant" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;

        }
        field(10; "Name of the participant"; Date)
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(11; Country; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Description; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Name of participant"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Training No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Request";

            trigger OnValidate()
            var
                TrainingNeed: Record "Training Request";
            begin
                TrainingNeed.SetRange("Request No.", "Training No.");
                IF TrainingNeed.findfirst THEN BEGIN
                    Description := TrainingNeed."Training Objectives";
                    "Training Name" := TrainingNeed."Training Objectives";
                    Location := TrainingNeed.Venue;
                    "Commencement Date" := TrainingNeed."Planned Start Date";
                    "Completion Date" := TrainingNeed."Planned End Date";
                END;
            end;
        }
        field(52; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = FILTER(false));

            trigger OnValidate()
            begin
                //  ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(53; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = FILTER(false));

            trigger OnValidate()
            begin

                //  ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(54; "Describe the courses/subjects"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Describe the courses/subjects covered';
        }
        field(55; "Usefulness of the Course"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Application of lesson learnt"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "List support you might need"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Improvement in job performance"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "List areas in job performance"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Ability to teach acquired"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = '"Ability to teach acquired" to other people';

        }
        field(61; "Adequacy of training provided"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Supervisor’s Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Training Evaluation No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        UserID := UserId;
        if "Training Evaluation No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Training Evaluation Nos");
            NoSeriesManagement.InitSeries(HRSetup."Training Evaluation Nos", xRec."No. Series", 0D, "Training Evaluation No.", "No. Series");
        end;

        if "User Setup".Get(UserId) then begin
            "User Setup".TestField("Employee No.");
            if Employee.Get("User Setup"."Employee No.") then begin
                "Personal No." := Employee."No.";
                "Name of participant" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        end;

    end;

    var
        Employee: Record Employee;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        HRSetup: Record "Human Resources Setup";
        "User Setup": Record "User Setup";

    local procedure GetEmpDetails(EmpNo: Code[20])
    var
        Employee: Record Employee;
    begin
        if Employee.Get(EmpNo) then begin
            "Name of participant" := (Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
        end;
    end;

}

