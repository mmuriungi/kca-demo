table 51015 "Utility Bill"
{
    Caption = 'Utility Bill';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; Description; Text[350])
        {
            Caption = 'Description';
        }
        field(3; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }
        field(4; Creator; Code[20])
        {
            Caption = 'Creator';
        }
        field(5; "Dept. Code"; Code[20])
        {
            Caption = 'Dept. Code';
        }
        field(6; "Department Name"; Text[200])
        {
            Caption = 'Department Name';
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(8; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(9; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionMembers = Open,Pending,Approved,Cancelled,Posted;
        }
        field(10; "Bill Type"; Enum Bills)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Tenant No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor where("Vendor Posting Group" = const('TENANT'));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Tenant.Reset();
                if Tenant.Get("Tenant No.") then begin
                    "Tenant Name" := Tenant.Name;
                    "Tenant E-Mail" := Tenant."E-Mail";
                    "Tanant Phone No." := Tenant."Phone No.";
                end;
            end;
        }
        field(12; "Tenant Name"; Text[550])
        {
            Editable = false;
        }
        field(13; "Tenant E-Mail"; Text[150])
        {
            ExtendedDatatype = EMail;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                EstatesMgnt.ValidateEmail("Tenant E-Mail");
            end;
        }
        field(14; "Tanant Phone No."; Text[50])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
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
            EstateSetup.TestField("Bill No.");
            NoSeriesMgnt.InitSeries(EstateSetup."Bill No.", EstateSetup."Bill No.", Today, "No.", EstateSetup."Bill No.");
            "Date Created" := Today;
            Creator := UserId;
        end;
    end;

    var
        Tenant: Record Vendor;
        EstatesMgnt: Codeunit "Estates Management";
        E: Record Employee;

}
