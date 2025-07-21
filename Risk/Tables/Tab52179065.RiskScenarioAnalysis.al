table 52179065 "Risk Scenario Analysis"
{
    Caption = 'Risk Scenario Analysis';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Scenario ID"; Code[20])
        {
            Caption = 'Scenario ID';
            DataClassification = CustomerContent;
        }
        field(2; "Related Risk ID"; Code[20])
        {
            Caption = 'Related Risk ID';
            DataClassification = CustomerContent;
            TableRelation = "Risk Register"."Risk ID";
        }
        field(3; "Scenario Name"; Text[100])
        {
            Caption = 'Scenario Name';
            DataClassification = CustomerContent;
        }
        field(4; "Scenario Description"; Text[250])
        {
            Caption = 'Scenario Description';
            DataClassification = CustomerContent;
        }
        field(5; "Scenario Type"; Option)
        {
            Caption = 'Scenario Type';
            DataClassification = CustomerContent;
            OptionMembers = " ",Best_Case,Most_Likely,Worst_Case,Stress_Test;
        }
        field(10; "Probability %"; Decimal)
        {
            Caption = 'Probability %';
            DataClassification = CustomerContent;
            MaxValue = 100;
            MinValue = 0;
        }
        field(11; "Financial Impact"; Decimal)
        {
            Caption = 'Financial Impact';
            DataClassification = CustomerContent;
        }
        field(12; "Operational Impact"; Text[100])
        {
            Caption = 'Operational Impact';
            DataClassification = CustomerContent;
        }
        field(13; "Reputational Impact"; Text[100])
        {
            Caption = 'Reputational Impact';
            DataClassification = CustomerContent;
        }
        field(20; "Key Variables"; Text[250])
        {
            Caption = 'Key Variables';
            DataClassification = CustomerContent;
        }
        field(21; "Assumptions"; Text[250])
        {
            Caption = 'Assumptions';
            DataClassification = CustomerContent;
        }
        field(30; "Sensitivity Factor"; Decimal)
        {
            Caption = 'Sensitivity Factor';
            DataClassification = CustomerContent;
        }
        field(31; "Monte Carlo Runs"; Integer)
        {
            Caption = 'Monte Carlo Runs';
            DataClassification = CustomerContent;
        }
        field(40; "Mitigation Strategies"; Text[250])
        {
            Caption = 'Mitigation Strategies';
            DataClassification = CustomerContent;
        }
        field(41; "Contingency Plans"; Text[250])
        {
            Caption = 'Contingency Plans';
            DataClassification = CustomerContent;
        }
        field(50; "Analysis Date"; Date)
        {
            Caption = 'Analysis Date';
            DataClassification = CustomerContent;
        }
        field(51; "Analyst"; Code[50])
        {
            Caption = 'Analyst';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }
        field(52; "Review Date"; Date)
        {
            Caption = 'Review Date';
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
        key(PK; "Scenario ID") { Clustered = true; }
        key(RiskID; "Related Risk ID") { }
        key(Type; "Scenario Type") { }
        key(Probability; "Probability %") { }
    }
    
    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
        "Analysis Date" := Today;
    end;
    
    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;
}