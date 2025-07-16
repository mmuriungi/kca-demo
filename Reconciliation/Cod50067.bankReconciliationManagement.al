codeunit 50067 "bank Reconciliation Management"
{

    /*{
        TableNo = "Bank Acc. Reconciliation";

        trigger OnRun()
        begin
            if BankAccReconPostYesNo(Rec) then;
        end;

        var
            PostReconciliationQst: Label 'Do you want to post the Reconciliation?';
            PostPaymentsOnlyQst: Label 'Do you want to post the payments?';
            PostPaymentsAndReconcileQst: Label 'Do you want to post the payments and reconcile the bank account?';
            UnreconciledItemsExistQst: Label 'Unreconciled items exist. Do you want to transfer them to a new reconciliation statement?';

        procedure BankAccReconPostYesNo(var BankAccReconciliation: Record "Bank Acc. Reconciliation") Result: Boolean
        var
            BankAccRecon: Record "Bank Acc. Reconciliation";
            UnreconciledLines: Record "Bank Acc. Reconciliation Line" temporary;
            IsHandled: Boolean;
        begin
            IsHandled := false;
            OnBeforeBankAccReconPostYesNo(BankAccReconciliation, Result, IsHandled);
            if IsHandled then
                exit(Result);

            BankAccRecon.Copy(BankAccReconciliation);

            // Determine confirmation question based on statement type
            if BankAccRecon."Statement Type" = BankAccRecon."Statement Type"::"Payment Application" then
                if BankAccRecon."Post Payments Only" then
                    if not Confirm(PostPaymentsOnlyQst, false) then
                        exit(false)
                    else
                        if not Confirm(PostPaymentsAndReconcileQst, false) then
                            exit(false)
                        else
                            if not Confirm(PostReconciliationQst, false) then
                                exit(false);

            // Separate reconciled and unreconciled lines
            if not SeparateReconciledLines(BankAccRecon, UnreconciledLines) then
                exit(false);

            // Run standard posting codeunit
            PostReconciliation(BankAccRecon);

            //CODEUNIT.Run(CODEUNIT::"Bank Acc. Reconciliation Post", BankAccRecon);

            // Handle unreconciled lines
            if not UnreconciledLines.IsEmpty then
                HandleUnreconciledLines(BankAccRecon, UnreconciledLines);

            // Update original record
            BankAccReconciliation := BankAccRecon;
            exit(true);
            Message('Bank Account Reconciliation has been posted.');
        end;

        local procedure SeparateReconciledLines(var BankAccReconciliation: Record "Bank Acc. Reconciliation"; var UnreconciledLines: Record "Bank Acc. Reconciliation Line" temporary) Continue: Boolean
        var
            BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
            UnreconciledItemsExist: Boolean;
        begin
            // Find unreconciled lines
            BankAccReconciliationLine.SetRange("Bank Account No.", BankAccReconciliation."Bank Account No.");
            BankAccReconciliationLine.SetRange("Statement No.", BankAccReconciliation."Statement No.");

            if BankAccReconciliationLine.FindSet() then
                repeat
                    // Check if line is not fully reconciled (with small tolerance)
                    if Abs(BankAccReconciliationLine."Statement Amount" - BankAccReconciliationLine."Applied Amount") > 0.01 then begin
                        UnreconciledLines := BankAccReconciliationLine;
                        UnreconciledLines.Insert();
                        UnreconciledItemsExist := true;
                    end;
                until BankAccReconciliationLine.Next() = 0;

            // Prompt user about unreconciled items if they exist
            if UnreconciledItemsExist then
                Continue := Confirm(UnreconciledItemsExistQst, false)
            else
                Continue := true;

            exit(Continue);
        end;

        local procedure HandleUnreconciledLines(var OriginalBankAccReconciliation: Record "Bank Acc. Reconciliation"; var UnreconciledLines: Record "Bank Acc. Reconciliation Line" temporary)
        var
            NewBankAccReconciliation: Record "Bank Acc. Reconciliation";
            NewBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        begin
            // Create a new bank reconciliation for unreconciled items
            NewBankAccReconciliation.Init();
            NewBankAccReconciliation."Bank Account No." := OriginalBankAccReconciliation."Bank Account No.";
            NewBankAccReconciliation.Validate("Bank Account No.");

            NewBankAccReconciliation."Statement Date" := CALCDATE('1M', TODAY);
            NewBankAccReconciliation."Statement No." := GetNextStatementNo(NewBankAccReconciliation);
            //NewBankAccReconciliation.Status := NewBankAccReconciliation.Status::Open;
            NewBankAccReconciliation."Statement Type" := OriginalBankAccReconciliation."Statement Type";

            NewBankAccReconciliation.Insert(true);

            // Transfer unreconciled lines to the new reconciliation
            if UnreconciledLines.FindSet() then
                repeat
                    NewBankAccReconciliationLine.Init();
                    NewBankAccReconciliationLine."Bank Account No." := UnreconciledLines."Bank Account No.";
                    NewBankAccReconciliationLine."Statement No." := NewBankAccReconciliation."Statement No.";
                    NewBankAccReconciliationLine."Statement Line No." := GetNextLineNo(NewBankAccReconciliation);

                    // Copy relevant fields from unreconciled line
                    NewBankAccReconciliationLine."Unreconcile Previously" := true;
                    NewBankAccReconciliationLine."Transaction Date" := UnreconciledLines."Transaction Date";
                    NewBankAccReconciliationLine."Statement Amount" := UnreconciledLines."Statement Amount";
                    NewBankAccReconciliationLine.Description := UnreconciledLines.Description;

                    NewBankAccReconciliationLine.Insert(true);
                until UnreconciledLines.Next() = 0;


            OnAfterHandleUnreconciledLines(OriginalBankAccReconciliation, NewBankAccReconciliation);
        end;

        procedure PostReconciliation(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
        begin
            if GuiAllowed and not PreviewMode then begin
                Window.Open('#1#################################\\' + PostingLinesTxt);
                Window.Update(1, StrSubstNo('%1 %2', BankAccReconciliation."Bank Account No.", BankAccReconciliation."Statement No."));
            end;

            InitPost(BankAccReconciliation);
            Post(BankAccReconciliation);
            FinalizePost(BankAccReconciliation);





            if PreviewMode then
                exit;

            if GuiAllowed then
                Window.Close();

            Commit();
        end;

        var
            PostingLinesTxt: Label 'Posting lines              #2######';
            Text001: Label '%1 is not equal to Total Balance.';
            Text002: Label 'There is nothing to post.';
            Text003: Label 'The application is not correct. The total amount applied is %1; it should be %2.';
            Text004: Label 'The total difference is %1. It must be %2.';
            BankAcc: Record "Bank Account";
            BankAccLedgEntry: Record "Bank Account Ledger Entry";
            CheckLedgEntry: Record "Check Ledger Entry";
            GenJnlLine: Record "Gen. Journal Line";
            GLSetup: Record "General Ledger Setup";
            SourceCodeSetup: Record "Source Code Setup";
            GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
            Window: Dialog;
            SourceCode: Code[10];
            PostedStamentNo: Code[20];
            TotalAmount: Decimal;
            TotalAppliedAmount: Decimal;
            TotalDiff: Decimal;
            Lines: Integer;
            Difference: Decimal;
            PreviewMode: Boolean;
            ExcessiveAmtErr: Label 'You must apply the excessive amount of %1 %2 manually.', Comment = '%1 a decimal number, %2 currency code';
            PostPaymentsOnly: Boolean;
            NotFullyAppliedErr: Label 'One or more payments are not fully applied.\\The sum of applied amounts is %1. It must be %2.', Comment = '%1 - total applied amount, %2 - total transaction amount';
            LineNoTAppliedErr: Label 'The line with transaction date %1 and transaction text ''%2'' is not applied. You must apply all lines.', Comment = '%1 - transaction date, %2 - arbitrary text';
            TransactionAlreadyReconciledErr: Label 'The line with transaction date %1 and transaction text ''%2'' is already reconciled.\\You must remove it from the payment reconciliation journal before posting.', Comment = '%1 - transaction date, %2 - arbitrary text';

        [Scope('OnPrem')]
        [CommitBehavior(CommitBehavior::Ignore)]
        procedure RunPreview(var BankAccReconciliation: Record "Bank Acc. Reconciliation"): Boolean
        begin
            PreviewMode := true;
            InitPost(BankAccReconciliation);
            Post(BankAccReconciliation);

            FinalizePost(BankAccReconciliation);

            exit(true);
        end;

        local procedure InitPost(var BankAccRecon: Record "Bank Acc. Reconciliation")
        begin
            OnBeforeInitPost(BankAccRecon);
            GLSetup.Get();
            with BankAccRecon do
                case "Statement Type" of
                    "Statement Type"::"Bank Reconciliation":
                        begin
                            TestField("Statement Date");
                            CheckLinesMatchEndingBalance(BankAccRecon, Difference);
                        end;
                    "Statement Type"::"Payment Application":
                        begin
                            SourceCodeSetup.Get();
                            SourceCode := SourceCodeSetup."Payment Reconciliation Journal";
                            PostPaymentsOnly := "Post Payments Only";
                            if PreviewMode then
                                exit;
                            if not PostPaymentsOnly then
                                if GuiAllowed then begin
                                    if PAGE.RunModal(Page::"Post Pmts and Rec. Bank Acc.", BankAccRecon) <> ACTION::LookupOK then
                                        Error('');

                                    BankAccRecon.Get("Statement Type", "Bank Account No.", "Statement No.");
                                    CheckLinesMatchEndingBalance(BankAccRecon, Difference);
                                end;
                        end;
                end;
        end;

        local procedure StoreFieldsPrePosting(BankAccRecon: Record "Bank Acc. Reconciliation"; var PrePostingOutstdPayments: Decimal; var PrePostingOutstdBankTransactions: Decimal; var PrePostingGLBalance: Decimal; var PrePostingTotalPositiveDifference: Decimal; var PrePostingTotalNegativeDifference: Decimal)
        var
            PreBankAcc: Record "Bank Account";
            BankAccReconTest: Codeunit "Bank Acc. Recon. Test";
        begin
            BankAccRecon.CalcFields(
                "Total Applied Amount",

                "Total Outstd Bank Transactions",
                "Total Outstd Payments",
                "Total Unposted Applied Amount"
            );
            PrePostingOutstdPayments := BankAccReconTest.TotalOutstandingPayments(BankAccRecon);
            PrePostingOutstdBankTransactions := BankAccReconTest.TotalOutstandingBankTransactions(BankAccRecon);
            PrePostingTotalPositiveDifference := BankAccReconTest.TotalPositiveDifference(BankAccRecon);
            PrePostingTotalNegativeDifference := BankAccReconTest.TotalNegativeDifference(BankAccRecon);
            PreBankAcc.SetFilter("Date Filter", '..%1', BankAccRecon."Statement Date");
            PreBankAcc.SetAutoCalcFields("Balance at Date");
            if PreBankAcc.Get(BankAccRecon."Bank Account No.") then
                PrePostingGLBalance := PreBankAcc."Balance at Date";
        end;

        local procedure Post(BankAccRecon: Record "Bank Acc. Reconciliation")
        var
            BankAccReconLine: Record "Bank Acc. Reconciliation Line";
            BankAccRecMatchBuffer: Record "Bank Acc. Rec. Match Buffer";
            FeatureTelemetry: Codeunit "Feature Telemetry";
            AppliedAmount: Decimal;
            PrePostingOutstdPayments: Decimal;
            PrePostingOutstdBankTransactions: Decimal;
            PrePostingGLBalance: Decimal;
            PrePostingTotalPositiveDifference: Decimal;
            PrePostingTotalNegativeDifference: Decimal;
            TotalTransAmtNotAppliedErr: Text;
        begin
            OnBeforePost(BankAccRecon, BankAccReconLine);
            case BankAccRecon."Statement Type" of
                BankAccRecon."Statement Type"::"Bank Reconciliation":
                    FeatureTelemetry.LogUptake('0000JLO', BankAccRecon.GetBankReconciliationTelemetryFeatureName(), Enum::"Feature Uptake Status"::Used);
                BankAccRecon."Statement Type"::"Payment Application":
                    FeatureTelemetry.LogUptake('0000KMI', BankAccReconLine.GetPaymentRecJournalTelemetryFeatureName(), Enum::"Feature Uptake Status"::Used);
            end;
            StoreFieldsPrePosting(BankAccRecon, PrePostingOutstdPayments, PrePostingOutstdBankTransactions, PrePostingGLBalance, PrePostingTotalPositiveDifference, PrePostingTotalNegativeDifference);
            // Run through lines
            BankAccReconLine.FilterBankRecLines(BankAccRecon);
            OnPostAfterFilterBankAccRecLines(BankAccReconLine, BankAccRecon);
            TotalAmount := 0;
            TotalAppliedAmount := 0;
            Lines := 0;
            if BankAccReconLine.IsEmpty() then
                if Confirm(MissingBankAccReconLineQst) then
                    InsertEmptyBankAccReconLine(BankAccRecon)
                else
                    Error('');
            BankAccLedgEntry.LockTable();
            CheckLedgEntry.LockTable();

            PostedStamentNo := GetPostedStamentNo(BankAccRecon);

            if BankAccReconLine.FindSet() then
                repeat
                    Lines := Lines + 1;
                    if GuiAllowed then
                        if not PreviewMode then
                            Window.Update(2, Lines);
                    AppliedAmount := 0;

                    BankAccReconLine.FilterManyToOneMatches(BankAccRecMatchBuffer);
                    if (BankAccRecon."Statement Type" = BankAccRecon."Statement Type"::"Bank Reconciliation") and BankAccRecMatchBuffer.FindFirst() then begin
                        if (not BankAccRecMatchBuffer."Is Processed") then
                            CloseBankAccLEManyToOne(BankAccRecMatchBuffer, AppliedAmount, BankAccRecon."Statement Date");
                    end else begin
                        // Adjust entries
                        // Test amount and settled amount
                        case BankAccRecon."Statement Type" of
                            BankAccRecon."Statement Type"::"Bank Reconciliation":
                                CloseBankAccLedgEntry(BankAccReconLine, AppliedAmount, BankAccRecon."Statement Date");
                            BankAccRecon."Statement Type"::"Payment Application":
                                PostPaymentApplications(BankAccReconLine, AppliedAmount);
                        end;
                        OnBeforeAppliedAmountCheck(BankAccReconLine, AppliedAmount);
                        BankAccReconLine.TestField("Applied Amount", AppliedAmount);
                    end;
                    TotalAmount += BankAccReconLine."Statement Amount";
                    TotalAppliedAmount += AppliedAmount;
                until BankAccReconLine.Next() = 0;
            // Test amount
            if BankAccRecon."Statement Type" = BankAccRecon."Statement Type"::"Payment Application" then
                TotalTransAmtNotAppliedErr := NotFullyAppliedErr
            else
                TotalTransAmtNotAppliedErr := Text003;
            if TotalAmount <> TotalAppliedAmount then
                Error(
                  TotalTransAmtNotAppliedErr,
                  TotalAppliedAmount, TotalAmount);
            if Difference <> 0 then
                Error(Text004, Difference, 0);

            if PreviewMode then
                exit;
            // Get bank
            if not PostPaymentsOnly then
                UpdateBank(BankAccRecon, TotalAmount);

            case BankAccRecon."Statement Type" of
                BankAccRecon."Statement Type"::"Bank Reconciliation":
                    begin
                        TransferToBankStmt(BankAccRecon, PrePostingOutstdPayments, PrePostingOutstdBankTransactions, PrePostingGLBalance, PrePostingTotalPositiveDifference, PrePostingTotalNegativeDifference);
                        FeatureTelemetry.LogUsage('0000JLP', BankAccRecon.GetBankReconciliationTelemetryFeatureName(), EventNameTelemetryTxt);
                        Session.LogMessage('0000JLQ', Format(Lines), Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', BankAccountRecCategoryLbl);
                    end;
                BankAccRecon."Statement Type"::"Payment Application":
                    begin
                        HandlePaymentApplicationTransfer(BankAccRecon, PrePostingOutstdPayments, PrePostingOutstdBankTransactions, PrePostingGLBalance, PrePostingTotalPositiveDifference, PrePostingTotalNegativeDifference);
                        FeatureTelemetry.LogUsage('0000KMJ', BankAccReconLine.GetPaymentRecJournalTelemetryFeatureName(), EventNameTelemetryPmtTxt);
                        Session.LogMessage('0000KMK', Format(Lines), Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', PaymentRecCategoryLbl);
                    end;
            end;
            ArchiveBankReconciliation(BankAccRecon);
        end;

        local procedure HandlePaymentApplicationTransfer(BankAccRecon: Record "Bank Acc. Reconciliation"; PrePostingOutstdPayments: Decimal; PrePostingOutstdBankTransactions: Decimal; PrePostingGLBalance: Decimal; PrePostingTotalPositiveDifference: Decimal; PrePostingTotalNegativeDifference: Decimal)
        var
            IsHandled: Boolean;
        begin
            IsHandled := false;
            OnBeforeHandlePaymentApplicationTransfer(BankAccRecon, IsHandled);
            if IsHandled then
                exit;

            TransferToPostPmtAppln(BankAccRecon);
            if not BankAccRecon."Post Payments Only" then
                TransferToBankStmt(BankAccRecon, PrePostingOutstdPayments, PrePostingOutstdBankTransactions, PrePostingGLBalance, PrePostingTotalPositiveDifference, PrePostingTotalNegativeDifference);
        end;

        local procedure FinalizePost(BankAccRecon: Record "Bank Acc. Reconciliation")
        var
            BankAccReconLine: Record "Bank Acc. Reconciliation Line";
            AppliedPmtEntry: Record "Applied Payment Entry";
        begin
            if PreviewMode then
                exit;
            OnBeforeFinalizePost(BankAccRecon);
            with BankAccRecon do begin
                if BankAccReconLine.LinesExist(BankAccRecon) then
                    repeat
                        AppliedPmtEntry.FilterAppliedPmtEntry(BankAccReconLine);
                        AppliedPmtEntry.DeleteAll();

                        BankAccReconLine.Delete();
                        BankAccReconLine.ClearDataExchEntries;

                    until BankAccReconLine.Next() = 0;

                Find;
                Delete;
                // BankAccRecon."Status" := BankAccRecon."Status"::Closed;
                // BankAccRecon."Posted" := true;
                // BankAccRecon."Posted By" := USERID;
                // Modify();

            end;
            UpdateArchiveOpenStatus(BankAccRecon);
            OnAfterFinalizePost(BankAccRecon);
        end;

        local procedure CheckLinesMatchEndingBalance(BankAccRecon: Record "Bank Acc. Reconciliation"; var Difference: Decimal)
        var
            BankAccReconLine: Record "Bank Acc. Reconciliation Line";
        begin
            with BankAccReconLine do begin
                LinesExist(BankAccRecon);
                BankAccRecon.CalcFields("Unreconcile Statement Amount");
                CalcSums("Statement Amount", Difference);
                OnCheckLinesMatchEndingBalanceOnAfterCalcSums(BankAccReconLine);

                if "Statement Amount" <>

                   BankAccRecon."Statement Ending Balance" - BankAccRecon."Balance Last Statement" + BankAccRecon."Unreconcile Statement Amount"
                then
                    Error(Text001, BankAccRecon.FieldCaption("Statement Ending Balance"));
            end;
            Difference := BankAccReconLine.Difference;
        end;

        local procedure CloseBankAccLEManyToOne(BankAccRecMatchBuffer: Record "Bank Acc. Rec. Match Buffer"; var AppliedAmount: Decimal; StatementDate: Date);
        var
            BankAccRecMatchBufferCopy: Record "Bank Acc. Rec. Match Buffer";
            BankAccRecLine: Record "Bank Acc. Reconciliation Line";
            LedgerEntryNo: Integer;
            TotalRecLinesAmount: Decimal;
        begin
            BankAccRecMatchBufferCopy.SetRange("Bank Account No.", BankAccRecMatchBuffer."Bank Account No.");
            BankAccRecMatchBufferCopy.SetRange("Statement No.", BankAccRecMatchBuffer."Statement No.");
            BankAccRecMatchBufferCopy.SetRange("Match ID", BankAccRecMatchBuffer."Match ID");
            if (not BankAccRecMatchBufferCopy.IsEmpty()) then
                if BankAccRecMatchBufferCopy.FindSet() then
                    repeat
                        LedgerEntryNo := BankAccRecMatchBufferCopy."Ledger Entry No.";
                        BankAccRecMatchBufferCopy."Is Processed" := true;
                        BankAccRecMatchBufferCopy.Modify();
                        BankAccRecLine.SetRange("Bank Account No.", BankAccRecMatchBufferCopy."Bank Account No.");
                        BankAccRecLine.SetRange("Statement No.", BankAccRecMatchBufferCopy."Statement No.");
                        BankAccRecLine.SetRange("Statement Line No.", BankAccRecMatchBufferCopy."Statement Line No.");
                        if BankAccRecLine.FindFirst() then
                            TotalRecLinesAmount += BankAccRecLine."Statement Amount";
                    until BankAccRecMatchBufferCopy.Next() = 0;

            BankAccLedgEntry.Get(LedgerEntryNo);
            BankAccLedgEntry.TestField("Remaining Amount", TotalRecLinesAmount);
            AppliedAmount += BankAccLedgEntry."Remaining Amount";
            BankAccLedgEntry."Remaining Amount" := 0;
            BankAccLedgEntry.Open := false;
            BankAccLedgEntry."Closed at Date" := StatementDate;
            BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Closed;
            OnCloseBankAccLedgEntryOnBeforeBankAccLedgEntryModify(BankAccLedgEntry, BankAccRecLine);
            BankAccLedgEntry.Modify();

            CheckLedgEntry.Reset();
            CheckLedgEntry.SetCurrentKey("Bank Account Ledger Entry No.");
            CheckLedgEntry.SetRange(
                "Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
            CheckLedgEntry.SetRange(Open, true);
            if CheckLedgEntry.Find('-') then
                repeat
                    CheckLedgEntry.TestField(Open, true);
                    CheckLedgEntry.TestField(
                        "Statement Status",
                        CheckLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                    CheckLedgEntry.Open := false;
                    CheckLedgEntry."Statement Status" := CheckLedgEntry."Statement Status"::Closed;
                    CheckLedgEntry.Modify();
                until CheckLedgEntry.Next() = 0;
        end;

        local procedure CloseBankAccLedgEntry(BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal; StatementClosingDate: Date)
        var
            IsHandled: Boolean;
        begin
            IsHandled := false;
            OnBeforeCloseBankAccLedgEntry(BankAccReconLine, AppliedAmount, IsHandled);
            if IsHandled then
                exit;

            BankAccLedgEntry.Reset();
            BankAccLedgEntry.SetCurrentKey("Bank Account No.", Open);
            BankAccLedgEntry.SetRange("Bank Account No.", BankAccReconLine."Bank Account No.");
            BankAccLedgEntry.SetRange(Open, true);
            BankAccLedgEntry.SetFilter("Statement Status", '%1|%2', BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied", BankAccLedgEntry."Statement Status"::"Check Entry Applied");
            BankAccLedgEntry.SetRange("Statement No.", BankAccReconLine."Statement No.");
            BankAccLedgEntry.SetRange("Statement Line No.", BankAccReconLine."Statement Line No.");
            OnCloseBankAccLedgEntryOnAfterBankAccLedgEntrySetFilters(BankAccLedgEntry, BankAccReconLine);
            if BankAccLedgEntry.FindSet(true) then
                repeat
                    AppliedAmount += BankAccLedgEntry."Remaining Amount";
                    BankAccLedgEntry."Remaining Amount" := 0;
                    BankAccLedgEntry.Open := false;
                    BankAccLedgEntry."Closed at Date" := StatementClosingDate;
                    BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Closed;
                    BankAccLedgEntry."Statement No." := PostedStamentNo;
                    OnCloseBankAccLedgEntryOnBeforeBankAccLedgEntryModify(BankAccLedgEntry, BankAccReconLine);
                    BankAccLedgEntry.Modify();

                    CheckLedgEntry.Reset();
                    CheckLedgEntry.SetCurrentKey("Bank Account Ledger Entry No.");
                    CheckLedgEntry.SetRange(
                      "Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
                    CheckLedgEntry.SetRange(Open, true);
                    if CheckLedgEntry.Find('-') then
                        repeat
                            CheckLedgEntry.TestField(Open, true);
                            CheckLedgEntry.TestField("Statement No.", BankAccReconLine."Statement No.");
                            CheckLedgEntry.TestField("Statement Line No.", BankAccReconLine."Statement Line No.");
                            CheckLedgEntry.Open := false;
                            CheckLedgEntry."Statement Status" := CheckLedgEntry."Statement Status"::Closed;
                            OnCloseBankAccLedgEntryOnBeforeCheckLedgEntryModify(CheckLedgEntry, BankAccReconLine);
                            CheckLedgEntry.Modify();
                        until CheckLedgEntry.Next() = 0;
                until BankAccLedgEntry.Next() = 0;
        end;


        local procedure CloseCheckLedgEntry(BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal)
        var
            CheckLedgEntry2: Record "Check Ledger Entry";
        begin
            CheckLedgEntry.Reset();
            CheckLedgEntry.SetCurrentKey("Bank Account No.", Open);
            CheckLedgEntry.SetRange("Bank Account No.", BankAccReconLine."Bank Account No.");
            CheckLedgEntry.SetRange(Open, true);
            CheckLedgEntry.SetRange(
              "Statement Status", CheckLedgEntry."Statement Status"::"Check Entry Applied");
            CheckLedgEntry.SetRange("Statement No.", BankAccReconLine."Statement No.");
            CheckLedgEntry.SetRange("Statement Line No.", BankAccReconLine."Statement Line No.");
            if CheckLedgEntry.FindSet(true, true) then
                repeat
                    AppliedAmount -= CheckLedgEntry.Amount;
                    CheckLedgEntry.Open := false;
                    CheckLedgEntry."Statement Status" := CheckLedgEntry."Statement Status"::Closed;
                    CheckLedgEntry."Statement No." := PostedStamentNo;
                    CheckLedgEntry.Modify();

                    BankAccLedgEntry.Get(CheckLedgEntry."Bank Account Ledger Entry No.");
                    BankAccLedgEntry.TestField(Open, true);
                    BankAccLedgEntry.TestField(
                      "Statement Status", BankAccLedgEntry."Statement Status"::"Check Entry Applied");
                    BankAccLedgEntry.TestField("Statement No.", '');
                    BankAccLedgEntry.TestField("Statement Line No.", 0);
                    BankAccLedgEntry."Remaining Amount" :=
                      BankAccLedgEntry."Remaining Amount" + CheckLedgEntry.Amount;
                    if BankAccLedgEntry."Remaining Amount" = 0 then begin
                        BankAccLedgEntry.Open := false;
                        BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Closed;
                        BankAccLedgEntry."Statement No." := PostedStamentNo;
                        BankAccLedgEntry."Statement Line No." := CheckLedgEntry."Statement Line No.";
                    end else begin
                        CheckLedgEntry2.Reset();
                        CheckLedgEntry2.SetCurrentKey("Bank Account Ledger Entry No.");
                        CheckLedgEntry2.SetRange("Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
                        CheckLedgEntry2.SetRange(Open, true);
                        CheckLedgEntry2.SetRange("Check Type", CheckLedgEntry2."Check Type"::"Partial Check");
                        CheckLedgEntry2.SetRange(
                          "Statement Status", CheckLedgEntry2."Statement Status"::"Check Entry Applied");
                        if not CheckLedgEntry2.FindFirst() then
                            BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Open;
                    end;
                    BankAccLedgEntry.Modify();
                until CheckLedgEntry.Next() = 0;
        end;

        local procedure PostPaymentApplications(BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal)
        var
            BankAccReconciliation: Record "Bank Acc. Reconciliation";
            CurrExchRate: Record "Currency Exchange Rate";
            AppliedPmtEntry: Record "Applied Payment Entry";
            BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
            DimensionManagement: Codeunit DimensionManagement;
            PaymentLineAmount: Decimal;
            RemainingAmount: Decimal;
            IsApplied: Boolean;
            IsHandled: Boolean;
        begin
            IsHandled := false;
            OnBeforePostPaymentApplications(BankAccReconLine, AppliedAmount, IsHandled);
            if IsHandled then
                exit;

            if BankAccReconLine.IsTransactionPostedAndReconciled then
                Error(TransactionAlreadyReconciledErr, BankAccReconLine."Transaction Date", BankAccReconLine."Transaction Text");

            OnPostPaymentApplicationsOnAfterTransactionPostedAndReconciledCheck(BankAccReconLine, AppliedAmount, SourceCode);
            with GenJnlLine do begin
                if BankAccReconLine."Account No." = '' then
                    Error(LineNoTAppliedErr, BankAccReconLine."Transaction Date", BankAccReconLine."Transaction Text");
                BankAcc.Get(BankAccReconLine."Bank Account No.");

                Init();
                SetSuppressCommit(true);
                "Document Type" := "Document Type"::Payment;

                if IsRefund(BankAccReconLine) then
                    if BankAccReconLine."Account Type" = BankAccReconLine."Account Type"::Employee then
                        "Document Type" := "Document Type"::" "
                    else
                        "Document Type" := "Document Type"::Refund;

                "Posting Date" := BankAccReconLine."Transaction Date";
                "Account Type" := "Gen. Journal Account Type".FromInteger(BankAccReconLine.GetAppliedToAccountType());
                BankAccReconciliation.Get(
                  BankAccReconLine."Statement Type", BankAccReconLine."Bank Account No.", BankAccReconLine."Statement No.");
                "Copy VAT Setup to Jnl. Lines" := BankAccReconciliation."Copy VAT Setup to Jnl. Line";
                Validate("Account No.", BankAccReconLine.GetAppliedToAccountNo);
                "Dimension Set ID" := BankAccReconLine."Dimension Set ID";
                DimensionManagement.UpdateGlobalDimFromDimSetID(
                  BankAccReconLine."Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

                Description := BankAccReconLine.GetDescription();

                "Document No." := PostedStamentNo;
                "Bal. Account Type" := "Bal. Account Type"::"Bank Account";
                "Bal. Account No." := BankAcc."No.";

                "Source Code" := SourceCode;
                "Allow Zero-Amount Posting" := true;

                "Applies-to ID" := BankAccReconLine.GetAppliesToID();
                if GLSetup."Journal Templ. Name Mandatory" then begin
                    GLSetup.TestField("Bank Acc. Recon. Template Name");
                    GLSetup.TestField("Bank Acc. Recon. Batch Name");
                    "Journal Template Name" := GLSetup."Bank Acc. Recon. Template Name";
                    "Journal Batch Name" := GLSetup."Bank Acc. Recon. Batch Name";
                end;
            end;

            OnPostPaymentApplicationsOnAfterInitGenJnlLine(GenJnlLine, BankAccReconLine);

            IsApplied := false;
            with AppliedPmtEntry do
                if AppliedPmtEntryLinesExist(BankAccReconLine) then
                    repeat
                        AppliedAmount += "Applied Amount" - "Applied Pmt. Discount";
                        PaymentLineAmount += "Applied Amount" - "Applied Pmt. Discount";
                        TestField("Account Type", BankAccReconLine."Account Type");
                        TestField("Account No.", BankAccReconLine."Account No.");
                        if "Applies-to Entry No." <> 0 then begin
                            case "Account Type" of
                                "Account Type"::Customer:
                                    ApplyCustLedgEntry(
                                      AppliedPmtEntry, GenJnlLine."Applies-to ID", GenJnlLine."Posting Date", 0D, 0D, "Applied Pmt. Discount");
                                "Account Type"::Vendor:
                                    ApplyVendLedgEntry(
                                      AppliedPmtEntry, GenJnlLine."Applies-to ID", GenJnlLine."Posting Date", 0D, 0D, "Applied Pmt. Discount");
                                "Account Type"::Employee:
                                    ApplyEmployeeLedgEntry(
                                      AppliedPmtEntry, GenJnlLine."Applies-to ID", GenJnlLine."Posting Date", 0D, 0D, "Applied Pmt. Discount");
                                "Account Type"::"Bank Account":
                                    begin
                                        BankAccountLedgerEntry.Get("Applies-to Entry No.");
                                        RemainingAmount := BankAccountLedgerEntry."Remaining Amount";
                                        case true of
                                            RemainingAmount = "Applied Amount":
                                                begin
                                                    if not PostPaymentsOnly then
                                                        CloseBankAccountLedgerEntry("Applies-to Entry No.", "Applied Amount");
                                                    PaymentLineAmount -= "Applied Amount";
                                                end;
                                            Abs(RemainingAmount) > Abs("Applied Amount"):
                                                begin
                                                    if not PostPaymentsOnly then begin
                                                        BankAccountLedgerEntry."Remaining Amount" -= "Applied Amount";
                                                        BankAccountLedgerEntry.Modify();
                                                    end;
                                                    PaymentLineAmount -= "Applied Amount";
                                                end;
                                            Abs(RemainingAmount) < Abs("Applied Amount"):
                                                begin
                                                    if not PostPaymentsOnly then
                                                        CloseBankAccountLedgerEntry("Applies-to Entry No.", RemainingAmount);
                                                    PaymentLineAmount -= RemainingAmount;
                                                end;
                                        end;
                                    end;
                                else
                                    OnPostPaymentApplicationsOnAccountTypeCaseElse(AppliedPmtEntry, GenJnlLine);
                            end;
                            IsApplied := true;
                        end;
                    until Next() = 0;

            if PaymentLineAmount <> 0 then begin
                if not IsApplied then
                    GenJnlLine."Applies-to ID" := '';
                if (GenJnlLine."Account Type" <> GenJnlLine."Account Type"::"Bank Account") or
                   (GenJnlLine."Currency Code" = BankAcc."Currency Code")
                then begin
                    GenJnlLine.Validate("Currency Code", BankAcc."Currency Code");
                    GenJnlLine.Amount := -PaymentLineAmount;
                    if GenJnlLine."Currency Code" <> '' then
                        GenJnlLine."Amount (LCY)" := Round(
                            CurrExchRate.ExchangeAmtFCYToLCY(
                              GenJnlLine."Posting Date", GenJnlLine."Currency Code",
                              GenJnlLine.Amount, GenJnlLine."Currency Factor"));
                    GenJnlLine.Validate("VAT %");
                    GenJnlLine.Validate("Bal. VAT %")
                end else
                    Error(ExcessiveAmtErr, PaymentLineAmount, GLSetup.GetCurrencyCode(BankAcc."Currency Code"));

                OnPostPaymentApplicationsOnBeforeValidateApplyRequirements(BankAccReconLine, GenJnlLine, AppliedAmount);

                GenJnlLine.ValidateApplyRequirements(GenJnlLine);
                GenJnlPostLine.RunWithCheck(GenJnlLine);
                OnPostPaymentApplicationsOnAfterPostGenJnlLine(GenJnlLine, GenJnlPostLine);
                if not PostPaymentsOnly then begin
                    BankAccountLedgerEntry.SetRange(Open, true);
                    BankAccountLedgerEntry.SetRange("Bank Account No.", BankAcc."No.");
                    BankAccountLedgerEntry.SetRange("Document Type", GenJnlLine."Document Type");
                    BankAccountLedgerEntry.SetRange("Document No.", PostedStamentNo);
                    BankAccountLedgerEntry.SetRange("Posting Date", GenJnlLine."Posting Date");
                    OnPostPaymentApplicationsOnAfterBankAccountLedgerEntrySetFilters(BankAccountLedgerEntry, GenJnlLine);
                    if BankAccountLedgerEntry.FindLast() then begin
                        BankAccountLedgerEntry."Statement No." := PostedStamentNo;
                        BankAccountLedgerEntry."Statement Line No." := BankAccReconLine."Statement Line No.";
                        BankAccountLedgerEntry.Modify();
                        CloseBankAccountLedgerEntry(BankAccountLedgerEntry."Entry No.", BankAccountLedgerEntry.Amount);
                    end;
                end;
            end;
        end;

        local procedure UpdateBank(BankAccRecon: Record "Bank Acc. Reconciliation"; Amt: Decimal)
        begin
            with BankAcc do begin
                LockTable();
                Get(BankAccRecon."Bank Account No.");
                TestField(Blocked, false);
                "Last Statement No." := PostedStamentNo;
                "Balance Last Statement" := BankAccRecon."Balance Last Statement" + Amt;
                Modify;
            end;
        end;

        local procedure TransferToBankStmt(BankAccRecon: Record "Bank Acc. Reconciliation"; PrePostingOutstdPayments: Decimal; PrePostingOutstdBankTransactions: Decimal; PrePostingGLBalance: Decimal; PrePostingTotalPositiveDifference: Decimal; PrePostingTotalNegativeDifference: Decimal)
        var
            BankAccStmt: Record "Bank Account Statement";
            BankAccStmtLine: Record "Bank Account Statement Line";
            BankAccReconLine: Record "Bank Acc. Reconciliation Line";
            IsHandled: Boolean;
        begin
            IsHandled := false;
            OnBeforeTransferToBankStmt(BankAccRecon, IsHandled);
            if IsHandled then
                exit;

            BankAccStmt.Init();
            BankAccStmt.TransferFields(BankAccRecon);
            BankAccStmt."Statement No." := PostedStamentNo;
            if BankAccReconLine.LinesExist(BankAccRecon) then
                repeat
                    BankAccStmtLine.TransferFields(BankAccReconLine);
                    BankAccStmtLine."Statement No." := BankAccStmt."Statement No.";
                    OnTransferToBankStmtOnBeforeBankAccStmtLineInsert(BankAccStmtLine, BankAccReconLine);
                    BankAccStmtLine.Insert();
                    BankAccReconLine.ClearDataExchEntries;
                until BankAccReconLine.Next() = 0;

            BankAccStmtLine.SetRange("Bank Account No.", BankAccStmt."Bank Account No.");
            BankAccStmtLine.SetRange("Statement No.", BankAccStmt."Statement No.");
            BankAccStmtLine.CalcSums("Statement Amount");
            BankAccStmt."G/L Balance at Posting Date" := PrePostingGLBalance;
            BankAccStmt."Outstd. Payments at Posting" := PrePostingOutstdPayments;
            BankAccStmt."Outstd. Transact. at Posting" := PrePostingOutstdBankTransactions;
            BankAccStmt."Total Pos. Diff. at Posting" := PrePostingTotalPositiveDifference;
            BankAccStmt."Total Neg. Diff. at Posting" := PrePostingTotalNegativeDifference;

            OnBeforeBankAccStmtInsert(BankAccStmt, BankAccRecon);
            BankAccStmt.Insert();
        end;

        local procedure GetPostedStamentNo(BankAccRecon: Record "Bank Acc. Reconciliation") StatementNo: Code[20]
        var
            BankAccStmt: Record "Bank Account Statement";
        begin
            StatementNo := BankAccRecon."Statement No.";

            BankAccStmt.SetRange("Bank Account No.", BankAccRecon."Bank Account No.");
            BankAccStmt.SetRange("Statement No.", BankAccRecon."Statement No.");
            if not BankAccStmt.IsEmpty() then
                StatementNo := GetNextStatementNoAndUpdateBankAccount(BankAccRecon."Bank Account No.");
        end;

        local procedure TransferToPostPmtAppln(BankAccRecon: Record "Bank Acc. Reconciliation")
        var
            PostedPmtReconHdr: Record "Posted Payment Recon. Hdr";
            PostedPmtReconLine: Record "Posted Payment Recon. Line";
            BankAccReconLine: Record "Bank Acc. Reconciliation Line";
            TypeHelper: Codeunit "Type Helper";
            FieldLength: Integer;
            IsHandled: Boolean;
        begin
            IsHandled := false;
            OnBeforeTransferToPostPmtAppln(BankAccRecon, IsHandled);
            if IsHandled then
                exit;

            if BankAccReconLine.LinesExist(BankAccRecon) then
                repeat
                    PostedPmtReconLine.TransferFields(BankAccReconLine);

                    FieldLength := TypeHelper.GetFieldLength(DATABASE::"Posted Payment Recon. Line",
                        PostedPmtReconLine.FieldNo("Applied Document No."));
                    PostedPmtReconLine."Applied Document No." := CopyStr(BankAccReconLine.GetAppliedToDocumentNo, 1, FieldLength);

                    FieldLength := TypeHelper.GetFieldLength(DATABASE::"Posted Payment Recon. Line",
                        PostedPmtReconLine.FieldNo("Applied Entry No."));
                    PostedPmtReconLine."Applied Entry No." := CopyStr(BankAccReconLine.GetAppliedToEntryNo, 1, FieldLength);

                    PostedPmtReconLine.Reconciled := not PostPaymentsOnly;

                    OnTransferToPostPmtApplnOnBeforePostedPmtReconLineInsert(PostedPmtReconLine, BankAccReconLine);
                    PostedPmtReconLine.Insert();
                    BankAccReconLine.ClearDataExchEntries;
                until BankAccReconLine.Next() = 0;

            PostedPmtReconHdr.TransferFields(BankAccRecon);
            OnBeforePostedPmtReconInsert(PostedPmtReconHdr, BankAccRecon);
            PostedPmtReconHdr.Insert();
        end;

        procedure ApplyCustLedgEntry(AppliedPmtEntry: Record "Applied Payment Entry"; AppliesToID: Code[50]; PostingDate: Date; PmtDiscDueDate: Date; PmtDiscToleranceDate: Date; RemPmtDiscPossible: Decimal)
        var
            CustLedgEntry: Record "Cust. Ledger Entry";
            CurrExchRate: Record "Currency Exchange Rate";
        begin
            with CustLedgEntry do begin
                Get(AppliedPmtEntry."Applies-to Entry No.");
                TestField(Open);
                BankAcc.Get(AppliedPmtEntry."Bank Account No.");
                if AppliesToID = '' then begin
                    "Pmt. Discount Date" := PmtDiscDueDate;
                    "Pmt. Disc. Tolerance Date" := PmtDiscToleranceDate;

                    "Remaining Pmt. Disc. Possible" := RemPmtDiscPossible;
                    if BankAcc.IsInLocalCurrency then
                        "Remaining Pmt. Disc. Possible" :=
                          CurrExchRate.ExchangeAmount("Remaining Pmt. Disc. Possible", '', "Currency Code", PostingDate);
                end else begin
                    "Applies-to ID" := AppliesToID;
                    "Amount to Apply" := AppliedPmtEntry.CalcAmountToApply(PostingDate);
                end;

                if PreviewMode then
                    CustEntryEditNoCommit(CustLedgEntry)
                else
                    CODEUNIT.Run(CODEUNIT::"Cust. Entry-Edit", CustLedgEntry);
            end;
        end;

        [CommitBehavior(CommitBehavior::Ignore)]
        local procedure CustEntryEditNoCommit(var CustLedgerEntry: Record "Cust. Ledger Entry")
        begin
            CODEUNIT.Run(CODEUNIT::"Cust. Entry-Edit", CustLedgerEntry);
        end;

        procedure ApplyVendLedgEntry(AppliedPmtEntry: Record "Applied Payment Entry"; AppliesToID: Code[50]; PostingDate: Date; PmtDiscDueDate: Date; PmtDiscToleranceDate: Date; RemPmtDiscPossible: Decimal)
        var
            VendLedgEntry: Record "Vendor Ledger Entry";
            CurrExchRate: Record "Currency Exchange Rate";
            BankRec1: page 379;
        begin
            with VendLedgEntry do begin
                Get(AppliedPmtEntry."Applies-to Entry No.");
                TestField(Open);
                BankAcc.Get(AppliedPmtEntry."Bank Account No.");
                if AppliesToID = '' then begin
                    "Pmt. Discount Date" := PmtDiscDueDate;
                    "Pmt. Disc. Tolerance Date" := PmtDiscToleranceDate;

                    "Remaining Pmt. Disc. Possible" := RemPmtDiscPossible;
                    if BankAcc.IsInLocalCurrency then
                        "Remaining Pmt. Disc. Possible" :=
                          CurrExchRate.ExchangeAmount("Remaining Pmt. Disc. Possible", '', "Currency Code", PostingDate);
                end else begin
                    "Applies-to ID" := AppliesToID;
                    "Amount to Apply" := AppliedPmtEntry.CalcAmountToApply(PostingDate);
                end;

                if PreviewMode then
                    VendEntryEditNoCommit(VendLedgEntry)
                else
                    CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);
            end;
        end;

        [CommitBehavior(CommitBehavior::Ignore)]
        local procedure VendEntryEditNoCommit(var VendorLedgerEntry: Record "Vendor Ledger Entry")
        begin
            CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", VendorLedgerEntry);
        end;

        procedure ApplyEmployeeLedgEntry(AppliedPmtEntry: Record "Applied Payment Entry"; AppliesToID: Code[50]; PostingDate: Date; PmtDiscDueDate: Date; PmtDiscToleranceDate: Date; RemPmtDiscPossible: Decimal)
        var
            EmployeeLedgerEntry: Record "Employee Ledger Entry";
        begin
            with EmployeeLedgerEntry do begin
                Get(AppliedPmtEntry."Applies-to Entry No.");
                TestField(Open);
                BankAcc.Get(AppliedPmtEntry."Bank Account No.");
                if AppliesToID <> '' then begin
                    "Applies-to ID" := AppliesToID;
                    "Amount to Apply" := AppliedPmtEntry.CalcAmountToApply(PostingDate);
                end;

                if PreviewMode then
                    EmplEntryEditNoCommit(EmployeeLedgerEntry)
                else
                    CODEUNIT.Run(CODEUNIT::"Empl. Entry-Edit", EmployeeLedgerEntry);
            end;
        end;

        [CommitBehavior(CommitBehavior::Ignore)]
        local procedure EmplEntryEditNoCommit(var EmployeeLedgerEntry: Record "Employee Ledger Entry")
        begin
            CODEUNIT.Run(CODEUNIT::"Empl. Entry-Edit", EmployeeLedgerEntry);
        end;

        local procedure CloseBankAccountLedgerEntry(EntryNo: Integer; AppliedAmount: Decimal)
        var
            BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
            CheckLedgerEntry: Record "Check Ledger Entry";
        begin
            with BankAccountLedgerEntry do begin
                Get(EntryNo);
                TestField(Open);
                TestField("Remaining Amount", AppliedAmount);
                "Remaining Amount" := 0;
                Open := false;
                "Statement Status" := "Statement Status"::Closed;
                Modify;

                CheckLedgerEntry.Reset();
                CheckLedgerEntry.SetCurrentKey("Bank Account Ledger Entry No.");
                CheckLedgerEntry.SetRange(
                  "Bank Account Ledger Entry No.", "Entry No.");
                CheckLedgerEntry.SetRange(Open, true);
                if CheckLedgerEntry.FindSet() then
                    repeat
                        CheckLedgerEntry.Open := false;
                        CheckLedgerEntry."Statement Status" := CheckLedgerEntry."Statement Status"::Closed;
                        CheckLedgerEntry.Modify();
                    until CheckLedgerEntry.Next() = 0;
            end;
        end;

        local procedure GetNextStatementNoAndUpdateBankAccount(BankAccountNo: Code[20]): Code[20]
        var
            BankAccount: Record "Bank Account";
        begin
            with BankAccount do begin
                SetLoadFields("Last Statement No.");
                Get(BankAccountNo);
                if "Last Statement No." <> '' then
                    "Last Statement No." := IncStr("Last Statement No.")
                else
                    "Last Statement No." := '1';
                Modify;
            end;
            exit(BankAccount."Last Statement No.");
        end;

        local procedure IsRefund(BankAccReconLine: Record "Bank Acc. Reconciliation Line"): Boolean
        begin
            with BankAccReconLine do
                if ("Account Type" = "Account Type"::Customer) and ("Statement Amount" < 0) or
                   ("Account Type" in ["Account Type"::Vendor, "Account Type"::Employee]) and ("Statement Amount" > 0)
                then
                    exit(true);
            exit(false);
        end;

        procedure Preview(var BankAccReconciliationSource: Record "Bank Acc. Reconciliation")
        var
            BankAccReconPostPreview: Codeunit "Bank. Acc. Recon. Post Preview";
            BankAccountReconciliationPost: Codeunit "Bank Acc. Reconciliation Post";
        begin
            BankAccReconPostPreview.Preview(BankAccountReconciliationPost, BankAccReconciliationSource);
        end;

        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank. Acc. Recon. Post Preview", 'OnRunPreview', '', false, false)]
        local procedure OnRunPreview(var Result: Boolean; var Subscriber: Codeunit "Bank Acc. Reconciliation Post"; var BankAccReconciliationSource: Record "Bank Acc. Reconciliation")
        var
            BankAccReconciliation: Record "Bank Acc. Reconciliation";
            BankAccountReconciliationPost: Codeunit "Bank Acc. Reconciliation Post";
        begin
            BankAccountReconciliationPost := Subscriber;
            BankAccReconciliation.Copy(BankAccReconciliationSource);
            Result := not BankAccountReconciliationPost.RunPreview(BankAccReconciliation);
        end;

        [IntegrationEvent(false, false)]
        local procedure OnBeforeAppliedAmountCheck(var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal)
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnBeforeBankAccStmtInsert(var BankAccStatement: Record "Bank Account Statement"; BankAccReconciliation: Record "Bank Acc. Reconciliation")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnBeforeCloseBankAccLedgEntry(var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal; var IsHandled: Boolean)
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnBeforeFinalizePost(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnBeforePostPaymentApplications(BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal; var IsHandled: Boolean)
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnAfterFinalizePost(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnBeforeInitPost(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnBeforePost(var BankAccReconciliation: Record "Bank Acc. Reconciliation"; var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnBeforePostedPmtReconInsert(var PostedPaymentReconHdr: Record "Posted Payment Recon. Hdr"; BankAccReconciliation: Record "Bank Acc. Reconciliation")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnBeforeTransferToPostPmtAppln(var BankAccReconciliation: Record "Bank Acc. Reconciliation"; var IsHandled: Boolean)
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnBeforeTransferToBankStmt(var BankAccRecon: Record "Bank Acc. Reconciliation"; var IsHandled: Boolean)
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnCheckLinesMatchEndingBalanceOnAfterCalcSums(var BankAccReconLine: Record "Bank Acc. Reconciliation Line")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnCloseBankAccLedgEntryOnBeforeBankAccLedgEntryModify(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnCloseBankAccLedgEntryOnAfterBankAccLedgEntrySetFilters(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnBeforeHandlePaymentApplicationTransfer(var BankAccRecon: Record "Bank Acc. Reconciliation"; var IsHandled: Boolean)
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnPostPaymentApplicationsOnAfterInitGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnPostPaymentApplicationsOnAfterPostGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnPostPaymentApplicationsOnAfterBankAccountLedgerEntrySetFilters(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnPostPaymentApplicationsOnAfterTransactionPostedAndReconciledCheck(BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal; SourceCode: Code[10])
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnPostPaymentApplicationsOnBeforeValidateApplyRequirements(var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; var GenJournalLine: Record "Gen. Journal Line"; AppliedAmount: Decimal)
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnPostPaymentApplicationsOnAccountTypeCaseElse(var AppliedPaymentEntry: Record "Applied Payment Entry"; var GenJournalLine: Record "Gen. Journal Line")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnPostAfterFilterBankAccRecLines(var BankAccReconLines: Record "Bank Acc. Reconciliation Line"; BankAccRecon: Record "Bank Acc. Reconciliation")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnTransferToBankStmtOnBeforeBankAccStmtLineInsert(var BankAccStmtLine: Record "Bank Account Statement Line"; BankAccReconLine: Record "Bank Acc. Reconciliation Line")
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnTransferToPostPmtApplnOnBeforePostedPmtReconLineInsert(var PostedPmtReconLine: Record "Posted Payment Recon. Line"; BankAccReconLine: Record "Bank Acc. Reconciliation Line")
        begin
        end;



        local procedure GetNextStatementNo(BankAccReconciliation: Record "Bank Acc. Reconciliation"): Code[20]
        var
            NextStatementNo: Code[20];
            BankAcc: Record "Bank Account";
        begin
            // Generate a unique statement number
            BankAcc.Get(BankAccReconciliation."Bank Account No.");
            // BankAcc."Last Statement Date" := BankAccReconciliation."Statement Date";
            BankAcc.Modify();

            if BankAccReconciliation."Statement Type" = BankAccReconciliation."Statement Type"::"Payment Application" then begin
                SetLastPaymentStatementNo(BankAcc);
                NextStatementNo := IncStr(BankAcc."Last Payment Statement No.");
            end else begin
                SetLastStatementNo(BankAcc);
                NextStatementNo := IncStr(BankAcc."Last Statement No.");


            end;

            BankAccReconciliation."Balance Last Statement" := BankAcc."Balance Last Statement";

            // NextStatementNo :=
            //     Format(BankAccReconciliation."Bank Account No.") +
            //     Format(Today(), 0, '<Year4><Month,2><Day,2>') +
            //     Format(Time(), 0, '<Hours24,2><Minutes,2>');

            exit(NextStatementNo);
        end;

        procedure SetLastPaymentStatementNo(var BankAccount: Record "Bank Account")
        var
            BankAccReconciliation: Record "Bank Acc. Reconciliation";
        begin
            if BankAccount."Last Payment Statement No." = '' then begin
                BankAccReconciliation.SetRange("Bank Account No.", BankAccount."No.");
                BankAccReconciliation.SetRange("Statement Type", BankAccReconciliation."Statement Type"::"Payment Application");
                if BankAccReconciliation.FindLast() then begin
                    BankAccount."Last Payment Statement No." := IncStr(BankAccReconciliation."Statement No.");
                    //BankAccount."Last Statement Date" := BankAccReconciliation."Statement Date";
                end else
                    BankAccount."Last Payment Statement No." := '0';
                // BankAccount."Last Statement Date" := BankAccReconciliation."Statement Date";

                BankAccount.Modify();
            end;
        end;



        procedure SetLastStatementNo(var BankAccount: Record "Bank Account")
        begin
            if BankAccount."Last Statement No." = '' then begin
                BankAccount."Last Statement No." := '0';
                BankAccount.Modify();
            end;
        end;




        local procedure GetNextLineNo(BankAccReconciliation: Record "Bank Acc. Reconciliation"): Integer
        var
            BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        begin
            // Find the next available line number
            BankAccReconciliationLine.SetRange("Bank Account No.", BankAccReconciliation."Bank Account No.");
            BankAccReconciliationLine.SetRange("Statement No.", BankAccReconciliation."Statement No.");

            if BankAccReconciliationLine.FindLast() then
                exit(BankAccReconciliationLine."Statement Line No." + 10000)
            else
                exit(10000);
        end;


        [IntegrationEvent(false, false)]
        local procedure OnBeforeBankAccReconPostYesNo(var BankAccReconciliation: Record "Bank Acc. Reconciliation"; var Result: Boolean; var Handled: Boolean)
        begin
        end;

        [IntegrationEvent(false, false)]
        local procedure OnAfterHandleUnreconciledLines(var OriginalBankAccReconciliation: Record "Bank Acc. Reconciliation"; var NewBankAccReconciliation: Record "Bank Acc. Reconciliation")
        begin
        end;



        procedure ArchiveBankReconciliation(BankReconciliation: Record "Bank Acc. Reconciliation")
        var
            BankRecArchiveHeader: Record "Bank Rec. Archive Header";
            BankRecArchiveLine: Record "Bank Rec. Archive Line";
            BankRecLine: Record "Bank Acc. Reconciliation Line";
            noseries: Codeunit NoSeriesManagement;
            Nextno: Code[20];
            ArchiveBankRec: Record "ArchiveBank LedgerEntries(Rec)";
            BankLedgerEntry: Record "Bank Account Ledger Entry";
        begin


            // Create Archive Header
            BankRecArchiveHeader.Reset();
            BankRecArchiveHeader.SetRange("Bank Account No.", BankReconciliation."Bank Account No.");
            BankRecArchiveHeader.SetRange("Statement No.", BankReconciliation."Statement No.");

            if not BankRecArchiveHeader.FindSet() then begin
                Nextno := noseries.GetNextNo('BankRec', Today, true);
                BankRecArchiveHeader.Init();
                BankRecArchiveHeader."No." := Nextno;
                BankRecArchiveHeader."Bank Account No." := BankReconciliation."Bank Account No.";
                BankRecArchiveHeader."Statement Date" := BankReconciliation."Statement Date";
                BankRecArchiveHeader."Statement Ending Balance" := BankReconciliation."Statement Ending Balance";
                BankRecArchiveHeader."Statement Starting Balance" := BankReconciliation."Balance Last Statement";

                BankRecArchiveHeader."Statement No." := BankReconciliation."Statement No.";
                BankRecArchiveHeader."Total Difference" := BankReconciliation."Total Difference";
                BankRecArchiveHeader."User ID" := UserId();
                BankRecArchiveHeader."Archive Date" := Today();
                BankRecArchiveHeader.Insert(true);


                // Archive Reconciliation Lines
                BankRecLine.Reset();
                BankRecLine.SetRange("Bank Account No.", BankReconciliation."Bank Account No.");
                BankRecLine.SetRange("Statement No.", BankReconciliation."Statement No.");

                if BankRecLine.FindSet() then begin
                    repeat
                        BankRecArchiveLine.Init();
                        BankRecArchiveLine."Archive Header No." := BankRecArchiveHeader."No.";
                        BankRecArchiveLine."Line No." := GetArchiveLastLineNo() + 1;
                        BankRecArchiveLine."Statement Type" := BankRecLine."Statement Type";
                        BankRecArchiveLine."Transaction Date" := BankRecLine."Transaction Date";
                        BankRecArchiveLine."Document No." := BankRecLine."Document No.";
                        BankRecArchiveLine."Bank Account No." := BankRecLine."Bank Account No.";
                        BankRecArchiveLine."Statement No." := BankRecLine."Statement No.";
                        BankRecArchiveLine.Type := BankRecLine.Type;
                        BankRecArchiveLine."Applied Amount" := BankRecLine."Applied Amount";
                        BankRecArchiveLine.Difference := BankRecLine.Difference;
                        BankRecArchiveLine."Archive Date" := Today();


                        BankRecArchiveLine.Amount := BankRecLine."Statement Amount";
                        BankRecArchiveLine."Reference No." := BankRecLine."Reference No";
                        BankRecArchiveLine."Description" := BankRecLine."Description";
                        BankRecArchiveLine."Credit Amount" := BankRecLine."Credit Amount";
                        BankRecArchiveLine."Debit Amount" := BankRecLine."Debit Amount";
                        BankRecArchiveLine.Insert(true);
                    until BankRecLine.Next() = 0;
                end;

                // Archive Bank Account Ledger Entries
                BankLedgerEntry.Reset();
                BankLedgerEntry.SetRange("Bank Account No.", BankReconciliation."Bank Account No.");
                BankLedgerEntry.SetRange("Statement No.", BankReconciliation."Statement No.");
                BankLedgerEntry.SetRange(Reversed, false);


                if BankLedgerEntry.FindSet() then begin
                    repeat
                        ArchiveBankRec.Init();
                        ArchiveBankRec."Entry No" := BankLedgerEntry."Entry No.";
                        ArchiveBankRec."Archive Header No." := BankRecArchiveHeader."No.";
                        ArchiveBankRec."Archive Entry No." := getlastarchiveebntryNo() + 1;

                        ArchiveBankRec."Bank Account No" := BankLedgerEntry."Bank Account No.";
                        ArchiveBankRec."Statement No" := BankReconciliation."Statement No.";
                        ArchiveBankRec."Statement Line No" := BankLedgerEntry."Statement Line No.";
                        ArchiveBankRec."Posting Date" := BankLedgerEntry."Posting Date";
                        ArchiveBankRec."Document Type" := BankLedgerEntry."Document Type";
                        ArchiveBankRec."Document No" := BankLedgerEntry."Document No.";
                        ArchiveBankRec."Statement Status" := BankLedgerEntry."Statement Status";
                        ArchiveBankRec.Descrption := BankLedgerEntry."Description";
                        ArchiveBankRec."Credit Amount" := BankLedgerEntry."Credit Amount";
                        ArchiveBankRec."Debit Amount" := BankLedgerEntry."Debit Amount";
                        ArchiveBankRec.Reversed := BankLedgerEntry.Reversed;
                        ArchiveBankRec.Remarks := BankLedgerEntry.Remarks;
                        ArchiveBankRec."Statement Difference" := BankLedgerEntry."Statement Difference";
                        ArchiveBankRec."Amount" := BankLedgerEntry."Amount";
                        ArchiveBankRec."Remaining Amount" := BankLedgerEntry."Remaining Amount";
                        ArchiveBankRec.Open := BankLedgerEntry.Open;
                        ArchiveBankRec."External Document No." := BankLedgerEntry."External Document No.";
                        ArchiveBankRec."User ID" := BankLedgerEntry."User ID";
                        ArchiveBankRec."Archive Date" := Today();
                        ArchiveBankRec.Insert(true);
                    until BankLedgerEntry.Next() = 0;
                end;
            end;
        end;








        procedure CleanupOldArchives(RetentionDays: Integer)
        var
            BankRecArchiveHeader: Record "Bank Rec. Archive Header";
        begin
            // Remove archives older than specified retention period
            BankRecArchiveHeader.SetFilter("Archive Date", '<=%1', CalcDate('-' + Format(RetentionDays) + 'D', Today()));

            if BankRecArchiveHeader.FindSet() then
                repeat
                    // Delete associated lines first
                    DeleteArchiveLines(BankRecArchiveHeader."No.");

                    // Then delete the header
                    BankRecArchiveHeader.Delete(true);
                until BankRecArchiveHeader.Next() = 0;
        end;

        local procedure DeleteArchiveLines(ArchiveHeaderNo: Code[20])
        var
            BankRecArchiveLine: Record "Bank Rec. Archive Line";
        begin
            BankRecArchiveLine.SetRange("Archive Header No.", ArchiveHeaderNo);
            if BankRecArchiveLine.FindSet() then
                BankRecArchiveLine.DeleteAll(true);
        end;

        // Hook to call archiving after successful reconciliation
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"bank Reconciliation Management", 'OnAfterFinalizePost', '', false, false)]
        local procedure AutoArchiveOnPostBankReconciliation(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
        begin
            // Archive the reconciliation automatically after posting
            ArchiveBankReconciliation(BankAccReconciliation);
        end;

        procedure GetArchiveLastLineNo(): Integer
        var
            BankRecArchiveLine: Record "Bank Rec. Archive Line";
        begin
            BankRecArchiveLine.reset;

            if BankRecArchiveLine.findlast() then
                exit(BankRecArchiveLine."Line No.");
            exit(0);
        end;

        procedure UpdateArchiveOpenStatus(BankReconciliation: Record "Bank Acc. Reconciliation")
        var
            ArchiveBankRec: Record "ArchiveBank LedgerEntries(Rec)";
            BankLedgerEntry: Record "Bank Account Ledger Entry";
            BankRecArchiveHeader: Record "Bank Rec. Archive Header";
        begin
            // Find the archive header for this reconciliation
            BankRecArchiveHeader.Reset();
            BankRecArchiveHeader.SetRange("Bank Account No.", BankReconciliation."Bank Account No.");
            BankRecArchiveHeader.SetRange("Statement No.", BankReconciliation."Statement No.");

            if BankRecArchiveHeader.FindFirst() then begin
                // Update archived entries with current open status from bank ledger entries
                ArchiveBankRec.Reset();
                ArchiveBankRec.SetRange("Archive Header No.", BankRecArchiveHeader."No.");
                ArchiveBankRec.SetRange("Bank Account No", BankReconciliation."Bank Account No.");

                if ArchiveBankRec.FindSet(true) then begin
                    repeat
                        // Get the current status from Bank Account Ledger Entry
                        BankLedgerEntry.Reset();
                        if BankLedgerEntry.Get(ArchiveBankRec."Entry No") then begin
                            // Update the archive with current open status and statement status
                            ArchiveBankRec.Open := BankLedgerEntry.Open;
                            ArchiveBankRec."Statement Status" := BankLedgerEntry."Statement Status";
                            ArchiveBankRec."Remaining Amount" := BankLedgerEntry."Remaining Amount";

                            // Add posting information to remarks
                            if ArchiveBankRec.Remarks = '' then
                                ArchiveBankRec.Remarks := 'Updated after posting Recon: ' + BankReconciliation."Statement No."
                            else
                                ArchiveBankRec.Remarks := ArchiveBankRec.Remarks + '; Updated after posting Recon: ' + BankReconciliation."Statement No.";

                            ArchiveBankRec.Modify(true);
                        end;
                    until ArchiveBankRec.Next() = 0;
                end;
            end;
        end;

        local procedure getlastarchiveebntryNo(): Integer
        var
            BankRecArchiveLine: Record "ArchiveBank LedgerEntries(Rec)";
        begin
            BankRecArchiveLine.Reset();
            if BankRecArchiveLine.FindLast() then
                exit(BankRecArchiveLine."Archive Entry No.")
            else
                exit(0);


        end;*/

}
