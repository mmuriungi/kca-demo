page 53136 "Meal-Proc. Posted Plans"
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
                action(BOMSummary)
                {
                    Caption = 'BoM Summary report';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedIsBig = true;
                    // RunObject = Report "BOM Summary Report - Meal";

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
                    //   RunObject = Report Daily Meal-Proc. Summary;

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
                    //   RunObject = Report 99907;

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
                    //    RunObject = Report 99910;

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
                    // RunObject = Report 99911;

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
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("Batch Date", '=%1', DateFilter);
    end;

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Batch Date", '=%1', DateFilter);
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
        CompanyInfo: Record "company Information";
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
        // DocPrint: Codeunit "Document-Print";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
    //  NoSeriesManagement: Codeunit "396";
    //  UserMgt: Codeunit "5700";

    local procedure Post(PostingCodeunitID: Integer; DocNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        OfficeMgt: Codeunit "Office Management";
        InstructionMgt: Codeunit "Instruction Mgt.";
        PreAssignedNo: Code[20];
    begin
        // Post Meal-Proc. to Update Items Accordingly
    end;
}

