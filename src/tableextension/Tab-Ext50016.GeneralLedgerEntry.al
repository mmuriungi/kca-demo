tableextension 50016 "General Ledger Entry" extends "G/L Entry"
{
    fields
    {
        field(50000; Remarks; Text[250])
        {
            Caption = 'Remarks';
            CalcFormula = lookup("FIN-Receipts Header"."Received From" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50001; Payee; Text[250])
        {
            Caption = 'Payee Name';
            CalcFormula = Lookup("FIN-Payments Header".Payee WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50002; "Customer Name"; Text[250])
        {
            Caption = 'Customer Name';
            CalcFormula = lookup(Customer.Name WHERE("No." = FIELD("Bal. Account No.")));
            FieldClass = FlowField;
        }
    }
}
