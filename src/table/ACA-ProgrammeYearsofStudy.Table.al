#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 77700 "ACA-Programme Years of Study"
{

    fields
    {
        field(1;"Programme Code";Code[20])
        {
        }
        field(2;"Year of Study";Integer)
        {
        }
        field(3;"Is FInal Year of Study";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Programme Code","Year of Study")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

