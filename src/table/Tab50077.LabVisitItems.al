table 50077 "Lab Visit Items"
{
    Caption = 'Lab Visit Items';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[25])
        {
            Caption = 'Code';
        }
        field(2; "Item No."; Code[25])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Item.GET("Item No.") then begin
                    "Item Description" := Item.Description;
                    "Unit of Measure" := Item."Sales Unit of Measure";
                end;
            end;
        }
        field(3; "Item Description"; Text[150])
        {
            Caption = 'Item Description';
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(5; "Unit of Measure"; Code[25])
        {
            Caption = 'Unit of Measure';
        }
        //lab visit no
        field(6; "Lab Visit No."; Code[25])
        {
            Caption = 'Lab Visit No.';
        }
    }
    keys
    {
        key(PK; "Lab Visit No.", "Code", "Item No.")
        {
            Clustered = true;
        }
    }
}
