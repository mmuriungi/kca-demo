table 52178742 "Customer ledger Upload"
{
    Caption = 'Customer ledger Upload';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(2; "Document No"; Code[20])
        {
            Caption = 'Document No';
        }
        field(3; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account  Type';


        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type" = const("Allocation Account")) "Allocation Account"
            else
            if ("Account Type" = const(Employee)) Employee;
        }
        field(5; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; "balalance Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'balalance Account Type';
        }
        field(8; "Balance Ac No"; Code[20])
        {
            Caption = 'Balance Ac No';
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false));

        }
        field(11; "External Doc No"; Code[20])
        {
            Caption = 'External Doc No';
        }
        field(12; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(13; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Line No", "Posting Date")
        {
            Clustered = true;
        }
    }
    var
        genline: Record "Gen. Journal Line";
}
