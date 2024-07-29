table 54836 "HMS-Observation Signs"
{

    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            TableRelation = "HMS-Treatment Form Header"."Treatment No.";
        }
        field(2; "Sign Code"; Code[20])
        {
            TableRelation = "HMS-Signs Setup"."Sign Code" WHERE(System = FIELD(System));
        }
        field(3; "Sign Description"; Text[100])
        {
            FieldClass = Normal;
        }
        field(4; System; Code[20])
        {
            TableRelation = "HMS-Systems".Code;
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Sign Code", System)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

