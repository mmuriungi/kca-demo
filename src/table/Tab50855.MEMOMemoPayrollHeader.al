table 50855 "MEMO-Memo Payroll Header"
{
    fields
    {
        field(1; "Payee No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Memo Amount"; Decimal)
        {
            CalcFormula = Sum("MEMO-Taxable Entries"."Taxable Amount"
            WHERE("Payee No." = FIELD("Payee No."), "Payroll Period" = FIELD("Payroll Period")));
            Description = 'Amounts on the Memo';
            FieldClass = FlowField;
        }
        field(4; "Gross Period Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Period Gross Pay';
        }
        field(6; N_Tax; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Normal Tax';
        }
        field(7; M_Tax; Decimal)
        {
            CalcFormula = Sum("MEMO-Taxable Entries"."Amount Deducted" WHERE
            ("Payee No." = FIELD("Payee No."), "Payroll Period" = FIELD("Payroll Period")));
            Description = 'Memo Tax';
            FieldClass = FlowField;
        }
        field(8; "Period Taxable Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Period''s Taxable Amount';
        }
        field(9; "Cummulative Taxable Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cumm. Taxable Pay';
        }
        field(10; "C-Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cummulative Tax';
        }
        field(11; "D-Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Tax Difference';
        }
        field(12; "Is Staff"; Boolean)
        {
            CalcFormula = Exist("HRM-Employee C" WHERE("No." = FIELD("Payee No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Payee No.", "Payroll Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        MEMOTaxableEntries.RESET;
        MEMOTaxableEntries.SETRANGE("Payee No.", xRec."Payee No.");
        MEMOTaxableEntries.SETRANGE("Payroll Period", xRec."Payroll Period");
        IF MEMOTaxableEntries.FIND('-') THEN MEMOTaxableEntries.DELETEALL;
    end;

    var
        MEMOTaxableEntries: Record "MEMO-Taxable Entries";
}

