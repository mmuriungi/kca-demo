table 51394 "Bank Rec. Archive Line"

{
    Caption = 'Bank Rec. Archive Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Archive Header No."; Code[20])
        {
            Caption = 'Archive Header No.';
            TableRelation = "Bank Rec. Archive Header"."No.";
            DataClassification = CustomerContent;
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(20; "Statement Type"; Option)
        {
            Caption = 'Statement Type';
            OptionCaption = 'Bank Reconciliation,Payment Application';
            OptionMembers = "Bank Reconciliation","Payment Application";
        }
        field(30; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            DataClassification = CustomerContent;
        }
        field(40; "Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(50; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(60; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(70; "Applied Amount"; Decimal)
        {
            Caption = 'Applied Amount';
            DataClassification = CustomerContent;
        }
        //Reference No
        field(80; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
            DataClassification = CustomerContent;
        }
        //Debit amount
        field(90; "Debit Amount"; Decimal)
        {
            Caption = 'Debit Amount';
            DataClassification = CustomerContent;
        }
        //Credit amount
        field(100; "Credit Amount"; Decimal)
        {
            Caption = 'Credit Amount';
            DataClassification = CustomerContent;
        }
        //Description
        field(110; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        //difference
        field(120; "Difference"; Decimal)
        {
            Caption = 'Difference';
            DataClassification = CustomerContent;
        }
        //bank account No
        field(130; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
            DataClassification = CustomerContent;
        }
        //Statement No.
        field(140; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            DataClassification = CustomerContent;
        }
        //Check No.
        field(150; "Check No."; Code[20])
        {
            Caption = 'Check No.';
            DataClassification = CustomerContent;
        }
        //Additional Transaction Info
        field(160; "Additional Transaction Info"; Text[250])
        {
            Caption = 'Additional Transaction Info';
            DataClassification = CustomerContent;
        }
        //Type
        field(170; "Type"; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Bank Account Ledger Entry,Check Ledger Entry,Difference';
            OptionMembers = "Bank Account Ledger Entry","Check Ledger Entry",Difference;

            trigger OnValidate()
            begin


            end;
        }
        field(171; "Applied Entries"; Integer)
        {
            Caption = 'Applied Entries';
            Editable = false;

            trigger OnLookup()
            begin
                //  DisplayApplication;
            end;
        }
        //"Archive Date
        field(180; "Archive Date"; Date)
        {
            Caption = 'Archive Date';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Archive Header No.", "Line No.")
        {
            Clustered = true;
        }
        key(SK1; "Transaction Date")
        {
            SumIndexFields = Amount, "Applied Amount";
        }
    }
}
