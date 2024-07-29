table 54336 "Hostel Stock lines&"
{
    Caption = 'Hostel Stock lines';
    DataClassification = ToBeClassified;

    // LookupPageId = " hostel Store lines";
    // DrillDownPageId = " hostel Store lines";
    fields
    {
        field(1; "No."; Code[30])
        {
            TableRelation = "Hostel Items"."No.";
            trigger OnValidate()
            var
                hoItem: Record "Hostel Items";
            begin
                hoItem.Reset();
                hoItem.get("No.");
                begin
                    rec.Description := hoItem.Description;
                    Modify();
                end;


            end;

        }
        field(2; "Document No."; Code[20])
        {
            Editable = true;

        }
        field(3; Description; Text[100])
        {

        }
        field(9; Reason; text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Quantity"; Decimal)
        {

        }

    }

    keys
    {
        key(key1; "No.", "Document No.")
        {

        }
    }
    var
        PharHeader: Record "Hostel Stock Header";

    trigger OnDelete()
    begin
        PharHeader.Reset();
    end;

}
