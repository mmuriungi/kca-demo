table 51380 "Nav Vendor Ledger"
{
    Caption = 'Nav Vendor Ledger';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
        }
        field(5; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        //BC ledger Amount
        field(6; "BC Ledger Amount"; Decimal)
        {
            Caption = 'BC Ledger Amount';
            FieldClass = FlowField;
            CalcFormula = sum("BC Vendor Ledger"."Amount" where("Document No." = field("Document No."), "Vendor No." = field("Vendor No.")));
        }
        //Nav Ledger Amount
        field(7; "Nav GL Ledger Amount"; Decimal)
        {
            Caption = 'Nav GL Ledger Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Nav GL Ledger"."Amount" where("Document No." = field("Document No.")));
        }
        //BC GL Ledger Amount
        field(8; "BC GL Ledger Amount"; Decimal)
        {
            Caption = 'BC GL Ledger Amount';
            FieldClass = FlowField;
            CalcFormula = sum("BC GL Ledger"."Amount" where("Document No." = field("Document No.")));
        }
    }
    keys
    {
        key(PK; "Entry No.", "Document No.")
        {
            Clustered = true;
        }
    }
}
