table 51067 "hostel stock lines"
{
    Caption = 'hostel stock lines';
    LookupPageId = "hostel Stock Lines";
    DrillDownPageId = "hostel Stock Lines";
    fields
    {
        field(1; "No."; Code[30])
        {
            TableRelation = "Hostel Sub-Store"."No.";
            trigger OnValidate()
            var
                PharItem: Record "Hostel Sub-Store";
            begin
                PharItem.Reset();
                PharItem.SetRange("No.", "No.");
                if PharItem.Find('-') then begin
                    Rec.Description := PharItem.Description;
                end;

            end;

        }
        field(2; "Document No."; Code[20])
        {

        }
        field(3; Description; Text[100])
        {

        }
        field(4; "Quantity"; Integer)
        {

        }
        field(5; "transaction type"; Option)
        {
            OptionMembers = "",Issue,Receive;
            DataClassification = ToBeClassified;
        }
        field(6; "Reason for adjustment"; Code[100])
        {

            DataClassification = ToBeClassified;
        }
        field(7; Staff; code[58])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";

        }
        field(8; Name; Code[46])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(key1; "No.", "Document No.")
        {

        }
    }
    var
        PharHeader: Record "Stock Hostel Header";

    trigger OnDelete()
    begin
        PharHeader.Reset();

    end;
}