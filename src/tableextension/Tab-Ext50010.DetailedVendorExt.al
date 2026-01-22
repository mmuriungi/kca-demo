tableextension 50010 "Detailed Vendor Ext" extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        field(500000; "Vendor Transaction Type"; Enum "Vendor Transaction Type")
        {
            Caption = 'Vendor Transaction Type';
            DataClassification = ToBeClassified;
        }
        field(500001; CustoAmount; Decimal)
        {
            Caption = 'Vendor Transaction Type';
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum("custom detail vend ledgers".Amount WHERE("Vendor No." = FIELD("Vendor No."), "Document No." = FIELD("Document No."), "Posting Date" = field("Posting Date"),
        "Entry Type" = CONST("Initial Entry")));
        }
        field(500002; LedgerAmount; Decimal)
        {
            Caption = 'Vendor Transaction Type';
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("Vendor No."), "Document No." = FIELD("Document No."), "Posting Date" = field("Posting Date"),
        "Entry Type" = CONST("Initial Entry")));
        }
    }
}
