table 54310 "Employee Perfomance Target"

{
    Caption = 'Employee Perfomance Target';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CorporateAffairsSetup.Get();
                    NoSeriesMgt.TestManual(CorporateAffairsSetup."Employee Targets No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "HRM-Employee C";
            DataClassification = ToBeClassified;
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
        }
        field(5; "Target Year"; Code[20])
        {
            Caption = 'Target Year';
            DataClassification = ToBeClassified;
            TableRelation = "WorkPlan Year";
        }
        field(6; Status; Option)
        {
            Editable = false;
            Caption = 'Status';
            OptionCaption = 'Open,Pending Approval,Released';
            OptionMembers = Open,"Pending Approval",Released;
        }
        field(7; Level; Option)
        {
            Editable = false;
            Caption = 'Level';
            OptionMembers = Target,Appraisal,Report;
        }
        field(8; "No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            CorporateAffairsSetup.Get();
            CorporateAffairsSetup.TestField("Employee Targets No.");
            NoSeriesMgt.InitSeries(CorporateAffairsSetup."Employee Targets No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        NoSeriesMgt: codeunit NoSeriesManagement;
        CorporateAffairsSetup: Record "Corporate Affairs Setup";
}
