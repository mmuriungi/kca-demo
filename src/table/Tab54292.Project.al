table 54292 Project
{
    Caption = 'Project';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(56; user; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Project Type"; Enum "Project Types")
        {
            Caption = 'Project Type';
        }
        field(4; "Contract Summary"; Text[1000])
        {
            Caption = 'Contract Summary';
        }
        field(5; "Perfomance Bond"; Code[20])
        {
            Caption = 'Perfomance Bond';
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(7; "Expected End Date"; Date)
        {
            Caption = 'Expected End Date';
        }
        field(8; "Date Created"; Date)
        {
            Caption = 'Date Created';
            Editable = false;
        }
        field(9; "Created by"; Code[20])
        {
            Caption = 'Created by';
            Editable = false;
        }
        field(10; Status; Option)
        {
            OptionMembers = Open,Pending,Approved,Closed,Cancelled,InProgress,Rejected,Completed,Scheduled,Posted;
            Caption = 'Status';
            Editable = false;
        }
        field(17; Requester; code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";
            NotBlank = true;

            trigger OnValidate()
            var
                hrm: Record "HRM-Employee C";
                FullName: Text[100];
            begin
                if hrm.Get("Requester") then begin
                    // Concatenate First Name, Middle Name, and Last Name with spaces
                    FullName := hrm."First Name";

                    if not IsNullOrEmpty(hrm."Middle Name") then
                        FullName := FullName + ' ' + hrm."Middle Name";

                    if not IsNullOrEmpty(hrm."Last Name") then
                        FullName := FullName + ' ' + hrm."Last Name";

                    rec."Requester Name" := FullName;
                    rec."Department Code" := hrm."Department Code";
                    rec.Department := hrm."Department Name";
                    rec."E-Mail" := hrm."Company E-Mail";
                    rec."Phone No." := hrm."Cellular Phone Number";

                    // No need to call rec.Modify() in OnValidate trigger
                end;
            end;

            // Helper function to check if a string is null or empty

        }
        field(18; "Requester Name"; code[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(78; "Phone No."; Code[15])
        {
            Caption = 'Phone No.';
            Editable = false;
        }
        field(36; "E-MAIL"; code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Department Code"; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; Department; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(15; "Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
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
    var
        EstateSetup: Record "Estates Setup";
        NoSeriesMgnt: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            EstateSetup.Get();
            EstateSetup.TestField("Project No.");
            NoSeriesMgnt.InitSeries(EstateSetup."Project No.", EstateSetup."Project No.", Today, "No.", EstateSetup."Project No.");
            "Date Created" := Today;
            "Created by" := UserId;
        end;
    end;

    procedure IsNullOrEmpty(Value: Text): Boolean;
    begin
        exit(Value = '');
    end;

}
