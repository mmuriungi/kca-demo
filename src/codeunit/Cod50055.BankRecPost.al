codeunit 50055 "Bank Rec.-Post"
{
    Permissions = TableData "Bank Account" = rm,
                  TableData "Bank Account Ledger Entry" = rm,
                  TableData "Check Ledger Entry" = rm,
                  //TableData "Journal Line Dimension"=rimd,
                  TableData "Bank Rec. Header" = rmd,
                  TableData "Bank Rec. Line" = rmd,
                  TableData "Bank Comment Line" = rimd,
                  TableData "Posted Bank Rec. Header" = rimd;
    //TableData "Posted Bank Rec. Line"=rimd,
    //TableData  "Bank Rec.-Post"=rimd;
    TableNo = "Bank Rec. Header";

    trigger OnRun()
    begin
        ClearAll;

        BankRecHeader := Rec;
        BankRecHeader.TestField("Statement Date");
        BankRecHeader.TestField("Statement No.");
        BankRecHeader.TestField("Bank Account No.");

        BankRecHeader.CalculateBalance;
        if (BankRecHeader."G/L Balance" +
            (BankRecHeader."Positive Adjustments" - BankRecHeader."Negative Bal. Adjustments") +
            (BankRecHeader."Negative Adjustments" - BankRecHeader."Positive Bal. Adjustments")) -
           ((BankRecHeader."Statement Balance" + BankRecHeader."Outstanding Deposits") - BankRecHeader."Outstanding Checks") <> 0
        then
            Error(Text007);

        BankRecHeader.CalcFields("Total Adjustments", "Total Balanced Adjustments");
        if (BankRecHeader."Total Adjustments" - BankRecHeader."Total Balanced Adjustments") <> 0 then
            Error(Text008);

        Window.Open(Text001 +
          Text002 +
          Text003 +
          Text004 +
          Text005 +
          Text006);

        Window.Update(1, BankRecHeader."Bank Account No.");
        Window.Update(2, BankRecHeader."Statement No.");

        GLSetup.Get;

        BankRecLine.LockTable;
        PostedBankRecLine.LockTable;

        SourceCodeSetup.Get;

        BankRecHeader.SetRange("Date Filter", BankRecHeader."Statement Date");
        BankRecHeader.CalcFields("G/L Balance (LCY)");
        BankRecHeader.CalculateBalance;

        PostedBankRecHeader.Init;
        PostedBankRecHeader.TransferFields(BankRecHeader, true);
        PostedBankRecHeader."G/L Balance (LCY)" := BankRecHeader."G/L Balance (LCY)";
        PostedBankRecHeader.Insert;

        BankRecCommentLine.SetCurrentKey("Table Name",
          "Bank Account No.",
          "No.");
        BankRecCommentLine.SetRange("Table Name", BankRecCommentLine."Table Name"::"Bank Rec.");
        BankRecCommentLine.SetRange("Bank Account No.", BankRecHeader."Bank Account No.");
        BankRecCommentLine.SetRange("No.", BankRecHeader."Statement No.");
        if BankRecCommentLine.Find('-') then
            repeat
                Window.Update(3, BankRecCommentLine."Line No.");

                PostedBankRecCommentLine.Init;
                PostedBankRecCommentLine.TransferFields(BankRecCommentLine, true);
                PostedBankRecCommentLine."Table Name" := PostedBankRecCommentLine."Table Name"::"Posted Bank Rec.";
                PostedBankRecCommentLine.INSERT(True);
            until BankRecCommentLine.Next = 0;
        BankRecCommentLine.DeleteAll;

        BankRecLine.Reset;
        BankRecLine.SetCurrentKey("Bank Account No.",
          "Statement No.");
        BankRecLine.SetRange("Bank Account No.", BankRecHeader."Bank Account No.");
        BankRecLine.SetRange("Statement No.", BankRecHeader."Statement No.");
        if BankRecLine.Find('-') then
            repeat
                Window.Update(BankRecLine."Record Type" + 4, BankRecLine."Line No.");
                if BankRecLine."Record Type" = BankRecLine."Record Type"::Adjustment then
                    if (GLSetup."Bank Rec. Adj. Doc. Nos." <> '') and
                       (BankRecLine."Document No." <> NoSeriesMgt.GetNextNo(GLSetup."Bank Rec. Adj. Doc. Nos.",
                          BankRecHeader."Posting Date", false))
                    then
                        NoSeriesMgt.TestManual(GLSetup."Bank Rec. Adj. Doc. Nos.");

                if BankRecLine."Record Type" = BankRecLine."Record Type"::Adjustment then
                    PostAdjustmentToGL(BankRecLine)
                else
                    if BankRecLine.Cleared then
                        UpdateLedgers(BankRecLine, SetStatus::Posted)
                    else
                        UpdateLedgers(BankRecLine, SetStatus::Open);

                PostedBankRecLine.Init;
                PostedBankRecLine.TransferFields(BankRecLine, true);
                PostedBankRecLine.INSERT(True);
            until BankRecLine.Next = 0;
        BankRecLine.DeleteAll;
        BankRecSubLine.Reset;
        BankRecSubLine.SetRange("Bank Account No.", BankRecHeader."Bank Account No.");
        BankRecSubLine.SetRange("Statement No.", BankRecHeader."Statement No.");
        BankRecSubLine.DeleteAll;

        BankAccount.Get(BankRecHeader."Bank Account No.");
        BankAccount."Last Statement No." := BankRecHeader."Statement No.";
        BankAccount."Balance Last Statement" := BankRecHeader."Statement Balance";
        BankAccount.Modify;

        BankRecHeader.Delete;

        Commit;
        Window.Close;
        if GLSetup."Bank Rec. Adj. Doc. Nos." <> '' then
            NoSeriesMgt.SaveNoSeries;
        Rec := BankRecHeader;
        UpdateAnalysisView.UpdateAll(0, true);
    end;

    var
        SetStatus: Option Open,Cleared,Posted;
        BankRecHeader: Record "Bank Rec. Header";
        BankRecLine: Record "Bank Rec. Line";
        BankRecCommentLine: Record "Bank Comment Line";
        BankRecSubLine: Record "Bank Rec. Sub-line";
        PostedBankRecHeader: Record "Posted Bank Rec. Header";
        PostedBankRecLine: Record "Posted Bank Rec. Line";
        PostedBankRecCommentLine: Record "Bank Comment Line";
        GLSetup: Record "General Ledger Setup";
        SourceCodeSetup: Record "Source Code Setup";
        BankAccount: Record "Bank Account";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        UpdateAnalysisView: Codeunit "Update Analysis View";
        Window: Dialog;
        Text001: Label 'Posting Bank Account  #1#################### \\';
        Text002: Label 'Statement             #2#################### \';
        Text003: Label 'Comment               #3########## \';
        Text004: Label 'Check                 #4########## \';
        Text005: Label 'Deposit               #5########## \';
        Text006: Label 'Adjustment            #6########## \';
        Text007: Label 'Difference must be zero before the statement can be posted.';
        Text008: Label 'Balance of adjustments must be zero before posting.';
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure UpdateLedgers(BankRecLine3: Record "Bank Rec. Line"; UseStatus: Option Open,Cleared,Posted)
    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        CheckLedgerEntry: Record "Check Ledger Entry";
        BankRecSubLine: Record "Bank Rec. Sub-line";
        CheckLedgerEntry2: Record "Check Ledger Entry";
    begin
        if (BankRecLine3."Bank Ledger Entry No." <> 0) and (BankRecLine3."Check Ledger Entry No." = 0) then
            UpdateBankLedger(
              BankRecLine3."Bank Ledger Entry No.", UseStatus,
              BankRecLine3."Statement No.", BankRecLine3."Line No.");
        if BankRecLine3."Check Ledger Entry No." <> 0 then
            if CheckLedgerEntry.Get(BankRecLine3."Check Ledger Entry No.") then begin
                if UseStatus = UseStatus::Posted then
                    CheckLedgerEntry.Open := false;
                case UseStatus of
                    UseStatus::Open:
                        CheckLedgerEntry."Statement Status" := CheckLedgerEntry."Statement Status"::Open;
                    UseStatus::Cleared:
                        CheckLedgerEntry."Statement Status" := CheckLedgerEntry."Statement Status"::"Check Entry Applied";
                    UseStatus::Posted:
                        CheckLedgerEntry."Statement Status" := CheckLedgerEntry."Statement Status"::Closed;
                end;
                if CheckLedgerEntry."Statement Status" = CheckLedgerEntry."Statement Status"::Open then begin
                    CheckLedgerEntry."Statement No." := '';
                    CheckLedgerEntry."Statement Line No." := 0;
                end else begin
                    CheckLedgerEntry."Statement No." := BankRecLine3."Statement No.";
                    CheckLedgerEntry."Statement Line No." := BankRecLine3."Line No.";
                end;
                CheckLedgerEntry.Modify;
                if (CheckLedgerEntry."Check Type" = CheckLedgerEntry."Check Type"::"Total Check") or
                   (UseStatus <> UseStatus::Posted)
                then
                    UpdateBankLedger(
                      BankRecLine3."Bank Ledger Entry No.", UseStatus,
                      BankRecLine3."Statement No.", BankRecLine3."Line No.")
                else begin
                    CheckLedgerEntry2.Reset;
                    CheckLedgerEntry2.SetCurrentKey("Bank Account Ledger Entry No.");
                    CheckLedgerEntry2.SetRange("Bank Account Ledger Entry No.", CheckLedgerEntry."Bank Account Ledger Entry No.");
                    CheckLedgerEntry2.SetFilter("Statement Status", '<>%1', CheckLedgerEntry."Statement Status"::Closed);
                    if CheckLedgerEntry2.Find('-') then begin
                        if BankLedgerEntry.Get(CheckLedgerEntry2."Bank Account Ledger Entry No.") then begin
                            BankLedgerEntry."Remaining Amount" := 0;
                            repeat
                                BankLedgerEntry."Remaining Amount" :=
                                  BankLedgerEntry."Remaining Amount" - CheckLedgerEntry2.Amount;
                            until CheckLedgerEntry2.Next = 0;
                            BankLedgerEntry.Modify;
                        end;
                    end else
                        UpdateBankLedger(
                          BankRecLine3."Bank Ledger Entry No.", UseStatus,
                          BankRecLine3."Statement No.", BankRecLine3."Line No.");
                end;
            end;
        if BankRecLine3."Collapse Status" = BankRecLine3."Collapse Status"::"Collapsed Deposit" then begin
            BankRecSubLine.SetRange("Bank Account No.", BankRecLine3."Bank Account No.");
            BankRecSubLine.SetRange("Statement No.", BankRecLine3."Statement No.");
            BankRecSubLine.SetRange("Bank Rec. Line No.", BankRecLine3."Line No.");
            if BankRecSubLine.Find('-') then
                repeat
                    UpdateBankLedger(
                      BankRecSubLine."Bank Ledger Entry No.", UseStatus,
                      BankRecLine3."Statement No.", BankRecLine3."Line No.");
                until BankRecSubLine.Next = 0;
        end;
    end;

    local procedure UpdateBankLedger(BankLedgerEntryNo: Integer; UseStatus: Option Open,Cleared,Posted; StatementNo: Code[20]; StatementLineNo: Integer)
    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        if BankLedgerEntry.Get(BankLedgerEntryNo) then begin
            if UseStatus = UseStatus::Posted then begin
                BankLedgerEntry.Open := false;
                BankLedgerEntry."Remaining Amount" := 0;
            end;
            case UseStatus of
                UseStatus::Open:
                    BankLedgerEntry."Statement Status" := BankLedgerEntry."Statement Status"::Open;
                UseStatus::Cleared:
                    BankLedgerEntry."Statement Status" := BankLedgerEntry."Statement Status"::"Bank Acc. Entry Applied";
                UseStatus::Posted:
                    BankLedgerEntry."Statement Status" := BankLedgerEntry."Statement Status"::Closed;
            end;
            if BankLedgerEntry."Statement Status" = BankLedgerEntry."Statement Status"::Open then begin
                BankLedgerEntry."Statement No." := '';
                BankLedgerEntry."Statement Line No." := 0;
            end else begin
                BankLedgerEntry."Statement No." := StatementNo;
                BankLedgerEntry."Statement Line No." := StatementLineNo;
            end;
            BankLedgerEntry.Modify;
        end;
    end;

    local procedure PostAdjustmentToGL(BankRecLine2: Record "Bank Rec. Line")
    var
        GenJnlLine: Record "Gen. Journal Line";
        GLEntry: Record "G/L Entry";
    begin
        if BankRecLine2.Amount <> 0 then begin
            GenJnlLine.Init;
            GenJnlLine."Posting Date" := BankRecLine2."Posting Date";
            GenJnlLine."Document Date" := BankRecLine2."Posting Date";
            GenJnlLine.Description := BankRecLine2.Description;
            GenJnlLine."Account Type" := BankRecLine2."Account Type";
            GenJnlLine."Account No." := BankRecLine2."Account No.";
            GenJnlLine."Bal. Account Type" := BankRecLine2."Bal. Account Type";
            GenJnlLine."Bal. Account No." := BankRecLine2."Bal. Account No.";
            GenJnlLine."Document Type" := BankRecLine2."Document Type";
            GenJnlLine."Document No." := BankRecLine2."Document No.";
            GenJnlLine."External Document No." := BankRecLine2."External Document No.";
            GenJnlLine."Currency Code" := BankRecLine2."Currency Code";
            GenJnlLine."Currency Factor" := BankRecLine2."Currency Factor";
            GenJnlLine."Source Currency Code" := BankRecLine2."Currency Code";
            GenJnlLine."Source Currency Amount" := BankRecLine2.Amount;
            if BankRecLine2."Currency Code" = '' then
                GenJnlLine."Currency Factor" := 1
            else
                GenJnlLine."Currency Factor" := BankRecLine2."Currency Factor";
            GenJnlLine.Validate(Amount, BankRecLine2.Amount);
            GenJnlLine."Source Type" := BankRecLine2."Account Type";
            GenJnlLine."Source No." := BankRecLine2."Account No.";
            //GenJnlLine."Source Code" := SourceCodeSetup."Bank Rec. Adjustment";
            GenJnlLine."Shortcut Dimension 1 Code" := BankRecLine2."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := BankRecLine2."Shortcut Dimension 2 Code";
            GenJnlLine."Dimension Set ID" := BankRecLine2."Dimension Set ID";

            GenJnlPostLine.RunWithCheck(GenJnlLine);

            GLEntry.FindLast;
            if GLEntry."Bal. Account Type" = GLEntry."Bal. Account Type"::"Bank Account" then
                BankRecLine2."Bank Ledger Entry No." := GLEntry."Entry No." - 1
            else
                BankRecLine2."Bank Ledger Entry No." := GLEntry."Entry No.";
            BankRecLine2."Check Ledger Entry No." := 0;
            BankRecLine2.Modify;
            UpdateLedgers(BankRecLine2, SetStatus::Posted);
        end;
    end;
}

