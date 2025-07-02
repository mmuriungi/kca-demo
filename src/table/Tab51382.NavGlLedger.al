table 51382 "Nav Gl Ledger"
{
    Caption = 'Nav Gl Ledger';
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
        //BC Ledger Amount
        field(6; "BC Ledger Amount"; Decimal)
        {
            Caption = 'BC Ledger Amount';
            FieldClass = FlowField;
            CalcFormula = sum("BC GL Ledger"."Amount" where("Document No." = field("Document No.")));
        }
        //BC Vendor Ledger Amount
        field(7; "BC Vendor Ledger Amount"; Decimal)
        {
            Caption = 'BC Vendor Ledger Amount';
            FieldClass = FlowField;
            CalcFormula = sum("BC Vendor Ledger"."Amount" where("Document No." = field("Document No.")));
        }
        //Nav Vendor Ledger Amount
        field(8; "Nav Vendor Ledger Amount"; Decimal)
        {
            Caption = 'Nav Vendor Ledger Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Nav Vendor Ledger"."Amount" where("Document No." = field("Document No.")));
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
