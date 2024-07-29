table 51009 "HRM-Appraisal Periods"
{
    DrillDownPageID = "HRM-Appraisal Periods List";
    LookupPageID = "HRM-Appraisal Periods List";

    fields
    {
        field(1; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Appraisal Year Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Appraisal Years".Code;
        }
        field(50009; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50010; "Date openned"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50011; "Date Closed"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50012; "Openned By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50013; "Closed By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; Period; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; Comments; text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

    }

    keys
    {
        key(Key1; "Code", "Appraisal Year Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Date openned" := TODAY;
        "Openned By" := USERID;
    end;

    var
        CReg: Record "HRM-Appraisal Registration";
        progs: Record "HRM-Appraisal Jobs";
}

