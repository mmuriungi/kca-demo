table 54901 "HMIS-Patient Ledger"
{
    //DrillDownPageID = 68179;
    //LookupPageID = 68179;

    fields
    {
        field(1; "Batch Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Patient No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Transaction No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Visit No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Transaction Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Section; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Registration,Triage,Consultation,Observation,Laboratory,Theater,External Referal,Internal Referal,Radiology,CCC Clinic,Awaiting Admision,Admitted,Discharged,Pharmacy,Appointment,Operation';
            OptionMembers = Registration,Triage,Consultation,Observation,Laboratory,Theater,"External Referal","Internal Referal",Radiology,"CCC Clinic","Awaiting Admision",Admitted,Discharged,Pharmacy,Appointment,Operation;
        }
        field(8; "Transaction Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Debit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Credit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Insurance Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Record Counts"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(13; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Registration,Triage,Consultation,Observation,Laboratory,Theater,External Referal,Internal Referal,Radiology,CCC Clinic,Awaiting Admision,Admitted,Discharged,Pharmacy,Appointment,Operation';
            OptionMembers = Registration,Triage,Consultation,Observation,Laboratory,Theater,"External Referal","Internal Referal",Radiology,"CCC Clinic","Awaiting Admision",Admitted,Discharged,Pharmacy,Appointment,Operation;
        }
        field(15; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Record Counts", "Batch Date", "Patient No.", "Transaction No.", "Visit No.")
        {
        }
    }

    fieldgroups
    {
    }
}

