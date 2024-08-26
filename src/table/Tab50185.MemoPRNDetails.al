table 50185 "Memo PRN Details"
{
    Caption = 'Purchase Line';
    DrillDownPageID = 518;
    LookupPageID = 518;
    PasteIsValid = false;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Editable = false;
            TableRelation = Vendor;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";

            trigger OnValidate()
            var
                TempPurchLine: Record "Purchase Line" temporary;
            begin
            end;
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = FILTER("Fixed Asset")) "Fixed Asset"."No."
            ELSE
            IF (Type = FILTER(Item)) Item."No."
            ELSE
            IF (Type = FILTER("G/L Account")) "G/L Account"."No.";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                TempPurchLine: Record "Purchase Line" temporary;
                StandardText: Record 7;
                FixedAsset: Record "Fixed Asset";
                PrepmtMgt: Codeunit 441;
            begin
                "Unit of Measure" := '';
                Rec.VALIDATE(Quantity, 1);
                Rec.VALIDATE("Unit Cost", 0);
                Rec.VALIDATE(Description, '');
                Rec.VALIDATE("Description 2", '');
                IF Type = Type::Item THEN BEGIN
                    Item.RESET;
                    Item.SETRANGE("No.", Rec."No.");
                    IF Item.FIND('-') THEN BEGIN
                        Rec.VALIDATE("Unit of Measure", Item."Base Unit of Measure");
                        Rec.VALIDATE("Unit Cost", Item."Unit Cost");
                        Rec.VALIDATE(Description, Item.Description);
                        Rec.VALIDATE("Description 2", Item."Description 2");
                    END;
                END ELSE
                    IF Type = Type::"Fixed Asset" THEN BEGIN
                        FixedAsset.RESET;
                        FixedAsset.SETRANGE("No.", Rec."No.");
                        IF FixedAsset.FIND('-') THEN BEGIN
                            Rec.VALIDATE(Description, FixedAsset.Description);
                            Rec.VALIDATE("Description 2", FixedAsset."Description 2");
                        END;
                    END ELSE
                        IF Type = Type::"G/L Account" THEN BEGIN
                            GLAcc.RESET;
                            GLAcc.SETRANGE("No.", Rec."No.");
                            IF GLAcc.FIND('-') THEN BEGIN
                                Rec.VALIDATE(Description, GLAcc.Name);
                                Rec.VALIDATE("Description 2", GLAcc."Search Name");
                            END;
                        END;
            end;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = filter(false));

            trigger OnValidate()
            var
                PurchSetup: Record 312;
                Vend: Record Vendor;
            begin
            end;
        }
        field(8; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(10; "Expected Receipt Date"; Date)
        {
            AccessByPermission = TableData 120 = R;
            Caption = 'Expected Receipt Date';
        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            var
                Item: Record Item;
                ReturnValue: Text[50];
            begin
            end;
        }
        field(12; "Description 2"; Text[100])
        {
            Caption = 'Description 2';
        }
        field(13; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Line Amount" := Quantity * "Unit Cost";
            end;
        }
        field(22; "Direct Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost ($)';
        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'Tax %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(29; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;

            trigger OnValidate()
            begin
                "Line Amount" := Quantity * "Unit Cost";
            end;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Amount';
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record 5402;
            begin
            end;
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            AccessByPermission = TableData 5600 = R;
            Caption = 'Use Duplication List';
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(5709; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(5710; Nonstock; Boolean)
        {
            AccessByPermission = TableData 5718 = R;
            Caption = 'Nonstock';
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;

            trigger OnValidate()
            var
                PurchasingCode: Record Purchasing;
            begin
            end;
        }
        field(5712; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            //TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(5794; "Planned Receipt Date"; Date)
        {
            AccessByPermission = TableData 99000880 = R;
            Caption = 'Planned Receipt Date';
        }
        field(5795; "Order Date"; Date)
        {
            AccessByPermission = TableData 120 = R;
            Caption = 'Order Date';
        }
        field(50607; "Manually Added"; Boolean)
        {
        }
        field(51000; "RFQ Remarks"; Text[50])
        {
        }
        field(51002; "Requisition No"; Code[20])
        {
        }
        field(99000756; "MPS Order"; Boolean)
        {
            Caption = 'MPS Order';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "No.", Type)
        {
            Clustered = true;
            MaintainSIFTIndex = false;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        PurchCommentLine: Record 43;
        SalesOrderLine: Record 37;
    begin
    end;

    trigger OnInsert()
    begin
        "Document Type" := "Document Type"::Quote;
    end;

    var
        Text000: Label 'You cannot rename a %1.';
        Text001: Label 'You cannot change %1 because the order line is associated with sales order %2.';
        Text002: Label 'Prices including Tax cannot be calculated when %1 is %2.';
        Text003: Label 'You cannot purchase resources.';
        Text004: Label 'must not be less than %1';
        Text006: Label 'You cannot invoice more than %1 units.';
        Text007: Label 'You cannot invoice more than %1 base units.';
        Text008: Label 'You cannot receive more than %1 units.';
        Text009: Label 'You cannot receive more than %1 base units.';
        Text010: Label 'You cannot change %1 when %2 is %3.';
        Text011: Label ' must be 0 when %1 is %2';
        Text012: Label 'must not be specified when %1 = %2';
        Text016: Label '%1 is required for %2 = %3.';
        Text017: Label '\The entered information may be disregarded by warehouse operations.';
        Text018: Label '%1 %2 is earlier than the work date %3.';
        Text020: Label 'You cannot return more than %1 units.';
        Text021: Label 'You cannot return more than %1 base units.';
        Text022: Label 'You cannot change %1, if item charge is already posted.';
        Text023: Label 'You cannot change the %1 when the %2 has been filled in.';
        Text029: Label 'must be positive.';
        Text030: Label 'must be negative.';
        Text031: Label 'You cannot define item tracking on this line because it is linked to production order %1.';
        Text032: Label '%1 must not be greater than the sum of %2 and %3.';
        Text033: Label 'Warehouse ';
        Text034: Label 'Inventory ';
        Text035: Label '%1 units for %2 %3 have already been returned or transferred. Therefore, only %4 units can be returned.';
        Text037: Label 'cannot be %1.';
        Text038: Label 'cannot be less than %1.';
        Text039: Label 'cannot be more than %1.';
        Text040: Label 'You must use form %1 to enter %2, if item tracking is used.';
        Text99000000: Label 'You cannot change %1 when the purchase order is associated to a production order.';
        PurchHeader: Record "Purchase Header";
        PurchLine2: Record "Purchase Line";
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FixedAsset: Record "Fixed Asset";
        Currency: Record Currency;
        CurrExchRate: Record 330;
        VATPostingSetup: Record 325;
        GenBusPostingGrp: Record 250;
        GenProdPostingGrp: Record 251;
        UnitOfMeasure: Record 204;
        ItemCharge: Record 5800;
        SKU: Record 5700;
        //WorkCenter: Record "99000754";
        // InvtSetup: Record "313";
        // Location: Record "14";
        // GLSetup: Record "98";
        // CalChange: Record "7602";
        // TempJobJnlLine: Record "210" temporary;
        // VendorLocation: Record "10013";
        // TaxArea: Record "318";
        // PurchSetup: Record "312";
        // ApplicationAreaSetup: Record "9178";
        // SalesTaxCalculate: Codeunit "398";
        // ReservEngineMgt: Codeunit "99000831";
        // ReservePurchLine: Codeunit "99000834";
        // UOMMgt: Codeunit "5402";
        // AddOnIntegrMgt: Codeunit "5403";
        // DimMgt: Codeunit "408";
        // DistIntegration: Codeunit "5702";
        // NonstockItemMgt: Codeunit "5703";
        // WhseValidateSourceLine: Codeunit "5777";
        // LeadTimeMgt: Codeunit "5404";
        // PurchPriceCalcMgt: Codeunit "7010";
        // CalendarMgmt: Codeunit "7600";
        // CheckDateConflict: Codeunit "99000815";
        // DeferralUtilities: Codeunit "1720";
        TrackingBlocked: Boolean;
        StatusCheckSuspended: Boolean;
        GLSetupRead: Boolean;
        UnitCostCurrency: Decimal;
        UpdateFromVAT: Boolean;
        Text042: Label 'You cannot return more than the %1 units that you have received for %2 %3.';
        Text043: Label 'must be positive when %1 is not 0.';
        Text044: Label 'You cannot change %1 because this purchase order is associated with %2 %3.';
        Text046: Label '%3 will not update %1 when changing %2 because a prepayment invoice has been posted. Do you want to continue?', Comment = '%1 - product name';
        Text047: Label '%1 can only be set when %2 is set.';
        Text048: Label '%1 cannot be changed when %2 is set.';
        PrePaymentLineAmountEntered: Boolean;
        Text049: Label 'You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?';
        Text050: Label 'Canceled.';
        Text051: Label 'must have the same sign as the receipt';
        Text052: Label 'The quantity that you are trying to invoice is greater than the quantity in receipt %1.';
        Text053: Label 'must have the same sign as the return shipment';
        Text054: Label 'The quantity that you are trying to invoice is greater than the quantity in return shipment %1.';
        Text1020002: Label 'Operation canceled to preserve Tax Differences.';
        Text1020001: Label 'This operation will remove the Tax Differences that were previously entered. Are you sure you want to continue?';
        Text1020000: Label 'You must reopen the document since this will affect Sales Tax.';
        USText001: Label 'You have added a %1, which will result in a Tax Entry being posted to record the amount of Sales Tax you will owe your Province as a result of this purchase. Are you sure you want to do this?';
        Text1020003: Label 'The %1 field in the %2 used on the %3 must match the %1 field in the %2 used on the %4.';
        Text10100: Label 'Acquisition can only be selected for type Fixed Asset or G/L Account.';
        Text1020005: Label 'must be %1 when the Prepayment Invoice has already been posted', Comment = 'starts with a field name; %1 - numeric value';
        AnotherItemWithSameDescrQst: Label 'Item No. %1 also has the description "%2".\Do you want to change the current item no. to %1?', Comment = '%1=Item no., %2=item description';
        DataConflictQst: Label 'The change creates a date conflict with existing reservations. Do you want to continue?';
        PurchSetupRead: Boolean;
        ItemNoFieldCaptionTxt: Label 'Item';
}

