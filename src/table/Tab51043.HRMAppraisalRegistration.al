table 51043 "HRM-Appraisal Registration"
{
    //DrillDownPageID = 75029;
    //LookupPageID = 75029;

    fields
    {
        field(1; "PF No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee C"."No.";
        }
        field(2; "Appraisal Period Code"; Code[50])
        {
            NotBlank = true;
            ///TableRelation = "HRM-Appraisal Periods".Field1;

            trigger OnValidate()
            begin
                coReg2.Reset;
                coReg2.SetRange(coReg2."Appraisal Period Code", Rec."Appraisal Period Code");
                coReg2.SetRange(coReg2."PF No.", Rec."PF No.");
                if coReg2.Find('-') then begin
                    if coReg2.Count > 1 then Error('Multiple Registration in the same Appraisal Period is not allowed....');
                end;
            end;
        }
        field(3; "Appraisal Job Code"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HRM-Appraisal Jobs".Code;

            trigger OnValidate()
            begin
                Periods.Reset;
                //Periods.SETRANGE(Periods.Closed,FALSE);
                if Periods.Find('-') then;

                acadYears.Reset;
                acadYears.SetRange(acadYears.Closed, true);
                if acadYears.Find('-') then begin
                    Rec."Appraisal Year Code" := acadYears.Code;
                end;



                //Default Stage and semeter

                //Defaulting of semester
                Periods.Reset;
                //  Periods.SETRANGE(Periods.Closed,FALSE);
                if Periods.Find('-') then
                    "Appraisal Period Code" := Periods."Period Code"
                else
                    Error('Please specify the Curent Appraisal Period in the Appraisal Periods Setup!');
                Validate("Appraisal Period Code");

                // Insert the Settlement Type
                CReg2.Reset;
                CReg2.SetRange("PF No.", Rec."PF No.");
                CReg2.SetFilter("Employee Category", '<>%1', '');
                if CReg2.Find('-') then begin
                    "Employee Category" := CReg2."Employee Category";
                    Validate("Employee Category");
                end;

                if "Registration Date" = 0D then
                    "Registration Date" := Today;
                Validate("Registration Date");
            end;
        }
        field(7; "Employee Category"; Code[50])
        {
            NotBlank = false;
            //TableRelation = "HRM-Employee Category".Code;

            trigger OnValidate()
            begin
                Validate("Registration Date");
                TestField("Reg. Transacton ID");
                "User ID" := UserId;
            end;
        }
        field(8; "Registration Date"; Date)
        {
            NotBlank = true;

            trigger OnValidate()
            begin

                EmpAppraisalTargets.Reset;
                EmpAppraisalTargets.SetRange(EmpAppraisalTargets."PF. No.", "PF No.");
                EmpAppraisalTargets.SetRange(EmpAppraisalTargets."Reg. Transacton ID", "Reg. Transacton ID");
                if EmpAppraisalTargets.Find('-') then
                    EmpAppraisalTargets.DeleteAll;



                //Insert Employee Appraisal Targets

                AppraisalTargets.Reset;
                AppraisalTargets.SetRange(AppraisalTargets."Appraisal Job Code", "Appraisal Job Code");
                AppraisalTargets.SetRange(AppraisalTargets."Appraisal Year Code", "Appraisal Year Code");
                if AppraisalTargets.Find('-') then begin
                    repeat
                    begin
                        EmpAppraisalTargets.Init;
                        EmpAppraisalTargets."Reg. Transacton ID" := "Reg. Transacton ID";
                        EmpAppraisalTargets."PF. No." := "PF No.";
                        EmpAppraisalTargets."Appraisal Job Code" := "Appraisal Job Code";
                        EmpAppraisalTargets."Appraisal Target Code" := AppraisalTargets.Code;
                        EmpAppraisalTargets."Appraisal Period Code" := "Appraisal Period Code";
                        //EmpAppraisalTargets.Description:=AppraisalTargets.Desription;
                        EmpAppraisalTargets.Taken := true;
                        EmpAppraisalTargets.Insert
                    end;
                    until AppraisalTargets.Next = 0
                end;
            end;
        }
        field(9; Remarks; Text[150])
        {
        }
        field(10; "Reg. Transacton ID"; Code[20])
        {

            trigger OnValidate()
            begin

                if "Reg. Transacton ID" = '' then begin
                    GenSetup.Get;
                    GenSetup.TestField(GenSetup."Appraisal Registration Nos.");
                    NoSeriesMgt.InitSeries(GenSetup."Appraisal Registration Nos.", xRec."No. Series", 0D, "Reg. Transacton ID", "No. Series");
                end;
            end;
        }
        field(11; "No. Series"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Reg. Transacton ID" <> xRec."Reg. Transacton ID" then begin
                    GenSetup.Get;
                    NoSeriesMgt.TestManual(GenSetup."Appraisal Registration Nos.");
                    "No. Series" := '';
                end;

                if "Reg. Transacton ID" = '' then begin
                    GenSetup.Get;
                    GenSetup.TestField(GenSetup."Appraisal Registration Nos.");
                    NoSeriesMgt.InitSeries(GenSetup."Appraisal Registration Nos.", xRec."No. Series", 0D, "Reg. Transacton ID", "No. Series");
                end;
            end;
        }
        field(21; "Targets Set"; Integer)
        {
            Editable = false;
        }
        field(22; "User ID"; Code[50])
        {
        }
        field(37; "Appraisal Year Code"; Code[20])
        {
            Description = 'Stores the reference to the academic year in the database';
            TableRelation = "HRM-Appraisal Years".Code;
        }
        field(68; "Date Registered"; Date)
        {
        }
        field(69; "Appraisal Jobs Category"; Code[20])
        {
            CalcFormula = Lookup("HRM-Appraisal Jobs"."Appraisal Category");
            FieldClass = FlowField;
        }
        field(20029; "Average Individual Target"; Decimal)
        {
        }
        field(50005; "Appraisal Target Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "`"; Code[20])
        {
        }
        field(50060; Award; Text[200])
        {
        }
        field(50085; "Suspervisor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "Supervisor Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50088; "Individual Target Grade"; Code[10])
        {
        }
        field(50089; "Individual Target Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50097; "Average Agreed Score"; Decimal)
        {
            CalcFormula = Sum("HRM-Appraisal Emp. Targets"."Individual Target" WHERE("PF. No." = FIELD("PF No."),
                                                                                      "Appraisal Period Code" = FIELD("Appraisal Period Code"),
                                                                                      "Appraisal year Code" = FIELD("Appraisal Year Code")));
            FieldClass = FlowField;
        }
        field(50098; "Agreed Score Grade"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Agreed Score Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60016; "Staff Name"; Text[250])
        {
        }
        field(60033; "ID Number"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "PF No.", "Appraisal Period Code", "Appraisal Job Code", "Appraisal Year Code")
        {
        }
        key(Key2; "Registration Date", "Appraisal Job Code")
        {
        }
        key(Key3; "Reg. Transacton ID", "Appraisal Job Code", "Appraisal Period Code")
        {
        }
        key(Key4; "Appraisal Job Code")
        {
        }
        key(Key5; "Employee Category")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        EmpAppraisalTargets.Reset;
        EmpAppraisalTargets.SetRange(EmpAppraisalTargets."PF. No.", Rec."PF No.");
        EmpAppraisalTargets.SetRange("Appraisal Period Code", Rec."Appraisal Period Code");
        if EmpAppraisalTargets.Find('-') then
            EmpAppraisalTargets.DeleteAll;

        ExamR.Reset;
        ExamR.SetRange(ExamR."PF No.", Rec."PF No.");
        ExamR.SetRange("Appraisal Period Code", Rec."Appraisal Period Code");
        if ExamR.Find('-') then
            ExamR.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "Reg. Transacton ID" = '' then begin
            GenSetup.Get;
            GenSetup.TestField(GenSetup."Appraisal Registration Nos.");
            NoSeriesMgt.InitSeries(GenSetup."Appraisal Registration Nos.", xRec."No. Series", 0D, "Reg. Transacton ID", "No. Series");
        end;
    end;

    var
        UserSetup: Record "User Setup";
        coReg2: Record "HRM-Appraisal Registration";
        coReg1: Record "HRM-Appraisal Registration";
        acadYears: Record "HRM-Appraisal Years";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenSetup: Record "HRM-Appraisal Gen. Setup";
        TotalCost: Decimal;
        RecFound: Boolean;
        EmpAppraisalTargets: Record "HRM-Appraisal Emp. Targets";
        AppraisalTargets: Record "HRM-Appraisal Targets";
        GenJnl: Record "Gen. Journal Line";
        Units: Record "HRM-Appraisal Targets";
        Periods: Record "HRM-Appraisal Periods Set";
        SemFound: Boolean;
        DueDate: Date;
        Cust: Record Customer;
        GenBatches: Record "Gen. Journal Batch";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        //SettlementType: Record "HRM-Employee Category";
        CReg: Record "HRM-Appraisal Registration";
        CustPostGroup: Record "Customer Posting Group";
        Programmes: Record "HRM-Appraisal Jobs";
        CourseReg: Record "HRM-Appraisal Registration";
        CourseReg2: Record "HRM-Appraisal Registration";
        Found: Boolean;
        LibCode: Text[30];
        Custs: Record Customer;
        UnitType: Text[100];
        TotalUnits: Integer;
        OldStud: Boolean;
        CReg2: Record "HRM-Appraisal Registration";
        StudUnits: Record "HRM-Appraisal Emp. Targets";
        ExamR: Record "HRM-Appraisal Results";
        Prog: Record "HRM-Appraisal Jobs";
        Prog2: Record "HRM-Appraisal Jobs";
        AcademicYear: Record "HRM-Appraisal Years";
        EmpAppraisalTargets_2: Record "HRM-Appraisal Emp. Targets";
        RecType: Option " ",GL,Cust,Item,Supp,FA,Emp,Sal,CourseReg,prTrans,EmpTrans;

    procedure Check_Units_Exist(PfNo: Code[20]; EmpJob: Code[20]; Stag: Code[20]; Unt: Code[20]) Exists: Boolean
    var
        StudUnits: Record "HRM-Appraisal Emp. Targets";
    begin
        Exists := false;
        StudUnits.Reset;
        StudUnits.SetRange(StudUnits."Appraisal Job Code", EmpJob);
        StudUnits.SetRange(StudUnits."Appraisal Target Code", Unt);
        StudUnits.SetRange(StudUnits."PF. No.", PfNo);
        if StudUnits.Find('-') then
            Exists := true;
    end;
}

