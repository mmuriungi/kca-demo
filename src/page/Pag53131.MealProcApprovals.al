page 53131 "Meal-Proc. Approvals"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Meal-Proc. Batch Lines";
    SourceTableView = WHERE("BOM Count" = FILTER(> 0),
                            Approve = FILTER(false));

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

                    trigger OnValidate()
                    begin
                        //Rec.SETFILTER("Batch Date",'=%1',DateFilter);
                        //CurrPage.UPDATE;
                    end;
                }
            }
            repeater(Group)
            {
                field("Item Code"; Rec."Item Code")
                {
                    Editable = false;
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
                    Editable = false;
                }
                field("Requirered Unit of Measure"; Rec."Requirered Unit of Measure")
                {
                    Editable = false;
                }
                field("QTY in KGs"; Rec."QTY in KGs")
                {
                    Editable = false;
                }
                field("QTY in Tones"; Rec."QTY in Tones")
                {
                    Editable = false;
                }
                field("BOM Count"; Rec."BOM Count")
                {
                    Editable = false;
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
                field(Approve; Rec.Approve)
                {
                }
                field(Reject; Rec.Reject)
                {
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Created Time"; Rec."Created Time")
                {
                    Editable = false;
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Mark as Final")
            {
                Caption = 'Mark as Final';
                Image = AvailableToPromise;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    ProductionBatches.RESET;
                    ProductionBatches.SETRANGE(ProductionBatches."Batch Date", DateFilter);
                    ProductionBatches.SETRANGE(ProductionBatches."Batch ID", Rec."Batch ID");
                    IF ProductionBatches.FIND('-') THEN BEGIN
                        IF ProductionBatches.Status <> ProductionBatches.Status::Draft THEN ERROR('');
                    END;


                    IF CONFIRM('CONFIRM:\Mark as Final?', FALSE) = FALSE THEN EXIT;
                    ProductionBatches.RESET;
                    ProductionBatches.SETRANGE(ProductionBatches."Batch Date", DateFilter);
                    ProductionBatches.SETRANGE(ProductionBatches."Batch ID", Rec."Batch ID");
                    IF ProductionBatches.FIND('-') THEN BEGIN
                        ProductionBatches.Status := ProductionBatches.Status::Final;
                        ProductionBatches.MODIFY;
                    END;
                end;
            }
            action(Approves)
            {
                Caption = 'Approve';
                Image = EncryptionKeys;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // MealProcPermissions.RESET;
                    // MealProcPermissions.SETRANGE("User Id",USERID);
                    // IF MealProcPermissions.FIND('-') THEN BEGIN
                    //   MealProcPermissions.TESTFIELD("Approve Orders");
                    //   END ELSE ERROR('Access Denied!');
                    IF CONFIRM('Approve?', TRUE) = FALSE THEN ERROR('Cancelled!');
                    Rec.Approve := TRUE;
                    Rec."Approved by" := USERID;
                    Rec."Approved Time" := TIME;
                    IF Rec.MODIFY THEN;
                    MESSAGE('Approved!');
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
                //   RunObject = Report 99900;

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
                //  RunObject = Report 99907;

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
                //    RunObject = Report 99911;

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
                //    RunObject = Report 99912;

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
                //   RunObject = Page 99916;
                //   RunPageLink = "Batch Date"=FIELD("Batch Date");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("Batch Date", '=%1', DateFilter);
        //CLEAR(currPayments);
        /*
        DetailedCustLedgEntry.RESET;
        DetailedCustLedgEntry.SETRANGE(DetailedCustLedgEntry."Customer No.",Rec."Item Code");
        DetailedCustLedgEntry.SETFILTER(DetailedCustLedgEntry."Posting Date",'=%1',TODAY);
        //DetailedCustLedgEntry.SETFILTER(DetailedCustLedgEntry.Amount,'<%1',0);
        IF DetailedCustLedgEntry.FIND('-') THEN BEGIN
          REPEAT
            BEGIN
            IF ((COPYSTR(DetailedCustLedgEntry."Document No.",1,2)='EQ')
              OR (COPYSTR(DetailedCustLedgEntry."Document No.",1,2)='RE')
              OR (COPYSTR(DetailedCustLedgEntry."Document No.",1,2)='KC')) THEN
            currPayments:=currPayments+DetailedCustLedgEntry.Amount;
            END;
            UNTIL DetailedCustLedgEntry.NEXT=0;
          END;
          */

    end;

    trigger OnOpenPage()
    begin
        DateFilter := TODAY;
        Rec.SETFILTER("Batch Date", '=%1', DateFilter);
    end;

    var
        // Customer1: Record "18";
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
        // Location: Record "Location";
        // WhseRequest: Record "5765";
        // ReservEntry: Record "337";
        // TempReservEntry: Record "337" temporary;
        CompanyInfo: Record "Company Information";
        // UserSetupMgt: Codeunit "5700";
        //NoSeriesMgt: Codeunit "396";
        // CustCheckCreditLimit: Codeunit "312";
        //  DimMgt: Codeunit "408";
        //  ApprovalsMgmt: Codeunit "1535";
        // WhseSourceHeader: Codeunit "5781";
        // ArchiveManagement: Codeunit "5063";
        //  SalesLineReserve: Codeunit "Sales Line-Reserve";
        CurrencyDate: Date;
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        SkipSellToContact: Boolean;
        SkipBillToContact: Boolean;
        InsertMode: Boolean;
        HideCreditCheckDialogue: Boolean;
        UpdateDocumentDate: Boolean;
        BilltoCustomerNoChanged: Boolean;
    //     FINCashOfficeUserTemplate: Record "61712";
    //     Customer: Record "18";
    //     ProductionCustProdSource: Record "99902";
    //     Item: Record "27";
    //     SalesInvoiceHeader: Record "112";
    //     SalesShipmentHeader: Record "110";
    //    // DocPrint: Codeunit "Document-Print";
    //     Usage: Option "Order Confirmation","Work Order","Pick Instruction";
    //     currPayments: Decimal;
    //     DetailedCustLedgEntry: Record "379";
    //     ProductionBatchLines: Record "99901";
    //     MealProcPermissions: Record "99905";
}

