table 52177871 "Compliance Reporting Lines"
{
    Caption = 'Compliance Reporting Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Sub section"; Code[20])
        {
            Caption = 'Sub section';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Blob)
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Relevant Legislation"; Code[100])
        {
            Caption = 'Relevant Legislation';
            DataClassification = ToBeClassified;
        }
        field(5; "Status of Compliance"; Option)
        {
            Caption = 'Status of Compliance';
            OptionMembers = " ",Compliant,"Non-Compliant";
            OptionCaption = ' ,Compliant,Non-Compliant';
            DataClassification = ToBeClassified;
        }
        field(6; "Comments on Non compliance"; Text[2048])
        {
            Caption = 'Comments on Non compliance';
            DataClassification = ToBeClassified;
        }
        field(7; "Action to rectify non-comp"; Text[2048])
        {
            Caption = 'Action to rectify non-compliance';
            DataClassification = ToBeClassified;
        }
        field(8; Responsibilities; Text[2048])
        {
            Caption = 'Responsibilities';
            DataClassification = ToBeClassified;
        }
        field(9; "Due diligence"; Option)
        {
            OptionMembers = "",Yes,No;
            OptionCaption = ' ,Yes,No';
            Caption = 'KMRC to conduct due diligence';
            DataClassification = ToBeClassified;
        }
        field(10; "Line No."; integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(11; "Issue"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Comments; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }
    }

}
