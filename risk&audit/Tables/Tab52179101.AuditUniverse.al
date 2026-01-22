table 52179101 "Audit Universe"
{
    Caption = 'Audit Universe';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Audit Area"; Option)
        {
            Caption = 'Audit Area';
            OptionMembers = " ",Financial,Operational,Compliance,IT,Strategic,Environmental,Quality;
            OptionCaption = ' ,Financial,Operational,Compliance,IT,Strategic,Environmental,Quality';
            DataClassification = ToBeClassified;
        }
        field(4; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            var
                DimValue: Record "Dimension Value";
            begin
                if DimValue.Get(1, "Department Code") then
                    "Department Name" := DimValue.Name;
            end;
        }
        field(5; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Risk Rating"; Enum "Audit Risk Ratings")
        {
            Caption = 'Risk Rating';
            DataClassification = ToBeClassified;
        }
        field(7; "Risk Score"; Decimal)
        {
            Caption = 'Risk Score';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(8; "Last Audit Date"; Date)
        {
            Caption = 'Last Audit Date';
            DataClassification = ToBeClassified;
        }
        field(9; "Next Audit Date"; Date)
        {
            Caption = 'Next Audit Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Audit Frequency"; Option)
        {
            Caption = 'Audit Frequency';
            OptionMembers = " ",Annual,"Semi-Annual",Quarterly,Monthly,"Ad-hoc";
            OptionCaption = ' ,Annual,Semi-Annual,Quarterly,Monthly,Ad-hoc';
            DataClassification = ToBeClassified;
        }
        field(11; "Primary Contact"; Code[50])
        {
            Caption = 'Primary Contact';
            TableRelation = "HRM-Employee C"."No.";
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            var
                Employee: Record "HRM-Employee C";
            begin
                if Employee.Get("Primary Contact") then
                    "Primary Contact Name" := Employee.FullName;
            end;
        }
        field(12; "Primary Contact Name"; Text[100])
        {
            Caption = 'Primary Contact Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Budget Amount"; Decimal)
        {
            Caption = 'Budget Amount';
            DataClassification = ToBeClassified;
        }
        field(14; "Budgeted Hours"; Decimal)
        {
            Caption = 'Budgeted Hours';
            DataClassification = ToBeClassified;
        }
        field(15; "Process Description"; Text[250])
        {
            Caption = 'Process Description';
            DataClassification = ToBeClassified;
        }
        field(16; "Key Controls"; Text[250])
        {
            Caption = 'Key Controls';
            DataClassification = ToBeClassified;
        }
        field(17; "Project History"; Integer)
        {
            Caption = 'Project History';
            FieldClass = FlowField;
            CalcFormula = Count("Audit Header" WHERE(Type = CONST(Audit)));
            Editable = false;
        }
        field(18; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Active,Inactive,Suspended;
            OptionCaption = 'Active,Inactive,Suspended';
            DataClassification = ToBeClassified;
        }
        field(19; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Business Impact"; Option)
        {
            Caption = 'Business Impact';
            OptionMembers = " ",Low,Medium,High,Critical;
            OptionCaption = ' ,Low,Medium,High,Critical';
            DataClassification = ToBeClassified;
        }
        field(24; "Regulatory Requirements"; Boolean)
        {
            Caption = 'Regulatory Requirements';
            DataClassification = ToBeClassified;
        }
        field(25; "Background Information"; Blob)
        {
            Caption = 'Background Information';
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(RiskScore; "Risk Score")
        {
        }
        key(Department; "Department Code")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;
    
    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;
}