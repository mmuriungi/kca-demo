table 50102 "GRN Lines List Page"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Serial No"; Code[20])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(5; Quantity; Integer)
        {
        }
        field(6; "Unit Price"; Decimal)
        {
        }
        field(7; "Total Price"; Decimal)
        {
        }
        field(8; "Item No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                Item.RESET;
                Item.SETRANGE(Item."No.", "Item No.");
                IF Item.FIND('-') THEN
                    Description := Item.Description;
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record "Item";
}

