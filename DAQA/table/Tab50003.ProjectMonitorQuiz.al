table 51355 "Project Monitor Quiz"
{
    Caption = 'Project Monitor Quiz';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Semester Code"; Code[25])
        {
            Caption = 'Semester Code';
            TableRelation = "ACA-Semesters";
        }
        field(2; "Quiz No."; Integer)
        {
            Caption = 'Quiz No.';
            AutoIncrement = true;
        }
        field(3; "Period From"; Date)
        {
            Caption = 'Period From';
            FieldClass = FlowField;
            CalcFormula = lookup("Survey Header"."Start Date" where("Survey Code" = field("Survey Code")));
        }
        field(4; "Period To"; Date)
        {
            Caption = 'Period To';
            FieldClass = FlowField;
            CalcFormula = lookup("Survey Header"."End Date" where("Survey Code" = field("Survey Code")));
        }
        field(6; Question; Text[2048])
        {
            Caption = 'Question';
        }
        field(10; "Requires Drill-Down"; Boolean)
        {
            Caption = 'Requires Drill-Down';
        }
        field(11; "Question Type"; Enum "Question Answer Type")
        {
            Caption = 'Question Type';
        }
        field(12; "Question Category"; Enum "Question Category")
        {
            Caption = 'Question Category';
        }
        field(13; "Survey Code"; Code[20])
        {
            Caption = 'Survey Code';
            TableRelation = "Survey Header";
        }
        field(14; "Mandatory"; Boolean)
        {
            Caption = 'Mandatory';
        }
        field(15; "Activates Question"; Integer)
        {
            Caption = 'Activates Question';
        }
        field(16; "Activates Based On Answer"; Option)
        {
            Caption = 'Activates Based On Answer';
            OptionMembers = " ",Yes,No,Other,Both;
        }
        field(17; "Activates Based On Value"; Text[2048])
        {
            Caption = 'Activates Based On Answer Value';
        }
    }
    keys
    {
        key(PK; "Semester Code", "Quiz No.", "Survey Code")
        {
            Clustered = true;
        }
    }
}
