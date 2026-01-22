table 51367 "Custom Gen Ledgers"
{
    Caption = 'Custom Gen Ledgers';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(2; "Document No"; Code[20])
        {
            Caption = 'Document No';
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
        }
        field(5; "Account No"; Code[20])
        {
            Caption = 'Account No';
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(8; "Shortcut dim 1"; Code[20])
        {
            Caption = 'Shortcut dim 1';
        }
        field(9; "Shortcut dim 2"; Code[20])
        {
            Caption = 'Shortcut dim 2';
        }
        field(10; "External Doc No"; Code[100])
        {
            Caption = 'External Doc No';
        }
        field(11; posted; Boolean)
        {
            Caption = 'Posted';
        }
    }
    keys
    {
        key(PK; "Line No")
        {
            Clustered = true;
        }
    }
}
