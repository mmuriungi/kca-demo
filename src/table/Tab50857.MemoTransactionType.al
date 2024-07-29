table 50857 "Memo-Transaction Type"
{
    DrillDownPageID = "Memo Transaction Types List1";
    LookupPageID = "Memo Transaction Types List1";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Transaction Type Desc."; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Is Taxable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

