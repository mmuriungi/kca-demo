table 54808 "HMS-Admission Form Header"
{
    LookupPageID = "HMS Admission List";

    fields
    {
        field(1; "Admission No."; Code[20])
        {
        }
        field(2; "Admission Date"; Date)
        {
            NotBlank = true;
        }
        field(3; "Admission Time"; Time)
        {
            NotBlank = true;
        }
        field(4; "Admission Area"; Option)
        {
            OptionMembers = Doctor,Referral;
        }
        field(5; "Patient No."; Code[20])
        {
            NotBlank = true;
        }
        field(6; "Employee No."; Code[20])
        {
            NotBlank = false;
        }
        field(7; "Relative No."; Integer)
        {
        }
        field(8; Ward; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Ward Setup"."Ward Code";
        }
        field(9; Bed; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Beds"."Bed No" WHERE("Ward No" = FIELD(Ward));
        }
        field(10; Doctor; Code[20])
        {
            NotBlank = true;
        }
        field(11; Remarks; Text[200])
        {
        }
        field(12; Status; Option)
        {
            OptionMembers = New,Admitted,Discharged,Cancelled,"Discharge Pending";
        }
        field(13; "No. Series"; Code[20])
        {
        }
        field(14; "Student No."; Code[20])
        {
        }
        field(15; "Link Type"; Code[20])
        {
        }
        field(16; "Link No."; Code[20])
        {
        }
        field(17; "Admission Reason"; Text[200])
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
        key(Key1; "Admission No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

