tableextension 50036 "Detailled Cust Ledger" extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        field(50; "Description"; Text[200])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Cust. Ledger Entry".Description where("Customer No." = field("Customer No."), "Document No." = field("Document No.")));

        }
    }

}