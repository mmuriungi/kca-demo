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
}