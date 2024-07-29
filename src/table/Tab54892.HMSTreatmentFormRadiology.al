table 54892 "HMS-Treatment Form Radiology"
{

    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Radiology Type Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Setup Radiology Type".Code;
        }
        field(3; "Radiology Type Name"; Text[30])
        {
            CalcFormula = Lookup("HMS-Setup Radiology Type".Description WHERE(Code = FIELD("Radiology Type Code")));
            FieldClass = FlowField;
        }
        field(4; "Date Due"; Date)
        {
        }
        field(5; "Radiology Remarks"; Text[100])
        {
        }
        field(6; Status; Option)
        {
            CalcFormula = Lookup("HMS-Radiology Form Header".Status WHERE("Link Type" = CONST('DOCTOR'),
                                                                           "Link No." = FIELD("Treatment No.")));
            FieldClass = FlowField;
            OptionMembers = New,Cancelled,Completed,Forwarded;
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Radiology Type Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

