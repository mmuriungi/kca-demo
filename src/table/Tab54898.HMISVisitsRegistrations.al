table 54898 "HMIS-Visits/Registrations"
{
    DrillDownPageID = "HMIS-Registration List";
    LookupPageID = "HMIS-Registration List";

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
            TableRelation = "HMS-Setup Diagnosis".Code; //WHERE (=FIELD("Patient Type"));
        }
        field(4; "In-patient No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Out-Patient No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Registration Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Discharged; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Discharge Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Discharged by"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Observation Room"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Registration,Triage,Consultation,Observation,Laboratory,Theater,External Referal,Internal Referal,Radiology,CCC Clinic,Awaiting Admision,Admitted,Discharged,Pharmacy,Appointment,Operation';
            OptionMembers = Registration,Triage,Consultation,Observation,Laboratory,Theater,"External Referal","Internal Referal",Radiology,"CCC Clinic","Awaiting Admision",Admitted,Discharged,Pharmacy,Appointment,Operation;
        }
        field(11; "Current Location"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Temperature (Celcious)"; Decimal)
        {
            //CalcFormula = Lookup("HMS-Setup Allergy".Field12 WHERE (Code=FIELD("Batch Date"),
            // Description=FIELD("Visit Number"),
            // Field3=FIELD("Patient No."),
            // Field4=FIELD("Triage No.")));
            //FieldClass = FlowField;
        }
        field(13; "Height (CM)"; Decimal)
        {
            ///CalcFormula = Lookup("HMS-Setup Allergy".Field13 WHERE (Code=FIELD("Batch Date"),
            //Description=FIELD("Visit Number"),
            //Field3=FIELD("Patient No."),
            //Field4=FIELD("Triage No.")));
            //FieldClass = FlowField;
        }
        field(14; "Weight (KGs)"; Decimal)
        {
            //CalcFormula = Lookup("HMS-Setup Allergy".Field14 WHERE (Code=FIELD("Batch Date"),
            //Description=FIELD("Visit Number"),
            //Field3=FIELD("Patient No."),
            //                                                        Field4=FIELD("Triage No.")));
            //FieldClass = FlowField;
        }
        field(15; BMI; Decimal)
        {
            //CalcFormula = Lookup("HMS-Setup Allergy".Field15 WHERE (Code=FIELD("Batch Date"),
            // Description=FIELD("Visit Number"),
            // Field3=FIELD("Patient No."),
            //Field4=FIELD("Triage No.")));
            //FieldClass = FlowField;
        }
        field(16; "Previous Temperature (Cel.)"; Decimal)
        {
            //CalcFormula = Lookup("HMS-Setup Allergy".Field16 WHERE (Code=FIELD("Batch Date"),
            //Description=FIELD("Visit Number"),
            //Field3=FIELD("Patient No."),
            // Field4=FIELD("Triage No.")));
            // FieldClass = FlowField;
        }
        field(17; "Previous Height (CM)"; Decimal)
        {
            //CalcFormula = Lookup("HMS-Setup Allergy".Field17 WHERE (Code=FIELD("Batch Date"),
            // Description=FIELD("Visit Number"),
            //Field3=FIELD("Patient No."),
            // Field4=FIELD("Triage No.")));
            // FieldClass = FlowField;
        }
        field(18; "Previous Weight (KGs)"; Decimal)
        {
            /* CalcFormula = Lookup("HMS-Setup Allergy".Field18 WHERE (Code=FIELD("Batch Date"),
                                                                     Description=FIELD("Visit Number"),
                                                                     Field3=FIELD("Patient No."),
                                                                     Field4=FIELD("Triage No.")));
             FieldClass = FlowField;*/
        }
        field(19; "Previous BMI"; Decimal)
        {
            /*  CalcFormula = Lookup("HMS-Setup Allergy".Field19 WHERE (Code=FIELD("Batch Date"),
                                                                     Description=FIELD("Visit Number"),
                                                                     Field3=FIELD("Patient No."),
                                                                     Field4=FIELD("Triage No.")));
             FieldClass = FlowField; */
        }
        field(20; "Triage By"; Code[20])
        {
            /* CalcFormula = Lookup("HMS-Setup Allergy".Field20 WHERE (Code=FIELD("Batch Date"),
                                                                    Description=FIELD("Visit Number"),
                                                                    Field3=FIELD("Patient No."),
                                                                    Field4=FIELD("Triage No.")));
            FieldClass = FlowField; */
        }
        field(21; "Test Date/Time"; DateTime)
        {
            /*   CalcFormula = Lookup("HMS-Setup Allergy".Field21 WHERE (Code=FIELD("Batch Date"),
                                                                      Description=FIELD("Visit Number"),
                                                                      Field3=FIELD("Patient No."),
                                                                      Field4=FIELD("Triage No.")));
              FieldClass = FlowField; */
        }
        field(22; "Triage No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Patient Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS-Setup Lab Package Test"."Package Name" WHERE("Lab Package" = FILTER('PATIENT CATOGORIES'));
        }
        field(24; "First Name"; Text[250])
        {
            CalcFormula = Lookup("HMS-Setup Diagnosis".Description WHERE(Code = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(25; "Other Names"; Text[250])
        {
            /* CalcFormula = Lookup("HMS-Setup Diagnosis"."Male Counter" WHERE (Code=FIELD("Patient No.")));
            FieldClass = FlowField; */
        }
        field(26; "Pay Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Cash,Check,ATM,Insurance,Others;
        }
        field(27; "Insurance Card No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                HMISPatientInsurances: Record "HMS-Setup Test Specimen";
            begin
                HMISPatientInsurances.Reset;
                HMISPatientInsurances.SetRange("Lab Test", Rec."Patient No.");
                HMISPatientInsurances.SetRange(unit, Rec."Insurance Card No.");
                if HMISPatientInsurances.Find('-') then begin
                    Rec."Insurance Firm Code" := HMISPatientInsurances."Specimen Name";
                    // Rec."Insurance Name":=
                end;
            end;
        }
        field(28; "Insurance Firm Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Insurance Name"; Text[150])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Insurance Firm Code")));
            FieldClass = FlowField;
        }
        field(30; "Progress Confirmed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Consultation No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Lab. Req. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Referal No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Phamacy Req. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Number of Receipts"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Theatre No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Invoices Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Vitals Notes"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(39; "Consultation Assigned"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Consultation Assigned to"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Pulse (in bpm)"; Decimal)
        {
            /* CalcFormula = Lookup("HMS-Setup Allergy".Field39 WHERE (Code=FIELD("Batch Date"),
                                                                    Description=FIELD("Visit Number"),
                                                                    Field3=FIELD("Patient No."),
                                                                    Field4=FIELD("Triage No.")));
            FieldClass = FlowField; */
        }
        field(51; "BP (In mm Hg)"; Code[30])
        {
            /* CalcFormula = Lookup("HMS-Setup Allergy".Field40 WHERE (Code=FIELD("Batch Date"),
                                                                    Description=FIELD("Visit Number"),
                                                                    Field3=FIELD("Patient No."),
                                                                    Field4=FIELD("Triage No.")));
            FieldClass = FlowField; */
        }
        field(52; "Sugars (In mm)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; P1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54; P2; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55; P3; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Previous Pulse (in bpm)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Previous BP (In mm Hg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Previous Sugars (In mm)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Previous P1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Previous P2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Previous P3"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Doctor's Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Doctor incharge"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Appointment No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Appointiment Doctor"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Appointiment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Appointiment Time From"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Appointment Time To"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Appointment Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Active,Skipped,Cancelled';
            OptionMembers = " ",Active,Skipped,Cancelled;
        }
        field(69; "Appointment Pinned to Doctor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "OPT No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Insurance Verified"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Insurance Cap (inpatient)");
                TestField("Insurance Cap (Outpatient)");
                "Insurance Verified Date" := Today;
                "Insurance Veriyfied by" := UserId;
            end;
        }
        field(72; "Insurance Veriyfied by"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Insurance Verified Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Insurance Cap (Outpatient)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Insurance Cap (inpatient)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "Inpatient Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Suggested,Active,Pending Clearance,Discharged,Cleared,Diseased';
            OptionMembers = " ",Suggested,Active,"Pending Clearance",Discharged,Cleared,Diseased;

            trigger OnValidate()
            begin
                if "Inpatient Status" = "Inpatient Status"::Suggested then begin
                    "Inpatient Suggested By" := UserId;
                    "Inpatient Suggested Date" := Today;
                    "Inpatient Suggested Time" := Time;
                end else
                    if "Inpatient Status" = "Inpatient Status"::Active then begin
                        "Inpatient Admission By" := UserId;
                        "Inpatient Admission Date" := Today;
                        "Inpatient Admission Time" := Time;
                    end else
                        if "Inpatient Status" = "Inpatient Status"::"Pending Clearance" then begin
                            "Inpatient Clearance Initiated" := UserId;
                        end else
                            if "Inpatient Status" = "Inpatient Status"::Cleared then begin
                                TestField("Inpatient Clearance Notes");
                            end else
                                if "Inpatient Status" = "Inpatient Status"::Discharged then begin
                                    "Discharged by" := UserId;
                                    Discharged := true;
                                    "Discharge Date/Time" := CreateDateTime(Today, Time);
                                    ;
                                end;
            end;
        }
        field(77; "Inpatient Admission Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(78; "Inpatient Admission Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Inpatient Total Bills"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Inpatient Admission By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Inpatient Nurse Routine Visits"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(84; "Inpatient Doctor Visits"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Inpatient Admission Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(86; "Inpatient Clearance Notes"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(87; "Inpatient Suggested By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(88; "Inpatient Clearance Initiated"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Inpatient Suggested Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(91; "Inpatient Suggested Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(92; Gender; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS-Setup Lab Package Test"."Package Name" WHERE("Lab Package" = FILTER('GENDER' | 'SEX' | 'SESUAL ORIENTATION'));
        }
        field(93; "Ward No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "HMIS Ward Card".Field1 WHERE (Field6=FIELD(Gender));
        }
        field(94; "Room No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(95; "Bed No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(96; "Clinician ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(97; "Clinician User Name"; Code[20])
        {
            /* CalcFormula = Lookup("HMIS-Clinicians Register".Field5 WHERE (Field2=FIELD("Clinician ID")));
            FieldClass = FlowField; */
        }
        field(98; "Clinician Names"; Text[150])
        {
            /* CalcFormula = Lookup("HMIS-Clinicians Register".Field4 WHERE (Field2=FIELD("Clinician ID")));
            FieldClass = FlowField; */
        }
        field(99; "Re-Asign to Clinician"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(100; "External Referal Placed"; Boolean)
        {
            CalcFormula = Exist("HMIS-Visits/Registrations" WHERE("Patient No." = FIELD("Patient No."),
                                                                   "Visit Number" = FIELD("Visit Number"),
                                                                   "External Referal Hospital Name" = FILTER(<> ''),
                                                                   "External Referal Notes" = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(101; "External Referal Hospital Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "HMIS-Referal Facilities".Field1;

            trigger OnValidate()
            begin
                "External Referal Date" := Today;
                "External Referal Placed By" := UserId;
            end;
        }
        field(102; "External Referal Placed By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(103; "External Referal Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(104; "External Referal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(105; "Clinician Priority Indicator"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(106; "Exists Pending Injections"; Boolean)
        {
            FieldClass = Normal;
        }
        field(107; "Injection Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(108; Co1; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(109; C02; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(110; C03; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(111; C04; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(112; C05; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(113; D01; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(114; D02; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(115; D03; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(116; D04; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(117; D05; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(118; History; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(119; Palor; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(120; CB1; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(121; Jaudice; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(122; CB2; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(123; DCH20; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(124; CB3; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(125; Cyanosis; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(126; CB4; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(127; Oedama; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(128; CB5; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(129; "Medical History"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(130; Neurologic; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Batch Date", "Visit Number")
        {
        }
        key(Key2; "Batch Date", "Patient No.")
        {
        }
        key(Key3; "Batch Date", "Clinician Priority Indicator", "Clinician ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Batch Date" := Today;
        HMISNoSeries.Reset;
        if HMISNoSeries.Find('-') then begin
            HMISNoSeries.TestField(HMISNoSeries."Visit Nos");
            "Visit Number" := NoSeriesManagement.GetNextNo(HMISNoSeries."Visit Nos", Today, true);
        end;
        "Registration Time" := Time;
        "Current Location" := 'Registration';
        "Progress Confirmed" := false;
    end;

    var
        HMISNoSeries: Record "HMS-Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
}

