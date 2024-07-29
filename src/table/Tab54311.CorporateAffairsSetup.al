table 54311 "Corporate Affairs Setup"
{
    Caption = 'Corprate Affairs Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(2; "First Executive Member"; Code[20])
        {
            Caption = 'First Executive Member';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(3; "Second Executive Member"; Code[20])
        {
            Caption = 'Second Executive Member';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(4; "Third Excutive Member"; Code[20])
        {
            Caption = 'Third Excutive Member';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(5; "Consultative committee"; Code[20])
        {
            Caption = 'Third Excutive Member';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(6; "CA Affair No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(7; "Feedback No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(8; "Receipt Of CSR"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(9; "Internal Audit No."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(10; "Work Plan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(11; "Employee Targets No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(12; "Complaint No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(13; "Audit Reporting No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(14; "CAR No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(15; "Audit No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(16; "CAP"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
