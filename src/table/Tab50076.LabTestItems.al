table 50076 "Lab Test Items"
{
    Caption = 'Lab Test Items';
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
    }
    keys
    {
        key(PK; "Code", "Item No.")
        {
            Clustered = true;
        }
    }
}
