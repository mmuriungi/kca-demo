codeunit 52178509 "Requisition Management"
{

    trigger OnRun()
    begin
    end;

    var
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        InvenSetup: Record "Inventory Setup";
        Err100: Label 'The Requisition Fulfilment Item Journal andTtemplate must be defined in Purchases & Payables Setup';
        Err200: Label 'The No. series for the Item Journal %1 and %2 must be defined!';
        Err300: Label 'The To & From locations must be defined';
        SNText01: Label 'There are no purchase review documents to process.  Please select the appropriate Decision and enter Target No. to process documents.';
        SNText02: Label 'No line were eligible for posting encumbrances - check line statuses.';
        SNText03: Label 'The Purchase Order %1 you are appending to does not exist.';
        SNText04: Label 'You cannot cancel a %1 purchase line.';
        SNText05: Label 'Advanced Budgeting is not licensed or activated in Source Codes.';
        SNText06: Label 'You cannot cancel a submitted for approval purchase line, Document %1 Line %2.';
        SNText07: Label 'Reversed Requisition Fulfillment & Canceled line, Document %1 Line %2.';
        SNText08: Label 'Use Delete instead of Cancel Line for purchase line, Document %1 Line %2.';
        SNText09: Label 'You cannot cancel a new purchase line, Document %1 Line %2 - Delete Line instead.';
        SNText10: Label 'Commitment Posting is not activated.';
        SNText11: Label 'Encumbrance Posting is not activated.';
        SNText12: Label 'There are no lines with status New and an Amount to check.';
        SNText13: Label 'Nothing to Submit.';
        SNText14: Label 'Requisition %1 has submitted lines - cannot be deleted.';
        SNText15: Label 'There is nothing to cancel for Line %1.  Delete line instead.';
        SNText16: Label 'You cannot cancel a Requisition %1 Line %2 that is %3.';
        SNText17: Label 'You cannot cancel a Deposit %1 Line %2 that is %3.';
        SNText18: Label 'There are no lines to check.';
        SNText19: Label 'There are no lines to cancel.';
        SNText20: Label 'There are outstanding Orders that must be fully Invoiced or Canceled first.';
        SNText21: Label 'Should Blanket Order %1, Line No. %2 be re-encumbered?';
        SNText22: Label 'Blanket Order Status %1 is not valid ';
        SNText23: Label 'The line has been submitted for approval.  Confirm cancellation?';
        SNText24: Label 'Cancel Line has been stopped.  Document %1 Line %2.';
        SNText25: Label 'Posting is not allowed for proposed Vendors.  Vendor No.=%1.';
        SNText26: Label 'Processing is not allowed for proposed Vendors.  Vendor No.=%1.';
        SNText27: Label 'No lines were eligible for posting commitments - check line statuses.';
        SNText28: Label 'Purchase tolerance check failed.  Document No.=%1, Line No.=%2.';
        SNText29: Label 'Reclassification not permitted for document %1, line %2.';
        SNText30: Label 'Status must be Approval Pending, Transfer Budget Pending or Disapproved.';
        SNText31: Label 'There are no lines to reset.';
        SNText32: Label 'You cannot cancel a new sales line, Document %1 Line %2 - Delete Line instead.';
        SNText33: Label 'You cannot cancel a %1 sales line.';
        SNText34: Label 'There are %1 failed validations.  Preview Distributions to resolve.';
        SNText36: Label 'The document has been submitted for approval.  Confirm cancellation?';
        SNText37: Label 'Cancel Document has been stopped.  %1 %2.';
        SNText38: Label 'You cannot reset document a %1 %2 that is %3 %4.';
        SNText39: Label 'You cannot cancel a %1 %2 that is %3 %4.';
        CommitmentDescription: Label 'Reserve for Commitments';
        EncumbranceDescription: Label 'Reserve for Encumbrances';
        ConversionDescription: Label 'Conversion of  %1 to %2.';
        Window: Dialog;
        LineNo: Integer;
        Options: Record "Purchases & Payables Setup";
        DimMgt: Codeunit DimensionManagement;
        PurchReleaseDocs: Codeunit "Release Purchase Document";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineNo2: Code[20];
        gCuNoSeriesMngmnt: Codeunit NoSeriesManagement;

    //[Scope('Internal')]
    procedure RequisitionReview(var TempRequisitionLine: Record "Purchase Line")
    var
        RequisitionLine: Record "Purchase Line";
        UserSetup: Record "User Setup";
        PurchaseHeader: Record "Purchase Header";
        LineNo: Integer;
        LastVendorProcessed: Code[20];
        DocNo: Code[20];
        LastReqDocNoProcessed: Code[20];
        DocumentType: enum "Purchase Document Type";
    begin
        PurchSetup.GET;
        UserSetup.GET(USERID);
        if UserSetup."Raise LPOs" = false then Error('%1 You are not allowed to create direct Lpos', userid);
        PurchSetup.GET;
        RequisitionLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        RequisitionLine.COPYFILTERS(TempRequisitionLine);
        RequisitionLine.SETRANGE(Select2, TRUE);
        RequisitionLine.SETFILTER(Decision, '<>%1', RequisitionLine.Decision::Order);
        RequisitionLine.SETFILTER(Quantity, '<>0');


        Window.OPEN('#1#################################\\' +
                    'Processing Purchase Doc #2######################\' +
                    'New Vendor No.          #3######################\' +
                    'Detail Line No.         #4######################');


        //Create New Purchase Quote
        LineNo := 0;
        LastVendorProcessed := '';
        LastReqDocNoProcessed := '';
        DocNo := '';
        RequisitionLine.SETRANGE(Decision, RequisitionLine.Decision::Order);
        IF RequisitionLine.FINDSET(TRUE, FALSE) THEN BEGIN
            Window.UPDATE(1, RequisitionLine.Decision);
            REPEAT
                CreateNewPurchaseDocument(RequisitionLine, 1, DocNo, LineNo, LastVendorProcessed, LastReqDocNoProcessed);
                RequisitionLine.Decision := RequisitionLine.Decision::Order;
                RequisitionLine."Buy-from Vendor No." := '';
                RequisitionLine.MODIFY;
            UNTIL RequisitionLine.NEXT = 0;
        END;

        Window.CLOSE;

    end;


    procedure CreateNewPurchaseDocument(var RequisitionLine: Record "Purchase Line"; DocumentType: Option Quote,"Order",,,"Blanket Order"; var DocumentNo: Code[20]; var LineNo: Integer; var LastVendorProcessed: Code[20]; var LastReqDocNoProcessed: Code[20])
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        RequisitionHeader: Record "Purchase Header";
        Vendor: Record Vendor;
    begin
        IF RequisitionLine."PO Type" = RequisitionLine."PO Type"::LPO THEN begin
            PurchSetup.TestField("Order Nos.");
            LineNo2 := NoSeriesMgt.GetNextNo(PurchSetup."Order Nos.", today, TRUE);
            PurchaseHeader."No. Series" := PurchSetup."Order Nos.";
            PurchaseHeader."Document type" := PurchaseHeader."Document type"::order;
        end else
            IF RequisitionLine."PO Type" = RequisitionLine."PO Type"::LSO THEN begin
                PurchSetup.TestField("LSO Nos");
                LineNo2 := NoSeriesMgt.GetNextNo(PurchSetup."LSO Nos", today, TRUE);
                PurchaseHeader."No. Series" := PurchSetup."LSO Nos";
                PurchaseHeader."Document type" := PurchaseHeader."Document type"::order;
            end;


        IF LastVendorProcessed = RequisitionLine."Buy-from Vendor No." THEN BEGIN
            LineNo := LineNo + 10000;
            PurchaseHeader.GET(DocumentType, DocumentNo);
        END ELSE BEGIN
            IF Vendor.GET(RequisitionLine."Buy-from Vendor No.") THEN
                PurchSetup.GET;
            PurchaseHeader.INIT;
            PurchaseHeader."No." := LineNo2;
            PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
            PurchaseHeader."PO Type" := RequisitionLine."PO Type";
            PurchaseHeader."Vendor Order No." := RequisitionLine."Document No.";
            PurchaseHeader."Quote No." := RequisitionLine."Document No.";
            PurchaseHeader."Assigned User ID 2" := RequisitionLine."Selected By";
            PurchaseHeader.INSERT(TRUE);
            //PurchaseHeader.VALIDATE("No.");
            PurchaseHeader.VALIDATE("Buy-from Vendor No.", RequisitionLine."Buy-from Vendor No.");
            PurchaseHeader.VALIDATE(PurchaseHeader."Posting Date", TODAY);
            PurchaseHeader.VALIDATE(PurchaseHeader."Document Date", TODAY);
            PurchaseHeader.VALIDATE("Shortcut Dimension 1 Code", RequisitionLine."Shortcut Dimension 1 Code");
            PurchaseHeader.VALIDATE("Shortcut Dimension 2 Code", RequisitionLine."Shortcut Dimension 2 Code");

            //Do the Other Dimensions
            //Other Dimensions
            PurchaseHeader.VALIDATE(PurchaseHeader."Dimension Set ID", RequisitionLine."Dimension Set ID");
            IF RequisitionHeader."Sell-to Customer No." <> '' THEN BEGIN
                PurchaseHeader.VALIDATE("Sell-to Customer No.", RequisitionHeader."Sell-to Customer No.");
                PurchaseHeader.VALIDATE("Ship-to Code", RequisitionHeader."Ship-to Code");
            END;
            IF RequisitionLine."Location Code" <> '' THEN
                PurchaseHeader.VALIDATE("Location Code", RequisitionLine."Location Code");
            PurchaseHeader."Prices Including VAT" := RequisitionHeader."Prices Including VAT";
            PurchaseHeader.VALIDATE(PurchaseHeader."Currency Code", RequisitionLine."Currency Code");
            PurchaseHeader."Assigned User ID 2" := RequisitionLine."Selected By";
            PurchaseHeader.MODIFY;
            Window.UPDATE(2, STRSUBSTNO('%1 %2', PurchaseHeader."Document Type", PurchaseHeader."No."));
            Window.UPDATE(3, FORMAT(RequisitionLine."Buy-from Vendor No."));
            LastVendorProcessed := RequisitionLine."Buy-from Vendor No.";
            LineNo := 10000;
        END;
        PurchaseLine.INIT;
        PurchaseLine.VALIDATE(PurchaseLine."Document Type", PurchaseHeader."Document Type");
        PurchaseLine.VALIDATE(PurchaseLine."Document No.", PurchaseHeader."No.");
        PurchaseLine.VALIDATE(PurchaseLine.Type, RequisitionLine.Type);
        DocumentNo := PurchaseHeader."No.";
        RequisitionLineTOPurchaseLine(PurchaseLine, RequisitionLine, LineNo, FALSE);
        PurchaseLine.VALIDATE("Direct Unit Cost", RequisitionLine."Direct Unit Cost");
        IF LastReqDocNoProcessed <> RequisitionLine."Document No." THEN BEGIN
            LastReqDocNoProcessed := RequisitionLine."Document No.";
        END;
        Window.UPDATE(4, PurchaseLine."Line No.");
        PurchaseLine.INSERT(TRUE);
        page.Run(page::"Purchase Order", PurchaseHeader, PurchaseHeader."No.");
    end;

    procedure RequisitionLineTOPurchaseLine(var PurchaseLine: Record "Purchase Line"; RequisitionLine: Record "Purchase Line"; LineNo: Integer; AppendToOrder: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        PurchaseHeader.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
        PurchaseLine.INIT;
        PurchaseLine."Document Type" := PurchaseHeader."Document Type";
        PurchaseLine."Document No." := PurchaseHeader."No.";
        PurchaseLine."Line No." := LineNo;
        IF NOT AppendToOrder THEN
            PurchaseLine.VALIDATE("Buy-from Vendor No.", RequisitionLine."Buy-from Vendor No.");
        //**
        PurchaseLine.VALIDATE(Type, RequisitionLine.Type);
        PurchaseLine.VALIDATE("No.", RequisitionLine."No.");
        IF PurchaseLine.Type = PurchaseLine.Type::Item THEN
            PurchaseLine.VALIDATE("Location Code", RequisitionLine."Location Code");
        PurchaseLine."Expected Receipt Date" := RequisitionLine."Expected Receipt Date";
        PurchaseLine.Description := RequisitionLine.Description;
        PurchaseLine."Description 2" := RequisitionLine."Description 2";
        PurchaseLine.VALIDATE("Unit of Measure Code", RequisitionLine."Unit of Measure Code");
        PurchaseLine.VALIDATE("Direct Unit Cost", RequisitionLine."Direct Unit Cost");
        PurchaseLine.VALIDATE(Quantity, RequisitionLine.Quantity);
        BEGIN
            PurchaseLine.VALIDATE("Direct Unit Cost", RequisitionLine."Direct Unit Cost");
            PurchaseLine.VALIDATE("Line Discount %", RequisitionLine."Line Discount %");
            PurchaseLine.VALIDATE("Currency Code", RequisitionLine."Currency Code");
        END;
        PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", RequisitionLine."Shortcut Dimension 2 Code");
        PurchaseLine.VALIDATE("Transaction Type", RequisitionLine."Transaction Type");
        PurchaseLine.VALIDATE("Tax Group Code", RequisitionLine."Tax Group Code");
        IF PurchaseLine.Type = PurchaseLine.Type::Item THEN PurchaseLine.VALIDATE("Variant Code", RequisitionLine."Variant Code");
        PurchaseLine."Unit of Measure" := RequisitionLine."Unit of Measure Code";
        PurchaseLine."Gen. Bus. Posting Group" := RequisitionLine."Gen. Bus. Posting Group";
        PurchaseLine."Gen. Prod. Posting Group" := RequisitionLine."Gen. Prod. Posting Group";
    end;

    procedure ChangeDocHeaderStatus(DocHeaderNo: Code[20])
    var
        DocHeader: Record "Purchase Header";
        DocLines: Record "Purchase Line";
        DocFullyProcessed: Boolean;
    begin
        //DocFullyProcessed := TRUE;
        DocLines.RESET;
        DocLines.SETRANGE(DocLines.Select2, TRUE);
        DocLines.SETRANGE(DocLines."Document No.", DocHeaderNo);
        IF DocLines.FIND('-') THEN BEGIN
            REPEAT
                MESSAGE('%1', DocHeaderNo);
                DocLines."Ordered by" := USERID;
                DocLines."Order Creation date" := TODAY;
                DocLines."Order Creation Time" := TIME;
                DocLines.Ordered := TRUE;
                DocLines.Select2 := FALSE;
            UNTIL DocLines.NEXT = 0;
        END;
    end;
}

