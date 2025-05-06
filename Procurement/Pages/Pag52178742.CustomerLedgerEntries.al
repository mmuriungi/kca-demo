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
                ToolTip = 'Post the selected line to the general ledger.';

                trigger OnAction()
                var
                    PostedCount: Integer;
                    SkippedCount: Integer;
                begin
                    if InsertAndPostGenJournalLine(PostedCount, SkippedCount) then
                        Message('Entry posted successfully.');
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
                ToolTip = 'Post all unposted lines to the general ledger.';

                trigger OnAction()
                begin
                    PostAllUnpostedLedgers();
                end;
            }
        }
    }

    procedure PostAllUnpostedLedgers()
    var
        CustLedgerUpload: Record "Customer ledger Upload";
        PostedCount: Integer;
        SkippedCount: Integer;
        TotalToProcess: Integer;
    begin
        PostedCount := 0;
        SkippedCount := 0;

        // Get all unposted records
        CustLedgerUpload.Reset();
        CustLedgerUpload.SetRange(Posted, false);
        TotalToProcess := CustLedgerUpload.Count;

        if TotalToProcess = 0 then begin
            Message('No unposted entries found.');
            exit;
        end;

        if CustLedgerUpload.FindSet() then
            repeat
                Rec := CustLedgerUpload;
                InsertAndPostGenJournalLine(PostedCount, SkippedCount);
                // Update the record in the table directly to mark as posted
                if not CustLedgerUpload.Posted then begin
                    CustLedgerUpload.Posted := true;
                    CustLedgerUpload.Modify();
                end;
            until CustLedgerUpload.Next() = 0;

        // Refresh the page to show updated Posted field
        CurrPage.Update(false);

        // Display consolidated message at the end
        Message('Processing complete: %1 entries posted, %2 entries skipped (zero amount).',
                PostedCount, SkippedCount);
    end;

    procedure InsertAndPostGenJournalLine(var PostedCount: Integer; var SkippedCount: Integer) Result: Boolean
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        Result := false;

        // Skip if amount is zero
        if Rec.Amount = 0 then begin
            SkippedCount += 1;
            exit(false);
        end;

        // Skip if already posted
        if Rec.Posted then begin
            SkippedCount += 1;
            exit(false);
        end;

        // Validate required fields
        if Rec."Account No." = '' then
            Error('Account No. must not be empty.');

        if Rec."Posting Date" = 0D then
            Error('Posting Date must be specified.');

        // Find the appropriate journal batch
        GenJournalBatch.Reset();
        GenJournalBatch.SetRange("Journal Template Name", 'GENERAL');
        GenJournalBatch.SetRange(Name, 'DEFAULT');
        if not GenJournalBatch.FindFirst() then
            Error('Journal batch not found. Please create a GENERAL template with DEFAULT batch.');

        // Get the next line number
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        if GenJournalLine.FindLast() then
            LineNo := GenJournalLine."Line No." + 10000
        else
            LineNo := 10000;

        // Clear and initialize the Gen. Journal Line
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'DEFAULT';
        GenJournalLine."Line No." := LineNo;

        // Use provided Document No
        GenJournalLine."Document No." := Rec."Document No";
        GenJournalLine."External Document No." := Rec."External Doc No";
        GenJournalLine."Posting Date" := Rec."Posting Date";

        // Set account information - Default to Customer
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := Rec."Account No.";
        GenJournalLine.Description := Rec.Description;
        GenJournalLine.Amount := Rec.Amount;

        // Set dimensions
        GenJournalLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";

        // Set balancing account - Default to G/L Account 72001
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := '72001';

        // Insert the journal line
        if GenJournalLine.Insert(true) then;

        // Post the journal line
        Clear(GenJnlPostLine);

        // Use try-catch to handle posting errors
        if not Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJournalLine) then
            Error(GetLastErrorText);

        // Update the Posted field in the Customer ledger Upload table
        Rec.Posted := true;
        Rec.Modify();

        // Increment posted counter
        PostedCount += 1;
        Result := true;
    end;
}