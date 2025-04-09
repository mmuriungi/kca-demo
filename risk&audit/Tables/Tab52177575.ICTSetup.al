table 51352 "ICT Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Incidence Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(3; "Registry E-Mail"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Screenshot Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Security E-Mail"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Escalation E-mail"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Communication Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(8; "Communication E-Mail"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Registry BCC"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "System Access Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(11; "Property Issue  Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(12; "Laptop Issue  Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(13; "Change Request  Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(14; "Portal Reports File Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "SMS  Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(16; "SMS IIS Link"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "SMS Pass Key"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Public Web Client Link"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Email  Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(20; "Super User ID 1"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(21; "Super User ID 2"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(22; "Activate Post to KRA Logs"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Enable OTP Authentication"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

