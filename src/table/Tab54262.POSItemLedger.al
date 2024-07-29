table 54262 "POS Item Ledger"
{
    LookupPageId = "POS Item Ledger";
    DrillDownPageId = "POS Item Ledger";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Entry Type"; Option)
        {
            OptionMembers = "Positive Adjmt.","Negative Adjmt.","Sale","Stock Clearance";
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(15; "Amount"; Decimal)
        {

        }
        field(16; "Spill Over"; Boolean)
        {

        }
        field(50; "User ID"; code[20])
        {

        }
    }

    trigger OnInsert()
    begin
        "User ID" := UserId;
    end;

    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No.")))
    end;
}