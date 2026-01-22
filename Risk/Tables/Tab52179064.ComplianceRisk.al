table 52179064 "Compliance Risk"
{
    Caption = 'Compliance Risk';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Compliance ID"; Code[20])
        {
            Caption = 'Compliance ID';
            DataClassification = CustomerContent;
        }
        field(2; "Related Risk ID"; Code[20])
        {
            Caption = 'Related Risk ID';
            DataClassification = CustomerContent;
            TableRelation = "Risk Register"."Risk ID";
        }
        field(3; "Regulation/Standard"; Text[100])
        {
            Caption = 'Regulation/Standard';
            DataClassification = CustomerContent;
        }
        field(4; "Requirement Description"; Text[250])
        {
            Caption = 'Requirement Description';
            DataClassification = CustomerContent;
        }
        field(5; "Regulatory Body"; Text[50])
        {
            Caption = 'Regulatory Body';
            DataClassification = CustomerContent;
        }
        field(10; "Compliance Status"; Option)
        {
            Caption = 'Compliance Status';
            DataClassification = CustomerContent;
            OptionMembers = " ",Compliant,Partially_Compliant,Non_Compliant,Under_Review;
        }
        field(11; "Risk Level"; Enum "Risk Rating")
        {
            Caption = 'Risk Level';
            DataClassification = CustomerContent;
        }
        field(20; "Last Assessment Date"; Date)
        {
            Caption = 'Last Assessment Date';
            DataClassification = CustomerContent;
        }
        field(21; "Next Assessment Date"; Date)
        {
            Caption = 'Next Assessment Date';
            DataClassification = CustomerContent;
        }
        field(22; "Assessment Frequency"; DateFormula)
        {
            Caption = 'Assessment Frequency';
            DataClassification = CustomerContent;
            
            trigger OnValidate()
            begin
                if Format("Assessment Frequency") <> '' then
                    "Next Assessment Date" := CalcDate("Assessment Frequency", "Last Assessment Date");
            end;
        }
        field(30; "Responsible Officer"; Code[50])
        {
            Caption = 'Responsible Officer';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }
        field(31; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('DEPARTMENT'));
        }
        field(40; "Action Plan"; Text[250])
        {
            Caption = 'Action Plan';
            DataClassification = CustomerContent;
        }
        field(41; "Target Completion Date"; Date)
        {
            Caption = 'Target Completion Date';
            DataClassification = CustomerContent;
        }
        field(42; "Actual Completion Date"; Date)
        {
            Caption = 'Actual Completion Date';
            DataClassification = CustomerContent;
        }
        field(50; "Penalties/Consequences"; Text[250])
        {
            Caption = 'Penalties/Consequences';
            DataClassification = CustomerContent;
        }
        field(51; "Evidence/Documentation"; Text[100])
        {
            Caption = 'Evidence/Documentation';
            DataClassification = CustomerContent;
        }
        field(60; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(61; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(62; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(63; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    
    keys
    {
        key(PK; "Compliance ID") { Clustered = true; }
        key(RiskID; "Related Risk ID") { }
        key(Status; "Compliance Status") { }
        key(Assessment; "Next Assessment Date") { }
    }
    
    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;
    
    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;
}