table 50853 "FIN-Memo Expense Codes Setup"
{
    DrillDownPageID = "FIN-Memo Expense Codes Setup";
    LookupPageID = "FIN-Memo Expense Codes Setup";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Type"; Code[30])
        {

        }
    }

    keys
    {
        key(Key1; "Code", "Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

