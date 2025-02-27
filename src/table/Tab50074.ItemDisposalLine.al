table 50074 "Item Disposal Line"
{
    DataClassification = CustomerContent;
    
    FIELDS
    {
        FIELD(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
            TableRelation = "Item Disposal Header"."No.";
        }
        FIELD(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        FIELD(3; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
            TableRelation = Item;
            
            TRIGGER OnValidate()
            VAR
                Item: Record Item;
            BEGIN
                IF Item.GET("Item No.") THEN BEGIN
                    Description := Item.Description;
                    "Unit of Measure Code" := Item."Base Unit of Measure";
                END;
            END;
        }
        FIELD(4; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        FIELD(5; "Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
            DecimalPlaces = 0:5;
            MinValue = 0;
            
            TRIGGER OnValidate()
            BEGIN
                VALIDATE("Cost Amount", "Unit Cost" * Quantity);
            END;
        }
        FIELD(6; "Unit of Measure Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        FIELD(7; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Cost';
            AutoFormatType = 1;
            
            TRIGGER OnValidate()
            BEGIN
                VALIDATE("Cost Amount", "Unit Cost" * Quantity);
            END;
        }
        FIELD(8; "Cost Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cost Amount';
            AutoFormatType = 1;
            Editable = false;
        }
        FIELD(9; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Location Code';
            TableRelation = Location;
        }
        FIELD(10; "Bin Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
        }
        FIELD(11; "Variant Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        FIELD(12; "Serial No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Serial No.';
        }
        FIELD(13; "Lot No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot No.';
        }
        FIELD(14; "Reason Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason Description';
        }
    }
    
    KEYS
    {
        KEY(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        KEY(Key2; "Item No.")
        {
        }
    }
}