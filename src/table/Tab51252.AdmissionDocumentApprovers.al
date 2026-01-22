#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51252 "Admission Document Approvers"
{
    //DrillDownPageID = UnknownPage77362;
    //LookupPageID = UnknownPage77362;

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
        }
        field(2; "Document Code"; Code[50])
        {
        }
        field(3; "Approved ID"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
    }

    keys
    {
        key(Key1; "Academic Year", "Document Code", "Approved ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

