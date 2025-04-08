table 52177868 "System Access Lines"
{
    Caption = 'System Access Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Role Name"; Code[50])
        {
            Caption = 'Role Name';
            DataClassification = ToBeClassified;
            Tablerelation = "System Roles";
        }
        field(3; "Appropriate Role"; Boolean)
        {
            Caption = 'Appropriate Role';
            DataClassification = ToBeClassified;
        }
        field(4; "Date of Receipt"; Date)
        {
            Caption = 'Date of Receipt';
            DataClassification = ToBeClassified;
        }
        field(5; "Date of Access revocation"; Date)
        {
            Caption = 'Date of Access revocation';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Role Name")
        {
            Clustered = true;
        }
    }

}
