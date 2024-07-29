table 54857 "HMS-Pharmacy Line"
{

    fields
    {
        field(1; "Pharmacy No."; Code[20])
        {
            TableRelation = "HMS-Pharmacy Header"."Pharmacy No.";
        }
        field(2; "Drug No."; Code[20])
        {
            TableRelation = IF ("Drugs Category" = FILTER('')) Item."No." WHERE("Inventory Posting Group" = CONST('MEDICAL'))
            ELSE
            IF ("Drugs Category" = FILTER(<> '')) Item."No." WHERE("Item Category Code" = FIELD("Drugs Category"));
        }
        field(3; "Drug Name"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Drug No.")));
            FieldClass = FlowField;
        }
        field(4; Quantity; Decimal)
        {

            trigger OnValidate()
            begin
                /*Get the actual quantity*/
                ItemUnitOfMeasure.RESET;
                ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure."Item No.", "Drug No.");
                ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure.Code, "Measuring Unit");
                IF ItemUnitOfMeasure.FIND('-') THEN BEGIN
                    "Actual Qty" := ItemUnitOfMeasure."Qty. per Unit of Measure" * Quantity;
                    Item.RESET;
                    IF Item.GET("Drug No.") THEN BEGIN
                        "Unit Price" := Item."Unit Price";
                        "Actual Price" := "Actual Qty" * "Unit Price";
                        Remaining := "Actual Qty";
                    END;
                END;

            end;
        }
        field(5; "Measuring Unit"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code;
        }
        field(6; "Unit Price"; Decimal)
        {
        }
        field(7; "Actual Qty"; Decimal)
        {
        }
        field(8; "Actual Price"; Decimal)
        {
        }
        field(9; "Issued Quantity"; Decimal)
        {

            trigger OnValidate()
            begin
                /*Get the actual quantity*/
                ItemUnitOfMeasure.RESET;
                ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure."Item No.", "Drug No.");
                ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure.Code, "Measuring Unit");
                IF ItemUnitOfMeasure.FIND('-') THEN BEGIN
                    "Issued Units" := ItemUnitOfMeasure."Qty. per Unit of Measure" * "Issued Quantity";
                    Item.RESET;
                    IF Item.GET("Drug No.") THEN BEGIN
                        "Issued Price" := "Issued Units" * "Unit Price";
                    END;
                    IF "Issued Units" > Remaining THEN BEGIN
                        ERROR('Issued Units cannot exceed Remaining Units');
                    END;
                END;

            end;
        }
        field(10; "Issued Units"; Decimal)
        {
        }
        field(11; "Issued Price"; Decimal)
        {
        }
        field(12; Dosage; Text[100])
        {
        }
        field(13; Remarks; Text[200])
        {
        }
        field(14; Pharmacy; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(15; Remaining; Decimal)
        {
        }
        field(16; Date; Date)
        {
            CalcFormula = Lookup("HMS-Pharmacy Header"."Pharmacy Date" WHERE("Pharmacy No." = FIELD("Pharmacy No.")));
            FieldClass = FlowField;
        }
        field(17; "Link No."; Code[20])
        {
            CalcFormula = Lookup("HMS-Pharmacy Header"."Link No." WHERE("Pharmacy No." = FIELD("Pharmacy No.")));
            FieldClass = FlowField;
        }
        field(18; "Link Type"; Code[20])
        {
            CalcFormula = Lookup("HMS-Pharmacy Header"."Link Type" WHERE("Pharmacy No." = FIELD("Pharmacy No.")));
            FieldClass = FlowField;
        }
        field(19; "Drugs Category"; Code[20])
        {
            TableRelation = "Item Category".Code;
        }
        field(20; "No Stock Drugs"; Text[250])
        {
        }
        field(25; "Treatment No."; code[20])
        {

        }

    }

    keys
    {
        key(Key1; "Pharmacy No.", "Drug No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ItemUnitOfMeasure: Record 5404;
        Item: Record 27;
}

