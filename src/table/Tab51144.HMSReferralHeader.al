table 51144 "HMS-Referral Header"
{
    LookupPageID = "HMS Referral List";

    fields
    {
        field(1; "Treatment no."; Code[20])
        {
            TableRelation = "HMS-Treatment Form Header"."Treatment No.";
            trigger OnValidate()
            var
                Hms: Record "HMS-Treatment Form Header";
            begin
                if Hms.Get("Treatment no.") then begin
                    "Patient No." := Hms."Patient No.";
                    "Date Referred" := Hms."Treatment Date";
                end;
            end;
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
        field(35; "Staff No"; Code[20])
        {
        }
        field(36; "No. Series"; Code[20])
        {
        }
        field(37; "Referral No."; Code[20])
        {
        }

        // PART A - Additional fields from the form
        field(38; "PF/STD No."; Code[20])
        {
            Caption = 'PF/STD No.';
        }
        field(39; "Referred Hospital"; Text[100])
        {
            Caption = 'Referred to Hospital';
        }
        field(40; "Clinical History"; Text[250])
        {
            Caption = 'Clinical History';
        }
        field(41; "Examination Findings"; Text[250])
        {
            Caption = 'Examination Findings';
        }
        field(42; "Investigations Done"; Text[250])
        {
            Caption = 'Investigations Done';
        }
        field(43; "Provisional Diagnosis"; Text[250])
        {
            Caption = 'Provisional Diagnosis';
        }
        field(44; "Present Treatment"; Text[250])
        {
            Caption = 'Present Treatment';
        }
        field(45; "Comments"; Text[250])
        {
            Caption = 'Comments';
        }

        // Referral Reasons (Multiple options)
        field(46; "Opinion/Advice"; Boolean)
        {
            Caption = 'Opinion/Advice';
        }
        field(47; "Investigation (Specify)"; Text[100])
        {
            Caption = 'Investigation (Specify)';
        }
        field(48; "Further Management"; Boolean)
        {
            Caption = 'Further Management';
        }
        field(49; "For Review"; Boolean)
        {
            Caption = 'For Review';
        }

        // Chief Medical Officer Section
        field(50; "CMO Name"; Text[100])
        {
            Caption = 'Chief Medical Officer Name';
        }
        field(51; "CMO Signature/Stamp"; Text[50])
        {
            Caption = 'CMO Signature/Stamp';
        }
        field(52; "CMO Date"; Date)
        {
            Caption = 'CMO Date';
        }

        // PART B - Confidential Report fields
        field(53; "Clinical Lab Findings"; Text[250])
        {
            Caption = 'Clinical Laboratory Findings';
        }
        field(54; "Diagnosis"; Text[250])
        {
            Caption = 'Diagnosis';
        }
        field(55; "Further Invest Required"; Text[250])
        {
            Caption = 'Further Investigations Required (if any)';
        }
        field(56; "Treatment Started"; Text[250])
        {
            Caption = 'Treatment Started';
        }
        field(57; "Other Remarks"; Text[250])
        {
            Caption = 'Other Remarks';
        }
        field(58; "Doctor Name"; Text[100])
        {
            Caption = 'Doctor Name';
        }
        field(59; "Doctor Sign"; Text[50])
        {
            Caption = 'Doctor Signature';
        }
        field(60; "Report Date"; Date)
        {
            Caption = 'Report Date';
        }
        field(61; "Official Rubber Stamp"; Text[50])
        {
            Caption = 'Official Rubber Stamp';
        }

        // PART C - Medical Claim fields
        field(62; "Consultant/Specialist Name"; Text[100])
        {
            Caption = 'Name of Consultant/Specialist';
        }
        field(63; "Consultant PF No."; Code[20])
        {
            Caption = 'Consultant PF No.';
        }
        field(64; "Consultant Signature"; Text[50])
        {
            Caption = 'Consultant Signature';
        }
        field(65; "Consultant Date/Stamp"; Date)
        {
            Caption = 'Consultant Date/Stamp';
        }
    }

    keys
    {
        key(Key1; "Treatment no.", "Referral No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        HmsSetup: Record "HMS-Setup";
    begin
        HmsSetup.Get();
        HmsSetup.TestField("Referral Nos");
        NoSeriesManagement.InitSeries(HmsSetup."Referral Nos", xRec."No. Series", 0D, Rec."Referral No.", Rec."No. Series");
    end;

    procedure FullName(): Text
    begin
        Rec.CalcFields(Surname, "Middle Name", "Last Name");
        exit(Rec.Surname + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name");
    end;
}