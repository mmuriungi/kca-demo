page 53133 "Posted Meal-Proc. Batches"
{
    CardPageID = "Meal-Proc. Batch Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Meal-Proc. Batches";
    SourceTableView = SORTING("Batch Date", "Production  Area")
                      ORDER(Descending)
                      WHERE(Status = FILTER(Final | Posted));

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
            action(MarkAsFinal)
            {
                Caption = 'Mark as Final';
                Image = AvailableToPromise;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ProductionBatches.RESET;
                    ProductionBatches.SETRANGE(ProductionBatches."Batch Date", Rec."Batch Date");
                    IF ProductionBatches.FIND('-') THEN BEGIN
                        IF ProductionBatches.Status <> ProductionBatches.Status::Draft THEN ERROR('Already Closed!');
                    END;


                    IF CONFIRM('CONFIRM:\Mark as Final?', FALSE) = FALSE THEN EXIT;
                    ProductionBatches.RESET;
                    ProductionBatches.SETRANGE(ProductionBatches."Batch Date", Rec."Batch Date");
                    IF ProductionBatches.FIND('-') THEN BEGIN
                        ProductionBatches.Status := ProductionBatches.Status::Final;
                        ProductionBatches.MODIFY;
                    END;
                    MESSAGE('The batch has been closed!');
                end;
            }
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
                //    RunObject = Report "Daily Meal-Proc. Summary";

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
                //    RunObject = Report "Monthly Meal-Proc. Summary";

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
                // RunObject = Report "Monthly Meal-Proc. Analysis";

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
                //   RunObject = Report "Meal Cons. Material Req. Sum.";

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
                //   RunObject = Report "Monthly Comsumption Rm Sum.";

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
                //  RunObject = Report "Meal Proc. Monthly Consumption";

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
        Location: Record "Location";
        WhseRequest: Record "Warehouse Request";
        ReservEntry: Record "Reservation Entry";
        TempReservEntry: Record "Reservation Entry" temporary;
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
        Item: Record "item";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        // DocPrint: Codeunit "Document-Print";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";

    procedure CreateTransferOrder()
    var
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        LineNo: Integer;
        ItmJnl: Record "Meal-Proc. Batch Lines";
        ItemRec: Record "Item";
        TransferNo: Code[20];
    begin
        /*
        //IF "Transfer Order Created" THEN
         //ERROR('Transfer order has been created for this document');
        WITH TransferHeader DO BEGIN
         INIT;
         ItmJnl.RESET;
         ItmJnl.SETRANGE("Batch Date",Rec."Batch Serial);
         IF ItmJnl.FINDFIRST THEN
         TransferNo:=NoSeriesManagement.GetNextNo('MI-11',"Posting Date",TRUE);
         //TransferNo:=
         TransferHeader."No.":=TransferNo;
         "Transfer-from Code":= ItmJnl."Location Code";
         VALIDATE("Transfer-from Code");
         "Transfer-to Code":= 'COLD ROOM 2';
         VALIDATE("Transfer-to Code");
         "In-Transit Code":='IN-TRANS';
         "Posting Date":=ItmJnl."Posting Date";
        "Shipment Date":=ItmJnl."Posting Date";
        "Receipt Date":=ItmJnl."Posting Date";
        //"Output Voucher No.":="Document No.";
        //"Transfer Type":="Transfer Type"::"Output Transfer";
         TransferHeader."Assigned User ID":=USERID;
         //TransferHeader."External Document No.":=Rec."Order No.";
          VALIDATE("Transfer-from Code");
          VALIDATE("Transfer-to Code");
         IF INSERT THEN BEGIN
         //Rec."Transfer Order No.":=TransferHeader."No.";
         //Rec."Transfer Order Created":=TRUE;
         MODIFY;
        END;
         END;
         {"Transfer Order No.":=TransferHeader."No.";
         "Transfer Order Created":=TRUE;
         MODIFY;
        }
        TransferHeader.RESET;
        TransferHeader.SETRANGE(TransferHeader."No.","Batch Serial");
        TransferHeader.SETRANGE("Posting Date","Batch Date");
        //TransferHeader.SETRANGE(TransferHeader."External Document No.","Order No.");
        IF TransferHeader.FINDFIRST THEN BEGIN
        ItmJnl.RESET;
        ItmJnl.SETRANGE(ItmJnl."Document No.",Rec."Batch Serial");
        ItmJnl.SETFILTER(ItmJnl."Output Quantity",'>%1',0);
        IF ItmJnl.FINDSET THEN BEGIN
         REPEAT
         LineNo+=10000;
         WITH TransferLine DO BEGIN
          INIT;
           "Line No.":=LineNo;
           TransferLine."Document No.":=TransferHeader."No.";
            IF ItemRec.GET(ItmJnl."Item No.") THEN BEGIN
            TransferLine."Item Category Code":=ItemRec."Item Category Code";
            TransferLine."Product Group Code":=ItemRec."Product Group Code";
            END;
            TransferLine."Item No.":=ItmJnl."Item No.";
            TransferLine.VALIDATE("Item No.");
            TransferLine.Quantity:=ItmJnl."Output Quantity";
            TransferLine."Transfer-from Code":=TransferHeader."Transfer-from Code";
            TransferLine."Transfer-to Code":=TransferHeader."Transfer-to Code";
            TransferLine."Shortcut Dimension 1 Code":=ItmJnl."Shortcut Dimension 1 Code";
            TransferLine."Shipment Date":=TransferHeader."Posting Date";
            TransferLine."Receipt Date":=TransferHeader."Posting Date";
            TransferLine.VALIDATE("Shortcut Dimension 1 Code");
            TransferLine."Shortcut Dimension 2 Code":=ItmJnl."Shortcut Dimension 2 Code";
            TransferLine.VALIDATE("Shortcut Dimension 2 Code");
            TransferLine."Gen. Prod. Posting Group":=ItmJnl."Gen. Prod. Posting Group";
            TransferLine.VALIDATE(Quantity);
             TransferLine.VALIDATE("Transfer-from Code");
             TransferLine.VALIDATE("Transfer-to Code");
             TransferLine."Unit of Measure Code":=ItmJnl."Unit of Measure Code";
          TransferLine."Document No." :=TransferHeader."No.";
          TransferLine."Unit of Measure":=ItmJnl."Unit of Measure Code";
          TransferLine.VALIDATE("Unit of Measure Code");
           INSERT(TRUE);
          END;
          UNTIL ItmJnl.NEXT = 0;
         END;
         //"Transfer Order No.":=TransferHeader."No.";
         //"Transfer Order Created":=TRUE;
         MODIFY;
        
        END;
         //"Transfer Order No.":=TransferHeader."No.";
         //"Transfer Order Created":=TRUE;
        
          PAGE.RUN(PAGE::"Transfer Order",TransferHeader);
          */

    end;
}

