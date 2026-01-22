table 51221 "Audit-Risk analysis Lines"
{

    fields
    {
        field(1; No; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Departmant Name"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Session; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Likelihood; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Impact; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Overall Rating"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Academic Year"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Modified By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Modified On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Risks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Causes; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Risk Action"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Responsible Persons"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

