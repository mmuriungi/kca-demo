table 54861 "HMS-Referral Header"
{
    LookupPageID = "HMS Referral List";

    fields
    {
        field(1; "Treatment no."; Code[20])
        {
        }
        field(2; "Hospital No."; Code[20])
        {
        }
        field(3; "Patient No."; Code[20])
        {
        }
        field(4; "Date Referred"; Date)
        {
        }
        field(5; "Referral Reason"; Code[30])
        {
        }
        field(6; "Referral Remarks"; Text[200])
        {
        }
        field(7; Status; Option)
        {
            OptionMembers = New,Referred,Released;
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
        key(Key1; "Treatment no.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

