table 52177869 "System Roles"
{
    Caption = 'System Roles';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Role Name"; Code[100])
        {
            Caption = 'Role Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Role Name")
        {
            Clustered = true;
        }
    }

}
