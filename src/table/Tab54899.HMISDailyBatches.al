table 54899 "HMIS-Daily Batches"
{

    fields
    {
        field(1; "Batch Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Time Created"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Closed';
            OptionMembers = New,Closed;
        }
        field(5; "Date/Time Closed"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Check-in Exists (OPT)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Check-In Exists (IPT)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Total Patiens"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Patients in OPT"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Patient in IPT"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Total Billings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Total Receipts"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Patients at Registration"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Patients at Triage"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Patients on Consultation"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Patients at Laboratory"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Patients In Theatre"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "External Referals"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Internal Referals"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Discharged Today"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Deceased Today"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Batch Date")
        {
        }
    }

    fieldgroups
    {
    }
}

