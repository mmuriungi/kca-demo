table 52178779 "PROC-Procurement Plan Lines"
{
    LookupPageId = "PROC-Procurement Plan Lines";
    DrillDownPageId = "PROC-Procurement Plan Lines";
    fields
    {
        field(1; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }

        field(2; Type; Enum "Purchase Line Type")
        {

        }
        field(3; "No."; Code[20])
        {
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"."No." where(Blocked = filter(false), "Income/Balance" = filter("Income Statement"), "Account Type" = filter(Posting))
            ELSE
            IF (Type = CONST(Item)) Item."No." where(Blocked = filter(false))
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"."No." where(Blocked = filter(false));

            trigger OnValidate()
            begin
                IF Type = Type::"G/L Account" THEN BEGIN
                    IF GL.GET("No.") THEN begin
                        Description := GL.Name;
                        "Votebook Account" := Rec."No.";
                    end;

                END;
                IF Type = Type::Item THEN BEGIN
                    IF ITM.GET("No.") THEN
                        Description := ITM.Description;
                    Category := ITM."Gen. Prod. Posting Group";
                    "Unit Of Measure" := ITM."Base Unit of Measure";
                    "Votebook Account" := itm."Item G/L Budget Account";
                    "Unit Cost" := ITM."Unit Cost";
                END;
                IF Type = Type::"Fixed Asset" THEN BEGIN
                    IF FA.GET("No.") THEN
                        Description := FA.Description;
                    Category := FA."FA Subclass Code";
                END;
            end;
        }
        field(4; Description; Text[100])
        {
        }
        field(5; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Cost";
                "Remaining Qty" := Quantity;
                "Amended Quantity" := Quantity;
            end;
        }
        field(6; "Unit Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Cost";
            end;
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; "Remaining Qty"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
        }
        field(10; Category; Code[20])
        {
        }
        field(11; "Start Date"; Date)
        {
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false));

        }

        field(13; Reservation; option)
        {
            OptionMembers = " ",Open,"Special Groups";
        }
        field(14; "Procurement Method"; Enum "Proc-Procurement Methods")
        {

        }
        field(15; "Unit Of Measure"; Text[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(16; "Entry No."; Integer)
        {

        }
        field(17; "Votebook Account"; Code[30])
        {
            TableRelation = "G/L Account"."No.";

        }
        field(18; "1st Quater"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin

                ValidateQuantity();
                "1st Quater Amended" := "1st Quater";
            end;

        }
        field(19; "2nd Quater"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                "2nd Quater Amended" := "2nd Quater";
                ValidateQuantity();
            end;

        }
        field(20; "3rd Quater"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                "3rd Quater Amended" := "3rd Quater";
                ValidateQuantity();
            end;

        }
        field(21; "4th Quater"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                "4th Quater Amended" := "4th Quater";
                ValidateQuantity();
            end;

        }
        field(22; "Quantity Requisitioned"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line".Quantity where("Procurement Plan" = field("Budget Name"), "No." = field("No."), "Feature On The Plan" = filter(true), "Document Type" = filter(Order)));
            Editable = false;
            DecimalPlaces = 0 : 5;
        }
        field(23; "Special Group"; Code[30])
        {
            TableRelation = "Proc-Target Groups".Code;
        }
        field(24; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));
        }
        field(25; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          Blocked = CONST(false));
        }
        field(26; Approved; Boolean)
        {
            Editable = false;
        }
        field(27; "Amended Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(28; "1st Quater Amended"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin

                ValidateQuantity();
            end;

        }
        field(29; "2nd Quater Amended"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                ValidateQuantity();
            end;

        }
        field(30; "3rd Quater Amended"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                ValidateQuantity();
            end;

        }
        field(31; "4th Quater Amended"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                ValidateQuantity();
            end;

        }

    }

    keys
    {
        key(Key1; "Budget Name", "No.", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }
    trigger OnModify()
    begin
        Amount := Quantity * "Unit Cost";
    end;

    var
        GL: Record "G/L Account";
        FA: Record "Fixed Asset";
        ITM: Record Item;


    procedure ValidateQuantity()
    begin
        Quantity := Rec."1st Quater" + Rec."2nd Quater" + rec."3rd Quater" + rec."4th Quater";
        "Amended Quantity" := Rec."1st Quater Amended" + Rec."2nd Quater Amended" + rec."3rd Quater Amended" + rec."4th Quater Amended";
        Amount := "Amended Quantity" * "Unit Cost";
        Rec.Validate(Quantity);
    end;
}

