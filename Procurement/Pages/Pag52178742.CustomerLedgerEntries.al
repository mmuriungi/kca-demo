page 52178742 "Update Customer Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Customer Ledger Entries';
    PageType = List;
    SourceTable = "Customer ledger Upload";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No field.', Comment = '%';
                }
                field("Account  Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Type field.', Comment = '%';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Global 1"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global 1 field.', Comment = '%';
                }
                field("Global 2"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global 2 field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("External Doc No"; Rec."External Doc No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Doc No field.', Comment = '%';
                }
                field("balalance Account Type"; Rec."balalance Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the balalance Account Type field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the entry has been posted.', Comment = '%';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(PostToLedger)
            {
                ApplicationArea = All;
                Caption = 'Post to Ledger';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Post the selected line to the general ledger and delete it.';

                trigger OnAction()
                begin
                    PostAndDelete();
                end;
            }

            action(PostAllToLedger)
            {
                ApplicationArea = All;
                Caption = 'Post All to Ledger';
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Post all unposted lines to the general ledger and delete them.';

                trigger OnAction()
                var
                    Processor: Codeunit "Customer Ledger Processor";
                begin
                    Processor.InsertUnpostedToGenJournal();
                end;
            }
        }
    }

    // Simple procedure to post a single entry and delete it
    procedure PostAndDelete()
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
    begin
        // Skip if amount is zero
        if Rec.Amount = 0 then begin
            Message('Entry skipped - Amount is zero.');
            exit;
        end;

        // Validate required fields
        if Rec."Account No." = '' then begin
            Error('Account No. must not be empty.');
            exit;
        end;

        if Rec."Posting Date" = 0D then begin
            Error('Posting Date must be specified.');
            exit;
        end;

        // Get the next line number
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        if GenJournalLine.FindLast() then
            LineNo := GenJournalLine."Line No." + 10000
        else
            LineNo := 10000;

        // Create the journal line
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'DEFAULT';
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document No." := Rec."Document No";
        GenJournalLine."External Document No." := Rec."External Doc No";
        GenJournalLine."Posting Date" := Rec."Posting Date";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := Rec."Account No.";
        GenJournalLine.Description := Rec.Description;
        GenJournalLine.Amount := Rec.Amount;
        GenJournalLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := '72001';

        // Insert the journal line
        if not GenJournalLine.Insert(true) then
            Error('Failed to insert journal line');

        // Post the line directly using codeunit
        if Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJournalLine) then begin
            // Delete this record after successful posting
            Rec.Delete();
            Message('Entry posted and deleted successfully.');
        end else
            Error('Posting failed: %1', GetLastErrorText);
    end;

    // Simple procedure to post all entries
    procedure PostAllEntries()
    var
        CustLedgerUpload: Record "Customer ledger Upload";
        Count: Integer;
        TotalCount: Integer;
    begin
        Count := 0;

        // Count total records
        CustLedgerUpload.Reset();
        CustLedgerUpload.SetRange(Posted, false);
        TotalCount := CustLedgerUpload.Count;

        if TotalCount = 0 then begin
            Message('No entries to post.');
            exit;
        end;

        if not Confirm('Post %1 entries?', false, TotalCount) then
            exit;

        // Use a simple approach - get one record at a time
        CustLedgerUpload.Reset();
        CustLedgerUpload.SetRange(Posted, false);

        if CustLedgerUpload.FindSet() then
            repeat
                // Set current record to the one we found
                Rec := CustLedgerUpload;

                // Try to post and delete in a separate transaction
                if TryToPostAndDelete(CustLedgerUpload) then
                    Count += 1;

            until CustLedgerUpload.Next() = 0;

        // Refresh page
        CurrPage.Update(false);

        Message('%1 of %2 entries posted and deleted.', Count, TotalCount);
    end;

    // Helper function that posts a single entry in its own transaction
    local procedure TryToPostAndDelete(var CustLedgerUpload: Record "Customer ledger Upload"): Boolean
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        RecID: RecordID;
    begin
        // Skip if amount is zero
        if CustLedgerUpload.Amount = 0 then
            exit(false);

        // Remember the record ID so we can find it again
        RecID := CustLedgerUpload.RecordId;

        // Create journal line
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        if GenJournalLine.FindLast() then
            LineNo := GenJournalLine."Line No." + 10000
        else
            LineNo := 10000;

        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'DEFAULT';
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document No." := CustLedgerUpload."Document No";
        GenJournalLine."External Document No." := CustLedgerUpload."External Doc No";
        GenJournalLine."Posting Date" := CustLedgerUpload."Posting Date";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := CustLedgerUpload."Account No.";
        GenJournalLine.Description := CustLedgerUpload.Description;
        GenJournalLine.Amount := CustLedgerUpload.Amount;
        GenJournalLine."Shortcut Dimension 1 Code" := CustLedgerUpload."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := CustLedgerUpload."Global Dimension 2 Code";
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := '72001';

        // Insert in its own transaction
        if not GenJournalLine.Insert(true) then
            exit(false);

        // Post in its own transaction   
        //   CODEUNIT.RUN(CODEUNIT::"Modified Gen. Jnl.-Post", GenJnlLine);

        if not Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJournalLine) then begin
            Error('Posting failed for Document No. %1: %2', GenJournalLine."Document No.", GetLastErrorText);
            exit(false);
        end;


        // Find and delete the original record in its own transaction
        if CustLedgerUpload.Get(RecID) then
            if not CustLedgerUpload.Delete(true) then
                exit(false);

        exit(true);
    end;
}