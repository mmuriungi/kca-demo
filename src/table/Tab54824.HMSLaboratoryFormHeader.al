table 54824 "HMS-Laboratory Form Header"
{
    LookupPageID = "HMS Laboratory List";

    fields
    {
        field(1; "Laboratory No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                IF "Laboratory No." <> xRec."Laboratory No." THEN BEGIN
                    HMSSetup.GET;
                    NoSeriesMgt.TestManual(HMSSetup."Lab Test Request Nos");
                    "No. Series" := '';
                    "Laboratory Date" := today;
                    "Laboratory Time" := time;
                END;
            end;
        }
        field(19; "sent to lab"; Boolean)
        {


        }
        field(2; "Laboratory Date"; Date)
        {
        }
        field(3; "Laboratory Time"; Time)
        {
        }
        field(4; "Patient No."; Code[20])
        {
            TableRelation = "HMS-Patient"."Patient No.";

            trigger OnValidate()
            begin
                Patient.RESET;
                Patient.GET("Patient No.");
                "Student No." := Patient."Student No.";
                "Employee No." := Patient."Employee No.";
                "Relative No." := Patient."Relative No.";
                "Patient Name" := Patient."Full Name";
                Surname := Patient.Surname;
                "Middle Name" := Patient."Middle Name";
                "Last Name" := Patient."Last Name";
            end;
        }
        field(5; "Student No."; Code[20])
        {
        }
        field(6; "Employee No."; Code[20])
        {
        }
        field(7; "Relative No."; Integer)
        {
        }
        field(8; "Scheduled Date"; Date)
        {
        }
        field(9; "Scheduled Time"; Time)
        {
        }
        field(10; "Supervisor ID"; Code[20])
        {
        }
        field(11; Status; Option)
        {
            OptionMembers = New,Forwarded,Cancelled,Completed;
        }
        field(12; "Link Type"; Code[20])
        {
        }
        field(13; "Link No."; Code[20])
        {
        }
        field(14; Remarks; Text[100])
        {
        }
        field(15; "Request Area"; Option)
        {
            OptionMembers = Doctor,Admission;
        }
        field(16; "No. Series"; Code[20])
        {
        }
        field(17; "Patient Type"; Option)
        {
            CalcFormula = Lookup("HMS-Patient"."Patient Type" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
            OptionMembers = Others,Student,Employee,Relative;
        }
        field(18; "Lab. Reference No."; Code[20])
        {
        }
        field(20; "Patient Name"; Text[200])
        {
        }
        field(21; Surname; Text[100])
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
        key(Key1; "Laboratory No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Laboratory No." = '' THEN BEGIN
            HMSSetup.GET;
            HMSSetup.TESTFIELD("Lab Test Request Nos");
            NoSeriesMgt.InitSeries(HMSSetup."Lab Test Request Nos", xRec."No. Series", 0D, "Laboratory No.", "No. Series");
        END;
    end;

    var
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        Patient: Record "HMS-Patient";
}

