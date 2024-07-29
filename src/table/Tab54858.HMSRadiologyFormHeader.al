table 54858 "HMS-Radiology Form Header"
{
    LookupPageID = "HMS Radiology List";

    fields
    {
        field(1; "Radiology No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Radiology Date"; Date)
        {
            NotBlank = true;
        }
        field(3; "Radiology Time"; Time)
        {
            NotBlank = true;
        }
        field(4; "Radiology Area"; Option)
        {
            NotBlank = true;
            OptionMembers = Doctor,Admission;
        }
        field(5; "Patient No."; Code[20])
        {
            NotBlank = true;
        }
        field(6; "Student No."; Code[20])
        {
        }
        field(7; "Employee No."; Code[20])
        {
        }
        field(8; "Relative No."; Integer)
        {
        }
        field(9; Status; Option)
        {
            OptionMembers = New,Cancelled,Completed,Forwarded;
        }
        field(10; "Link No."; Code[20])
        {
        }
        field(11; "Link Type"; Code[20])
        {
        }
        field(12; "No. Series"; Code[20])
        {
        }
        field(13; "Supervisor ID"; Code[20])
        {
            //TableRelation = Table2000000002.Field1;
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
        key(Key1; "Radiology No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

