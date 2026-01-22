table 51240 "QA Audit Header"
{
    Caption = 'QA Audit Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Audit Header No."; Code[30])
        {
            Caption = 'Audit Header';
            DataClassification = ToBeClassified;
        }
        field(2; "Audit No."; Code[30])
        {
            Caption = 'Audit No.';
            TableRelation = "IMS Audit Notification Form"."Audit No.";

            trigger OnValidate()
            var
                IMSAudit: Record "IMS Audit Notification Form";
            begin
                IMSAudit.RESET;
                IMSAudit.SETRANGE(IMSAudit."Audit No.", "Audit No.");
                IF IMSAudit.FIND('-') THEN
                    "Centre to be audited" := IMSAudit."Centre to be audited";

            end;
        }
        field(3; "Centre to be Audited"; Code[30])
        {
            Caption = 'Center to be Audited';
            //TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, "Centre to be Audited");
                IF DimVal.FIND('-') THEN
                    "Region Name" := DimVal.Name
            end;
        }
        field(4; "Region Name"; Text[100])
        {
            Caption = 'Region Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Audit Criteria"; Code[30])
        {
            Caption = 'Audit Criteria';
            TableRelation = "Audit Risk Actions";
        }
        field(6; "Audit team leader"; Code[30])
        {
            Caption = 'Audit Team Leader';

            TableRelation = "HRM-Employee C"."No.";
            trigger OnValidate()
            var
                HRMEmp: Record "HRM-Employee C";
            begin
                if HRMEmp.Get("Audit team leader") then begin
                    "Audit team leader Name" := HRMEmp.FullName;

                end;
            end;
        }
        field(7; "Audit team leader Name"; Text[100])
        {
            Caption = 'Audit team leader Name';
            DataClassification = ToBeClassified;
        }
        field(8; "Audit Summary"; Text[250])
        {
            Caption = 'Audit Summary';
            DataClassification = ToBeClassified;
        }
        field(9; "Audit Status"; Option)
        {
            OptionMembers = New,Ongoing,Closed;
        }
    }

    keys
    {
        key(PK; "Audit Header No.")
        {
            Clustered = true;
        }
    }
}
