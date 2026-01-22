table 52179087 "Legal Court Hearing"
{
    Caption = 'Legal Court Hearing';
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
        field(3; "Hearing Date"; Date)
        {
            Caption = 'Hearing Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Hearing Time"; Time)
        {
            Caption = 'Hearing Time';
            DataClassification = ToBeClassified;
        }
        field(5; "Hearing Type"; Option)
        {
            Caption = 'Hearing Type';
            OptionMembers = " ",Mention,"Pre-Trial","Main Hearing",Ruling,Judgment,Sentencing,"Status Conference",Motion,Appeal;
            OptionCaption = ' ,Mention,Pre-Trial,Main Hearing,Ruling,Judgment,Sentencing,Status Conference,Motion,Appeal';
            DataClassification = ToBeClassified;
        }
        field(6; "Court Room"; Text[50])
        {
            Caption = 'Court Room';
            DataClassification = ToBeClassified;
        }
        field(7; "Presiding Judge"; Text[100])
        {
            Caption = 'Presiding Judge';
            DataClassification = ToBeClassified;
        }
        field(8; "Hearing Outcome"; Text[250])
        {
            Caption = 'Hearing Outcome';
            DataClassification = ToBeClassified;
        }
        field(9; "Next Hearing Date"; Date)
        {
            Caption = 'Next Hearing Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Legal Counsel Present"; Text[250])
        {
            Caption = 'Legal Counsel Present';
            DataClassification = ToBeClassified;
        }
        field(11; "Court Orders"; Blob)
        {
            Caption = 'Court Orders';
            DataClassification = ToBeClassified;
        }
        field(12; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Scheduled,Completed,Adjourned,Cancelled;
            OptionCaption = 'Scheduled,Completed,Adjourned,Cancelled';
            DataClassification = ToBeClassified;
        }
        field(13; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Date Created"; DateTime)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(SK1; "Case No.", "Hearing Date")
        {
        }
        key(SK2; "Hearing Date", Status)
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Date Created" := CurrentDateTime;
    end;
}