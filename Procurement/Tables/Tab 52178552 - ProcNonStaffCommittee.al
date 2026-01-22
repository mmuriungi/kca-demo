table 52178552 "Proc-Non Staff Committee"
{
    DrillDownPageId = "Proc-Non Staff Committee";
    LookupPageId = "Proc-Non Staff Committee";
    Caption = 'Non Staff Committee';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[50])
        {
            Caption = 'No';
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';
        }
        field(3; Email; Text[150])
        {
            Caption = 'Email';
        }
        field(4; "Phone"; Text[15])
        {
            Caption = 'Phone';
        }
        field(5; Designation; Text[250])
        {
            Caption = 'Designation';
        }
        field(6; "Institution From"; Text[250])
        {
            Caption = 'Institution From';
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; No, Name)
        {
        }
    }
}
