table 51239 "QA Audit Team"
{
    Caption = 'QA Audit Team';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Audit No."; Code[50])
        {
            Caption = 'Audit No';
            DataClassification = ToBeClassified;
        }
        field(2; "Staff No."; Code[50])
        {
            Caption = 'Staff No';
            TableRelation = "HRM-Employee C"."No.";
            trigger OnValidate()
            var
                HRMEmp: Record "HRM-Employee C";
            begin
                if HRMEmp.Get("Staff No.") then begin
                    "Staff Name" := HRMEmp.FullName;
                    "Center Code" := HRMEmp."Cost Center Code";
                end;
            end;
        }
        field(3; "Staff Name"; Text[250])
        {
            Caption = 'Staff Name';
        }
        field(4; "Center Code"; Code[30])
        {
            Caption = 'Center Code';
        }
    }
    keys
    {
        key(PK; "Audit No.", "Staff No.")
        {
            Clustered = true;
        }
    }
}
