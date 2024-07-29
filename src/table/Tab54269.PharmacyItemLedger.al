table 54269 "Pharmacy Item Ledger"
{
    LookupPageId = "Pharmacy Item Ledger";
    DrillDownPageId = "Pharmacy Item Ledger";
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
        field(4; "Entry Type"; Enum "Item Ledger Entry Type")
        {
            Caption = 'Entry Type';
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
        field(16; "Student No."; code[30])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS-Pharmacy Header"."Student No." where("Pharmacy No." = field("Document No.")));
        }
        field(17; "Patient No."; code[30])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS-Pharmacy Header"."Patient No." where("Pharmacy No." = field("Document No.")));
        }

        field(50; "User ID"; code[20])
        {

        }
    }

    keys
    {
        key(key1; "Entry No.", "Item No.", "Document No.")
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