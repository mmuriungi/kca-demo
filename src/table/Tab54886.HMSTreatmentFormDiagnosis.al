table 54886 "HMS-Treatment Form Diagnosis"
{

    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Diagnosis No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Setup Diagnosis".Code;
        }
        field(3; "Diagnosis Name"; Text[250])
        {
            CalcFormula = Lookup("HMS-Setup Diagnosis".Description WHERE(Code = FIELD("Diagnosis No.")));
            FieldClass = FlowField;
        }
        field(4; Confirmed; Boolean)
        {
        }
        field(5; Remarks; Text[100])
        {
        }
        field(6; "Treatment Date"; Date)
        {
            CalcFormula = Lookup("HMS-Treatment Form Header"."Treatment Date" WHERE("Treatment No." = FIELD("Treatment No.")));
            FieldClass = FlowField;
        }
        field(7; PatientNoF; Code[20])
        {
            CalcFormula = Lookup("HMS-Treatment Form Header"."Patient No." WHERE("Treatment No." = FIELD("Treatment No.")));
            FieldClass = FlowField;
        }
        field(8; "Patient No"; Code[20])
        {
        }
        field(9; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(10; Age; Code[20])
        {
            CalcFormula = Lookup("HMS-Patient"."Patient No." WHERE("Patient No." = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(11; "Patient Name"; Text[100])
        {
            CalcFormula = Lookup("HMS-Patient".Surname WHERE("Patient No." = FIELD(PatientNoF)));
            FieldClass = FlowField;
        }
        field(12; "Diagnosis Date"; Date)
        {
            CalcFormula = Lookup("HMS-Treatment Form Header"."Treatment Date" WHERE("Treatment No." = FIELD("Treatment No.")));
            FieldClass = FlowField;
        }
        /* field(13;Treatment;Text[30])
        {
            TableRelation = "HMS-Pharmacy Line"."Drug Name" WHERE ("Drug Name"=CONST());
        } */
        field(14; "Patient Appointments"; Integer)
        {
        }
        field(15; Doctor; Code[20])
        {
            CalcFormula = Lookup("HMS-Treatment Form Header"."Doctor ID" WHERE("Treatment No." = FIELD("Treatment No.")));
            FieldClass = FlowField;
        }
        field(16; "Diagnosis Count"; Integer)
        {
            CalcFormula = Count("HMS-Treatment Form Diagnosis" WHERE("Diagnosis No." = FIELD("Diagnosis No."),
                                                                      "Treatment Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(17; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Diagnosis No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

