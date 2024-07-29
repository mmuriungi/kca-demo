table 54888 "HMS-Treatment Form Header"
{
    LookupPageID = "HMS-Treatment List";

    fields
    {
        field(1; "Treatment No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Treatment No." <> xRec."Treatment No." THEN BEGIN
                    HMSSetup.GET;
                    NoSeriesMgt.TestManual(HMSSetup."Visit Nos");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Treatment Type"; Option)
        {
            OptionMembers = Outpatient,Inpatient;
        }
        field(3; "Treatment Date"; Date)
        {
        }
        field(4; "Treatment Time"; Time)
        {
        }
        field(5; "Doctor ID"; Code[20])
        {
            //TableRelation = "HMS-Setup Doctor"."User ID";
        }
        field(6; "Patient No."; Code[20])
        {
            TableRelation = "HMS-Patient"."Patient No.";

            trigger OnValidate()
            begin
                Patient.RESET;
                Patient.GET("Patient No.");
                "Student No." := Patient."Student No.";
                "Patient Name" := Patient."Full Name";
                "Employee No." := Patient."Employee No.";
                "Relative No." := Patient."Relative No.";
            end;
        }
        field(7; "Student No."; Code[20])
        {
        }
        field(36; "Patient Name"; text[100])
        {

        }
        field(8; "Employee No."; Code[20])
        {
        }
        field(9; "Relative No."; Integer)
        {
        }
        field(35; "sent to lab"; boolean)
        {

        }
        field(10; "Treatment Remarks"; Code[100])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                rec."Doctor ID" := UserId;
                rec.Location := rec.Location::Consultation;
                rec.Modify();
            end;
        }
        field(347; "Observation remarks"; code[1000])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; Status; Option)
        {
            OptionMembers = New,Completed,Referred,Cancelled;
        }
        field(12; "Link No."; Code[20])
        {
            TableRelation = IF ("Treatment Type" = CONST(Outpatient),
                                Direct = CONST(false)) "HMS-Observation Form Header"."Observation No." WHERE(Closed = CONST(true),
                                                                                                         Status = CONST(Pending),
                                                                                                         Completed = CONST(false))
            ELSE
            IF ("Treatment Type" = CONST(Inpatient)) "HMS-Admission Form Header"."Admission No." WHERE(Status = CONST(Admitted))
            ELSE
            IF ("Treatment Type" = CONST(Outpatient),
                                                                                                                  Direct = CONST(true)) "HMS-Appointment Form Header"."Appointment No." WHERE(Status = CONST(Dispatched),
                                                                                                                                                                                            "Dispatch To" = CONST(Doctor));
        }
        field(13; "Link Type"; Code[20])
        {
        }
        field(14; "No. Series"; Code[20])
        {
        }
        field(15; "Off Duty Days"; Decimal)
        {
        }
        field(16; "Light Duty Days"; Decimal)
        {
        }
        field(17; "Off Duty Comments"; Text[200])
        {
        }
        field(18; "Off Duty"; Boolean)
        {
        }
        field(19; "Treatment Location"; Option)
        {
            OptionMembers = Main;
        }
        field(20; "Patient Type"; Option)
        {
            CalcFormula = Lookup("HMS-Patient"."Patient Type" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Others,Student,Employee,Dependant';
            OptionMembers = " ",Others,Student,Employee,Dependant;
        }
        field(21; Direct; Boolean)
        {
        }
        field(22; "Lab Status"; Option)
        {
            OptionCaption = ' ,Pending,Cleared';
            OptionMembers = " ",Pending,Cleared;
        }
        field(23; "Radiology Status"; Option)
        {
            OptionCaption = ' ,Pending,Cleared';
            OptionMembers = " ",Pending,Cleared;
        }
        field(24; "Pharmacy Status"; Option)
        {
            OptionCaption = ' ,Pending,Cleared';
            OptionMembers = " ",Pending,Cleared;
        }
        field(25; "Injection Status"; Option)
        {
            OptionCaption = ' ,Pending,Cleared';
            OptionMembers = " ",Pending,Cleared;
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
        field(26; "Observation No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Diagnosis"; code[30])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS-Treatment Form Diagnosis"."Diagnosis No." where("Treatment No." = field("Treatment No.")));

        }
        field(41; "Diagnosis Two"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HMS-Treatment Form Diagnosis" where("Treatment No." = field("Treatment No.")));

        }
        field(45; "Specimen Code"; code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Specimen Name"; code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(47; AllergicTo; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(48; Location; Option)
        {
            OptionMembers = " ",Queue,Consultation,Pharmacy,Lab;
            DataClassification = ToBeClassified;
        }
        field(49; age; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50; gender; Option)
        {
            OptionMembers = "",Male,Female;
            DataClassification = ToBeClassified;
        }
        field(51; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52; Photo; Blob)
        {
            Subtype = Bitmap;
        }

    }

    keys
    {
        key(Key1; "Treatment No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Treatment No." = '' THEN BEGIN
            HMSSetup.GET;
            HMSSetup.TESTFIELD("Visit Nos");
            NoSeriesMgt.InitSeries(HMSSetup."Visit Nos", xRec."No. Series", 0D, "Treatment No.", "No. Series");
            //rec."Doctor ID" := UserId;
        END;
    end;

    var
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        Patient: Record "HMS-Patient";
        treatmentDrug: Record "HMS-Treatment Form Drug";
        pharmHeader: Record "HMS-Pharmacy Header";
        pharmLine: Record "HMS-Pharmacy Line";
        Treatment: Record "HMS-Treatment Form Header";

    procedure CreatePharmRequest()
    var
        Nextno: code[20];
    begin
        Treatment.Reset();
        Treatment.SetRange("Treatment No.", "Treatment No.");
        if Treatment.Find('-') then begin
            HMSSetup.GET;
            HMSSetup.TESTFIELD("Pharmacy Nos");
            //Nextno := NoSeriesMgt.GetNextNo(HMSSetup."Pharmacy Nos", today, true);
            pharmHeader.Init();
            pharmHeader."Pharmacy No." := NoSeriesMgt.GetNextNo(HMSSetup."Pharmacy Nos", today, true);
            pharmHeader."Pharmacy Date" := Today();
            pharmHeader."Pharmacy Time" := System.Time();
            pharmHeader."Request Area" := pharmHeader."Request Area"::Doctor;
            pharmHeader."Patient No." := Treatment."Patient No.";
            pharmHeader."Full Name" := Treatment."Patient Name";
            pharmHeader."Student No." := Treatment."Student No.";
            pharmHeader."Treatment No." := Treatment."Treatment No.";
            pharmHeader.Insert(true);
            treatmentDrug.Reset();
            treatmentDrug.SetRange("Treatment No.", "Treatment No.");
            if treatmentDrug.Find('-') then begin
                repeat
                    //treatmentDrug."Pharmacy No." := Nextno;
                    //treatmentDrug.Modify(true);
                    treatmentDrug.Rename("Treatment No.", treatmentDrug."Drug No.", pharmHeader."Pharmacy No.");
                until treatmentDrug.Next() = 0;
            end;
            Message("Patient Name" + ' Sent to Pharmacy. Request No.' + pharmHeader."Pharmacy No.");
        end;

    end;
}

