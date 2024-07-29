table 55413 "Audit-Risk Treatment Act. Step"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Risk Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Risk Treatment Action"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Verified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Verified Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Verified By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; TreatmentCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Budgeted Amount"; Decimal)
        {
            FieldClass = Normal;
        }
    }

    keys
    {
        key(Key1; No, "Risk Code", TreatmentCode)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

