#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 61627 "ACA-Hostel Reservation Lines"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No";
        }
        field(4; "Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Ledger"."Room No" where("Hostel No" = field("Hostel No"));
        }
        field(5; "Space No"; Code[20])
        {
            TableRelation = "ACA-Hostel Ledger"."Space No" where("Hostel No" = field("Hostel No"),
                                                                  "Room No" = field("Room No"));
        }
    }

    keys
    {
        key(Key1; "Code", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

