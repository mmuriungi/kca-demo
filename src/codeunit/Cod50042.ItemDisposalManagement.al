codeunit 50042 "Item Disposal Management"
{
    VAR
        NoItemsErr: Label 'There are no items to dispose on this document.';
        NegQtyErr: Label 'The quantity must be greater than 0.';
        PostingConfirmQst: Label 'Do you want to post this disposal document?';
        PostingCompletedMsg: Label 'The disposal has been posted successfully.';

    PROCEDURE RequestApproval(VAR DisposalHeader: Record "Item Disposal Header")
    VAR
        DisposalLine: Record "Item Disposal Line";
        ApprovMgmt: Codeunit "Approval Workflows V1";
        variant: Variant;
    BEGIN
        // Check if there are lines
        DisposalLine.SETRANGE("Document No.", DisposalHeader."No.");
        IF NOT DisposalLine.FINDFIRST THEN
            ERROR(NoItemsErr);

        // Validate all lines have quantities
        REPEAT
            IF DisposalLine.Quantity <= 0 THEN
                ERROR(NegQtyErr);
        UNTIL DisposalLine.NEXT = 0;

        variant := DisposalHeader;
        if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
            ApprovMgmt.OnSendDocForApproval(variant);

    END;

    procedure CancelRequest(VAR DisposalHeader: Record "Item Disposal Header")
    VAR
        ApprovMgmt: Codeunit "Approval Workflows V1";
        variant: Variant;
    BEGIN
        variant := DisposalHeader;
        if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
            ApprovMgmt.OnCancelDocApprovalRequest(variant);
    END;

    PROCEDURE PostDisposal(VAR DisposalHeader: Record "Item Disposal Header")
    VAR
        DisposalLine: Record "Item Disposal Line";
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        Window: Dialog;
        LineCount: Integer;
        LineNo: Integer;
        Item: Record Item;
    BEGIN
        IF NOT CONFIRM(PostingConfirmQst) THEN
            EXIT;
        DisposalLine.SETRANGE("Document No.", DisposalHeader."No.");
        IF NOT DisposalLine.FindSet() THEN
            ERROR(NoItemsErr);
        LineCount := DisposalLine.COUNT;
        Window.OPEN('#1###### @2@@@@@@@', DisposalHeader."No.", LineCount);
        LineNo := 0;
        REPEAT
            item.get(disposalline."item no.");
            LineNo += 1;
            Window.UPDATE(2, LineNo);
            ItemJnlLine.INIT;
            ItemJnlLine."Journal Template Name" := 'ITEM';
            ItemJnlLine."Journal Batch Name" := 'DEFAULT';
            ItemJnlLine."Line No." := LineNo * 10000;
            ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
            ItemJnlLine."Document No." := DisposalHeader."No.";
            ItemJnlLine."Posting Date" := DisposalHeader."Disposal Date";
            ItemJnlLine."Document Date" := DisposalHeader."Document Date";
            ItemJnlLine."Item No." := DisposalLine."Item No.";
            ItemJnlLine.Validate("Item No.");
            ItemJnlLine."Gen. Prod. Posting Group" := item."Gen. Prod. Posting Group";
            ItemJnlLine.Description := DisposalLine.Description;
            ItemJnlLine.Quantity := DisposalLine.Quantity;
            ItemJnlLine.validate(Quantity);
            ItemJnlLine."Unit of Measure Code" := DisposalLine."Unit of Measure Code";
            ItemJnlLine.Validate("Unit of Measure Code");
            ItemJnlLine."Unit Cost" := DisposalLine."Unit Cost";
            ItemJnlLine.validate("Unit Cost");
            ItemJnlLine."Location Code" := DisposalLine."Location Code";
            ItemJnlLine.validate("Location Code");
            ItemJnlLine."Bin Code" := DisposalLine."Bin Code";
            ItemJnlLine."Variant Code" := DisposalLine."Variant Code";
            ItemJnlLine."Serial No." := DisposalLine."Serial No.";
            ItemJnlLine."Lot No." := DisposalLine."Lot No.";
            ItemJnlLine."Reason Code" := DisposalHeader."Disposal Reason Code";
            ItemJnlPostLine.RunWithCheck(ItemJnlLine);
        UNTIL DisposalLine.NEXT = 0;
        DisposalHeader.Status := DisposalHeader.Status::Posted;
        DisposalHeader.MODIFY;
        Window.CLOSE;
        MESSAGE(PostingCompletedMsg);
    END;

    PROCEDURE FindItemEntries(VAR DisposalLine: Record "Item Disposal Line")
    VAR
        Item: Record Item;
        ItemLedgEntry: Record "Item Ledger Entry";
        AvailableInventory: Page "Item Ledger Entries";
    BEGIN
        ItemLedgEntry.SETCURRENTKEY("Item No.", Open);
        ItemLedgEntry.SETRANGE("Item No.", DisposalLine."Item No.");
        ItemLedgEntry.SETRANGE(Open, TRUE);
        IF DisposalLine."Location Code" <> '' THEN
            ItemLedgEntry.SETRANGE("Location Code", DisposalLine."Location Code");
        AvailableInventory.SETTABLEVIEW(ItemLedgEntry);
        AvailableInventory.RUNMODAL;
    END;
    /// <summary>
    /// Creates a new disposal header.
    /// </summary>
    /// <param name="LocationCode">Location code for the disposal</param>
    /// <param name="DisposalMethod">Method of disposal</param>
    /// <param name="ReasonCode">Reason code for the disposal</param>
    /// <param name="DisposalAccount">G/L account for the disposal</param>
    /// <returns>The created disposal header record</returns>
    PROCEDURE CreateDisposalHeader(LocationCode: Code[10]; DisposalMethod: Enum "Disposal Method"; ReasonCode: Code[10]; DisposalAccount: Code[20]): Record "Item Disposal Header"
    VAR
        DisposalHeader: Record "Item Disposal Header";
    BEGIN
        DisposalHeader.INIT();
        DisposalHeader."No." := '';  // Will be assigned by number series
        DisposalHeader."Document Date" := WORKDATE();
        DisposalHeader."Disposal Date" := WORKDATE();
        DisposalHeader."Disposal Method" := DisposalMethod;
        DisposalHeader."Disposal Reason Code" := ReasonCode;
        DisposalHeader."Location Code" := LocationCode;
        DisposalHeader."Disposal Account" := DisposalAccount;
        DisposalHeader.INSERT(TRUE);

        EXIT(DisposalHeader);
    END;

    /// <summary>
    /// Creates a new disposal line.
    /// </summary>
    /// <param name="DisposalHeader">Disposal header record</param>
    /// <param name="ItemNo">Item number</param>
    /// <param name="Quantity">Quantity to dispose</param>
    /// <param name="UnitOfMeasure">Unit of measure code</param>
    /// <param name="LocationCode">Location code</param>
    /// <param name="ReasonDescription">Description of the disposal reason</param>
    /// <returns>The created disposal line record</returns>
    PROCEDURE CreateDisposalLine(VAR DisposalHeader: Record "Item Disposal Header"; ItemNo: Code[20]; Quantity: Decimal; UnitOfMeasure: Code[10]; LocationCode: Code[10]; ReasonDescription: Text[100]): Record "Item Disposal Line"
    VAR
        DisposalLine: Record "Item Disposal Line";
        Item: Record Item;
        NextLineNo: Integer;
    BEGIN
        // Find the next line number
        DisposalLine.RESET();
        DisposalLine.SETRANGE("Document No.", DisposalHeader."No.");
        IF DisposalLine.FINDLAST() THEN
            NextLineNo := DisposalLine."Line No." + 10000
        ELSE
            NextLineNo := 10000;

        // Get item details
        Item.GET(ItemNo);

        // Create the new line
        DisposalLine.INIT();
        DisposalLine."Document No." := DisposalHeader."No.";
        DisposalLine."Line No." := NextLineNo;
        DisposalLine."Item No." := ItemNo;
        DisposalLine.VALIDATE("Item No.");  // This will set the description and UoM

        // Override UoM if specified
        IF UnitOfMeasure <> '' THEN
            DisposalLine."Unit of Measure Code" := UnitOfMeasure;

        DisposalLine.Quantity := Quantity;
        DisposalLine.VALIDATE(Quantity);
        DisposalLine."Unit Cost" := Item."Unit Cost";
        DisposalLine.VALIDATE("Unit Cost");

        // Set location if specified, otherwise use the header location
        IF LocationCode <> '' THEN
            DisposalLine."Location Code" := LocationCode
        ELSE
            DisposalLine."Location Code" := DisposalHeader."Location Code";

        DisposalLine."Reason Description" := ReasonDescription;
        DisposalLine.INSERT(TRUE);

        EXIT(DisposalLine);
    END;

    /// <summary>
    /// Creates a disposal document from lab visit items.
    /// </summary>
    /// <param name="TreatmentNo">Treatment number</param>
    /// <param name="LocationCode">Location code</param>
    /// <returns>The created disposal header record</returns>
    PROCEDURE CreateDisposalFromLabVisit(TreatmentNo: Code[20]; LocationCode: Code[10]): Record "Item Disposal Header"
    VAR
        LabVisitItems: Record "Lab Visit Items";
        DisposalHeader: Record "Item Disposal Header";
        DisposalLine: Record "Item Disposal Line";
        GLSetup: Record "General Ledger Setup";
        ItemCount: Integer;
    BEGIN
        // Check if there are items to dispose
        LabVisitItems.RESET();
        LabVisitItems.SETRANGE("Lab Visit No.", TreatmentNo);
        IF NOT LabVisitItems.FINDFIRST() THEN
            ERROR(NoItemsErr);

        // Get G/L Setup for disposal account
        GLSetup.GET();

        // Create disposal header
        DisposalHeader := CreateDisposalHeader(
            LocationCode,
            "Disposal Method"::Internal,
            'LABUSE',
           '');

        // Create disposal lines for each lab visit item
        ItemCount := 0;
        LabVisitItems.RESET();
        LabVisitItems.SETRANGE("Lab Visit No.", TreatmentNo);
        IF LabVisitItems.FINDSET() THEN BEGIN
            REPEAT
                IF (LabVisitItems."Item No." <> '') AND (LabVisitItems.Quantity > 0) THEN BEGIN
                    CreateDisposalLine(
                        DisposalHeader,
                        LabVisitItems."Item No.",
                        LabVisitItems.Quantity,
                        LabVisitItems."Unit of Measure",
                        LocationCode,
                        'Used for lab test: ' + LabVisitItems.Code);
                    ItemCount += 1;
                END;
            UNTIL LabVisitItems.NEXT() = 0;
        END;

        // If no valid items were found, delete the header and error
        IF ItemCount = 0 THEN BEGIN
            DisposalHeader.DELETE();
            ERROR(NoItemsErr);
        END;

        MESSAGE('Disposal created: ' + DisposalHeader."No.");
        EXIT(DisposalHeader);
    END;
}