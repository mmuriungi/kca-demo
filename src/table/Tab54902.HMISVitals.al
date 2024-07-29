table 54902 "HMIS-Vitals"
{

    fields
    {
        field(1; "Batch Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Visit Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Patient No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Vitals No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Registration,Triage,Consultation,Observation,Laboratory,Theater,External Referal,Internal Referal,Radiology,CCC Clinic,Awaiting Admision,Admitted,Discharged';
            OptionMembers = Registration,Triage,Consultation,Observation,Laboratory,Theater,"External Referal","Internal Referal",Radiology,"CCC Clinic","Awaiting Admision",Admitted,Discharged;
        }
        field(11; "Current Location"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Temperature (Celcious)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Height (CM)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // BMI:=ComputeBMI("Weight (KGs)","Height (CM)");
            end;
        }
        field(14; "Weight (KGs)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //  BMI:=ComputeBMI("Weight (KGs)","Height (CM)");
            end;
        }
        field(15; BMI; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Previous Temperature (Cel.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Previous Height (CM)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Previous Weight (KGs)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Previous BMI"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Triage By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Test Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Released Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "First Name"; Text[100])
        {
            //CalcFormula = Lookup(HMIS-Patient."First Name" WHERE ("Patient No."=FIELD("Patient No.")));
            //FieldClass = FlowField;
        }
        field(25; "Other Names"; Text[100])
        {
            //CalcFormula = Lookup(HMIS-Patient."Other Names" WHERE (Patient No.=FIELD(Patient No.)));
            //FieldClass = FlowField;
        }
        field(38; "Vitals Notes"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Pulse (in bpm)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "BP (In mm Hg)"; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Sugars (In mm)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(42; P1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(43; P2; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; P3; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Previous Pulse (in bpm)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Previous BP (In mm Hg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Previous Sugars (In mm)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Previous P1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Previous P2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Previous P3"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Batch Date", "Visit Number", "Vitals No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        HMISVitals.RESET;
        HMISVitals.SETRANGE("Patient No.", Rec."Patient No.");
        HMISVitals.SETFILTER("Vitals No.", '<>%1', Rec."Vitals No.");
        IF HMISVitals.FIND('-') THEN BEGIN
            "Previous BMI" := HMISVitals.BMI;
            "Previous Height (CM)" := HMISVitals."Height (CM)";
            "Previous Temperature (Cel.)" := HMISVitals."Temperature (Celcious)";
            "Previous Weight (KGs)" := HMISVitals."Weight (KGs)";
            //"Previous BP (In mm Hg)":="BP (In mm Hg)";
            "Previous P1" := P1;
            "Previous P2" := P2;
            "Previous P3" := P3;
            "Previous Pulse (in bpm)" := "Pulse (in bpm)";
            "Previous Sugars (In mm)" := "Sugars (In mm)";
        END;
        "Triage By" := USERID;
        "Test Date/Time" := CURRENTDATETIME;
    end;

    trigger OnModify()
    begin
        "Triage By" := USERID;
        "Test Date/Time" := CURRENTDATETIME;
    end;

    var
        HMISVitals: Record "HMIS-Vitals";

    local procedure ComputeBMI(WeightInKgs: Decimal; HeightInCM: Decimal) ReturnBMI: Decimal
    begin
        CLEAR(ReturnBMI);
        HeightInCM := HeightInCM / 100;
        HeightInCM := HeightInCM * HeightInCM;
        IF ((WeightInKgs <> 0) AND (HeightInCM <> 0)) THEN BEGIN
            ReturnBMI := WeightInKgs / HeightInCM;
        END;
    end;
}

