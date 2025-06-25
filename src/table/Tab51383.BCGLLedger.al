table 51383 "BC GL Ledger"
{
    Caption = 'BC GL Ledger';
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
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
        }
        field(5; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        //Nav Ledger Amount 
        field(6; "Nav Ledger Amount"; Decimal)
        {
            Caption = 'Nav Ledger Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Nav GL Ledger"."Amount" where("Document No." = field("Document No.")));
        }
        //Nav Vendor Ledger Amount
        field(7; "Nav Vendor Ledger Amount"; Decimal)
        {
            Caption = 'Nav Vendor Ledger Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Nav Vendor Ledger"."Amount" where("Document No." = field("Document No.")));
        }
        //Nav GL Ledger Amount
        field(8; "Nav GL Ledger Amount"; Decimal)
        {
            Caption = 'Nav GL Ledger Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Nav GL Ledger"."Amount" where("Document No." = field("Document No.")));
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
