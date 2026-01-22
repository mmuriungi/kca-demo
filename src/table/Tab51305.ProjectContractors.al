table 51305 "Project Contractors"
{
    Caption = 'Project Contractors';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Project No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Project";
        }
        field(2; "Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "ID No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Company; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        //Email,phone number, and address
        field(5; "Email"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Phone Number"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Project No")
        {
            Clustered = true;
        }
    }
}
