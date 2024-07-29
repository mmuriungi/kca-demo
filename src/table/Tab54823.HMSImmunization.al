table 54823 "HMS-Immunization"
{

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            NotBlank = false;
        }
        field(2; "Immunization Date"; Date)
        {
            NotBlank = true;
        }
        field(3; "Immunization Time"; Time)
        {
            NotBlank = true;
        }
        field(4; "Patient No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Patient"."Patient No." WHERE("Patient Type" = FIELD("Patient Type"));
        }
        field(5; "Patient Type"; Option)
        {
            NotBlank = true;
            OptionMembers = Others,Student,Employee,Relative;
        }
        field(6; "Patient Name"; Text[150])
        {
            FieldClass = Normal;
        }
        field(7; "Immunization No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Immunization".Code;
        }
        field(8; "Immunization Name"; Text[100])
        {
            CalcFormula = Lookup("ACA-Immunization".Description WHERE(Code = FIELD("Immunization No.")));
            FieldClass = FlowField;
        }
        field(9; Given; Boolean)
        {
        }
        field(10; Remarks; Text[200])
        {
        }
        field(11; Posted; Boolean)
        {
        }
        field(12; Select; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

