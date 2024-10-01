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
        //"Item Specification"
        field(50003; "Item Specification"; Text[250])
        {
            Caption = 'Item Specification';
        }
        //"Currency Code"
        field(50004; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
        }
        //"Exchange Rate to Base Currency"
        field(50005; "Exchange Rate to Base Currency"; Decimal)
        {
            Caption = 'Exchange Rate to Base Currency';
        }
    }
}
