table 54845 "HMS-Patient Medical Condition"
{
    LookupPageId = "HMS Patient Medical Condition";

    fields
    {
        field(1; "Patient No."; Code[20])
        {
        }
        field(2; "Medical Condition"; Code[20])
        {
            TableRelation = "HMS-Medical Conditions".Code;
        }
        field(3; "Medical Condition Name"; Text[100])
        {
            CalcFormula = Lookup("HMS-Medical Conditions".Description WHERE(Code = FIELD("Medical Condition")));
            FieldClass = FlowField;
        }
        field(4; "Date From"; Date)
        {
        }
        field(5; "Date To"; Date)
        {
        }
        field(6; Yes; Boolean)
        {
        }
        field(7; Details; Text[200])
        {
        }
        field(27; Surname; Text[100])
        {
            CalcFormula = Lookup("HMS-Patient".Surname WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(28; "Middle Name"; Text[30])
        {
            CalcFormula = Lookup("HMS-Patient"."Middle Name" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(29; "Last Name"; Text[50])
        {
            CalcFormula = Lookup("HMS-Patient"."Last Name" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(30; "ID Number"; Code[20])
        {
            CalcFormula = Lookup("HMS-Patient"."ID Number" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(31; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = Lookup("HMS-Patient"."Correspondence Address 1" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(32; "Telephone No. 1"; Code[100])
        {
            CalcFormula = Lookup("HMS-Patient"."Telephone No. 1" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(33; Email; Text[100])
        {
            CalcFormula = Lookup("HMS-Patient".Email WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(34; "Patient Ref. No."; Code[20])
        {
            CalcFormula = Lookup("HMS-Patient"."Patient Ref. No." WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Patient No.", "Medical Condition")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

