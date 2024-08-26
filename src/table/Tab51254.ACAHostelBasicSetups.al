#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51254 "ACA-Hostel Basic Setups"
{

    fields
    {
        field(1;"Current Academic Year";Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(2;"Current Semester";Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(3;Rec_Id;Integer)
        {
        }
    }

    keys
    {
        key(Key1;Rec_Id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

