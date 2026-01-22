table 52179086 "Legal Case Party"
{
    Caption = 'Legal Case Party';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            DataClassification = ToBeClassified;
            TableRelation = "Legal Case"."Case No.";
        }
        field(3; "Party Type"; Option)
        {
            Caption = 'Party Type';
            OptionMembers = " ",Plaintiff,Defendant,Petitioner,Respondent,Appellant,Appellee,"Third Party","Interested Party",Witness;
            OptionCaption = ' ,Plaintiff,Defendant,Petitioner,Respondent,Appellant,Appellee,Third Party,Interested Party,Witness';
            DataClassification = ToBeClassified;
        }
        field(4; "Party Name"; Text[100])
        {
            Caption = 'Party Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Party ID/Registration No."; Code[50])
        {
            Caption = 'Party ID/Registration No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Legal Representative"; Text[100])
        {
            Caption = 'Legal Representative';
            DataClassification = ToBeClassified;
        }
        field(7; "Law Firm"; Text[100])
        {
            Caption = 'Law Firm';
            DataClassification = ToBeClassified;
        }
        field(8; "Contact Person"; Text[100])
        {
            Caption = 'Contact Person';
            DataClassification = ToBeClassified;
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
        }
        field(10; Email; Text[100])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
        }
        field(11; Address; Text[250])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(12; "Is University Party"; Boolean)
        {
            Caption = 'Is University Party';
            DataClassification = ToBeClassified;
        }
        field(13; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";
        }
        field(14; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." WHERE("Customer Type" = CONST(Student));
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(SK1; "Case No.", "Party Type")
        {
        }
    }
}