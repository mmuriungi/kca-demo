table 50639 "ACA-Defined Units per YoS"
{

    fields
    {
        field(1; Programmes; Code[20])
        {
        }
        field(2; "Year of Study"; Integer)
        {
        }
        field(3; "Number of Units"; Integer)
        {
        }
        field(39; Options; Code[20])
        {
            TableRelation = "ACA-Programme Options".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        //aca
        field(40; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year";
        }
    }

    keys
    {
        key(Key1; Programmes, "Year of Study", Options,"Academic Year")
        {
        }
    }

    fieldgroups
    {
    }
}

