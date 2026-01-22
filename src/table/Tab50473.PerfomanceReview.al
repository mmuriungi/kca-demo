/// <summary>
/// Table Perfomance Review (ID 50042).
/// </summary>
table 50473 "Perfomance Review"
{
    Caption = 'Perfomance Review';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Review Period"; Option)
        {
            Caption = 'Review Period';
            OptionMembers = " ","Mid Year","End Year";
            DataClassification = ToBeClassified;
        }
        field(3; "Agreed Targets"; Text[500])
        {
            Caption = 'Agreed Targets';
            DataClassification = ToBeClassified;
            TableRelation = "Targets kra kpi"."Strategic Objectives" where("Employee No" = field("Employee No"), "Appraisal No" = field("Appraisal No"), Period = field(Period));
        }
        field(4; KPIs; Text[500])
        {
            Caption = 'KPIs';
            TableRelation = "Targets kra kpi".KPIs where("Employee No" = field("Employee No"), "Appraisal No" = field("Appraisal No"), Period = field(Period));
            DataClassification = ToBeClassified;
        }
        field(5; "Changed Targets"; Text[500])
        {
            Caption = 'Changed Targets';
            DataClassification = ToBeClassified;
        }
        field(6; "Level of achievement"; Text[500])
        {
            Caption = 'Level of achievement';
            DataClassification = ToBeClassified;
        }
        field(7; "Employee No"; Code[50])
        {
            Caption = 'Employee No';
            DataClassification = ToBeClassified;
        }
        field(8; "Period"; code[20])
        {

        }
        field(9; "Appraisal No"; code[20])
        {

        }
        field(10; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; "Code", "Line No", Period, "Employee No", "Appraisal No")
        {
            Clustered = true;
        }

    }
}
