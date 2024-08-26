codeunit 50053 "Deposit-Post"
{
    Permissions = TableData "Cust. Ledger Entry" = r,
                  TableData "Vendor Ledger Entry" = r,
                  TableData "Bank Account Ledger Entry" = r,
                  TableData "Posted Deposit Header" = rim,
                  TableData "Posted Deposit LineX" = rim;
    TableNo = "Deposit Header";

    trigger OnRun()
    var
        RecordLinkManagement: Codeunit "Record Link Management";
    begin
        // Perform all testing

        Rec.TestField("Posting Date");
        Rec.TestField("Total Deposit Amount");
        Rec.TestField("Document Date");
        Rec.TestField("Bank Account No.");
        BankAccount.Get(Rec."Bank Account No.");
        BankAccount.TestField(Blocked, false);

        if Rec."Currency Code" = '' then
            Currency.InitRoundingPrecision
        else begin
            Currency.Get(Rec."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;

        SourceCodeSetup.Get;
        GenJnlTemplate.Get(Rec."Journal Template Name");

        Rec.CalcFields("Total Deposit Lines");
        if Rec."Total Deposit Lines" <> Rec."Total Deposit Amount" then
            Error(Text000, Rec.FieldCaption("Total Deposit Amount"), Rec.FieldCaption("Total Deposit Lines"));

        TotalLines := 0;
        TotalDepositLinesLCY := 0;
        CurLine := 0;
        Window.Open(
          StrSubstNo(Text001, Rec."No.") +
          Text004 +
          Text002 +
          Text003);

        // Copy to History Tables

        Window.Update(4, Text005);
        PostedDepositHeader.LockTable;
        PostedDepositLine.LockTable;

        Rec.LockTable;
        GenJnlLine.LockTable;

        PostedDepositHeader.TransferFields(Rec, true);
        PostedDepositHeader."No. Printed" := 0;
        PostedDepositHeader.Insert;

        RecordLinkManagement.CopyLinks(Rec, PostedDepositHeader);

        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        if GenJnlLine.Find('-') then
            repeat
                TotalLines := TotalLines + 1;
                Window.Update(2, TotalLines);
                PostedDepositLine."Deposit No." := Rec."No.";
                PostedDepositLine."Line No." := TotalLines;
                PostedDepositLine."Account Type" := GenJnlLine."Account Type";
                PostedDepositLine."Account No." := GenJnlLine."Account No.";
                PostedDepositLine."Document Date" := GenJnlLine."Document Date";
                PostedDepositLine."Document Type" := GenJnlLine."Document Type";
                PostedDepositLine."Document No." := GenJnlLine."Document No.";
                PostedDepositLine.Description := GenJnlLine.Description;
                PostedDepositLine."Currency Code" := GenJnlLine."Currency Code";
                PostedDepositLine.Amount := -GenJnlLine.Amount;
                PostedDepositLine."Posting Group" := GenJnlLine."Posting Group";
                PostedDepositLine."Shortcut Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
                PostedDepositLine."Shortcut Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
                PostedDepositLine."Dimension Set ID" := GenJnlLine."Dimension Set ID";
                PostedDepositLine."Posting Date" := Rec."Posting Date";
                PostedDepositLine.Insert;
                if GenJnlTemplate."Force Doc. Balance" then
                    AddBalancingAccount(GenJnlLine, Rec)
                else
                    GenJnlLine."Bal. Account No." := '';
                GenJnlCheckLine.RunCheck(GenJnlLine);
            until GenJnlLine.Next = 0;

        BankCommentLine.Reset;
        BankCommentLine.SetRange("Table Name", BankCommentLine."Table Name"::Deposit);
        BankCommentLine.SetRange("Bank Account No.", Rec."Bank Account No.");
        BankCommentLine.SetRange("No.", Rec."No.");
        if BankCommentLine.Find('-') then
            repeat
                BankCommentLine2 := BankCommentLine;
                BankCommentLine2."Table Name" := BankCommentLine2."Table Name"::"Posted Deposit";
                BankCommentLine2.Insert;
            until BankCommentLine.Next = 0;

        // Post to General, and other, Ledgers

        Window.Update(4, Text006);
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        if GenJnlLine.Find('-') then
            repeat
                CurLine := CurLine + 1;
                Window.Update(2, CurLine);
                Window.Update(3, Round(CurLine / TotalLines * 10000, 1));
                if GenJnlTemplate."Force Doc. Balance" then
                    AddBalancingAccount(GenJnlLine, Rec)
                else begin
                    TotalDepositLinesLCY := TotalDepositLinesLCY + GenJnlLine."Amount (LCY)";
                    GenJnlLine."Bal. Account No." := '';
                end;
                GenJnlLine."Source Code" := SourceCodeSetup.Deposits;
                GenJnlLine."Source Type" := GenJnlLine."Source Type"::"Bank Account";
                GenJnlLine."Source No." := Rec."Bank Account No.";
                GenJnlLine."Source Currency Code" := Rec."Currency Code";
                GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;
                GenJnlPostLine.RunWithoutCheck(GenJnlLine);

                PostedDepositLine.Get(Rec."No.", CurLine);
                case GenJnlLine."Account Type" of
                    GenJnlLine."Account Type"::"G/L Account",
                    GenJnlLine."Account Type"::"Bank Account":
                        begin
                            GLEntry.FindLast;
                            PostedDepositLine."Entry No." := GLEntry."Entry No.";
                            if GenJnlTemplate."Force Doc. Balance" and
                               (GenJnlLine.Amount * GLEntry.Amount < 0)
                            then
                                PostedDepositLine."Entry No." := PostedDepositLine."Entry No." - 1;
                        end;
                    GenJnlLine."Account Type"::Customer:
                        begin
                            CustLedgEntry.FindLast;
                            PostedDepositLine."Entry No." := CustLedgEntry."Entry No.";
                        end;
                    GenJnlLine."Account Type"::Vendor:
                        begin
                            VendLedgEntry.FindLast;
                            PostedDepositLine."Entry No." := VendLedgEntry."Entry No.";
                        end;
                end;
                if GenJnlTemplate."Force Doc. Balance" then begin
                    BankAccountLedgerEntry.FindLast;
                    PostedDepositLine."Bank Account Ledger Entry No." := BankAccountLedgerEntry."Entry No.";
                    if (GenJnlLine."Account Type" = GenJnlLine."Account Type"::"Bank Account") and
                       (GenJnlLine.Amount * BankAccountLedgerEntry.Amount > 0)
                    then
                        PostedDepositLine."Entry No." := PostedDepositLine."Entry No." - 1;
                end;
                PostedDepositLine.Modify;
            until GenJnlLine.Next = 0;

        Window.Update(4, Text007);
        if not GenJnlTemplate."Force Doc. Balance" then begin
            GenJnlLine.Init;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
            GenJnlLine."Account No." := Rec."Bank Account No.";
            GenJnlLine."Posting Date" := Rec."Posting Date";
            GenJnlLine."Document No." := Rec."No.";
            GenJnlLine."Currency Code" := Rec."Currency Code";
            GenJnlLine."Currency Factor" := Rec."Currency Factor";
            GenJnlLine."Posting Group" := Rec."Bank Acc. Posting Group";
            GenJnlLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
            GenJnlLine."Dimension Set ID" := Rec."Dimension Set ID";
            GenJnlLine."Source Code" := SourceCodeSetup.Deposits;
            GenJnlLine."Reason Code" := Rec."Reason Code";
            GenJnlLine."Document Date" := Rec."Document Date";
            GenJnlLine."External Document No." := Rec."No.";
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::"Bank Account";
            GenJnlLine."Source No." := Rec."Bank Account No.";
            GenJnlLine."Source Currency Code" := Rec."Currency Code";
            GenJnlLine.Description := Rec."Posting Description";
            GenJnlLine.Amount := Rec."Total Deposit Amount";
            GenJnlLine."Source Currency Amount" := Rec."Total Deposit Amount";
            GenJnlLine.Validate(Amount);
            GenJnlLine."Amount (LCY)" := -TotalDepositLinesLCY;
            GenJnlPostLine.RunWithCheck(GenJnlLine);

            BankAccountLedgerEntry.FindLast;    // The last entry is the one we just posted.
            PostedDepositLine.Reset;
            PostedDepositLine.SetRange("Deposit No.", Rec."No.");
            if PostedDepositLine.Find('-') then
                repeat
                    PostedDepositLine."Bank Account Ledger Entry No." := BankAccountLedgerEntry."Entry No.";
                    PostedDepositLine.Modify;
                until PostedDepositLine.Next = 0;
        end;

        // Erase Original Document
        Window.Update(4, Text008);

        BankCommentLine.Reset;
        BankCommentLine.SetRange("Table Name", BankCommentLine."Table Name"::Deposit);
        BankCommentLine.SetRange("Bank Account No.", Rec."Bank Account No.");
        BankCommentLine.SetRange("No.", Rec."No.");
        BankCommentLine.DeleteAll;

        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        GenJnlLine.DeleteAll;
        GenJnlBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
        if IncStr(Rec."Journal Batch Name") <> '' then begin
            GenJnlBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
            GenJnlBatch.Delete;
            GenJnlBatch.Name := IncStr(Rec."Journal Batch Name");
            if GenJnlBatch.Insert then;
        end;

        Rec.Delete;

        Commit;

        UpdateAnalysisView.UpdateAll(0, true);
    end;

    var
        PostedDepositHeader: Record "Posted Deposit Header";
        PostedDepositLine: Record "Posted Deposit LineX";
        BankCommentLine: Record "Bank Comment Line";
        BankCommentLine2: Record "Bank Comment Line";
        BankAccount: Record "Bank Account";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        SourceCodeSetup: Record "Source Code Setup";
        GLEntry: Record "G/L Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        Currency: Record Currency;
        Window: Dialog;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
        Text000: Label 'The %1 must match the %2.';
        Text001: Label 'Posting Deposit No. %1...\\';
        Text002: Label 'Deposit Line  #2########\';
        UpdateAnalysisView: Codeunit "Update Analysis View";
        TotalLines: Integer;
        CurLine: Integer;
        Text003: Label '@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        Text004: Label 'Status        #4###################\';
        Text005: Label 'Moving Deposit to History';
        Text006: Label 'Posting Lines to Ledgers';
        Text007: Label 'Posting Bank Entry';
        Text008: Label 'Removing Deposit Entry';
        TotalDepositLinesLCY: Decimal;

    local procedure AddBalancingAccount(var GenJnlLine: Record "Gen. Journal Line"; DepositHeader: Record "Deposit Header")
    begin
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine."Bal. Account No." := DepositHeader."Bank Account No.";
        GenJnlLine."Balance (LCY)" := 0;
    end;
}

