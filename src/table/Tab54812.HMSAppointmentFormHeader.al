table 54812 "HMS-Appointment Form Header"
{
    LookupPageID = "HMS-Appointment List";

    fields
    {
        field(1; "Appointment No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Appointment No." <> xRec."Appointment No." THEN BEGIN
                    HMSSetup.GET;
                    NoSeriesMgt.TestManual(HMSSetup."Appointment Nos");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Appointment Date"; Date)
        {
        }
        field(3; "Appointment Time"; Time)
        {
        }
        field(4; "Appointment Type"; Code[20])
        {
            TableRelation = "HMS-Setup Appointment Type".Code;
        }
        field(5; "Patient Type"; Option)
        {
            OptionMembers = ,Student,Employee,others;
        }
        field(6; "Patient No."; Code[20])
        {
            TableRelation = "HMS-Patient";

            trigger OnValidate()
            var
                ptS: Record "HMS-Patient";
            begin
                pts.Reset();
                if pts.Get("Employee No.") then begin
                    rec."Employee No." := pts."Employee No.";
                    rec.Age := ptS.Age;
                    rec."Patient email" := ptS.Email;
                    rec.Modify();
                end;


            end;
            // TableRelation = IF ("Patient Type" = CONST(Student)) "HMS-Patient"."Patient No." WHERE("Patient Type" = CONST(Student))
            // ELSE
            // IF ("Patient Type" = CONST(Employee)) "HMS-Patient"."Patient No." WHERE("Patient Type" = CONST(Employee))
            // ELSE
            // IF ("Patient Type" = CONST(others)) "HMS-Patient"."Patient No." WHERE("Patient Type" = CONST(Others));

            // trigger OnValidate()
            // var
            //     pat2: Record "HMS-Patient";
            // begin
            //     IF Pat2.GET("Patient No.") THEN BEGIN
            //         REC.Gender := Pat2.Gender;
            //         rec.Age := pat2.Age;
            //         rec."Patient email" := pat2.Email;



            //         //Age:=
            //     END;
            // end;
        }
        field(7; "Student No."; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                IF Pat.GET("Patient No.") THEN BEGIN
                    Gender := Pat.Gender;
                    //Age:= 
                END;
            end;
        }
        field(8; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(9; "Relative No."; Integer)
        {
            TableRelation = "Employee Relative"."Line No." WHERE("Employee No." = FIELD("Employee No."));
        }
        field(10; Doctor; Code[20])
        {
            TableRelation = "HMS-Setup Doctor"."User ID";
        }
        field(11; Remarks; Text[100])
        {
        }
        field(687; "Patient email"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Status; Option)
        {
            OptionMembers = New,Booked,Completed,Rescheduled,Cancelled,Dispatched;
        }
        field(13; "ReAppointment No."; Code[20])
        {
        }
        field(14; "ReAppointment Date"; Date)
        {
        }
        field(15; "ReAppointment Time"; Time)
        {
        }
        field(16; "ReAppointment Type Code"; Code[20])
        {
            TableRelation = "HMS-Setup Appointment Type".Code;
        }
        field(17; "ReAppointment Doctor ID"; Code[20])
        {
            TableRelation = "HMS-Setup Doctor"."User ID";
        }
        field(18; "No. Series"; Code[20])
        {
        }
        field(19; "Dispatch To"; Option)
        {
            OptionMembers = Observation,Doctor;
        }
        field(20; "Dispatch Date"; Date)
        {
        }
        field(21; "Dispatch Time"; Time)
        {
        }
        field(22; "User ID"; Code[20])
        {
            //TableRelation = Table2000000002.Field1;
        }
        field(23; "Treatment Status"; Option)
        {
            CalcFormula = Lookup("HMS-Treatment Form Header".Status WHERE("Link No." = FIELD("Appointment No.")));
            FieldClass = FlowField;
            OptionMembers = New,Completed,Referred,Cancelled;
        }
        field(24; Gender; Option)
        {
            OptionCaption = ',Male,Female';
            OptionMembers = ,Male,Female;
        }
        field(25; Age; Text[100])
        {
        }
        field(26; "Preparation Instruction"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Cancelation Request"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Appointment No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Appointment No." = '' THEN BEGIN
            HMSSetup.GET;
            HMSSetup.TESTFIELD("Appointment Nos");
            NoSeriesMgt.InitSeries(HMSSetup."Appointment Nos", xRec."No. Series", 0D, "Appointment No.", "No. Series");
        END;
    end;

    var
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        Pat: Record "HMS-Patient";
}

