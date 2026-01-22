table 51220 "Audit-Risk Analysis Header"
{

    fields
    {
        field(1; No; Code[10])
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(3; "Departmant Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(4; Session; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "ACA-Semesters".Code;
        }
        field(5; Likelihood; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Impact; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Overall Rating"; Integer)
        {
            Editable = false;
        }
        /* field(8; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "ACA-Academic Year".Code;
        } */
        field(9; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Modified By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Modified On"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; Risks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Causes; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Implications; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Risk Action"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Responsible Persons"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." WHERE("Customer Posting Group" = CONST('IMPREST'));
        }
        field(18; Process; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Department Name2"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Departmant Name")));
            FieldClass = FlowField;
        }
        field(20; "Responsible Persons Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Responsible Persons")));
            FieldClass = FlowField;
        }
        field(21; "Priority Level"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Low,Medium,High;
        }
        field(22; status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,"In Audit",Closed,Reopened;
        }
        field(23; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Budget Period"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name".Name;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        AuditRiskCauses.RESET;
        AuditRiskCauses.SETRANGE("Risk Code", No);
        IF AuditRiskCauses.FINDFIRST THEN ERROR('Cannot delete. Valid Data in Risk Causes');

        AuditRiskActions.RESET;
        AuditRiskActions.SETRANGE("Risk Code", No);
        IF AuditRiskActions.FINDFIRST THEN ERROR('Cannot delete. Valid Data in Risk Actions');

        AuditRiskImpacts.RESET;
        AuditRiskImpacts.SETRANGE("Risk Code", No);
        IF AuditRiskImpacts.FINDFIRST THEN ERROR('Cannot delete. Valid Data in Risk Impacts');
    end;

    trigger OnInsert()
    begin
        IF No = '' THEN BEGIN
            //ACAGeneralSetUp.GET;
            //ACAGeneralSetUp.TESTFIELD("Further Info Nos"); //rsk
            //NoSeriesMgt.InitSeries(ACAGeneralSetUp."Further Info Nos", xRec."No Series", 0D, No, "No Series");
            NoSeriesMgt.InitSeries('RISK', xRec."No Series", 0D, No, "No Series");
        END;
        "Created By" := USERID;
        "Created On" := CURRENTDATETIME;
        Date := TODAY;
    end;

    trigger OnModify()
    begin
        "Modified By" := USERID;
        "Modified On" := CURRENTDATETIME;
        "Overall Rating" := Impact * Likelihood;
    end;

    var
        ACAGeneralSetUp: Record "Audit General SetUp";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        AuditRiskCauses: Record "Audit-Risk Causes";
        AuditRiskImpacts: Record "Audit Risk Impacts";
        AuditRiskActions: Record "Audit Risk Actions";
        AuditRiskTreatmentActStep: Record "Audit-Risk Treatment Act. Step";
}

