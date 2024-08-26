table 51116 "HMS-Observation Form Header"
{
    LookupPageID = "HMS-Observation List";

    fields
    {
        field(1; "Observation No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Observation No." <> xRec."Observation No." THEN BEGIN
                    HMSSetup.GET;
                    NoSeriesMgt.TestManual(HMSSetup."Observation Nos");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Observation Type"; Option)
        {
            Editable = true;

            OptionMembers = New,"Re-Visit",Appointment,Admission;
        }
        field(3; "Observation Date"; Date)
        {
        }
        field(4; "Observation Time"; Time)
        {
        }
        field(5; "Observation User ID"; Code[20])
        {
            TableRelation = User;
        }
        field(6; "Observation Remarks"; Code[200])
        {
        }
        field(7; "Patient No."; Code[20])
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

            end;
        }

        field(8; "Patient Name"; Text[200])
        {
            TableRelation = Customer."No.";
        }
        field(9; "Student No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(10; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(11; "Relative No."; Integer)
        {
            TableRelation = "Employee Relative"."Line No." WHERE("Employee No." = FIELD("Employee No."));
        }
        field(12; "Link Type"; Code[20])
        {
        }
        field(13; "Link No."; Code[20])
        {
            TableRelation = IF ("Observation Type" = CONST(Appointment)) "HMS-Appointment Form Header"."Appointment No." WHERE(Status = CONST(Dispatched),
                                                                                                                            "Dispatch To" = CONST(Observation))
            ELSE
            IF ("Observation Type" = CONST("Re-Visit")) "HMS-Treatment Form Header"."Treatment No." WHERE(Status = CONST(New))
            ELSE
            IF ("Observation Type" = CONST(Admission)) "HMS-Admission Form Header"."Admission No." WHERE(Status = CONST(Admitted));
        }
        field(14; "No. Series"; Code[20])
        {
        }
        field(15; Closed; Boolean)
        {
        }
        field(16; Status; Option)
        {
            OptionMembers = New,Pending,Closed;
        }
        field(17; Completed; Boolean)
        {
        }
        field(18; "Detailed Observation"; Text[1024])
        {
            DataClassification = ToBeClassified;
        }

        field(60; "Examining Officer"; Text[30])
        {
            Editable = false;
        }
        field(61; Height; Decimal)
        {
            trigger OnValidate()
            var
                H: Decimal;
            begin
                if Weight > 0 then begin
                    H := Height / 100;
                    BMI := Weight / (H * H);
                    rec."Examining Officer" := UserId;
                end;
            end;
        }
        field(63; Weight; Decimal)
        {
            trigger OnValidate()
            var
                H: Decimal;
            begin
                if Height > 0 then begin
                    H := Height / 100;
                    BMI := Weight / (H * H);
                end;
            end;
        }
        field(64; "Rhesus Factor"; Option)
        {
            OptionMembers = "","Rh+","Rh-",Rhnull;
        }
        field(65; "Blood Pressure"; code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Body Temp."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(67; BMI; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Physical Impairment Details"; Text[200])
        {
        }
        field(70; "Blood Group"; Option)
        {
            OptionMembers = "","A+","A-","B+","B-","AB+","AB-","O+","O-";
        }
        field(72; "Heart Rate"; Text[20])
        {

        }
        field(73; "Medical Details Not Covered"; Text[200])
        {
        }
        field(74; "Gender"; code[20])
        {
            TableRelation = "HMS-Patient".Gender;

        }
        field(75; "Sent to Treatment"; Boolean)
        {

        }
        field(76; AllergicTo; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(78; Age; code[34])
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Phone Number"; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Observation No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Observation No." = '' THEN BEGIN
            HMSSetup.GET;
            HMSSetup.TESTFIELD("Observation Nos");
            NoSeriesMgt.InitSeries(HMSSetup."Observation Nos", xRec."No. Series", 0D, "Observation No.", "No. Series");
        END;
        "Examining Officer" := UserId;
        "Observation User ID" := USERID;
        "Observation Date" := Today();
        "Observation Time" := Time();
    end;

    var
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        Patient: Record "HMS-Patient";
}

