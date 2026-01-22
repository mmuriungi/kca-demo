table 51219 "Audit Risk Actions"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Risk Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Risk Treatment"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Risk Action"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Treatment Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Budget Amount"; Decimal)
        {
            CalcFormula = Sum("Audit-Risk Treatment Act. Step"."Budgeted Amount" WHERE(TreatmentCode = FIELD("Treatment Code")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; No, "Risk Code", "Treatment Code")
        {
            Clustered = true;
        }
        key(Key2; "Treatment Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        AuditRiskTreatmentActStep.RESET;
        AuditRiskTreatmentActStep.SETFILTER("Risk Code", "Risk Code");
        IF AuditRiskTreatmentActStep.FINDFIRST THEN ERROR('Action has active link to valid Data. Can not delete.');
    end;

    trigger OnInsert()
    begin
        IF Rec.FINDLAST THEN
            No := No + 1;
        "Treatment Code" := "Risk Code" + '' + FORMAT(No);
    end;

    var
        AuditRiskTreatmentActStep: Record "Audit-Risk Treatment Act. Step";
}

