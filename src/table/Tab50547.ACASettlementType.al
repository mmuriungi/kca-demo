table 50547 "ACA-Settlement Type"
{
    DrillDownPageID = "ACA-Settlement Types";
    LookupPageID = "ACA-Settlement Types";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
        }
        field(3; Remarks; Text[150])
        {
        }
        field(4; Installments; Boolean)
        {
        }
        field(5; "Tuition G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(6; "Reg. No Prefix"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

