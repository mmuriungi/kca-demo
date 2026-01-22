table 51363 "PartTime Invoice Batch"
{
    Caption = 'PartTime Invoice Batch';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Batch No."; Code[20])
        {
            Caption = 'Batch No.';
            DataClassification = CustomerContent;
            TableRelation = "Parttime Claims Batch"."No.";
        }
        field(5; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Status"; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = "Open","Posted";
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Batch No.")
        {
            Clustered = true;
        }
    }
}
