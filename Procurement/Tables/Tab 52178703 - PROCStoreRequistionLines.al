/// <summary>
/// Table PROC-Store Requistion Lines (ID 52178703).
/// </summary>
table 52178703 "PROC-Store Requistion Lines"
{
    //DrillDownPageID = 68151;
    //LookupPageID = 68151;

    fields
    {
        field(1; "Requistion No"; Code[20])
        {

            trigger OnValidate()
            begin
                /*
                  IF ReqHeader.GET("Requistion No") THEN BEGIN
                    IF ReqHeader."Global Dimension 1 Code"='' THEN
                       ERROR('Please Select the Global Dimension 1 Requisitioning')
                  END;
                 */

            end;
        }
        field(3; "Line No."; Integer)
        {

            Caption = 'Line No.';
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Item,Minor Asset';
            OptionMembers = " ",Item,"Minor Asset";
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST(Item)) Item."No."
            ELSE
            IF (Type = CONST("Minor Asset")) "Fixed Asset"."No." WHERE("FA Location Code" = FIELD("Issuing Store"));

            trigger OnValidate()
            begin


                //Control: Don't Post Same Item Twice NOT GL's
                IF Type = Type::" " THEN BEGIN
                    RequisitionLine.RESET;
                    RequisitionLine.SETRANGE(RequisitionLine."Requistion No", "Requistion No");
                    RequisitionLine.SETRANGE(RequisitionLine."No.", "No.");
                    IF RequisitionLine.FIND('-') THEN
                        ERROR('You Cannot enter two lines for the same Item');
                END;
                //

                "Action Type" := "Action Type"::"Ask for Quote";

                IF Type = Type::Item THEN BEGIN
                    CalcFields("In Store");
                    IF QtyStore.GET("No.") THEN
                        Description := QtyStore.Description;
                    "Unit of Measure" := QtyStore."Base Unit of Measure";
                    "Unit Cost" := QtyStore."Unit Cost";
                    //"Line Amount" := "Unit Cost" * "Quantity To Issue";
                    QtyStore.CALCFIELDS(QtyStore.Inventory);
                    "Qty in store" := QtyStore.Inventory;
                    IF ((QtyStore.Inventory <= 0)) THEN MESSAGE('There are no  ''' + QtyStore.Description + '''  in stock.');
                    IF ((QtyStore.Inventory <= 0)) THEN ERROR('There are no ''' + QtyStore.Description + ''' in the Store to be issued!!\Please consult the store Manager for advice.');
                END;

                IF Type = Type::Item THEN BEGIN
                    IF Item.GET("No.") THEN
                        Description := Item.Description;
                END;

                IF Type = Type::"Minor Asset" THEN BEGIN
                    IF FA.GET("No.") THEN
                        Description := FA.Description;
                END;

            end;
        }
        field(6; Description; Text[500])
        {
            Caption = 'Description';
        }
        field(7; "Description 2"; Text[500])
        {
            Caption = 'Description 2';
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                IF QtyStore.GET("No.") THEN
                    QtyStore.CALCFIELDS(QtyStore.Inventory);
                CalcFields("In Store");
                "Qty in store" := QtyStore.Inventory;
                //CheckStocklevel;
            end;
        }
        field(9; "Qty in store"; Decimal)
        {

        }
        field(18; "In Store"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No.")));
            Editable = false;
        }
        field(2; "Qty balance"; Decimal)
        {

        }

        field(10; "Request Status"; Option)
        {
            Editable = true;
            OptionMembers = Pending,Released,"Director Approval","Budget Approval","FD Approval","CEO Approval",Approved,Closed;
        }
        field(11; "Action Type"; Option)
        {
            OptionMembers = " ",Issue,"Ask for Quote";

            trigger OnValidate()
            begin
                IF Type = Type::" " THEN BEGIN
                    IF "Action Type" = "Action Type"::Issue THEN
                        ERROR('You cannot Issue a G/L Account please order for it')
                END;


                //Compare Quantity in Store and Qty to Issue
                IF Type = Type::" " THEN BEGIN
                    CalcFields("In Store");
                    IF "Action Type" = "Action Type"::Issue THEN BEGIN
                        IF Quantity > "In Store" THEN
                            ERROR('You cannot issue more than what is available in store')
                    END;
                END;
            end;
        }
        field(12; "Unit of Measure"; Code[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(13; "Total Budget"; Decimal)
        {
        }
        field(14; "Current Month Budget"; Decimal)
        {
        }
        field(15; "Unit Cost"; Decimal)
        {


        }
        field(16; "Line Amount"; Decimal)
        {
            Editable = false;
        }
        field(17; "Quantity Requested"; Decimal)
        {
            Caption = 'Quantity Requested';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                CalcFields("In Store");
                Quantity := "Quantity Requested";
                "Quantity To Issue" := "Quantity Requested";
                if "Quantity Requested" > "In Store" then
                    Error('You can only request quantity available in Store');
                "Line Amount" := "Unit Cost" * "Quantity Requested";
                VALIDATE(Quantity);
            end;
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(26; "Current Actuals Amount"; Decimal)
        {
        }
        field(27; Committed; Boolean)
        {
        }
        field(81; "Shortcut Dimension 3 Code"; Code[120])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(82; "Shortcut Dimension 4 Code"; Code[120])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(83; "Issuing Store"; Code[20])
        {
            TableRelation = IF (Type = CONST(Item)) Location
            ELSE
            IF (Type = CONST("Minor Asset")) "FA Location";

            trigger OnValidate()
            begin
                //IF Loc.GET("Issuing Store") THEN
                //  "Issue UserID":=Loc."Milk Collection Vehicle";
            end;
        }
        field(84; "Quantity To Issue"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                CalcFields("In Store");
                rec.Reset();
                IF "Quantity To Issue" > "Quantity Requested" THEN ERROR('You cannot Issue more than requested.');
                if "Quantity To Issue" > "In Store" then Error('You can not issue more than what is in the store');
                IF ("Quantity Issued" + "Quantity To Issue") > "Quantity Requested" THEN
                    ERROR('Total Issued Items cannot exceed the Total Requested..');
                "Issue Quantity" := "Quantity To Issue";

                "Qty balance" := "Qty in store" - "Quantity To Issue";
                Validate("Qty balance");
            end;
        }
        field(85; "Quantity Issued"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(86; "Issue Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(50035; "Budgeted Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("Budget Name" = FIELD("Budget Name"),
                                                               "G/L Account No." = FIELD("Vote Account"),
                                                               "Global Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code"),
                                                               "Global Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code")));
            Editable = false;
        }
        field(50036; "Actual Expenditure"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("Vote Account"),
                                                        "Global Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code"),
                                                        "Global Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code")));
            Editable = false;
        }
        field(50037; "Committed Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("FIN-Committment".Amount WHERE("G/L Account No." = FIELD("Vote Account"),
                                                            Budget = FIELD("Budget Name"),
                                                            "Shortcut Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code"),
                                                            "Shortcut Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code")));
            Editable = false;
        }
        field(50038; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(50039; "Budget Balance"; Decimal)
        {
        }
        field(50040; "Vote Account"; Code[20])
        {
        }
        field(50041; "Issue UserID"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Requistion No", "No.")
        {
            Clustered = true;
            SumIndexFields = "Line Amount";
        }
        key(Key2; "No.", Type, "Request Status")
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ReqHeader.RESET;
        ReqHeader.SETRANGE(ReqHeader."No.", "Requistion No");
        IF ReqHeader.FIND('-') THEN
            IF ReqHeader.Status = ReqHeader.Status::posted THEN
                ERROR('You Cannot Delete Entries if status is Pending/Open')
    end;

    trigger OnInsert()
    begin



        ReqHeader.RESET;
        ReqHeader.SETRANGE(ReqHeader."No.", "Requistion No");
        IF ReqHeader.FIND('-') THEN BEGIN
            "Shortcut Dimension 1 Code" := ReqHeader."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := ReqHeader."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code" := ReqHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := ReqHeader."Shortcut Dimension 4 Code";
            IF ReqHeader.Status <> ReqHeader.Status::Open THEN
                ERROR('You Cannot Enter Entries if status is not Pending')
        END;
    end;

    trigger OnModify()
    begin

        IF Type = Type::" " THEN
            //  "Line Amount" := "Unit Cost" * "Quantity To Issue";


            ReqHeader.RESET;
        ReqHeader.SETRANGE(ReqHeader."No.", "Requistion No");
        IF ReqHeader.FIND('-') THEN BEGIN
            "Shortcut Dimension 1 Code" := ReqHeader."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := ReqHeader."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code" := ReqHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := ReqHeader."Shortcut Dimension 4 Code";
            //IF ReqHeader.Status<>ReqHeader.Status::Open THEN
            // IF (("Quantity To Issue"=xRec."Quantity To Issue") AND (xRec."Quantity Issued"="Quantity Issued")
            //AND ("Issue Quantity"=xRec."Issue Quantity")) THEN
            //  ERROR('You Cannot Modify Entries if status is not Pending')
        END;

        /* ReqHeader.RESET;
         ReqHeader.SETRANGE(ReqHeader."No.","Requistion No");
         IF ReqHeader.FIND('-') THEN BEGIN
          "Shortcut Dimension 1 Code":=ReqHeader."Global Dimension 1 Code";
          "Shortcut Dimension 2 Code":=ReqHeader."Shortcut Dimension 2 Code";
          "Shortcut Dimension 3 Code":=ReqHeader."Shortcut Dimension 3 Code";
          "Shortcut Dimension 4 Code":=ReqHeader."Shortcut Dimension 4 Code";
          IF ReqHeader.Status<>ReqHeader.Status::Open THEN
              ERROR('You Cannot Modify Entries if status is not Pending')
         END; */

    end;

    var
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        QtyStore: Record Item;
        GenPostGroup: Record "General Posting Setup";
        Budget: Decimal;
        CurrMonth: Code[10];
        CurrYR: Code[10];
        BudgDate: Text[30];
        ReqHeader: Record "PROC-Store Requistion Header";
        BudgetDate: Date;
        YrBudget: Decimal;
        RequisitionLine: Record "PROC-Store Requistion Lines";
        Item: Record Item;
        FA: Record "Fixed Asset";
        qty: Integer;
        Loc: Record Location;


    procedure CheckStocklevel()
    begin
        Item.RESET;
        Item.GET("No.");
        Item.SETFILTER(Item."Location Filter", "Issuing Store");
        Item.CALCFIELDS(Item.Inventory);
        qty := Item.Inventory;
        IF (qty - Quantity) < 0 THEN BEGIN
            ERROR('This transaction will result in Negative stock');
        END;
    end;
}