
table 51393 "ArchiveBank LedgerEntries(Rec)"


{
    Caption = 'ArchiveBank LedgerEntries(Rec)';
    DataClassification = ToBeClassified;

    fields
    {
        // Add a unique archive entry number as primary key
        field(1; "Archive Entry No."; Integer)
        {
            Caption = 'Archive Entry No.';
            AutoIncrement = true;
        }
        field(2; "Statement No"; Code[50])
        {
            Caption = 'Statement No';
        }
        field(3; Applied; Boolean)
        {
            Caption = 'Applied';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';
        }
        field(6; "Document No"; Code[50])
        {
            Caption = 'Document No';
        }
        field(7; Descrption; Text[250])
        {
            Caption = 'Description';
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(9; Open; Boolean)
        {
            Caption = 'Open';
        }
        field(10; "Check Ledger Entries"; Integer)
        {
            Caption = 'Check Ledger Entries';
        }
        field(11; "External Document No."; Code[50])
        {
            Caption = 'External Document No.';
        }
        field(12; "Bank Account No"; Code[20])
        {
            Caption = 'Bank Account No';
        }
        field(13; "Entry No"; Integer)
        {
            Caption = 'Original Entry No'; // This is the original bank ledger entry number
        }
        field(14; "Archive Header No."; Code[20])
        {
            Caption = 'Archive Header No.';
        }
        field(15; "Statement Line No"; Integer)
        {
            Caption = 'Statement Line No';
        }
        field(16; "Remaining Amount"; Decimal)
        {
            Caption = 'Remaining Amount';
        }
        field(17; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(18; "Archive Date"; Date)
        {
            Caption = 'Archive Date';
        }
        field(19; "Statement Status"; Option)
        {
            Caption = 'Statement Status';
            OptionCaption = 'Open,Bank Acc. Entry Applied,Check Entry Applied,Closed';
            OptionMembers = Open,"Bank Acc. Entry Applied","Check Entry Applied",Closed;
        }
        field(20; Remarks; Text[250])
        {
            Caption = 'Remarks';
        }
        field(21; "Statement Difference"; Decimal)
        {
            Caption = 'Statement Difference';
        }
        field(22; "Credit Amount"; Decimal)
        {
            Caption = 'Credit Amount';
        }
        field(23; Reversed; Boolean)
        {
            Caption = 'Reversed';
        }
        field(24; "Debit Amount"; Decimal)
        {
            Caption = 'Debit Amount';
        }
        // Add field to track if this entry was applied in this specific reconciliation
        field(25; "Applied in This Recon"; Boolean)
        {
            Caption = 'Applied in This Reconciliation';
        }
        // Add field to store the reconciliation statement number
        field(26; "Reconciliation Statement No"; Code[50])
        {
            Caption = 'Reconciliation Statement No';
        }
    }
    keys
    {
        key(PK; "Archive Entry No.")
        {
            Clustered = true;
        }
        key(SK1; "Archive Header No.", "Entry No")
        {
        }
        key(SK2; "Bank Account No", "Entry No", "Archive Date")
        {
        }
        key(SK3; "Reconciliation Statement No", "Entry No")
        {
        }
    }
}