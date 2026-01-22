codeunit 50109 "Item Transfer Management"
{
    TableNo = "Item Transfer Header";

    procedure PostTransfer(var ItemTransferHeader: Record "Item Transfer Header")
    var
        ItemTransferLine: Record "Item Transfer Line";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalBatch: Record "Item Journal Batch";
        ItemJournalTemplate: Record "Item Journal Template";
        LineNo: Integer;
    begin
        // Validate transfer can be posted
        ValidateTransfer(ItemTransferHeader);

        // Get item journal template and batch
        GetItemJournalBatch(ItemJournalTemplate, ItemJournalBatch);

        // Clear existing lines in the batch
        ItemJournalLine.SetRange("Journal Template Name", ItemJournalTemplate.Name);
        ItemJournalLine.SetRange("Journal Batch Name", ItemJournalBatch.Name);
        ItemJournalLine.DeleteAll();

        LineNo := 10000;

        // Create negative adjustment for source location
        ItemTransferLine.SetRange("Transfer No.", ItemTransferHeader."No.");
        ItemTransferLine.SetFilter("Quantity to Transfer", '>0');
        if ItemTransferLine.FindSet() then
            repeat
                CreateItemJournalLine(ItemJournalLine, ItemJournalTemplate.Name, ItemJournalBatch.Name,
                    LineNo, ItemTransferHeader, ItemTransferLine, false);
                LineNo += 10000;
            until ItemTransferLine.Next() = 0;

        // Create positive adjustment for destination location
        ItemTransferLine.Reset();
        ItemTransferLine.SetRange("Transfer No.", ItemTransferHeader."No.");
        ItemTransferLine.SetFilter("Quantity to Transfer", '>0');
        if ItemTransferLine.FindSet() then
            repeat
                CreateItemJournalLine(ItemJournalLine, ItemJournalTemplate.Name, ItemJournalBatch.Name,
                    LineNo, ItemTransferHeader, ItemTransferLine, true);
                LineNo += 10000;
            until ItemTransferLine.Next() = 0;

        // Post the journal
        PostItemJournal(ItemJournalTemplate.Name, ItemJournalBatch.Name);

        // Update transfer header
        ItemTransferHeader.Posted := true;
        ItemTransferHeader."Posted By" := UserId;
        ItemTransferHeader."Posted Date" := CurrentDateTime;
        ItemTransferHeader.Status := ItemTransferHeader.Status::Posted;
        ItemTransferHeader.Modify();

        Message('Transfer %1 has been posted successfully.', ItemTransferHeader."No.");
    end;

    local procedure ValidateTransfer(var ItemTransferHeader: Record "Item Transfer Header")
    var
        ItemTransferLine: Record "Item Transfer Line";
    begin
        if ItemTransferHeader.Posted then
            Error('Transfer %1 has already been posted.', ItemTransferHeader."No.");

        if ItemTransferHeader.Status <> ItemTransferHeader.Status::Released then
            Error('Transfer %1 must be released before posting.', ItemTransferHeader."No.");

        if ItemTransferHeader."Location From Code" = '' then
            Error('Location From Code must be specified.');

        if ItemTransferHeader."Location To Code" = '' then
            Error('Location To Code must be specified.');

        if ItemTransferHeader."Location From Code" = ItemTransferHeader."Location To Code" then
            Error('Location From and Location To cannot be the same.');

        ItemTransferLine.SetRange("Transfer No.", ItemTransferHeader."No.");
        ItemTransferLine.SetFilter("Quantity to Transfer", '>0');
        if ItemTransferLine.IsEmpty then
            Error('At least one line with quantity to transfer must exist.');
    end;

    local procedure GetItemJournalBatch(var ItemJournalTemplate: Record "Item Journal Template"; var ItemJournalBatch: Record "Item Journal Batch")
    begin
        ItemJournalTemplate.SetRange(Type, ItemJournalTemplate.Type::Item);
        ItemJournalTemplate.SetRange(Recurring, false);
        if not ItemJournalTemplate.FindFirst() then
            Error('No suitable item journal template found.');

        ItemJournalBatch.SetRange("Journal Template Name", ItemJournalTemplate.Name);
        if not ItemJournalBatch.FindFirst() then begin
            ItemJournalBatch.Init();
            ItemJournalBatch."Journal Template Name" := ItemJournalTemplate.Name;
            ItemJournalBatch.Name := 'TRANSFER';
            ItemJournalBatch.Description := 'Item Transfer Posting';
            ItemJournalBatch.Insert();
        end;
    end;

    local procedure CreateItemJournalLine(var ItemJournalLine: Record "Item Journal Line";
                                         TemplateName: Code[10]; BatchName: Code[10]; LineNo: Integer;
                                         ItemTransferHeader: Record "Item Transfer Header";
                                         ItemTransferLine: Record "Item Transfer Line"; IsPositive: Boolean)
    begin
        ItemJournalLine.Init();
        ItemJournalLine."Journal Template Name" := TemplateName;
        ItemJournalLine."Journal Batch Name" := BatchName;
        ItemJournalLine."Line No." := LineNo;
        ItemJournalLine."Posting Date" := ItemTransferHeader."Transfer Date";
        ItemJournalLine."Document No." := ItemTransferHeader."No.";
        ItemJournalLine."Item No." := ItemTransferLine."Item No.";
        ItemJournalLine.Description := CopyStr(StrSubstNo('Transfer %1', ItemTransferHeader."No."), 1, MaxStrLen(ItemJournalLine.Description));

        if IsPositive then begin
            ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Positive Adjmt.";
            ItemJournalLine."Location Code" := ItemTransferLine."Location To Code";
            ItemJournalLine.Quantity := ItemTransferLine."Quantity to Transfer";
        end else begin
            ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
            ItemJournalLine."Location Code" := ItemTransferLine."Location From Code";
            ItemJournalLine.Quantity := ItemTransferLine."Quantity to Transfer";
        end;

        ItemJournalLine."Unit of Measure Code" := ItemTransferLine."Unit of Measure Code";
        ItemJournalLine."Unit Cost" := ItemTransferLine."Unit Cost";
        ItemJournalLine.Insert();
    end;

    local procedure PostItemJournal(TemplateName: Code[10]; BatchName: Code[10])
    var
        ItemJournalLine: Record "Item Journal Line";
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
    begin
        ItemJournalLine.SetRange("Journal Template Name", TemplateName);
        ItemJournalLine.SetRange("Journal Batch Name", BatchName);
        if ItemJournalLine.FindFirst() then
            ItemJnlPostBatch.Run(ItemJournalLine);
    end;
}