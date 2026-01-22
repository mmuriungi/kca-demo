table 50189 "memo TT"
{

    fields
    {
        field(1; serial; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Pf; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Payee; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Sum"; Decimal)
        {
            CalcFormula = Sum("memo TT".Amount WHERE(Pf = FIELD(Pf)));
            FieldClass = FlowField;
        }
        field(6; Sum2; Decimal)
        {
            CalcFormula = Sum("memo TT".Payee WHERE(Pf = FIELD(Pf)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; serial)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

