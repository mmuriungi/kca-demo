table 54885 "HMS-Treatment Admission"
{

    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Ward No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Ward Setup"."Ward Code";
        }
        field(3; "Bed No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Beds"."Bed No" WHERE("Ward No" = FIELD("Ward No."));
        }
        field(4; "Date Of Admission"; Date)
        {
        }
        field(5; "Admission Reason"; Code[30])
        {
        }
        field(6; "Admission Remarks"; Text[100])
        {
        }
        field(7; Status; Option)
        {
            CalcFormula = Lookup("HMS-Admission Form Header".Status WHERE("Link Type" = CONST('DOCTOR'),
                                                                           "Link No." = FIELD("Treatment No.")));
            FieldClass = FlowField;
            OptionMembers = New,Admitted,Discharged,Cancelled,"Discharge Pending";
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Ward No.", "Bed No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

