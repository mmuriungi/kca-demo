table 50901 "Meal-Proc. Batches"
{

    fields
    {
        field(1; "Batch Date"; Date)
        {

            trigger OnValidate()
            var
                NoSeriesManagement: Codeunit NoSeriesManagement;
                ProductionCentralSetup: Record "Meal-Proc. Central Setup";
                NextSerial: Code[20];
            begin
                CLEAR(NextSerial);
                ProductionCentralSetup.RESET;
                IF ProductionCentralSetup.FIND('-') THEN BEGIN
                    ProductionCentralSetup.TESTFIELD("Processing Batch Serial");

                END ELSE
                    ERROR('Central Setup missing');
                //  "Created By":=USERID;
                "Created Time" := TIME;
                "Batch Month" := DATE2DMY("Batch Date", 2);
                "Batch Year" := DATE2DMY("Batch Date", 3);
                IF (DATE2DMY("Batch Date", 2) = 1) THEN
                    "Batch Month Name" := 'JAN'
                ELSE
                    IF (DATE2DMY("Batch Date", 2) = 2) THEN
                        "Batch Month Name" := 'FEB'
                    ELSE
                        IF (DATE2DMY("Batch Date", 2) = 3) THEN
                            "Batch Month Name" := 'MAR'
                        ELSE
                            IF (DATE2DMY("Batch Date", 2) = 4) THEN
                                "Batch Month Name" := 'APR'
                            ELSE
                                IF (DATE2DMY("Batch Date", 2) = 5) THEN
                                    "Batch Month Name" := 'MAY'
                                ELSE
                                    IF (DATE2DMY("Batch Date", 2) = 6) THEN
                                        "Batch Month Name" := 'JUN'
                                    ELSE
                                        IF (DATE2DMY("Batch Date", 2) = 7) THEN
                                            "Batch Month Name" := 'JUL'
                                        ELSE
                                            IF (DATE2DMY("Batch Date", 2) = 8) THEN
                                                "Batch Month Name" := 'AUG'
                                            ELSE
                                                IF (DATE2DMY("Batch Date", 2) = 9) THEN
                                                    "Batch Month Name" := 'SEP'
                                                ELSE
                                                    IF (DATE2DMY("Batch Date", 2) = 10) THEN
                                                        "Batch Month Name" := 'OCT'
                                                    ELSE
                                                        IF (DATE2DMY("Batch Date", 2) = 11) THEN
                                                            "Batch Month Name" := 'NOV'
                                                        ELSE
                                                            IF (DATE2DMY("Batch Date", 2) = 12) THEN
                                                                "Batch Month Name" := 'DEC';

                // Populate the Customer Order Lines Here
                // Check if a prevous order plan exists and adopt. If not, pick for all Prod Customers
                IF CONFIRM('Populate Products automatically?', TRUE) = FALSE THEN EXIT;
                ProductionBatches.RESET;
                ProductionBatches.SETRANGE(ProductionBatches."Batch Date", (CALCDATE('-1D', "Batch Date")));
                IF ProductionBatches.FIND('-') THEN BEGIN
                    IF CONFIRM('Populate list using yesterdays Plan?', TRUE) = TRUE THEN BEGIN
                        ProductionBatchLines.RESET;
                        ProductionBatchLines.SETRANGE(ProductionBatchLines."Batch Date", (CALCDATE('-1D', "Batch Date")));
                        ProductionBatchLines.SETRANGE(ProductionBatchLines."Batch ID", "Batch ID");
                        ProductionBatchLines.SETFILTER(ProductionBatchLines."BOM Count", '>%1', 0);
                        IF ProductionBatchLines.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN

                                ProductionBatchLines1.RESET;
                                ProductionBatchLines1.SETRANGE(ProductionBatchLines1."Batch Date", "Batch Date");
                                ProductionBatchLines1.SETRANGE(ProductionBatchLines1."Item Code", ProductionBatchLines."Item Code");
                                ProductionBatchLines1.SETRANGE(ProductionBatchLines1."Batch ID", "Batch ID");
                                IF NOT (ProductionBatchLines1.FIND('-')) THEN BEGIN
                                    //Check if batch is created
                                    // NextSerial:=NoSeriesManagement.GetNextNo(ProductionCentralSetup."Processing Batch Serial",TODAY,TRUE);
                                    ProductionBatchLines1.INIT;
                                    ProductionBatchLines1."Batch Date" := "Batch Date";
                                    ProductionBatchLines1."Batch ID" := "Batch ID";
                                    ProductionBatchLines1."Item Code" := ProductionBatchLines."Item Code";
                                    ProductionBatchLines1.VALIDATE("Item Code");
                                    //  ProductionBatchLines."Batch Serial":=NextSerial;
                                    ProductionBatchLines1."Production  Area" := ProductionBatchLines."Production  Area";
                                    ProductionBatchLines1.VALIDATE("Item Code");
                                    ProductionBatchLines1.INSERT;
                                END ELSE
                                    ProductionBatchLines1.VALIDATE("Item Code");
                                // Insert the Order Details from Yesterday
                            END;
                            UNTIL ProductionBatchLines.NEXT = 0;
                        END;
                    END ELSE BEGIN
                        CLEAR(Items);
                        Items.RESET;
                        //Items.SETFILTER(Items."Production Area",'=%1',Items."Production Area"::Kitchen);
                        Items.SETFILTER("Production BOM No.", '<>%1', '');
                        Items.SETFILTER("Item Category Code", '%1|%2', 'FOOD', 'KITCHEN');
                        IF Items.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                ProductionBatchLines.RESET;
                                ProductionBatchLines.SETRANGE(ProductionBatchLines."Batch Date", "Batch Date");
                                ProductionBatchLines.SETRANGE(ProductionBatchLines."Item Code", Items."No.");
                                ProductionBatchLines.SETRANGE(ProductionBatchLines."Batch ID", "Batch ID");
                                IF NOT (ProductionBatchLines.FIND('-')) THEN BEGIN
                                    //NextSerial:=NoSeriesManagement.GetNextNo(ProductionCentralSetup."Processing Batch Serial",
                                    //TODAY,TRUE);
                                    ProductionBatchLines.INIT;
                                    ProductionBatchLines."Batch Date" := "Batch Date";
                                    ProductionBatchLines."Batch ID" := "Batch ID";
                                    ProductionBatchLines."Item Code" := Items."No.";
                                    ProductionBatchLines.VALIDATE("Item Code");
                                    // ProductionBatchLines."Production  Area":=Items."Production Area";
                                    //  ProductionBatchLines."Batch Serial":=NextSerial;
                                    ProductionBatchLines.INSERT;
                                END ELSE
                                    ProductionBatchLines.VALIDATE("Item Code");
                            END;
                            UNTIL Items.NEXT = 0;
                        END;
                    END;
                END ELSE BEGIN
                    CLEAR(Items);
                    Items.RESET;
                    //Items.SETFILTER(Items."Production Area",'=%1',Items."Production Area"::Kitchen);
                    Items.SETFILTER("Production BOM No.", '<>%1', '');
                    Items.SETFILTER("Item Category Code", '%1|%2', 'FOOD', 'KITCHEN');
                    IF Items.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            ProductionBatchLines.RESET;
                            ProductionBatchLines.SETRANGE(ProductionBatchLines."Batch Date", "Batch Date");
                            ProductionBatchLines.SETRANGE(ProductionBatchLines."Item Code", Items."No.");
                            ProductionBatchLines.SETRANGE(ProductionBatchLines."Batch ID", "Batch ID");
                            IF NOT (ProductionBatchLines.FIND('-')) THEN BEGIN
                                // NextSerial:=NoSeriesManagement.GetNextNo(ProductionCentralSetup."Processing Batch Serial",
                                //TODAY,TRUE);
                                ProductionBatchLines.INIT;
                                ProductionBatchLines."Batch Date" := "Batch Date";
                                ProductionBatchLines."Batch ID" := "Batch ID";
                                ProductionBatchLines."Item Code" := Items."No.";
                                ProductionBatchLines.VALIDATE("Item Code");
                                //  ProductionBatchLines."Batch Serial":=NextSerial;
                                // ProductionBatchLines."Production  Area":=Items."Production Area";
                                ProductionBatchLines.VALIDATE("Item Code");
                                ProductionBatchLines.INSERT;
                            END ELSE
                                ProductionBatchLines.VALIDATE("Item Code");
                        END;
                        UNTIL Items.NEXT = 0;
                    END;
                END;
            end;
        }
        field(2; "Created Time"; Time)
        {
        }
        field(3; "Batch Month"; Integer)
        {
        }
        field(4; "Batch Month Name"; Code[20])
        {
        }
        field(5; "Batch Year"; Integer)
        {
        }
        field(6; "No of Items"; Integer)
        {
            CalcFormula = Count("Meal-Proc. Batch Lines" WHERE("Batch Date" = FIELD("Batch Date")));
            FieldClass = FlowField;
        }
        field(7; Status; Option)
        {
            OptionCaption = 'Draft,Final,Posted';
            OptionMembers = Draft,Final,Posted;
        }
        field(8; "Total Value"; Decimal)
        {
        }
        field(9; "Created By"; Code[20])
        {
        }
        field(10; "Daily Total"; Decimal)
        {
            CalcFormula = Sum("Meal-Proc. BOM Prod. Source"."Line Amount" WHERE("Batch Date" = FIELD("Batch Date")));
            FieldClass = FlowField;
        }
        field(11; "Production  Area"; Option)
        {
            OptionCaption = ' ,Kitchen,Location a,Location b';
            OptionMembers = " ",Kitchen,"Location a","Location b";
        }
        field(12; "Batch ID"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Batch Date", "Production  Area", "Batch ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR('Not Allowed!');
    end;

    trigger OnInsert()
    begin
        IF ProductionPermissions.GET(USERID) THEN
            ProductionPermissions.TESTFIELD("Create Batch")
        ELSE
            ERROR('Access denied.');

        // IF  ProductionPermissions."Production  Area"=ProductionPermissions."Production  Area"::" " THEN
        //  ERROR('Production  Area is not specified for you!');
        "Production  Area" := ProductionPermissions."Production  Area";

        //
        // IF "Batch Date"=0D THEN BEGIN
        // //IF NOT (ProductionBatches.GET(TODAY)) THEN
        //  ProductionBatches.RESET;
        //  ProductionBatches
        //   Rec."Batch Date":=TODAY;
        // VALIDATE(Rec."Batch Date");
        // END;
        CLEAR(ProductionBatches);
        ProductionBatches.RESET;
        ProductionBatches.SETRANGE("Batch Date", TODAY);
        IF ProductionBatches.FIND('-') THEN;
        Rec."Batch Date" := TODAY;
        Rec."Batch ID" := ProductionBatches.COUNT + 1;
        VALIDATE(Rec."Batch Date");
    end;

    trigger OnModify()
    begin
        IF ProductionPermissions.GET(USERID) THEN
            ProductionPermissions.TESTFIELD("Edit Batch")
        ELSE
            ERROR('Access denied.');

        // IF ProductionPermissions."Production  Area"<>Rec."Production  Area" THEN
        //   ERROR('Access denied.');
    end;

    var
        ProductionBatches: Record "Meal Proc. Prod. Batches";
        ProductionBatchLines: Record "Meal-Proc. Batch Lines";
        Items: Record item;
        ProductionBatchLines1: Record "Meal-Proc. Batch Lines";
        ProductionPermissions: Record "Meal-Proc. Permissions";
        ProductionCustProdSource: Record "Meal-Proc. BOM Prod. Source";
        ProductionCustProdSourceToday: Record "Meal-Proc. BOM Prod. Source";
        NextSerial: Code[20];
        MealProdBatched: Record "Meal Proc. Prod. Batches";
        MealProcBatchnoSetup: Record "Batch number Setup";

        Items2: Record item;
        NoSeriesManagement: Codeunit NoSeriesManagement;
}

