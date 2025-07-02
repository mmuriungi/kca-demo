table 51374 "Gen Line Custom2"
{
    Caption = 'Gen Line Custom';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            // TableRelation = "Gen. Journal Template";
        }
        field(6; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            //  TableRelation = "Gen. Journal Batch";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';


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
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(13; Amount; Decimal)
        {
        }
        field(14; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(15; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
}
