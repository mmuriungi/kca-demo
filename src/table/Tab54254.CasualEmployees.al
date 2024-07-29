table 54254 "Casual Employees."
{
    // DrillDownPageID = "Casual Employees.";
    //LookupPageID = "Casual Employees.";

    fields
    {
        field(1; "Casual No"; Code[30])
        {
        }
        field(2; "Full  Name"; Text[100])
        {
        }
        field(3; Gender; Option)
        {
            OptionCaption = ',Male,Female';
            OptionMembers = ,male,Female;
        }
        field(4; "D O B"; Date)
        {
        }
        field(5; "ID Number"; Code[20])
        {

            trigger OnValidate()
            begin
                CasualEmployees.RESET;
                CasualEmployees.SETRANGE(CasualEmployees."ID Number", "ID Number");
                IF CasualEmployees.FINDFIRST THEN
                    ERROR('This ID Number already register under %1', CasualEmployees."Full  Name");
            end;
        }
        field(6; "Revenue Division"; Code[30])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                DimensionValue.RESET;
                DimensionValue.SETRANGE(DimensionValue.Code, 'REVENUE DIVISION');
                DimensionValue.SETRANGE(DimensionValue."Dimension Code", "Revenue Division");
                IF DimensionValue.FINDFIRST THEN
                    "Division Name" := DimensionValue.Name;
            end;
        }
        field(7; Department; Code[30])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                DimensionValue.RESET;
                DimensionValue.SETRANGE(DimensionValue.Code, 'DEPARTMENT');
                DimensionValue.SETRANGE(DimensionValue."Dimension Code", Department);
                IF DimensionValue.FINDFIRST THEN
                    "Department Name" := DimensionValue.Name;
            end;
        }
        field(8; "Task  Description"; Text[30])
        {
        }
        field(9; "No of Hours"; Integer)
        {
        }
        field(10; "No of Days"; DateFormula)
        {

            trigger OnValidate()
            begin
                "End Date" := CALCDATE("No of Days", "Start Date");
                "No of Days value" := "End Date" - "Start Date";
            end;
        }
        field(11; "Bank Code"; Code[20])
        {
        }
        field(12; "Bank Name"; Text[50])
        {
        }
        field(13; "Bank Account Number"; Code[30])
        {
        }
        field(14; "Start Date"; Date)
        {

            trigger OnValidate()
            begin

                "End Date" := CALCDATE("No of Days", "Start Date");
                "No of Days value" := "End Date" - "Start Date";
            end;
        }
        field(16; "End Date"; Date)
        {
            Editable = false;
        }
        field(17; "Rate per Day"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Rate Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Rate Description"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Department Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD(Department)));
            FieldClass = FlowField;
        }
        field(23; "Division Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Revenue Division")));
            FieldClass = FlowField;
        }
        field(24; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "PRL-Payroll Periods"."Date Opened";
        }
        field(25; "Task Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Casual Tiers."."Occupation Code";

            trigger OnValidate()
            begin
                CasualTiers.RESET;
                CasualTiers.SETRANGE(CasualTiers."Occupation Code", "Task Code");
                IF CasualTiers.FIND('-') THEN BEGIN
                    "Task  Description" := CasualTiers."Occupation Description";
                    "Rate per Day" := CasualTiers."Rate per Day";
                    "Rate Per Month" := CasualTiers."Rate Per Month";
                END;
            end;
        }
        field(26; "Rate Per Month"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "No of Days value"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Employee Code"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                CLEAR(HrEmployees);
                HrEmployees.SETRANGE(HrEmployees."No.", "Employee Code");
                IF HrEmployees.FINDFIRST THEN BEGIN
                    "Full  Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                    "ID Number" := HrEmployees."ID Number";
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Casual No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        IF "Employee Code" <> '' THEN BEGIN
            "Casual No" := "Employee Code";
        END ELSE
            IF "Employee Code" = '' THEN
                IF "Casual No" = '' THEN BEGIN
                    GenLedgerSetup.GET;
                    //GenLedgerSetup.TESTFIELD(GenLedgerSetup."Casual Staff Nos.");
                    //NoSeriesMgt.InitSeries(GenLedgerSetup."Casual Staff Nos.", xRec."No. Series", 0D, "Casual No", "No. Series");
                    NoSeriesMgt.InitSeries('CASUAL', xRec."No. Series", 0D, "Casual No", "No. Series");
                END;
    end;

    var
        GenLedgerSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit 396;
        CasualEmployees: Record "Casual Employees.";
        DimensionValue: Record 349;
        CasualTiers: Record "Casual Tiers.";
        HrEmployees: Record "HRM-Employee (D)";
        Ok: Boolean;
}

