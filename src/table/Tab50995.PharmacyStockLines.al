table 50995 "Pharmacy Stock Lines"
{
    LookupPageId = "Pharmacy Stock Lines";
    DrillDownPageId = "Pharmacy Stock Lines";
    fields
    {
        field(1; "No."; Code[30])
        {
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                PharItem: Record Item;
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
        PharHeader: Record "Pharmacy Stock Header";

    trigger OnDelete()
    begin
        PharHeader.Reset();

    end;
}