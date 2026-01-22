table 52178796 "Tender Lines"
{
    Caption = 'Tender Lines';
    PasteIsValid = false;

    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
            // OptionCaption = 'Quotation Request,Open Tender,Restricted Tender';
            // OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
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
        field(4; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account"."No."
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(3)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge";

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
                ItemCrossReference: Record "Item Reference";
                PrepmtMgt: Codeunit "Prepayment Mgt.";
            begin
                //,G/L Account,Item,,Fixed Asset,Charge (Item)
                IF Type = Type::"G/L Account" THEN BEGIN
                    GLAcc.RESET;
                    GLAcc.GET("No.");
                    Description := GLAcc.Name;
                END
                ELSE
                    IF Type = Type::Item THEN BEGIN
                        Item.RESET;
                        Item.GET("No.");
                        Description := Item.Description;
                    END
                    ELSE
                        IF Type = Type::"Fixed Asset" THEN BEGIN
                            FA.RESET;
                            FA.GET("No.");
                            Description := FA.Description;
                        END
                        ELSE
                            IF Type = Type::"Charge (Item)" THEN BEGIN
                                CItem.RESET;
                                CItem.GET("No.");
                                Description := CItem.Description;
                            END;
            end;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = filter(false));
        }
        field(8; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(9; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
            Editable = true;
        }
        field(11; "Description 2"; Text[250])
        {
            Caption = 'Description 2';
        }
        field(12; "Unit of Measure"; Code[20])
        {
            Caption = 'Unit of Measure';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure".Code;
        }
        field(13; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                IF "Direct Unit Cost" <> 0 THEN BEGIN
                    Amount := Quantity * "Direct Unit Cost";
                END;
            end;
        }
        field(14; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(15; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;
        }
        field(16; "Qty. to Receive"; Decimal)
        {
            Caption = 'Qty. to Receive';
            DecimalPlaces = 0 : 5;
        }
        field(17; "Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';

            trigger OnValidate()
            begin
                IF Quantity <> 0 THEN BEGIN
                    Amount := Quantity * "Direct Unit Cost";
                END;
            end;
        }
        field(18; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
        }
        field(19; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(20; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(21; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
        }
        field(22; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(23; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;
        }
        field(24; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
        }
        field(25; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
        }
        field(26; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(27; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(28; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(29; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(30; "Appl.-to Item Entry"; Integer)
        {
            Caption = 'Appl.-to Item Entry';
        }
        field(31; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(32; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                Job: Record Job;
            begin
            end;
        }
        field(34; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(35; "Outstanding Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Outstanding Amount';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
            end;
        }
        field(36; "Qty. Rcd. Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Rcd. Not Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(37; "Amt. Rcd. Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amt. Rcd. Not Invoiced';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
            end;
        }
        field(38; "Quantity Received"; Decimal)
        {
            Caption = 'Quantity Received';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(39; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(40; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            Editable = false;
        }
        field(41; "Receipt Line No."; Integer)
        {
            Caption = 'Receipt Line No.';
            Editable = false;
        }
        field(42; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(43; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            Editable = false;
            TableRelation = Vendor;
        }
        field(44; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            Editable = false;
        }
        field(45; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
        }
        field(46; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = filter(true)) "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(47; "Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = filter(true)) "Sales Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                        "Document No." = FIELD("Sales Order No."));
        }
        field(48; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
            Editable = false;
        }
        field(49; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(51; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(52; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(53; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(54; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Editable = false;
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                              "Document No." = FIELD("Document No."));
        }
        field(55; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
            TableRelation = "Entry/Exit Point";
        }
        field(56; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(57; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(58; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(59; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(60; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(61; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax';
        }
        field(62; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(63; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(64; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(65; "Outstanding Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)';
            Editable = false;
        }
        field(66; "Amt. Rcd. Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. Rcd. Not Invoiced (LCY)';
            Editable = false;
        }
        field(67; "Reserved Quantity"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Document No."),
                                                                  "Source Ref. No." = FIELD("Line No."),
                                                                  "Source Type" = CONST(39),
                                                                  "Reservation Status" = CONST(Reservation)));

            // CalcFormula = Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Document No."),
            //                                                       "Source Ref. No." = FIELD("Line No."),
            //                                                       "Source Type" = CONST(39),
            //                                                       "Source Subtype" = FIELD("Document Type"),
            //                                                       "Reservation Status" = CONST(Reservation)));

            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68; "Blanket Order No."; Code[20])
        {
            Caption = 'Blanket Order No.';
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(69; "Blanket Order Line No."; Integer)
        {
            Caption = 'Blanket Order Line No.';
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"),
                                                              "Document No." = FIELD("Blanket Order No."));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(70; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            Editable = false;
        }
        field(71; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
        }
        field(72; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(73; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';
        }
        field(74; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
        }
        field(75; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice';
            Editable = false;
        }
        field(76; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            Editable = false;
        }
        field(77; "IC Partner Ref. Type"; Option)
        {
            Caption = 'IC Partner Ref. Type';
            OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.,Vendor Item No.';
            OptionMembers = " ","G/L Account",Item,,,"Charge (Item)","Cross Reference","Common Item No.","Vendor Item No.";
        }
        field(78; "IC Partner Reference"; Code[20])
        {
            Caption = 'IC Partner Reference';

            trigger OnLookup()
            var
                ICGLAccount: Record "IC G/L Account";
                ItemCrossReference: Record "Item Reference";
                ItemVendorCatalog: Record "Item Vendor";
            begin
            end;
        }
        field(79; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                GenPostingSetup: Record "General Posting Setup";
                GLAcc: Record "G/L Account";
            begin
            end;
        }
        field(80; "Prepmt. Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Line Amount';
            MinValue = 0;
        }
        field(81; "Prepmt. Amt. Inv."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amt. Inv.';
            Editable = false;
        }
        field(82; "Prepmt. Amt. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amt. Incl. VAT';
            Editable = false;
        }
        field(83; "Prepayment Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment Amount';
            Editable = false;
        }
        field(84; "Prepmt. VAT Base Amt."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. VAT Base Amt.';
            Editable = false;
        }
        field(85; "Prepayment VAT %"; Decimal)
        {
            Caption = 'Prepayment VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(86; "Prepmt. VAT Calc. Type"; Option)
        {
            Caption = 'Prepmt. VAT Calc. Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(87; "Prepayment VAT Identifier"; Code[10])
        {
            Caption = 'Prepayment VAT Identifier';
            Editable = false;
        }
        field(88; "Prepayment Tax Area Code"; Code[20])
        {
            Caption = 'Prepayment Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(89; "Prepayment Tax Liable"; Boolean)
        {
            Caption = 'Prepayment Tax Liable';
        }
        field(90; "Prepayment Tax Group Code"; Code[10])
        {
            Caption = 'Prepayment Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(91; "Prepmt Amt to Deduct"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt Amt to Deduct';
            MinValue = 0;
        }
        field(92; "Prepmt Amt Deducted"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt Amt Deducted';
            Editable = false;
        }
        field(93; "Prepayment Line"; Boolean)
        {
            Caption = 'Prepayment Line';
            Editable = false;
        }
        field(94; "Prepmt. Amount Inv. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. Incl. VAT';
            Editable = false;
        }
        field(95; "Prepmt. Amount Inv. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. (LCY)';
            Editable = false;
        }
        field(96; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
        }
        field(97; "Prepayment VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment VAT Difference';
            Editable = false;
        }
        field(98; "Prepmt VAT Diff. to Deduct"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. to Deduct';
            Editable = false;
        }
        field(99; "Prepmt VAT Diff. Deducted"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. Deducted';
            Editable = false;
        }
        field(100; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(101; "Job Line Type"; Option)
        {
            Caption = 'Job Line Type';
            OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';
            OptionMembers = " ",Schedule,Contract,"Both Schedule and Contract";
        }
        field(102; "Job Unit Price"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Unit Price';
        }
        field(103; "Job Total Price"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Total Price';
            Editable = false;
        }
        field(104; "Job Line Amount"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Amount';
        }
        field(105; "Job Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Discount Amount';
        }
        field(106; "Job Line Discount %"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(107; "Job Unit Price (LCY)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Unit Price (LCY)';
            Editable = false;
        }
        field(108; "Job Total Price (LCY)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Total Price (LCY)';
            Editable = false;
        }
        field(109; "Job Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Amount (LCY)';
            Editable = false;
        }
        field(110; "Job Line Disc. Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Disc. Amount (LCY)';
            Editable = false;
        }
        field(111; "Job Currency Factor"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Currency Factor';
        }
        field(112; "Job Currency Code"; Code[20])
        {
            Caption = 'Job Currency Code';
        }
        field(113; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(114; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(115; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';

            trigger OnLookup()
            var
                //WMSManagement: Codeunit "WMS Management";
                BinCode: Code[20];
            begin
            end;

            trigger OnValidate()
            var
            // WMSManagement: Codeunit "WMS Management";
            begin
            end;
        }
        field(116; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(117; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record "Unit of Measure Translation";
            begin
            end;
        }
        field(118; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(119; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(120; "Qty. to Invoice (Base)"; Decimal)
        {
            Caption = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(121; "Qty. to Receive (Base)"; Decimal)
        {
            Caption = 'Qty. to Receive (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(122; "Qty. Rcd. Not Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Rcd. Not Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(123; "Qty. Received (Base)"; Decimal)
        {
            Caption = 'Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(124; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(125; "Reserved Qty. (Base)"; Decimal)
        {
            FieldClass = FlowField;

            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Source Type" = CONST(39),
                                                                           "Source ID" = FIELD("Document No."),
                                                                           "Source Ref. No." = FIELD("Line No."),
                                                                           "Reservation Status" = CONST(Reservation)));

            // CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Source Type" = CONST(39),
            //                                                                "Source Subtype" = FIELD("Document Type"),
            //                                                                "Source ID" = FIELD("Document No."),
            //                                                                "Source Ref. No." = FIELD("Line No."),
            //                                                                "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;

        }
        field(126; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date';
        }
        field(127; "FA Posting Type"; Option)
        {
            Caption = 'FA Posting Type';
            OptionCaption = ' ,Acquisition Cost,Maintenance';
            OptionMembers = " ","Acquisition Cost",Maintenance;
        }
        field(128; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";
        }
        field(129; "Salvage Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Salvage Value';
        }
        field(130; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date';
        }
        field(131; "Depr. Acquisition Cost"; Boolean)
        {
            Caption = 'Depr. Acquisition Cost';
        }
        field(132; "Maintenance Code"; Code[10])
        {
            Caption = 'Maintenance Code';
            TableRelation = Maintenance;
        }
        field(133; "Insurance No."; Code[20])
        {
            Caption = 'Insurance No.';
            TableRelation = Insurance;
        }
        field(134; "Budgeted FA No."; Code[20])
        {
            Caption = 'Budgeted FA No.';
            TableRelation = "Fixed Asset";
        }
        field(135; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book';
            TableRelation = "Depreciation Book";
        }
        field(136; "Use Duplication List"; Boolean)
        {
            Caption = 'Use Duplication List';
        }
        field(137; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(138; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';

            trigger OnValidate()
            var
                ReturnedCrossRef: Record "Item Reference";
            begin
            end;
        }
        field(139; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            Caption = 'Unit of Measure (Cross Ref.)';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(140; "Cross-Reference Type"; Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(141; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.';
        }
        field(142; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(143; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
        }
        field(144; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
        }
        field(145; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = Item."Item Category Code" WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(146; "Special Order"; Boolean)
        {
            Caption = 'Special Order';
        }
        field(147; "Special Order Sales No."; Code[20])
        {
            Caption = 'Special Order Sales No.';
            TableRelation = IF ("Special Order" = filter(false)) "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(148; "Special Order Sales Line No."; Integer)
        {
            Caption = 'Special Order Sales Line No.';
            TableRelation = IF ("Special Order" = filter(true)) "Sales Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                         "Document No." = FIELD("Special Order Sales No."));
        }
        field(149; "Whse. Outstanding Qty. (Base)"; Decimal)
        {
            BlankZero = true;

            CalcFormula = Sum("Warehouse Receipt Line"."Qty. Outstanding (Base)" WHERE("Source Type" = CONST(39),
                                                                                        "Source No." = FIELD("Document No."),
                                                                                        "Source Line No." = FIELD("Line No.")));

            // CalcFormula = Sum("Warehouse Receipt Line"."Qty. Outstanding (Base)" WHERE("Source Type" = CONST(39),
            //                                                                             "Source Subtype" = FIELD("Document Type"),
            //                                                                             "Source No." = FIELD("Document No."),
            //                                                                             "Source Line No." = FIELD("Line No.")));
            Caption = 'Whse. Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(150; "Completely Received"; Boolean)
        {
            Caption = 'Completely Received';
            Editable = false;
        }
        field(151; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(152; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
        }
        field(153; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
        }
        field(154; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
        }
        field(155; "Planned Receipt Date"; Date)
        {
            Caption = 'Planned Receipt Date';
        }
        field(156; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(157; "Allow Item Charge Assignment"; Boolean)
        {
            Caption = 'Allow Item Charge Assignment';
            InitValue = true;
        }
        field(158; "Qty. to Assign"; Decimal)
        {
            CalcFormula = Sum("Item Charge Assignment (Purch)"."Qty. to Assign" WHERE("Document Type" = FIELD("Document Type"),
                                                                                       "Document No." = FIELD("Document No."),
                                                                                       "Document Line No." = FIELD("Line No.")));
            Caption = 'Qty. to Assign';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(159; "Qty. Assigned"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Charge Assignment (Purch)"."Qty. Assigned" WHERE("Document Type" = FIELD("Document Type"),
                                                                                     "Document No." = FIELD("Document No."),
                                                                                      "Document Line No." = FIELD("Line No.")));
            Caption = 'Qty. Assigned';
            DecimalPlaces = 0 : 5;
            Editable = false;

        }
        field(160; "Return Qty. to Ship"; Decimal)
        {
            Caption = 'Return Qty. to Ship';
            DecimalPlaces = 0 : 5;
        }
        field(161; "Return Qty. to Ship (Base)"; Decimal)
        {
            Caption = 'Return Qty. to Ship (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(162; "Return Qty. Shipped Not Invd."; Decimal)
        {
            Caption = 'Return Qty. Shipped Not Invd.';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(163; "Ret. Qty. Shpd Not Invd.(Base)"; Decimal)
        {
            Caption = 'Ret. Qty. Shpd Not Invd.(Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(164; "Return Shpd. Not Invd."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Return Shpd. Not Invd.';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
            end;
        }
        field(165; "Return Shpd. Not Invd. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Return Shpd. Not Invd. (LCY)';
            Editable = false;
        }
        field(166; "Return Qty. Shipped"; Decimal)
        {
            Caption = 'Return Qty. Shipped';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(167; "Return Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Return Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(168; "Return Shipment No."; Code[20])
        {
            Caption = 'Return Shipment No.';
            Editable = false;
        }
        field(169; "Return Shipment Line No."; Integer)
        {
            Caption = 'Return Shipment Line No.';
            Editable = false;
        }
        field(170; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
        }
        field(171; Committed; Boolean)
        {
        }
        field(172; "Expense Code"; Code[20])
        {
            //TableRelation = "FIN-Expense Code";
        }
        field(173; "Asset No."; Code[10])
        {
            TableRelation = "Fixed Asset"."No.";
        }
        field(174; Specifications; Integer)
        {
            FieldClass = Normal;
        }
        field(175; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            TableRelation = "Routing Header";
        }
        field(176; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            TableRelation = "Prod. Order Routing Line"."Operation No." WHERE(Status = CONST(Released),
                                                                              "Prod. Order No." = FIELD("Prod. Order No."),
                                                                              "Routing No." = FIELD("Routing No."));

            trigger OnValidate()
            var
                ProdOrderRtngLine: Record "Prod. Order Routing Line";
            begin
            end;
        }
        field(177; "Work Center No."; Code[20])
        {
            Caption = 'Work Center No.';
            TableRelation = "Work Center";
        }
        field(178; Finished; Boolean)
        {
            Caption = 'Finished';
        }
        field(179; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            TableRelation = "Prod. Order Line"."Line No." WHERE(Status = FILTER(Released ..),
                                                                 "Prod. Order No." = FIELD("Prod. Order No."));
        }
        field(180; "Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rate';
            DecimalPlaces = 0 : 5;
        }
        field(181; "MPS Order"; Boolean)
        {
            Caption = 'MPS Order';
        }
        field(182; "Planning Flexibility"; Option)
        {
            Caption = 'Planning Flexibility';
            OptionCaption = 'Unlimited,None';
            OptionMembers = Unlimited,"None";
        }
        field(183; "Safety Lead Time"; DateFormula)
        {
            Caption = 'Safety Lead Time';
        }
        field(184; "Routing Reference No."; Integer)
        {
            Caption = 'Routing Reference No.';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.", Description)
        {
            Clustered = true;
            MaintainSIFTIndex = false;
            SumIndexFields = Amount, "Amount Including VAT";
        }
        key(Key2; "Document No.", "Line No.", "Document Type")
        {
        }
        key(Key3; "Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Expected Receipt Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Outstanding Qty. (Base)";
        }
        key(Key4; "Document Type", "Pay-to Vendor No.", "Currency Code")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Outstanding Amount", "Amt. Rcd. Not Invoiced", "Outstanding Amount (LCY)", "Amt. Rcd. Not Invoiced (LCY)";
        }
        key(Key5; "Document Type", "Blanket Order No.", "Blanket Order Line No.")
        {
        }
        key(Key6; "Document Type", Type, "Prod. Order No.", "Prod. Order Line No.", "Routing No.", "Operation No.")
        {
        }
        key(Key7; "Document Type", "Document No.", "Location Code")
        {
        }
        key(Key8; "Document Type", "Receipt No.", "Receipt Line No.")
        {
        }
        key(Key9; Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Document Type", "Expected Receipt Date")
        {
            MaintainSQLIndex = false;
        }
        key(Key10; "Document Type", "Buy-from Vendor No.")
        {
        }
        key(Key11; "Document Type", "Job No.", "Job Task No.")
        {
            SumIndexFields = "Outstanding Amount (LCY)", "Amt. Rcd. Not Invoiced (LCY)";
        }
        key(Key12; Committed, "Expected Receipt Date")
        {
            SumIndexFields = Amount, "Amount Including VAT";
        }
        key(Key13; "Document No.", Type, "No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        PurchCommentLine: Record "Purch. Comment Line";
    begin
        PQHeader.RESET;
        PQHeader.SETRANGE(PQHeader."Document Type", "Document Type");
        PQHeader.SETRANGE(PQHeader."No.", "Document No.");
        IF PQHeader.FIND('-') THEN BEGIN
            IF PQHeader.Status = PQHeader.Status::Released THEN BEGIN
                ERROR('The RFQ is already released you cannot delete the records');
            END;
        END;
    end;

    var
        Text000: Label 'You cannot rename a %1.';
        Text001: Label 'You cannot change %1 because the order line is associated with sales order %2.';
        Text002: Label 'Prices including VAT cannot be calculated when %1 is %2.';
        Text003: Label 'You cannot purchase resources.';
        Text004: Label 'must not be less than %1';
        Text006: Label 'You cannot invoice more than %1 units.';
        Text007: Label 'You cannot invoice more than %1 base units.';
        Text008: Label 'You cannot receive more than %1 units.';
        Text009: Label 'You cannot receive more than %1 base units.';
        Text010: Label 'You cannot change %1 when %2 is %3.';
        Text011: Label ' must be 0 when %1 is %2';
        Text012: Label 'must not be specified when %1 = %2';
        Text014: Label 'Change %1 from %2 to %3?';
        Text016: Label '%1 is required for %2 = %3.';
        Text017: Label '\The entered information will be disregarded by warehouse operations.';
        Text018: Label '%1 %2 is earlier than the work date %3.';
        Text020: Label 'You cannot return more than %1 units.';
        Text021: Label 'You cannot return more than %1 base units.';
        Text022: Label 'You cannot change %1, if item charge is already posted.';
        Text023: Label 'You cannot change the %1 when the %2 has been filled in.';
        Text029: Label 'must be positive.';
        Text030: Label 'must be negative.';
        Text031: Label 'You cannot define item tracking on this line because it is linked to production order %1.';
        Text032: Label '%1 must not be greater than %2.';
        Text033: Label 'Warehouse ';
        Text034: Label 'Inventory ';
        Text035: Label '%1 units for %2 %3 have already been returned or transferred. Therefore, only %4 units can be returned.';
        Text036: Label 'You must cancel the existing approval for this document to be able to change the %1 field.';
        Text037: Label 'cannot be %1.';
        Text038: Label 'cannot be less than %1.';
        Text039: Label 'cannot be more than %1.';
        Text99000000: Label 'You cannot change %1 when the purchase order is associated to a production order.';
        Text042: Label 'You cannot return more than the %1 units that you have received for %2 %3.';
        Text043: Label 'must be positive when %1 is not 0.';
        Text044: Label 'You cannot change %1 because this purchase order is associated with %2 %3.';
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FA: Record "Fixed Asset";
        CItem: Record "Item Charge";
        PQHeader: Record "PROC-Purchase Quote Header";
}