table 50184 "Journal Voucher Lines"
{
    Caption = 'Journal Voucher Lines ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(2; "Docuument No"; Code[20])
        {
            Caption = 'Document No';
        }
        field(3; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
        }
        field(4; "Account No"; Code[20])
        {
            Caption = 'Account No';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Account Type" = CONST(Employee)) Employee;
            trigger OnValidate()
             var
           postedRecon: record "Bank Rec. Archive Header";
            begin
                //Reconciliation
                if Rec."Account Type"= Rec."Account Type"::"Bank Account" then 
                postedRecon.RESET;
                postedRecon.SETRANGE(postedRecon."Bank Account No.","Account No");
                postedRecon.SetCurrentKey(postedRecon."Statement Date");
                if postedRecon.FindLast() then begin
                    if postedRecon."Statement Date" > "Posting Date" then
                        error('You cannot select a Bank Account that has been reconciled upto %1', postedRecon."Statement Date");

                end;
            end;
        }
        field(5; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(6; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(8; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; "Account Name"; Text[50])
        {
            Caption = 'Account Name';
        }
        field(11; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(12; processed; Boolean)
        {
            Caption = 'processed';
        }
        field(13; "externalDocumentNo"; Code[20])
        {
            // Caption = 'vendor invoice no';
        }
        field(14; "Balancing Account No"; Code[20])
        {
            // TableRelation = "G/L Account"."No.";
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Bal. Account Type" = CONST(Employee)) Employee;
             trigger OnValidate()
             var
           postedRecon: record "Bank Rec. Archive Header";
            begin
                //Reconciliation
                if Rec."Bal. Account Type"= Rec."Bal. Account Type"::"Bank Account" then 
                postedRecon.RESET;
                postedRecon.SETRANGE(postedRecon."Bank Account No.","Balancing Account No");
                postedRecon.SetCurrentKey(postedRecon."Statement Date");
                if postedRecon.FindLast() then begin
                    if postedRecon."Statement Date" > "Posting Date" then
                        error('You cannot select a Bank Account that has been reconciled upto %1', postedRecon."Statement Date");

                end;
            end;

        }
        field(15; "Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';
        }
        //Reference No
        field(16; "Reference No"; Code[50])
        {
            Caption = 'Reference No';
        }
        field(17; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Journal Batch Name';
        }
        field(18; "Claimed"; Boolean)
        {
            Caption = 'Claimed';
        }






    }
    keys
    {
        key(PK; "Line No", "Docuument No", "Reference No")
        {
            Clustered = true;
        }
        key(pk2; "Docuument No")
        {
        }

    }
}
