table 52178576 "Proc Bids Buffer"
{
    DrillDownPageId = "Proc Bids Buffer";
    LookupPageId = "Proc Bids Buffer";
    Caption = 'Proc Bids Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
        field(2; "Document No"; Code[50])
        {
            Caption = 'Document No';
        }
        field(3; "Item No"; Code[50])
        {
            Caption = 'Item No';
        }
        field(4; Supplier; Code[50])
        {
            Caption = 'Supplier';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; "External Doc No"; Code[50])
        {

        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
     trigger OnInsert()
    begin
        if "Entry No" = 0 then
            "Entry No" := GetLastEntryNo() + 1;
    end;
     procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No")))
    end;
}
