codeunit 50112 "General. Jnl.-Post Line"
{
    Permissions = TableData 17 = imd,
                  TableData 21 = imd,
                  TableData 25 = imd,
                  TableData 45 = imd,
                  TableData 253 = rimd,
                  TableData 254 = imd,
                  TableData 271 = imd,
                  TableData 272 = imd,
                  TableData 379 = imd,
                  TableData 380 = imd,
                  TableData 1053 = rim,
                  TableData 5222 = imd,
                  TableData 5223 = imd,
                  TableData 5601 = rimd,
                  TableData 5617 = imd,
                  TableData 5625 = rimd;
    TableNo = 81;

    /*trigger OnRun()
    begin
        GetGLSetup;
        RunWithCheck(Rec);
    end;

    var
        NeedsRoundingErr: Label '%1 needs to be rounded';
        PurchaseAlreadyExistsErr: Label 'Purchase %1 %2 already exists for this vendor.', Comment = '%1 = Document Type; %2 = Document No.';
        BankPaymentTypeMustNotBeFilledErr: Label 'Bank Payment Type must not be filled if Currency Code is different in Gen. Journal Line and Bank Account.';
        DocNoMustBeEnteredErr: Label 'Document No. must be entered when Bank Payment Type is %1.';
        CheckAlreadyExistsErr: Label 'Check %1 already exists for this Bank Account.';
        GLSetup: Record "98";
        GlobalGLEntry: Record "17";
        TempGLEntryBuf: Record "17" temporary;
        TempGLEntryVAT: Record "17" temporary;
        GLReg: Record "45";
        AddCurrency: Record "4";
        CurrExchRate: Record "330";
        VATEntry: Record "254";
        TaxDetail: Record "322";
        UnrealizedCustLedgEntry: Record "21";
        UnrealizedVendLedgEntry: Record "25";
        GLEntryVATEntryLink: Record "253";
        TempVATEntry: Record "254" temporary;
        GenJnlCheckLine: Codeunit "11";
        PaymentToleranceMgt: Codeunit "426";
        DeferralUtilities: Codeunit "1720";
        DeferralDocType: Option Purchase,Sales,"G/L";
        LastDocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder;
        AddCurrencyCode: Code[10];
        GLSourceCode: Code[10];
        LastDocNo: Code[20];
        FiscalYearStartDate: Date;
        CurrencyDate: Date;
        LastDate: Date;
        BalanceCheckAmount: Decimal;
        BalanceCheckAmount2: Decimal;
        BalanceCheckAddCurrAmount: Decimal;
        BalanceCheckAddCurrAmount2: Decimal;
        CurrentBalance: Decimal;
        TotalAddCurrAmount: Decimal;
        TotalAmount: Decimal;
        UnrealizedRemainingAmountCust: Decimal;
        UnrealizedRemainingAmountVend: Decimal;
        AmountRoundingPrecision: Decimal;
        AddCurrGLEntryVATAmt: Decimal;
        CurrencyFactor: Decimal;
        FirstEntryNo: Integer;
        NextEntryNo: Integer;
        NextVATEntryNo: Integer;
        FirstNewVATEntryNo: Integer;
        FirstTransactionNo: Integer;
        NextTransactionNo: Integer;
        NextConnectionNo: Integer;
        NextCheckEntryNo: Integer;
        InsertedTempGLEntryVAT: Integer;
        GLEntryNo: Integer;
        UseCurrFactorOnly: Boolean;
        NonAddCurrCodeOccured: Boolean;
        FADimAlreadyChecked: Boolean;
        ResidualRoundingErr: Label 'Residual caused by rounding of %1';
        DimensionUsedErr: Label 'A dimension used in %1 %2, %3, %4 has caused an error. %5.', Comment = 'Comment';
        OverrideDimErr: Boolean;
        JobLine: Boolean;
        CheckUnrealizedCust: Boolean;
        CheckUnrealizedVend: Boolean;
        GLSetupRead: Boolean;
        InvalidPostingDateErr: Label '%1 is not within the range of posting dates for your company.', Comment = '%1=The date passed in for the posting date.';
        DescriptionMustNotBeBlankErr: Label 'When %1 is selected for %2, %3 must have a value.', Comment = '%1: Field Omit Default Descr. in Jnl., %2 G/L Account No, %3 Description';
        NoDeferralScheduleErr: Label 'You must create a deferral schedule if a deferral template is selected. Line: %1, Deferral Template: %2.', Comment = '%1=The line number of the general ledger transaction, %2=The Deferral Template Code';
        ZeroDeferralAmtErr: Label 'Deferral amounts cannot be 0. Line: %1, Deferral Template: %2.', Comment = '%1=The line number of the general ledger transaction, %2=The Deferral Template Code';
        IsGLRegInserted: Boolean;

    procedure GetGLReg(var NewGLReg: Record "45")
    begin
        NewGLReg := GLReg;
    end;

    procedure RunWithCheck(var GenJnlLine2: Record "81"): Integer
    var
        GenJnlLine: Record "81";
    begin
        GenJnlLine.COPY(GenJnlLine2);
        Code(GenJnlLine, TRUE);
        OnAfterRunWithCheck(GenJnlLine);
        GenJnlLine2 := GenJnlLine;
        EXIT(GLEntryNo);
    end;

    [Scope('Internal')]
    procedure RunWithoutCheck(var GenJnlLine2: Record "81"): Integer
    var
        GenJnlLine: Record "81";
    begin
        GenJnlLine.COPY(GenJnlLine2);
        Code(GenJnlLine, FALSE);
        OnAfterRunWithoutCheck(GenJnlLine);
        GenJnlLine2 := GenJnlLine;
        EXIT(GLEntryNo);
    end;

    local procedure "Code"(var GenJnlLine: Record "81"; CheckLine: Boolean)
    var
        Balancing: Boolean;
        IsTransactionConsistent: Boolean;
    begin
        OnBeforeCode(GenJnlLine, CheckLine);

        GetGLSourceCode;

        WITH GenJnlLine DO BEGIN
            IF EmptyLine THEN BEGIN
                InitLastDocDate(GenJnlLine);
                EXIT;
            END;

            IF CheckLine THEN BEGIN
                IF OverrideDimErr THEN
                    GenJnlCheckLine.SetOverDimErr;
                GenJnlCheckLine.RunCheck(GenJnlLine);
            END;

            AmountRoundingPrecision := InitAmounts(GenJnlLine);

            IF "Bill-to/Pay-to No." = '' THEN
                CASE TRUE OF
                    "Account Type" IN ["Account Type"::Customer, "Account Type"::Vendor]:
                        "Bill-to/Pay-to No." := "Account No.";
                    "Bal. Account Type" IN ["Bal. Account Type"::Customer, "Bal. Account Type"::Vendor]:
                        "Bill-to/Pay-to No." := "Bal. Account No.";
                END;
            IF "Document Date" = 0D THEN
                "Document Date" := "Posting Date";
            IF "Due Date" = 0D THEN
                "Due Date" := "Posting Date";

            JobLine := ("Job No." <> '');

            IF NextEntryNo = 0 THEN
                StartPosting(GenJnlLine)
            ELSE
                ContinuePosting(GenJnlLine);

            IF "Account No." <> '' THEN BEGIN
                IF ("Bal. Account No." <> '') AND
                   (NOT "System-Created Entry") AND
                   ("Account Type" IN
                    ["Account Type"::Customer,
                     "Account Type"::Vendor,
                     "Account Type"::"Fixed Asset"])
                THEN BEGIN
                    CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line", GenJnlLine);
                    Balancing := TRUE;
                END;

                PostGenJnlLine(GenJnlLine, Balancing);
            END;

            IF "Bal. Account No." <> '' THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line", GenJnlLine);
                PostGenJnlLine(GenJnlLine, NOT Balancing);
            END;

            CheckPostUnrealizedVAT(GenJnlLine, TRUE);

            CreateDeferralScheduleFromGL(GenJnlLine, Balancing);

            IsTransactionConsistent := FinishPosting;
        END;

        OnAfterGLFinishPosting(GlobalGLEntry, GenJnlLine, IsTransactionConsistent, FirstTransactionNo);
    end;

    local procedure PostGenJnlLine(var GenJnlLine: Record "81"; Balancing: Boolean)
    begin
        OnBeforePostGenJnlLine(GenJnlLine);

        WITH GenJnlLine DO
            CASE "Account Type" OF
                "Account Type"::"G/L Account":
                    PostGLAcc(GenJnlLine, Balancing);
                "Account Type"::Customer:
                    PostCust(GenJnlLine, Balancing);
                "Account Type"::Vendor:
                    PostVend(GenJnlLine, Balancing);
                "Account Type"::Employee:
                    PostEmployee(GenJnlLine);
                "Account Type"::"Bank Account":
                    PostBankAcc(GenJnlLine, Balancing);
                "Account Type"::"Fixed Asset":
                    PostFixedAsset(GenJnlLine);
                "Account Type"::"IC Partner":
                    PostICPartner(GenJnlLine);
            END;
    end;

    local procedure InitAmounts(var GenJnlLine: Record "81"): Decimal
    var
        Currency: Record "4";
    begin
        WITH GenJnlLine DO BEGIN
            IF "Currency Code" = '' THEN BEGIN
                Currency.InitRoundingPrecision;
                "Amount (LCY)" := Amount;
                "VAT Amount (LCY)" := "VAT Amount";
                "VAT Base Amount (LCY)" := "VAT Base Amount";
            END ELSE BEGIN
                Currency.GET("Currency Code");
                Currency.TESTFIELD("Amount Rounding Precision");
                IF NOT "System-Created Entry" THEN BEGIN
                    "Source Currency Code" := "Currency Code";
                    "Source Currency Amount" := Amount;
                    "Source Curr. VAT Base Amount" := "VAT Base Amount";
                    "Source Curr. VAT Amount" := "VAT Amount";
                END;
            END;
            IF "Additional-Currency Posting" = "Additional-Currency Posting"::None THEN BEGIN
                IF Amount <> ROUND(Amount, Currency."Amount Rounding Precision") THEN
                    FIELDERROR(
                      Amount,
                      STRSUBSTNO(NeedsRoundingErr, Amount));
                IF "Amount (LCY)" <> ROUND("Amount (LCY)") THEN
                    FIELDERROR(
                      "Amount (LCY)",
                      STRSUBSTNO(NeedsRoundingErr, "Amount (LCY)"));
            END;
            EXIT(Currency."Amount Rounding Precision");
        END;
    end;

    local procedure InitLastDocDate(GenJnlLine: Record "81")
    begin
        WITH GenJnlLine DO BEGIN
            LastDocType := "Document Type";
            LastDocNo := "Document No.";
            LastDate := "Posting Date";
        END;
    end;

    local procedure InitVAT(var GenJnlLine: Record "81"; var GLEntry: Record "17"; var VATPostingSetup: Record "325")
    var
        LCYCurrency: Record "4";
        SalesTaxCalculate: Codeunit "398";
    begin
        LCYCurrency.InitRoundingPrecision;
        WITH GenJnlLine DO
            IF "Gen. Posting Type" <> 0 THEN BEGIN // None
                VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                TESTFIELD("VAT Calculation Type", VATPostingSetup."VAT Calculation Type");
                CASE "VAT Posting" OF
                    "VAT Posting"::"Automatic VAT Entry":
                        BEGIN
                            GLEntry.CopyPostingGroupsFromGenJnlLine(GenJnlLine);
                            CASE "VAT Calculation Type" OF
                                "VAT Calculation Type"::"Normal VAT":
                                    IF "VAT Difference" <> 0 THEN BEGIN
                                        GLEntry.Amount := "VAT Base Amount (LCY)";
                                        GLEntry."VAT Amount" := "Amount (LCY)" - GLEntry.Amount;
                                        GLEntry."Additional-Currency Amount" := "Source Curr. VAT Base Amount";
                                        IF "Source Currency Code" = AddCurrencyCode THEN
                                            AddCurrGLEntryVATAmt := "Source Curr. VAT Amount"
                                        ELSE
                                            AddCurrGLEntryVATAmt := CalcLCYToAddCurr(GLEntry."VAT Amount");
                                    END ELSE BEGIN
                                        GLEntry."VAT Amount" :=
                                          ROUND(
                                            "Amount (LCY)" * VATPostingSetup."VAT %" / (100 + VATPostingSetup."VAT %"),
                                            LCYCurrency."Amount Rounding Precision", LCYCurrency.VATRoundingDirection);
                                        GLEntry.Amount := "Amount (LCY)" - GLEntry."VAT Amount";
                                        IF "Source Currency Code" = AddCurrencyCode THEN
                                            AddCurrGLEntryVATAmt :=
                                              ROUND(
                                                "Source Currency Amount" * VATPostingSetup."VAT %" / (100 + VATPostingSetup."VAT %"),
                                                AddCurrency."Amount Rounding Precision", AddCurrency.VATRoundingDirection)
                                        ELSE
                                            AddCurrGLEntryVATAmt := CalcLCYToAddCurr(GLEntry."VAT Amount");
                                        GLEntry."Additional-Currency Amount" := "Source Currency Amount" - AddCurrGLEntryVATAmt;
                                    END;
                                "VAT Calculation Type"::"Reverse Charge VAT":
                                    CASE "Gen. Posting Type" OF
                                        "Gen. Posting Type"::Purchase:
                                            IF "VAT Difference" <> 0 THEN BEGIN
                                                GLEntry."VAT Amount" := "VAT Amount (LCY)";
                                                IF "Source Currency Code" = AddCurrencyCode THEN
                                                    AddCurrGLEntryVATAmt := "Source Curr. VAT Amount"
                                                ELSE
                                                    AddCurrGLEntryVATAmt := CalcLCYToAddCurr(GLEntry."VAT Amount");
                                            END ELSE BEGIN
                                                GLEntry."VAT Amount" :=
                                                  ROUND(
                                                    GLEntry.Amount * VATPostingSetup."VAT %" / 100,
                                                    LCYCurrency."Amount Rounding Precision", LCYCurrency.VATRoundingDirection);
                                                IF "Source Currency Code" = AddCurrencyCode THEN
                                                    AddCurrGLEntryVATAmt :=
                                                      ROUND(
                                                        GLEntry."Additional-Currency Amount" * VATPostingSetup."VAT %" / 100,
                                                        AddCurrency."Amount Rounding Precision", AddCurrency.VATRoundingDirection)
                                                ELSE
                                                    AddCurrGLEntryVATAmt := CalcLCYToAddCurr(GLEntry."VAT Amount");
                                            END;
                                        "Gen. Posting Type"::Sale:
                                            BEGIN
                                                GLEntry."VAT Amount" := 0;
                                                AddCurrGLEntryVATAmt := 0;
                                            END;
                                    END;
                                "VAT Calculation Type"::"Full VAT":
                                    BEGIN
                                        CASE "Gen. Posting Type" OF
                                            "Gen. Posting Type"::Sale:
                                                TESTFIELD("Account No.", VATPostingSetup.GetSalesAccount(FALSE));
                                            "Gen. Posting Type"::Purchase:
                                                TESTFIELD("Account No.", VATPostingSetup.GetPurchAccount(FALSE));
                                        END;
                                        GLEntry.Amount := 0;
                                        GLEntry."Additional-Currency Amount" := 0;
                                        GLEntry."VAT Amount" := "Amount (LCY)";
                                        IF "Source Currency Code" = AddCurrencyCode THEN
                                            AddCurrGLEntryVATAmt := "Source Currency Amount"
                                        ELSE
                                            AddCurrGLEntryVATAmt := CalcLCYToAddCurr("Amount (LCY)");
                                    END;
                                "VAT Calculation Type"::"Sales Tax":
                                    BEGIN
                                        IF ("Gen. Posting Type" = "Gen. Posting Type"::Purchase) AND
                                           "Use Tax"
                                        THEN BEGIN
                                            GLEntry."VAT Amount" :=
                                              ROUND(
                                                SalesTaxCalculate.CalculateTax(
                                                  "Tax Area Code", "Tax Group Code", "Tax Liable",
                                                  "Posting Date", "Amount (LCY)", Quantity, 0));
                                            GLEntry.Amount := "Amount (LCY)";
                                        END ELSE BEGIN
                                            GLEntry.Amount :=
                                              ROUND(
                                                SalesTaxCalculate.ReverseCalculateTax(
                                                  "Tax Area Code", "Tax Group Code", "Tax Liable",
                                                  "Posting Date", "Amount (LCY)", Quantity, 0));
                                            GLEntry."VAT Amount" := "Amount (LCY)" - GLEntry.Amount;
                                        END;
                                        GLEntry."Additional-Currency Amount" := "Source Currency Amount";
                                        IF "Source Currency Code" = AddCurrencyCode THEN
                                            AddCurrGLEntryVATAmt := "Source Curr. VAT Amount"
                                        ELSE
                                            AddCurrGLEntryVATAmt := CalcLCYToAddCurr(GLEntry."VAT Amount");
                                    END;
                            END;
                        END;
                    "VAT Posting"::"Manual VAT Entry":
                        IF "Gen. Posting Type" <> "Gen. Posting Type"::Settlement THEN BEGIN
                            GLEntry.CopyPostingGroupsFromGenJnlLine(GenJnlLine);
                            GLEntry."VAT Amount" := "VAT Amount (LCY)";
                            IF "Source Currency Code" = AddCurrencyCode THEN
                                AddCurrGLEntryVATAmt := "Source Curr. VAT Amount"
                            ELSE
                                AddCurrGLEntryVATAmt := CalcLCYToAddCurr("VAT Amount (LCY)");
                        END;
                END;
            END;
        GLEntry."Additional-Currency Amount" :=
          GLCalcAddCurrency(GLEntry.Amount, GLEntry."Additional-Currency Amount", GLEntry."Additional-Currency Amount", TRUE, GenJnlLine);
    end;

    local procedure PostVAT(GenJnlLine: Record "81"; var GLEntry: Record "17"; VATPostingSetup: Record "325")
    var
        TaxDetail2: Record "322";
        SalesTaxCalculate: Codeunit "398";
        VATAmount: Decimal;
        VATAmount2: Decimal;
        VATBase: Decimal;
        VATBase2: Decimal;
        SrcCurrVATAmount: Decimal;
        SrcCurrVATBase: Decimal;
        SrcCurrSalesTaxBaseAmount: Decimal;
        RemSrcCurrVATAmount: Decimal;
        SalesTaxBaseAmount: Decimal;
        TaxDetailFound: Boolean;
    begin
        WITH GenJnlLine DO
            // Post VAT
            // VAT for VAT entry
            CASE "VAT Calculation Type" OF
                "VAT Calculation Type"::"Normal VAT",
                "VAT Calculation Type"::"Reverse Charge VAT",
                "VAT Calculation Type"::"Full VAT":
                    BEGIN
                        IF "VAT Posting" = "VAT Posting"::"Automatic VAT Entry" THEN
                            "VAT Base Amount (LCY)" := GLEntry.Amount;
                        IF "Gen. Posting Type" = "Gen. Posting Type"::Settlement THEN
                            AddCurrGLEntryVATAmt := "Source Curr. VAT Amount";
                        InsertVAT(
                          GenJnlLine, VATPostingSetup,
                          GLEntry.Amount, GLEntry."VAT Amount", "VAT Base Amount (LCY)", "Source Currency Code",
                          GLEntry."Additional-Currency Amount", AddCurrGLEntryVATAmt, "Source Curr. VAT Base Amount");
                        NextConnectionNo := NextConnectionNo + 1;
                    END;
                "VAT Calculation Type"::"Sales Tax":
                    BEGIN
                        CASE "VAT Posting" OF
                            "VAT Posting"::"Automatic VAT Entry":
                                SalesTaxBaseAmount := GLEntry.Amount;
                            "VAT Posting"::"Manual VAT Entry":
                                SalesTaxBaseAmount := "VAT Base Amount (LCY)";
                        END;
                        IF ("VAT Posting" = "VAT Posting"::"Manual VAT Entry") AND
                           ("Gen. Posting Type" = "Gen. Posting Type"::Settlement)
                        THEN
                            InsertVAT(
                              GenJnlLine, VATPostingSetup,
                              GLEntry.Amount, GLEntry."VAT Amount", "VAT Base Amount (LCY)", "Source Currency Code",
                              "Source Curr. VAT Base Amount", "Source Curr. VAT Amount", "Source Curr. VAT Base Amount")
                        ELSE BEGIN
                            CLEAR(SalesTaxCalculate);
                            SalesTaxCalculate.InitSalesTaxLines(
                              "Tax Area Code", "Tax Group Code", "Tax Liable",
                              SalesTaxBaseAmount, Quantity, "Posting Date", GLEntry."VAT Amount");
                            SrcCurrVATAmount := 0;
                            SrcCurrSalesTaxBaseAmount := CalcLCYToAddCurr(SalesTaxBaseAmount);
                            RemSrcCurrVATAmount := AddCurrGLEntryVATAmt;
                            TaxDetailFound := FALSE;
                            WHILE SalesTaxCalculate.GetSalesTaxLine(TaxDetail2, VATAmount, VATBase) DO BEGIN
                                RemSrcCurrVATAmount := RemSrcCurrVATAmount - SrcCurrVATAmount;
                                IF TaxDetailFound THEN
                                    InsertVAT(
                                      GenJnlLine, VATPostingSetup,
                                      SalesTaxBaseAmount, VATAmount2, VATBase2, "Source Currency Code",
                                      SrcCurrSalesTaxBaseAmount, SrcCurrVATAmount, SrcCurrVATBase);
                                TaxDetailFound := TRUE;
                                TaxDetail := TaxDetail2;
                                VATAmount2 := VATAmount;
                                VATBase2 := VATBase;
                                SrcCurrVATAmount := CalcLCYToAddCurr(VATAmount);
                                SrcCurrVATBase := CalcLCYToAddCurr(VATBase);
                            END;
                            IF TaxDetailFound THEN
                                InsertVAT(
                                  GenJnlLine, VATPostingSetup,
                                  SalesTaxBaseAmount, VATAmount2, VATBase2, "Source Currency Code",
                                  SrcCurrSalesTaxBaseAmount, RemSrcCurrVATAmount, SrcCurrVATBase);
                            InsertSummarizedVAT(GenJnlLine);
                        END;
                    END;
            END;
    end;

    local procedure InsertVAT(GenJnlLine: Record "81"; VATPostingSetup: Record "325"; GLEntryAmount: Decimal; GLEntryVATAmount: Decimal; GLEntryBaseAmount: Decimal; SrcCurrCode: Code[10]; SrcCurrGLEntryAmt: Decimal; SrcCurrGLEntryVATAmt: Decimal; SrcCurrGLEntryBaseAmt: Decimal)
    var
        TaxJurisdiction: Record "320";
        VATAmount: Decimal;
        VATBase: Decimal;
        SrcCurrVATAmount: Decimal;
        SrcCurrVATBase: Decimal;
        VATDifferenceLCY: Decimal;
        SrcCurrVATDifference: Decimal;
        UnrealizedVAT: Boolean;
    begin
        WITH GenJnlLine DO BEGIN
            // Post VAT
            // VAT for VAT entry
            VATEntry.INIT;
            VATEntry.CopyFromGenJnlLine(GenJnlLine);
            VATEntry."Entry No." := NextVATEntryNo;
            VATEntry."EU Service" := VATPostingSetup."EU Service";
            VATEntry."Transaction No." := NextTransactionNo;
            VATEntry."Sales Tax Connection No." := NextConnectionNo;

            IF "VAT Difference" = 0 THEN
                VATDifferenceLCY := 0
            ELSE
                IF "Currency Code" = '' THEN
                    VATDifferenceLCY := "VAT Difference"
                ELSE
                    VATDifferenceLCY :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Posting Date", "Currency Code", "VAT Difference",
                          CurrExchRate.ExchangeRate("Posting Date", "Currency Code")));

            IF "VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax" THEN BEGIN
                IF TaxDetail."Tax Jurisdiction Code" <> '' THEN
                    TaxJurisdiction.GET(TaxDetail."Tax Jurisdiction Code");
                IF "Gen. Posting Type" <> "Gen. Posting Type"::Settlement THEN BEGIN
                    VATEntry."Tax Group Used" := TaxDetail."Tax Group Code";
                    VATEntry."Tax Type" := TaxDetail."Tax Type";
                    VATEntry."Tax on Tax" := TaxDetail."Calculate Tax on Tax";
                END;
                VATEntry."Tax Jurisdiction Code" := TaxDetail."Tax Jurisdiction Code";
            END;

            IF AddCurrencyCode <> '' THEN
                IF AddCurrencyCode <> SrcCurrCode THEN BEGIN
                    SrcCurrGLEntryAmt := ExchangeAmtLCYToFCY2(GLEntryAmount);
                    SrcCurrGLEntryVATAmt := ExchangeAmtLCYToFCY2(GLEntryVATAmount);
                    SrcCurrGLEntryBaseAmt := ExchangeAmtLCYToFCY2(GLEntryBaseAmount);
                    SrcCurrVATDifference := ExchangeAmtLCYToFCY2(VATDifferenceLCY);
                END ELSE
                    SrcCurrVATDifference := "VAT Difference";

            UnrealizedVAT :=
              (((VATPostingSetup."Unrealized VAT Type" > 0) AND
                (VATPostingSetup."VAT Calculation Type" IN
                 [VATPostingSetup."VAT Calculation Type"::"Normal VAT",
                  VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT",
                  VATPostingSetup."VAT Calculation Type"::"Full VAT"])) OR
               ((TaxJurisdiction."Unrealized VAT Type" > 0) AND
                (VATPostingSetup."VAT Calculation Type" IN
                 [VATPostingSetup."VAT Calculation Type"::"Sales Tax"]))) AND
              IsNotPayment("Document Type");
            IF GLSetup."Prepayment Unrealized VAT" AND NOT GLSetup."Unrealized VAT" AND
               (VATPostingSetup."Unrealized VAT Type" > 0)
            THEN
                UnrealizedVAT := Prepayment;

            // VAT for VAT entry
            IF "Gen. Posting Type" <> 0 THEN BEGIN
                CASE "VAT Posting" OF
                    "VAT Posting"::"Automatic VAT Entry":
                        BEGIN
                            VATAmount := GLEntryVATAmount;
                            VATBase := GLEntryBaseAmount;
                            SrcCurrVATAmount := SrcCurrGLEntryVATAmt;
                            SrcCurrVATBase := SrcCurrGLEntryBaseAmt;
                        END;
                    "VAT Posting"::"Manual VAT Entry":
                        BEGIN
                            IF "Gen. Posting Type" = "Gen. Posting Type"::Settlement THEN BEGIN
                                VATAmount := GLEntryAmount;
                                SrcCurrVATAmount := SrcCurrGLEntryVATAmt;
                                VATEntry.Closed := TRUE;
                            END ELSE BEGIN
                                VATAmount := GLEntryVATAmount;
                                SrcCurrVATAmount := SrcCurrGLEntryVATAmt;
                            END;
                            VATBase := GLEntryBaseAmount;
                            SrcCurrVATBase := SrcCurrGLEntryBaseAmt;
                        END;
                END;

                IF UnrealizedVAT THEN BEGIN
                    VATEntry.Amount := 0;
                    VATEntry.Base := 0;
                    VATEntry."Unrealized Amount" := VATAmount;
                    VATEntry."Unrealized Base" := VATBase;
                    VATEntry."Remaining Unrealized Amount" := VATEntry."Unrealized Amount";
                    VATEntry."Remaining Unrealized Base" := VATEntry."Unrealized Base";
                END ELSE BEGIN
                    VATEntry.Amount := VATAmount;
                    VATEntry.Base := VATBase;
                    VATEntry."Unrealized Amount" := 0;
                    VATEntry."Unrealized Base" := 0;
                    VATEntry."Remaining Unrealized Amount" := 0;
                    VATEntry."Remaining Unrealized Base" := 0;
                END;

                IF AddCurrencyCode = '' THEN BEGIN
                    VATEntry."Additional-Currency Base" := 0;
                    VATEntry."Additional-Currency Amount" := 0;
                    VATEntry."Add.-Currency Unrealized Amt." := 0;
                    VATEntry."Add.-Currency Unrealized Base" := 0;
                END ELSE
                    IF UnrealizedVAT THEN BEGIN
                        VATEntry."Additional-Currency Base" := 0;
                        VATEntry."Additional-Currency Amount" := 0;
                        VATEntry."Add.-Currency Unrealized Base" := SrcCurrVATBase;
                        VATEntry."Add.-Currency Unrealized Amt." := SrcCurrVATAmount;
                    END ELSE BEGIN
                        VATEntry."Additional-Currency Base" := SrcCurrVATBase;
                        VATEntry."Additional-Currency Amount" := SrcCurrVATAmount;
                        VATEntry."Add.-Currency Unrealized Base" := 0;
                        VATEntry."Add.-Currency Unrealized Amt." := 0;
                    END;
                VATEntry."Add.-Curr. Rem. Unreal. Amount" := VATEntry."Add.-Currency Unrealized Amt.";
                VATEntry."Add.-Curr. Rem. Unreal. Base" := VATEntry."Add.-Currency Unrealized Base";
                VATEntry."VAT Difference" := VATDifferenceLCY;
                VATEntry."Add.-Curr. VAT Difference" := SrcCurrVATDifference;

                VATEntry.INSERT(TRUE);
                GLEntryVATEntryLink.InsertLink(TempGLEntryBuf."Entry No.", VATEntry."Entry No.");
                NextVATEntryNo := NextVATEntryNo + 1;
            END;

            // VAT for G/L entry/entries
            IF (GLEntryVATAmount <> 0) OR
               ((SrcCurrGLEntryVATAmt <> 0) AND (SrcCurrCode = AddCurrencyCode))
            THEN
                CASE "Gen. Posting Type" OF
                    "Gen. Posting Type"::Purchase:
                        CASE VATPostingSetup."VAT Calculation Type" OF
                            VATPostingSetup."VAT Calculation Type"::"Normal VAT",
                          VATPostingSetup."VAT Calculation Type"::"Full VAT":
                                CreateGLEntry(GenJnlLine, VATPostingSetup.GetPurchAccount(UnrealizedVAT),
                                  GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE);
                            VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                                BEGIN
                                    CreateGLEntry(GenJnlLine, VATPostingSetup.GetPurchAccount(UnrealizedVAT),
                                      GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE);
                                    CreateGLEntry(GenJnlLine, VATPostingSetup.GetRevChargeAccount(UnrealizedVAT),
                                      -GLEntryVATAmount, -SrcCurrGLEntryVATAmt, TRUE);
                                END;
                            VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                                IF "Use Tax" THEN BEGIN
                                    InitGLEntryVAT(GenJnlLine, TaxJurisdiction.GetPurchAccount(UnrealizedVAT), '',
                                      GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE);
                                    InitGLEntryVAT(GenJnlLine, TaxJurisdiction.GetRevChargeAccount(UnrealizedVAT), '',
                                      -GLEntryVATAmount, -SrcCurrGLEntryVATAmt, TRUE);
                                END ELSE
                                    InitGLEntryVAT(GenJnlLine, TaxJurisdiction.GetPurchAccount(UnrealizedVAT), '',
                                      GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE);
                        END;
                    "Gen. Posting Type"::Sale:
                        CASE VATPostingSetup."VAT Calculation Type" OF
                            VATPostingSetup."VAT Calculation Type"::"Normal VAT",
                          VATPostingSetup."VAT Calculation Type"::"Full VAT":
                                CreateGLEntry(GenJnlLine, VATPostingSetup.GetSalesAccount(UnrealizedVAT),
                                  GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE);
                            VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                                ;
                            VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                                InitGLEntryVAT(GenJnlLine, TaxJurisdiction.GetSalesAccount(UnrealizedVAT), '',
                                  GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE);
                        END;
                END;
        END;
    end;

    local procedure SummarizeVAT(SummarizeGLEntries: Boolean; GLEntry: Record "17")
    var
        InsertedTempVAT: Boolean;
    begin
        InsertedTempVAT := FALSE;
        IF SummarizeGLEntries THEN
            IF TempGLEntryVAT.FINDSET THEN
                REPEAT
                    IF (TempGLEntryVAT."G/L Account No." = GLEntry."G/L Account No.") AND
                       (TempGLEntryVAT."Bal. Account No." = GLEntry."Bal. Account No.")
                    THEN BEGIN
                        TempGLEntryVAT.Amount := TempGLEntryVAT.Amount + GLEntry.Amount;
                        TempGLEntryVAT."Additional-Currency Amount" :=
                          TempGLEntryVAT."Additional-Currency Amount" + GLEntry."Additional-Currency Amount";
                        TempGLEntryVAT.MODIFY;
                        InsertedTempVAT := TRUE;
                    END;
                UNTIL (TempGLEntryVAT.NEXT = 0) OR InsertedTempVAT;
        IF NOT InsertedTempVAT OR NOT SummarizeGLEntries THEN BEGIN
            TempGLEntryVAT := GLEntry;
            TempGLEntryVAT."Entry No." :=
              TempGLEntryVAT."Entry No." + InsertedTempGLEntryVAT;
            TempGLEntryVAT.INSERT;
            InsertedTempGLEntryVAT := InsertedTempGLEntryVAT + 1;
        END;
    end;

    local procedure InsertSummarizedVAT(GenJnlLine: Record "81")
    begin
        IF TempGLEntryVAT.FINDSET THEN BEGIN
            REPEAT
                InsertGLEntry(GenJnlLine, TempGLEntryVAT, TRUE);
            UNTIL TempGLEntryVAT.NEXT = 0;
            TempGLEntryVAT.DELETEALL;
            InsertedTempGLEntryVAT := 0;
        END;
        NextConnectionNo := NextConnectionNo + 1;
    end;

    local procedure PostGLAcc(GenJnlLine: Record "81"; Balancing: Boolean)
    var
        GLAcc: Record "15";
        GLEntry: Record "17";
        VATPostingSetup: Record "325";
    begin
        WITH GenJnlLine DO BEGIN
            GLAcc.GET("Account No.");
            // G/L entry
            InitGLEntry(GenJnlLine, GLEntry,
              "Account No.", "Amount (LCY)",
              "Source Currency Amount", TRUE, "System-Created Entry");
            IF NOT "System-Created Entry" THEN
                IF "Posting Date" = NORMALDATE("Posting Date") THEN
                    GLAcc.TESTFIELD("Direct Posting", TRUE);
            IF GLAcc."Omit Default Descr. in Jnl." THEN
                IF DELCHR(Description, '=', ' ') = '' THEN
                    ERROR(
                      DescriptionMustNotBeBlankErr,
                      GLAcc.FIELDCAPTION("Omit Default Descr. in Jnl."),
                      GLAcc."No.",
                      FIELDCAPTION(Description));
            GLEntry."Gen. Posting Type" := "Gen. Posting Type";
            GLEntry."Bal. Account Type" := "Bal. Account Type";
            GLEntry."Bal. Account No." := "Bal. Account No.";
            GLEntry."No. Series" := "Posting No. Series";
            IF "Additional-Currency Posting" =
               "Additional-Currency Posting"::"Additional-Currency Amount Only"
            THEN BEGIN
                GLEntry."Additional-Currency Amount" := Amount;
                GLEntry.Amount := 0;
            END;
            // Store Entry No. to global variable for return:
            GLEntryNo := GLEntry."Entry No.";
            InitVAT(GenJnlLine, GLEntry, VATPostingSetup);
            InsertGLEntry(GenJnlLine, GLEntry, TRUE);
            PostJob(GenJnlLine, GLEntry);
            PostVAT(GenJnlLine, GLEntry, VATPostingSetup);
            DeferralPosting("Deferral Code", "Source Code", "Account No.", GenJnlLine, Balancing);
            OnMoveGenJournalLine(GLEntry.RECORDID);
        END;

        OnAfterPostGLAcc(GenJnlLine);
    end;

    local procedure PostCust(var GenJnlLine: Record "81"; Balancing: Boolean)
    var
        LineFeeNoteOnReportHist: Record "1053";
        Cust: Record "18";
        CustPostingGr: Record "92";
        CustLedgEntry: Record "21";
        CVLedgEntryBuf: Record "382";
        TempDtldCVLedgEntryBuf: Record "383" temporary;
        DtldCustLedgEntry: Record "379";
        ReceivablesAccount: Code[20];
        DtldLedgEntryInserted: Boolean;
    begin
        WITH GenJnlLine DO BEGIN
            Cust.GET("Account No.");
            Cust.CheckBlockedCustOnJnls(Cust, "Document Type", TRUE);

            IF "Posting Group" = '' THEN BEGIN
                Cust.TESTFIELD("Customer Posting Group");
                "Posting Group" := Cust."Customer Posting Group";
            END;
            CustPostingGr.GET("Posting Group");
            ReceivablesAccount := CustPostingGr.GetReceivablesAccount;

            DtldCustLedgEntry.LOCKTABLE;
            CustLedgEntry.LOCKTABLE;

            InitCustLedgEntry(GenJnlLine, CustLedgEntry);

            IF NOT Cust."Block Payment Tolerance" THEN
                CalcPmtTolerancePossible(
                  GenJnlLine, CustLedgEntry."Pmt. Discount Date", CustLedgEntry."Pmt. Disc. Tolerance Date",
                  CustLedgEntry."Max. Payment Tolerance");

            TempDtldCVLedgEntryBuf.DELETEALL;
            TempDtldCVLedgEntryBuf.INIT;
            TempDtldCVLedgEntryBuf.CopyFromGenJnlLine(GenJnlLine);
            TempDtldCVLedgEntryBuf."CV Ledger Entry No." := CustLedgEntry."Entry No.";
            CVLedgEntryBuf.CopyFromCustLedgEntry(CustLedgEntry);
            TempDtldCVLedgEntryBuf.InsertDtldCVLedgEntry(TempDtldCVLedgEntryBuf, CVLedgEntryBuf, TRUE);
            CVLedgEntryBuf.Open := CVLedgEntryBuf."Remaining Amount" <> 0;
            CVLedgEntryBuf.Positive := CVLedgEntryBuf."Remaining Amount" > 0;

            CalcPmtDiscPossible(GenJnlLine, CVLedgEntryBuf);

            IF "Currency Code" <> '' THEN BEGIN
                TESTFIELD("Currency Factor");
                CVLedgEntryBuf."Original Currency Factor" := "Currency Factor"
            END ELSE
                CVLedgEntryBuf."Original Currency Factor" := 1;
            CVLedgEntryBuf."Adjusted Currency Factor" := CVLedgEntryBuf."Original Currency Factor";

            // Check the document no.
            IF "Recurring Method" = 0 THEN
                IF IsNotPayment("Document Type") THEN BEGIN
                    GenJnlCheckLine.CheckSalesDocNoIsNotUsed("Document Type", "Document No.");
                    CheckSalesExtDocNo(GenJnlLine);
                END;

            // Post application
            ApplyCustLedgEntry(CVLedgEntryBuf, TempDtldCVLedgEntryBuf, GenJnlLine, Cust);

            // Post customer entry
            CustLedgEntry.CopyFromCVLedgEntryBuffer(CVLedgEntryBuf);
            CustLedgEntry."Amount to Apply" := 0;
            CustLedgEntry."Applies-to Doc. No." := '';
            CustLedgEntry.INSERT(TRUE);

            // Post detailed customer entries
            DtldLedgEntryInserted := PostDtldCustLedgEntries(GenJnlLine, TempDtldCVLedgEntryBuf, CustPostingGr, TRUE);

            // Post Reminder Terms - Note About Line Fee on Report
            LineFeeNoteOnReportHist.Save(CustLedgEntry);

            IF DtldLedgEntryInserted THEN
                IF IsTempGLEntryBufEmpty THEN
                    DtldCustLedgEntry.SetZeroTransNo(NextTransactionNo);

            DeferralPosting("Deferral Code", "Source Code", ReceivablesAccount, GenJnlLine, Balancing);
            OnMoveGenJournalLine(CustLedgEntry.RECORDID);
        END;
    end;

    local procedure PostVend(GenJnlLine: Record "81"; Balancing: Boolean)
    var
        Vend: Record "23";
        VendPostingGr: Record "93";
        VendLedgEntry: Record "25";
        CVLedgEntryBuf: Record "382";
        TempDtldCVLedgEntryBuf: Record "383" temporary;
        DtldVendLedgEntry: Record "380";
        PayablesAccount: Code[20];
        DtldLedgEntryInserted: Boolean;
        CheckExtDocNoHandled: Boolean;
    begin
        WITH GenJnlLine DO BEGIN
            Vend.GET("Account No.");
            Vend.CheckBlockedVendOnJnls(Vend, "Document Type", TRUE);

            IF "Posting Group" = '' THEN BEGIN
                Vend.TESTFIELD("Vendor Posting Group");
                "Posting Group" := Vend."Vendor Posting Group";
            END;
            VendPostingGr.GET("Posting Group");
            PayablesAccount := VendPostingGr.GetPayablesAccount;

            DtldVendLedgEntry.LOCKTABLE;
            VendLedgEntry.LOCKTABLE;

            InitVendLedgEntry(GenJnlLine, VendLedgEntry);

            IF NOT Vend."Block Payment Tolerance" THEN
                CalcPmtTolerancePossible(
                  GenJnlLine, VendLedgEntry."Pmt. Discount Date", VendLedgEntry."Pmt. Disc. Tolerance Date",
                  VendLedgEntry."Max. Payment Tolerance");

            TempDtldCVLedgEntryBuf.DELETEALL;
            TempDtldCVLedgEntryBuf.INIT;
            TempDtldCVLedgEntryBuf.CopyFromGenJnlLine(GenJnlLine);
            TempDtldCVLedgEntryBuf."CV Ledger Entry No." := VendLedgEntry."Entry No.";
            CVLedgEntryBuf.CopyFromVendLedgEntry(VendLedgEntry);
            TempDtldCVLedgEntryBuf.InsertDtldCVLedgEntry(TempDtldCVLedgEntryBuf, CVLedgEntryBuf, TRUE);
            CVLedgEntryBuf.Open := CVLedgEntryBuf."Remaining Amount" <> 0;
            CVLedgEntryBuf.Positive := CVLedgEntryBuf."Remaining Amount" > 0;

            CalcPmtDiscPossible(GenJnlLine, CVLedgEntryBuf);

            IF "Currency Code" <> '' THEN BEGIN
                TESTFIELD("Currency Factor");
                CVLedgEntryBuf."Adjusted Currency Factor" := "Currency Factor"
            END ELSE
                CVLedgEntryBuf."Adjusted Currency Factor" := 1;
            CVLedgEntryBuf."Original Currency Factor" := CVLedgEntryBuf."Adjusted Currency Factor";

            // Check the document no.
            IF "Recurring Method" = 0 THEN
                IF IsNotPayment("Document Type") THEN BEGIN
                    GenJnlCheckLine.CheckPurchDocNoIsNotUsed("Document Type", "Document No.");
                    OnBeforeCheckPurchExtDocNo(GenJnlLine, VendLedgEntry, CVLedgEntryBuf, CheckExtDocNoHandled);
                    IF NOT CheckExtDocNoHandled THEN
                        CheckPurchExtDocNo(GenJnlLine);
                END;

            // Post application
            ApplyVendLedgEntry(CVLedgEntryBuf, TempDtldCVLedgEntryBuf, GenJnlLine, Vend);

            // Post vendor entry
            VendLedgEntry.CopyFromCVLedgEntryBuffer(CVLedgEntryBuf);
            VendLedgEntry."Amount to Apply" := 0;
            VendLedgEntry."Applies-to Doc. No." := '';
            VendLedgEntry.INSERT(TRUE);

            // Post detailed vendor entries
            DtldLedgEntryInserted := PostDtldVendLedgEntries(GenJnlLine, TempDtldCVLedgEntryBuf, VendPostingGr, TRUE);

            IF DtldLedgEntryInserted THEN
                IF IsTempGLEntryBufEmpty THEN
                    DtldVendLedgEntry.SetZeroTransNo(NextTransactionNo);
            DeferralPosting("Deferral Code", "Source Code", PayablesAccount, GenJnlLine, Balancing);
            OnMoveGenJournalLine(VendLedgEntry.RECORDID);
        END;
    end;

    local procedure PostEmployee(GenJnlLine: Record "81")
    var
        Employee: Record "5200";
        EmployeePostingGr: Record "5221";
        EmployeeLedgerEntry: Record "5222";
        CVLedgEntryBuf: Record "382";
        TempDtldCVLedgEntryBuf: Record "383" temporary;
        DtldEmplLedgEntry: Record "5223";
        DtldLedgEntryInserted: Boolean;
    begin
        WITH GenJnlLine DO BEGIN
            Employee.GET("Account No.");

            IF "Posting Group" = '' THEN BEGIN
                Employee.TESTFIELD("Employee Posting Group");
                "Posting Group" := Employee."Employee Posting Group";
            END;
            EmployeePostingGr.GET("Posting Group");

            DtldEmplLedgEntry.LOCKTABLE;
            EmployeeLedgerEntry.LOCKTABLE;

            InitEmployeeLedgerEntry(GenJnlLine, EmployeeLedgerEntry);

            TempDtldCVLedgEntryBuf.DELETEALL;
            TempDtldCVLedgEntryBuf.INIT;
            TempDtldCVLedgEntryBuf.CopyFromGenJnlLine(GenJnlLine);
            TempDtldCVLedgEntryBuf."CV Ledger Entry No." := EmployeeLedgerEntry."Entry No.";
            CVLedgEntryBuf.CopyFromEmplLedgEntry(EmployeeLedgerEntry);
            TempDtldCVLedgEntryBuf.InsertDtldCVLedgEntry(TempDtldCVLedgEntryBuf, CVLedgEntryBuf, TRUE);
            CVLedgEntryBuf.Open := CVLedgEntryBuf."Remaining Amount" <> 0;
            CVLedgEntryBuf.Positive := CVLedgEntryBuf."Remaining Amount" > 0;

            // Post application
            ApplyEmplLedgEntry(CVLedgEntryBuf, TempDtldCVLedgEntryBuf, GenJnlLine, Employee);

            // Post vendor entry
            EmployeeLedgerEntry.CopyFromCVLedgEntryBuffer(CVLedgEntryBuf);
            EmployeeLedgerEntry."Amount to Apply" := 0;
            EmployeeLedgerEntry."Applies-to Doc. No." := '';
            EmployeeLedgerEntry.INSERT(TRUE);

            // Post detailed employee entries
            DtldLedgEntryInserted := PostDtldEmplLedgEntries(GenJnlLine, TempDtldCVLedgEntryBuf, EmployeePostingGr, TRUE);

            // Posting GL Entry
            IF DtldLedgEntryInserted THEN
                IF IsTempGLEntryBufEmpty THEN
                    DtldEmplLedgEntry.SetZeroTransNo(NextTransactionNo);

            OnMoveGenJournalLine(EmployeeLedgerEntry.RECORDID);
        END;
    end;

    local procedure PostBankAcc(GenJnlLine: Record "81"; Balancing: Boolean)
    var
        BankAcc: Record "270";
        BankAccLedgEntry: Record "271";
        CheckLedgEntry: Record "272";
        CheckLedgEntry2: Record "272";
        BankAccPostingGr: Record "277";
    begin
        WITH GenJnlLine DO BEGIN
            BankAcc.GET("Account No.");
            BankAcc.TESTFIELD(Blocked, FALSE);
            IF "Currency Code" = '' THEN
                BankAcc.TESTFIELD("Currency Code", '')
            ELSE
                IF BankAcc."Currency Code" <> '' THEN
                    TESTFIELD("Currency Code", BankAcc."Currency Code");

            BankAcc.TESTFIELD("Bank Acc. Posting Group");
            BankAccPostingGr.GET(BankAcc."Bank Acc. Posting Group");

            BankAccLedgEntry.LOCKTABLE;

            InitBankAccLedgEntry(GenJnlLine, BankAccLedgEntry);

            BankAccLedgEntry."Bank Acc. Posting Group" := BankAcc."Bank Acc. Posting Group";
            BankAccLedgEntry."Currency Code" := BankAcc."Currency Code";
            IF BankAcc."Currency Code" <> '' THEN
                BankAccLedgEntry.Amount := Amount
            ELSE
                BankAccLedgEntry.Amount := "Amount (LCY)";
            BankAccLedgEntry."Amount (LCY)" := "Amount (LCY)";
            BankAccLedgEntry.Open := Amount <> 0;
            BankAccLedgEntry."Remaining Amount" := BankAccLedgEntry.Amount;
            BankAccLedgEntry.Positive := Amount > 0;
            BankAccLedgEntry.UpdateDebitCredit(Correction);
            BankAccLedgEntry.INSERT(TRUE);

            IF ((Amount <= 0) AND ("Bank Payment Type" = "Bank Payment Type"::"Computer Check") AND "Check Printed") OR
               ((Amount < 0) AND ("Bank Payment Type" = "Bank Payment Type"::"Manual Check"))
            THEN BEGIN
                IF BankAcc."Currency Code" <> "Currency Code" THEN
                    ERROR(BankPaymentTypeMustNotBeFilledErr);
                CASE "Bank Payment Type" OF
                    "Bank Payment Type"::"Computer Check":
                        BEGIN
                            TESTFIELD("Check Printed", TRUE);
                            CheckLedgEntry.LOCKTABLE;
                            CheckLedgEntry.RESET;
                            CheckLedgEntry.SETCURRENTKEY("Bank Account No.", "Entry Status", "Check No.");
                            CheckLedgEntry.SETRANGE("Bank Account No.", "Account No.");
                            CheckLedgEntry.SETRANGE("Entry Status", CheckLedgEntry."Entry Status"::Printed);
                            CheckLedgEntry.SETRANGE("Check No.", "Document No.");
                            IF CheckLedgEntry.FINDSET THEN
                                REPEAT
                                    CheckLedgEntry2 := CheckLedgEntry;
                                    CheckLedgEntry2."Entry Status" := CheckLedgEntry2."Entry Status"::Posted;
                                    CheckLedgEntry2."Bank Account Ledger Entry No." := BankAccLedgEntry."Entry No.";
                                    CheckLedgEntry2.MODIFY;
                                UNTIL CheckLedgEntry.NEXT = 0;
                        END;
                    "Bank Payment Type"::"Manual Check":
                        BEGIN
                            IF "Document No." = '' THEN
                                ERROR(DocNoMustBeEnteredErr, "Bank Payment Type");
                            CheckLedgEntry.RESET;
                            IF NextCheckEntryNo = 0 THEN BEGIN
                                CheckLedgEntry.LOCKTABLE;
                                IF CheckLedgEntry.FINDLAST THEN
                                    NextCheckEntryNo := CheckLedgEntry."Entry No." + 1
                                ELSE
                                    NextCheckEntryNo := 1;
                            END;

                            CheckLedgEntry.SETRANGE("Bank Account No.", "Account No.");
                            CheckLedgEntry.SETFILTER(
                              "Entry Status", '%1|%2|%3',
                              CheckLedgEntry."Entry Status"::Printed,
                              CheckLedgEntry."Entry Status"::Posted,
                              CheckLedgEntry."Entry Status"::"Financially Voided");
                            CheckLedgEntry.SETRANGE("Check No.", "Document No.");
                            IF NOT CheckLedgEntry.ISEMPTY THEN
                                ERROR(CheckAlreadyExistsErr, "Document No.");

                            InitCheckLedgEntry(BankAccLedgEntry, CheckLedgEntry);
                            CheckLedgEntry."Bank Payment Type" := CheckLedgEntry."Bank Payment Type"::"Manual Check";
                            IF BankAcc."Currency Code" <> '' THEN
                                CheckLedgEntry.Amount := -Amount
                            ELSE
                                CheckLedgEntry.Amount := -"Amount (LCY)";
                            CheckLedgEntry.INSERT(TRUE);
                            NextCheckEntryNo := NextCheckEntryNo + 1;
                        END;
                END;
            END;

            BankAccPostingGr.TESTFIELD("G/L Bank Account No.");
            CreateGLEntryBalAcc(
              GenJnlLine, BankAccPostingGr."G/L Bank Account No.", "Amount (LCY)", "Source Currency Amount",
              "Bal. Account Type", "Bal. Account No.");
            DeferralPosting("Deferral Code", "Source Code", BankAccPostingGr."G/L Bank Account No.", GenJnlLine, Balancing);
            OnMoveGenJournalLine(BankAccLedgEntry.RECORDID);
        END;
    end;

    local procedure PostFixedAsset(GenJnlLine: Record "81")
    var
        GLEntry: Record "17";
        GLEntry2: Record "17";
        TempFAGLPostBuf: Record "5637" temporary;
        FAGLPostBuf: Record "5637";
        VATPostingSetup: Record "325";
        FAJnlPostLine: Codeunit "5632";
        FAAutomaticEntry: Codeunit "5607";
        ShortcutDim1Code: Code[20];
        ShortcutDim2Code: Code[20];
        Correction2: Boolean;
        NetDisposalNo: Integer;
        DimensionSetID: Integer;
        VATEntryGLEntryNo: Integer;
    begin
        WITH GenJnlLine DO BEGIN
            InitGLEntry(GenJnlLine, GLEntry, '', "Amount (LCY)", "Source Currency Amount", TRUE, "System-Created Entry");
            GLEntry."Gen. Posting Type" := "Gen. Posting Type";
            GLEntry."Bal. Account Type" := "Bal. Account Type";
            GLEntry."Bal. Account No." := "Bal. Account No.";
            InitVAT(GenJnlLine, GLEntry, VATPostingSetup);
            GLEntry2 := GLEntry;
            FAJnlPostLine.GenJnlPostLine(
              GenJnlLine, GLEntry2.Amount, GLEntry2."VAT Amount", NextTransactionNo, NextEntryNo, GLReg."No.");
            ShortcutDim1Code := "Shortcut Dimension 1 Code";
            ShortcutDim2Code := "Shortcut Dimension 2 Code";
            DimensionSetID := "Dimension Set ID";
            Correction2 := Correction;
        END;
        WITH TempFAGLPostBuf DO
            IF FAJnlPostLine.FindFirstGLAcc(TempFAGLPostBuf) THEN
                REPEAT
                    GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                    GenJnlLine."Dimension Set ID" := "Dimension Set ID";
                    GenJnlLine.Correction := Correction;
                    FADimAlreadyChecked := "FA Posting Group" <> '';
                    CheckDimValueForDisposal(GenJnlLine, "Account No.");
                    IF "Original General Journal Line" THEN
                        InitGLEntry(GenJnlLine, GLEntry, "Account No.", Amount, GLEntry2."Additional-Currency Amount", TRUE, TRUE)
                    ELSE BEGIN
                        CheckNonAddCurrCodeOccurred('');
                        InitGLEntry(GenJnlLine, GLEntry, "Account No.", Amount, 0, FALSE, TRUE);
                    END;
                    FADimAlreadyChecked := FALSE;
                    GLEntry.CopyPostingGroupsFromGLEntry(GLEntry2);
                    GLEntry."VAT Amount" := GLEntry2."VAT Amount";
                    GLEntry."Bal. Account Type" := GLEntry2."Bal. Account Type";
                    GLEntry."Bal. Account No." := GLEntry2."Bal. Account No.";
                    GLEntry."FA Entry Type" := "FA Entry Type";
                    GLEntry."FA Entry No." := "FA Entry No.";
                    IF "Net Disposal" THEN
                        NetDisposalNo := NetDisposalNo + 1
                    ELSE
                        NetDisposalNo := 0;
                    IF "Automatic Entry" AND NOT "Net Disposal" THEN
                        FAAutomaticEntry.AdjustGLEntry(GLEntry);
                    IF NetDisposalNo > 1 THEN
                        GLEntry."VAT Amount" := 0;
                    IF "FA Posting Group" <> '' THEN BEGIN
                        FAGLPostBuf := TempFAGLPostBuf;
                        FAGLPostBuf."Entry No." := NextEntryNo;
                        FAGLPostBuf.INSERT;
                    END;
                    InsertGLEntry(GenJnlLine, GLEntry, TRUE);
                    IF (VATEntryGLEntryNo = 0) AND (GLEntry."Gen. Posting Type" <> GLEntry."Gen. Posting Type"::" ") THEN
                        VATEntryGLEntryNo := GLEntry."Entry No.";
                UNTIL FAJnlPostLine.GetNextGLAcc(TempFAGLPostBuf) = 0;
        GenJnlLine."Shortcut Dimension 1 Code" := ShortcutDim1Code;
        GenJnlLine."Shortcut Dimension 2 Code" := ShortcutDim2Code;
        GenJnlLine."Dimension Set ID" := DimensionSetID;
        GenJnlLine.Correction := Correction2;
        GLEntry := GLEntry2;
        IF VATEntryGLEntryNo = 0 THEN
            VATEntryGLEntryNo := GLEntry."Entry No.";
        TempGLEntryBuf."Entry No." := VATEntryGLEntryNo; // Used later in InsertVAT(): GLEntryVATEntryLink.InsertLink(TempGLEntryBuf."Entry No.",VATEntry."Entry No.")
        PostVAT(GenJnlLine, GLEntry, VATPostingSetup);

        FAJnlPostLine.UpdateRegNo(GLReg."No.");
        GenJnlLine.OnMoveGenJournalLine(GLEntry.RECORDID);
    end;

    local procedure PostICPartner(GenJnlLine: Record "81")
    var
        ICPartner: Record "413";
        AccountNo: Code[20];
    begin
        WITH GenJnlLine DO BEGIN
            IF "Account No." <> ICPartner.Code THEN
                ICPartner.GET("Account No.");
            IF ("Document Type" = "Document Type"::"Credit Memo") XOR (Amount > 0) THEN BEGIN
                ICPartner.TESTFIELD("Receivables Account");
                AccountNo := ICPartner."Receivables Account";
            END ELSE BEGIN
                ICPartner.TESTFIELD("Payables Account");
                AccountNo := ICPartner."Payables Account";
            END;

            CreateGLEntryBalAcc(
              GenJnlLine, AccountNo, "Amount (LCY)", "Source Currency Amount",
              "Bal. Account Type", "Bal. Account No.");
        END;
    end;

    local procedure PostJob(GenJnlLine: Record "81"; GLEntry: Record "17")
    var
        JobPostLine: Codeunit "1001";
    begin
        IF JobLine THEN BEGIN
            JobLine := FALSE;
            JobPostLine.PostGenJnlLine(GenJnlLine, GLEntry);
        END;
    end;

    [Scope('Internal')]
    procedure StartPosting(GenJnlLine: Record "81")
    var
        GenJnlTemplate: Record "80";
        AccountingPeriod: Record "50";
    begin
        OnBeforeStartPosting(GenJnlLine);

        WITH GenJnlLine DO BEGIN
            GlobalGLEntry.LOCKTABLE;
            IF GlobalGLEntry.FINDLAST THEN BEGIN
                NextEntryNo := GlobalGLEntry."Entry No." + 1;
                NextTransactionNo := GlobalGLEntry."Transaction No." + 1;
            END ELSE BEGIN
                NextEntryNo := 1;
                NextTransactionNo := 1;
            END;
            FirstTransactionNo := NextTransactionNo;

            InitLastDocDate(GenJnlLine);
            CurrentBalance := 0;

            AccountingPeriod.RESET;
            AccountingPeriod.SETCURRENTKEY(Closed);
            AccountingPeriod.SETRANGE(Closed, FALSE);
            AccountingPeriod.FINDFIRST;
            FiscalYearStartDate := AccountingPeriod."Starting Date";

            GetGLSetup;

            IF NOT GenJnlTemplate.GET("Journal Template Name") THEN
                GenJnlTemplate.INIT;

            VATEntry.LOCKTABLE;
            IF VATEntry.FINDLAST THEN
                NextVATEntryNo := VATEntry."Entry No." + 1
            ELSE
                NextVATEntryNo := 1;
            NextConnectionNo := 1;
            FirstNewVATEntryNo := NextVATEntryNo;

            GLReg.LOCKTABLE;
            IF GLReg.FINDLAST THEN
                GLReg."No." := GLReg."No." + 1
            ELSE
                GLReg."No." := 1;
            GLReg.INIT;
            GLReg."From Entry No." := NextEntryNo;
            GLReg."From VAT Entry No." := NextVATEntryNo;
            GLReg."Creation Date" := TODAY;
            GLReg."Source Code" := "Source Code";
            GLReg."Journal Batch Name" := "Journal Batch Name";
            GLReg."User ID" := USERID;
            IsGLRegInserted := FALSE;

            OnAfterInitGLRegister(GLReg, GenJnlLine);

            GetCurrencyExchRate(GenJnlLine);
            TempGLEntryBuf.DELETEALL;
            CalculateCurrentBalance(
              "Account No.", "Bal. Account No.", IncludeVATAmount, "Amount (LCY)", "VAT Amount");
        END;
    end;

    [Scope('Internal')]
    procedure ContinuePosting(GenJnlLine: Record "81")
    begin
        OnBeforeContinuePosting(GenJnlLine);

        IF NextTransactionNoNeeded(GenJnlLine) THEN BEGIN
            CheckPostUnrealizedVAT(GenJnlLine, FALSE);
            NextTransactionNo := NextTransactionNo + 1;
            InitLastDocDate(GenJnlLine);
            FirstNewVATEntryNo := NextVATEntryNo;
        END;

        GetCurrencyExchRate(GenJnlLine);
        TempGLEntryBuf.DELETEALL;
        CalculateCurrentBalance(
          GenJnlLine."Account No.", GenJnlLine."Bal. Account No.", GenJnlLine.IncludeVATAmount,
          GenJnlLine."Amount (LCY)", GenJnlLine."VAT Amount");
    end;

    local procedure NextTransactionNoNeeded(GenJnlLine: Record "81"): Boolean
    var
        NewTransaction: Boolean;
    begin
        WITH GenJnlLine DO BEGIN
            NewTransaction :=
              (LastDocType <> "Document Type") OR (LastDocNo <> "Document No.") OR
              (LastDate <> "Posting Date") OR ((CurrentBalance = 0) AND (TotalAddCurrAmount = 0)) AND NOT "System-Created Entry";
            IF NOT NewTransaction THEN
                OnNextTransactionNoNeeded(GenJnlLine, LastDocType, LastDocNo, LastDate, CurrentBalance, TotalAddCurrAmount, NewTransaction);
            EXIT(NewTransaction);
        END;
    end;

    [Scope('Internal')]
    procedure FinishPosting() IsTransactionConsistent: Boolean
    var
        CostAccSetup: Record "1108";
        TransferGlEntriesToCA: Codeunit "1105";
    begin
        IsTransactionConsistent :=
          (BalanceCheckAmount = 0) AND (BalanceCheckAmount2 = 0) AND
          (BalanceCheckAddCurrAmount = 0) AND (BalanceCheckAddCurrAmount2 = 0);

        IF TempGLEntryBuf.FINDSET THEN BEGIN
            REPEAT
                GlobalGLEntry := TempGLEntryBuf;
                IF AddCurrencyCode = '' THEN BEGIN
                    GlobalGLEntry."Additional-Currency Amount" := 0;
                    GlobalGLEntry."Add.-Currency Debit Amount" := 0;
                    GlobalGLEntry."Add.-Currency Credit Amount" := 0;
                END;
                GlobalGLEntry."Prior-Year Entry" := GlobalGLEntry."Posting Date" < FiscalYearStartDate;
                GlobalGLEntry.INSERT(TRUE);
                OnAfterInsertGlobalGLEntry(GlobalGLEntry);
            UNTIL TempGLEntryBuf.NEXT = 0;

            GLReg."To VAT Entry No." := NextVATEntryNo - 1;
            GLReg."To Entry No." := GlobalGLEntry."Entry No.";
            IF IsTransactionConsistent THEN
                IF IsGLRegInserted THEN
                    GLReg.MODIFY
                ELSE BEGIN
                    GLReg.INSERT;
                    IsGLRegInserted := TRUE;
                END;
        END;
        GlobalGLEntry.CONSISTENT(IsTransactionConsistent);

        IF CostAccSetup.GET THEN
            IF CostAccSetup."Auto Transfer from G/L" THEN
                TransferGlEntriesToCA.GetGLEntries;

        FirstEntryNo := 0;
    end;

    local procedure PostUnrealizedVAT(GenJnlLine: Record "81")
    begin
        IF CheckUnrealizedCust THEN BEGIN
            CustUnrealizedVAT(GenJnlLine, UnrealizedCustLedgEntry, UnrealizedRemainingAmountCust);
            CheckUnrealizedCust := FALSE;
        END;
        IF CheckUnrealizedVend THEN BEGIN
            VendUnrealizedVAT(GenJnlLine, UnrealizedVendLedgEntry, UnrealizedRemainingAmountVend);
            CheckUnrealizedVend := FALSE;
        END;
    end;

    local procedure CheckPostUnrealizedVAT(GenJnlLine: Record "81"; CheckCurrentBalance: Boolean)
    begin
        IF CheckCurrentBalance AND (CurrentBalance = 0) OR NOT CheckCurrentBalance THEN
            PostUnrealizedVAT(GenJnlLine)
    end;

    local procedure InitGLEntry(GenJnlLine: Record "81"; var GLEntry: Record "17"; GLAccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; UseAmountAddCurr: Boolean; SystemCreatedEntry: Boolean)
    var
        GLAcc: Record "15";
    begin
        IF GLAccNo <> '' THEN BEGIN
            GLAcc.GET(GLAccNo);
            GLAcc.TESTFIELD(Blocked, FALSE);
            GLAcc.TESTFIELD("Account Type", GLAcc."Account Type"::Posting);

            // Check the Value Posting field on the G/L Account if it is not checked already in Codeunit 11
            IF (NOT
                ((GLAccNo = GenJnlLine."Account No.") AND
                 (GenJnlLine."Account Type" = GenJnlLine."Account Type"::"G/L Account")) OR
                ((GLAccNo = GenJnlLine."Bal. Account No.") AND
                 (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"G/L Account"))) AND
               NOT FADimAlreadyChecked
            THEN
                CheckGLAccDimError(GenJnlLine, GLAccNo);
        END;

        GLEntry.INIT;
        GLEntry.CopyFromGenJnlLine(GenJnlLine);
        GLEntry."Entry No." := NextEntryNo;
        GLEntry."Transaction No." := NextTransactionNo;
        GLEntry."G/L Account No." := GLAccNo;
        GLEntry."System-Created Entry" := SystemCreatedEntry;
        GLEntry.Amount := Amount;
        GLEntry."Additional-Currency Amount" :=
          GLCalcAddCurrency(Amount, AmountAddCurr, GLEntry."Additional-Currency Amount", UseAmountAddCurr, GenJnlLine);
    end;

    local procedure InitGLEntryVAT(GenJnlLine: Record "81"; AccNo: Code[20]; BalAccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; UseAmtAddCurr: Boolean)
    var
        GLEntry: Record "17";
    begin
        IF UseAmtAddCurr THEN
            InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, AmountAddCurr, TRUE, TRUE)
        ELSE BEGIN
            InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, 0, FALSE, TRUE);
            GLEntry."Additional-Currency Amount" := AmountAddCurr;
            GLEntry."Bal. Account No." := BalAccNo;
        END;
        SummarizeVAT(GLSetup."Summarize G/L Entries", GLEntry);
    end;

    local procedure InitGLEntryVATCopy(GenJnlLine: Record "81"; AccNo: Code[20]; BalAccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; VATEntry: Record "254"): Integer
    var
        GLEntry: Record "17";
    begin
        InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, 0, FALSE, TRUE);
        GLEntry."Additional-Currency Amount" := AmountAddCurr;
        GLEntry."Bal. Account No." := BalAccNo;
        GLEntry.CopyPostingGroupsFromVATEntry(VATEntry);
        SummarizeVAT(GLSetup."Summarize G/L Entries", GLEntry);

        EXIT(GLEntry."Entry No.");
    end;

    procedure InsertGLEntry(GenJnlLine: Record "81"; GLEntry: Record "17"; CalcAddCurrResiduals: Boolean)
    begin
        WITH GLEntry DO BEGIN
            TESTFIELD("G/L Account No.");

            IF Amount <> ROUND(Amount) THEN
                FIELDERROR(
                  Amount,
                  STRSUBSTNO(NeedsRoundingErr, Amount));

            UpdateCheckAmounts(
              "Posting Date", Amount, "Additional-Currency Amount",
              BalanceCheckAmount, BalanceCheckAmount2, BalanceCheckAddCurrAmount, BalanceCheckAddCurrAmount2);

            UpdateDebitCredit(GenJnlLine.Correction);
        END;

        TempGLEntryBuf := GLEntry;

        OnBeforeInsertGLEntryBuffer(TempGLEntryBuf, GenJnlLine);

        TempGLEntryBuf.INSERT;

        IF FirstEntryNo = 0 THEN
            FirstEntryNo := TempGLEntryBuf."Entry No.";
        NextEntryNo := NextEntryNo + 1;

        IF CalcAddCurrResiduals THEN
            HandleAddCurrResidualGLEntry(GenJnlLine, GLEntry.Amount, GLEntry."Additional-Currency Amount");
    end;

    local procedure CreateGLEntry(GenJnlLine: Record "81"; AccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; UseAmountAddCurr: Boolean)
    var
        GLEntry: Record "17";
    begin
        IF UseAmountAddCurr THEN
            InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, AmountAddCurr, TRUE, TRUE)
        ELSE BEGIN
            InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, 0, FALSE, TRUE);
            GLEntry."Additional-Currency Amount" := AmountAddCurr;
        END;
        InsertGLEntry(GenJnlLine, GLEntry, TRUE);
    end;

    local procedure CreateGLEntryBalAcc(GenJnlLine: Record "81"; AccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; BalAccType: Option; BalAccNo: Code[20])
    var
        GLEntry: Record "17";
    begin
        InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, AmountAddCurr, TRUE, TRUE);
        GLEntry."Bal. Account Type" := BalAccType;
        GLEntry."Bal. Account No." := BalAccNo;
        InsertGLEntry(GenJnlLine, GLEntry, TRUE);
        GenJnlLine.OnMoveGenJournalLine(GLEntry.RECORDID);
    end;

    local procedure CreateGLEntryGainLoss(GenJnlLine: Record "81"; AccNo: Code[20]; Amount: Decimal; UseAmountAddCurr: Boolean)
    var
        GLEntry: Record "17";
    begin
        InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, 0, UseAmountAddCurr, TRUE);
        InsertGLEntry(GenJnlLine, GLEntry, TRUE);
    end;

    local procedure CreateGLEntryVAT(GenJnlLine: Record "81"; AccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; VATAmount: Decimal; DtldCVLedgEntryBuf: Record "383")
    var
        GLEntry: Record "17";
    begin
        InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, 0, FALSE, TRUE);
        GLEntry."Additional-Currency Amount" := AmountAddCurr;
        GLEntry."VAT Amount" := VATAmount;
        GLEntry.CopyPostingGroupsFromDtldCVBuf(DtldCVLedgEntryBuf, DtldCVLedgEntryBuf."Gen. Posting Type");
        InsertGLEntry(GenJnlLine, GLEntry, TRUE);
        InsertVATEntriesFromTemp(DtldCVLedgEntryBuf, GLEntry);
    end;

    local procedure CreateGLEntryVATCollectAdj(GenJnlLine: Record "81"; AccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; VATAmount: Decimal; DtldCVLedgEntryBuf: Record "383"; var AdjAmount: array[4] of Decimal)
    var
        GLEntry: Record "17";
    begin
        InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, 0, FALSE, TRUE);
        GLEntry."Additional-Currency Amount" := AmountAddCurr;
        GLEntry."VAT Amount" := VATAmount;
        GLEntry.CopyPostingGroupsFromDtldCVBuf(DtldCVLedgEntryBuf, DtldCVLedgEntryBuf."Gen. Posting Type");
        InsertGLEntry(GenJnlLine, GLEntry, TRUE);
        CollectAdjustment(AdjAmount, GLEntry.Amount, GLEntry."Additional-Currency Amount");
        InsertVATEntriesFromTemp(DtldCVLedgEntryBuf, GLEntry);
    end;

    local procedure CreateGLEntryFromVATEntry(GenJnlLine: Record "81"; VATAccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; VATEntry: Record "254")
    var
        GLEntry: Record "17";
    begin
        InitGLEntry(GenJnlLine, GLEntry, VATAccNo, Amount, 0, FALSE, TRUE);
        GLEntry."Additional-Currency Amount" := AmountAddCurr;
        GLEntry.CopyPostingGroupsFromVATEntry(VATEntry);
        InsertGLEntry(GenJnlLine, GLEntry, TRUE);
    end;

    local procedure CreateDeferralScheduleFromGL(var GenJournalLine: Record "81"; IsBalancing: Boolean)
    begin
        WITH GenJournalLine DO
            IF ("Account No." <> '') AND ("Deferral Code" <> '') THEN
                IF (("Account Type" IN ["Account Type"::Customer, "Account Type"::Vendor]) AND ("Source Code" = GLSourceCode)) OR
                   ("Account Type" IN ["Account Type"::"G/L Account", "Account Type"::"Bank Account"])
                THEN BEGIN
                    IF NOT IsBalancing THEN
                        CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line", GenJournalLine);
                    DeferralUtilities.CreateScheduleFromGL(GenJournalLine, FirstEntryNo);
                END;
    end;

    local procedure UpdateCheckAmounts(PostingDate: Date; Amount: Decimal; AddCurrAmount: Decimal; var BalanceCheckAmount: Decimal; var BalanceCheckAmount2: Decimal; var BalanceCheckAddCurrAmount: Decimal; var BalanceCheckAddCurrAmount2: Decimal)
    begin
        IF PostingDate = NORMALDATE(PostingDate) THEN BEGIN
            BalanceCheckAmount :=
              BalanceCheckAmount + Amount * ((PostingDate - 01010000D) MOD 99 + 1);
            BalanceCheckAmount2 :=
              BalanceCheckAmount2 + Amount * ((PostingDate - 01010000D) MOD 98 + 1);
        END ELSE BEGIN
            BalanceCheckAmount :=
              BalanceCheckAmount + Amount * ((NORMALDATE(PostingDate) - 01010000D + 50) MOD 99 + 1);
            BalanceCheckAmount2 :=
              BalanceCheckAmount2 + Amount * ((NORMALDATE(PostingDate) - 01010000D + 50) MOD 98 + 1);
        END;

        IF AddCurrencyCode <> '' THEN
            IF PostingDate = NORMALDATE(PostingDate) THEN BEGIN
                BalanceCheckAddCurrAmount :=
                  BalanceCheckAddCurrAmount + AddCurrAmount * ((PostingDate - 01010000D) MOD 99 + 1);
                BalanceCheckAddCurrAmount2 :=
                  BalanceCheckAddCurrAmount2 + AddCurrAmount * ((PostingDate - 01010000D) MOD 98 + 1);
            END ELSE BEGIN
                BalanceCheckAddCurrAmount :=
                  BalanceCheckAddCurrAmount +
                  AddCurrAmount * ((NORMALDATE(PostingDate) - 01010000D + 50) MOD 99 + 1);
                BalanceCheckAddCurrAmount2 :=
                  BalanceCheckAddCurrAmount2 +
                  AddCurrAmount * ((NORMALDATE(PostingDate) - 01010000D + 50) MOD 98 + 1);
            END
        ELSE BEGIN
            BalanceCheckAddCurrAmount := 0;
            BalanceCheckAddCurrAmount2 := 0;
        END;
    end;

    local procedure CalcPmtDiscPossible(GenJnlLine: Record "81"; var CVLedgEntryBuf: Record "382")
    begin
        WITH GenJnlLine DO
            IF "Amount (LCY)" <> 0 THEN BEGIN
                IF (CVLedgEntryBuf."Pmt. Discount Date" >= CVLedgEntryBuf."Posting Date") OR
                   (CVLedgEntryBuf."Pmt. Discount Date" = 0D)
                THEN BEGIN
                    IF GLSetup."Pmt. Disc. Excl. VAT" THEN BEGIN
                        IF "Sales/Purch. (LCY)" = 0 THEN
                            CVLedgEntryBuf."Original Pmt. Disc. Possible" :=
                              ("Amount (LCY)" + TotalVATAmountOnJnlLines(GenJnlLine)) * Amount / "Amount (LCY)"
                        ELSE
                            CVLedgEntryBuf."Original Pmt. Disc. Possible" := "Sales/Purch. (LCY)" * Amount / "Amount (LCY)"
                    END ELSE
                        CVLedgEntryBuf."Original Pmt. Disc. Possible" := Amount;
                    CVLedgEntryBuf."Original Pmt. Disc. Possible" :=
                      ROUND(
                        CVLedgEntryBuf."Original Pmt. Disc. Possible" * "Payment Discount %" / 100, AmountRoundingPrecision);
                END;
                CVLedgEntryBuf."Remaining Pmt. Disc. Possible" := CVLedgEntryBuf."Original Pmt. Disc. Possible";
            END;
    end;

    local procedure CalcPmtTolerancePossible(GenJnlLine: Record "81"; PmtDiscountDate: Date; var PmtDiscToleranceDate: Date; var MaxPaymentTolerance: Decimal)
    begin
        WITH GenJnlLine DO
            IF "Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo"] THEN BEGIN
                IF PmtDiscountDate <> 0D THEN
                    PmtDiscToleranceDate :=
                      CALCDATE(GLSetup."Payment Discount Grace Period", PmtDiscountDate)
                ELSE
                    PmtDiscToleranceDate := PmtDiscountDate;

                CASE "Account Type" OF
                    "Account Type"::Customer:
                        PaymentToleranceMgt.CalcMaxPmtTolerance(
                          "Document Type", "Currency Code", Amount, "Amount (LCY)", 1, MaxPaymentTolerance);
                    "Account Type"::Vendor:
                        PaymentToleranceMgt.CalcMaxPmtTolerance(
                          "Document Type", "Currency Code", Amount, "Amount (LCY)", -1, MaxPaymentTolerance);
                END;
            END;
    end;

    local procedure CalcPmtTolerance(var NewCVLedgEntryBuf: Record "382"; var OldCVLedgEntryBuf: Record "382"; var OldCVLedgEntryBuf2: Record "382"; var DtldCVLedgEntryBuf: Record "383"; GenJnlLine: Record "81"; var PmtTolAmtToBeApplied: Decimal; NextTransactionNo: Integer; FirstNewVATEntryNo: Integer)
    var
        PmtTol: Decimal;
        PmtTolLCY: Decimal;
        PmtTolAddCurr: Decimal;
    begin
        IF OldCVLedgEntryBuf2."Accepted Payment Tolerance" = 0 THEN
            EXIT;

        PmtTol := -OldCVLedgEntryBuf2."Accepted Payment Tolerance";
        PmtTolAmtToBeApplied := PmtTolAmtToBeApplied + PmtTol;
        PmtTolLCY :=
          ROUND(
            (NewCVLedgEntryBuf."Original Amount" + PmtTol) / NewCVLedgEntryBuf."Original Currency Factor") -
          NewCVLedgEntryBuf."Original Amt. (LCY)";

        OldCVLedgEntryBuf."Accepted Payment Tolerance" := 0;
        OldCVLedgEntryBuf."Pmt. Tolerance (LCY)" := -PmtTolLCY;

        IF NewCVLedgEntryBuf."Currency Code" = AddCurrencyCode THEN
            PmtTolAddCurr := PmtTol
        ELSE
            PmtTolAddCurr := CalcLCYToAddCurr(PmtTolLCY);

        IF NOT GLSetup."Pmt. Disc. Excl. VAT" AND GLSetup."Adjust for Payment Disc." AND (PmtTolLCY <> 0) THEN
            CalcPmtDiscIfAdjVAT(
              NewCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine, PmtTolLCY, PmtTolAddCurr,
              NextTransactionNo, FirstNewVATEntryNo, DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance (VAT Excl.)");

        DtldCVLedgEntryBuf.InitDtldCVLedgEntryBuf(
          GenJnlLine, NewCVLedgEntryBuf, DtldCVLedgEntryBuf,
          DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance", PmtTol, PmtTolLCY, PmtTolAddCurr, 0, 0, 0);
    end;

    local procedure CalcPmtDisc(var NewCVLedgEntryBuf: Record "382"; var OldCVLedgEntryBuf: Record "382"; var OldCVLedgEntryBuf2: Record "382"; var DtldCVLedgEntryBuf: Record "383"; GenJnlLine: Record "81"; PmtTolAmtToBeApplied: Decimal; ApplnRoundingPrecision: Decimal; NextTransactionNo: Integer; FirstNewVATEntryNo: Integer)
    var
        PmtDisc: Decimal;
        PmtDiscLCY: Decimal;
        PmtDiscAddCurr: Decimal;
        MinimalPossibleLiability: Decimal;
        PaymentExceedsLiability: Boolean;
        ToleratedPaymentExceedsLiability: Boolean;
    begin
        MinimalPossibleLiability := ABS(OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2."Remaining Pmt. Disc. Possible");
        PaymentExceedsLiability := ABS(OldCVLedgEntryBuf2."Amount to Apply") >= MinimalPossibleLiability;
        ToleratedPaymentExceedsLiability := ABS(NewCVLedgEntryBuf."Remaining Amount" + PmtTolAmtToBeApplied) >= MinimalPossibleLiability;

        IF (PaymentToleranceMgt.CheckCalcPmtDisc(NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, TRUE, TRUE) AND
            ((OldCVLedgEntryBuf2."Amount to Apply" = 0) OR PaymentExceedsLiability) OR
            (PaymentToleranceMgt.CheckCalcPmtDisc(NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, FALSE, FALSE) AND
             (OldCVLedgEntryBuf2."Amount to Apply" <> 0) AND PaymentExceedsLiability AND ToleratedPaymentExceedsLiability))
        THEN BEGIN
            PmtDisc := -OldCVLedgEntryBuf2."Remaining Pmt. Disc. Possible";
            PmtDiscLCY :=
              ROUND(
                (NewCVLedgEntryBuf."Original Amount" + PmtDisc) / NewCVLedgEntryBuf."Original Currency Factor") -
              NewCVLedgEntryBuf."Original Amt. (LCY)";

            OldCVLedgEntryBuf."Pmt. Disc. Given (LCY)" := -PmtDiscLCY;

            IF (NewCVLedgEntryBuf."Currency Code" = AddCurrencyCode) AND (AddCurrencyCode <> '') THEN
                PmtDiscAddCurr := PmtDisc
            ELSE
                PmtDiscAddCurr := CalcLCYToAddCurr(PmtDiscLCY);

            IF NOT GLSetup."Pmt. Disc. Excl. VAT" AND GLSetup."Adjust for Payment Disc." AND
               (PmtDiscLCY <> 0)
            THEN
                CalcPmtDiscIfAdjVAT(
                  NewCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine, PmtDiscLCY, PmtDiscAddCurr,
                  NextTransactionNo, FirstNewVATEntryNo, DtldCVLedgEntryBuf."Entry Type"::"Payment Discount (VAT Excl.)");

            DtldCVLedgEntryBuf.InitDtldCVLedgEntryBuf(
              GenJnlLine, NewCVLedgEntryBuf, DtldCVLedgEntryBuf,
              DtldCVLedgEntryBuf."Entry Type"::"Payment Discount", PmtDisc, PmtDiscLCY, PmtDiscAddCurr, 0, 0, 0);
        END;
    end;

    local procedure CalcPmtDiscIfAdjVAT(var NewCVLedgEntryBuf: Record "382"; var OldCVLedgEntryBuf: Record "382"; var DtldCVLedgEntryBuf: Record "383"; GenJnlLine: Record "81"; var PmtDiscLCY2: Decimal; var PmtDiscAddCurr2: Decimal; NextTransactionNo: Integer; FirstNewVATEntryNo: Integer; EntryType: Integer)
    var
        VATEntry2: Record "254";
        VATPostingSetup: Record "325";
        TaxJurisdiction: Record "320";
        DtldCVLedgEntryBuf2: Record "383";
        OriginalAmountAddCurr: Decimal;
        PmtDiscRounding: Decimal;
        PmtDiscRoundingAddCurr: Decimal;
        PmtDiscFactorLCY: Decimal;
        PmtDiscFactorAddCurr: Decimal;
        VATBase: Decimal;
        VATBaseAddCurr: Decimal;
        VATAmount: Decimal;
        VATAmountAddCurr: Decimal;
        TotalVATAmount: Decimal;
        LastConnectionNo: Integer;
        VATEntryModifier: Integer;
    begin
        IF OldCVLedgEntryBuf."Original Amt. (LCY)" = 0 THEN
            EXIT;

        IF (AddCurrencyCode = '') OR (AddCurrencyCode = OldCVLedgEntryBuf."Currency Code") THEN
            OriginalAmountAddCurr := OldCVLedgEntryBuf.Amount
        ELSE
            OriginalAmountAddCurr := CalcLCYToAddCurr(OldCVLedgEntryBuf."Original Amt. (LCY)");

        PmtDiscRounding := PmtDiscLCY2;
        PmtDiscFactorLCY := PmtDiscLCY2 / OldCVLedgEntryBuf."Original Amt. (LCY)";
        IF OriginalAmountAddCurr <> 0 THEN
            PmtDiscFactorAddCurr := PmtDiscAddCurr2 / OriginalAmountAddCurr
        ELSE
            PmtDiscFactorAddCurr := 0;
        VATEntry2.RESET;
        VATEntry2.SETCURRENTKEY("Transaction No.");
        VATEntry2.SETRANGE("Transaction No.", OldCVLedgEntryBuf."Transaction No.");
        IF OldCVLedgEntryBuf."Transaction No." = NextTransactionNo THEN
            VATEntry2.SETRANGE("Entry No.", 0, FirstNewVATEntryNo - 1);
        IF VATEntry2.FINDSET THEN BEGIN
            TotalVATAmount := 0;
            LastConnectionNo := 0;
            REPEAT
                VATPostingSetup.GET(VATEntry2."VAT Bus. Posting Group", VATEntry2."VAT Prod. Posting Group");
                IF VATEntry2."VAT Calculation Type" =
                   VATEntry2."VAT Calculation Type"::"Sales Tax"
                THEN BEGIN
                    TaxJurisdiction.GET(VATEntry2."Tax Jurisdiction Code");
                    VATPostingSetup."Adjust for Payment Discount" :=
                      TaxJurisdiction."Adjust for Payment Discount";
                END;
                IF VATPostingSetup."Adjust for Payment Discount" THEN BEGIN
                    IF LastConnectionNo <> VATEntry2."Sales Tax Connection No." THEN BEGIN
                        IF LastConnectionNo <> 0 THEN BEGIN
                            DtldCVLedgEntryBuf := DtldCVLedgEntryBuf2;
                            DtldCVLedgEntryBuf."VAT Amount (LCY)" := -TotalVATAmount;
                            DtldCVLedgEntryBuf.InsertDtldCVLedgEntry(DtldCVLedgEntryBuf, NewCVLedgEntryBuf, FALSE);
                            InsertSummarizedVAT(GenJnlLine);
                        END;

                        CalcPmtDiscVATBases(VATEntry2, VATBase, VATBaseAddCurr);

                        PmtDiscRounding := PmtDiscRounding + VATBase * PmtDiscFactorLCY;
                        VATBase := ROUND(PmtDiscRounding - PmtDiscLCY2);
                        PmtDiscLCY2 := PmtDiscLCY2 + VATBase;

                        PmtDiscRoundingAddCurr := PmtDiscRoundingAddCurr + VATBaseAddCurr * PmtDiscFactorAddCurr;
                        VATBaseAddCurr := ROUND(CalcLCYToAddCurr(VATBase), AddCurrency."Amount Rounding Precision");
                        PmtDiscAddCurr2 := PmtDiscAddCurr2 + VATBaseAddCurr;

                        DtldCVLedgEntryBuf2.INIT;
                        DtldCVLedgEntryBuf2."Posting Date" := GenJnlLine."Posting Date";
                        DtldCVLedgEntryBuf2."Document Type" := GenJnlLine."Document Type";
                        DtldCVLedgEntryBuf2."Document No." := GenJnlLine."Document No.";
                        DtldCVLedgEntryBuf2.Amount := 0;
                        DtldCVLedgEntryBuf2."Amount (LCY)" := -VATBase;
                        DtldCVLedgEntryBuf2."Entry Type" := EntryType;
                        CASE EntryType OF
                            DtldCVLedgEntryBuf."Entry Type"::"Payment Discount Tolerance (VAT Excl.)":
                                VATEntryModifier := 1000000;
                            DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance (VAT Excl.)":
                                VATEntryModifier := 2000000;
                            DtldCVLedgEntryBuf."Entry Type"::"Payment Discount (VAT Excl.)":
                                VATEntryModifier := 3000000;
                        END;
                        DtldCVLedgEntryBuf2.CopyFromCVLedgEntryBuf(NewCVLedgEntryBuf);
                        // The total payment discount in currency is posted on the entry made in
                        // the function CalcPmtDisc.
                        DtldCVLedgEntryBuf2."User ID" := USERID;
                        DtldCVLedgEntryBuf2."Additional-Currency Amount" := -VATBaseAddCurr;
                        DtldCVLedgEntryBuf2.CopyPostingGroupsFromVATEntry(VATEntry2);
                        TotalVATAmount := 0;
                        LastConnectionNo := VATEntry2."Sales Tax Connection No.";
                    END;

                    CalcPmtDiscVATAmounts(
                      VATEntry2, VATBase, VATBaseAddCurr, VATAmount, VATAmountAddCurr,
                      PmtDiscRounding, PmtDiscFactorLCY, PmtDiscLCY2, PmtDiscAddCurr2);

                    TotalVATAmount := TotalVATAmount + VATAmount;

                    IF (PmtDiscAddCurr2 <> 0) AND (PmtDiscLCY2 = 0) THEN BEGIN
                        VATAmountAddCurr := VATAmountAddCurr - PmtDiscAddCurr2;
                        PmtDiscAddCurr2 := 0;
                    END;

                    // Post VAT
                    // VAT for VAT entry
                    IF VATEntry2.Type <> 0 THEN
                        InsertPmtDiscVATForVATEntry(
                          GenJnlLine, TempVATEntry, VATEntry2, VATEntryModifier,
                          VATAmount, VATAmountAddCurr, VATBase, VATBaseAddCurr,
                          PmtDiscFactorLCY, PmtDiscFactorAddCurr);

                    // VAT for G/L entry/entries
                    InsertPmtDiscVATForGLEntry(
                      GenJnlLine, DtldCVLedgEntryBuf, NewCVLedgEntryBuf, VATEntry2,
                      VATPostingSetup, TaxJurisdiction, EntryType, VATAmount, VATAmountAddCurr);
                END;
            UNTIL VATEntry2.NEXT = 0;

            IF LastConnectionNo <> 0 THEN BEGIN
                DtldCVLedgEntryBuf := DtldCVLedgEntryBuf2;
                DtldCVLedgEntryBuf."VAT Amount (LCY)" := -TotalVATAmount;
                DtldCVLedgEntryBuf.InsertDtldCVLedgEntry(DtldCVLedgEntryBuf, NewCVLedgEntryBuf, TRUE);
                InsertSummarizedVAT(GenJnlLine);
            END;
        END;
    end;

    local procedure CalcPmtDiscTolerance(var NewCVLedgEntryBuf: Record "382"; var OldCVLedgEntryBuf: Record "382"; var OldCVLedgEntryBuf2: Record "382"; var DtldCVLedgEntryBuf: Record "383"; GenJnlLine: Record "81"; NextTransactionNo: Integer; FirstNewVATEntryNo: Integer)
    var
        PmtDiscTol: Decimal;
        PmtDiscTolLCY: Decimal;
        PmtDiscTolAddCurr: Decimal;
    begin
        IF NOT OldCVLedgEntryBuf2."Accepted Pmt. Disc. Tolerance" THEN
            EXIT;

        PmtDiscTol := -OldCVLedgEntryBuf2."Remaining Pmt. Disc. Possible";
        PmtDiscTolLCY :=
          ROUND(
            (NewCVLedgEntryBuf."Original Amount" + PmtDiscTol) / NewCVLedgEntryBuf."Original Currency Factor") -
          NewCVLedgEntryBuf."Original Amt. (LCY)";

        OldCVLedgEntryBuf."Pmt. Disc. Given (LCY)" := -PmtDiscTolLCY;

        IF NewCVLedgEntryBuf."Currency Code" = AddCurrencyCode THEN
            PmtDiscTolAddCurr := PmtDiscTol
        ELSE
            PmtDiscTolAddCurr := CalcLCYToAddCurr(PmtDiscTolLCY);

        IF NOT GLSetup."Pmt. Disc. Excl. VAT" AND GLSetup."Adjust for Payment Disc." AND (PmtDiscTolLCY <> 0) THEN
            CalcPmtDiscIfAdjVAT(
              NewCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine, PmtDiscTolLCY, PmtDiscTolAddCurr,
              NextTransactionNo, FirstNewVATEntryNo, DtldCVLedgEntryBuf."Entry Type"::"Payment Discount Tolerance (VAT Excl.)");

        DtldCVLedgEntryBuf.InitDtldCVLedgEntryBuf(
          GenJnlLine, NewCVLedgEntryBuf, DtldCVLedgEntryBuf,
          DtldCVLedgEntryBuf."Entry Type"::"Payment Discount Tolerance", PmtDiscTol, PmtDiscTolLCY, PmtDiscTolAddCurr, 0, 0, 0);
    end;

    local procedure CalcPmtDiscVATBases(VATEntry2: Record "254"; var VATBase: Decimal; var VATBaseAddCurr: Decimal)
    var
        VATEntry: Record "254";
    begin
        CASE VATEntry2."VAT Calculation Type" OF
            VATEntry2."VAT Calculation Type"::"Normal VAT",
            VATEntry2."VAT Calculation Type"::"Reverse Charge VAT",
            VATEntry2."VAT Calculation Type"::"Full VAT":
                BEGIN
                    VATBase :=
                      VATEntry2.Base + VATEntry2."Unrealized Base";
                    VATBaseAddCurr :=
                      VATEntry2."Additional-Currency Base" +
                      VATEntry2."Add.-Currency Unrealized Base";
                END;
            VATEntry2."VAT Calculation Type"::"Sales Tax":
                BEGIN
                    VATEntry.RESET;
                    VATEntry.SETCURRENTKEY("Transaction No.");
                    VATEntry.SETRANGE("Transaction No.", VATEntry2."Transaction No.");
                    VATEntry.SETRANGE("Sales Tax Connection No.", VATEntry2."Sales Tax Connection No.");
                    VATEntry := VATEntry2;
                    REPEAT
                        IF VATEntry.Base < 0 THEN
                            VATEntry.SETFILTER(Base, '>%1', VATEntry.Base)
                        ELSE
                            VATEntry.SETFILTER(Base, '<%1', VATEntry.Base);
                    UNTIL NOT VATEntry.FINDLAST;
                    VATEntry.RESET;
                    VATBase :=
                      VATEntry.Base + VATEntry."Unrealized Base";
                    VATBaseAddCurr :=
                      VATEntry."Additional-Currency Base" +
                      VATEntry."Add.-Currency Unrealized Base";
                END;
        END;
    end;

    local procedure CalcPmtDiscVATAmounts(VATEntry2: Record "254"; VATBase: Decimal; VATBaseAddCurr: Decimal; var VATAmount: Decimal; var VATAmountAddCurr: Decimal; var PmtDiscRounding: Decimal; PmtDiscFactorLCY: Decimal; var PmtDiscLCY2: Decimal; var PmtDiscAddCurr2: Decimal)
    begin
        CASE VATEntry2."VAT Calculation Type" OF
            VATEntry2."VAT Calculation Type"::"Normal VAT",
          VATEntry2."VAT Calculation Type"::"Full VAT":
                IF (VATEntry2.Amount + VATEntry2."Unrealized Amount" <> 0) OR
                   (VATEntry2."Additional-Currency Amount" + VATEntry2."Add.-Currency Unrealized Amt." <> 0)
                THEN BEGIN
                    IF (VATBase = 0) AND
                       (VATEntry2."VAT Calculation Type" <> VATEntry2."VAT Calculation Type"::"Full VAT")
                    THEN
                        VATAmount := 0
                    ELSE BEGIN
                        PmtDiscRounding :=
                          PmtDiscRounding +
                          (VATEntry2.Amount + VATEntry2."Unrealized Amount") * PmtDiscFactorLCY;
                        VATAmount := ROUND(PmtDiscRounding - PmtDiscLCY2);
                        PmtDiscLCY2 := PmtDiscLCY2 + VATAmount;
                    END;
                    IF (VATBaseAddCurr = 0) AND
                       (VATEntry2."VAT Calculation Type" <> VATEntry2."VAT Calculation Type"::"Full VAT")
                    THEN
                        VATAmountAddCurr := 0
                    ELSE BEGIN
                        VATAmountAddCurr := ROUND(CalcLCYToAddCurr(VATAmount), AddCurrency."Amount Rounding Precision");
                        PmtDiscAddCurr2 := PmtDiscAddCurr2 + VATAmountAddCurr;
                    END;
                END ELSE BEGIN
                    VATAmount := 0;
                    VATAmountAddCurr := 0;
                END;
            VATEntry2."VAT Calculation Type"::"Reverse Charge VAT":
                BEGIN
                    VATAmount :=
                      ROUND((VATEntry2.Amount + VATEntry2."Unrealized Amount") * PmtDiscFactorLCY);
                    VATAmountAddCurr := ROUND(CalcLCYToAddCurr(VATAmount), AddCurrency."Amount Rounding Precision");
                END;
            VATEntry2."VAT Calculation Type"::"Sales Tax":
                IF (VATEntry2.Type = VATEntry2.Type::Purchase) AND VATEntry2."Use Tax" THEN BEGIN
                    VATAmount :=
                      ROUND((VATEntry2.Amount + VATEntry2."Unrealized Amount") * PmtDiscFactorLCY);
                    VATAmountAddCurr := ROUND(CalcLCYToAddCurr(VATAmount), AddCurrency."Amount Rounding Precision");
                END ELSE
                    IF (VATEntry2.Amount + VATEntry2."Unrealized Amount" <> 0) OR
                       (VATEntry2."Additional-Currency Amount" + VATEntry2."Add.-Currency Unrealized Amt." <> 0)
                    THEN BEGIN
                        IF VATBase = 0 THEN
                            VATAmount := 0
                        ELSE BEGIN
                            PmtDiscRounding :=
                              PmtDiscRounding +
                              (VATEntry2.Amount + VATEntry2."Unrealized Amount") * PmtDiscFactorLCY;
                            VATAmount := ROUND(PmtDiscRounding - PmtDiscLCY2);
                            PmtDiscLCY2 := PmtDiscLCY2 + VATAmount;
                        END;

                        IF VATBaseAddCurr = 0 THEN
                            VATAmountAddCurr := 0
                        ELSE BEGIN
                            VATAmountAddCurr := ROUND(CalcLCYToAddCurr(VATAmount), AddCurrency."Amount Rounding Precision");
                            PmtDiscAddCurr2 := PmtDiscAddCurr2 + VATAmountAddCurr;
                        END;
                    END ELSE BEGIN
                        VATAmount := 0;
                        VATAmountAddCurr := 0;
                    END;
        END;
    end;

    local procedure InsertPmtDiscVATForVATEntry(GenJnlLine: Record "81"; var TempVATEntry: Record "254" temporary; VATEntry2: Record "254"; VATEntryModifier: Integer; VATAmount: Decimal; VATAmountAddCurr: Decimal; VATBase: Decimal; VATBaseAddCurr: Decimal; PmtDiscFactorLCY: Decimal; PmtDiscFactorAddCurr: Decimal)
    var
        TempVATEntryNo: Integer;
    begin
        TempVATEntry.RESET;
        TempVATEntry.SETRANGE("Entry No.", VATEntryModifier, VATEntryModifier + 999999);
        IF TempVATEntry.FINDLAST THEN
            TempVATEntryNo := TempVATEntry."Entry No." + 1
        ELSE
            TempVATEntryNo := VATEntryModifier + 1;
        TempVATEntry := VATEntry2;
        TempVATEntry."Entry No." := TempVATEntryNo;
        TempVATEntry."Posting Date" := GenJnlLine."Posting Date";
        TempVATEntry."Document No." := GenJnlLine."Document No.";
        TempVATEntry."External Document No." := GenJnlLine."External Document No.";
        TempVATEntry."Document Type" := GenJnlLine."Document Type";
        TempVATEntry."Source Code" := GenJnlLine."Source Code";
        TempVATEntry."Reason Code" := GenJnlLine."Reason Code";
        TempVATEntry."Transaction No." := NextTransactionNo;
        TempVATEntry."Sales Tax Connection No." := NextConnectionNo;
        TempVATEntry."Unrealized Amount" := 0;
        TempVATEntry."Unrealized Base" := 0;
        TempVATEntry."Remaining Unrealized Amount" := 0;
        TempVATEntry."Remaining Unrealized Base" := 0;
        TempVATEntry."User ID" := USERID;
        TempVATEntry."Closed by Entry No." := 0;
        TempVATEntry.Closed := FALSE;
        TempVATEntry."Internal Ref. No." := '';
        TempVATEntry.Amount := VATAmount;
        TempVATEntry."Additional-Currency Amount" := VATAmountAddCurr;
        TempVATEntry."VAT Difference" := 0;
        TempVATEntry."Add.-Curr. VAT Difference" := 0;
        TempVATEntry."Add.-Currency Unrealized Amt." := 0;
        TempVATEntry."Add.-Currency Unrealized Base" := 0;
        IF VATEntry2."Tax on Tax" THEN BEGIN
            TempVATEntry.Base :=
              ROUND((VATEntry2.Base + VATEntry2."Unrealized Base") * PmtDiscFactorLCY);
            TempVATEntry."Additional-Currency Base" :=
              ROUND(
                (VATEntry2."Additional-Currency Base" +
                 VATEntry2."Add.-Currency Unrealized Base") * PmtDiscFactorAddCurr,
                AddCurrency."Amount Rounding Precision");
        END ELSE BEGIN
            TempVATEntry.Base := VATBase;
            TempVATEntry."Additional-Currency Base" := VATBaseAddCurr;
        END;

        IF AddCurrencyCode = '' THEN BEGIN
            TempVATEntry."Additional-Currency Base" := 0;
            TempVATEntry."Additional-Currency Amount" := 0;
            TempVATEntry."Add.-Currency Unrealized Amt." := 0;
            TempVATEntry."Add.-Currency Unrealized Base" := 0;
        END;
        TempVATEntry.INSERT;
    end;

    local procedure InsertPmtDiscVATForGLEntry(GenJnlLine: Record "81"; var DtldCVLedgEntryBuf: Record "383"; var NewCVLedgEntryBuf: Record "382"; VATEntry2: Record "254"; var VATPostingSetup: Record "325"; var TaxJurisdiction: Record "320"; EntryType: Integer; VATAmount: Decimal; VATAmountAddCurr: Decimal)
    begin
        DtldCVLedgEntryBuf.INIT;
        DtldCVLedgEntryBuf.CopyFromCVLedgEntryBuf(NewCVLedgEntryBuf);
        CASE EntryType OF
            DtldCVLedgEntryBuf."Entry Type"::"Payment Discount (VAT Excl.)":
                DtldCVLedgEntryBuf."Entry Type" :=
                  DtldCVLedgEntryBuf."Entry Type"::"Payment Discount (VAT Adjustment)";
            DtldCVLedgEntryBuf."Entry Type"::"Payment Discount Tolerance (VAT Excl.)":
                DtldCVLedgEntryBuf."Entry Type" :=
                  DtldCVLedgEntryBuf."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)";
            DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance (VAT Excl.)":
                DtldCVLedgEntryBuf."Entry Type" :=
                  DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance (VAT Adjustment)";
        END;
        DtldCVLedgEntryBuf."Posting Date" := GenJnlLine."Posting Date";
        DtldCVLedgEntryBuf."Document Type" := GenJnlLine."Document Type";
        DtldCVLedgEntryBuf."Document No." := GenJnlLine."Document No.";
        DtldCVLedgEntryBuf.Amount := 0;
        DtldCVLedgEntryBuf."VAT Bus. Posting Group" := VATEntry2."VAT Bus. Posting Group";
        DtldCVLedgEntryBuf."VAT Prod. Posting Group" := VATEntry2."VAT Prod. Posting Group";
        DtldCVLedgEntryBuf."Tax Jurisdiction Code" := VATEntry2."Tax Jurisdiction Code";
        // The total payment discount in currency is posted on the entry made in
        // the function CalcPmtDisc.
        DtldCVLedgEntryBuf."User ID" := USERID;
        DtldCVLedgEntryBuf."Use Additional-Currency Amount" := TRUE;

        CASE VATEntry2.Type OF
            VATEntry2.Type::Purchase:
                CASE VATEntry2."VAT Calculation Type" OF
                    VATEntry2."VAT Calculation Type"::"Normal VAT",
                    VATEntry2."VAT Calculation Type"::"Full VAT":
                        BEGIN
                            InitGLEntryVAT(GenJnlLine, VATPostingSetup.GetPurchAccount(FALSE), '',
                              VATAmount, VATAmountAddCurr, FALSE);
                            DtldCVLedgEntryBuf."Amount (LCY)" := -VATAmount;
                            DtldCVLedgEntryBuf."Additional-Currency Amount" := -VATAmountAddCurr;
                            DtldCVLedgEntryBuf.InsertDtldCVLedgEntry(DtldCVLedgEntryBuf, NewCVLedgEntryBuf, TRUE);
                        END;
                    VATEntry2."VAT Calculation Type"::"Reverse Charge VAT":
                        BEGIN
                            InitGLEntryVAT(GenJnlLine, VATPostingSetup.GetPurchAccount(FALSE), '',
                              VATAmount, VATAmountAddCurr, FALSE);
                            InitGLEntryVAT(GenJnlLine, VATPostingSetup.GetRevChargeAccount(FALSE), '',
                              -VATAmount, -VATAmountAddCurr, FALSE);
                        END;
                    VATEntry2."VAT Calculation Type"::"Sales Tax":
                        IF VATEntry2."Use Tax" THEN BEGIN
                            InitGLEntryVAT(GenJnlLine, TaxJurisdiction.GetPurchAccount(FALSE), '',
                              VATAmount, VATAmountAddCurr, FALSE);
                            InitGLEntryVAT(GenJnlLine, TaxJurisdiction.GetRevChargeAccount(FALSE), '',
                              -VATAmount, -VATAmountAddCurr, FALSE);
                        END ELSE BEGIN
                            InitGLEntryVAT(GenJnlLine, TaxJurisdiction.GetPurchAccount(FALSE), '',
                              VATAmount, VATAmountAddCurr, FALSE);
                            DtldCVLedgEntryBuf."Amount (LCY)" := -VATAmount;
                            DtldCVLedgEntryBuf."Additional-Currency Amount" := -VATAmountAddCurr;
                            DtldCVLedgEntryBuf.InsertDtldCVLedgEntry(DtldCVLedgEntryBuf, NewCVLedgEntryBuf, TRUE);
                        END;
                END;
            VATEntry2.Type::Sale:
                CASE VATEntry2."VAT Calculation Type" OF
                    VATEntry2."VAT Calculation Type"::"Normal VAT",
                    VATEntry2."VAT Calculation Type"::"Full VAT":
                        BEGIN
                            InitGLEntryVAT(
                              GenJnlLine, VATPostingSetup.GetSalesAccount(FALSE), '',
                              VATAmount, VATAmountAddCurr, FALSE);
                            DtldCVLedgEntryBuf."Amount (LCY)" := -VATAmount;
                            DtldCVLedgEntryBuf."Additional-Currency Amount" := -VATAmountAddCurr;
                            DtldCVLedgEntryBuf.InsertDtldCVLedgEntry(DtldCVLedgEntryBuf, NewCVLedgEntryBuf, TRUE);
                        END;
                    VATEntry2."VAT Calculation Type"::"Reverse Charge VAT":
                        ;
                    VATEntry2."VAT Calculation Type"::"Sales Tax":
                        BEGIN
                            InitGLEntryVAT(
                              GenJnlLine, TaxJurisdiction.GetSalesAccount(FALSE), '',
                              VATAmount, VATAmountAddCurr, FALSE);
                            DtldCVLedgEntryBuf."Amount (LCY)" := -VATAmount;
                            DtldCVLedgEntryBuf."Additional-Currency Amount" := -VATAmountAddCurr;
                            DtldCVLedgEntryBuf.InsertDtldCVLedgEntry(DtldCVLedgEntryBuf, NewCVLedgEntryBuf, TRUE);
                        END;
                END;
        END;
    end;

    local procedure CalcCurrencyApplnRounding(var NewCVLedgEntryBuf: Record "382"; var OldCVLedgEntryBuf: Record "382"; var DtldCVLedgEntryBuf: Record "383"; GenJnlLine: Record "81"; ApplnRoundingPrecision: Decimal)
    var
        ApplnRounding: Decimal;
        ApplnRoundingLCY: Decimal;
    begin
        IF ((NewCVLedgEntryBuf."Document Type" <> NewCVLedgEntryBuf."Document Type"::Payment) AND
            (NewCVLedgEntryBuf."Document Type" <> NewCVLedgEntryBuf."Document Type"::Refund)) OR
           (NewCVLedgEntryBuf."Currency Code" = OldCVLedgEntryBuf."Currency Code")
        THEN
            EXIT;

        ApplnRounding := -(NewCVLedgEntryBuf."Remaining Amount" + OldCVLedgEntryBuf."Remaining Amount");
        ApplnRoundingLCY := ROUND(ApplnRounding / NewCVLedgEntryBuf."Adjusted Currency Factor");

        IF (ApplnRounding = 0) OR (ABS(ApplnRounding) > ApplnRoundingPrecision) THEN
            EXIT;

        DtldCVLedgEntryBuf.InitDtldCVLedgEntryBuf(
          GenJnlLine, NewCVLedgEntryBuf, DtldCVLedgEntryBuf,
          DtldCVLedgEntryBuf."Entry Type"::"Appln. Rounding", ApplnRounding, ApplnRoundingLCY, ApplnRounding, 0, 0, 0);
    end;

    local procedure FindAmtForAppln(var NewCVLedgEntryBuf: Record "382"; var OldCVLedgEntryBuf: Record "382"; var OldCVLedgEntryBuf2: Record "382"; var AppliedAmount: Decimal; var AppliedAmountLCY: Decimal; var OldAppliedAmount: Decimal; ApplnRoundingPrecision: Decimal)
    begin
        IF OldCVLedgEntryBuf2.GETFILTER(Positive) <> '' THEN BEGIN
            IF OldCVLedgEntryBuf2."Amount to Apply" <> 0 THEN BEGIN
                IF (PaymentToleranceMgt.CheckCalcPmtDisc(NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, FALSE, FALSE) AND
                    (ABS(OldCVLedgEntryBuf2."Amount to Apply") >=
                     ABS(OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2."Remaining Pmt. Disc. Possible")))
                THEN
                    AppliedAmount := -OldCVLedgEntryBuf2."Remaining Amount"
                ELSE
                    AppliedAmount := -OldCVLedgEntryBuf2."Amount to Apply"
            END ELSE
                AppliedAmount := -OldCVLedgEntryBuf2."Remaining Amount";
        END ELSE BEGIN
            IF OldCVLedgEntryBuf2."Amount to Apply" <> 0 THEN
                IF (PaymentToleranceMgt.CheckCalcPmtDisc(NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, FALSE, FALSE) AND
                    (ABS(OldCVLedgEntryBuf2."Amount to Apply") >=
                     ABS(OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2."Remaining Pmt. Disc. Possible")) AND
                    (ABS(NewCVLedgEntryBuf."Remaining Amount") >=
                     ABS(
                       ABSMin(
                         OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2."Remaining Pmt. Disc. Possible",
                         OldCVLedgEntryBuf2."Amount to Apply")))) OR
                   OldCVLedgEntryBuf."Accepted Pmt. Disc. Tolerance"
                THEN BEGIN
                    AppliedAmount := -OldCVLedgEntryBuf2."Remaining Amount";
                    OldCVLedgEntryBuf."Accepted Pmt. Disc. Tolerance" := FALSE;
                END ELSE
                    AppliedAmount := GetAppliedAmountFromBuffers(NewCVLedgEntryBuf, OldCVLedgEntryBuf2)
            ELSE
                AppliedAmount := ABSMin(NewCVLedgEntryBuf."Remaining Amount", -OldCVLedgEntryBuf2."Remaining Amount");
        END;

        IF (ABS(OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2."Amount to Apply") < ApplnRoundingPrecision) AND
           (ApplnRoundingPrecision <> 0) AND
           (OldCVLedgEntryBuf2."Amount to Apply" <> 0)
        THEN
            AppliedAmount := AppliedAmount - (OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2."Amount to Apply");

        IF NewCVLedgEntryBuf."Currency Code" = OldCVLedgEntryBuf2."Currency Code" THEN BEGIN
            AppliedAmountLCY := ROUND(AppliedAmount / OldCVLedgEntryBuf."Original Currency Factor");
            OldAppliedAmount := AppliedAmount;
        END ELSE BEGIN
            // Management of posting in multiple currencies
            IF AppliedAmount = -OldCVLedgEntryBuf2."Remaining Amount" THEN
                OldAppliedAmount := -OldCVLedgEntryBuf."Remaining Amount"
            ELSE
                OldAppliedAmount :=
                  CurrExchRate.ExchangeAmount(
                    AppliedAmount, NewCVLedgEntryBuf."Currency Code",
                    OldCVLedgEntryBuf2."Currency Code", NewCVLedgEntryBuf."Posting Date");

            IF NewCVLedgEntryBuf."Currency Code" <> '' THEN
                // Post the realized gain or loss on the NewCVLedgEntryBuf
                AppliedAmountLCY := ROUND(OldAppliedAmount / OldCVLedgEntryBuf."Original Currency Factor")
            ELSE
                // Post the realized gain or loss on the OldCVLedgEntryBuf
                AppliedAmountLCY := ROUND(AppliedAmount / NewCVLedgEntryBuf."Original Currency Factor");
        END;
    end;

    local procedure CalcCurrencyUnrealizedGainLoss(var CVLedgEntryBuf: Record "382"; var TempDtldCVLedgEntryBuf: Record "383" temporary; GenJnlLine: Record "81"; AppliedAmount: Decimal; RemainingAmountBeforeAppln: Decimal)
    var
        DtldCustLedgEntry: Record "379";
        DtldVendLedgEntry: Record "380";
        UnRealizedGainLossLCY: Decimal;
    begin
        IF (CVLedgEntryBuf."Currency Code" = '') OR (RemainingAmountBeforeAppln = 0) THEN
            EXIT;

        // Calculate Unrealized GainLoss
        IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer THEN
            UnRealizedGainLossLCY :=
              ROUND(
                DtldCustLedgEntry.GetUnrealizedGainLossAmount(CVLedgEntryBuf."Entry No.") *
                ABS(AppliedAmount / RemainingAmountBeforeAppln))
        ELSE
            UnRealizedGainLossLCY :=
              ROUND(
                DtldVendLedgEntry.GetUnrealizedGainLossAmount(CVLedgEntryBuf."Entry No.") *
                ABS(AppliedAmount / RemainingAmountBeforeAppln));

        IF UnRealizedGainLossLCY <> 0 THEN
            IF UnRealizedGainLossLCY < 0 THEN
                TempDtldCVLedgEntryBuf.InitDtldCVLedgEntryBuf(
                  GenJnlLine, CVLedgEntryBuf, TempDtldCVLedgEntryBuf,
                  TempDtldCVLedgEntryBuf."Entry Type"::"Unrealized Loss", 0, -UnRealizedGainLossLCY, 0, 0, 0, 0)
            ELSE
                TempDtldCVLedgEntryBuf.InitDtldCVLedgEntryBuf(
                  GenJnlLine, CVLedgEntryBuf, TempDtldCVLedgEntryBuf,
                  TempDtldCVLedgEntryBuf."Entry Type"::"Unrealized Gain", 0, -UnRealizedGainLossLCY, 0, 0, 0, 0);
    end;

    local procedure CalcCurrencyRealizedGainLoss(var CVLedgEntryBuf: Record "382"; var TempDtldCVLedgEntryBuf: Record "383" temporary; GenJnlLine: Record "81"; AppliedAmount: Decimal; AppliedAmountLCY: Decimal)
    var
        RealizedGainLossLCY: Decimal;
    begin
        IF CVLedgEntryBuf."Currency Code" = '' THEN
            EXIT;

        // Calculate Realized GainLoss
        RealizedGainLossLCY :=
          AppliedAmountLCY - ROUND(AppliedAmount / CVLedgEntryBuf."Original Currency Factor");
        IF RealizedGainLossLCY <> 0 THEN
            IF RealizedGainLossLCY < 0 THEN
                TempDtldCVLedgEntryBuf.InitDtldCVLedgEntryBuf(
                  GenJnlLine, CVLedgEntryBuf, TempDtldCVLedgEntryBuf,
                  TempDtldCVLedgEntryBuf."Entry Type"::"Realized Loss", 0, RealizedGainLossLCY, 0, 0, 0, 0)
            ELSE
                TempDtldCVLedgEntryBuf.InitDtldCVLedgEntryBuf(
                  GenJnlLine, CVLedgEntryBuf, TempDtldCVLedgEntryBuf,
                  TempDtldCVLedgEntryBuf."Entry Type"::"Realized Gain", 0, RealizedGainLossLCY, 0, 0, 0, 0);
    end;

    local procedure CalcApplication(var NewCVLedgEntryBuf: Record "382"; var OldCVLedgEntryBuf: Record "382"; var DtldCVLedgEntryBuf: Record "383"; GenJnlLine: Record "81"; AppliedAmount: Decimal; AppliedAmountLCY: Decimal; OldAppliedAmount: Decimal; PrevNewCVLedgEntryBuf: Record "382"; PrevOldCVLedgEntryBuf: Record "382"; var AllApplied: Boolean)
    begin
        IF AppliedAmount = 0 THEN
            EXIT;

        DtldCVLedgEntryBuf.InitDtldCVLedgEntryBuf(
          GenJnlLine, OldCVLedgEntryBuf, DtldCVLedgEntryBuf,
          DtldCVLedgEntryBuf."Entry Type"::Application, OldAppliedAmount, AppliedAmountLCY, 0,
          NewCVLedgEntryBuf."Entry No.", PrevOldCVLedgEntryBuf."Remaining Pmt. Disc. Possible",
          PrevOldCVLedgEntryBuf."Max. Payment Tolerance");

        OldCVLedgEntryBuf.Open := OldCVLedgEntryBuf."Remaining Amount" <> 0;
        IF NOT OldCVLedgEntryBuf.Open THEN
            OldCVLedgEntryBuf.SetClosedFields(
              NewCVLedgEntryBuf."Entry No.", GenJnlLine."Posting Date",
              -OldAppliedAmount, -AppliedAmountLCY, NewCVLedgEntryBuf."Currency Code", -AppliedAmount)
        ELSE
            AllApplied := FALSE;

        DtldCVLedgEntryBuf.InitDtldCVLedgEntryBuf(
          GenJnlLine, NewCVLedgEntryBuf, DtldCVLedgEntryBuf,
          DtldCVLedgEntryBuf."Entry Type"::Application, -AppliedAmount, -AppliedAmountLCY, 0,
          NewCVLedgEntryBuf."Entry No.", PrevNewCVLedgEntryBuf."Remaining Pmt. Disc. Possible",
          PrevNewCVLedgEntryBuf."Max. Payment Tolerance");

        NewCVLedgEntryBuf.Open := NewCVLedgEntryBuf."Remaining Amount" <> 0;
        IF NOT NewCVLedgEntryBuf.Open AND NOT AllApplied THEN
            NewCVLedgEntryBuf.SetClosedFields(
              OldCVLedgEntryBuf."Entry No.", GenJnlLine."Posting Date",
              AppliedAmount, AppliedAmountLCY, OldCVLedgEntryBuf."Currency Code", OldAppliedAmount);
    end;

    local procedure CalcAmtLCYAdjustment(var CVLedgEntryBuf: Record "382"; var DtldCVLedgEntryBuf: Record "383"; GenJnlLine: Record "81")
    var
        AdjustedAmountLCY: Decimal;
    begin
        IF CVLedgEntryBuf."Currency Code" = '' THEN
            EXIT;

        AdjustedAmountLCY :=
          ROUND(CVLedgEntryBuf."Remaining Amount" / CVLedgEntryBuf."Adjusted Currency Factor");

        IF AdjustedAmountLCY <> CVLedgEntryBuf."Remaining Amt. (LCY)" THEN BEGIN
            DtldCVLedgEntryBuf.InitFromGenJnlLine(GenJnlLine);
            DtldCVLedgEntryBuf.CopyFromCVLedgEntryBuf(CVLedgEntryBuf);
            DtldCVLedgEntryBuf."Entry Type" :=
              DtldCVLedgEntryBuf."Entry Type"::"Correction of Remaining Amount";
            DtldCVLedgEntryBuf."Amount (LCY)" := AdjustedAmountLCY - CVLedgEntryBuf."Remaining Amt. (LCY)";
            DtldCVLedgEntryBuf.InsertDtldCVLedgEntry(DtldCVLedgEntryBuf, CVLedgEntryBuf, FALSE);
        END;
    end;

    local procedure InitBankAccLedgEntry(GenJnlLine: Record "81"; var BankAccLedgEntry: Record "271")
    begin
        BankAccLedgEntry.INIT;
        BankAccLedgEntry.CopyFromGenJnlLine(GenJnlLine);
        BankAccLedgEntry."Entry No." := NextEntryNo;
        BankAccLedgEntry."Transaction No." := NextTransactionNo;
    end;

    local procedure InitCheckLedgEntry(BankAccLedgEntry: Record "271"; var CheckLedgEntry: Record "272")
    begin
        CheckLedgEntry.INIT;
        CheckLedgEntry.CopyFromBankAccLedgEntry(BankAccLedgEntry);
        CheckLedgEntry."Entry No." := NextCheckEntryNo;
    end;

    local procedure InitCustLedgEntry(GenJnlLine: Record "81"; var CustLedgEntry: Record "21")
    begin
        CustLedgEntry.INIT;
        CustLedgEntry.CopyFromGenJnlLine(GenJnlLine);
        CustLedgEntry."Entry No." := NextEntryNo;
        CustLedgEntry."Transaction No." := NextTransactionNo;
    end;

    local procedure InitVendLedgEntry(GenJnlLine: Record "81"; var VendLedgEntry: Record "25")
    begin
        VendLedgEntry.INIT;
        VendLedgEntry.CopyFromGenJnlLine(GenJnlLine);
        VendLedgEntry."Entry No." := NextEntryNo;
        VendLedgEntry."Transaction No." := NextTransactionNo;
    end;

    local procedure InitEmployeeLedgerEntry(GenJnlLine: Record "81"; var EmployeeLedgerEntry: Record "5222")
    begin
        EmployeeLedgerEntry.INIT;
        EmployeeLedgerEntry.CopyFromGenJnlLine(GenJnlLine);
        EmployeeLedgerEntry."Entry No." := NextEntryNo;
        EmployeeLedgerEntry."Transaction No." := NextTransactionNo;
    end;

    local procedure InsertDtldCustLedgEntry(GenJnlLine: Record "81"; DtldCVLedgEntryBuf: Record "383"; var DtldCustLedgEntry: Record "379"; Offset: Integer)
    begin
        WITH DtldCustLedgEntry DO BEGIN
            INIT;
            TRANSFERFIELDS(DtldCVLedgEntryBuf);
            "Entry No." := Offset + DtldCVLedgEntryBuf."Entry No.";
            "Journal Batch Name" := GenJnlLine."Journal Batch Name";
            "Reason Code" := GenJnlLine."Reason Code";
            "Source Code" := GenJnlLine."Source Code";
            "Transaction No." := NextTransactionNo;
            UpdateDebitCredit(GenJnlLine.Correction);
            INSERT(TRUE);
        END;
    end;

    local procedure InsertDtldVendLedgEntry(GenJnlLine: Record "81"; DtldCVLedgEntryBuf: Record "383"; var DtldVendLedgEntry: Record "380"; Offset: Integer)
    begin
        WITH DtldVendLedgEntry DO BEGIN
            INIT;
            TRANSFERFIELDS(DtldCVLedgEntryBuf);
            "Entry No." := Offset + DtldCVLedgEntryBuf."Entry No.";
            "Journal Batch Name" := GenJnlLine."Journal Batch Name";
            "Reason Code" := GenJnlLine."Reason Code";
            "Source Code" := GenJnlLine."Source Code";
            "Transaction No." := NextTransactionNo;
            UpdateDebitCredit(GenJnlLine.Correction);
            INSERT(TRUE);
        END;
    end;

    local procedure InsertDtldEmplLedgEntry(GenJnlLine: Record "81"; DtldCVLedgEntryBuf: Record "383"; var DtldEmplLedgEntry: Record "5223"; Offset: Integer)
    begin
        WITH DtldEmplLedgEntry DO BEGIN
            INIT;
            TRANSFERFIELDS(DtldCVLedgEntryBuf);
            "Entry No." := Offset + DtldCVLedgEntryBuf."Entry No.";
            "Journal Batch Name" := GenJnlLine."Journal Batch Name";
            "Reason Code" := GenJnlLine."Reason Code";
            "Source Code" := GenJnlLine."Source Code";
            "Transaction No." := NextTransactionNo;
            UpdateDebitCredit(GenJnlLine.Correction);
            INSERT(TRUE);
        END;
    end;

    local procedure ApplyCustLedgEntry(var NewCVLedgEntryBuf: Record "382"; var DtldCVLedgEntryBuf: Record "383"; GenJnlLine: Record "81"; Cust: Record "18")
    var
        OldCustLedgEntry: Record "21";
        OldCVLedgEntryBuf: Record "382";
        NewCustLedgEntry: Record "21";
        NewCVLedgEntryBuf2: Record "382";
        TempOldCustLedgEntry: Record "21" temporary;
        Completed: Boolean;
        AppliedAmount: Decimal;
        NewRemainingAmtBeforeAppln: Decimal;
        ApplyingDate: Date;
        PmtTolAmtToBeApplied: Decimal;
        AllApplied: Boolean;
    begin
        IF NewCVLedgEntryBuf."Amount to Apply" = 0 THEN
            EXIT;

        AllApplied := TRUE;
        IF (GenJnlLine."Applies-to Doc. No." = '') AND (GenJnlLine."Applies-to ID" = '') AND
           NOT
           ((Cust."Application Method" = Cust."Application Method"::"Apply to Oldest") AND
            GenJnlLine."Allow Application")
        THEN
            EXIT;

        PmtTolAmtToBeApplied := 0;
        NewRemainingAmtBeforeAppln := NewCVLedgEntryBuf."Remaining Amount";
        NewCVLedgEntryBuf2 := NewCVLedgEntryBuf;

        ApplyingDate := GenJnlLine."Posting Date";

        IF NOT PrepareTempCustLedgEntry(GenJnlLine, NewCVLedgEntryBuf, TempOldCustLedgEntry, Cust, ApplyingDate) THEN
            EXIT;

        GenJnlLine."Posting Date" := ApplyingDate;
        // Apply the new entry (Payment) to the old entries (Invoices) one at a time
        REPEAT
            TempOldCustLedgEntry.CALCFIELDS(
              Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
              "Original Amount", "Original Amt. (LCY)");
            TempOldCustLedgEntry.COPYFILTER(Positive, OldCVLedgEntryBuf.Positive);
            OldCVLedgEntryBuf.CopyFromCustLedgEntry(TempOldCustLedgEntry);

            PostApply(
              GenJnlLine, DtldCVLedgEntryBuf, OldCVLedgEntryBuf, NewCVLedgEntryBuf, NewCVLedgEntryBuf2,
              Cust."Block Payment Tolerance", AllApplied, AppliedAmount, PmtTolAmtToBeApplied);

            IF NOT OldCVLedgEntryBuf.Open THEN BEGIN
                UpdateCalcInterest(OldCVLedgEntryBuf);
                UpdateCalcInterest2(OldCVLedgEntryBuf, NewCVLedgEntryBuf);
            END;

            TempOldCustLedgEntry.CopyFromCVLedgEntryBuffer(OldCVLedgEntryBuf);
            OldCustLedgEntry := TempOldCustLedgEntry;
            OldCustLedgEntry."Applies-to ID" := '';
            OldCustLedgEntry."Amount to Apply" := 0;
            OldCustLedgEntry.MODIFY;

            IF GLSetup."Unrealized VAT" OR
               (GLSetup."Prepayment Unrealized VAT" AND TempOldCustLedgEntry.Prepayment)
            THEN
                IF IsNotPayment(TempOldCustLedgEntry."Document Type") THEN BEGIN
                    TempOldCustLedgEntry.RecalculateAmounts(
                      NewCVLedgEntryBuf."Currency Code", TempOldCustLedgEntry."Currency Code", NewCVLedgEntryBuf."Posting Date");
                    CustUnrealizedVAT(
                      GenJnlLine,
                      TempOldCustLedgEntry,
                      CurrExchRate.ExchangeAmount(
                        AppliedAmount, NewCVLedgEntryBuf."Currency Code",
                        TempOldCustLedgEntry."Currency Code", NewCVLedgEntryBuf."Posting Date"));
                END;

            TempOldCustLedgEntry.DELETE;

            // Find the next old entry for application of the new entry
            IF GenJnlLine."Applies-to Doc. No." <> '' THEN
                Completed := TRUE
            ELSE
                IF TempOldCustLedgEntry.GETFILTER(Positive) <> '' THEN
                    IF TempOldCustLedgEntry.NEXT = 1 THEN
                        Completed := FALSE
                    ELSE BEGIN
                        TempOldCustLedgEntry.SETRANGE(Positive);
                        TempOldCustLedgEntry.FIND('-');
                        TempOldCustLedgEntry.CALCFIELDS("Remaining Amount");
                        Completed := TempOldCustLedgEntry."Remaining Amount" * NewCVLedgEntryBuf."Remaining Amount" >= 0;
                    END
                ELSE
                    IF NewCVLedgEntryBuf.Open THEN
                        Completed := TempOldCustLedgEntry.NEXT = 0
                    ELSE
                        Completed := TRUE;
        UNTIL Completed;

        DtldCVLedgEntryBuf.SETCURRENTKEY("CV Ledger Entry No.", "Entry Type");
        DtldCVLedgEntryBuf.SETRANGE("CV Ledger Entry No.", NewCVLedgEntryBuf."Entry No.");
        DtldCVLedgEntryBuf.SETRANGE(
          "Entry Type",
          DtldCVLedgEntryBuf."Entry Type"::Application);
        DtldCVLedgEntryBuf.CALCSUMS("Amount (LCY)", Amount);

        CalcCurrencyUnrealizedGainLoss(
          NewCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine, DtldCVLedgEntryBuf.Amount, NewRemainingAmtBeforeAppln);

        CalcAmtLCYAdjustment(NewCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine);

        NewCVLedgEntryBuf."Applies-to ID" := '';
        NewCVLedgEntryBuf."Amount to Apply" := 0;

        IF NOT NewCVLedgEntryBuf.Open THEN
            UpdateCalcInterest(NewCVLedgEntryBuf);

        IF GLSetup."Unrealized VAT" OR
           (GLSetup."Prepayment Unrealized VAT" AND NewCVLedgEntryBuf.Prepayment)
        THEN
            IF IsNotPayment(NewCVLedgEntryBuf."Document Type") AND
               (NewRemainingAmtBeforeAppln - NewCVLedgEntryBuf."Remaining Amount" <> 0)
            THEN BEGIN
                NewCustLedgEntry.CopyFromCVLedgEntryBuffer(NewCVLedgEntryBuf);
                CheckUnrealizedCust := TRUE;
                UnrealizedCustLedgEntry := NewCustLedgEntry;
                UnrealizedCustLedgEntry.CALCFIELDS("Amount (LCY)", "Original Amt. (LCY)");
                UnrealizedRemainingAmountCust := NewCustLedgEntry."Remaining Amount" - NewRemainingAmtBeforeAppln;
            END;
    end;

    procedure CustPostApplyCustLedgEntry(var GenJnlLinePostApply: Record "81"; var CustLedgEntryPostApply: Record "21")
    var
        Cust: Record "18";
        CustPostingGr: Record "92";
        CustLedgEntry: Record "21";
        DtldCustLedgEntry: Record "379";
        TempDtldCVLedgEntryBuf: Record "383" temporary;
        CVLedgEntryBuf: Record "382";
        GenJnlLine: Record "81";
        DtldLedgEntryInserted: Boolean;
    begin
        GenJnlLine := GenJnlLinePostApply;
        CustLedgEntry.TRANSFERFIELDS(CustLedgEntryPostApply);
        WITH GenJnlLine DO BEGIN
            "Source Currency Code" := CustLedgEntryPostApply."Currency Code";
            "Applies-to ID" := CustLedgEntryPostApply."Applies-to ID";

            GenJnlCheckLine.RunCheck(GenJnlLine);

            IF NextEntryNo = 0 THEN
                StartPosting(GenJnlLine)
            ELSE
                ContinuePosting(GenJnlLine);

            Cust.GET(CustLedgEntry."Customer No.");
            Cust.CheckBlockedCustOnJnls(Cust, "Document Type", TRUE);

            IF "Posting Group" = '' THEN BEGIN
                Cust.TESTFIELD("Customer Posting Group");
                "Posting Group" := Cust."Customer Posting Group";
            END;
            CustPostingGr.GET("Posting Group");
            CustPostingGr.GetReceivablesAccount;

            DtldCustLedgEntry.LOCKTABLE;
            CustLedgEntry.LOCKTABLE;

            // Post the application
            CustLedgEntry.CALCFIELDS(
              Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
              "Original Amount", "Original Amt. (LCY)");
            CVLedgEntryBuf.CopyFromCustLedgEntry(CustLedgEntry);
            ApplyCustLedgEntry(CVLedgEntryBuf, TempDtldCVLedgEntryBuf, GenJnlLine, Cust);
            CustLedgEntry.CopyFromCVLedgEntryBuffer(CVLedgEntryBuf);
            CustLedgEntry.MODIFY;

            // Post the Dtld customer entry
            DtldLedgEntryInserted := PostDtldCustLedgEntries(GenJnlLine, TempDtldCVLedgEntryBuf, CustPostingGr, FALSE);

            CheckPostUnrealizedVAT(GenJnlLine, TRUE);

            IF DtldLedgEntryInserted THEN
                IF IsTempGLEntryBufEmpty THEN
                    DtldCustLedgEntry.SetZeroTransNo(NextTransactionNo);
            FinishPosting;
        END;
    end;

    local procedure PrepareTempCustLedgEntry(GenJnlLine: Record "81"; var NewCVLedgEntryBuf: Record "382"; var TempOldCustLedgEntry: Record "21" temporary; Cust: Record "18"; var ApplyingDate: Date): Boolean
    var
        OldCustLedgEntry: Record "21";
        SalesSetup: Record "311";
        GenJnlApply: Codeunit "225";
        RemainingAmount: Decimal;
    begin
        IF GenJnlLine."Applies-to Doc. No." <> '' THEN BEGIN
            // Find the entry to be applied to
            OldCustLedgEntry.RESET;
            OldCustLedgEntry.SETCURRENTKEY("Document No.");
            OldCustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
            OldCustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
            OldCustLedgEntry.SETRANGE("Customer No.", NewCVLedgEntryBuf."CV No.");
            OldCustLedgEntry.SETRANGE(Open, TRUE);

            OldCustLedgEntry.FINDFIRST;
            OldCustLedgEntry.TESTFIELD(Positive, NOT NewCVLedgEntryBuf.Positive);
            IF OldCustLedgEntry."Posting Date" > ApplyingDate THEN
                ApplyingDate := OldCustLedgEntry."Posting Date";
            GenJnlApply.CheckAgainstApplnCurrency(
              NewCVLedgEntryBuf."Currency Code", OldCustLedgEntry."Currency Code", GenJnlLine."Account Type"::Customer, TRUE);
            TempOldCustLedgEntry := OldCustLedgEntry;
            TempOldCustLedgEntry.INSERT;
        END ELSE BEGIN
            // Find the first old entry (Invoice) which the new entry (Payment) should apply to
            OldCustLedgEntry.RESET;
            OldCustLedgEntry.SETCURRENTKEY("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
            TempOldCustLedgEntry.SETCURRENTKEY("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
            OldCustLedgEntry.SETRANGE("Customer No.", NewCVLedgEntryBuf."CV No.");
            OldCustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
            OldCustLedgEntry.SETRANGE(Open, TRUE);
            OldCustLedgEntry.SETFILTER("Entry No.", '<>%1', NewCVLedgEntryBuf."Entry No.");
            IF NOT (Cust."Application Method" = Cust."Application Method"::"Apply to Oldest") THEN
                OldCustLedgEntry.SETFILTER("Amount to Apply", '<>%1', 0);

            IF Cust."Application Method" = Cust."Application Method"::"Apply to Oldest" THEN
                OldCustLedgEntry.SETFILTER("Posting Date", '..%1', GenJnlLine."Posting Date");

            // Check Cust Ledger Entry and add to Temp.
            SalesSetup.GET;
            IF SalesSetup."Appln. between Currencies" = SalesSetup."Appln. between Currencies"::None THEN
                OldCustLedgEntry.SETRANGE("Currency Code", NewCVLedgEntryBuf."Currency Code");
            IF OldCustLedgEntry.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    IF GenJnlApply.CheckAgainstApplnCurrency(
                         NewCVLedgEntryBuf."Currency Code", OldCustLedgEntry."Currency Code", GenJnlLine."Account Type"::Customer, FALSE)
                    THEN BEGIN
                        IF (OldCustLedgEntry."Posting Date" > ApplyingDate) AND (OldCustLedgEntry."Applies-to ID" <> '') THEN
                            ApplyingDate := OldCustLedgEntry."Posting Date";
                        TempOldCustLedgEntry := OldCustLedgEntry;
                        TempOldCustLedgEntry.INSERT;
                    END;
                UNTIL OldCustLedgEntry.NEXT = 0;

            TempOldCustLedgEntry.SETRANGE(Positive, NewCVLedgEntryBuf."Remaining Amount" > 0);

            IF TempOldCustLedgEntry.FIND('-') THEN BEGIN
                RemainingAmount := NewCVLedgEntryBuf."Remaining Amount";
                TempOldCustLedgEntry.SETRANGE(Positive);
                TempOldCustLedgEntry.FIND('-');
                REPEAT
                    TempOldCustLedgEntry.CALCFIELDS("Remaining Amount");
                    TempOldCustLedgEntry.RecalculateAmounts(
                      TempOldCustLedgEntry."Currency Code", NewCVLedgEntryBuf."Currency Code", NewCVLedgEntryBuf."Posting Date");
                    IF PaymentToleranceMgt.CheckCalcPmtDiscCVCust(NewCVLedgEntryBuf, TempOldCustLedgEntry, 0, FALSE, FALSE) THEN
                        TempOldCustLedgEntry."Remaining Amount" -= TempOldCustLedgEntry."Remaining Pmt. Disc. Possible";
                    RemainingAmount += TempOldCustLedgEntry."Remaining Amount";
                UNTIL TempOldCustLedgEntry.NEXT = 0;
                TempOldCustLedgEntry.SETRANGE(Positive, RemainingAmount < 0);
            END ELSE
                TempOldCustLedgEntry.SETRANGE(Positive);

            EXIT(TempOldCustLedgEntry.FIND('-'));
        END;
        EXIT(TRUE);
    end;

    local procedure PostDtldCustLedgEntries(GenJnlLine: Record "81"; var DtldCVLedgEntryBuf: Record "383"; CustPostingGr: Record "92"; LedgEntryInserted: Boolean) DtldLedgEntryInserted: Boolean
    var
        TempInvPostBuf: Record "49" temporary;
        DtldCustLedgEntry: Record "379";
        AdjAmount: array[4] of Decimal;
        DtldCustLedgEntryNoOffset: Integer;
        SaveEntryNo: Integer;
    begin
        IF GenJnlLine."Account Type" <> GenJnlLine."Account Type"::Customer THEN
            EXIT;

        IF DtldCustLedgEntry.FINDLAST THEN
            DtldCustLedgEntryNoOffset := DtldCustLedgEntry."Entry No."
        ELSE
            DtldCustLedgEntryNoOffset := 0;

        DtldCVLedgEntryBuf.RESET;
        IF DtldCVLedgEntryBuf.FINDSET THEN BEGIN
            IF LedgEntryInserted THEN BEGIN
                SaveEntryNo := NextEntryNo;
                NextEntryNo := NextEntryNo + 1;
            END;
            REPEAT
                InsertDtldCustLedgEntry(GenJnlLine, DtldCVLedgEntryBuf, DtldCustLedgEntry, DtldCustLedgEntryNoOffset);

                UpdateTotalAmounts(
                  TempInvPostBuf, GenJnlLine."Dimension Set ID",
                  DtldCVLedgEntryBuf."Amount (LCY)", DtldCVLedgEntryBuf."Additional-Currency Amount");

                // Post automatic entries.
                IF ((DtldCVLedgEntryBuf."Amount (LCY)" <> 0) OR
                    (DtldCVLedgEntryBuf."VAT Amount (LCY)" <> 0)) OR
                   ((AddCurrencyCode <> '') AND (DtldCVLedgEntryBuf."Additional-Currency Amount" <> 0))
                THEN
                    PostDtldCustLedgEntry(GenJnlLine, DtldCVLedgEntryBuf, CustPostingGr, AdjAmount);
            UNTIL DtldCVLedgEntryBuf.NEXT = 0;
        END;

        CreateGLEntriesForTotalAmounts(
          GenJnlLine, TempInvPostBuf, AdjAmount, SaveEntryNo, CustPostingGr.GetReceivablesAccount, LedgEntryInserted);

        DtldLedgEntryInserted := NOT DtldCVLedgEntryBuf.ISEMPTY;
        DtldCVLedgEntryBuf.DELETEALL;
    end;

    local procedure PostDtldCustLedgEntry(GenJnlLine: Record "81"; DtldCVLedgEntryBuf: Record "383"; CustPostingGr: Record "92"; var AdjAmount: array[4] of Decimal)
    var
        AccNo: Code[20];
    begin
        AccNo := GetDtldCustLedgEntryAccNo(GenJnlLine, DtldCVLedgEntryBuf, CustPostingGr, 0, FALSE);
        PostDtldCVLedgEntry(GenJnlLine, DtldCVLedgEntryBuf, AccNo, AdjAmount, FALSE);
    end;

    local procedure PostDtldCustLedgEntryUnapply(GenJnlLine: Record "81"; DtldCVLedgEntryBuf: Record "383"; CustPostingGr: Record "92"; OriginalTransactionNo: Integer)
    var
        AdjAmount: array[4] of Decimal;
        AccNo: Code[20];
    begin
        IF (DtldCVLedgEntryBuf."Amount (LCY)" = 0) AND
           (DtldCVLedgEntryBuf."VAT Amount (LCY)" = 0) AND
           ((AddCurrencyCode = '') OR (DtldCVLedgEntryBuf."Additional-Currency Amount" = 0))
        THEN
            EXIT;

        AccNo := GetDtldCustLedgEntryAccNo(GenJnlLine, DtldCVLedgEntryBuf, CustPostingGr, OriginalTransactionNo, TRUE);
        DtldCVLedgEntryBuf."Gen. Posting Type" := DtldCVLedgEntryBuf."Gen. Posting Type"::Sale;
        PostDtldCVLedgEntry(GenJnlLine, DtldCVLedgEntryBuf, AccNo, AdjAmount, TRUE);
    end;

    local procedure GetDtldCustLedgEntryAccNo(GenJnlLine: Record "81"; DtldCVLedgEntryBuf: Record "383"; CustPostingGr: Record "92"; OriginalTransactionNo: Integer; Unapply: Boolean): Code[20]
    var
        GenPostingSetup: Record "252";
        Currency: Record "4";
        AmountCondition: Boolean;
    begin
        WITH DtldCVLedgEntryBuf DO BEGIN
            AmountCondition := IsDebitAmount(DtldCVLedgEntryBuf, Unapply);
            CASE "Entry Type" OF
                "Entry Type"::"Initial Entry":
                    ;
                "Entry Type"::Application:
                    ;
                "Entry Type"::"Unrealized Loss",
                "Entry Type"::"Unrealized Gain",
                "Entry Type"::"Realized Loss",
                "Entry Type"::"Realized Gain":
                    BEGIN
                        GetCurrency(Currency, "Currency Code");
                        CheckNonAddCurrCodeOccurred(Currency.Code);
                        EXIT(Currency.GetGainLossAccount(DtldCVLedgEntryBuf));
                    END;
                "Entry Type"::"Payment Discount":
                    EXIT(CustPostingGr.GetPmtDiscountAccount(AmountCondition));
                "Entry Type"::"Payment Discount (VAT Excl.)":
                    BEGIN
                        TESTFIELD("Gen. Prod. Posting Group");
                        GenPostingSetup.GET("Gen. Bus. Posting Group", "Gen. Prod. Posting Group");
                        EXIT(GenPostingSetup.GetSalesPmtDiscountAccount(AmountCondition));
                    END;
                "Entry Type"::"Appln. Rounding":
                    EXIT(CustPostingGr.GetApplRoundingAccount(AmountCondition));
                "Entry Type"::"Correction of Remaining Amount":
                    EXIT(CustPostingGr.GetRoundingAccount(AmountCondition));
                "Entry Type"::"Payment Discount Tolerance":
                    CASE GLSetup."Pmt. Disc. Tolerance Posting" OF
                        GLSetup."Pmt. Disc. Tolerance Posting"::"Payment Tolerance Accounts":
                            EXIT(CustPostingGr.GetPmtToleranceAccount(AmountCondition));
                        GLSetup."Pmt. Disc. Tolerance Posting"::"Payment Discount Accounts":
                            EXIT(CustPostingGr.GetPmtDiscountAccount(AmountCondition));
                    END;
                "Entry Type"::"Payment Tolerance":
                    CASE GLSetup."Payment Tolerance Posting" OF
                        GLSetup."Payment Tolerance Posting"::"Payment Tolerance Accounts":
                            EXIT(CustPostingGr.GetPmtToleranceAccount(AmountCondition));
                        GLSetup."Payment Tolerance Posting"::"Payment Discount Accounts":
                            EXIT(CustPostingGr.GetPmtDiscountAccount(AmountCondition));
                    END;
                "Entry Type"::"Payment Tolerance (VAT Excl.)":
                    BEGIN
                        TESTFIELD("Gen. Prod. Posting Group");
                        GenPostingSetup.GET("Gen. Bus. Posting Group", "Gen. Prod. Posting Group");
                        CASE GLSetup."Payment Tolerance Posting" OF
                            GLSetup."Payment Tolerance Posting"::"Payment Tolerance Accounts":
                                EXIT(GenPostingSetup.GetSalesPmtToleranceAccount(AmountCondition));
                            GLSetup."Payment Tolerance Posting"::"Payment Discount Accounts":
                                EXIT(GenPostingSetup.GetSalesPmtDiscountAccount(AmountCondition));
                        END;
                    END;
                "Entry Type"::"Payment Discount Tolerance (VAT Excl.)":
                    BEGIN
                        GenPostingSetup.GET("Gen. Bus. Posting Group", "Gen. Prod. Posting Group");
                        CASE GLSetup."Pmt. Disc. Tolerance Posting" OF
                            GLSetup."Pmt. Disc. Tolerance Posting"::"Payment Tolerance Accounts":
                                EXIT(GenPostingSetup.GetSalesPmtToleranceAccount(AmountCondition));
                            GLSetup."Pmt. Disc. Tolerance Posting"::"Payment Discount Accounts":
                                EXIT(GenPostingSetup.GetSalesPmtDiscountAccount(AmountCondition));
                        END;
                    END;
                "Entry Type"::"Payment Discount (VAT Adjustment)",
              "Entry Type"::"Payment Tolerance (VAT Adjustment)",
              "Entry Type"::"Payment Discount Tolerance (VAT Adjustment)":
                    IF Unapply THEN
                        PostDtldCustVATAdjustment(GenJnlLine, DtldCVLedgEntryBuf, OriginalTransactionNo);
                ELSE
                    FIELDERROR("Entry Type");
            END;
        END;
    end;

    local procedure CustUnrealizedVAT(GenJnlLine: Record "81"; var CustLedgEntry2: Record "21"; SettledAmount: Decimal)
    var
        VATEntry2: Record "254";
        TaxJurisdiction: Record "320";
        VATPostingSetup: Record "325";
        VATPart: Decimal;
        VATAmount: Decimal;
        VATBase: Decimal;
        VATAmountAddCurr: Decimal;
        VATBaseAddCurr: Decimal;
        PaidAmount: Decimal;
        TotalUnrealVATAmountLast: Decimal;
        TotalUnrealVATAmountFirst: Decimal;
        SalesVATAccount: Code[20];
        SalesVATUnrealAccount: Code[20];
        LastConnectionNo: Integer;
        GLEntryNo: Integer;
    begin
        PaidAmount := CustLedgEntry2."Amount (LCY)" - CustLedgEntry2."Remaining Amt. (LCY)";
        VATEntry2.RESET;
        VATEntry2.SETCURRENTKEY("Transaction No.");
        VATEntry2.SETRANGE("Transaction No.", CustLedgEntry2."Transaction No.");
        IF VATEntry2.FINDSET THEN
            REPEAT
                VATPostingSetup.GET(VATEntry2."VAT Bus. Posting Group", VATEntry2."VAT Prod. Posting Group");
                IF VATPostingSetup."Unrealized VAT Type" IN
                   [VATPostingSetup."Unrealized VAT Type"::Last, VATPostingSetup."Unrealized VAT Type"::"Last (Fully Paid)"]
                THEN
                    TotalUnrealVATAmountLast := TotalUnrealVATAmountLast - VATEntry2."Remaining Unrealized Amount";
                IF VATPostingSetup."Unrealized VAT Type" IN
                   [VATPostingSetup."Unrealized VAT Type"::First, VATPostingSetup."Unrealized VAT Type"::"First (Fully Paid)"]
                THEN
                    TotalUnrealVATAmountFirst := TotalUnrealVATAmountFirst - VATEntry2."Remaining Unrealized Amount";
            UNTIL VATEntry2.NEXT = 0;
        IF VATEntry2.FINDSET THEN BEGIN
            LastConnectionNo := 0;
            REPEAT
                VATPostingSetup.GET(VATEntry2."VAT Bus. Posting Group", VATEntry2."VAT Prod. Posting Group");
                IF LastConnectionNo <> VATEntry2."Sales Tax Connection No." THEN BEGIN
                    InsertSummarizedVAT(GenJnlLine);
                    LastConnectionNo := VATEntry2."Sales Tax Connection No.";
                END;

                VATPart :=
                  VATEntry2.GetUnrealizedVATPart(
                    ROUND(SettledAmount / CustLedgEntry2.GetOriginalCurrencyFactor),
                    PaidAmount,
                    CustLedgEntry2."Original Amt. (LCY)",
                    TotalUnrealVATAmountFirst,
                    TotalUnrealVATAmountLast);

                IF VATPart > 0 THEN BEGIN
                    CASE VATEntry2."VAT Calculation Type" OF
                        VATEntry2."VAT Calculation Type"::"Normal VAT",
                        VATEntry2."VAT Calculation Type"::"Reverse Charge VAT",
                        VATEntry2."VAT Calculation Type"::"Full VAT":
                            BEGIN
                                SalesVATAccount := VATPostingSetup.GetSalesAccount(FALSE);
                                SalesVATUnrealAccount := VATPostingSetup.GetSalesAccount(TRUE);
                            END;
                        VATEntry2."VAT Calculation Type"::"Sales Tax":
                            BEGIN
                                TaxJurisdiction.GET(VATEntry2."Tax Jurisdiction Code");
                                SalesVATAccount := TaxJurisdiction.GetSalesAccount(FALSE);
                                SalesVATUnrealAccount := TaxJurisdiction.GetSalesAccount(TRUE);
                            END;
                    END;

                    IF VATPart = 1 THEN BEGIN
                        VATAmount := VATEntry2."Remaining Unrealized Amount";
                        VATBase := VATEntry2."Remaining Unrealized Base";
                        VATAmountAddCurr := VATEntry2."Add.-Curr. Rem. Unreal. Amount";
                        VATBaseAddCurr := VATEntry2."Add.-Curr. Rem. Unreal. Base";
                    END ELSE BEGIN
                        VATAmount := ROUND(VATEntry2."Remaining Unrealized Amount" * VATPart, GLSetup."Amount Rounding Precision");
                        VATBase := ROUND(VATEntry2."Remaining Unrealized Base" * VATPart, GLSetup."Amount Rounding Precision");
                        VATAmountAddCurr :=
                          ROUND(
                            VATEntry2."Add.-Curr. Rem. Unreal. Amount" * VATPart,
                            AddCurrency."Amount Rounding Precision");
                        VATBaseAddCurr :=
                          ROUND(
                            VATEntry2."Add.-Curr. Rem. Unreal. Base" * VATPart,
                            AddCurrency."Amount Rounding Precision");
                    END;

                    InitGLEntryVAT(
                      GenJnlLine, SalesVATUnrealAccount, SalesVATAccount, -VATAmount, -VATAmountAddCurr, FALSE);
                    GLEntryNo :=
                      InitGLEntryVATCopy(GenJnlLine, SalesVATAccount, SalesVATUnrealAccount, VATAmount, VATAmountAddCurr, VATEntry2);

                    PostUnrealVATEntry(GenJnlLine, VATEntry2, VATAmount, VATBase, VATAmountAddCurr, VATBaseAddCurr, GLEntryNo);
                END;
            UNTIL VATEntry2.NEXT = 0;

            InsertSummarizedVAT(GenJnlLine);
        END;
    end;

    local procedure ApplyVendLedgEntry(var NewCVLedgEntryBuf: Record "382"; var DtldCVLedgEntryBuf: Record "383"; GenJnlLine: Record "81"; Vend: Record "23")
    var
        OldVendLedgEntry: Record "25";
        OldCVLedgEntryBuf: Record "382";
        NewVendLedgEntry: Record "25";
        NewCVLedgEntryBuf2: Record "382";
        TempOldVendLedgEntry: Record "25" temporary;
        Completed: Boolean;
        AppliedAmount: Decimal;
        NewRemainingAmtBeforeAppln: Decimal;
        ApplyingDate: Date;
        PmtTolAmtToBeApplied: Decimal;
        AllApplied: Boolean;
    begin
        IF NewCVLedgEntryBuf."Amount to Apply" = 0 THEN
            EXIT;

        AllApplied := TRUE;
        IF (GenJnlLine."Applies-to Doc. No." = '') AND (GenJnlLine."Applies-to ID" = '') AND
           NOT
           ((Vend."Application Method" = Vend."Application Method"::"Apply to Oldest") AND
            GenJnlLine."Allow Application")
        THEN
            EXIT;

        PmtTolAmtToBeApplied := 0;
        NewRemainingAmtBeforeAppln := NewCVLedgEntryBuf."Remaining Amount";
        NewCVLedgEntryBuf2 := NewCVLedgEntryBuf;

        ApplyingDate := GenJnlLine."Posting Date";

        IF NOT PrepareTempVendLedgEntry(GenJnlLine, NewCVLedgEntryBuf, TempOldVendLedgEntry, Vend, ApplyingDate) THEN
            EXIT;

        GenJnlLine."Posting Date" := ApplyingDate;
        // Apply the new entry (Payment) to the old entries (Invoices) one at a time
        REPEAT
            TempOldVendLedgEntry.CALCFIELDS(
              Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
              "Original Amount", "Original Amt. (LCY)");
            OldCVLedgEntryBuf.CopyFromVendLedgEntry(TempOldVendLedgEntry);
            TempOldVendLedgEntry.COPYFILTER(Positive, OldCVLedgEntryBuf.Positive);

            PostApply(
              GenJnlLine, DtldCVLedgEntryBuf, OldCVLedgEntryBuf, NewCVLedgEntryBuf, NewCVLedgEntryBuf2,
              Vend."Block Payment Tolerance", AllApplied, AppliedAmount, PmtTolAmtToBeApplied);

            // Update the Old Entry
            TempOldVendLedgEntry.CopyFromCVLedgEntryBuffer(OldCVLedgEntryBuf);
            OldVendLedgEntry := TempOldVendLedgEntry;
            OldVendLedgEntry."Applies-to ID" := '';
            OldVendLedgEntry."Amount to Apply" := 0;
            OldVendLedgEntry.MODIFY;

            IF GLSetup."Unrealized VAT" OR
               (GLSetup."Prepayment Unrealized VAT" AND TempOldVendLedgEntry.Prepayment)
            THEN
                IF IsNotPayment(TempOldVendLedgEntry."Document Type") THEN BEGIN
                    TempOldVendLedgEntry.RecalculateAmounts(
                      NewCVLedgEntryBuf."Currency Code", TempOldVendLedgEntry."Currency Code", NewCVLedgEntryBuf."Posting Date");
                    VendUnrealizedVAT(
                      GenJnlLine,
                      TempOldVendLedgEntry,
                      CurrExchRate.ExchangeAmount(
                        AppliedAmount, NewCVLedgEntryBuf."Currency Code",
                        TempOldVendLedgEntry."Currency Code", NewCVLedgEntryBuf."Posting Date"));
                END;

            TempOldVendLedgEntry.DELETE;

            // Find the next old entry to apply to the new entry
            IF GenJnlLine."Applies-to Doc. No." <> '' THEN
                Completed := TRUE
            ELSE
                IF TempOldVendLedgEntry.GETFILTER(Positive) <> '' THEN
                    IF TempOldVendLedgEntry.NEXT = 1 THEN
                        Completed := FALSE
                    ELSE BEGIN
                        TempOldVendLedgEntry.SETRANGE(Positive);
                        TempOldVendLedgEntry.FIND('-');
                        TempOldVendLedgEntry.CALCFIELDS("Remaining Amount");
                        Completed := TempOldVendLedgEntry."Remaining Amount" * NewCVLedgEntryBuf."Remaining Amount" >= 0;
                    END
                ELSE
                    IF NewCVLedgEntryBuf.Open THEN
                        Completed := TempOldVendLedgEntry.NEXT = 0
                    ELSE
                        Completed := TRUE;
        UNTIL Completed;

        DtldCVLedgEntryBuf.SETCURRENTKEY("CV Ledger Entry No.", "Entry Type");
        DtldCVLedgEntryBuf.SETRANGE("CV Ledger Entry No.", NewCVLedgEntryBuf."Entry No.");
        DtldCVLedgEntryBuf.SETRANGE(
          "Entry Type",
          DtldCVLedgEntryBuf."Entry Type"::Application);
        DtldCVLedgEntryBuf.CALCSUMS("Amount (LCY)", Amount);

        CalcCurrencyUnrealizedGainLoss(
          NewCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine, DtldCVLedgEntryBuf.Amount, NewRemainingAmtBeforeAppln);

        CalcAmtLCYAdjustment(NewCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine);

        NewCVLedgEntryBuf."Applies-to ID" := '';
        NewCVLedgEntryBuf."Amount to Apply" := 0;

        IF GLSetup."Unrealized VAT" OR
           (GLSetup."Prepayment Unrealized VAT" AND NewCVLedgEntryBuf.Prepayment)
        THEN
            IF IsNotPayment(NewCVLedgEntryBuf."Document Type") AND
               (NewRemainingAmtBeforeAppln - NewCVLedgEntryBuf."Remaining Amount" <> 0)
            THEN BEGIN
                NewVendLedgEntry.CopyFromCVLedgEntryBuffer(NewCVLedgEntryBuf);
                CheckUnrealizedVend := TRUE;
                UnrealizedVendLedgEntry := NewVendLedgEntry;
                UnrealizedVendLedgEntry.CALCFIELDS("Amount (LCY)", "Original Amt. (LCY)");
                UnrealizedRemainingAmountVend := -(NewRemainingAmtBeforeAppln - NewVendLedgEntry."Remaining Amount");
            END;
    end;

    local procedure ApplyEmplLedgEntry(var NewCVLedgEntryBuf: Record "382"; var DtldCVLedgEntryBuf: Record "383"; GenJnlLine: Record "81"; Employee: Record "5200")
    var
        OldEmplLedgEntry: Record "5222";
        OldCVLedgEntryBuf: Record "382";
        NewCVLedgEntryBuf2: Record "382";
        TempOldEmplLedgEntry: Record "5222" temporary;
        Completed: Boolean;
        AppliedAmount: Decimal;
        ApplyingDate: Date;
        PmtTolAmtToBeApplied: Decimal;
        AllApplied: Boolean;
    begin
        IF NewCVLedgEntryBuf."Amount to Apply" = 0 THEN
            EXIT;

        AllApplied := TRUE;
        IF (GenJnlLine."Applies-to Doc. No." = '') AND (GenJnlLine."Applies-to ID" = '') AND
           NOT
           ((Employee."Application Method" = Employee."Application Method"::"Apply to Oldest") AND
            GenJnlLine."Allow Application")
        THEN
            EXIT;

        PmtTolAmtToBeApplied := 0;
        NewCVLedgEntryBuf2 := NewCVLedgEntryBuf;

        ApplyingDate := GenJnlLine."Posting Date";

        IF NOT PrepareTempEmplLedgEntry(GenJnlLine, NewCVLedgEntryBuf, TempOldEmplLedgEntry, Employee, ApplyingDate) THEN
            EXIT;

        GenJnlLine."Posting Date" := ApplyingDate;

        // Apply the new entry (Payment) to the old entries one at a time
        REPEAT
            TempOldEmplLedgEntry.CALCFIELDS(
              Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
              "Original Amount", "Original Amt. (LCY)");
            OldCVLedgEntryBuf.CopyFromEmplLedgEntry(TempOldEmplLedgEntry);
            TempOldEmplLedgEntry.COPYFILTER(Positive, OldCVLedgEntryBuf.Positive);

            PostApply(
              GenJnlLine, DtldCVLedgEntryBuf, OldCVLedgEntryBuf, NewCVLedgEntryBuf, NewCVLedgEntryBuf2,
              TRUE, AllApplied, AppliedAmount, PmtTolAmtToBeApplied);

            // Update the Old Entry
            TempOldEmplLedgEntry.CopyFromCVLedgEntryBuffer(OldCVLedgEntryBuf);
            OldEmplLedgEntry := TempOldEmplLedgEntry;
            OldEmplLedgEntry."Applies-to ID" := '';
            OldEmplLedgEntry."Amount to Apply" := 0;
            OldEmplLedgEntry.MODIFY;

            TempOldEmplLedgEntry.DELETE;

            // Find the next old entry to apply to the new entry
            IF GenJnlLine."Applies-to Doc. No." <> '' THEN
                Completed := TRUE
            ELSE
                IF TempOldEmplLedgEntry.GETFILTER(Positive) <> '' THEN
                    IF TempOldEmplLedgEntry.NEXT = 1 THEN
                        Completed := FALSE
                    ELSE BEGIN
                        TempOldEmplLedgEntry.SETRANGE(Positive);
                        TempOldEmplLedgEntry.FIND('-');
                        TempOldEmplLedgEntry.CALCFIELDS("Remaining Amount");
                        Completed := TempOldEmplLedgEntry."Remaining Amount" * NewCVLedgEntryBuf."Remaining Amount" >= 0;
                    END
                ELSE
                    IF NewCVLedgEntryBuf.Open THEN
                        Completed := TempOldEmplLedgEntry.NEXT = 0
                    ELSE
                        Completed := TRUE;
        UNTIL Completed;

        DtldCVLedgEntryBuf.SETCURRENTKEY("CV Ledger Entry No.", "Entry Type");
        DtldCVLedgEntryBuf.SETRANGE("CV Ledger Entry No.", NewCVLedgEntryBuf."Entry No.");
        DtldCVLedgEntryBuf.SETRANGE(
          "Entry Type",
          DtldCVLedgEntryBuf."Entry Type"::Application);
        DtldCVLedgEntryBuf.CALCSUMS("Amount (LCY)", Amount);

        NewCVLedgEntryBuf."Applies-to ID" := '';
        NewCVLedgEntryBuf."Amount to Apply" := 0;
    end;

    [Scope('Internal')]
    procedure VendPostApplyVendLedgEntry(var GenJnlLinePostApply: Record "81"; var VendLedgEntryPostApply: Record "25")
    var
        Vend: Record "23";
        VendPostingGr: Record "93";
        VendLedgEntry: Record "25";
        DtldVendLedgEntry: Record "380";
        TempDtldCVLedgEntryBuf: Record "383" temporary;
        CVLedgEntryBuf: Record "382";
        GenJnlLine: Record "81";
        DtldLedgEntryInserted: Boolean;
    begin
        GenJnlLine := GenJnlLinePostApply;
        VendLedgEntry.TRANSFERFIELDS(VendLedgEntryPostApply);
        WITH GenJnlLine DO BEGIN
            "Source Currency Code" := VendLedgEntryPostApply."Currency Code";
            "Applies-to ID" := VendLedgEntryPostApply."Applies-to ID";

            GenJnlCheckLine.RunCheck(GenJnlLine);

            IF NextEntryNo = 0 THEN
                StartPosting(GenJnlLine)
            ELSE
                ContinuePosting(GenJnlLine);

            Vend.GET(VendLedgEntry."Vendor No.");
            Vend.CheckBlockedVendOnJnls(Vend, "Document Type", TRUE);

            IF "Posting Group" = '' THEN BEGIN
                Vend.TESTFIELD("Vendor Posting Group");
                "Posting Group" := Vend."Vendor Posting Group";
            END;
            VendPostingGr.GET("Posting Group");
            VendPostingGr.GetPayablesAccount;

            DtldVendLedgEntry.LOCKTABLE;
            VendLedgEntry.LOCKTABLE;

            // Post the application
            VendLedgEntry.CALCFIELDS(
              Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
              "Original Amount", "Original Amt. (LCY)");
            CVLedgEntryBuf.CopyFromVendLedgEntry(VendLedgEntry);
            ApplyVendLedgEntry(
              CVLedgEntryBuf, TempDtldCVLedgEntryBuf, GenJnlLine, Vend);
            VendLedgEntry.CopyFromCVLedgEntryBuffer(CVLedgEntryBuf);
            VendLedgEntry.MODIFY(TRUE);

            // Post Dtld vendor entry
            DtldLedgEntryInserted := PostDtldVendLedgEntries(GenJnlLine, TempDtldCVLedgEntryBuf, VendPostingGr, FALSE);

            CheckPostUnrealizedVAT(GenJnlLine, TRUE);

            IF DtldLedgEntryInserted THEN
                IF IsTempGLEntryBufEmpty THEN
                    DtldVendLedgEntry.SetZeroTransNo(NextTransactionNo);

            FinishPosting;
        END;
    end;

    [Scope('Internal')]
    procedure EmplPostApplyEmplLedgEntry(var GenJnlLinePostApply: Record "81"; var EmplLedgEntryPostApply: Record "5222")
    var
        Empl: Record "5200";
        EmplPostingGr: Record "5221";
        EmplLedgEntry: Record "5222";
        DtldEmplLedgEntry: Record "5223";
        TempDtldCVLedgEntryBuf: Record "383" temporary;
        CVLedgEntryBuf: Record "382";
        GenJnlLine: Record "81";
        DtldLedgEntryInserted: Boolean;
    begin
        GenJnlLine := GenJnlLinePostApply;
        EmplLedgEntry.TRANSFERFIELDS(EmplLedgEntryPostApply);
        WITH GenJnlLine DO BEGIN
            "Source Currency Code" := EmplLedgEntryPostApply."Currency Code";
            "Applies-to ID" := EmplLedgEntryPostApply."Applies-to ID";

            GenJnlCheckLine.RunCheck(GenJnlLine);

            IF NextEntryNo = 0 THEN
                StartPosting(GenJnlLine)
            ELSE
                ContinuePosting(GenJnlLine);

            Empl.GET(EmplLedgEntry."Employee No.");

            IF "Posting Group" = '' THEN BEGIN
                Empl.TESTFIELD("Employee Posting Group");
                "Posting Group" := Empl."Employee Posting Group";
            END;
            EmplPostingGr.GET("Posting Group");
            EmplPostingGr.GetPayablesAccount;

            DtldEmplLedgEntry.LOCKTABLE;
            EmplLedgEntry.LOCKTABLE;

            // Post the application
            EmplLedgEntry.CALCFIELDS(
              Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
              "Original Amount", "Original Amt. (LCY)");
            CVLedgEntryBuf.CopyFromEmplLedgEntry(EmplLedgEntry);
            ApplyEmplLedgEntry(
              CVLedgEntryBuf, TempDtldCVLedgEntryBuf, GenJnlLine, Empl);
            EmplLedgEntry.CopyFromCVLedgEntryBuffer(CVLedgEntryBuf);
            EmplLedgEntry.MODIFY(TRUE);

            // Post Dtld vendor entry
            DtldLedgEntryInserted := PostDtldEmplLedgEntries(GenJnlLine, TempDtldCVLedgEntryBuf, EmplPostingGr, FALSE);

            CheckPostUnrealizedVAT(GenJnlLine, TRUE);

            IF DtldLedgEntryInserted THEN
                IF IsTempGLEntryBufEmpty THEN
                    DtldEmplLedgEntry.SetZeroTransNo(NextTransactionNo);

            FinishPosting;
        END;
    end;

    local procedure PrepareTempVendLedgEntry(GenJnlLine: Record "81"; var NewCVLedgEntryBuf: Record "382"; var TempOldVendLedgEntry: Record "25" temporary; Vend: Record "23"; var ApplyingDate: Date): Boolean
    var
        OldVendLedgEntry: Record "25";
        PurchSetup: Record "312";
        GenJnlApply: Codeunit "225";
        RemainingAmount: Decimal;
    begin
        IF GenJnlLine."Applies-to Doc. No." <> '' THEN BEGIN
            // Find the entry to be applied to
            OldVendLedgEntry.RESET;
            OldVendLedgEntry.SETCURRENTKEY("Document No.");
            OldVendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
            OldVendLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
            OldVendLedgEntry.SETRANGE("Vendor No.", NewCVLedgEntryBuf."CV No.");
            OldVendLedgEntry.SETRANGE(Open, TRUE);
            OldVendLedgEntry.FINDFIRST;
            OldVendLedgEntry.TESTFIELD(Positive, NOT NewCVLedgEntryBuf.Positive);
            IF OldVendLedgEntry."Posting Date" > ApplyingDate THEN
                ApplyingDate := OldVendLedgEntry."Posting Date";
            GenJnlApply.CheckAgainstApplnCurrency(
              NewCVLedgEntryBuf."Currency Code", OldVendLedgEntry."Currency Code", GenJnlLine."Account Type"::Vendor, TRUE);
            TempOldVendLedgEntry := OldVendLedgEntry;
            TempOldVendLedgEntry.INSERT;
        END ELSE BEGIN
            // Find the first old entry (Invoice) which the new entry (Payment) should apply to
            OldVendLedgEntry.RESET;
            OldVendLedgEntry.SETCURRENTKEY("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
            TempOldVendLedgEntry.SETCURRENTKEY("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
            OldVendLedgEntry.SETRANGE("Vendor No.", NewCVLedgEntryBuf."CV No.");
            OldVendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
            OldVendLedgEntry.SETRANGE(Open, TRUE);
            OldVendLedgEntry.SETFILTER("Entry No.", '<>%1', NewCVLedgEntryBuf."Entry No.");
            IF NOT (Vend."Application Method" = Vend."Application Method"::"Apply to Oldest") THEN
                OldVendLedgEntry.SETFILTER("Amount to Apply", '<>%1', 0);

            IF Vend."Application Method" = Vend."Application Method"::"Apply to Oldest" THEN
                OldVendLedgEntry.SETFILTER("Posting Date", '..%1', GenJnlLine."Posting Date");

            // Check and Move Ledger Entries to Temp
            PurchSetup.GET;
            IF PurchSetup."Appln. between Currencies" = PurchSetup."Appln. between Currencies"::None THEN
                OldVendLedgEntry.SETRANGE("Currency Code", NewCVLedgEntryBuf."Currency Code");
            IF OldVendLedgEntry.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    IF GenJnlApply.CheckAgainstApplnCurrency(
                         NewCVLedgEntryBuf."Currency Code", OldVendLedgEntry."Currency Code", GenJnlLine."Account Type"::Vendor, FALSE)
                    THEN BEGIN
                        IF (OldVendLedgEntry."Posting Date" > ApplyingDate) AND (OldVendLedgEntry."Applies-to ID" <> '') THEN
                            ApplyingDate := OldVendLedgEntry."Posting Date";
                        TempOldVendLedgEntry := OldVendLedgEntry;
                        TempOldVendLedgEntry.INSERT;
                    END;
                UNTIL OldVendLedgEntry.NEXT = 0;

            TempOldVendLedgEntry.SETRANGE(Positive, NewCVLedgEntryBuf."Remaining Amount" > 0);

            IF TempOldVendLedgEntry.FIND('-') THEN BEGIN
                RemainingAmount := NewCVLedgEntryBuf."Remaining Amount";
                TempOldVendLedgEntry.SETRANGE(Positive);
                TempOldVendLedgEntry.FIND('-');
                REPEAT
                    TempOldVendLedgEntry.CALCFIELDS("Remaining Amount");
                    TempOldVendLedgEntry.RecalculateAmounts(
                      TempOldVendLedgEntry."Currency Code", NewCVLedgEntryBuf."Currency Code", NewCVLedgEntryBuf."Posting Date");
                    IF PaymentToleranceMgt.CheckCalcPmtDiscCVVend(NewCVLedgEntryBuf, TempOldVendLedgEntry, 0, FALSE, FALSE) THEN
                        TempOldVendLedgEntry."Remaining Amount" -= TempOldVendLedgEntry."Remaining Pmt. Disc. Possible";
                    RemainingAmount += TempOldVendLedgEntry."Remaining Amount";
                UNTIL TempOldVendLedgEntry.NEXT = 0;
                TempOldVendLedgEntry.SETRANGE(Positive, RemainingAmount < 0);
            END ELSE
                TempOldVendLedgEntry.SETRANGE(Positive);
            EXIT(TempOldVendLedgEntry.FIND('-'));
        END;
        EXIT(TRUE);
    end;

    local procedure PrepareTempEmplLedgEntry(GenJnlLine: Record "81"; var NewCVLedgEntryBuf: Record "382"; var TempOldEmplLedgEntry: Record "5222" temporary; Employee: Record "5200"; var ApplyingDate: Date): Boolean
    var
        OldEmplLedgEntry: Record "5222";
        RemainingAmount: Decimal;
    begin
        IF GenJnlLine."Applies-to Doc. No." <> '' THEN BEGIN
            // Find the entry to be applied to
            OldEmplLedgEntry.RESET;
            OldEmplLedgEntry.SETCURRENTKEY("Document No.");
            OldEmplLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
            OldEmplLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
            OldEmplLedgEntry.SETRANGE("Employee No.", NewCVLedgEntryBuf."CV No.");
            OldEmplLedgEntry.SETRANGE(Open, TRUE);
            OldEmplLedgEntry.FINDFIRST;
            OldEmplLedgEntry.TESTFIELD(Positive, NOT NewCVLedgEntryBuf.Positive);
            IF OldEmplLedgEntry."Posting Date" > ApplyingDate THEN
                ApplyingDate := OldEmplLedgEntry."Posting Date";
            TempOldEmplLedgEntry := OldEmplLedgEntry;
            TempOldEmplLedgEntry.INSERT;
        END ELSE BEGIN
            // Find the first old entry which the new entry (Payment) should apply to
            OldEmplLedgEntry.RESET;
            OldEmplLedgEntry.SETCURRENTKEY("Employee No.", "Applies-to ID", Open, Positive);
            TempOldEmplLedgEntry.SETCURRENTKEY("Employee No.", "Applies-to ID", Open, Positive);
            OldEmplLedgEntry.SETRANGE("Employee No.", NewCVLedgEntryBuf."CV No.");
            OldEmplLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
            OldEmplLedgEntry.SETRANGE(Open, TRUE);
            OldEmplLedgEntry.SETFILTER("Entry No.", '<>%1', NewCVLedgEntryBuf."Entry No.");
            IF NOT (Employee."Application Method" = Employee."Application Method"::"Apply to Oldest") THEN
                OldEmplLedgEntry.SETFILTER("Amount to Apply", '<>%1', 0);

            IF Employee."Application Method" = Employee."Application Method"::"Apply to Oldest" THEN
                OldEmplLedgEntry.SETFILTER("Posting Date", '..%1', GenJnlLine."Posting Date");

            OldEmplLedgEntry.SETRANGE("Currency Code", NewCVLedgEntryBuf."Currency Code");
            IF OldEmplLedgEntry.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    IF (OldEmplLedgEntry."Posting Date" > ApplyingDate) AND (OldEmplLedgEntry."Applies-to ID" <> '') THEN
                        ApplyingDate := OldEmplLedgEntry."Posting Date";
                    TempOldEmplLedgEntry := OldEmplLedgEntry;
                    TempOldEmplLedgEntry.INSERT;
                UNTIL OldEmplLedgEntry.NEXT = 0;

            TempOldEmplLedgEntry.SETRANGE(Positive, NewCVLedgEntryBuf."Remaining Amount" > 0);

            IF TempOldEmplLedgEntry.FIND('-') THEN BEGIN
                RemainingAmount := NewCVLedgEntryBuf."Remaining Amount";
                TempOldEmplLedgEntry.SETRANGE(Positive);
                TempOldEmplLedgEntry.FIND('-');
                REPEAT
                    TempOldEmplLedgEntry.CALCFIELDS("Remaining Amount");
                    RemainingAmount += TempOldEmplLedgEntry."Remaining Amount";
                UNTIL TempOldEmplLedgEntry.NEXT = 0;
                TempOldEmplLedgEntry.SETRANGE(Positive, RemainingAmount < 0);
            END ELSE
                TempOldEmplLedgEntry.SETRANGE(Positive);
            EXIT(TempOldEmplLedgEntry.FIND('-'));
        END;
        EXIT(TRUE);
    end;

    local procedure PostDtldVendLedgEntries(GenJnlLine: Record "81"; var DtldCVLedgEntryBuf: Record "383"; VendPostingGr: Record "93"; LedgEntryInserted: Boolean) DtldLedgEntryInserted: Boolean
    var
        TempInvPostBuf: Record "49" temporary;
        DtldVendLedgEntry: Record "380";
        AdjAmount: array[4] of Decimal;
        DtldVendLedgEntryNoOffset: Integer;
        SaveEntryNo: Integer;
    begin
        IF GenJnlLine."Account Type" <> GenJnlLine."Account Type"::Vendor THEN
            EXIT;

        IF DtldVendLedgEntry.FINDLAST THEN
            DtldVendLedgEntryNoOffset := DtldVendLedgEntry."Entry No."
        ELSE
            DtldVendLedgEntryNoOffset := 0;

        DtldCVLedgEntryBuf.RESET;
        IF DtldCVLedgEntryBuf.FINDSET THEN BEGIN
            IF LedgEntryInserted THEN BEGIN
                SaveEntryNo := NextEntryNo;
                NextEntryNo := NextEntryNo + 1;
            END;
            REPEAT
                InsertDtldVendLedgEntry(GenJnlLine, DtldCVLedgEntryBuf, DtldVendLedgEntry, DtldVendLedgEntryNoOffset);

                UpdateTotalAmounts(
                  TempInvPostBuf, GenJnlLine."Dimension Set ID",
                  DtldCVLedgEntryBuf."Amount (LCY)", DtldCVLedgEntryBuf."Additional-Currency Amount");

                // Post automatic entries.
                IF ((DtldCVLedgEntryBuf."Amount (LCY)" <> 0) OR
                    (DtldCVLedgEntryBuf."VAT Amount (LCY)" <> 0)) OR
                   ((AddCurrencyCode <> '') AND (DtldCVLedgEntryBuf."Additional-Currency Amount" <> 0))
                THEN
                    PostDtldVendLedgEntry(GenJnlLine, DtldCVLedgEntryBuf, VendPostingGr, AdjAmount);
            UNTIL DtldCVLedgEntryBuf.NEXT = 0;
        END;

        CreateGLEntriesForTotalAmounts(
          GenJnlLine, TempInvPostBuf, AdjAmount, SaveEntryNo, VendPostingGr.GetPayablesAccount, LedgEntryInserted);

        DtldLedgEntryInserted := NOT DtldCVLedgEntryBuf.ISEMPTY;
        DtldCVLedgEntryBuf.DELETEALL;
    end;

    local procedure PostDtldVendLedgEntry(GenJnlLine: Record "81"; DtldCVLedgEntryBuf: Record "383"; VendPostingGr: Record "93"; var AdjAmount: array[4] of Decimal)
    var
        AccNo: Code[20];
    begin
        AccNo := GetDtldVendLedgEntryAccNo(GenJnlLine, DtldCVLedgEntryBuf, VendPostingGr, 0, FALSE);
        PostDtldCVLedgEntry(GenJnlLine, DtldCVLedgEntryBuf, AccNo, AdjAmount, FALSE);
    end;

    local procedure PostDtldVendLedgEntryUnapply(GenJnlLine: Record "81"; DtldCVLedgEntryBuf: Record "383"; VendPostingGr: Record "93"; OriginalTransactionNo: Integer)
    var
        AccNo: Code[20];
        AdjAmount: array[4] of Decimal;
    begin
        IF (DtldCVLedgEntryBuf."Amount (LCY)" = 0) AND
           (DtldCVLedgEntryBuf."VAT Amount (LCY)" = 0) AND
           ((AddCurrencyCode = '') OR (DtldCVLedgEntryBuf."Additional-Currency Amount" = 0))
        THEN
            EXIT;

        AccNo := GetDtldVendLedgEntryAccNo(GenJnlLine, DtldCVLedgEntryBuf, VendPostingGr, OriginalTransactionNo, TRUE);
        DtldCVLedgEntryBuf."Gen. Posting Type" := DtldCVLedgEntryBuf."Gen. Posting Type"::Purchase;
        PostDtldCVLedgEntry(GenJnlLine, DtldCVLedgEntryBuf, AccNo, AdjAmount, TRUE);
    end;

    local procedure GetDtldVendLedgEntryAccNo(GenJnlLine: Record "81"; DtldCVLedgEntryBuf: Record "383"; VendPostingGr: Record "93"; OriginalTransactionNo: Integer; Unapply: Boolean): Code[20]
    var
        Currency: Record "4";
        GenPostingSetup: Record "252";
        AmountCondition: Boolean;
    begin
        WITH DtldCVLedgEntryBuf DO BEGIN
            AmountCondition := IsDebitAmount(DtldCVLedgEntryBuf, Unapply);
            CASE "Entry Type" OF
                "Entry Type"::"Initial Entry":
                    ;
                "Entry Type"::Application:
                    ;
                "Entry Type"::"Unrealized Loss",
                "Entry Type"::"Unrealized Gain",
                "Entry Type"::"Realized Loss",
                "Entry Type"::"Realized Gain":
                    BEGIN
                        GetCurrency(Currency, "Currency Code");
                        CheckNonAddCurrCodeOccurred(Currency.Code);
                        EXIT(Currency.GetGainLossAccount(DtldCVLedgEntryBuf));
                    END;
                "Entry Type"::"Payment Discount":
                    EXIT(VendPostingGr.GetPmtDiscountAccount(AmountCondition));
                "Entry Type"::"Payment Discount (VAT Excl.)":
                    BEGIN
                        GenPostingSetup.GET("Gen. Bus. Posting Group", "Gen. Prod. Posting Group");
                        EXIT(GenPostingSetup.GetPurchPmtDiscountAccount(AmountCondition));
                    END;
                "Entry Type"::"Appln. Rounding":
                    EXIT(VendPostingGr.GetApplRoundingAccount(AmountCondition));
                "Entry Type"::"Correction of Remaining Amount":
                    EXIT(VendPostingGr.GetRoundingAccount(AmountCondition));
                "Entry Type"::"Payment Discount Tolerance":
                    CASE GLSetup."Pmt. Disc. Tolerance Posting" OF
                        GLSetup."Pmt. Disc. Tolerance Posting"::"Payment Tolerance Accounts":
                            EXIT(VendPostingGr.GetPmtToleranceAccount(AmountCondition));
                        GLSetup."Pmt. Disc. Tolerance Posting"::"Payment Discount Accounts":
                            EXIT(VendPostingGr.GetPmtDiscountAccount(AmountCondition));
                    END;
                "Entry Type"::"Payment Tolerance":
                    CASE GLSetup."Payment Tolerance Posting" OF
                        GLSetup."Payment Tolerance Posting"::"Payment Tolerance Accounts":
                            EXIT(VendPostingGr.GetPmtToleranceAccount(AmountCondition));
                        GLSetup."Payment Tolerance Posting"::"Payment Discount Accounts":
                            EXIT(VendPostingGr.GetPmtDiscountAccount(AmountCondition));
                    END;
                "Entry Type"::"Payment Tolerance (VAT Excl.)":
                    BEGIN
                        GenPostingSetup.GET("Gen. Bus. Posting Group", "Gen. Prod. Posting Group");
                        CASE GLSetup."Payment Tolerance Posting" OF
                            GLSetup."Payment Tolerance Posting"::"Payment Tolerance Accounts":
                                EXIT(GenPostingSetup.GetPurchPmtToleranceAccount(AmountCondition));
                            GLSetup."Payment Tolerance Posting"::"Payment Discount Accounts":
                                EXIT(GenPostingSetup.GetPurchPmtDiscountAccount(AmountCondition));
                        END;
                    END;
                "Entry Type"::"Payment Discount Tolerance (VAT Excl.)":
                    BEGIN
                        GenPostingSetup.GET("Gen. Bus. Posting Group", "Gen. Prod. Posting Group");
                        CASE GLSetup."Pmt. Disc. Tolerance Posting" OF
                            GLSetup."Pmt. Disc. Tolerance Posting"::"Payment Tolerance Accounts":
                                EXIT(GenPostingSetup.GetPurchPmtToleranceAccount(AmountCondition));
                            GLSetup."Pmt. Disc. Tolerance Posting"::"Payment Discount Accounts":
                                EXIT(GenPostingSetup.GetPurchPmtDiscountAccount(AmountCondition));
                        END;
                    END;
                "Entry Type"::"Payment Discount (VAT Adjustment)",
              "Entry Type"::"Payment Tolerance (VAT Adjustment)",
              "Entry Type"::"Payment Discount Tolerance (VAT Adjustment)":
                    IF Unapply THEN
                        PostDtldVendVATAdjustment(GenJnlLine, DtldCVLedgEntryBuf, OriginalTransactionNo);
                ELSE
                    FIELDERROR("Entry Type");
            END;
        END;
    end;

    local procedure PostDtldEmplLedgEntries(GenJnlLine: Record "81"; var DtldCVLedgEntryBuf: Record "383"; EmplPostingGr: Record "5221"; LedgEntryInserted: Boolean) DtldLedgEntryInserted: Boolean
    var
        TempInvPostBuf: Record "49" temporary;
        DtldEmplLedgEntry: Record "5223";
        DummyAdjAmount: array[4] of Decimal;
        DtldEmplLedgEntryNoOffset: Integer;
        SaveEntryNo: Integer;
    begin
        IF GenJnlLine."Account Type" <> GenJnlLine."Account Type"::Employee THEN
            EXIT;

        IF DtldEmplLedgEntry.FINDLAST THEN
            DtldEmplLedgEntryNoOffset := DtldEmplLedgEntry."Entry No."
        ELSE
            DtldEmplLedgEntryNoOffset := 0;

        DtldCVLedgEntryBuf.RESET;
        IF DtldCVLedgEntryBuf.FINDSET THEN BEGIN
            IF LedgEntryInserted THEN BEGIN
                SaveEntryNo := NextEntryNo;
                NextEntryNo := NextEntryNo + 1;
            END;
            REPEAT
                InsertDtldEmplLedgEntry(GenJnlLine, DtldCVLedgEntryBuf, DtldEmplLedgEntry, DtldEmplLedgEntryNoOffset);

                UpdateTotalAmounts(
                  TempInvPostBuf, GenJnlLine."Dimension Set ID",
                  DtldCVLedgEntryBuf."Amount (LCY)", DtldCVLedgEntryBuf."Additional-Currency Amount");
            UNTIL DtldCVLedgEntryBuf.NEXT = 0;
        END;

        CreateGLEntriesForTotalAmounts(
          GenJnlLine, TempInvPostBuf, DummyAdjAmount, SaveEntryNo, EmplPostingGr.GetPayablesAccount, LedgEntryInserted);

        DtldLedgEntryInserted := NOT DtldCVLedgEntryBuf.ISEMPTY;
        DtldCVLedgEntryBuf.DELETEALL;
    end;

    local procedure PostDtldCVLedgEntry(GenJnlLine: Record "81"; DtldCVLedgEntryBuf: Record "383"; AccNo: Code[20]; var AdjAmount: array[4] of Decimal; Unapply: Boolean)
    begin
        WITH DtldCVLedgEntryBuf DO
            CASE "Entry Type" OF
                "Entry Type"::"Initial Entry":
                    ;
                "Entry Type"::Application:
                    ;
                "Entry Type"::"Unrealized Loss",
                "Entry Type"::"Unrealized Gain",
                "Entry Type"::"Realized Loss",
                "Entry Type"::"Realized Gain":
                    BEGIN
                        CreateGLEntryGainLoss(GenJnlLine, AccNo, -"Amount (LCY)", "Currency Code" = AddCurrencyCode);
                        IF NOT Unapply THEN
                            CollectAdjustment(AdjAmount, -"Amount (LCY)", 0);
                    END;
                "Entry Type"::"Payment Discount",
                "Entry Type"::"Payment Tolerance",
                "Entry Type"::"Payment Discount Tolerance":
                    BEGIN
                        CreateGLEntry(GenJnlLine, AccNo, -"Amount (LCY)", -"Additional-Currency Amount", FALSE);
                        IF NOT Unapply THEN
                            CollectAdjustment(AdjAmount, -"Amount (LCY)", -"Additional-Currency Amount");
                    END;
                "Entry Type"::"Payment Discount (VAT Excl.)",
                "Entry Type"::"Payment Tolerance (VAT Excl.)",
                "Entry Type"::"Payment Discount Tolerance (VAT Excl.)":
                    BEGIN
                        IF NOT Unapply THEN
                            CreateGLEntryVATCollectAdj(
                              GenJnlLine, AccNo, -"Amount (LCY)", -"Additional-Currency Amount", -"VAT Amount (LCY)", DtldCVLedgEntryBuf,
                              AdjAmount)
                        ELSE
                            CreateGLEntryVAT(
                              GenJnlLine, AccNo, -"Amount (LCY)", -"Additional-Currency Amount", -"VAT Amount (LCY)", DtldCVLedgEntryBuf);
                    END;
                "Entry Type"::"Appln. Rounding":
                    IF "Amount (LCY)" <> 0 THEN BEGIN
                        CreateGLEntry(GenJnlLine, AccNo, -"Amount (LCY)", -"Additional-Currency Amount", TRUE);
                        IF NOT Unapply THEN
                            CollectAdjustment(AdjAmount, -"Amount (LCY)", -"Additional-Currency Amount");
                    END;
                "Entry Type"::"Correction of Remaining Amount":
                    IF "Amount (LCY)" <> 0 THEN BEGIN
                        CreateGLEntry(GenJnlLine, AccNo, -"Amount (LCY)", 0, FALSE);
                        IF NOT Unapply THEN
                            CollectAdjustment(AdjAmount, -"Amount (LCY)", 0);
                    END;
                "Entry Type"::"Payment Discount (VAT Adjustment)",
              "Entry Type"::"Payment Tolerance (VAT Adjustment)",
              "Entry Type"::"Payment Discount Tolerance (VAT Adjustment)":
                    ;
                ELSE
                    FIELDERROR("Entry Type");
            END;
    end;

    local procedure PostDtldCustVATAdjustment(GenJnlLine: Record "81"; DtldCVLedgEntryBuf: Record "383"; OriginalTransactionNo: Integer)
    var
        VATPostingSetup: Record "325";
        TaxJurisdiction: Record "320";
    begin
        WITH DtldCVLedgEntryBuf DO BEGIN
            FindVATEntry(VATEntry, OriginalTransactionNo);

            CASE VATPostingSetup."VAT Calculation Type" OF
                VATPostingSetup."VAT Calculation Type"::"Normal VAT",
                VATPostingSetup."VAT Calculation Type"::"Full VAT":
                    BEGIN
                        VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                        VATPostingSetup.TESTFIELD("VAT Calculation Type", VATEntry."VAT Calculation Type");
                        CreateGLEntry(
                          GenJnlLine, VATPostingSetup.GetSalesAccount(FALSE), -"Amount (LCY)", -"Additional-Currency Amount", FALSE);
                    END;
                VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                    ;
                VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                    BEGIN
                        TESTFIELD("Tax Jurisdiction Code");
                        TaxJurisdiction.GET("Tax Jurisdiction Code");
                        CreateGLEntry(
                          GenJnlLine, TaxJurisdiction.GetPurchAccount(FALSE), -"Amount (LCY)", -"Additional-Currency Amount", FALSE);
                    END;
            END;
        END;
    end;

    local procedure PostDtldVendVATAdjustment(GenJnlLine: Record "81"; DtldCVLedgEntryBuf: Record "383"; OriginalTransactionNo: Integer)
    var
        VATPostingSetup: Record "325";
        TaxJurisdiction: Record "320";
    begin
        WITH DtldCVLedgEntryBuf DO BEGIN
            FindVATEntry(VATEntry, OriginalTransactionNo);

            CASE VATPostingSetup."VAT Calculation Type" OF
                VATPostingSetup."VAT Calculation Type"::"Normal VAT",
                VATPostingSetup."VAT Calculation Type"::"Full VAT":
                    BEGIN
                        VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                        VATPostingSetup.TESTFIELD("VAT Calculation Type", VATEntry."VAT Calculation Type");
                        CreateGLEntry(
                          GenJnlLine, VATPostingSetup.GetPurchAccount(FALSE), -"Amount (LCY)", -"Additional-Currency Amount", FALSE);
                    END;
                VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                    BEGIN
                        VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                        VATPostingSetup.TESTFIELD("VAT Calculation Type", VATEntry."VAT Calculation Type");
                        CreateGLEntry(
                          GenJnlLine, VATPostingSetup.GetPurchAccount(FALSE), -"Amount (LCY)", -"Additional-Currency Amount", FALSE);
                        CreateGLEntry(
                          GenJnlLine, VATPostingSetup.GetRevChargeAccount(FALSE), "Amount (LCY)", "Additional-Currency Amount", FALSE);
                    END;
                VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                    BEGIN
                        TaxJurisdiction.GET("Tax Jurisdiction Code");
                        IF "Use Tax" THEN BEGIN
                            CreateGLEntry(
                              GenJnlLine, TaxJurisdiction.GetPurchAccount(FALSE), -"Amount (LCY)", -"Additional-Currency Amount", FALSE);
                            CreateGLEntry(
                              GenJnlLine, TaxJurisdiction.GetRevChargeAccount(FALSE), "Amount (LCY)", "Additional-Currency Amount", FALSE);
                        END ELSE
                            CreateGLEntry(
                              GenJnlLine, TaxJurisdiction.GetPurchAccount(FALSE), -"Amount (LCY)", -"Additional-Currency Amount", FALSE);
                    END;
            END;
        END;
    end;

    local procedure VendUnrealizedVAT(GenJnlLine: Record "81"; var VendLedgEntry2: Record "25"; SettledAmount: Decimal)
    var
        VATEntry2: Record "254";
        TaxJurisdiction: Record "320";
        VATPostingSetup: Record "325";
        VATPart: Decimal;
        VATAmount: Decimal;
        VATBase: Decimal;
        VATAmountAddCurr: Decimal;
        VATBaseAddCurr: Decimal;
        PaidAmount: Decimal;
        TotalUnrealVATAmountFirst: Decimal;
        TotalUnrealVATAmountLast: Decimal;
        PurchVATAccount: Code[20];
        PurchVATUnrealAccount: Code[20];
        PurchReverseAccount: Code[20];
        PurchReverseUnrealAccount: Code[20];
        LastConnectionNo: Integer;
        GLEntryNo: Integer;
    begin
        VATEntry2.RESET;
        VATEntry2.SETCURRENTKEY("Transaction No.");
        VATEntry2.SETRANGE("Transaction No.", VendLedgEntry2."Transaction No.");
        PaidAmount := -VendLedgEntry2."Amount (LCY)" + VendLedgEntry2."Remaining Amt. (LCY)";
        IF VATEntry2.FINDSET THEN
            REPEAT
                VATPostingSetup.GET(VATEntry2."VAT Bus. Posting Group", VATEntry2."VAT Prod. Posting Group");
                IF VATPostingSetup."Unrealized VAT Type" IN
                   [VATPostingSetup."Unrealized VAT Type"::Last, VATPostingSetup."Unrealized VAT Type"::"Last (Fully Paid)"]
                THEN
                    TotalUnrealVATAmountLast := TotalUnrealVATAmountLast - VATEntry2."Remaining Unrealized Amount";
                IF VATPostingSetup."Unrealized VAT Type" IN
                   [VATPostingSetup."Unrealized VAT Type"::First, VATPostingSetup."Unrealized VAT Type"::"First (Fully Paid)"]
                THEN
                    TotalUnrealVATAmountFirst := TotalUnrealVATAmountFirst - VATEntry2."Remaining Unrealized Amount";
            UNTIL VATEntry2.NEXT = 0;
        IF VATEntry2.FINDSET THEN BEGIN
            LastConnectionNo := 0;
            REPEAT
                VATPostingSetup.GET(VATEntry2."VAT Bus. Posting Group", VATEntry2."VAT Prod. Posting Group");
                IF LastConnectionNo <> VATEntry2."Sales Tax Connection No." THEN BEGIN
                    InsertSummarizedVAT(GenJnlLine);
                    LastConnectionNo := VATEntry2."Sales Tax Connection No.";
                END;

                VATPart :=
                  VATEntry2.GetUnrealizedVATPart(
                    ROUND(SettledAmount / VendLedgEntry2.GetOriginalCurrencyFactor),
                    PaidAmount,
                    VendLedgEntry2."Original Amt. (LCY)",
                    TotalUnrealVATAmountFirst,
                    TotalUnrealVATAmountLast);

                IF VATPart > 0 THEN BEGIN
                    CASE VATEntry2."VAT Calculation Type" OF
                        VATEntry2."VAT Calculation Type"::"Normal VAT",
                        VATEntry2."VAT Calculation Type"::"Full VAT":
                            BEGIN
                                PurchVATAccount := VATPostingSetup.GetPurchAccount(FALSE);
                                PurchVATUnrealAccount := VATPostingSetup.GetPurchAccount(TRUE);
                            END;
                        VATEntry2."VAT Calculation Type"::"Reverse Charge VAT":
                            BEGIN
                                PurchVATAccount := VATPostingSetup.GetPurchAccount(FALSE);
                                PurchVATUnrealAccount := VATPostingSetup.GetPurchAccount(TRUE);
                                PurchReverseAccount := VATPostingSetup.GetRevChargeAccount(FALSE);
                                PurchReverseUnrealAccount := VATPostingSetup.GetRevChargeAccount(TRUE);
                            END;
                        VATEntry2."VAT Calculation Type"::"Sales Tax":
                            IF (VATEntry2.Type = VATEntry2.Type::Purchase) AND VATEntry2."Use Tax" THEN BEGIN
                                TaxJurisdiction.GET(VATEntry2."Tax Jurisdiction Code");
                                PurchVATAccount := TaxJurisdiction.GetPurchAccount(FALSE);
                                PurchVATUnrealAccount := TaxJurisdiction.GetPurchAccount(TRUE);
                                PurchReverseAccount := TaxJurisdiction.GetRevChargeAccount(FALSE);
                                PurchReverseUnrealAccount := TaxJurisdiction.GetRevChargeAccount(TRUE);
                            END ELSE BEGIN
                                TaxJurisdiction.GET(VATEntry2."Tax Jurisdiction Code");
                                PurchVATAccount := TaxJurisdiction.GetPurchAccount(FALSE);
                                PurchVATUnrealAccount := TaxJurisdiction.GetPurchAccount(TRUE);
                            END;
                    END;

                    IF VATPart = 1 THEN BEGIN
                        VATAmount := VATEntry2."Remaining Unrealized Amount";
                        VATBase := VATEntry2."Remaining Unrealized Base";
                        VATAmountAddCurr := VATEntry2."Add.-Curr. Rem. Unreal. Amount";
                        VATBaseAddCurr := VATEntry2."Add.-Curr. Rem. Unreal. Base";
                    END ELSE BEGIN
                        VATAmount := ROUND(VATEntry2."Remaining Unrealized Amount" * VATPart, GLSetup."Amount Rounding Precision");
                        VATBase := ROUND(VATEntry2."Remaining Unrealized Base" * VATPart, GLSetup."Amount Rounding Precision");
                        VATAmountAddCurr :=
                          ROUND(
                            VATEntry2."Add.-Curr. Rem. Unreal. Amount" * VATPart,
                            AddCurrency."Amount Rounding Precision");
                        VATBaseAddCurr :=
                          ROUND(
                            VATEntry2."Add.-Curr. Rem. Unreal. Base" * VATPart,
                            AddCurrency."Amount Rounding Precision");
                    END;

                    InitGLEntryVAT(
                      GenJnlLine, PurchVATUnrealAccount, PurchVATAccount, -VATAmount, -VATAmountAddCurr, FALSE);
                    GLEntryNo :=
                      InitGLEntryVATCopy(GenJnlLine, PurchVATAccount, PurchVATUnrealAccount, VATAmount, VATAmountAddCurr, VATEntry2);

                    IF (VATEntry2."VAT Calculation Type" =
                        VATEntry2."VAT Calculation Type"::"Reverse Charge VAT") OR
                       ((VATEntry2."VAT Calculation Type" =
                         VATEntry2."VAT Calculation Type"::"Sales Tax") AND
                        (VATEntry2.Type = VATEntry2.Type::Purchase) AND VATEntry2."Use Tax")
                    THEN BEGIN
                        InitGLEntryVAT(
                          GenJnlLine, PurchReverseUnrealAccount, PurchReverseAccount, VATAmount, VATAmountAddCurr, FALSE);
                        GLEntryNo :=
                          InitGLEntryVATCopy(GenJnlLine, PurchReverseAccount, PurchReverseUnrealAccount, -VATAmount, -VATAmountAddCurr, VATEntry2);
                    END;

                    PostUnrealVATEntry(GenJnlLine, VATEntry2, VATAmount, VATBase, VATAmountAddCurr, VATBaseAddCurr, GLEntryNo);
                END;
            UNTIL VATEntry2.NEXT = 0;

            InsertSummarizedVAT(GenJnlLine);
        END;
    end;

    local procedure PostUnrealVATEntry(GenJnlLine: Record "81"; var VATEntry2: Record "254"; VATAmount: Decimal; VATBase: Decimal; VATAmountAddCurr: Decimal; VATBaseAddCurr: Decimal; GLEntryNo: Integer)
    begin
        VATEntry.LOCKTABLE;
        VATEntry := VATEntry2;
        VATEntry."Entry No." := NextVATEntryNo;
        VATEntry."Posting Date" := GenJnlLine."Posting Date";
        VATEntry."Document No." := GenJnlLine."Document No.";
        VATEntry."External Document No." := GenJnlLine."External Document No.";
        VATEntry."Document Type" := GenJnlLine."Document Type";
        VATEntry.Amount := VATAmount;
        VATEntry.Base := VATBase;
        VATEntry."Additional-Currency Amount" := VATAmountAddCurr;
        VATEntry."Additional-Currency Base" := VATBaseAddCurr;
        VATEntry.SetUnrealAmountsToZero;
        VATEntry."User ID" := USERID;
        VATEntry."Source Code" := GenJnlLine."Source Code";
        VATEntry."Reason Code" := GenJnlLine."Reason Code";
        VATEntry."Closed by Entry No." := 0;
        VATEntry.Closed := FALSE;
        VATEntry."Transaction No." := NextTransactionNo;
        VATEntry."Sales Tax Connection No." := NextConnectionNo;
        VATEntry."Unrealized VAT Entry No." := VATEntry2."Entry No.";
        VATEntry.INSERT(TRUE);
        GLEntryVATEntryLink.InsertLink(GLEntryNo + 1, NextVATEntryNo);
        NextVATEntryNo := NextVATEntryNo + 1;

        VATEntry2."Remaining Unrealized Amount" :=
          VATEntry2."Remaining Unrealized Amount" - VATEntry.Amount;
        VATEntry2."Remaining Unrealized Base" :=
          VATEntry2."Remaining Unrealized Base" - VATEntry.Base;
        VATEntry2."Add.-Curr. Rem. Unreal. Amount" :=
          VATEntry2."Add.-Curr. Rem. Unreal. Amount" - VATEntry."Additional-Currency Amount";
        VATEntry2."Add.-Curr. Rem. Unreal. Base" :=
          VATEntry2."Add.-Curr. Rem. Unreal. Base" - VATEntry."Additional-Currency Base";
        VATEntry2.MODIFY;
    end;

    local procedure PostApply(GenJnlLine: Record "81"; var DtldCVLedgEntryBuf: Record "383"; var OldCVLedgEntryBuf: Record "382"; var NewCVLedgEntryBuf: Record "382"; var NewCVLedgEntryBuf2: Record "382"; BlockPaymentTolerance: Boolean; AllApplied: Boolean; var AppliedAmount: Decimal; var PmtTolAmtToBeApplied: Decimal)
    var
        OldCVLedgEntryBuf2: Record "382";
        OldCVLedgEntryBuf3: Record "382";
        OldRemainingAmtBeforeAppln: Decimal;
        ApplnRoundingPrecision: Decimal;
        AppliedAmountLCY: Decimal;
        OldAppliedAmount: Decimal;
    begin
        OldRemainingAmtBeforeAppln := OldCVLedgEntryBuf."Remaining Amount";
        OldCVLedgEntryBuf3 := OldCVLedgEntryBuf;

        // Management of posting in multiple currencies
        OldCVLedgEntryBuf2 := OldCVLedgEntryBuf;
        OldCVLedgEntryBuf.COPYFILTER(Positive, OldCVLedgEntryBuf2.Positive);
        ApplnRoundingPrecision := GetApplnRoundPrecision(NewCVLedgEntryBuf, OldCVLedgEntryBuf);

        OldCVLedgEntryBuf2.RecalculateAmounts(
          OldCVLedgEntryBuf2."Currency Code", NewCVLedgEntryBuf."Currency Code", NewCVLedgEntryBuf."Posting Date");

        IF NOT BlockPaymentTolerance THEN
            CalcPmtTolerance(
              NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine,
              PmtTolAmtToBeApplied, NextTransactionNo, FirstNewVATEntryNo);

        CalcPmtDisc(
          NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine,
          PmtTolAmtToBeApplied, ApplnRoundingPrecision, NextTransactionNo, FirstNewVATEntryNo);

        IF NOT BlockPaymentTolerance THEN
            CalcPmtDiscTolerance(
              NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine,
              NextTransactionNo, FirstNewVATEntryNo);

        CalcCurrencyApplnRounding(
          NewCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf,
          GenJnlLine, ApplnRoundingPrecision);

        FindAmtForAppln(
          NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2,
          AppliedAmount, AppliedAmountLCY, OldAppliedAmount, ApplnRoundingPrecision);

        CalcCurrencyUnrealizedGainLoss(
          OldCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine, -OldAppliedAmount, OldRemainingAmtBeforeAppln);

        CalcCurrencyRealizedGainLoss(
          NewCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine, AppliedAmount, AppliedAmountLCY);

        CalcCurrencyRealizedGainLoss(
          OldCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine, -OldAppliedAmount, -AppliedAmountLCY);

        CalcApplication(
          NewCVLedgEntryBuf, OldCVLedgEntryBuf, DtldCVLedgEntryBuf,
          GenJnlLine, AppliedAmount, AppliedAmountLCY, OldAppliedAmount,
          NewCVLedgEntryBuf2, OldCVLedgEntryBuf3, AllApplied);

        PaymentToleranceMgt.CalcRemainingPmtDisc(NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, GLSetup);

        CalcAmtLCYAdjustment(OldCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine);
    end;

    procedure UnapplyCustLedgEntry(GenJnlLine2: Record "81"; DtldCustLedgEntry: Record "379")
    var
        Cust: Record "18";
        CustPostingGr: Record "92";
        GenJnlLine: Record "81";
        DtldCustLedgEntry2: Record "379";
        NewDtldCustLedgEntry: Record "379";
        CustLedgEntry: Record "21";
        DtldCVLedgEntryBuf: Record "383";
        VATEntry: Record "254";
        TempVATEntry2: Record "254" temporary;
        CurrencyLCY: Record "4";
        TempInvPostBuf: Record "49" temporary;
        AdjAmount: array[4] of Decimal;
        NextDtldLedgEntryNo: Integer;
        UnapplyVATEntries: Boolean;
    begin
        GenJnlLine.TRANSFERFIELDS(GenJnlLine2);
        IF GenJnlLine."Document Date" = 0D THEN
            GenJnlLine."Document Date" := GenJnlLine."Posting Date";

        IF NextEntryNo = 0 THEN
            StartPosting(GenJnlLine)
        ELSE
            ContinuePosting(GenJnlLine);

        ReadGLSetup(GLSetup);

        Cust.GET(DtldCustLedgEntry."Customer No.");
        Cust.CheckBlockedCustOnJnls(Cust, GenJnlLine2."Document Type"::Payment, TRUE);
        CustPostingGr.GET(GenJnlLine."Posting Group");
        CustPostingGr.GetReceivablesAccount;

        VATEntry.LOCKTABLE;
        DtldCustLedgEntry.LOCKTABLE;
        CustLedgEntry.LOCKTABLE;

        DtldCustLedgEntry.TESTFIELD("Entry Type", DtldCustLedgEntry."Entry Type"::Application);

        DtldCustLedgEntry2.RESET;
        DtldCustLedgEntry2.FINDLAST;
        NextDtldLedgEntryNo := DtldCustLedgEntry2."Entry No." + 1;
        IF DtldCustLedgEntry."Transaction No." = 0 THEN BEGIN
            DtldCustLedgEntry2.SETCURRENTKEY("Application No.", "Customer No.", "Entry Type");
            DtldCustLedgEntry2.SETRANGE("Application No.", DtldCustLedgEntry."Application No.");
        END ELSE BEGIN
            DtldCustLedgEntry2.SETCURRENTKEY("Transaction No.", "Customer No.", "Entry Type");
            DtldCustLedgEntry2.SETRANGE("Transaction No.", DtldCustLedgEntry."Transaction No.");
        END;
        DtldCustLedgEntry2.SETRANGE("Customer No.", DtldCustLedgEntry."Customer No.");
        DtldCustLedgEntry2.SETFILTER("Entry Type", '>%1', DtldCustLedgEntry."Entry Type"::"Initial Entry");
        IF DtldCustLedgEntry."Transaction No." <> 0 THEN BEGIN
            UnapplyVATEntries := FALSE;
            DtldCustLedgEntry2.FINDSET;
            REPEAT
                DtldCustLedgEntry2.TESTFIELD(Unapplied, FALSE);
                IF IsVATAdjustment(DtldCustLedgEntry2."Entry Type") THEN
                    UnapplyVATEntries := TRUE
            UNTIL DtldCustLedgEntry2.NEXT = 0;

            PostUnapply(
              GenJnlLine, VATEntry, VATEntry.Type::Sale,
              DtldCustLedgEntry."Customer No.", DtldCustLedgEntry."Transaction No.", UnapplyVATEntries, TempVATEntry);

            DtldCustLedgEntry2.FINDSET;
            REPEAT
                DtldCVLedgEntryBuf.INIT;
                DtldCVLedgEntryBuf.TRANSFERFIELDS(DtldCustLedgEntry2);
                ProcessTempVATEntry(DtldCVLedgEntryBuf, TempVATEntry);
            UNTIL DtldCustLedgEntry2.NEXT = 0;
        END;

        // Look one more time
        DtldCustLedgEntry2.FINDSET;
        TempInvPostBuf.DELETEALL;
        REPEAT
            DtldCustLedgEntry2.TESTFIELD(Unapplied, FALSE);
            InsertDtldCustLedgEntryUnapply(GenJnlLine, NewDtldCustLedgEntry, DtldCustLedgEntry2, NextDtldLedgEntryNo);

            DtldCVLedgEntryBuf.INIT;
            DtldCVLedgEntryBuf.TRANSFERFIELDS(NewDtldCustLedgEntry);
            SetAddCurrForUnapplication(DtldCVLedgEntryBuf);
            CurrencyLCY.InitRoundingPrecision;

            IF (DtldCustLedgEntry2."Transaction No." <> 0) AND IsVATExcluded(DtldCustLedgEntry2."Entry Type") THEN BEGIN
                UnapplyExcludedVAT(
                  TempVATEntry2, DtldCustLedgEntry2."Transaction No.", DtldCustLedgEntry2."VAT Bus. Posting Group",
                  DtldCustLedgEntry2."VAT Prod. Posting Group", DtldCustLedgEntry2."Gen. Prod. Posting Group");
                DtldCVLedgEntryBuf."VAT Amount (LCY)" :=
                  CalcVATAmountFromVATEntry(DtldCVLedgEntryBuf."Amount (LCY)", TempVATEntry2, CurrencyLCY);
            END;
            UpdateTotalAmounts(
              TempInvPostBuf, GenJnlLine."Dimension Set ID", DtldCVLedgEntryBuf."Amount (LCY)",
              DtldCVLedgEntryBuf."Additional-Currency Amount");

            IF NOT (DtldCVLedgEntryBuf."Entry Type" IN [
                                                        DtldCVLedgEntryBuf."Entry Type"::"Initial Entry",
                                                        DtldCVLedgEntryBuf."Entry Type"::Application])
            THEN
                CollectAdjustment(AdjAmount,
                  -DtldCVLedgEntryBuf."Amount (LCY)", -DtldCVLedgEntryBuf."Additional-Currency Amount");

            PostDtldCustLedgEntryUnapply(
              GenJnlLine, DtldCVLedgEntryBuf, CustPostingGr, DtldCustLedgEntry2."Transaction No.");

            DtldCustLedgEntry2.Unapplied := TRUE;
            DtldCustLedgEntry2."Unapplied by Entry No." := NewDtldCustLedgEntry."Entry No.";
            DtldCustLedgEntry2.MODIFY;

            UpdateCustLedgEntry(DtldCustLedgEntry2);
        UNTIL DtldCustLedgEntry2.NEXT = 0;

        CreateGLEntriesForTotalAmountsUnapply(GenJnlLine, TempInvPostBuf, CustPostingGr.GetReceivablesAccount);

        IF IsTempGLEntryBufEmpty THEN
            DtldCustLedgEntry.SetZeroTransNo(NextTransactionNo);
        CheckPostUnrealizedVAT(GenJnlLine, TRUE);
        FinishPosting;
    end;

    procedure UnapplyVendLedgEntry(GenJnlLine2: Record "81"; DtldVendLedgEntry: Record "380")
    var
        Vend: Record "23";
        VendPostingGr: Record "93";
        GenJnlLine: Record "81";
        DtldVendLedgEntry2: Record "380";
        NewDtldVendLedgEntry: Record "380";
        VendLedgEntry: Record "25";
        DtldCVLedgEntryBuf: Record "383";
        VATEntry: Record "254";
        TempVATEntry2: Record "254" temporary;
        CurrencyLCY: Record "4";
        TempInvPostBuf: Record "49" temporary;
        AdjAmount: array[4] of Decimal;
        NextDtldLedgEntryNo: Integer;
        UnapplyVATEntries: Boolean;
    begin
        GenJnlLine.TRANSFERFIELDS(GenJnlLine2);
        IF GenJnlLine."Document Date" = 0D THEN
            GenJnlLine."Document Date" := GenJnlLine."Posting Date";

        IF NextEntryNo = 0 THEN
            StartPosting(GenJnlLine)
        ELSE
            ContinuePosting(GenJnlLine);

        ReadGLSetup(GLSetup);

        Vend.GET(DtldVendLedgEntry."Vendor No.");
        Vend.CheckBlockedVendOnJnls(Vend, GenJnlLine2."Document Type"::Payment, TRUE);
        VendPostingGr.GET(GenJnlLine."Posting Group");
        VendPostingGr.GetPayablesAccount;

        VATEntry.LOCKTABLE;
        DtldVendLedgEntry.LOCKTABLE;
        VendLedgEntry.LOCKTABLE;

        DtldVendLedgEntry.TESTFIELD("Entry Type", DtldVendLedgEntry."Entry Type"::Application);

        DtldVendLedgEntry2.RESET;
        DtldVendLedgEntry2.FINDLAST;
        NextDtldLedgEntryNo := DtldVendLedgEntry2."Entry No." + 1;
        IF DtldVendLedgEntry."Transaction No." = 0 THEN BEGIN
            DtldVendLedgEntry2.SETCURRENTKEY("Application No.", "Vendor No.", "Entry Type");
            DtldVendLedgEntry2.SETRANGE("Application No.", DtldVendLedgEntry."Application No.");
        END ELSE BEGIN
            DtldVendLedgEntry2.SETCURRENTKEY("Transaction No.", "Vendor No.", "Entry Type");
            DtldVendLedgEntry2.SETRANGE("Transaction No.", DtldVendLedgEntry."Transaction No.");
        END;
        DtldVendLedgEntry2.SETRANGE("Vendor No.", DtldVendLedgEntry."Vendor No.");
        DtldVendLedgEntry2.SETFILTER("Entry Type", '>%1', DtldVendLedgEntry."Entry Type"::"Initial Entry");
        IF DtldVendLedgEntry."Transaction No." <> 0 THEN BEGIN
            UnapplyVATEntries := FALSE;
            DtldVendLedgEntry2.FINDSET;
            REPEAT
                DtldVendLedgEntry2.TESTFIELD(Unapplied, FALSE);
                IF IsVATAdjustment(DtldVendLedgEntry2."Entry Type") THEN
                    UnapplyVATEntries := TRUE
            UNTIL DtldVendLedgEntry2.NEXT = 0;

            PostUnapply(
              GenJnlLine, VATEntry, VATEntry.Type::Purchase,
              DtldVendLedgEntry."Vendor No.", DtldVendLedgEntry."Transaction No.", UnapplyVATEntries, TempVATEntry);

            DtldVendLedgEntry2.FINDSET;
            REPEAT
                DtldCVLedgEntryBuf.INIT;
                DtldCVLedgEntryBuf.TRANSFERFIELDS(DtldVendLedgEntry2);
                ProcessTempVATEntry(DtldCVLedgEntryBuf, TempVATEntry);
            UNTIL DtldVendLedgEntry2.NEXT = 0;
        END;

        // Look one more time
        DtldVendLedgEntry2.FINDSET;
        TempInvPostBuf.DELETEALL;
        REPEAT
            DtldVendLedgEntry2.TESTFIELD(Unapplied, FALSE);
            InsertDtldVendLedgEntryUnapply(GenJnlLine, NewDtldVendLedgEntry, DtldVendLedgEntry2, NextDtldLedgEntryNo);

            DtldCVLedgEntryBuf.INIT;
            DtldCVLedgEntryBuf.TRANSFERFIELDS(NewDtldVendLedgEntry);
            SetAddCurrForUnapplication(DtldCVLedgEntryBuf);
            CurrencyLCY.InitRoundingPrecision;

            IF (DtldVendLedgEntry2."Transaction No." <> 0) AND IsVATExcluded(DtldVendLedgEntry2."Entry Type") THEN BEGIN
                UnapplyExcludedVAT(
                  TempVATEntry2, DtldVendLedgEntry2."Transaction No.", DtldVendLedgEntry2."VAT Bus. Posting Group",
                  DtldVendLedgEntry2."VAT Prod. Posting Group", DtldVendLedgEntry2."Gen. Prod. Posting Group");
                DtldCVLedgEntryBuf."VAT Amount (LCY)" :=
                  CalcVATAmountFromVATEntry(DtldCVLedgEntryBuf."Amount (LCY)", TempVATEntry2, CurrencyLCY);
            END;
            UpdateTotalAmounts(
              TempInvPostBuf, GenJnlLine."Dimension Set ID", DtldCVLedgEntryBuf."Amount (LCY)",
              DtldCVLedgEntryBuf."Additional-Currency Amount");

            IF NOT (DtldCVLedgEntryBuf."Entry Type" IN [
                                                        DtldCVLedgEntryBuf."Entry Type"::"Initial Entry",
                                                        DtldCVLedgEntryBuf."Entry Type"::Application])
            THEN
                CollectAdjustment(AdjAmount,
                  -DtldCVLedgEntryBuf."Amount (LCY)", -DtldCVLedgEntryBuf."Additional-Currency Amount");

            PostDtldVendLedgEntryUnapply(
              GenJnlLine, DtldCVLedgEntryBuf, VendPostingGr, DtldVendLedgEntry2."Transaction No.");

            DtldVendLedgEntry2.Unapplied := TRUE;
            DtldVendLedgEntry2."Unapplied by Entry No." := NewDtldVendLedgEntry."Entry No.";
            DtldVendLedgEntry2.MODIFY;

            UpdateVendLedgEntry(DtldVendLedgEntry2);
        UNTIL DtldVendLedgEntry2.NEXT = 0;

        CreateGLEntriesForTotalAmountsUnapply(GenJnlLine, TempInvPostBuf, VendPostingGr.GetPayablesAccount);

        IF IsTempGLEntryBufEmpty THEN
            DtldVendLedgEntry.SetZeroTransNo(NextTransactionNo);
        CheckPostUnrealizedVAT(GenJnlLine, TRUE);
        FinishPosting;
    end;

    [Scope('Internal')]
    procedure UnapplyEmplLedgEntry(GenJnlLine2: Record "81"; DtldEmplLedgEntry: Record "5223")
    var
        Employee: Record "5200";
        EmployeePostingGroup: Record "5221";
        GenJnlLine: Record "81";
        DtldEmplLedgEntry2: Record "5223";
        NewDtldEmplLedgEntry: Record "5223";
        EmplLedgEntry: Record "5222";
        DtldCVLedgEntryBuf: Record "383";
        CurrencyLCY: Record "4";
        TempInvPostBuf: Record "49" temporary;
        NextDtldLedgEntryNo: Integer;
    begin
        GenJnlLine.TRANSFERFIELDS(GenJnlLine2);
        IF GenJnlLine."Document Date" = 0D THEN
            GenJnlLine."Document Date" := GenJnlLine."Posting Date";

        IF NextEntryNo = 0 THEN
            StartPosting(GenJnlLine)
        ELSE
            ContinuePosting(GenJnlLine);

        ReadGLSetup(GLSetup);

        Employee.GET(DtldEmplLedgEntry."Employee No.");
        EmployeePostingGroup.GET(GenJnlLine."Posting Group");
        EmployeePostingGroup.GetPayablesAccount;

        DtldEmplLedgEntry.LOCKTABLE;
        EmplLedgEntry.LOCKTABLE;

        DtldEmplLedgEntry.TESTFIELD("Entry Type", DtldEmplLedgEntry."Entry Type"::Application);

        DtldEmplLedgEntry2.RESET;
        DtldEmplLedgEntry2.FINDLAST;
        NextDtldLedgEntryNo := DtldEmplLedgEntry2."Entry No." + 1;
        IF DtldEmplLedgEntry."Transaction No." = 0 THEN BEGIN
            DtldEmplLedgEntry2.SETCURRENTKEY("Application No.", "Employee No.", "Entry Type");
            DtldEmplLedgEntry2.SETRANGE("Application No.", DtldEmplLedgEntry."Application No.");
        END ELSE BEGIN
            DtldEmplLedgEntry2.SETCURRENTKEY("Transaction No.", "Employee No.", "Entry Type");
            DtldEmplLedgEntry2.SETRANGE("Transaction No.", DtldEmplLedgEntry."Transaction No.");
        END;
        DtldEmplLedgEntry2.SETRANGE("Employee No.", DtldEmplLedgEntry."Employee No.");
        DtldEmplLedgEntry2.SETFILTER("Entry Type", '>%1', DtldEmplLedgEntry."Entry Type"::"Initial Entry");

        // Look one more time
        DtldEmplLedgEntry2.FINDSET;
        TempInvPostBuf.DELETEALL;
        REPEAT
            DtldEmplLedgEntry2.TESTFIELD(Unapplied, FALSE);
            InsertDtldEmplLedgEntryUnapply(GenJnlLine, NewDtldEmplLedgEntry, DtldEmplLedgEntry2, NextDtldLedgEntryNo);

            DtldCVLedgEntryBuf.INIT;
            DtldCVLedgEntryBuf.TRANSFERFIELDS(NewDtldEmplLedgEntry);
            SetAddCurrForUnapplication(DtldCVLedgEntryBuf);
            CurrencyLCY.InitRoundingPrecision;

            UpdateTotalAmounts(
              TempInvPostBuf, GenJnlLine."Dimension Set ID", DtldCVLedgEntryBuf."Amount (LCY)",
              DtldCVLedgEntryBuf."Additional-Currency Amount");

            DtldEmplLedgEntry2.Unapplied := TRUE;
            DtldEmplLedgEntry2."Unapplied by Entry No." := NewDtldEmplLedgEntry."Entry No.";
            DtldEmplLedgEntry2.MODIFY;

            UpdateEmplLedgEntry(DtldEmplLedgEntry2);
        UNTIL DtldEmplLedgEntry2.NEXT = 0;

        CreateGLEntriesForTotalAmountsUnapply(GenJnlLine, TempInvPostBuf, EmployeePostingGroup.GetPayablesAccount);

        IF IsTempGLEntryBufEmpty THEN
            DtldEmplLedgEntry.SetZeroTransNo(NextTransactionNo);
        FinishPosting;
    end;

    local procedure UnapplyExcludedVAT(var TempVATEntry: Record "254" temporary; TransactionNo: Integer; VATBusPostingGroup: Code[20]; VATProdPostingGroup: Code[20]; GenProdPostingGroup: Code[20])
    begin
        TempVATEntry.SETRANGE("VAT Bus. Posting Group", VATBusPostingGroup);
        TempVATEntry.SETRANGE("VAT Prod. Posting Group", VATProdPostingGroup);
        TempVATEntry.SETRANGE("Gen. Prod. Posting Group", GenProdPostingGroup);
        IF NOT TempVATEntry.FINDFIRST THEN BEGIN
            TempVATEntry.RESET;
            IF TempVATEntry.FINDLAST THEN
                TempVATEntry."Entry No." := TempVATEntry."Entry No." + 1
            ELSE
                TempVATEntry."Entry No." := 1;
            TempVATEntry.INIT;
            TempVATEntry."VAT Bus. Posting Group" := VATBusPostingGroup;
            TempVATEntry."VAT Prod. Posting Group" := VATProdPostingGroup;
            TempVATEntry."Gen. Prod. Posting Group" := GenProdPostingGroup;
            VATEntry.SETCURRENTKEY("Transaction No.");
            VATEntry.SETRANGE("Transaction No.", TransactionNo);
            VATEntry.SETRANGE("VAT Bus. Posting Group", VATBusPostingGroup);
            VATEntry.SETRANGE("VAT Prod. Posting Group", VATProdPostingGroup);
            VATEntry.SETRANGE("Gen. Prod. Posting Group", GenProdPostingGroup);
            IF VATEntry.FINDSET THEN
                REPEAT
                    IF VATEntry."Unrealized VAT Entry No." = 0 THEN BEGIN
                        TempVATEntry.Base := TempVATEntry.Base + VATEntry.Base;
                        TempVATEntry.Amount := TempVATEntry.Amount + VATEntry.Amount;
                    END;
                UNTIL VATEntry.NEXT = 0;
            CLEAR(VATEntry);
            TempVATEntry.INSERT;
        END;
    end;

    local procedure PostUnrealVATByUnapply(GenJnlLine: Record "81"; VATPostingSetup: Record "325"; VATEntry: Record "254"; NewVATEntry: Record "254")
    var
        VATEntry2: Record "254";
        AmountAddCurr: Decimal;
    begin
        AmountAddCurr := CalcAddCurrForUnapplication(VATEntry."Posting Date", VATEntry.Amount);
        CreateGLEntry(
          GenJnlLine, GetPostingAccountNo(VATPostingSetup, VATEntry, TRUE), VATEntry.Amount, AmountAddCurr, FALSE);
        CreateGLEntryFromVATEntry(
          GenJnlLine, GetPostingAccountNo(VATPostingSetup, VATEntry, FALSE), -VATEntry.Amount, -AmountAddCurr, VATEntry);

        WITH VATEntry2 DO BEGIN
            GET(VATEntry."Unrealized VAT Entry No.");
            "Remaining Unrealized Amount" := "Remaining Unrealized Amount" - NewVATEntry.Amount;
            "Remaining Unrealized Base" := "Remaining Unrealized Base" - NewVATEntry.Base;
            "Add.-Curr. Rem. Unreal. Amount" :=
              "Add.-Curr. Rem. Unreal. Amount" - NewVATEntry."Additional-Currency Amount";
            "Add.-Curr. Rem. Unreal. Base" :=
              "Add.-Curr. Rem. Unreal. Base" - NewVATEntry."Additional-Currency Base";
            MODIFY;
        END;
    end;

    local procedure PostPmtDiscountVATByUnapply(GenJnlLine: Record "81"; ReverseChargeVATAccNo: Code[20]; VATAccNo: Code[20]; VATEntry: Record "254")
    var
        AmountAddCurr: Decimal;
    begin
        AmountAddCurr := CalcAddCurrForUnapplication(VATEntry."Posting Date", VATEntry.Amount);
        CreateGLEntry(GenJnlLine, ReverseChargeVATAccNo, VATEntry.Amount, AmountAddCurr, FALSE);
        CreateGLEntry(GenJnlLine, VATAccNo, -VATEntry.Amount, -AmountAddCurr, FALSE);
    end;

    local procedure PostUnapply(GenJnlLine: Record "81"; var VATEntry: Record "254"; VATEntryType: Option; BilltoPaytoNo: Code[20]; TransactionNo: Integer; UnapplyVATEntries: Boolean; var TempVATEntry: Record "254" temporary)
    var
        VATPostingSetup: Record "325";
        VATEntry2: Record "254";
        GLEntryVATEntryLink: Record "253";
        AccNo: Code[20];
        TempVATEntryNo: Integer;
    begin
        TempVATEntryNo := 1;
        VATEntry.SETCURRENTKEY(Type, "Bill-to/Pay-to No.", "Transaction No.");
        VATEntry.SETRANGE(Type, VATEntryType);
        VATEntry.SETRANGE("Bill-to/Pay-to No.", BilltoPaytoNo);
        VATEntry.SETRANGE("Transaction No.", TransactionNo);
        IF VATEntry.FINDSET THEN
            REPEAT
                VATPostingSetup.GET(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group");
                IF UnapplyVATEntries OR (VATEntry."Unrealized VAT Entry No." <> 0) THEN BEGIN
                    InsertTempVATEntry(GenJnlLine, VATEntry, TempVATEntryNo, TempVATEntry);
                    IF VATEntry."Unrealized VAT Entry No." <> 0 THEN BEGIN
                        VATPostingSetup.GET(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group");
                        IF VATPostingSetup."VAT Calculation Type" IN
                           [VATPostingSetup."VAT Calculation Type"::"Normal VAT",
                            VATPostingSetup."VAT Calculation Type"::"Full VAT"]
                        THEN
                            PostUnrealVATByUnapply(GenJnlLine, VATPostingSetup, VATEntry, TempVATEntry)
                        ELSE
                            IF VATPostingSetup."VAT Calculation Type" = VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT" THEN BEGIN
                                PostUnrealVATByUnapply(GenJnlLine, VATPostingSetup, VATEntry, TempVATEntry);
                                CreateGLEntry(
                                  GenJnlLine, VATPostingSetup.GetRevChargeAccount(TRUE),
                                  -VATEntry.Amount, CalcAddCurrForUnapplication(VATEntry."Posting Date", -VATEntry.Amount), FALSE);
                                CreateGLEntry(
                                  GenJnlLine, VATPostingSetup.GetRevChargeAccount(FALSE),
                                  VATEntry.Amount, CalcAddCurrForUnapplication(VATEntry."Posting Date", VATEntry.Amount), FALSE);
                            END ELSE
                                PostUnrealVATByUnapply(GenJnlLine, VATPostingSetup, VATEntry, TempVATEntry);
                        VATEntry2 := TempVATEntry;
                        VATEntry2."Entry No." := NextVATEntryNo;
                        VATEntry2.INSERT;
                        IF VATEntry2."Unrealized VAT Entry No." = 0 THEN
                            GLEntryVATEntryLink.InsertLink(NextEntryNo, VATEntry2."Entry No.");
                        TempVATEntry.DELETE;
                        IncrNextVATEntryNo;
                    END;

                    IF VATPostingSetup."Adjust for Payment Discount" AND NOT IsNotPayment(VATEntry."Document Type") AND
                       (VATPostingSetup."VAT Calculation Type" =
                        VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT") AND
                       (VATEntry."Unrealized VAT Entry No." = 0) AND UnapplyVATEntries
                    THEN BEGIN
                        CASE VATEntryType OF
                            VATEntry.Type::Sale:
                                AccNo := VATPostingSetup.GetSalesAccount(FALSE);
                            VATEntry.Type::Purchase:
                                AccNo := VATPostingSetup.GetPurchAccount(FALSE);
                        END;
                        PostPmtDiscountVATByUnapply(GenJnlLine, VATPostingSetup.GetRevChargeAccount(FALSE), AccNo, VATEntry);
                    END;
                END;
            UNTIL VATEntry.NEXT = 0;
    end;

    local procedure CalcAddCurrForUnapplication(Date: Date; Amt: Decimal): Decimal
    var
        AddCurrency: Record "4";
        CurrExchRate: Record "330";
    begin
        IF AddCurrencyCode = '' THEN
            EXIT;

        AddCurrency.GET(AddCurrencyCode);
        AddCurrency.TESTFIELD("Amount Rounding Precision");

        EXIT(
          ROUND(
            CurrExchRate.ExchangeAmtLCYToFCY(
              Date, AddCurrencyCode, Amt, CurrExchRate.ExchangeRate(Date, AddCurrencyCode)),
            AddCurrency."Amount Rounding Precision"));
    end;

    local procedure CalcVATAmountFromVATEntry(AmountLCY: Decimal; var VATEntry: Record "254"; CurrencyLCY: Record "4") VATAmountLCY: Decimal
    begin
        WITH VATEntry DO
            IF (AmountLCY = Base) OR (Base = 0) THEN BEGIN
                VATAmountLCY := Amount;
                DELETE;
            END ELSE BEGIN
                VATAmountLCY :=
                  ROUND(
                    Amount * AmountLCY / Base,
                    CurrencyLCY."Amount Rounding Precision",
                    CurrencyLCY.VATRoundingDirection);
                Base := Base - AmountLCY;
                Amount := Amount - VATAmountLCY;
                MODIFY;
            END;
    end;

    local procedure InsertDtldCustLedgEntryUnapply(GenJnlLine: Record "81"; var NewDtldCustLedgEntry: Record "379"; OldDtldCustLedgEntry: Record "379"; var NextDtldLedgEntryNo: Integer)
    begin
        NewDtldCustLedgEntry := OldDtldCustLedgEntry;
        WITH NewDtldCustLedgEntry DO BEGIN
            "Entry No." := NextDtldLedgEntryNo;
            "Posting Date" := GenJnlLine."Posting Date";
            "Transaction No." := NextTransactionNo;
            "Application No." := 0;
            Amount := -OldDtldCustLedgEntry.Amount;
            "Amount (LCY)" := -OldDtldCustLedgEntry."Amount (LCY)";
            "Debit Amount" := -OldDtldCustLedgEntry."Debit Amount";
            "Credit Amount" := -OldDtldCustLedgEntry."Credit Amount";
            "Debit Amount (LCY)" := -OldDtldCustLedgEntry."Debit Amount (LCY)";
            "Credit Amount (LCY)" := -OldDtldCustLedgEntry."Credit Amount (LCY)";
            Unapplied := TRUE;
            "Unapplied by Entry No." := OldDtldCustLedgEntry."Entry No.";
            "Document No." := GenJnlLine."Document No.";
            "Source Code" := GenJnlLine."Source Code";
            "User ID" := USERID;
            INSERT(TRUE);
        END;
        NextDtldLedgEntryNo := NextDtldLedgEntryNo + 1;
    end;

    local procedure InsertDtldVendLedgEntryUnapply(GenJnlLine: Record "81"; var NewDtldVendLedgEntry: Record "380"; OldDtldVendLedgEntry: Record "380"; var NextDtldLedgEntryNo: Integer)
    begin
        NewDtldVendLedgEntry := OldDtldVendLedgEntry;
        WITH NewDtldVendLedgEntry DO BEGIN
            "Entry No." := NextDtldLedgEntryNo;
            "Posting Date" := GenJnlLine."Posting Date";
            "Transaction No." := NextTransactionNo;
            "Application No." := 0;
            Amount := -OldDtldVendLedgEntry.Amount;
            "Amount (LCY)" := -OldDtldVendLedgEntry."Amount (LCY)";
            "Debit Amount" := -OldDtldVendLedgEntry."Debit Amount";
            "Credit Amount" := -OldDtldVendLedgEntry."Credit Amount";
            "Debit Amount (LCY)" := -OldDtldVendLedgEntry."Debit Amount (LCY)";
            "Credit Amount (LCY)" := -OldDtldVendLedgEntry."Credit Amount (LCY)";
            Unapplied := TRUE;
            "Unapplied by Entry No." := OldDtldVendLedgEntry."Entry No.";
            "Document No." := GenJnlLine."Document No.";
            "Source Code" := GenJnlLine."Source Code";
            "User ID" := USERID;
            INSERT(TRUE);
        END;
        NextDtldLedgEntryNo := NextDtldLedgEntryNo + 1;
    end;

    local procedure InsertDtldEmplLedgEntryUnapply(GenJnlLine: Record "81"; var NewDtldEmplLedgEntry: Record "5223"; OldDtldEmplLedgEntry: Record "5223"; var NextDtldLedgEntryNo: Integer)
    begin
        NewDtldEmplLedgEntry := OldDtldEmplLedgEntry;
        WITH NewDtldEmplLedgEntry DO BEGIN
            "Entry No." := NextDtldLedgEntryNo;
            "Posting Date" := GenJnlLine."Posting Date";
            "Transaction No." := NextTransactionNo;
            "Application No." := 0;
            Amount := -OldDtldEmplLedgEntry.Amount;
            "Amount (LCY)" := -OldDtldEmplLedgEntry."Amount (LCY)";
            "Debit Amount" := -OldDtldEmplLedgEntry."Debit Amount";
            "Credit Amount" := -OldDtldEmplLedgEntry."Credit Amount";
            "Debit Amount (LCY)" := -OldDtldEmplLedgEntry."Debit Amount (LCY)";
            "Credit Amount (LCY)" := -OldDtldEmplLedgEntry."Credit Amount (LCY)";
            Unapplied := TRUE;
            "Unapplied by Entry No." := OldDtldEmplLedgEntry."Entry No.";
            "Document No." := GenJnlLine."Document No.";
            "Source Code" := GenJnlLine."Source Code";
            "User ID" := USERID;
            INSERT(TRUE);
        END;
        NextDtldLedgEntryNo := NextDtldLedgEntryNo + 1;
    end;

    local procedure InsertTempVATEntry(GenJnlLine: Record "81"; VATEntry: Record "254"; var TempVATEntryNo: Integer; var TempVATEntry: Record "254" temporary)
    begin
        TempVATEntry := VATEntry;
        WITH TempVATEntry DO BEGIN
            "Entry No." := TempVATEntryNo;
            TempVATEntryNo := TempVATEntryNo + 1;
            "Closed by Entry No." := 0;
            Closed := FALSE;
            CopyAmountsFromVATEntry(VATEntry, TRUE);
            "Posting Date" := GenJnlLine."Posting Date";
            "Document No." := GenJnlLine."Document No.";
            "User ID" := USERID;
            "Transaction No." := NextTransactionNo;
            INSERT;
        END;
    end;

    local procedure ProcessTempVATEntry(DtldCVLedgEntryBuf: Record "383"; var TempVATEntry: Record "254" temporary)
    var
        VATEntrySaved: Record "254";
        VATBaseSum: array[3] of Decimal;
        DeductedVATBase: Decimal;
        EntryNoBegin: array[3] of Integer;
        i: Integer;
    begin
        IF NOT (DtldCVLedgEntryBuf."Entry Type" IN
                [DtldCVLedgEntryBuf."Entry Type"::"Payment Discount (VAT Excl.)",
                 DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance (VAT Excl.)",
                 DtldCVLedgEntryBuf."Entry Type"::"Payment Discount Tolerance (VAT Excl.)"])
        THEN
            EXIT;

        DeductedVATBase := 0;
        TempVATEntry.RESET;
        TempVATEntry.SETRANGE("Entry No.", 0, 999999);
        TempVATEntry.SETRANGE("Gen. Bus. Posting Group", DtldCVLedgEntryBuf."Gen. Bus. Posting Group");
        TempVATEntry.SETRANGE("Gen. Prod. Posting Group", DtldCVLedgEntryBuf."Gen. Prod. Posting Group");
        TempVATEntry.SETRANGE("VAT Bus. Posting Group", DtldCVLedgEntryBuf."VAT Bus. Posting Group");
        TempVATEntry.SETRANGE("VAT Prod. Posting Group", DtldCVLedgEntryBuf."VAT Prod. Posting Group");
        IF TempVATEntry.FINDSET THEN
            REPEAT
                CASE TRUE OF
                    VATBaseSum[3] + TempVATEntry.Base = DtldCVLedgEntryBuf."Amount (LCY)" - DeductedVATBase:
                        i := 4;
                    VATBaseSum[2] + TempVATEntry.Base = DtldCVLedgEntryBuf."Amount (LCY)" - DeductedVATBase:
                        i := 3;
                    VATBaseSum[1] + TempVATEntry.Base = DtldCVLedgEntryBuf."Amount (LCY)" - DeductedVATBase:
                        i := 2;
                    TempVATEntry.Base = DtldCVLedgEntryBuf."Amount (LCY)" - DeductedVATBase:
                        i := 1;
                    ELSE
                        i := 0;
                END;
                IF i > 0 THEN BEGIN
                    TempVATEntry.RESET;
                    IF i > 1 THEN BEGIN
                        IF EntryNoBegin[i - 1] < TempVATEntry."Entry No." THEN
                            TempVATEntry.SETRANGE("Entry No.", EntryNoBegin[i - 1], TempVATEntry."Entry No.")
                        ELSE
                            TempVATEntry.SETRANGE("Entry No.", TempVATEntry."Entry No.", EntryNoBegin[i - 1]);
                    END ELSE
                        TempVATEntry.SETRANGE("Entry No.", TempVATEntry."Entry No.");
                    TempVATEntry.FINDSET;
                    REPEAT
                        VATEntrySaved := TempVATEntry;
                        CASE DtldCVLedgEntryBuf."Entry Type" OF
                            DtldCVLedgEntryBuf."Entry Type"::"Payment Discount (VAT Excl.)":
                                TempVATEntry.RENAME(TempVATEntry."Entry No." + 3000000);
                            DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance (VAT Excl.)":
                                TempVATEntry.RENAME(TempVATEntry."Entry No." + 2000000);
                            DtldCVLedgEntryBuf."Entry Type"::"Payment Discount Tolerance (VAT Excl.)":
                                TempVATEntry.RENAME(TempVATEntry."Entry No." + 1000000);
                        END;
                        TempVATEntry := VATEntrySaved;
                        DeductedVATBase += TempVATEntry.Base;
                    UNTIL TempVATEntry.NEXT = 0;
                    FOR i := 1 TO 3 DO BEGIN
                        VATBaseSum[i] := 0;
                        EntryNoBegin[i] := 0;
                    END;
                    TempVATEntry.SETRANGE("Entry No.", 0, 999999);
                END ELSE BEGIN
                    VATBaseSum[3] += TempVATEntry.Base;
                    VATBaseSum[2] := VATBaseSum[1] + TempVATEntry.Base;
                    VATBaseSum[1] := TempVATEntry.Base;
                    IF EntryNoBegin[3] > 0 THEN
                        EntryNoBegin[3] := TempVATEntry."Entry No.";
                    EntryNoBegin[2] := EntryNoBegin[1];
                    EntryNoBegin[1] := TempVATEntry."Entry No.";
                END;
            UNTIL TempVATEntry.NEXT = 0;
    end;

    local procedure UpdateCustLedgEntry(DtldCustLedgEntry: Record "379")
    var
        CustLedgEntry: Record "21";
    begin
        IF DtldCustLedgEntry."Entry Type" <> DtldCustLedgEntry."Entry Type"::Application THEN
            EXIT;

        CustLedgEntry.GET(DtldCustLedgEntry."Cust. Ledger Entry No.");
        CustLedgEntry."Remaining Pmt. Disc. Possible" := DtldCustLedgEntry."Remaining Pmt. Disc. Possible";
        CustLedgEntry."Max. Payment Tolerance" := DtldCustLedgEntry."Max. Payment Tolerance";
        CustLedgEntry."Accepted Payment Tolerance" := 0;
        IF NOT CustLedgEntry.Open THEN BEGIN
            CustLedgEntry.Open := TRUE;
            CustLedgEntry."Closed by Entry No." := 0;
            CustLedgEntry."Closed at Date" := 0D;
            CustLedgEntry."Closed by Amount" := 0;
            CustLedgEntry."Closed by Amount (LCY)" := 0;
            CustLedgEntry."Closed by Currency Code" := '';
            CustLedgEntry."Closed by Currency Amount" := 0;
            CustLedgEntry."Pmt. Disc. Given (LCY)" := 0;
            CustLedgEntry."Pmt. Tolerance (LCY)" := 0;
            CustLedgEntry."Calculate Interest" := FALSE;
        END;
        CustLedgEntry.MODIFY;
    end;

    local procedure UpdateVendLedgEntry(DtldVendLedgEntry: Record "380")
    var
        VendLedgEntry: Record "25";
    begin
        IF DtldVendLedgEntry."Entry Type" <> DtldVendLedgEntry."Entry Type"::Application THEN
            EXIT;

        VendLedgEntry.GET(DtldVendLedgEntry."Vendor Ledger Entry No.");
        VendLedgEntry."Remaining Pmt. Disc. Possible" := DtldVendLedgEntry."Remaining Pmt. Disc. Possible";
        VendLedgEntry."Max. Payment Tolerance" := DtldVendLedgEntry."Max. Payment Tolerance";
        VendLedgEntry."Accepted Payment Tolerance" := 0;
        IF NOT VendLedgEntry.Open THEN BEGIN
            VendLedgEntry.Open := TRUE;
            VendLedgEntry."Closed by Entry No." := 0;
            VendLedgEntry."Closed at Date" := 0D;
            VendLedgEntry."Closed by Amount" := 0;
            VendLedgEntry."Closed by Amount (LCY)" := 0;
            VendLedgEntry."Closed by Currency Code" := '';
            VendLedgEntry."Closed by Currency Amount" := 0;
            VendLedgEntry."Pmt. Disc. Rcd.(LCY)" := 0;
            VendLedgEntry."Pmt. Tolerance (LCY)" := 0;
        END;
        VendLedgEntry.MODIFY;
    end;

    local procedure UpdateEmplLedgEntry(DtldEmplLedgEntry: Record "5223")
    var
        EmplLedgEntry: Record "5222";
    begin
        IF DtldEmplLedgEntry."Entry Type" <> DtldEmplLedgEntry."Entry Type"::Application THEN
            EXIT;

        EmplLedgEntry.GET(DtldEmplLedgEntry."Employee Ledger Entry No.");
        IF NOT EmplLedgEntry.Open THEN BEGIN
            EmplLedgEntry.Open := TRUE;
            EmplLedgEntry."Closed by Entry No." := 0;
            EmplLedgEntry."Closed at Date" := 0D;
            EmplLedgEntry."Closed by Amount" := 0;
            EmplLedgEntry."Closed by Amount (LCY)" := 0;
        END;
        EmplLedgEntry.MODIFY;
    end;

    local procedure UpdateCalcInterest(var CVLedgEntryBuf: Record "382")
    var
        CustLedgEntry: Record "21";
        CVLedgEntryBuf2: Record "382";
    begin
        WITH CVLedgEntryBuf DO BEGIN
            IF CustLedgEntry.GET("Closed by Entry No.") THEN BEGIN
                CVLedgEntryBuf2.TRANSFERFIELDS(CustLedgEntry);
                UpdateCalcInterest2(CVLedgEntryBuf, CVLedgEntryBuf2);
            END;
            CustLedgEntry.SETCURRENTKEY("Closed by Entry No.");
            CustLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
            IF CustLedgEntry.FINDSET THEN
                REPEAT
                    CVLedgEntryBuf2.TRANSFERFIELDS(CustLedgEntry);
                    UpdateCalcInterest2(CVLedgEntryBuf, CVLedgEntryBuf2);
                UNTIL CustLedgEntry.NEXT = 0;
        END;
    end;

    local procedure UpdateCalcInterest2(var CVLedgEntryBuf: Record "382"; var CVLedgEntryBuf2: Record "382")
    begin
        WITH CVLedgEntryBuf DO
            IF "Due Date" < CVLedgEntryBuf2."Document Date" THEN
                "Calculate Interest" := TRUE;
    end;

    local procedure GLCalcAddCurrency(Amount: Decimal; AddCurrAmount: Decimal; OldAddCurrAmount: Decimal; UseAddCurrAmount: Boolean; GenJnlLine: Record "81"): Decimal
    begin
        IF (AddCurrencyCode <> '') AND
           (GenJnlLine."Additional-Currency Posting" = GenJnlLine."Additional-Currency Posting"::None)
        THEN BEGIN
            IF (GenJnlLine."Source Currency Code" = AddCurrencyCode) AND UseAddCurrAmount THEN
                EXIT(AddCurrAmount);

            EXIT(ExchangeAmtLCYToFCY2(Amount));
        END;
        EXIT(OldAddCurrAmount);
    end;

    local procedure HandleAddCurrResidualGLEntry(GenJnlLine: Record "81"; Amount: Decimal; AmountAddCurr: Decimal)
    var
        GLAcc: Record "15";
        GLEntry: Record "17";
    begin
        IF AddCurrencyCode = '' THEN
            EXIT;

        TotalAddCurrAmount := TotalAddCurrAmount + AmountAddCurr;
        TotalAmount := TotalAmount + Amount;

        IF (GenJnlLine."Additional-Currency Posting" = GenJnlLine."Additional-Currency Posting"::None) AND
           (TotalAmount = 0) AND (TotalAddCurrAmount <> 0) AND
           CheckNonAddCurrCodeOccurred(GenJnlLine."Source Currency Code")
        THEN BEGIN
            GLEntry.INIT;
            GLEntry.CopyFromGenJnlLine(GenJnlLine);
            GLEntry."External Document No." := '';
            GLEntry.Description :=
              COPYSTR(
                STRSUBSTNO(
                  ResidualRoundingErr,
                  GLEntry.FIELDCAPTION("Additional-Currency Amount")),
                1, MAXSTRLEN(GLEntry.Description));
            GLEntry."Source Type" := 0;
            GLEntry."Source No." := '';
            GLEntry."Job No." := '';
            GLEntry.Quantity := 0;
            GLEntry."Entry No." := NextEntryNo;
            GLEntry."Transaction No." := NextTransactionNo;
            IF TotalAddCurrAmount < 0 THEN
                GLEntry."G/L Account No." := AddCurrency."Residual Losses Account"
            ELSE
                GLEntry."G/L Account No." := AddCurrency."Residual Gains Account";
            GLEntry.Amount := 0;
            GLEntry."System-Created Entry" := TRUE;
            GLEntry."Additional-Currency Amount" := -TotalAddCurrAmount;
            GLAcc.GET(GLEntry."G/L Account No.");
            GLAcc.TESTFIELD(Blocked, FALSE);
            GLAcc.TESTFIELD("Account Type", GLAcc."Account Type"::Posting);
            InsertGLEntry(GenJnlLine, GLEntry, FALSE);

            CheckGLAccDimError(GenJnlLine, GLEntry."G/L Account No.");

            TotalAddCurrAmount := 0;
        END;
    end;

    local procedure CalcLCYToAddCurr(AmountLCY: Decimal): Decimal
    begin
        IF AddCurrencyCode = '' THEN
            EXIT;

        EXIT(ExchangeAmtLCYToFCY2(AmountLCY));
    end;

    local procedure GetCurrencyExchRate(GenJnlLine: Record "81")
    var
        NewCurrencyDate: Date;
    begin
        IF AddCurrencyCode = '' THEN
            EXIT;

        AddCurrency.GET(AddCurrencyCode);
        AddCurrency.TESTFIELD("Amount Rounding Precision");
        AddCurrency.TESTFIELD("Residual Gains Account");
        AddCurrency.TESTFIELD("Residual Losses Account");

        NewCurrencyDate := GenJnlLine."Posting Date";
        IF GenJnlLine."Reversing Entry" THEN
            NewCurrencyDate := NewCurrencyDate - 1;
        IF (NewCurrencyDate <> CurrencyDate) OR
           UseCurrFactorOnly
        THEN BEGIN
            UseCurrFactorOnly := FALSE;
            CurrencyDate := NewCurrencyDate;
            CurrencyFactor :=
              CurrExchRate.ExchangeRate(CurrencyDate, AddCurrencyCode);
        END;
        IF (GenJnlLine."FA Add.-Currency Factor" <> 0) AND
           (GenJnlLine."FA Add.-Currency Factor" <> CurrencyFactor)
        THEN BEGIN
            UseCurrFactorOnly := TRUE;
            CurrencyDate := 0D;
            CurrencyFactor := GenJnlLine."FA Add.-Currency Factor";
        END;
    end;

    local procedure ExchangeAmtLCYToFCY2(Amount: Decimal): Decimal
    begin
        IF UseCurrFactorOnly THEN
            EXIT(
              ROUND(
                CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor(Amount, CurrencyFactor),
                AddCurrency."Amount Rounding Precision"));
        EXIT(
          ROUND(
            CurrExchRate.ExchangeAmtLCYToFCY(
              CurrencyDate, AddCurrencyCode, Amount, CurrencyFactor),
            AddCurrency."Amount Rounding Precision"));
    end;

    local procedure CheckNonAddCurrCodeOccurred(CurrencyCode: Code[10]): Boolean
    begin
        NonAddCurrCodeOccured :=
          NonAddCurrCodeOccured OR (AddCurrencyCode <> CurrencyCode);
        EXIT(NonAddCurrCodeOccured);
    end;

    local procedure TotalVATAmountOnJnlLines(GenJnlLine: Record "81") TotalVATAmount: Decimal
    var
        GenJnlLine2: Record "81";
    begin
        WITH GenJnlLine2 DO BEGIN
            SETRANGE("Source Code", GenJnlLine."Source Code");
            SETRANGE("Document No.", GenJnlLine."Document No.");
            SETRANGE("Posting Date", GenJnlLine."Posting Date");
            IF FINDSET THEN
                REPEAT
                    TotalVATAmount += "VAT Amount (LCY)" - "Bal. VAT Amount (LCY)";
                UNTIL NEXT = 0;
        END;
        EXIT(TotalVATAmount);
    end;

    procedure SetGLRegReverse(var ReverseGLReg: Record "45")
    begin
        GLReg.Reversed := TRUE;
        ReverseGLReg := GLReg;
    end;

    local procedure InsertVATEntriesFromTemp(var DtldCVLedgEntryBuf: Record "383"; GLEntry: Record "17")
    var
        Complete: Boolean;
        LinkedAmount: Decimal;
        FirstEntryNo: Integer;
        LastEntryNo: Integer;
    begin
        TempVATEntry.RESET;
        TempVATEntry.SETRANGE("Gen. Bus. Posting Group", GLEntry."Gen. Bus. Posting Group");
        TempVATEntry.SETRANGE("Gen. Prod. Posting Group", GLEntry."Gen. Prod. Posting Group");
        TempVATEntry.SETRANGE("VAT Bus. Posting Group", GLEntry."VAT Bus. Posting Group");
        TempVATEntry.SETRANGE("VAT Prod. Posting Group", GLEntry."VAT Prod. Posting Group");
        CASE DtldCVLedgEntryBuf."Entry Type" OF
            DtldCVLedgEntryBuf."Entry Type"::"Payment Discount Tolerance (VAT Excl.)":
                BEGIN
                    FirstEntryNo := 1000000;
                    LastEntryNo := 1999999;
                END;
            DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance (VAT Excl.)":
                BEGIN
                    FirstEntryNo := 2000000;
                    LastEntryNo := 2999999;
                END;
            DtldCVLedgEntryBuf."Entry Type"::"Payment Discount (VAT Excl.)":
                BEGIN
                    FirstEntryNo := 3000000;
                    LastEntryNo := 3999999;
                END;
        END;
        TempVATEntry.SETRANGE("Entry No.", FirstEntryNo, LastEntryNo);
        IF TempVATEntry.FINDSET THEN
            REPEAT
                VATEntry := TempVATEntry;
                VATEntry."Entry No." := NextVATEntryNo;
                VATEntry.INSERT(TRUE);
                NextVATEntryNo := NextVATEntryNo + 1;
                IF VATEntry."Unrealized VAT Entry No." = 0 THEN
                    GLEntryVATEntryLink.InsertLink(GLEntry."Entry No.", VATEntry."Entry No.");
                LinkedAmount += VATEntry.Amount + VATEntry.Base;
                Complete := LinkedAmount = -(DtldCVLedgEntryBuf."Amount (LCY)" + DtldCVLedgEntryBuf."VAT Amount (LCY)");
                LastEntryNo := TempVATEntry."Entry No.";
            UNTIL Complete OR (TempVATEntry.NEXT = 0);

        TempVATEntry.SETRANGE("Entry No.", FirstEntryNo, LastEntryNo);
        TempVATEntry.DELETEALL;
    end;

    local procedure ABSMin(Decimal1: Decimal; Decimal2: Decimal): Decimal
    begin
        IF ABS(Decimal1) < ABS(Decimal2) THEN
            EXIT(Decimal1);
        EXIT(Decimal2);
    end;

    procedure ABSMax(Decimal1: Decimal; Decimal2: Decimal): Decimal
    begin
        IF ABS(Decimal1) > ABS(Decimal2) THEN
            EXIT(Decimal1);
        EXIT(Decimal2);
    end;

    local procedure GetApplnRoundPrecision(NewCVLedgEntryBuf: Record "382"; OldCVLedgEntryBuf: Record "382"): Decimal
    var
        ApplnCurrency: Record "4";
        CurrencyCode: Code[10];
    begin
        IF NewCVLedgEntryBuf."Currency Code" <> '' THEN
            CurrencyCode := NewCVLedgEntryBuf."Currency Code"
        ELSE
            CurrencyCode := OldCVLedgEntryBuf."Currency Code";
        IF CurrencyCode = '' THEN
            EXIT(0);
        ApplnCurrency.GET(CurrencyCode);
        IF ApplnCurrency."Appln. Rounding Precision" <> 0 THEN
            EXIT(ApplnCurrency."Appln. Rounding Precision");
        EXIT(GLSetup."Appln. Rounding Precision");
    end;

    local procedure GetGLSetup()
    begin
        IF GLSetupRead THEN
            EXIT;

        GLSetup.GET;
        GLSetupRead := TRUE;

        AddCurrencyCode := GLSetup."Additional Reporting Currency";
    end;

    local procedure ReadGLSetup(var NewGLSetup: Record "98")
    begin
        NewGLSetup := GLSetup;
    end;

    local procedure CheckSalesExtDocNo(GenJnlLine: Record "81")
    var
        SalesSetup: Record "311";
    begin
        SalesSetup.GET;
        IF NOT SalesSetup."Ext. Doc. No. Mandatory" THEN
            EXIT;

        IF GenJnlLine."Document Type" IN
           [GenJnlLine."Document Type"::Invoice,
            GenJnlLine."Document Type"::"Credit Memo",
            GenJnlLine."Document Type"::Payment,
            GenJnlLine."Document Type"::Refund,
            GenJnlLine."Document Type"::" "]
        THEN
            GenJnlLine.TESTFIELD("External Document No.");
    end;

    local procedure CheckPurchExtDocNo(GenJnlLine: Record "81")
    var
        PurchSetup: Record "312";
        OldVendLedgEntry: Record "25";
    begin
        PurchSetup.GET;
        IF NOT (PurchSetup."Ext. Doc. No. Mandatory" OR (GenJnlLine."External Document No." <> '')) THEN
            EXIT;

        GenJnlLine.TESTFIELD("External Document No.");
        OldVendLedgEntry.RESET;
        OldVendLedgEntry.SETRANGE("External Document No.", GenJnlLine."External Document No.");
        OldVendLedgEntry.SETRANGE("Document Type", GenJnlLine."Document Type");
        OldVendLedgEntry.SETRANGE("Vendor No.", GenJnlLine."Account No.");
        OldVendLedgEntry.SETRANGE(Reversed, FALSE);
        IF NOT OldVendLedgEntry.ISEMPTY THEN
            ERROR(
              PurchaseAlreadyExistsErr,
              GenJnlLine."Document Type", GenJnlLine."External Document No.");
    end;

    local procedure CheckDimValueForDisposal(GenJnlLine: Record "81"; AccountNo: Code[20])
    var
        DimMgt: Codeunit "408";
        TableID: array[10] of Integer;
        AccNo: array[10] of Code[20];
    begin
        IF ((GenJnlLine.Amount = 0) OR (GenJnlLine."Amount (LCY)" = 0)) AND
           (GenJnlLine."FA Posting Type" = GenJnlLine."FA Posting Type"::Disposal)
        THEN BEGIN
            TableID[1] := DimMgt.TypeToTableID1(GenJnlLine."Account Type"::"G/L Account");
            AccNo[1] := AccountNo;
            IF NOT DimMgt.CheckDimValuePosting(TableID, AccNo, GenJnlLine."Dimension Set ID") THEN
                ERROR(DimMgt.GetDimValuePostingErr);
        END;
    end;

    procedure SetOverDimErr()
    begin
        OverrideDimErr := TRUE;
    end;

    local procedure CheckGLAccDimError(GenJnlLine: Record "81"; GLAccNo: Code[20])
    var
        DimMgt: Codeunit "408";
        TableID: array[10] of Integer;
        AccNo: array[10] of Code[20];
    begin
        IF (GenJnlLine.Amount = 0) AND (GenJnlLine."Amount (LCY)" = 0) THEN
            EXIT;

        TableID[1] := DATABASE::"G/L Account";
        AccNo[1] := GLAccNo;
        IF DimMgt.CheckDimValuePosting(TableID, AccNo, GenJnlLine."Dimension Set ID") THEN
            EXIT;

        IF GenJnlLine."Line No." <> 0 THEN
            ERROR(
              DimensionUsedErr,
              GenJnlLine.TABLECAPTION, GenJnlLine."Journal Template Name",
              GenJnlLine."Journal Batch Name", GenJnlLine."Line No.",
              DimMgt.GetDimValuePostingErr);

        ERROR(DimMgt.GetDimValuePostingErr);
    end;

    local procedure CalculateCurrentBalance(AccountNo: Code[20]; BalAccountNo: Code[20]; InclVATAmount: Boolean; AmountLCY: Decimal; VATAmount: Decimal)
    begin
        IF (AccountNo <> '') AND (BalAccountNo <> '') THEN
            EXIT;

        IF AccountNo = BalAccountNo THEN
            EXIT;

        IF NOT InclVATAmount THEN
            VATAmount := 0;

        IF BalAccountNo <> '' THEN
            CurrentBalance -= AmountLCY + VATAmount
        ELSE
            CurrentBalance += AmountLCY + VATAmount;
    end;

    local procedure GetCurrency(var Currency: Record "4"; CurrencyCode: Code[10])
    begin
        IF Currency.Code <> CurrencyCode THEN BEGIN
            IF CurrencyCode = '' THEN
                CLEAR(Currency)
            ELSE
                Currency.GET(CurrencyCode);
        END;
    end;

    local procedure CollectAdjustment(var AdjAmount: array[4] of Decimal; Amount: Decimal; AmountAddCurr: Decimal)
    var
        Offset: Integer;
    begin
        Offset := GetAdjAmountOffset(Amount, AmountAddCurr);
        AdjAmount[Offset] += Amount;
        AdjAmount[Offset + 1] += AmountAddCurr;
    end;

    local procedure HandleDtldAdjustment(GenJnlLine: Record "81"; var GLEntry: Record "17"; AdjAmount: array[4] of Decimal; TotalAmountLCY: Decimal; TotalAmountAddCurr: Decimal; GLAccNo: Code[20])
    begin
        IF NOT PostDtldAdjustment(
             GenJnlLine, GLEntry, AdjAmount,
             TotalAmountLCY, TotalAmountAddCurr, GLAccNo,
             GetAdjAmountOffset(TotalAmountLCY, TotalAmountAddCurr))
        THEN
            InitGLEntry(GenJnlLine, GLEntry, GLAccNo, TotalAmountLCY, TotalAmountAddCurr, TRUE, TRUE);
    end;

    local procedure PostDtldAdjustment(GenJnlLine: Record "81"; var GLEntry: Record "17"; AdjAmount: array[4] of Decimal; TotalAmountLCY: Decimal; TotalAmountAddCurr: Decimal; GLAcc: Code[20]; ArrayIndex: Integer): Boolean
    begin
        IF (GenJnlLine."Bal. Account No." <> '') AND
           ((AdjAmount[ArrayIndex] <> 0) OR (AdjAmount[ArrayIndex + 1] <> 0)) AND
           ((TotalAmountLCY + AdjAmount[ArrayIndex] <> 0) OR (TotalAmountAddCurr + AdjAmount[ArrayIndex + 1] <> 0))
        THEN BEGIN
            CreateGLEntryBalAcc(
              GenJnlLine, GLAcc, -AdjAmount[ArrayIndex], -AdjAmount[ArrayIndex + 1],
              GenJnlLine."Bal. Account Type", GenJnlLine."Bal. Account No.");
            InitGLEntry(GenJnlLine, GLEntry,
              GLAcc, TotalAmountLCY + AdjAmount[ArrayIndex],
              TotalAmountAddCurr + AdjAmount[ArrayIndex + 1], TRUE, TRUE);
            AdjAmount[ArrayIndex] := 0;
            AdjAmount[ArrayIndex + 1] := 0;
            EXIT(TRUE);
        END;

        EXIT(FALSE);
    end;

    local procedure GetAdjAmountOffset(Amount: Decimal; AmountACY: Decimal): Integer
    begin
        IF (Amount > 0) OR (Amount = 0) AND (AmountACY > 0) THEN
            EXIT(1);
        EXIT(3);
    end;

    procedure GetNextEntryNo(): Integer
    begin
        EXIT(NextEntryNo);
    end;

    procedure GetNextTransactionNo(): Integer
    begin
        EXIT(NextTransactionNo);
    end;

    procedure GetNextVATEntryNo(): Integer
    begin
        EXIT(NextVATEntryNo);
    end;

    procedure IncrNextVATEntryNo()
    begin
        NextVATEntryNo := NextVATEntryNo + 1;
    end;

    local procedure IsNotPayment(DocumentType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund): Boolean
    begin
        EXIT(DocumentType IN [DocumentType::Invoice,
                              DocumentType::"Credit Memo",
                              DocumentType::"Finance Charge Memo",
                              DocumentType::Reminder]);
    end;

    local procedure IsTempGLEntryBufEmpty(): Boolean
    begin
        EXIT(TempGLEntryBuf.ISEMPTY);
    end;

    local procedure IsVATAdjustment(EntryType: Option): Boolean
    var
        DtldCVLedgEntryBuf: Record "383";
    begin
        EXIT(EntryType IN [DtldCVLedgEntryBuf."Entry Type"::"Payment Discount (VAT Adjustment)",
                           DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                           DtldCVLedgEntryBuf."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]);
    end;

    local procedure IsVATExcluded(EntryType: Option): Boolean
    var
        DtldCVLedgEntryBuf: Record "383";
    begin
        EXIT(EntryType IN [DtldCVLedgEntryBuf."Entry Type"::"Payment Discount (VAT Excl.)",
                           DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance (VAT Excl.)",
                           DtldCVLedgEntryBuf."Entry Type"::"Payment Discount Tolerance (VAT Excl.)"]);
    end;

    local procedure UpdateGLEntryNo(var GLEntryNo: Integer; var SavedEntryNo: Integer)
    begin
        IF SavedEntryNo <> 0 THEN BEGIN
            GLEntryNo := SavedEntryNo;
            NextEntryNo := NextEntryNo - 1;
            SavedEntryNo := 0;
        END;
    end;

    local procedure UpdateTotalAmounts(var TempInvPostBuf: Record "49" temporary; DimSetID: Integer; AmountToCollect: Decimal; AmountACYToCollect: Decimal)
    begin
        WITH TempInvPostBuf DO BEGIN
            SETRANGE("Dimension Set ID", DimSetID);
            IF FINDFIRST THEN BEGIN
                Amount += AmountToCollect;
                "Amount (ACY)" += AmountACYToCollect;
                MODIFY;
            END ELSE BEGIN
                INIT;
                "Dimension Set ID" := DimSetID;
                Amount := AmountToCollect;
                "Amount (ACY)" := AmountACYToCollect;
                INSERT;
            END;
        END;
    end;

    local procedure CreateGLEntriesForTotalAmountsUnapply(GenJnlLine: Record "81"; var TempInvPostBuf: Record "49" temporary; Account: Code[20])
    var
        DimMgt: Codeunit "408";
    begin
        WITH TempInvPostBuf DO BEGIN
            SETRANGE("Dimension Set ID");
            IF FINDSET THEN
                REPEAT
                    IF (Amount <> 0) OR
                       ("Amount (ACY)" <> 0) AND (GLSetup."Additional Reporting Currency" <> '')
                    THEN BEGIN
                        DimMgt.UpdateGenJnlLineDim(GenJnlLine, "Dimension Set ID");
                        CreateGLEntry(GenJnlLine, Account, Amount, "Amount (ACY)", TRUE);
                    END;
                UNTIL NEXT = 0;
        END;
    end;

    local procedure CreateGLEntriesForTotalAmounts(GenJnlLine: Record "81"; var InvPostBuf: Record "49"; AdjAmountBuf: array[4] of Decimal; SavedEntryNo: Integer; GLAccNo: Code[20]; LedgEntryInserted: Boolean)
    var
        DimMgt: Codeunit "408";
        GLEntryInserted: Boolean;
    begin
        GLEntryInserted := FALSE;

        WITH InvPostBuf DO BEGIN
            RESET;
            IF FINDSET THEN
                REPEAT
                    IF (Amount <> 0) OR ("Amount (ACY)" <> 0) AND (AddCurrencyCode <> '') THEN BEGIN
                        DimMgt.UpdateGenJnlLineDim(GenJnlLine, "Dimension Set ID");
                        CreateGLEntryForTotalAmounts(GenJnlLine, Amount, "Amount (ACY)", AdjAmountBuf, SavedEntryNo, GLAccNo);
                        GLEntryInserted := TRUE;
                    END;
                UNTIL NEXT = 0;
        END;

        IF NOT GLEntryInserted AND LedgEntryInserted THEN
            CreateGLEntryForTotalAmounts(GenJnlLine, 0, 0, AdjAmountBuf, SavedEntryNo, GLAccNo);
    end;

    local procedure CreateGLEntryForTotalAmounts(GenJnlLine: Record "81"; Amount: Decimal; AmountACY: Decimal; AdjAmountBuf: array[4] of Decimal; var SavedEntryNo: Integer; GLAccNo: Code[20])
    var
        GLEntry: Record "17";
    begin
        HandleDtldAdjustment(GenJnlLine, GLEntry, AdjAmountBuf, Amount, AmountACY, GLAccNo);
        GLEntry."Bal. Account Type" := GenJnlLine."Bal. Account Type";
        GLEntry."Bal. Account No." := GenJnlLine."Bal. Account No.";
        UpdateGLEntryNo(GLEntry."Entry No.", SavedEntryNo);
        InsertGLEntry(GenJnlLine, GLEntry, TRUE);
    end;

    local procedure SetAddCurrForUnapplication(var DtldCVLedgEntryBuf: Record "383")
    begin
        WITH DtldCVLedgEntryBuf DO
            IF NOT ("Entry Type" IN ["Entry Type"::Application, "Entry Type"::"Unrealized Loss",
                                     "Entry Type"::"Unrealized Gain", "Entry Type"::"Realized Loss",
                                     "Entry Type"::"Realized Gain", "Entry Type"::"Correction of Remaining Amount"])
            THEN
                IF ("Entry Type" = "Entry Type"::"Appln. Rounding") OR
                   ((AddCurrencyCode <> '') AND (AddCurrencyCode = "Currency Code"))
                THEN
                    "Additional-Currency Amount" := Amount
                ELSE
                    "Additional-Currency Amount" := CalcAddCurrForUnapplication("Posting Date", "Amount (LCY)");
    end;

    local procedure GetAppliedAmountFromBuffers(NewCVLedgEntryBuf: Record "382"; OldCVLedgEntryBuf: Record "382"): Decimal
    begin
        IF (((NewCVLedgEntryBuf."Document Type" = NewCVLedgEntryBuf."Document Type"::Payment) AND
             (OldCVLedgEntryBuf."Document Type" = OldCVLedgEntryBuf."Document Type"::"Credit Memo")) OR
            ((NewCVLedgEntryBuf."Document Type" = NewCVLedgEntryBuf."Document Type"::Refund) AND
             (OldCVLedgEntryBuf."Document Type" = OldCVLedgEntryBuf."Document Type"::Invoice))) AND
           (ABS(NewCVLedgEntryBuf."Remaining Amount") < ABS(OldCVLedgEntryBuf."Amount to Apply"))
        THEN
            EXIT(ABSMax(NewCVLedgEntryBuf."Remaining Amount", -OldCVLedgEntryBuf."Amount to Apply"));
        EXIT(ABSMin(NewCVLedgEntryBuf."Remaining Amount", -OldCVLedgEntryBuf."Amount to Apply"));
    end;

    local procedure PostDeferral(var GenJournalLine: Record "81"; AccountNumber: Code[20])
    var
        DeferralTemplate: Record "1700";
        DeferralHeader: Record "1701";
        DeferralLine: Record "1702";
        GLEntry: Record "17";
        CurrExchRate: Record "330";
        DeferralUtilities: Codeunit "1720";
        PerPostDate: Date;
        PeriodicCount: Integer;
        AmtToDefer: Decimal;
        AmtToDeferACY: Decimal;
        EmptyDeferralLine: Boolean;
    begin
        WITH GenJournalLine DO BEGIN
            IF "Source Type" IN ["Source Type"::Vendor, "Source Type"::Customer] THEN
                // Purchasing and Sales, respectively
                // We can create these types directly from the GL window, need to make sure we don't already have a deferral schedule
                // created for this GL Trx before handing it off to sales/purchasing subsystem
                IF "Source Code" <> GLSourceCode THEN BEGIN
                    PostDeferralPostBuffer(GenJournalLine);
                    EXIT;
                END;

            IF DeferralHeader.GET(DeferralDocType::"G/L", "Journal Template Name", "Journal Batch Name", 0, '', "Line No.") THEN BEGIN
                EmptyDeferralLine := FALSE;
                // Get the range of detail records for this schedule
                DeferralLine.SETRANGE("Deferral Doc. Type", DeferralDocType::"G/L");
                DeferralLine.SETRANGE("Gen. Jnl. Template Name", "Journal Template Name");
                DeferralLine.SETRANGE("Gen. Jnl. Batch Name", "Journal Batch Name");
                DeferralLine.SETRANGE("Document Type", 0);
                DeferralLine.SETRANGE("Document No.", '');
                DeferralLine.SETRANGE("Line No.", "Line No.");
                IF DeferralLine.FINDSET THEN
                    REPEAT
                        IF DeferralLine.Amount = 0.0 THEN
                            EmptyDeferralLine := TRUE;
                    UNTIL (DeferralLine.NEXT = 0) OR EmptyDeferralLine;
                IF EmptyDeferralLine THEN
                    ERROR(ZeroDeferralAmtErr, "Line No.", "Deferral Code");
                DeferralHeader."Amount to Defer (LCY)" :=
                  ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code",
                      DeferralHeader."Amount to Defer", "Currency Factor"));
                DeferralHeader.MODIFY;
            END;

            DeferralUtilities.RoundDeferralAmount(
              DeferralHeader,
              "Currency Code", "Currency Factor", "Posting Date", AmtToDefer, AmtToDeferACY);

            DeferralTemplate.GET("Deferral Code");
            DeferralTemplate.TESTFIELD("Deferral Account");
            DeferralTemplate.TESTFIELD("Deferral %");

            // Get the Deferral Header table so we know the amount to defer...
            // Assume straight GL posting
            IF DeferralHeader.GET(DeferralDocType::"G/L", "Journal Template Name", "Journal Batch Name", 0, '', "Line No.") THEN BEGIN
                // Get the range of detail records for this schedule
                DeferralLine.SETRANGE("Deferral Doc. Type", DeferralDocType::"G/L");
                DeferralLine.SETRANGE("Gen. Jnl. Template Name", "Journal Template Name");
                DeferralLine.SETRANGE("Gen. Jnl. Batch Name", "Journal Batch Name");
                DeferralLine.SETRANGE("Document Type", 0);
                DeferralLine.SETRANGE("Document No.", '');
                DeferralLine.SETRANGE("Line No.", "Line No.");
            END ELSE
                ERROR(NoDeferralScheduleErr, "Line No.", "Deferral Code");

            InitGLEntry(GenJournalLine, GLEntry,
              AccountNumber,
              -DeferralHeader."Amount to Defer (LCY)",
              -DeferralHeader."Amount to Defer", TRUE, TRUE);
            GLEntry.Description := Description;
            InsertGLEntry(GenJournalLine, GLEntry, TRUE);

            InitGLEntry(GenJournalLine, GLEntry,
              DeferralTemplate."Deferral Account",
              DeferralHeader."Amount to Defer (LCY)",
              DeferralHeader."Amount to Defer", TRUE, TRUE);
            GLEntry.Description := Description;
            InsertGLEntry(GenJournalLine, GLEntry, TRUE);

            // Here we want to get the Deferral Details table range and loop through them...
            IF DeferralLine.FINDSET THEN BEGIN
                PeriodicCount := 1;
                REPEAT
                    PerPostDate := DeferralLine."Posting Date";
                    IF GenJnlCheckLine.DateNotAllowed(PerPostDate) THEN
                        ERROR(InvalidPostingDateErr, PerPostDate);

                    InitGLEntry(GenJournalLine, GLEntry, AccountNumber, DeferralLine."Amount (LCY)",
                      DeferralLine.Amount,
                      TRUE, TRUE);
                    GLEntry."Posting Date" := PerPostDate;
                    GLEntry.Description := DeferralLine.Description;
                    InsertGLEntry(GenJournalLine, GLEntry, TRUE);

                    InitGLEntry(GenJournalLine, GLEntry,
                      DeferralTemplate."Deferral Account", -DeferralLine."Amount (LCY)",
                      -DeferralLine.Amount,
                      TRUE, TRUE);
                    GLEntry."Posting Date" := PerPostDate;
                    GLEntry.Description := DeferralLine.Description;
                    InsertGLEntry(GenJournalLine, GLEntry, TRUE);
                    PeriodicCount := PeriodicCount + 1;
                UNTIL DeferralLine.NEXT = 0;
            END ELSE
                ERROR(NoDeferralScheduleErr, "Line No.", "Deferral Code");
        END;
    end;

    local procedure PostDeferralPostBuffer(GenJournalLine: Record "81")
    var
        DeferralPostBuffer: Record "1703";
        GLEntry: Record "17";
        PostDate: Date;
    begin
        WITH GenJournalLine DO BEGIN
            IF "Source Type" = "Source Type"::Customer THEN
                DeferralDocType := DeferralDocType::Sales
            ELSE
                DeferralDocType := DeferralDocType::Purchase;

            DeferralPostBuffer.SETRANGE("Deferral Doc. Type", DeferralDocType);
            DeferralPostBuffer.SETRANGE("Document No.", "Document No.");
            DeferralPostBuffer.SETRANGE("Deferral Line No.", "Deferral Line No.");

            IF DeferralPostBuffer.FINDSET THEN BEGIN
                REPEAT
                    PostDate := DeferralPostBuffer."Posting Date";
                    IF GenJnlCheckLine.DateNotAllowed(PostDate) THEN
                        ERROR(InvalidPostingDateErr, PostDate);

                    // When no sales/purch amount is entered, the offset was already posted
                    IF (DeferralPostBuffer."Sales/Purch Amount" <> 0) OR (DeferralPostBuffer."Sales/Purch Amount (LCY)" <> 0) THEN BEGIN
                        InitGLEntry(GenJournalLine, GLEntry, DeferralPostBuffer."G/L Account",
                          DeferralPostBuffer."Sales/Purch Amount (LCY)",
                          DeferralPostBuffer."Sales/Purch Amount",
                          TRUE, TRUE);
                        GLEntry."Posting Date" := PostDate;
                        GLEntry.Description := DeferralPostBuffer.Description;
                        GLEntry.CopyFromDeferralPostBuffer(DeferralPostBuffer);
                        InsertGLEntry(GenJournalLine, GLEntry, TRUE);
                    END;

                    InitGLEntry(GenJournalLine, GLEntry,
                      DeferralPostBuffer."Deferral Account",
                      -DeferralPostBuffer."Amount (LCY)",
                      -DeferralPostBuffer.Amount,
                      TRUE, TRUE);
                    GLEntry."Posting Date" := PostDate;
                    GLEntry.Description := DeferralPostBuffer.Description;
                    InsertGLEntry(GenJournalLine, GLEntry, TRUE);
                UNTIL DeferralPostBuffer.NEXT = 0;
                DeferralPostBuffer.DELETEALL;
            END;
        END;
    end;

    procedure RemoveDeferralSchedule(GenJournalLine: Record "81")
    var
        DeferralUtilities: Codeunit "1720";
        DeferralDocType: Option Purchase,Sales,"G/L";
    begin
        // Removing deferral schedule after all deferrals for this line have been posted successfully
        WITH GenJournalLine DO
            DeferralUtilities.DeferralCodeOnDelete(
              DeferralDocType::"G/L",
              "Journal Template Name",
              "Journal Batch Name", 0, '', "Line No.");
    end;

    local procedure GetGLSourceCode()
    var
        SourceCodeSetup: Record "242";
    begin
        SourceCodeSetup.GET;
        GLSourceCode := SourceCodeSetup."General Journal";
    end;

    local procedure DeferralPosting(DeferralCode: Code[10]; SourceCode: Code[10]; AccountNo: Code[20]; var GenJournalLine: Record "81"; Balancing: Boolean)
    begin
        IF DeferralCode <> '' THEN
            // Sales and purchasing could have negative amounts, so check for them first...
            IF (SourceCode <> GLSourceCode) AND
             (GenJournalLine."Account Type" IN [GenJournalLine."Account Type"::Customer, GenJournalLine."Account Type"::Vendor])
          THEN
                PostDeferralPostBuffer(GenJournalLine)
            ELSE
                // Pure GL trx, only post deferrals if it is not a balancing entry
                IF NOT Balancing THEN
                    PostDeferral(GenJournalLine, AccountNo);
    end;

    local procedure GetPostingAccountNo(VATPostingSetup: Record "325"; VATEntry: Record "254"; UnrealizedVAT: Boolean): Code[20]
    var
        TaxJurisdiction: Record "320";
    begin
        IF VATPostingSetup."VAT Calculation Type" = VATPostingSetup."VAT Calculation Type"::"Sales Tax" THEN BEGIN
            VATEntry.TESTFIELD("Tax Jurisdiction Code");
            TaxJurisdiction.GET(VATEntry."Tax Jurisdiction Code");
            CASE VATEntry.Type OF
                VATEntry.Type::Sale:
                    EXIT(TaxJurisdiction.GetSalesAccount(UnrealizedVAT));
                VATEntry.Type::Purchase:
                    EXIT(TaxJurisdiction.GetPurchAccount(UnrealizedVAT));
            END;
        END;

        CASE VATEntry.Type OF
            VATEntry.Type::Sale:
                EXIT(VATPostingSetup.GetSalesAccount(UnrealizedVAT));
            VATEntry.Type::Purchase:
                EXIT(VATPostingSetup.GetPurchAccount(UnrealizedVAT));
        END;
    end;

    local procedure IsDebitAmount(DtldCVLedgEntryBuf: Record "383"; Unapply: Boolean): Boolean
    var
        VATPostingSetup: Record "325";
        VATAmountCondition: Boolean;
        EntryAmount: Decimal;
    begin
        WITH DtldCVLedgEntryBuf DO BEGIN
            VATAmountCondition :=
              "Entry Type" IN ["Entry Type"::"Payment Discount (VAT Excl.)", "Entry Type"::"Payment Tolerance (VAT Excl.)",
                               "Entry Type"::"Payment Discount Tolerance (VAT Excl.)"];
            IF VATAmountCondition THEN BEGIN
                VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                VATAmountCondition := VATPostingSetup."VAT Calculation Type" = VATPostingSetup."VAT Calculation Type"::"Full VAT";
            END;
            IF VATAmountCondition THEN
                EntryAmount := "VAT Amount (LCY)"
            ELSE
                EntryAmount := "Amount (LCY)";
            IF Unapply THEN
                EXIT(EntryAmount > 0);
            EXIT(EntryAmount <= 0);
        END;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCode(var GenJnlLine: Record "81"; CheckLine: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckPurchExtDocNo(GenJournalLine: Record "81"; VendorLedgerEntry: Record "25"; CVLedgerEntryBuffer: Record "382"; var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStartPosting(var GenJournalLine: Record "81")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeContinuePosting(var GenJournalLine: Record "81")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostGenJnlLine(var GenJournalLine: Record "81")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInitGLRegister(var GLRegister: Record "45"; var GenJournalLine: Record "81")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertGlobalGLEntry(var GLEntry: Record "17")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRunWithCheck(var GenJnlLine: Record "81")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRunWithoutCheck(var GenJnlLine: Record "81")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertGLEntryBuffer(var TempGLEntryBuf: Record "17" temporary; var GenJournalLine: Record "81")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGLFinishPosting(GLEntry: Record "17"; var GenJnlLine: Record "81"; IsTransactionConsistent: Boolean; FirstTransactionNo: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnNextTransactionNoNeeded(GenJnlLine: Record "81"; LastDocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder; LastDocNo: Code[20]; LastDate: Date; CurrentBalance: Decimal; CurrentBalanceACY: Decimal; var NewTransaction: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostGLAcc(GenJnlLine: Record "81")
    begin
    end;*/

    //[Scope('Internal')]
    procedure "Update Semester"(EntryNo: Integer; Sem: Code[20])
    var
        CustD: Record 379;
    begin
        IF CustD.GET(EntryNo) THEN BEGIN
            //CustD.Semester := Sem;
            CustD.MODIFY;
        END;
    end;

    //[Scope('Internal')]
    procedure RemoveApplications(EntryNo: Integer)
    var
        CustD: Record 379;
    begin
        IF CustD.GET(EntryNo) THEN BEGIN
            CustD.DELETE;
        END;
    end;

    //[Scope('Internal')]
    procedure UpdateBankRec(BankNo: Code[20]; SDate: Date)
    var
        BankLedger: Record 271;
    begin
        BankLedger.RESET;
        BankLedger.SETRANGE(BankLedger."Bank Account No.", BankNo);
        BankLedger.SETRANGE(BankLedger.Reversed, FALSE);
        BankLedger.SETFILTER(BankLedger."Posting Date", '%1..%2', 99991231D, SDate);
        BankLedger.SETFILTER(BankLedger."Statement Line No.", '%1', 0);
        IF BankLedger.FIND('-') THEN BEGIN
            REPEAT
                BankLedger."Statement Difference" := BankLedger.Amount;
                BankLedger.MODIFY;
            UNTIL BankLedger.NEXT = 0;
        END;
    end;

    //[Scope('Internal')]
    procedure UpdateBankCheque(BankNo: Code[20]; DocNo: Code[20]; ChequeNo: Code[20])
    var
        BankL: Record 271;
    begin
        BankL.RESET;
        BankL.SETRANGE("Document No.", DocNo);
        BankL.SETRANGE("Bank Account No.", BankNo);
        IF BankL.FIND('-') THEN BEGIN
            REPEAT
                BankL."External Document No." := ChequeNo;
                BankL.MODIFY;
            UNTIL BankL.NEXT = 0;
        END;
    end;
}

