table 50131 "Assumptions_Definitions Lines"
{
    Caption = 'Assumptions & Definitions Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[50])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Quantitative","Qualitative";
            OptionCaption = ' ,Quantitative,Qualitative';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Assumption Type"; Option)
        {
            Caption = 'Assumption Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Score Parameter,Main Heading,Main Heading End,Sub-Heading,Sub-Heading End';
            OptionMembers = "Score Parameter","Objective Heading","Objective Heading End","Sub-Heading","Sub-Heading End";
        }
        field(5; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Full Score"; Decimal)
        {
            Caption = 'Full Score';
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(7; "Score Per Option"; Decimal)
        {
            Caption = 'Score Per Option';
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(8; "Score Per Option (SACCOs)"; Decimal)
        {
            Caption = 'Score Per Option (SACCOs)';
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(9; Indentation; Integer)
        {
            Caption = 'Indentation';
            DataClassification = ToBeClassified;
        }

        field(10; Indent; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Document No.", Type, "Line No.")
        {
            Clustered = true;
        }
    }

}
