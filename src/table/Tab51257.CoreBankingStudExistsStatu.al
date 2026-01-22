#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51257 "Core_Banking_Stud_Exists_Statu"
{

    fields
    {
        field(1; "Core_Banking Status"; Option)
        {
            OptionCaption = ' ,Student,KUCCPS Import';
            OptionMembers = " ",Student,"KUCCPS Import";
        }
        field(2; "Exists in Customer"; Boolean)
        {
        }
        field(3; "Exists in KUCCPS Import"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Core_Banking Status")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

