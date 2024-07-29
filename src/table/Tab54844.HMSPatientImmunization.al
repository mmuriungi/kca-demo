table 54844 "HMS-Patient Immunization"
{

    fields
    {
        field(2; "Patient No."; Code[20])
        {
            Description = 'Stores the admission number in the database';
            TableRelation = "HMS-Patient"."Patient No.";
        }
        field(3; "Immunization Code"; Code[20])
        {
            Description = 'Stores the reference code of the immunization in the database';
            TableRelation = "ACA-Immunization".Code;
        }
        field(4; "Immunization Name"; Text[30])
        {
            CalcFormula = Lookup("ACA-Immunization".Description WHERE(Code = FIELD("Immunization Code")));
            Description = 'Stores the name of the immunization in the database';
            FieldClass = FlowField;
        }
        field(5; Yes; Boolean)
        {
            Description = 'Stores the state of the immunization in the database';
        }
        field(6; Date; Date)
        {
            Description = 'Stores the date when the immunization was done';
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
        key(Key1; "Patient No.", "Immunization Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

