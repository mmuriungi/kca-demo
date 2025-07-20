table 52179003 "CRM Transaction"
{
    DataClassification = CustomerContent;
    Caption = 'CRM Transaction';
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = "CRM Customer";
        }
        field(3; "Transaction Type"; Enum "CRM Transaction Type")
        {
            Caption = 'Transaction Type';
        }
        field(4; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
        }
        field(5; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(7; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
        }
        field(9; "Payment Method"; Enum "CRM Payment Method")
        {
            Caption = 'Payment Method';
        }
        field(10; "Campaign Code"; Code[20])
        {
            Caption = 'Campaign Code';
            TableRelation = "CRM Campaign";
        }
        field(11; "Status"; Enum "CRM Transaction Status")
        {
            Caption = 'Status';
        }
        field(12; "Source Document Type"; Enum "CRM Document Type")
        {
            Caption = 'Source Document Type';
        }
        field(13; "Source Document No."; Code[20])
        {
            Caption = 'Source Document No.';
        }
        field(14; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(15; "Programme Code"; Code[20])
        {
            Caption = 'Programme Code';
        }
        field(16; "Donation Category"; Code[20])
        {
            Caption = 'Donation Category';
        }
        field(17; "Tax Amount"; Decimal)
        {
            Caption = 'Tax Amount';
        }
        field(18; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
        }
        field(19; "Processed Date"; DateTime)
        {
            Caption = 'Processed Date';
        }
        field(20; "Processed By"; Code[50])
        {
            Caption = 'Processed By';
            TableRelation = User."User Name";
        }
        field(21; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
        field(22; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(23; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(24; "External Reference"; Text[50])
        {
            Caption = 'External Reference';
        }
        field(25; "Bank Account"; Code[20])
        {
            Caption = 'Bank Account';
            TableRelation = "Bank Account";
        }
        field(26; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
        }
        field(27; "Fiscal Year"; Code[20])
        {
            Caption = 'Fiscal Year';
        }
        field(28; "GL Account No."; Code[20])
        {
            Caption = 'GL Account No.';
            TableRelation = "G/L Account";
        }
        field(29; "Dimension 1 Code"; Code[20])
        {
            Caption = 'Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(30; "Dimension 2 Code"; Code[20])
        {
            Caption = 'Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
    }
    
    keys
    {
        key(PK; "Entry No.", "Customer No.")
        {
            Clustered = true;
        }
        key(Customer; "Customer No.", "Transaction Date")
        {
        }
        key(Date; "Transaction Date")
        {
        }
        key(Type; "Transaction Type")
        {
        }
        key(Campaign; "Campaign Code")
        {
        }
        key(Status; "Status")
        {
        }
        key(Amount; "Amount")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
        if "Transaction Date" = 0D then
            "Transaction Date" := WorkDate();
        if "Status" = "Status"::" " then
            "Status" := "Status"::Pending;
        If "Entry No." = 0 then 
            "Entry No." := Random(1000000);
    end;
}