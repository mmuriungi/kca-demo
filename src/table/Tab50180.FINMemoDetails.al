table 50180 "FIN-Memo Details"
{

    fields
    {
        field(1; "Memo No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Staff no."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Payee Type" = CONST(Staff)) "HRM-Employee C"
            ELSE
            IF ("Payee Type" = CONST("Non Staff")) "HRM-Other Payees";

            trigger OnValidate()
            begin

                IF "Payee Type" = "Payee Type"::Staff THEN BEGIN
                    HRMEmployeeC.RESET;
                    HRMEmployeeD.SETRANGE("No.", "Staff no.");
                    HRMEmployeeC.SETRANGE("No.", "Staff no.");
                    IF HRMEmployeeC.FIND('-') THEN;
                    "Staff Name" := HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name";
                    "KRA pin" := HRMEmployeeC."PIN Number";
                    "Id Number" := HRMEmployeeC."ID Number";
                    "Job Grade" := HRMEmployeeC."Salary Grade";
                END;

                IF "Payee Type" = "Payee Type"::"Non Staff" THEN BEGIN
                    OtherPayee.RESET;
                    OtherPayee.SETRANGE(OtherPayee."No.", "Staff no.");
                    IF OtherPayee.FIND('-') THEN;
                    "Staff Name" := OtherPayee."First Name" + ' ' + OtherPayee."Middle Name" + ' ' + OtherPayee."Last Name";
                    "Bank Code" := OtherPayee."Main Bank";
                    "Branch Code" := OtherPayee."Main Bank";
                    "Account Number" := OtherPayee."Bank Account Number";
                    "KRA pin" := OtherPayee."PIN Number";
                    "Id Number" := OtherPayee."ID Number";
                END;

                Gross.RESET;
                Gross.SETRANGE("Employee Code", "Staff no.");
                IF Gross.FINDLAST THEN
                    "Current Gross" := Gross."Gross Pay";
            end;
        }
        field(3; "Expense Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Staff Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Rate; Decimal)
        {

            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                PAYE := prPayroll.fnGetEmployeePaye("Current Gross");

                Amount := Rate * Days;
                Rec.CALCFIELDS("Is Taxable");
                IF Rec."Is Taxable" THEN BEGIN
                    IF "Current Gross" <> 0 THEN BEGIN
                        "PAYE Amount" := (prPayroll.fnGetEmployeePaye(Amount + "Current Gross")) - PAYE;
                    END ELSE
                        "PAYE Amount" := (30 / 100) * Rate * Days;
                END ELSE
                    "PAYE Amount" := 0;
            end;
        }
        field(6; Days; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                PAYE := prPayroll.fnGetEmployeePaye("Current Gross");
                //AmountMemo.SETRANGE("Period Month","Period Month");
                Amount := Rate * Days;
                Rec.CALCFIELDS("Is Taxable");
                IF Rec."Is Taxable" THEN BEGIN
                    IF "Current Gross" <> 0 THEN BEGIN
                        "PAYE Amount" := (prPayroll.fnGetEmployeePaye(Amount + "Current Gross")) - PAYE;
                    END ELSE
                        "PAYE Amount" := (30 / 100) * Rate * Days;
                END ELSE
                    "PAYE Amount" := 0;


            end;
        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Compute P.A.Y.E."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "P.A.Y.E. Rate"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*PAYE:=prPayroll.fnGetEmployeePaye("Current Gross");
                Amount:=Rate*Days;
                Rec.CALCFIELDS("Is Taxable");
                IF Rec."Is Taxable" THEN BEGIN
                "PAYE Amount":=(prPayroll.fnGetEmployeePaye(Amount+"Current Gross"))-PAYE;
                //"PAYE Amount":=("P.A.Y.E. Rate"/100)*Rate*Days;
                END ELSE "PAYE Amount":=0;
                */

            end;
        }
        field(10; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Period Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Period Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "PAYE Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Type; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Memo-Transaction Type".Code;
        }
        field(15; "Is Taxable"; Boolean)
        {
            CalcFormula = Lookup("Memo-Transaction Type"."Is Taxable" WHERE(Code = FIELD(Type)));
            FieldClass = FlowField;
        }
        field(16; "Payee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Staff,Non Staff';
            OptionMembers = ,Staff,"Non Staff";
        }
        field(17; "Period Posted To"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Payroll Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Memo Status"; Option)
        {
            CalcFormula = Lookup("FIN-Memo Header"."Memo Status" WHERE("No." = FIELD("Memo No.")));
            FieldClass = FlowField;
            OptionCaption = 'New,Pending Approval,Approved,Posted';
            OptionMembers = New,"Pending Approval",Approved,Posted;
        }
        field(20; "Bank Code"; Code[50])
        {
            CalcFormula = Lookup("HRM-Employee (D)"."Main Bank" WHERE("No." = FIELD("Staff no.")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                IF "Payee Type" = "Payee Type"::Staff THEN BEGIN
                    HRMEmployeeD.RESET;
                    HRMEmployeeD.SETRANGE("No.", "Staff no.");
                    IF HRMEmployeeD.FIND('-') THEN;
                    "Bank Code" := HRMEmployeeD."Main Bank";
                END;
                IF "Payee Type" = "Payee Type"::"Non Staff" THEN BEGIN
                    HRMOtherPayees.RESET;
                    HRMOtherPayees.SETRANGE("No.", "Staff no.");
                    IF HRMOtherPayees.FIND('-') THEN;
                    "Bank Code" := HRMOtherPayees."Main Bank";
                    "Branch Code" := HRMOtherPayees."Main Bank";
                    "Account Number" := HRMOtherPayees."Bank Account Number";
                END;
            end;
        }
        field(21; "Branch Code"; Code[50])
        {
            CalcFormula = Lookup("HRM-Employee (D)"."Branch Bank" WHERE("No." = FIELD("Staff no.")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                IF "Payee Type" = "Payee Type"::Staff THEN BEGIN
                    HRMEmployeeD.RESET;
                    HRMEmployeeD.SETRANGE("No.", "Staff no.");
                    IF HRMEmployeeD.FIND('-') THEN;
                    "Branch Code" := HRMEmployeeD."Main Bank";
                END;
                IF "Payee Type" = "Payee Type"::"Non Staff" THEN BEGIN
                    HRMOtherPayees.RESET;
                    HRMOtherPayees.SETRANGE("No.", "Staff no.");
                    IF HRMOtherPayees.FIND('-') THEN;
                    "Branch Code" := HRMOtherPayees."Main Bank";
                END;
            end;
        }
        field(22; "Account Number"; Code[100])
        {
            CalcFormula = Lookup("HRM-Employee (D)"."Bank Account Number" WHERE("No." = FIELD("Staff no.")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                IF "Payee Type" = "Payee Type"::Staff THEN BEGIN
                    HRMEmployeeD.RESET;
                    HRMEmployeeD.SETRANGE("No.", "Staff no.");
                    IF HRMEmployeeD.FIND('-') THEN;
                    "Account Number" := HRMEmployeeD."Bank Account Number";
                END;
                IF "Payee Type" = "Payee Type"::"Non Staff" THEN BEGIN
                    HRMOtherPayees.RESET;
                    HRMOtherPayees.SETRANGE("No.", "Staff no.");
                    IF HRMOtherPayees.FIND('-') THEN;
                    "Account Number" := HRMOtherPayees."Bank Account Number";
                END;
            end;
        }
        field(23; "Current Gross"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; PAYE; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Period Closed"; Boolean)
        {
            CalcFormula = Lookup("PRL-Payroll Periods".Closed WHERE("Date Opened" = FIELD("Payroll Period")));
            FieldClass = FlowField;
        }
        field(26; "Is Disabled"; Boolean)
        {
            CalcFormula = Lookup("HRM-Employee (D)"."Physical Disability" WHERE("No." = FIELD("Staff no.")));
            FieldClass = FlowField;
        }
        field(27; "Imprest Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "KRA pin"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Id Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Payee Grade"; Code[30])
        {

        }
        field(31; Region; Text[50])
        {
            TableRelation = "Fin Memo Regions".Regions;
            trigger OnValidate()
            var
                Regn: Record "Fin Memo Regions";
            begin
                Regn.Reset();
                Regn.SetRange(Regions, Rec.Region);
                Regn.SetRange(Grade, Rec."Job Grade");
                if Regn.Find('-') then begin
                    Rec.Rate := Regn.Amount;
                    if Rec.Days > 0 then
                        Rec.Amount := (Rec.rate * Rec.Days);
                end;
            end;
        }
        field(32; "Job Grade"; code[30])
        {

        }

        field(33; "Vehicle No"; code[30])
        {
            TableRelation = "Fixed Asset"."No." where("FA Subclass Code" = filter('MV'));

            trigger OnValidate()
            var
                Fa: Record "Fixed Asset";
            begin
                Fa.Reset();
                fa.SetRange("No.", Rec."Vehicle No");
                if fa.Find('-') then begin
                    // "Consumption Rate" := fa."Fuel consumption Rate";
                    //"Fuel Rate" := fa."Fuel Rate";
                end;
                if ((Rec.Distance <> 0) or (Rec."Consumption Rate" <> 0) or (Distance <> 0)) then
                    Rec.Amount := ((Distance / "Consumption Rate") * "Fuel Rate");

            end;
        }
        field(34; "Consumption Rate"; decimal)
        {

        }
        field(35; "Fuel Rate"; decimal)
        {

        }
        field(36; "Distance"; decimal)
        {
            trigger OnValidate()
            begin
                if ((Rec.Distance <> 0) or (Rec."Consumption Rate" <> 0) or (Distance <> 0)) then
                    Rec.Amount := ((Distance / "Consumption Rate") * "Fuel Rate");
            end;

        }


    }

    keys
    {
        key(Key1; "Memo No.", "Staff no.", "Expense Code", Type)
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        PRLPayrollPeriods.RESET;
        PRLPayrollPeriods.SETRANGE(Closed, FALSE);
        IF PRLPayrollPeriods.FIND('-') THEN;
        "Payroll Period" := PRLPayrollPeriods."Date Opened";
        "Compute P.A.Y.E." := false;
        "P.A.Y.E. Rate" := 30;
        "Period Month" := PRLPayrollPeriods."Period Month";
        "Period Year" := PRLPayrollPeriods."Period Year";


    end;

    var
        PRLPayrollPeriods: Record "PRL-Payroll Periods";
        HRMEmployeeC: Record "HRM-Employee C";
        OtherPayee: Record "HRM-Other Payees";
        prPayroll: Codeunit "prPayrollProcessing";
        Gross: Record "PRL-Employee P9 Info";
        //AmountMemo: Record "64604";
        HRMEmployeeD: Record "HRM-Employee (D)";
        HRMOtherPayees: Record "HRM-Other Payees";
}

