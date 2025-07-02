table 51379 "Item Transfer Line"
{
    Caption = 'Item Transfer Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Transfer No."; Code[20])
        {
            Caption = 'Transfer No.';
            TableRelation = "Item Transfer Header"."No.";
            DataClassification = ToBeClassified;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }

        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No." where(Type = const(Inventory));
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Item.Get("Item No.") then begin
                    Description := Item.Description;
                    "Unit of Measure Code" := Item."Base Unit of Measure";
                end else
                    Clear(Description);

                CalcAvailableQuantity();
            end;
        }

        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(5; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
            DataClassification = ToBeClassified;
        }

        field(6; "Location From Code"; Code[10])
        {
            Caption = 'Location From Code';
            TableRelation = Location.Code;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcAvailableQuantity();
            end;
        }

        field(7; "Location To Code"; Code[10])
        {
            Caption = 'Location To Code';
            TableRelation = Location.Code;
            DataClassification = ToBeClassified;
        }

        field(8; "Quantity Available"; Decimal)
        {
            Caption = 'Quantity Available';
            DecimalPlaces = 0 : 5;
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(9; "Quantity to Transfer"; Decimal)
        {
            Caption = 'Quantity to Transfer';
            DecimalPlaces = 0 : 5;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Quantity to Transfer" > "Quantity Available" then
                    Error('Quantity to transfer cannot exceed available quantity (%1).', "Quantity Available");

                if "Quantity to Transfer" < 0 then
                    Error('Quantity to transfer cannot be negative.');
            end;
        }

        field(10; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DecimalPlaces = 2 : 5;
            DataClassification = ToBeClassified;
        }

        field(11; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            DecimalPlaces = 2 : 5;
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Transfer No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        ItemTransferHeader: Record "Item Transfer Header";
    begin
        if ItemTransferHeader.Get("Transfer No.") then begin
            "Location From Code" := ItemTransferHeader."Location From Code";
            "Location To Code" := ItemTransferHeader."Location To Code";
        end;
    end;

    trigger OnModify()
    begin
        "Total Cost" := "Quantity to Transfer" * "Unit Cost";
    end;

    local procedure CalcAvailableQuantity()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        "Quantity Available" := 0;

        if ("Item No." = '') or ("Location From Code" = '') then
            exit;

        ItemLedgerEntry.SetRange("Item No.", "Item No.");
        ItemLedgerEntry.SetRange("Location Code", "Location From Code");
        ItemLedgerEntry.CalcSums(Quantity);
        "Quantity Available" := ItemLedgerEntry.Quantity;
    end;
}
