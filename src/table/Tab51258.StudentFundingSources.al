#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51258 "Student_Funding_Sources"
{
    // //DrillDownPageID = UnknownPage77386;
    // //LookupPageID = UnknownPage77386;

    fields
    {
        field(1; "Source Code"; Code[20])
        {
        }
        field(2; "Source Description"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Source Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

