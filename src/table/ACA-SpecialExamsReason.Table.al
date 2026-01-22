#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 78023 "ACA-Special Exams Reason"
{
    DrillDownPageID = "ACA-Special Exams Reasons";
    LookupPageID = "ACA-Special Exams Reasons";

    fields
    {
        field(1; "Reason Code"; Code[25])
        {
        }
        field(2; Description; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Reason Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

