/// <summary>
/// Table PROC-Store Requistion Header (ID 52178702).
/// </summary>
table 50145 "PROC-Store Requistion Header1"
{
    DrillDownPageID = "PROC-Store Requisition";
    LookupPageID = "PROC-Store Requisition";

    fields
    {
        field(1; "No."; Code[30])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                IF "No." = '' THEN BEGIN
                    IF "No." <> xRec."No." THEN BEGIN
                        GenLedgerSetup.GET();
                        NoSeriesMgt.TestManual(GenLedgerSetup."Stores Requisition No");
                        "No." := '';
                        "Requester ID" := UserId;
                        "Request date" := Today;
                    END;
                END;
            end;
        }
        field(2; "Request date"; Date)
        {
        }
        field(5; "Required Date"; Date)
        {
            Editable = false;
            trigger OnValidate()
            begin
                if "Required Date" < Today then Error('Select a varied date');
            end;
        }
        field(6; "Requester ID"; Code[20])
        {

            Editable = false;


        }
        field(7; "Request Description"; Text[500])
        {
        }
        field(9; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Cancelled,Posted;
        }
        field(11; Supplier; Code[20])
        {
            TableRelation = Vendor;
        }
        field(12; "Action Type"; Option)
        {
            OptionMembers = " ","Ask for Tender","Ask for Quote";

            trigger OnValidate()
            begin
                /*
                IF Type=Type::"G/L Account" THEN BEGIN
                   IF "Action Type"="Action Type"::Issue THEN
                            ERROR('You cannot Issue a G/L Account please order for it')
                END;


               //Compare Quantity in Store and Qty to Issue
                IF Type=Type::Item THEN BEGIN
                   IF "Action Type"="Action Type"::Issue THEN BEGIN
                    IF Quantity>"Qty in store" THEN
                      ERROR('You cannot Issue More than what is available in store')
                   END;
                END;
                */

            end;
        }
        field(29; Justification; Text[250])
        {
        }
        field(30; "User ID"; Code[30])
        {
        }
        field(31; "Global Dimension 1 Code"; Code[100])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                Dimval.RESET;
                Dimval.SETRANGE(Dimval."Global Dimension No.", 1);
                Dimval.SETRANGE(Dimval.Code, "Global Dimension 1 Code");
                IF Dimval.FIND('-') THEN
                    "Function Name" := Dimval.Name
            end;
        }
        field(56; "Shortcut Dimension 2 Code"; Code[100])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false), "Falls Under" = field("Global Dimension 1 Code"));

            trigger OnValidate()
            begin
                Dimval.RESET;
                Dimval.SETRANGE(Dimval."Global Dimension No.", 2);
                Dimval.SETRANGE(Dimval.Code, "Shortcut Dimension 2 Code");
                IF Dimval.FIND('-') THEN
                    "Budget Center Name" := Dimval.Name
            end;
        }
        field(57; "Function Name"; Text[500])
        {
            Description = 'Stores the name of the function in the database';
        }
        field(58; "Budget Center Name"; Text[500])
        {
            Description = 'Stores the name of the budget center in the database';
        }
        field(81; "Shortcut Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                Dimval.RESET;
                //Dimval.SETRANGE(Dimval."Global Dimension No.",3);
                Dimval.SETRANGE(Dimval.Code, "Shortcut Dimension 3 Code");
                IF Dimval.FIND('-') THEN
                    Dim3 := Dimval.Name
            end;
        }
        field(82; "Shortcut Dimension 4 Code"; Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                Dimval.RESET;
                //Dimval.SETRANGE(Dimval."Global Dimension No.",4);
                Dimval.SETRANGE(Dimval.Code, "Shortcut Dimension 4 Code");
                IF Dimval.FIND('-') THEN
                    Dim4 := Dimval.Name
            end;
        }
        field(83; Dim3; Text[250])
        {
        }
        field(84; Dim4; Text[250])
        {
        }
        field(85; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code ;//where(grouping = filter('SRN'));

            trigger OnValidate()
            begin



            end;
        }
        field(86; TotalAmount; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("PROC-Store Requistion Lines"."Line Amount" WHERE("Requistion No" = FIELD("No.")));
            Editable = false;
        }
        field(87; "Issuing Store"; Code[50])
        {
            TableRelation = IF ("Store Requisition Type" = CONST(Item)) Location;

            trigger OnValidate()
            begin

                ReqLines.RESET;
                ReqLines.SETRANGE(ReqLines."Requistion No", "No.");
                IF ReqLines.FIND('-') THEN BEGIN
                    REPEAT
                        ReqLines."Issuing Store" := "Issuing Store";
                    UNTIL ReqLines.NEXT = 0;
                END;
            end;
        }
        field(88; "Store Requisition Type"; Option)
        {
            OptionCaption = 'Item';
            OptionMembers = Item;
        }
        field(89; "Issue Date"; Date)
        {
        }
        field(90; Committed; Boolean)
        {
        }
        field(91; "SRN.No"; Code[20])
        {
        }
        field(50045; "Budgeted Amount"; Decimal)
        {
            Editable = false;
        }
        field(50046; "Actual Expenditure"; Decimal)
        {
            Editable = false;
        }
        field(50047; "Committed Amount"; Decimal)
        {
            Editable = false;
        }
        field(50048; "Budget Balance"; Decimal)
        {
            Editable = false;
        }
        field(50049; Amount; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("PROC-Store Requistion Lines"."Line Amount" WHERE("Requistion No" = FIELD("No.")));
            Editable = false;

        }
        field(50050; "Requisition Type"; Option)
        {

            OptionMembers = Item,"Minor Asset";
        }
        field(50051; "Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Shortcut Dimension 2 Code")));
            Editable = false;
        }
        field(50052; "Staff No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Issuer; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Remarks; text[2048])
        {

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Status <> Status::Open THEN
            ERROR('You Cannot DELETE an already released Requisition')
    end;

    trigger OnInsert()
    begin

        IF "No." = '' THEN BEGIN
            GenLedgerSetup.GET();
            GenLedgerSetup.TESTFIELD(GenLedgerSetup."Stores Requisition No");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Stores Requisition No", xRec."No. Series", 0D, "No.", "No. Series");
            "Requester ID" := UserId;
            "Request date" := Today;
        END;
        rec.SETRANGE(rec."User ID", USERID);
        rec.SETRANGE(rec.Status, Rec.Status::Open);
        IF rec.COUNT > 0 THEN BEGIN
            ERROR('There are still some pending requisitions in your account. Please use the pending application first');
        END;
        rec.SETRANGE(rec."User ID", USERID);
        rec.SETRANGE(rec.Status, Rec.Status::"Pending Approval");
        IF rec.COUNT > 0 THEN BEGIN
            ERROR('There are still some pending requisitions in your account. Please use the pending application first');
        END;
    end;

    trigger OnModify()
    begin
        ReqLines.RESET;
        ReqLines.SETRANGE(ReqLines."Requistion No", "No.");
        IF ReqLines.FIND('-') THEN BEGIN
            REPEAT
                ReqLines."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                ReqLines."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                ReqLines."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                ReqLines."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
            UNTIL ReqLines.NEXT = 0;
        END;
    end;

    var
        // NoSeriesMgt;
        // UserMgt;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenLedgerSetup: Record "Purchases & Payables Setup";
        //UserDept: Record "61733";
        //RespCenter: Record "61695";
        //UserMgt: Codeunit "User Setup Management";
        Text001: Label 'Your identification is set up to process from %1 %2 only.';
        Dimval: Record "Dimension Value";
        ReqLines: Record "PROC-Store Requistion Lines";

    /// <summary>
    /// StoresLinesExist.
    /// </summary>
    procedure StoresLinesExist()
    begin
    end;
}

