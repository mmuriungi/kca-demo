table 50187 "MEMO-Taxable Entries"
{

    fields
    {
        field(1; "Payee No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Payee Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Is Staff"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Memo Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Memo Date"; Date)
        {
            CalcFormula = Lookup("FIN-Memo Header"."Date/Time" WHERE("No." = FIELD("Memo Number")));
            FieldClass = FlowField;
        }
        field(6; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Taxable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Amount Deducted"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Memo Entry,Payroll Posting,Carry Forward,Brought Down';
            OptionMembers = "Memo Entry","Payroll Posting","Carry Forward","Brought Down";
        }
        field(10; "Expense Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Payee No.", "Memo Number", "Payroll Period", "Expense Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

