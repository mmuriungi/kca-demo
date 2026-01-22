table 50048 "PesaFlow Invoices"
{
    Caption = 'PesaFlow Invoices';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "BillRefNo"; Code[50])
        {
            Caption = 'Bill Reference No.';
            DataClassification = CustomerContent;
        }
        field(2; "InvoiceNo"; Code[50])
        {
            Caption = 'Invoice No.';
            DataClassification = CustomerContent;
        }
        field(3; "CustomerRefNo"; Code[20])
        {
            Caption = 'Customer Reference No.';
            DataClassification = CustomerContent;
        }
        field(4; "CustomerName"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(5; "InvoiceAmount"; Decimal)
        {
            Caption = 'Invoice Amount';
            DataClassification = CustomerContent;
        }
        field(6; "ServiceID"; Code[50])
        {
            Caption = 'Service ID';
            DataClassification = CustomerContent;
        }
        field(7; "Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(8; "TokenHash"; Text[100])
        {
            Caption = 'Token Hash';
            DataClassification = CustomerContent;
        }
        field(9; "InvoiceLink"; Text[150])
        {
            Caption = 'Invoice Link';
            DataClassification = CustomerContent;
        }
        field(10; "Posted to Core Banking"; Boolean)
        {
            Caption = 'Posted to Core Banking';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; BillRefNo)
        {
            Clustered = true;
        }
    }
}
