table 50903 "Meal-Proc. BOM Prod. Source"
{
    DrillDownPageID = "Meal-Proc. Order Details";
    LookupPageID = "Meal-Proc. Order Details";

    fields
    {
        field(1; "Batch Date"; Date)
        {
        }
        field(2; "Parent Item"; Code[20])
        {
            Caption = 'No.';
            TableRelation = Item."No." WHERE(//"Production Area"=FILTER(<>' '),
                                            "Production BOM No." = FILTER(<> '')
                                            // ,
                                            // "Item Category Code"=FILTER('PRODUCTS')
                                            );
        }
        field(3; "Item No."; Code[20])
        {
            TableRelation = Item."No.";

            trigger OnValidate()
            begin

                IF Item.GET(Rec."Item No.") THEN BEGIN
                    "Unit of Measure" := Item."Sales Unit of Measure";
                    "Control Unit of Measure" := Item."Control Unit of Measure";

                    CLEAR(NewItemQuantity);
                    CLEAR(OldItemQuantity);
                    ItemUnitofMeasure.RESET;
                    ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.", Rec."Item No.");
                    ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure.Code, Item."Control Unit of Measure");
                    IF ItemUnitofMeasure.FIND('-') THEN BEGIN
                        OldItemQuantity := ItemUnitofMeasure."Qty. per Unit of Measure";
                    END;
                    ItemUnitofMeasure.RESET;
                    ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.", Rec."Item No.");
                    ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure.Code, "Unit of Measure");
                    IF ItemUnitofMeasure.FIND('-') THEN BEGIN
                        NewItemQuantity := ItemUnitofMeasure."Qty. per Unit of Measure";
                    END;
                    IF ((NewItemQuantity <> 0) AND (OldItemQuantity <> 0)) THEN BEGIN
                    END;
                END;
            end;
        }
        field(4; Description; Text[150])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(5; "Created By"; Code[20])
        {
        }
        field(6; "Item Quantity"; Decimal)
        {

            trigger OnValidate()
            begin

                ComputeTotalValues();

                "Captured By" := USERID;
                "Captured Time" := TIME;
            end;
        }
        field(7; "Unit Price"; Decimal)
        {

            trigger OnValidate()
            begin
                ComputeTotalValues;
            end;
        }
        field(8; "Line Amount"; Decimal)
        {
        }
        field(37; Approve; Boolean)
        {
            CalcFormula = Lookup("Meal-Proc. Batch Lines".Approve WHERE("Batch Date" = FIELD("Batch Date"),
                                                                         "Item Code" = FIELD("Parent Item")
                                                                         //  ,
                                                                         //  "Production  Area"=FIELD("Production  Area")
                                                                         ));
            FieldClass = FlowField;
        }
        field(38; Reject; Boolean)
        {
            CalcFormula = Lookup("Meal-Proc. Batch Lines".Reject WHERE("Batch Date" = FIELD("Batch Date"),
                                                                        "Item Code" = FIELD("Parent Item")
                                                                        // ,
                                                                        // Production  Area=FIELD(Production  Area)
                                                                        ));
            FieldClass = FlowField;
        }
        field(39; "Unit of Measure"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate()
            begin
                ComputeTotalValues
            end;
        }
        field(41; "Captured Time"; Time)
        {
        }
        field(42; "Captured By"; Code[20])
        {
        }
        field(44; "Control Unit of Measure"; Code[20])
        {
        }
        field(45; "Control Quantity"; Decimal)
        {
        }
        field(300; "Production  Area"; Option)
        {
            OptionCaption = ' ,Kitchen,Location a,Location b';
            OptionMembers = " ",Kitchen,"Location a","Location b";
        }
        field(301; "BOM Design Quantity"; Decimal)
        {
        }
        field(302; "Consumption Quantiry"; Decimal)
        {
        }
        field(311; "Batch ID"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Batch Date", "Parent Item", "Item No.", "Production  Area", "Batch ID")
        {
            SumIndexFields = "Line Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := USERID;
        "Captured By" := USERID;
        "Captured Time" := TIME;
    end;

    trigger OnModify()
    begin
        CALCFIELDS(Approve);
        IF ((Approve) OR (Reject)) THEN BEGIN
            IF ProductionPermissions.GET(USERID) THEN
                ProductionPermissions.TESTFIELD("Modify After Approval")
            ELSE
                ERROR('Access Denied!');
        END;

        IF ProductionBatches.GET("Batch Date", "Production  Area") THEN BEGIN
            IF ProductionBatches.Status <> ProductionBatches.Status::Draft THEN BEGIN
                IF ProductionPermissions.GET(USERID) THEN
                    ProductionPermissions.TESTFIELD("Modify After Approval")
                ELSE
                    ERROR('Access Denied!');
            END;
        END ELSE
            ERROR('Batch does not exists!');
    end;

    var
        Item: Record Item;
        ProductionBatches: Record "Meal-Proc. Batches";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ProductionBatchLines: Record "Meal-Proc. Batch Lines";
        OldItemQuantity: Decimal;
        NewItemQuantity: Decimal;
        ProductionPermissions: Record "Meal-Proc. Permissions";

    local procedure ComputeTotalValues()
    var
        ProductionBatchLines: Record "Meal-Proc. Batch Lines";
    begin

        "Line Amount" := "Item Quantity" * "Unit Price";

        IF Item.GET(Rec."Item No.") THEN BEGIN
            "Control Unit of Measure" := Item."Control Unit of Measure";


            CLEAR(NewItemQuantity);
            CLEAR(OldItemQuantity);
            ItemUnitofMeasure.RESET;
            ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.", Rec."Item No.");
            ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure.Code, Rec."Control Unit of Measure");
            IF ItemUnitofMeasure.FIND('-') THEN BEGIN
                OldItemQuantity := ItemUnitofMeasure."Qty. per Unit of Measure";
            END;
            ItemUnitofMeasure.RESET;
            ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure."Item No.", Rec."Item No.");
            ItemUnitofMeasure.SETRANGE(ItemUnitofMeasure.Code, "Unit of Measure");
            IF ItemUnitofMeasure.FIND('-') THEN BEGIN
                NewItemQuantity := ItemUnitofMeasure."Qty. per Unit of Measure";
            END;
            IF ((NewItemQuantity <> 0) AND (OldItemQuantity <> 0)) THEN BEGIN
                IF Item."Is Controlled" THEN
                    "Control Quantity" := ("Item Quantity" * (NewItemQuantity / OldItemQuantity))
                ELSE
                    "Control Quantity" := 0;
            END;
        END;
    end;
}

