table 54884 "HMS-Test Package"
{
    //LookupPageID = "HRM-Employee Kin Card";

    fields
    {
        field(1; Name; Code[200])
        {
        }
        field(3; "Lab Remarks"; Text[200])
        {
            TableRelation = "HMS-Lab Remarks".Name;
        }
        field(4; Method; Code[50])
        {
            TableRelation = "HMS-Methods".Code;
        }
        field(5; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

