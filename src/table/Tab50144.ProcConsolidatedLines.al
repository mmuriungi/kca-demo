table 50144 "Proc Consolidated Lines"
{
    Caption = 'Proc Consolidated Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Fy; Code[50])
        {
            Editable = false;
            Caption = 'Fy';
        }
        field(2; No; Code[50])
        {
            Caption = 'No';
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"."No." where(Blocked = filter(false))
            ELSE
            IF (Type = CONST(Item)) Item."No." where(Blocked = filter(false))
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"."No." where(Blocked = filter(false));

            trigger OnValidate()
            begin
                IF Type = Type::"G/L Account" THEN BEGIN
                    IF GL.GET("No") THEN begin
                        Description := GL.Name;
                        "Votebook Account" := Rec."No";
                    end;

                END;
                IF Type = Type::Item THEN BEGIN
                    IF ITM.GET("No") THEN
                        Description := ITM.Description;
                    "Unit Of Measure" := ITM."Base Unit of Measure";
                    "Votebook Account" := itm."Item G/L Budget Account";
                    "Unit Cost" := ITM."Unit Cost";
                END;
                IF Type = Type::"Fixed Asset" THEN BEGIN
                    IF FA.GET("No") THEN
                        Description := FA.Description;

                END;
            end;
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(4; Type; Enum "Purchase Line Type")
        {

        }
        field(5; "1st Quater"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            CalcFormula = sum("PROC-Procurement Plan Lines1"."1st Quater" where(Type = field(Type), "No." = field(No), "Budget Name" = field(Fy), Approved = filter(true)));
            FieldClass = FlowField;
            Editable = false;
            trigger OnValidate()
            begin
                ValidateQuantity();
            end;

        }
        field(6; "2nd Quater"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            CalcFormula = sum("PROC-Procurement Plan Lines1"."2nd Quater" where(Type = field(Type), "No." = field(No), "Budget Name" = field(Fy), Approved = filter(true)));
            FieldClass = FlowField;
            Editable = false;
            trigger OnValidate()
            begin
                ValidateQuantity();
            end;

        }
        field(7; "3rd Quater"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            CalcFormula = sum("PROC-Procurement Plan Lines1"."3rd Quater" where(Type = field(Type), "No." = field(No), "Budget Name" = field(Fy), Approved = filter(true)));
            FieldClass = FlowField;
            Editable = false;
            trigger OnValidate()
            begin
                ValidateQuantity();
            end;

        }
        field(8; "4th Quater"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            CalcFormula = sum("PROC-Procurement Plan Lines1"."4th Quater" where(Type = field(Type), "No." = field(No), "Budget Name" = field(Fy), Approved = filter(true)));
            FieldClass = FlowField;
            Editable = false;
            trigger OnValidate()
            begin
                ValidateQuantity();
            end;

        }

        field(9; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
            /*  CalcFormula = sum("PROC-Procurement Plan Lines".Quantity where(Type = field(Type), "No." = field(No), "Budget Name" = field(Fy), Approved = filter(true)));
             FieldClass = FlowField;
             Editable = false; */
            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Cost";
            end;
        }
        field(10; "Unit Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Cost";
            end;
        }
        field(11; Amount; Decimal)
        {
        }
        field(12; "Unit Of Measure"; Text[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(13; "Entry No."; Integer)
        {

        }
        field(14; "Votebook Account"; Code[30])
        {
            TableRelation = "G/L Account"."No.";

        }
        field(15; "1st Quater Amended"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            CalcFormula = sum("PROC-Procurement Plan Lines1"."1st Quater Amended" where(Type = field(Type), "No." = field(No), "Budget Name" = field(Fy), Approved = filter(true)));
            FieldClass = FlowField;
            Editable = false;
            trigger OnValidate()
            begin
                ValidateQuantity();
            end;

        }
        field(16; "2nd Quater Amended"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            CalcFormula = sum("PROC-Procurement Plan Lines1"."2nd Quater Amended" where(Type = field(Type), "No." = field(No), "Budget Name" = field(Fy), Approved = filter(true)));
            FieldClass = FlowField;
            Editable = false;
            trigger OnValidate()
            begin
                ValidateQuantity();
            end;

        }
        field(17; "3rd Quater Amended"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            CalcFormula = sum("PROC-Procurement Plan Lines1"."3rd Quater Amended" where(Type = field(Type), "No." = field(No), "Budget Name" = field(Fy), Approved = filter(true)));
            FieldClass = FlowField;
            Editable = false;
            trigger OnValidate()
            begin
                ValidateQuantity();
            end;

        }
        field(18; "4th Quater Amended"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            CalcFormula = sum("PROC-Procurement Plan Lines1"."4th Quater Amended" where(Type = field(Type), "No." = field(No), "Budget Name" = field(Fy), Approved = filter(true)));
            FieldClass = FlowField;
            Editable = false;
            trigger OnValidate()
            begin
                ValidateQuantity();
            end;

        }
        field(19; "Amended Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(20; Reservation; option)
        {
            OptionMembers = " ",Open,"Special Groups";
        }
        field(21; "Procurement Method"; Enum "Proc-Procurement Methods")
        {

        }
        field(22; "Special Group"; Code[30])
        {
            TableRelation = "Proc-Target Groups".Code;
        }
        field(23; "Description 2"; Text[2048])
        {

        }
        field(24; "Source of Funds"; Text[500])
        {

        }
        field(25; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
        }


        field(27; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false));

        }
        field(28; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));
        }
        field(29; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          Blocked = CONST(false));
        }
        field(30; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          Blocked = CONST(false));
        }
        field(31; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          Blocked = CONST(false));
        }
        field(32; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          Blocked = CONST(false));
        }

    }
    keys
    {
        key(PK; Fy, "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "Entry No." = 0 then
            "Entry No." := GetLastEntryNo() + 1;
        ValidateQuantity();
    end;


    trigger OnModify()
    begin
        ValidateQuantity();
    end;

    procedure ValidateQuantity()
    begin
        /*   rec.CalcFields("1st Quater");
          rec.CalcFields("2nd Quater");
          rec.CalcFields("3rd Quater");
          rec.CalcFields("4th Quater"); */
        //Quantity := Rec."1st Quater" + Rec."2nd Quater" + rec."3rd Quater" + rec."4th Quater";
        "Amended Quantity" := Quantity;
        Amount := Quantity * "Unit Cost";
        Rec.Validate(Quantity);
        rec.Validate("Unit Cost");
    end;

    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No.")))
    end;

    var
        GL: Record "G/L Account";
        FA: Record "Fixed Asset";
        ITM: Record Item;
}
