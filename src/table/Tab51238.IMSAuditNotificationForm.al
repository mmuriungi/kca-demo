table 51238 "IMS Audit Notification Form"
{
    Caption = 'IMS Audit Notification Form';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Audit No."; Code[50])
        {
            Caption = 'Audit No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Purpose of audit"; Text[250])
        {
            Caption = 'Purpose of audit';
            DataClassification = ToBeClassified;
        }
        field(3; "Scope of the audit"; Text[250])
        {
            Caption = 'Scope of the audit';
            DataClassification = ToBeClassified;
        }
        field(4; "Basis of audit"; Text[250])
        {
            Caption = 'Basis of audit';
            DataClassification = ToBeClassified;
        }
        field(5; "Audit date:"; Date)
        {
            Caption = 'Audit date:';
            DataClassification = ToBeClassified;
        }
        field(6; "Centre to be audited"; Code[50])
        {
            Caption = 'Centre to be audited';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, "Centre to be audited");
                IF DimVal.FIND('-') THEN
                    "Region Name" := DimVal.Name
            end;
        }
        field(7; "Region Name"; Text[250])
        {
            Caption = 'Region Name';
            DataClassification = ToBeClassified;
        }



    }
    keys
    {
        key(PK; "Audit No.")
        {
            Clustered = true;
        }
    }
}
