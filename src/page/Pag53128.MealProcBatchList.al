page 53128 "Meal-Proc. Batch List"
{
    CardPageID = "Meal-Proc. Batch Card";
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Meal-Proc. Batches";
    SourceTableView = SORTING("Batch Date", "Production  Area")
                      ORDER(Descending)
                      WHERE(Status = FILTER(Draft));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Batch Date"; Rec."Batch Date")
                {
                }
                field("Created Time"; Rec."Created Time")
                {
                }
                field("Batch Month"; Rec."Batch Month")
                {
                }
                field("Batch Month Name"; Rec."Batch Month Name")
                {
                }
                field("Batch Year"; Rec."Batch Year")
                {
                }
                field("No of Items"; Rec."No of Items")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Total Value"; Rec."Total Value")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Repopulate)
            {
                Caption = 'Re-Populate Items';
                Image = PostedMemo;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF CONFIRM('CONFIRM:\Re-populate Items?', FALSE) = FALSE THEN ERROR('Cancelled!');
                    Rec.VALIDATE("Batch Date");
                    MESSAGE('Items Populated Automatically!');
                end;
            }
            action(MarkasFin)
            {
                Caption = 'Mark as Final';
                Image = AvailableToPromise;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF Rec.Status <> Rec.Status::Draft THEN ERROR('Already Closed!');


                    IF CONFIRM('CONFIRM:\Mark as Final?', FALSE) = FALSE THEN EXIT;
                    IF CONFIRM('******WARNING!!!!!!!:\You will not post into an already posted Batch. \Continue?', FALSE) = FALSE THEN EXIT;
                    Rec.Status := Rec.Status::Final;
                    Rec.MODIFY;
                end;
            }
            action(BOMSummary)
            {
                Caption = 'BoM Summary report';
                Image = PrintForm;
                Promoted = true;
                PromotedIsBig = true;
                //  RunObject = Report 99909;

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
                //  RunObject = Report 99900;

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
                /// RunObject = Report 99907;

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
                //   RunObject = Report 99908;

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
                //  RunObject = Report 99910;

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
                //  RunObject = Report 99911;

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
                // RunObject = Report 99912;

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

    var
        lineNo: Integer;
        DateFilter: Date;
        ProductionBatches: Record "Meal-Proc. Batches";
        NextOderNo: Code[20];
        // SalesSetup: Record "311";
        // GLSetup: Record "98";
        // GLAcc: Record "15";
        // SalesHeader: Record "36";
        // SalesLine: Record "37";
        // CustLedgEntry: Record "21";
        // Cust: Record "18";
        // PaymentTerms: Record "3";
        // PaymentMethod: Record "289";
        // CurrExchRate: Record "330";
        // SalesCommentLine: Record "44";
        // PostCode: Record "225";
        // BankAcc: Record "270";
        // SalesShptHeader: Record "110";
        // SalesInvHeader: Record "112";
        // SalesCrMemoHeader: Record "114";
        // ReturnRcptHeader: Record "6660";
        // SalesInvHeaderPrepmt: Record "112";
        // SalesCrMemoHeaderPrepmt: Record "114";
        // GenBusPostingGrp: Record "250";
        // RespCenter: Record "5714";
        // InvtSetup: Record "313";
        // Location: Record "14";
        // WhseRequest: Record "5765";
        // ReservEntry: Record "337";
        // TempReservEntry: Record "337" temporary;
        CompanyInfo: Record "Company Information";
        // UserSetupMgt: Codeunit "5700";
        // NoSeriesMgt: Codeunit "396";
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
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        DocPrint: Codeunit "Document-Print";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
}

