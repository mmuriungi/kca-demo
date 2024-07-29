table 54851 "HMS-Patients Medical History"
{
    //LookupPageID = "ACA-Semester Card";

    fields
    {
        field(1; "Patient No"; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; Description; Text[200])
        {
        }
        field(4; Refference; Text[200])
        {
        }
        field(5; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Patient No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

