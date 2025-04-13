table 51356 "Project Quiz Answers"
{
    Caption = 'Project Quiz Answers';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Project No."; Code[25])
        {
            Caption = 'Project No.';
        }
        field(2; "Quiz No."; Integer)
        {
            Caption = 'Quiz No.';
            trigger OnValidate()
            var
                pquiz: Record "Project Monitor Quiz";
            begin
                pquiz.Reset();
                pquiz.SetRange("Project No.", "Project No.");
                pquiz.SetRange("Quiz No.", "Quiz No.");
                if pquiz.FindFirst() then begin
                    "Period From" := pquiz."Period From";
                    "Period To" := pquiz."Period To";
                    "Question" := pquiz."Question";
                    "Question Type" := pquiz."Question Type";
                    "Survey Code" := pquiz."Survey Code";
                end;

            end;
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
        field(8; "Text Answer"; Text[2048])
        {
            Caption = 'Text Answer';
        }
        field(9; "Boolean Answer"; Boolean)
        {
            Caption = 'Boolean Answer';
        }
        field(12; "Answered By"; Text[250])
        {
            Caption = 'Answered By';
        }
        field(13; "Answered Date"; DateTime)
        {
            Caption = 'Answered Date';
        }
        field(14; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;

        }
        field(11; "Question Type"; Enum "Question Answer Type")
        {
            Caption = 'Question Type';
        }
        field(15; "Survey Code"; Code[20])
        {
            Caption = 'Survey Code';
            TableRelation = "Survey Header";
        }
        field(16; "Answered By Email"; Text[250])
        {

        }
        field(17; "Number Answer"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Survey Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Survey Header".Description where("Survey Code" = field("Survey Code")));
        }
    }
    keys
    {
        key(PK; "Project No.", "Quiz No.", "Entry No.", "Survey Code")
        {
            Clustered = true;
        }
    }
}
