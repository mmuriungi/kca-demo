table 50902 "Meal-Proc. Batch Lines"
{

    fields
    {
        field(1; "Batch Date"; Date)
        {
        }
        field(2; "Item Code"; Code[20])
        {
            Caption = 'No.';
            TableRelation = Item."No." WHERE("Item Category Code" = FILTER('FOOD' | 'KITCHEN' | 'MEAL' | 'MEALS'));

            trigger OnValidate()
            begin
                Item.RESET;
                Item.SETRANGE("No.", "Item Code");
                IF Item.FIND('-') THEN BEGIN
                    Item.TESTFIELD("Control Unit of Measure");
                    IF Item."Control Unit of Measure" = '' THEN BEGIN
                        Item.TESTFIELD("Base Unit of Measure");
                        Item."Control Unit of Measure" := Item."Base Unit of Measure";
                        Item.MODIFY;
                    END;
                    //Item.TESTFIELD("Product Class");
                    IF Item."Product Class" = Item."Product Class"::" " THEN BEGIN
                        Item."Product Class" := Item."Product Class"::"Main Meal";
                        Item.MODIFY;
                    END;
                    //   "Production  Area":=Item."Production Area";
                    "Requirered Unit of Measure" := Item."Control Unit of Measure";
                    ItemUnitofMeasure.RESET;
                    ItemUnitofMeasure.SETRANGE("Item No.", Item."No.");
                    ItemUnitofMeasure.SETRANGE(Code, Item."Control Unit of Measure");
                    IF ItemUnitofMeasure.FIND('-') THEN BEGIN
                        "Requirered Unit of Measure" := Item."Control Unit of Measure";
                    END;
                END;

                MealProcBatchnoSetup.RESET;
                MealProcBatchnoSetup.SETRANGE(MealProcBatchnoSetup."Product Class", Item."Product Class");
                IF MealProcBatchnoSetup.FIND('-') THEN BEGIN
                    MealProcBatchnoSetup.TESTFIELD("Batch No. Series");
                    MealProcBatchnoSetup.TESTFIELD("Expiration computation");
                END ELSE
                    ERROR('Batch Setup for ' + "Item Code" + ' IS MISSING');

                MealProdBatched.RESET;
                MealProdBatched.SETRANGE("Batch Date", Rec."Batch Date");
                MealProdBatched.SETRANGE("Product Class", Item."Product Class");
                IF MealProdBatched.FIND('-') THEN BEGIN
                    Rec."Batch Serial" := MealProdBatched."Batch No";
                    Rec."Expiry Date" := MealProdBatched."Expiry Date";
                    Rec."Date of Manufacture" := MealProdBatched."Manufacture Date";
                    // Rec.MODIFY;
                END ELSE BEGIN
                    Item.RESET;
                    Item.SETRANGE("No.", "Item Code");
                    IF Item.FIND('-') THEN BEGIN
                        Item.TESTFIELD("Control Unit of Measure");
                        Item.TESTFIELD("Product Class");
                        MealProdBatched.INIT;
                        MealProdBatched."Batch Date" := Rec."Batch Date";
                        MealProdBatched."Product Class" := Item."Product Class";
                        MealProdBatched."Batch No" := (NoSeriesManagement.GetNextNo(
                        MealProcBatchnoSetup."Batch No. Series", Rec."Batch Date", TRUE)) + FORMAT(Rec."Batch Date");
                        MealProdBatched."Manufacture Date" := Rec."Batch Date";
                        MealProdBatched."Expiry Date" :=
                        CALCDATE(MealProcBatchnoSetup."Expiration computation", Rec."Batch Date");
                        MealProdBatched.INSERT;

                        MealProdBatched.RESET;
                        MealProdBatched.SETRANGE("Batch Date", Rec."Batch Date");
                        MealProdBatched.SETRANGE("Product Class", Item."Product Class");
                        IF MealProdBatched.FIND('-') THEN BEGIN
                            Rec."Batch Serial" := MealProdBatched."Batch No";
                            Rec."Expiry Date" := MealProdBatched."Expiry Date";
                            Rec."Date of Manufacture" := MealProdBatched."Manufacture Date";
                            // Rec.MODIFY;
                        END;
                    END;
                END;


                ProductionCustProdSource.RESET;
                ProductionCustProdSource.SETRANGE("Batch Date", Rec."Batch Date");
                ProductionCustProdSource.SETRANGE("Parent Item", Rec."Item Code");
                ProductionCustProdSource.SETRANGE("Production  Area", Rec."Production  Area");
                IF ProductionCustProdSource.FIND('-') THEN ProductionCustProdSource.DELETEALL;
            end;
        }
        field(3; "Item Description"; Text[150])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item Code")));
            FieldClass = FlowField;
        }
        field(34; "BOM Count"; Integer)
        {
            CalcFormula = Count("Meal-Proc. BOM Prod. Source" WHERE("Batch Date" = FIELD("Batch Date"),
                                                                     "Parent Item" = FIELD("Item Code"),
                                                                     "Batch ID" = FIELD("Batch ID")));
            FieldClass = FlowField;
        }
        field(37; Approve; Boolean)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Batch Serial");
                TESTFIELD("Date of Manufacture");
                TESTFIELD("Expiry Date");
                IF Approve THEN BEGIN
                    Reject := FALSE;
                    "Reject Reason" := '';
                END;

                //"Approved by"
                "Approved by" := USERID;
                "Approved Time" := TIME;
                //"Approved Machine":=environ('Clientname');

                FRMVitalSetup.RESET;
                IF FRMVitalSetup.FIND('-') THEN BEGIN
                    // // // //  IF FRMVitalSetup."Prod Approval Start Time"<>0T THEN BEGIN
                    // // // // IF (TIME < FRMVitalSetup."Prod Approval Start Time") THEN
                    // // // //  ERROR('Approvals are set to begin at '+FORMAT(FRMVitalSetup."Prod Approval Start Time"));
                    // // // //    END;
                END;
            end;
        }
        field(38; Reject; Boolean)
        {

            trigger OnValidate()
            begin
                "Rejected By" := USERID;
                "Rejected Time" := TIME;
            end;
        }
        field(39; "Reject Reason"; Text[250])
        {
        }
        field(52; "Approved by"; Code[20])
        {
        }
        field(53; "Approved Time"; Time)
        {
        }
        field(54; "Approved Machine"; Code[100])
        {
        }
        field(57; "Rejected By"; Code[20])
        {
        }
        field(58; "Rejected Time"; Time)
        {
        }
        field(59; "Created By"; Code[20])
        {
        }
        field(60; "Created Time"; Time)
        {
        }
        field(300; "Production  Area"; Option)
        {
            OptionCaption = ' ,Kitchen,Location a,Location b';
            OptionMembers = " ",Kitchen,"Location a","Location b";
        }
        field(301; "Required QTY"; Decimal)
        {

            trigger OnValidate()
            begin
                ProductionCustProdSource.RESET;
                ProductionCustProdSource.SETRANGE("Batch Date", Rec."Batch Date");
                ProductionCustProdSource.SETRANGE("Parent Item", Rec."Item Code");
                ProductionCustProdSource.SETRANGE("Batch ID", Rec."Batch ID");
                IF ProductionCustProdSource.FIND('-') THEN ProductionCustProdSource.DELETEALL;


                Item.RESET;
                Item.SETRANGE("No.", "Item Code");
                IF Item.FIND('-') THEN BEGIN
                    Item.TESTFIELD("Control Unit of Measure");
                    //  "Production  Area":=Item."Production Area";
                    "Requirered Unit of Measure" := Item."Control Unit of Measure";
                    ItemUnitofMeasure.RESET;
                    ItemUnitofMeasure.SETRANGE("Item No.", Item."No.");
                    ItemUnitofMeasure.SETRANGE(Code, Item."Control Unit of Measure");
                    IF ItemUnitofMeasure.FIND('-') THEN BEGIN
                        "QTY in KGs" := ItemUnitofMeasure."Qty. per Unit of Measure" * "Required QTY";
                        "QTY in Tones" := (ItemUnitofMeasure."Qty. per Unit of Measure" * "Required QTY") / 1000;
                    END;
                    // Item.TESTFIELD(Item."Production BOM No.");
                    ProductionBOMLine.RESET;
                    ProductionBOMLine.SETRANGE("Production BOM No.", Item."Production BOM No.");
                    ProductionBOMLine.SETFILTER(Type, '%1', ProductionBOMLine.Type::Item);
                    IF ProductionBOMLine.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            ProductionCustProdSource.INIT;
                            ProductionCustProdSource."Batch Date" := Rec."Batch Date";
                            ProductionCustProdSource."Batch ID" := Rec."Batch ID";
                            ProductionCustProdSource."Parent Item" := Rec."Item Code";
                            ProductionCustProdSource."Item No." := ProductionBOMLine."No.";
                            ProductionCustProdSource.VALIDATE("Item No.");
                            ProductionCustProdSource."Production  Area" := Rec."Production  Area";
                            ProductionCustProdSource."Created By" := USERID;
                            ProductionCustProdSource."Item Quantity" := Rec."Required QTY";
                            ;
                            ProductionCustProdSource.VALIDATE("Item Quantity");
                            ProductionCustProdSource."Unit of Measure" := ProductionBOMLine."Unit of Measure Code";
                            ProductionCustProdSource."Captured By" := USERID;
                            ProductionCustProdSource."Captured Time" := TIME;
                            ProductionCustProdSource."BOM Design Quantity" := ProductionBOMLine.Quantity;
                            ProductionCustProdSource."Consumption Quantiry" := ProductionBOMLine.Quantity * Rec."Required QTY";
                            ProductionCustProdSource."Control Unit of Measure" := Item."Control Unit of Measure";
                            ProductionCustProdSource.INSERT;
                        END;
                        UNTIL ProductionBOMLine.NEXT = 0;
                    END;
                END;
            end;
        }
        field(302; "Requirered Unit of Measure"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item Code"));
        }
        field(303; "QTY in KGs"; Decimal)
        {
        }
        field(304; "QTY in Tones"; Decimal)
        {
        }
        field(305; "Batch Serial"; Code[100])
        {
        }
        field(306; "Date of Manufacture"; Date)
        {
        }
        field(307; "Expiry Date"; Date)
        {
        }
        field(308; Posted; Boolean)
        {
        }
        field(309; "Transfer Order No"; Code[20])
        {
        }
        field(310; "Transfer Order Created"; Boolean)
        {
        }
        field(311; "Batch ID"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Batch Date", "Item Code", "Production  Area", "Batch ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Approve THEN BEGIN
            //   IF ProductionPermissions.GET(USERID) THEN
            // ProductionPermissions.TESTFIELD("Delete After Approval")
            //   ELSE ERROR('Access Denied!');
        END;
        IF Posted THEN ERROR('Posted!');

        ProductionCustProdSource.RESET;
        ProductionCustProdSource.SETRANGE(ProductionCustProdSource."Batch Date", Rec."Batch Date");
        ProductionCustProdSource.SETRANGE(ProductionCustProdSource."Production  Area", Rec."Production  Area");
        IF ProductionCustProdSource.FIND('-') THEN BEGIN
            ProductionCustProdSource.DELETEALL;
        END;


        //IF ProductionBatches.GET("Batch Date",Rec."Production  Area") THEN BEGIN
        IF ProductionBatches.Status <> ProductionBatches.Status::Draft THEN BEGIN
            //   IF ProductionPermissions.GET(USERID) THEN
            // ProductionPermissions.TESTFIELD("Delete After Approval")
            //   ELSE ERROR('Access Denied!');
        END;
        // END ELSE ERROR('Batch does not exists!');
    end;

    trigger OnInsert()
    begin
        // IF ProductionPermissions.GET(USERID) THEN
        //   ProductionPermissions.TESTFIELD("Create Meal-Proc. plan")
        // ELSE ERROR('Access Denied!');

        //IF ProductionBatches.GET("Batch Date",Rec."Production  Area") THEN BEGIN
        IF ProductionBatches.Status <> ProductionBatches.Status::Draft THEN BEGIN
            //   IF ProductionPermissions.GET(USERID) THEN
            // ProductionPermissions.TESTFIELD("Insert After Approval")
            //   ELSE ERROR('Access Denied!');
        END;
        // END ELSE ERROR('Batch does not exists!');

        "Created By" := USERID;
        "Created Time" := TIME;
    end;

    trigger OnModify()
    begin
        //IF ProductionBatches.GET("Batch Date",Rec."Production  Area") THEN BEGIN
        IF ProductionBatches.Status <> ProductionBatches.Status::Draft THEN BEGIN
            ERROR('Closed Batch');
            //   IF ProductionPermissions.GET(USERID) THEN
            // ProductionPermissions.TESTFIELD("Modify After Approval")
            //   ELSE ERROR('Access Denied!');
        END;
        //  END ELSE ERROR('Batch does not exists!');

        IF Posted THEN ERROR('Posted!');
    end;

    var
        ProductionBatches: Record "Meal-Proc. Batches";
        ProductionCustProdSource: Record "Meal-Proc. BOM Prod. Source";
        // ProductionPermissions: Record Permiss;
        FRMVitalSetup: Record "FRM Vital Setup";
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ProductionBOMLine: Record "Production BOM Line";
        ProductionBatchLines1: Record "Meal-Proc. Batch Lines";
        NextSerial: Code[20];
        MealProdBatched: Record "Meal Proc. Prod. Batches";
        MealProcBatchnoSetup: Record "Batch number Setup";
        Items2: Record Item;
        NoSeriesManagement: Codeunit NoSeriesManagement;

    procedure CreateTransferOrder()
    var
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        LineNo: Integer;
        ItmJnl: Record "Item Journal Line";
        ItemRec: Record Item;
        TransferNo: Code[20];
    begin
        //IF "Transfer Order Created" THEN
        //ERROR('Transfer order has been created for this document');
        TransferHeader.INIT;
        ItmJnl.RESET;
        ItmJnl.SETRANGE(ItmJnl."Document No.", Rec."Batch Serial");
        IF ItmJnl.FINDFIRST THEN
            TransferNo := NoSeriesManagement.GetNextNo('MI-11', TransferHeader."Posting Date", TRUE);
        //TransferNo:=
        TransferHeader."No." := TransferNo;
        TransferHeader."Transfer-from Code" := ItmJnl."Location Code";
        TransferHeader.VALIDATE("Transfer-from Code");
        TransferHeader."Transfer-to Code" := 'COLD ROOM 2';
        TransferHeader.VALIDATE("Transfer-to Code");
        TransferHeader."In-Transit Code" := 'IN-TRANS';
        TransferHeader."Posting Date" := ItmJnl."Posting Date";
        TransferHeader."Shipment Date" := ItmJnl."Posting Date";
        TransferHeader."Receipt Date" := ItmJnl."Posting Date";
        //"Output Voucher No.":="Document No.";
        //"Transfer Type":="Transfer Type"::"Output Transfer";
        TransferHeader."Assigned User ID" := USERID;
        //TransferHeader."External Document No.":=Rec."Order No.";
        TransferHeader.VALIDATE("Transfer-from Code");
        TransferHeader.VALIDATE("Transfer-to Code");
        IF TransferHeader.INSERT THEN BEGIN
            //Rec."Transfer Order No.":=TransferHeader."No.";
            //Rec."Transfer Order Created":=TRUE;
            TransferHeader.MODIFY;
        END;
        /*"Transfer Order No.":=TransferHeader."No.";
        "Transfer Order Created":=TRUE;
        MODIFY;
       */
        TransferHeader.RESET;
        TransferHeader.SETRANGE(TransferHeader."No.", "Batch Serial");
        TransferHeader.SETRANGE("Posting Date", "Batch Date");
        //TransferHeader.SETRANGE(TransferHeader."External Document No.","Order No.");
        IF TransferHeader.FINDFIRST THEN BEGIN
            ItmJnl.RESET;
            ItmJnl.SETRANGE(ItmJnl."Document No.", Rec."Batch Serial");
            ItmJnl.SETFILTER(ItmJnl."Output Quantity", '>%1', 0);
            IF ItmJnl.FINDSET THEN BEGIN
                REPEAT
                    LineNo += 10000;
                    TransferLine.INIT;
                    TransferLine."Line No." := LineNo;
                    TransferLine."Document No." := TransferHeader."No.";
                    IF ItemRec.GET(ItmJnl."Item No.") THEN BEGIN
                        TransferLine."Item Category Code" := ItemRec."Item Category Code";
                        // TransferLine."Product Group Code":=ItemRec."Product Group Code";
                    END;
                    TransferLine."Item No." := ItmJnl."Item No.";
                    TransferLine.VALIDATE("Item No.");
                    TransferLine.Quantity := ItmJnl."Output Quantity";
                    TransferLine."Transfer-from Code" := TransferHeader."Transfer-from Code";
                    TransferLine."Transfer-to Code" := TransferHeader."Transfer-to Code";
                    TransferLine."Shortcut Dimension 1 Code" := ItmJnl."Shortcut Dimension 1 Code";
                    TransferLine."Shipment Date" := TransferHeader."Posting Date";
                    TransferLine."Receipt Date" := TransferHeader."Posting Date";
                    TransferLine.VALIDATE("Shortcut Dimension 1 Code");
                    TransferLine."Shortcut Dimension 2 Code" := ItmJnl."Shortcut Dimension 2 Code";
                    TransferLine.VALIDATE("Shortcut Dimension 2 Code");
                    TransferLine."Gen. Prod. Posting Group" := ItmJnl."Gen. Prod. Posting Group";
                    TransferLine.VALIDATE(Quantity);
                    TransferLine.VALIDATE("Transfer-from Code");
                    TransferLine.VALIDATE("Transfer-to Code");
                    TransferLine."Unit of Measure Code" := ItmJnl."Unit of Measure Code";
                    TransferLine."Document No." := TransferHeader."No.";
                    TransferLine."Unit of Measure" := ItmJnl."Unit of Measure Code";
                    TransferLine.VALIDATE("Unit of Measure Code");
                    TransferLine.INSERT(TRUE);
                UNTIL ItmJnl.NEXT = 0;
            END;
            //"Transfer Order No.":=TransferHeader."No.";
            //"Transfer Order Created":=TRUE;
            MODIFY;

        END;
        //"Transfer Order No.":=TransferHeader."No.";
        //"Transfer Order Created":=TRUE;

        PAGE.RUN(PAGE::"Transfer Order", TransferHeader);

    end;
}

