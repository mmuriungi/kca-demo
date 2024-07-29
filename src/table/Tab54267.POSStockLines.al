table 54267 "POS Stock Lines"
{
    LookupPageId = "POS Stock Lines";
    DrillDownPageId = "POS Stock Lines";
    fields
    {
        field(1; "No."; Code[30])
        {
            TableRelation = "POS Items"."No.";
            trigger OnValidate()
            var
                posItem: Record "POS Items";
            begin
                posItem.Reset();
                posItem.SetRange("No.", "No.");
                if posItem.Find('-') then begin
                    Rec.Description := posItem.Description;
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
        field(5; "Inventory"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("POS Item Ledger".Quantity where("Item No." = field("No.")));
        }

    }

    keys
    {
        key(key1; "No.", "Document No.")
        {

        }
    }
}