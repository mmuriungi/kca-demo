page 53139 "Meal-Proc. Transfer"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Meal-Proc. Batch Lines";
    SourceTableView = WHERE("BOM Count" = FILTER(> 0),
                            Approve = FILTER(true),
                            Posted = FILTER(true));

    layout
    {
        area(content)
        {
            group("Filter")
            {
                Caption = 'Filters';
                field(DateFil; DateFilter)
                {
                    Caption = 'Batch Date';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.SETFILTER("Batch Date", '=%1', DateFilter);
                        CurrPage.UPDATE;
                    end;
                }
            }
            repeater(Group)
            {
                field("Item Code"; Rec."Item Code")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Production  Area"; Rec."Production  Area")
                {
                }
                field("Required QTY"; Rec."Required QTY")
                {
                }
                field("Requirered Unit of Measure"; Rec."Requirered Unit of Measure")
                {
                }
                field("BOM Count"; Rec."BOM Count")
                {
                }
                field("QTY in KGs"; Rec."QTY in KGs")
                {
                }
                field("QTY in Tones"; Rec."QTY in Tones")
                {
                }
                field("Batch Serial"; Rec."Batch Serial")
                {
                }
                field("Date of Manufacture"; Rec."Date of Manufacture")
                {
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action(PostOrder)
                {
                    Caption = '&Post Plan';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedIsBig = true;
                    ShortCutKey = 'F2';
                    Visible = false;

                    trigger OnAction()
                    var
                        counted: Integer;
                    begin
                        Rec.TESTFIELD(Approve);
                        ProductionPermissions.RESET;
                        ProductionPermissions.SETRANGE("User Id", USERID);
                        IF ProductionPermissions.FIND('-') THEN BEGIN
                            ProductionPermissions.TESTFIELD("Default Meal-Proc. Template");
                            ProductionPermissions.TESTFIELD("Default Meal-Proc. Batch");
                            ProductionPermissions.TESTFIELD("Default Raw Material Location");
                            ProductionPermissions.TESTFIELD("Default Product Location");
                        END ELSE
                            ERROR('Access Denied!');
                        IF CONFIRM('Post Production?', TRUE) = FALSE THEN EXIT;
                        ItemJnlLine.RESET;
                        ItemJnlLine.SETRANGE("Journal Template Name", ToTemplateName);
                        ItemJnlLine.SETRANGE("Journal Batch Name", ToBatchName);
                        IF ItemJnlLine.FIND('-') THEN ItemJnlLine.DELETEALL;

                        CLEAR(ToTemplateName);
                        CLEAR(ToBatchName);
                        ToTemplateName := ProductionPermissions."Default Meal-Proc. Template";
                        ToBatchName := ProductionPermissions."Default Meal-Proc. Batch";
                        ItemJnlTemplate.RESET;
                        ItemJnlTemplate.SETRANGE(Name, ToTemplateName);
                        IF ItemJnlTemplate.FIND('-') THEN BEGIN
                        END;
                        ItemJnlBatch.RESET;
                        ItemJnlBatch.SETRANGE("Journal Template Name", ToTemplateName);
                        ItemJnlBatch.SETRANGE(Name, ToBatchName);
                        IF ItemJnlBatch.FIND('-') THEN BEGIN
                        END;
                        ProductionBatchLines.RESET;
                        ProductionBatchLines.SETRANGE("Batch Date", DateFilter);
                        ProductionBatchLines.SETFILTER(Posted, '%1', FALSE);
                        IF ProductionBatchLines.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                //////////////////////////////////////////////////////////////Post Consumption Journal
                                CLEAR(NextLineNo);
                                ItemJnlLine.RESET;
                                ItemJnlLine.SETRANGE("Journal Template Name", ToTemplateName);
                                ItemJnlLine.SETRANGE("Journal Batch Name", ToBatchName);
                                IF ItemJnlLine.FINDLAST THEN NextLineNo := ItemJnlLine."Line No.";
                                CLEAR(OrderLineNo);
                                ProductionBOMProdSource.RESET;
                                ProductionBOMProdSource.SETRANGE("Batch Date", ProductionBatchLines."Batch Date");
                                ProductionBOMProdSource.SETRANGE("Parent Item", ProductionBatchLines."Item Code");
                                ProductionBOMProdSource.SETRANGE("Production  Area", ProductionBatchLines."Production  Area");
                                ProductionBOMProdSource.SETFILTER("Consumption Quantiry", '<>0');
                                IF ProductionBOMProdSource.FIND('-') THEN BEGIN
                                    REPEAT
                                    BEGIN
                                        NextLineNo := NextLineNo + 1000;
                                        OrderLineNo := OrderLineNo + 100;
                                        ItemJnlLine.INIT;
                                        ItemJnlLine."Journal Template Name" := ToTemplateName;
                                        ItemJnlLine."Journal Batch Name" := ToBatchName;
                                        ItemJnlLine."Line No." := NextLineNo;
                                        ItemJnlLine.VALIDATE("Posting Date", ProductionBOMProdSource."Batch Date");
                                        ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::Consumption);
                                        ItemJnlLine."Document Date" := ProductionBOMProdSource."Batch Date";
                                        ItemJnlLine."Document No." := ProductionBatchLines."Batch Serial";
                                        //  ItemJnlLine.."Document Type":=ItemJnlLine.."Document Type"::
                                        ItemJnlLine."Document Line No." := NextLineNo;
                                        ItemJnlLine."Order Type" := ItemJnlLine."Order Type"::Production;
                                        ItemJnlLine."Order No." := ProductionBatchLines."Batch Serial";
                                        ItemJnlLine.VALIDATE("Source No.", ProductionBOMProdSource."Item No.");
                                        ItemJnlLine.VALIDATE("Item No.", ProductionBOMProdSource."Item No.");
                                        ItemJnlLine."Unit of Measure Code" := ProductionBOMProdSource."Unit of Measure";
                                        ProductionBOMProdSource.CALCFIELDS(Description);
                                        ItemJnlLine.Description := ProductionBOMProdSource.Description;

                                        IF ProductionBOMProdSource."Consumption Quantiry" <> 0 THEN
                                            // IF Item."Rounding Precision" > 0 THEN
                                            ItemJnlLine.VALIDATE(Quantity, ProductionBOMProdSource."Consumption Quantiry");
                                        //ELSE
                                        //  ItemJnlLine.VALIDATE(Quantity,ROUND(NeededQty,0.00001));

                                        ItemJnlLine.VALIDATE("Location Code", ProductionPermissions."Default Raw Material Location");
                                        // IF "Bin Code" <> '' THEN
                                        //   ItemJnlLine."Bin Code" := "Bin Code";

                                        // ItemJnlLine."Variant Code" := "Variant Code";
                                        ItemJnlLine."Order Line No." := OrderLineNo;
                                        ItemJnlLine."Prod. Order Comp. Line No." := OrderLineNo;

                                        ItemJnlLine.Level := 1;
                                        ItemJnlLine."Flushing Method" := ItemJnlLine."Flushing Method"::Manual;
                                        ItemJnlLine."Source Code" := ItemJnlTemplate."Source Code";
                                        ItemJnlLine."Reason Code" := ItemJnlBatch."Reason Code";
                                        ItemJnlLine."Posting No. Series" := ItemJnlBatch."Posting No. Series";
                                        IF ItemJnlLine.Quantity <> 0 THEN
                                            ItemJnlLine.INSERT;
                                    END;
                                    UNTIL ProductionBOMProdSource.NEXT = 0;
                                END;

                                ////////////////////////////////////////////////////////////// Post Output Journal
                                ItemJnlLine.RESET;
                                ItemJnlLine.SETRANGE("Journal Template Name", ToTemplateName);
                                ItemJnlLine.SETRANGE("Journal Batch Name", ToBatchName);
                                IF ItemJnlLine.FINDLAST THEN NextLineNo := ItemJnlLine."Line No.";

                                NextLineNo := NextLineNo + 1000;
                                OrderLineNo := OrderLineNo + 100;

                                ItemJnlLine.INIT;
                                ItemJnlLine."Journal Template Name" := ToTemplateName;
                                ItemJnlLine."Journal Batch Name" := ToBatchName;
                                ItemJnlLine."Line No." := NextLineNo;
                                ItemJnlLine.VALIDATE("Posting Date", ProductionBatchLines."Batch Date");
                                ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::Output);
                                //  ItemJnlLine.VALIDATE("Order Type",ItemJnlLine."Order Type"::Production);
                                ItemJnlLine."Document Date" := ProductionBatchLines."Batch Date";
                                ItemJnlLine."Document No." := ProductionBatchLines."Batch Serial";
                                //  ItemJnlLine.."Document Type":=ItemJnlLine.."Document Type"::
                                ItemJnlLine."Document Line No." := NextLineNo;
                                ItemJnlLine."Order Type" := ItemJnlLine."Order Type"::Production;
                                ItemJnlLine."Order No." := ProductionBatchLines."Batch Serial";
                                ;
                                ItemJnlLine."Order Line No." := OrderLineNo;
                                ItemJnlLine.VALIDATE("Item No.", ProductionBatchLines."Item Code");
                                ItemJnlLine."Source Type" := ItemJnlLine."Source Type"::Item;
                                ItemJnlLine.VALIDATE("Source No.", ProductionBatchLines."Item Code");
                                //ItemJnlLine.VALIDATE("Variant Code","Variant Code");
                                ItemJnlLine.VALIDATE("Location Code", ProductionPermissions."Default Product Location");
                                //IF "Bin Code" <> '' THEN
                                //  ItemJnlLine.VALIDATE("Bin Code","Bin Code");
                                //ItemJnlLine.VALIDATE("Routing No.","Routing No.");
                                //ItemJnlLine.VALIDATE("Routing Reference No.","Routing Reference No.");
                                // IF ProdOrderRtngLine."Prod. Order No." <> '' THEN
                                //  ItemJnlLine.VALIDATE("Operation No.",ProdOrderRtngLine."Operation No.");
                                ItemJnlLine."Invoiced Quantity" := ProductionBatchLines."Required QTY";
                                ItemJnlLine.VALIDATE("Invoiced Quantity");
                                ItemJnlLine."Unit of Measure Code" := ProductionBatchLines."Requirered Unit of Measure";
                                ItemJnlLine.VALIDATE("Setup Time", 0);
                                ItemJnlLine.VALIDATE("Run Time", 0);
                                //  IF ("Location Code" <> '') AND (ProdOrderRtngLine."Next Operation No." = '') THEN
                                //    ItemJnlLine.CheckWhse("Location Code",QtyToPost);
                                //  IF ItemJnlLine.SubcontractingWorkCenterUsed THEN
                                //    ItemJnlLine.VALIDATE("Output Quantity",0)
                                //  ELSE
                                ItemJnlLine.VALIDATE("Output Quantity", ProductionBatchLines."Required QTY");
                                ItemJnlLine.VALIDATE(Quantity, ProductionBatchLines."Required QTY");

                                //  IF ProdOrderRtngLine."Routing Status" = ProdOrderRtngLine."Routing Status"::Finished THEN
                                ItemJnlLine.Finished := TRUE;
                                ItemJnlLine."Flushing Method" := ItemJnlLine."Flushing Method"::Manual;
                                ItemJnlLine."Source Code" := ItemJnlTemplate."Source Code";
                                ItemJnlLine."Reason Code" := ItemJnlBatch."Reason Code";
                                ItemJnlLine."Posting No. Series" := ItemJnlBatch."Posting No. Series";

                                IF ItemJnlLine.Quantity <> 0 THEN
                                    ItemJnlLine.INSERT;

                                ProductionBatchLines.Posted := TRUE;
                                ProductionBatchLines.MODIFY;
                            END;
                            UNTIL ProductionBatchLines.NEXT = 0;
                        END;

                        //************************* Post Meal-Proc. Journal here*************************//
                        ItemJnlLine.RESET;
                        ItemJnlLine.SETRANGE("Journal Template Name", ToTemplateName);
                        ItemJnlLine.SETRANGE("Journal Batch Name", ToBatchName);
                        IF ItemJnlLine.FINDFIRST THEN
                            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ItemJnlLine);
                    end;
                }
                action("Create Transfer Order")
                {
                    Image = TransferOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //CreateTransferOrder();
                        TransferHeader.INIT;
                        ItmJnl.RESET;
                        ItmJnl.SETRANGE(ItmJnl."Batch Date", Rec."Batch Date");
                        IF ItmJnl.FINDFIRST THEN BEGIN
                            //   TransferNo:=NoSeriesManagement.GetNextNo('TRANSFER',"Posting Date",TRUE);
                            TransferHeader."No." := TransferNo;
                            TransferHeader."Transfer-from Code" := 'Packaging'; //ItmJnl.Processing';
                            TransferHeader.VALIDATE("Transfer-from Code");
                            TransferHeader."Transfer-to Code" := 'COLDROOM 2';
                            TransferHeader.VALIDATE("Transfer-to Code");
                            TransferHeader."In-Transit Code" := 'TRANSIT';
                            TransferHeader."Posting Date" := ItmJnl."Batch Date";
                            TransferHeader."Shipment Date" := ItmJnl."Batch Date";
                            TransferHeader."Receipt Date" := ItmJnl."Batch Date";
                            TransferHeader."Assigned User ID" := USERID;
                            TransferHeader.VALIDATE("Transfer-from Code");
                            TransferHeader.VALIDATE("Transfer-to Code");
                            TransferHeader.INSERT;
                        END;
                        TransferHeader.RESET;
                        TransferHeader.SETRANGE(TransferHeader."No.", TransferNo);
                        TransferHeader.SETRANGE("Posting Date", Rec."Batch Date");
                        IF TransferHeader.FINDFIRST THEN BEGIN
                            ItmJnl.RESET;
                            ItmJnl.SETRANGE(ItmJnl."Batch Serial", Rec."Batch Serial");
                            ItmJnl.SETFILTER(ItmJnl."Required QTY", '>%1', 0);
                            IF ItmJnl.FINDSET THEN BEGIN
                                REPEAT
                                    lineNo += 10000;
                                    TransferLine.INIT;
                                    TransferLine."Line No." := lineNo;
                                    TransferLine."Document No." := TransferHeader."No.";
                                    IF ItemRec.GET(ItmJnl."Item Code") THEN BEGIN
                                        TransferLine."Item Category Code" := ItemRec."Item Category Code";
                                        //    TransferLine."Product Group Code":=ItemRec."Product Group Code";
                                    END;
                                    TransferLine."Item No." := ItmJnl."Item Code";
                                    TransferLine.VALIDATE("Item No.");
                                    TransferLine.Quantity := ItmJnl."Required QTY";
                                    TransferLine."Transfer-from Code" := TransferHeader."Transfer-from Code";
                                    TransferLine."Transfer-to Code" := TransferHeader."Transfer-to Code";
                                    TransferLine."Shortcut Dimension 1 Code" := 'A07';//ItmJnl."Shortcut Dimension 1 Code";
                                    TransferLine."Shipment Date" := TransferHeader."Posting Date";
                                    TransferLine."Receipt Date" := TransferHeader."Posting Date";
                                    TransferLine.VALIDATE("Shortcut Dimension 1 Code");
                                    TransferLine."Shortcut Dimension 2 Code" := 'Processing';//ItmJnl."Shortcut Dimension 2 Code";
                                    TransferLine.VALIDATE("Shortcut Dimension 2 Code");
                                    //TransferLine."Gen. Prod. Posting Group":=ItmJnl."Gen. Prod. Posting Group";
                                    TransferLine.VALIDATE(Quantity);
                                    TransferLine.VALIDATE("Transfer-from Code");
                                    TransferLine.VALIDATE("Transfer-to Code");
                                    TransferLine."Unit of Measure Code" := ItmJnl."Requirered Unit of Measure";
                                    TransferLine."Document No." := TransferHeader."No.";
                                    TransferLine."Unit of Measure" := ItmJnl."Requirered Unit of Measure";
                                    TransferLine.VALIDATE("Unit of Measure Code");
                                    TransferLine.INSERT(TRUE);
                                UNTIL ItmJnl.NEXT = 0;
                            END;
                            Rec."Transfer Order No" := TransferHeader."No.";
                            Rec."Transfer Order Created" := TRUE;
                            Rec.MODIFY;

                        END;


                        PAGE.RUN(PAGE::"Transfer Order", TransferHeader);
                    end;
                }
            }
            group("Summary Reports")
            {
                Caption = 'Summary Reports';
                action(BOMSummary)
                {
                    Caption = 'BoM Summary report';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedIsBig = true;
                    // RunObject = Report 99909;

                    trigger OnAction()
                    var
                        ProductionBatches: Record "Meal-Proc. Batches";
                    begin
                    end;
                }
                action(DailyProdSummary)
                {
                    Caption = 'Daily prod. Summary';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedIsBig = true;
                    // RunObject = Report "Daily Meal-Proc. Summary";

                    trigger OnAction()
                    var
                        ProductionBatches: Record "Meal-Proc. Batches";
                    begin
                    end;
                }
                action(MonthlyProdSummary)
                {
                    Caption = 'Monthly Pro. Summary';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedIsBig = true;
                    //    RunObject = Report 99907;

                    trigger OnAction()
                    var
                        ProductionBatches: Record "Meal-Proc. Batches";
                    begin
                    end;
                }
                action(MonthlyProdAnalysis)
                {
                    Caption = 'Monthly Pro. Analysis';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedIsBig = true;
                    //  RunObject = Report 99908;

                    trigger OnAction()
                    var
                        ProductionBatches: Record "Meal-Proc. Batches";
                    begin
                    end;
                }
                action(RMSumm)
                {
                    Caption = 'Material Requisition Summ.';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedIsBig = true;
                    //   RunObject = Report 99910;

                    trigger OnAction()
                    var
                        ProductionBatches: Record "Meal-Proc. Batches";
                    begin
                    end;
                }
                action(RmMontTo)
                {
                    Caption = 'Monthly Raw Material Summary';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedIsBig = true;
                    //   RunObject = Report 99911;

                    trigger OnAction()
                    var
                        ProductionBatches: Record "Meal-Proc. Batches";
                    begin
                    end;
                }
                action(RMMontlySumm2)
                {
                    Caption = 'Monthly Consuption Sum';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedIsBig = true;
                    //   RunObject = Report 99912;

                    trigger OnAction()
                    var
                        ProductionBatches: Record "Meal-Proc. Batches";
                    begin
                    end;
                }
                action(ProcBatched)
                {
                    Caption = 'Proccessing Batches';
                    Image = Description;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Meal Process Batches";
                    RunPageLink = "Batch Date" = FIELD("Batch Date");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("Batch Date", '=%1', DateFilter);
    end;

    trigger OnOpenPage()
    begin
        //Rec.SETFILTER("Batch Date",'=%1',DateFilter);
        DateFilter := TODAY;
    end;

    var
        NextLineNo: Integer;
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        OrderLineNo: Integer;
        ItemJnlLine: Record "Item Journal Line";
        ProductionBatchLines: Record "Meal-Proc. Batch Lines";
        ProductionBOMProdSource: Record "Meal-Proc. BOM Prod. Source";
        ProductionPermissions: Record "Meal-Proc. Permissions";
        ProductionCentralSetup: Record "Meal-Proc. Central Setup";
        ToTemplateName: Code[20];
        ToBatchName: Code[20];
        DateFilter: Date;
        lineNo: Integer;
        ProductionBatches: Record "Meal-Proc. Batches";
        NextOderNo: Code[20];
        SalesSetup: Record "Sales & Receivables Setup";
        PostCode: Record "Post Code";
        BankAcc: Record "Bank Account";
        RespCenter: Record "Responsibility Center";
        InvtSetup: Record "Inventory Setup";
        Location: Record "Location";
        WhseRequest: Record "Warehouse Request";
        ReservEntry: Record "Reservation Entry";
        TempReservEntry: Record "Reservation Entry" temporary;
        CompanyInfo: Record "Company Information";
        UserSetupMgt: Codeunit "User Setup Management";
        //  NoSeriesMgt: Codeunit NoSeriesManagement;
        // CustCheckCreditLimit: Codeunit "312";
        // DimMgt: Codeunit "408";
        // ApprovalsMgmt: Codeunit "1535";
        // WhseSourceHeader: Codeunit "5781";
        // ArchiveManagement: Codeunit "5063";
        // SalesLineReserve: Codeunit "99000832";
        CurrencyDate: Date;
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        SkipSellToContact: Boolean;
        SkipBillToContact: Boolean;
        InsertMode: Boolean;
        HideCreditCheckDialogue: Boolean;
        UpdateDocumentDate: Boolean;
        BilltoCustomerNoChanged: Boolean;
        FINCashOfficeUserTemplate: Record "FIN-Cash Office User Template";
        Customer: Record "Customer";
        ProductionCustProdSource: Record "Meal-Proc. BOM Prod. Source";
        Item: Record "Item";
        DocPrint: Codeunit "Document-Print";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
        //  NoSeriesManagement: Codeunit NoSeriesManagement;
        UserMgt: Codeunit "User Management";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        ItmJnl: Record "Meal-Proc. Batch Lines";
        ItemRec: Record "Item";
        TransferNo: Code[20];

    local procedure Post(PostingCodeunitID: Integer; DocNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        //OfficeMgt: Codeunit "Office Management";
        // InstructionMgt: Codeunit "Instruction Mgt.";
        PreAssignedNo: Code[20];
    begin
        // Post Meal-Proc. to Update Items Accordingly
    end;

    procedure CreateTransferOrder()
    var
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        LineNo: Integer;
        ItmJnl: Record "Meal-Proc. Batch Lines";
        ItemRec: Record "Item";
        TransferNo: Code[20];
    begin
        //IF "Transfer Order Created" THEN
        //ERROR('Transfer order has been created for this document');
        TransferHeader.INIT;
        ItmJnl.RESET;
        ItmJnl.SETRANGE(ItmJnl."Batch Date", Rec."Batch Date");
        IF ItmJnl.FINDFIRST THEN
            //  TransferNo:=NoSeriesManagement.GetNextNo('TRANSFER',"Posting Date",TRUE);
            //TransferNo:=
            TransferHeader."No." := TransferNo;
        TransferHeader."Transfer-from Code" := 'Packaging'; //ItmJnl.Processing';
        TransferHeader.VALIDATE("Transfer-from Code");
        TransferHeader."Transfer-to Code" := 'main';
        TransferHeader.VALIDATE("Transfer-to Code");
        TransferHeader."In-Transit Code" := 'TRANSIT';
        TransferHeader."Posting Date" := ItmJnl."Batch Date";
        TransferHeader."Shipment Date" := ItmJnl."Batch Date";
        TransferHeader."Receipt Date" := ItmJnl."Batch Date";
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
        TransferHeader.SETRANGE(TransferHeader."No.", Rec."Batch Serial");
        TransferHeader.SETRANGE("Posting Date", Rec."Batch Date");
        //TransferHeader.SETRANGE(TransferHeader."External Document No.","Order No.");
        IF TransferHeader.FINDFIRST THEN BEGIN
            ItmJnl.RESET;
            ItmJnl.SETRANGE(ItmJnl."Batch Serial", Rec."Batch Serial");
            ItmJnl.SETFILTER(ItmJnl."Required QTY", '>%1', 0);
            IF ItmJnl.FINDSET THEN BEGIN
                REPEAT
                    LineNo += 10000;
                    TransferLine.INIT;
                    TransferLine."Line No." := LineNo;
                    TransferLine."Document No." := TransferHeader."No.";
                    IF ItemRec.GET(ItmJnl."Item Code") THEN BEGIN
                        TransferLine."Item Category Code" := ItemRec."Item Category Code";
                        //   TransferLine."Product Group Code":=ItemRec."Product Group Code";
                    END;
                    TransferLine."Item No." := ItmJnl."Item Code";
                    TransferLine.VALIDATE("Item No.");
                    TransferLine.Quantity := ItmJnl."Required QTY";
                    TransferLine."Transfer-from Code" := TransferHeader."Transfer-from Code";
                    TransferLine."Transfer-to Code" := TransferHeader."Transfer-to Code";
                    TransferLine."Shortcut Dimension 1 Code" := 'A07';//ItmJnl."Shortcut Dimension 1 Code";
                    TransferLine."Shipment Date" := TransferHeader."Posting Date";
                    TransferLine."Receipt Date" := TransferHeader."Posting Date";
                    TransferLine.VALIDATE("Shortcut Dimension 1 Code");
                    TransferLine."Shortcut Dimension 2 Code" := 'Processing';//ItmJnl."Shortcut Dimension 2 Code";
                    TransferLine.VALIDATE("Shortcut Dimension 2 Code");
                    //TransferLine."Gen. Prod. Posting Group":=ItmJnl."Gen. Prod. Posting Group";
                    TransferLine.VALIDATE(Quantity);
                    TransferLine.VALIDATE("Transfer-from Code");
                    TransferLine.VALIDATE("Transfer-to Code");
                    TransferLine."Unit of Measure Code" := ItmJnl."Requirered Unit of Measure";
                    TransferLine."Document No." := TransferHeader."No.";
                    TransferLine."Unit of Measure" := ItmJnl."Requirered Unit of Measure";
                    TransferLine.VALIDATE("Unit of Measure Code");
                    TransferLine.INSERT(TRUE);
                UNTIL ItmJnl.NEXT = 0;
            END;
            //"Transfer Order No.":=TransferHeader."No.";
            //"Transfer Order Created":=TRUE;
            Rec.MODIFY;

        END;
        //"Transfer Order No.":=TransferHeader."No.";
        //"Transfer Order Created":=TRUE;

        PAGE.RUN(PAGE::"Transfer Order", TransferHeader);

    end;

}

