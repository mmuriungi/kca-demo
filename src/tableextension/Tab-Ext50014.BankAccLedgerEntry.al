tableextension 50014 "Bank Acc. Ledger Entry" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50000; "Statement Difference"; Decimal)
        {
            Caption = 'Statement Difference';
            DataClassification = ToBeClassified;
        }
        field(50001; Remarks; Text[200])
        {
            Caption = 'Remarks';
            CalcFormula = lookup("FIN-Receipts Header"."Received From" where("No." = field("Document No.")));
            FieldClass = FlowField;

        }
        field(50002; "Payee Name"; Text[200])
        {
            Caption = 'Payee Name';
            CalcFormula = Lookup("FIN-Payments Header".Payee WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50003; "Customer Name"; Text[200])
        {
            Caption = 'Customer Name';
            CalcFormula = lookup(Customer.Name WHERE("No." = FIELD("Bal. Account No.")));
            FieldClass = FlowField;

        }
    }
}
