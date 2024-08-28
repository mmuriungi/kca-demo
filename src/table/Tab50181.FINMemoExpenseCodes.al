table 50181 "FIN-Memo Expense Codes"
{
    DrillDownPageId = "FIN-Memo Expense Codes";

    fields
    {
        field(1; "Memo No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "FIN-Memo Header"."No.";
        }
        field(2; "Expense Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "FIN-Memo Expense Codes Setup".Code;
            trigger OnValidate()
            var
                EPSetup: Record "FIN-Memo Expense Codes Setup";
            begin
                EPSetup.Reset();
                EPSetup.SetRange(Code, Rec."Expense Code");
                if EPSetup.Find('-') then
                    Rec.Type := EPSetup.Type;
            end;
        }
        field(3; "Details Exists"; Boolean)
        {
            CalcFormula = Exist("FIN-Memo Details" WHERE("Memo No." = FIELD("Memo No."),
                                                          "Expense Code" = FIELD("Expense Code")));
            FieldClass = FlowField;
        }
        field(4; "Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = "FIN-Memo Expense Codes Setup".Type;

        }

    }

    keys
    {
        key(Key1; "Memo No.", "Expense Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

