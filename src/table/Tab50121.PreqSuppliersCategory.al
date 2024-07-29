table 50121 "Preq Suppliers/Category"
{
    Caption = 'Preq Suppliers/Category';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Preq Year"; Code[20])
        {
            Caption = 'Preq Year';
        }
        field(2; "Preq Category"; Code[20])
        {
            Caption = 'Preq Category';
        }
        field(3; Supplier_Code; Code[20])
        {
            Caption = 'Supplier_Code';
            TableRelation=Vendor."No.";
        }
        field(4; "Supplier Name"; Text[250])
        {
            Caption = 'Supplier Name';
        }
        field(5; Phone; Text[50])
        {
            Caption = 'Phone';
        }
        field(6; Email; Text[250])
        {
            Caption = 'Email';
        }
        field(7; "RFQ Placed"; Integer)
        {
            Caption = 'RFQ Placed';
        }
        field(8; "Quoted Received "; Integer)
        {
            Caption = 'Quoted Received ';
        }
        field(9; "Lpos Placed"; Integer)
        {
            Caption = 'Lpos Placed';
        }
        field(10; "Document No."; code[20])
        {

        }
    }
    keys
    {
        key(PK; "Preq Year")
        {
            Clustered = true;
        }
    }
}
