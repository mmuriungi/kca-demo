#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 99406 "POS Stock Lines"
{

    fields
    {
        field(1; "No."; Code[30])
        {
            TableRelation = "POS Items"."No.";

            trigger OnValidate()
            begin
                posItem.Reset();
                posItem.SetRange("No.", "No.");
                if posItem.Find('-') then begin
                    Rec.Description := posItem.Description;
                end;
            end;
        }
        field(2; "Document No."; Code[30])
        {
        }
        field(3; Description; Text[100])
        {
        }
        field(4; Quantity; Decimal)
        {
        }
        field(5; Location; Code[30])
        {
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; "No.", "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if UserId <> 'KUCSERVER\ASIMBA' then Error('Cancelled');
    end;

    var
        posItem: Record "POS Items";
}

