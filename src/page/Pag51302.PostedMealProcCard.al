page 51302 "Posted Meal-Proc. Card"
{
    DataCaptionFields = "Batch Date", Status, "Created By";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                Editable = false;
                Enabled = false;
                SubPageLink = "Batch Date" = FIELD("Batch Date"),
                              "Batch ID" = FIELD("Batch ID");
                SubPageView = WHERE("BOM Count" = FILTER(> 0),
                                    Approve = FILTER(true));
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
                //   RunObject = Report 99909;

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
                //  RunObject = Report "Daily Meal-Proc. Summary";

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
                //  RunObject = Report "Monthly Meal-Proc. Summary";

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
                //  RunObject = Report "Monthly Meal-Proc. Analysis";

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
                // RunObject = Report "Meal Cons. Material Req. Sum.";

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
                //       RunObject = Report 99912;

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
            action("Create Transfer Order")
            {
                Image = TransferOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Status, Rec.Status::Posted);
                    //"Transfer Order Created":="Transfer Order Created"::"1";
                    //CreateTransferOrder;
                end;
            }
        }
    }

    var
        ProductionBatches1: Record "Meal-Proc. Batches";
        lineNo: Integer;
        DateFilter: Date;
        ProductionBatches: Record "Meal-Proc. Batches";
        NextOderNo: Code[20];
        SalesSetup: Record "Sales & Receivables Setup";
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
        Cust: Record "Customer";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        CurrExchRate: Record "Currency Exchange Rate";
        SalesCommentLine: Record "Sales Comment Line";
        PostCode: Record "Post Code";
        BankAcc: Record "Bank Account";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ReturnRcptHeader: Record "Return Receipt Header";
        SalesInvHeaderPrepmt: Record "Sales Invoice Header";
        SalesCrMemoHeaderPrepmt: Record "Sales Cr.Memo Header";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        RespCenter: Record "Responsibility Center";
        InvtSetup: Record "Inventory Setup";
        Location: Record "location";
        WhseRequest: Record "Warehouse Request";
        ReservEntry: Record "Reservation Entry";
        TempReservEntry: Record "Reservation Entry" temporary;
        CompanyInfo: Record "Company Information";
        UserSetupMgt: Codeunit "User Setup Management";
        // NoSeriesMgt: Codeunit "NoSeriesManagement";
        // CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        // DimMgt: Codeunit "DimensionManagement";
        // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        // WhseSourceHeader: Codeunit "Whse. Validate Source Header";
        // ArchiveManagement: Codeunit "ArchiveManagement";
        // SalesLineReserve: Codeunit "Sales Line-Reserve";
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
        Item: Record "item";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        //   DocPrint: Codeunit "Document-Print";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
}

