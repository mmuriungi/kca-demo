table 52178797 "Tender Submission Lines"
{
    Caption = 'Tender Submission Lines';
    PasteIsValid = false;

    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
            // OptionCaption = 'Quotation Request,Open Tender,Restricted Tender';
            // OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(2; "Buy-from Bidder No."; Code[20])
        {
            Caption = 'Buy-from bidder No.';
            Editable = false;
            TableRelation = "Tender Applicants Registration";
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
        field(5; Type; Enum "Purchase Line Type")
        {

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
            IF (Type = CONST(Resource)) Resource
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
        field(8; "Document Date"; Date)
        {

        }
        field(9; Description; Text[1000])
        {
            Caption = 'Description';
            Editable = true;
        }
        field(10; "Description 2"; Text[250])
        {
            Caption = 'Description 2';
        }
        field(11; "Unit of Measure"; Code[20])
        {
            Caption = 'Unit of Measure';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure".Code;
        }
        field(12; Quantity; Decimal)
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


        field(13; "Direct Unit Cost"; Decimal)
        {

            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';

            trigger OnValidate()
            begin
                IF Quantity <> 0 THEN BEGIN
                    Amount := Quantity * "Direct Unit Cost";
                END;
            end;
        }


        field(14; Amount; Decimal)
        {

            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(15; "Amount Including VAT"; Decimal)
        {

            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;
        }
        field(16; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
        }

        field(17; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(18; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }

        field(19; "Unit Cost"; Decimal)
        {

            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
        }

        field(20; "Line Amount"; Decimal)
        {

            AutoFormatType = 1;
            Caption = 'Line Amount';
        }
        field(21; "Unit of Measure Code"; Code[10])
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


        field(22; "Tender No."; code[50])
        {

        }
        field(23; "RFQ No."; Code[30])
        {

        }


    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.", "RFQ No.")
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

        GLAcc: Record "G/L Account";
        Item: Record Item;
        FA: Record "Fixed Asset";
        CItem: Record "Item Charge";
        PQHeader: Record "PROC-Purchase Quote Header";
}