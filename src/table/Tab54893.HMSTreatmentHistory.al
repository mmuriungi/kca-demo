table 54893 "HMS-Treatment History"
{

    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            TableRelation = "HMS-Treatment Form Header"."Treatment No.";
        }
        field(2; "History Code"; Code[20])
        {
            TableRelation = "HMS-Patient History"."History Code";
        }
        field(3; "History Value"; Code[250])
        {
        }
        field(4; "History Name"; Text[250])
        {
            CalcFormula = Lookup("HMS-Patient History"."History Name" WHERE("History Code" = FIELD("History Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Treatment No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

