table 51298 "Proc-Preq. Categories/Year"
{
    DrillDownPageID = "Proc-Preq. Categories/Year";
    LookupPageID = "Proc-Preq. Categories/Year";

    fields
    {
        field(1; "Preq. Year"; Code[20])
        {
            TableRelation = "Proc-Prequalification Years"."Preq. Year";
        }
        field(2; "Preq. Category"; Code[100])
        {
            TableRelation = "Proc-Prequalif. Categories"."Category Code";
        }
        field(3; "Prequalified Suppliers"; Integer)
        {
            CalcFormula = Count("Proc-Preq. Suppliers/Category" WHERE("Preq. Year" = FIELD("Preq. Year"),
                                                                       "Preq. Category" = FIELD("Preq. Category")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Preq. Year", "Preq. Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

