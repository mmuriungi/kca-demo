table 54828 "HMS-Labs"
{
    //LookupPageID = "ACA-Admission Recognised Inst.";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Name; Text[200])
        {
        }
        field(3; Remarks; Text[250])
        {
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

