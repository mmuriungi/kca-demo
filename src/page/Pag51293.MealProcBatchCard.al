page 51293 "Meal-Proc. Batch Card"
{
    DataCaptionFields = "Batch Date", Status, "Created By";
    DeleteAllowed = true;
    PageType = Card;
    SourceTable = "Meal-Proc. Batches";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Batch ID"; Rec."Batch ID")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Batch Date"; Rec."Batch Date")
                {
                    Editable = false;
                }
                field("Production  Area"; Rec."Production  Area")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Daily Total"; Rec."Daily Total")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part("Orders List"; "Meal-Proc. Batch Lines")
            {
                Caption = 'Orders List';
                SubPageLink = "Batch Date" = FIELD("Batch Date"),
                              "Batch ID" = FIELD("Batch ID");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(BOMSummary)
            {
                Caption = 'BoM Summary report';
                Image = PrintForm;
                Promoted = true;
                PromotedIsBig = true;
                //    RunObject = Report "BOM Summary Report - Meal";

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

                trigger OnAction()
                var
                    ProductionBatches: Record "Meal-Proc. Batches";
                begin
                    MealProcBatchesLines.RESET;
                    MealProcBatchesLines.SETRANGE("Batch Date", Rec."Batch Date");
                    IF MealProcBatchesLines.FIND('-') THEN BEGIN
                        REPORT.RUN(99900, TRUE, FALSE, MealProcBatchesLines);
                    END;
                end;
            }
            action(MonthlyProdSummary)
            {
                Caption = 'Monthly Pro. Summary';
                Image = PrintForm;
                Promoted = true;
                PromotedIsBig = true;
                // RunObject = Report 99907;

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
                //  RunObject = Report 99912;

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
        MealProcBatchesLines: Record "Meal-Proc. Batch Lines";
        ProductionBatches1: Record "Meal-Proc. Batches";
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
        // CompanyInfo: Record "79";
        // UserSetupMgt: Codeunit "5700";
        // NoSeriesMgt: Codeunit "396";
        // CustCheckCreditLimit: Codeunit "312";
        // DimMgt: Codeunit "408";
        // ApprovalsMgmt: Codeunit "1535";
        // WhseSourceHeader: Codeunit "5781";
        // ArchiveManagement: Codeunit "5063";
        // SalesLineReserve: Codeunit "99000832";
        // CurrencyDate: Date;
        // HideValidationDialog: Boolean;
        // Confirmed: Boolean;
        // SkipSellToContact: Boolean;
        // SkipBillToContact: Boolean;
        // InsertMode: Boolean;
        // HideCreditCheckDialogue: Boolean;
        // UpdateDocumentDate: Boolean;
        // BilltoCustomerNoChanged: Boolean;
        // FINCashOfficeUserTemplate: Record "61712";
        // Customer: Record "18";
        // ProductionCustProdSource: Record "99902";
        // Item: Record "27";
        // SalesInvoiceHeader: Record "112";
        // SalesShipmentHeader: Record "110";
        // DocPrint: Codeunit "229";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
}

