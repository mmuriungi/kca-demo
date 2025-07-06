codeunit 50013 "Finance Operations"
{
    var

        PaymentHeader: Record "FIN-Imprest Header";
        Objeperiod: Record "PRL-Payroll Periods";
        EmpTransactions: Record "PRL-Employee Transactions";
        Periodmoth: Integer;
        periodYear: Integer;
        PayrallPeriod: date;
        TotalRec: Integer;
        TotalRec2: Integer;
        ImpSur: Record "FIN-Imprest Surr. Header";
        ImpsurrLines: Record "FIN-Imprest Surrender Details";
        gensetup: record "Cash Office Setup";
        NextSurNo: code[20];
        NoSeriesMgt: Codeunit 396;
        SendApprovalRequest: Codeunit "Init Code";
        BCSetup: Record "FIN-Budgetary Control Setup";

        AdjustGenJnl: Codeunit 407;
        BudgetControl: Codeunit "Budgetary Control";
        FINImprestSurrLines: Record "FIN-Imprest Surrender Details";
        GenJnlLine: record 81;
        interest: decimal;
        ImprestReq: Record "FIN-Imprest Header";
        GenledSetup: RECORD "Cash Office Setup";
        DefaultBatch: Record 232;
        InterestGLAccount: Code[20];
        genlegSetUp: RECORD "Cash Office Setup";
        LineNo: Integer;
        ImprestDetails: Record "FIN-Imprest Surrender Details";

    Procedure GenerateCashImprestPv(var FinImprestHeader: Record "FIN-Imprest Header")
    var
        ImpHeaderLine: record "FIN-Imprest Lines";
        PayHeader: Record "FIN-Payments Header";
        Payline: Record "FIN-Payment Line";
        genSetup: Record "Cash Office Setup";
        Info: record 79;
        Nextno: code[20];
        NoSeriesMgt: Codeunit 396;

    begin
        if not FinImprestHeader."Pay Using Pv" then begin
            Nextno := NoSeriesMgt.GetNextNo('PV', 0D, TRUE);
            PayHeader.Init();
            PayHeader."No." := Nextno;
            PayHeader."Imprest Voucher" := true;
            PayHeader.Date := Today;
            PayHeader.Cashier := UserId;
            PayHeader."Time Posted" := Time;
            PayHeader."Payment Narration" := FinImprestHeader.Purpose;
            PayHeader."Global Dimension 1 Code" := FinImprestHeader."Global Dimension 1 Code";
            PayHeader."Shortcut Dimension 2 Code" := FinImprestHeader."Shortcut Dimension 2 Code";
            PayHeader."Responsibility Center" := FinImprestHeader."Responsibility Center";
            PayHeader.Payee := FinImprestHeader.Payee;
            PayHeader."On Behalf Of" := FinImprestHeader."On Behalf Of";
            PayHeader."Imprest No.":=FinImprestHeader."No.";
            Info.get;
            PayHeader."On Behalf Of" := Info.Name;
            PayHeader.Insert();
            Payline.reset;
            Payline.SetRange("Imprest Request No", FinImprestHeader."No.");
            Payline.SetFilter("Imprest Processed", '=%1', false);
            Payline.SetRange(No, PayHeader."No.");
            if not Payline.Find('-') then begin
                FinImprestHeader.CalcFields("Total Net Amount");
                Payline.Init();
                Payline.No := PayHeader."No.";
                Payline.Type := 'IMPREST';
                Payline."Account Type" := Payline."Account Type"::Customer;
                Payline.Grouping := 'IMPREST';
                Payline."Account No." := FinImprestHeader."Account No.";
                Payline.Validate("Account No.");
                Payline.Payee := FinImprestHeader.Payee;
                Payline."Transaction Name" := PayHeader.Payee;
                Payline."Imprest Request No" := FinImprestHeader."No.";
                Payline.Amount := FinImprestHeader."Total Net Amount";
                Payline.Validate(Amount);
                Payline."Imprest Processed" := true;
                PayLine.INSERT(True);
            end;
            FinImprestHeader."Pay Using Pv" := true;
            FinImprestHeader.Status := FinImprestHeader.Status::Posted;
            FinImprestHeader.Posted := true;
            FinImprestHeader.Modify()





        end;
        /* ImpHeader.Reset();
         ImpHeader.SetRange("No.", FinImprestHeader."No.");
         if ImpHeader.Find('-') then begin




             Nextno := NoSeriesMgt.GetNextNo('PV', 0D, TRUE);
             PayHeader.Init();
             PayHeader."No." := Nextno;
             PayHeader."Imprest Voucher" := true;
             PayHeader.Date := Today;
             PayHeader.Cashier := UserId;
             PayHeader."Time Posted" := Time;
             PayHeader."Payment Narration" := 'Imprest Combinination';
             PayHeader."Global Dimension 1 Code" := 'MAIN';
             PayHeader."Shortcut Dimension 2 Code" := 'CENTRAL VOTE';
             Info.get;
             PayHeader."On Behalf Of" := Info.Name;
             PayHeader.Insert();
             if PayHeader.Insert() then begin



                 //repeat
                 ImpHeader.CalcFields("Total Net Amount");
                 Payline.Init();
                 Payline.No := PayHeader."No.";
                 Payline.Type := 'IMPREST';
                 Payline."Account Type" := Payline."Account Type"::Customer;
                 Payline.Grouping := 'IMPREST';
                 Payline."Account No." := ImpHeader."Account No.";
                 Payline.Validate("Account No.");
                 Payline.Payee := ImpHeader.Payee;
                 Payline."Transaction Name" := PayHeader.Payee;
                 Payline."Imprest Request No" := ImpHeader."No.";



                 Payline.Amount := ImpHeader."Total Net Amount";
                 Payline.Validate(Amount);
                 PayLine.INSERT(True);
                 ImpHeader."Pay Using Pv" := true;
                 ImpHeader.Modify()
                 //until ImpHeader.next = 0;

             end;*/
        FinImprestHeader."Pay Using Pv" := true;
        FinImprestHeader.Status := FinImprestHeader.Status::Posted;
        FinImprestHeader.Modify();
        SendApprovalRequest.OnSendPVSforApproval(PayHeader);
        Message('pv No: ' + format(PayHeader."No.") + ' Generated Successifully and awaiting approval');


        //end;
    end;

    procedure PayrollRefund()
    begin

        Objeperiod.reset;
        Objeperiod.SetFilter(Objeperiod.Closed, '=%1', false);
        if Objeperiod.Find('-') then begin
            Periodmoth := Objeperiod."Period Month";
            periodYear := Objeperiod."Period Year";
            PayrallPeriod := Objeperiod."Date Opened";

            if Objeperiod.Find('-') then begin
            end;
        end;
    end;


    procedure RecoverFromPayroll()
    var



    begin
        Objeperiod.reset;
        Objeperiod.SetFilter(Objeperiod.Closed, '=%1', false);
        if Objeperiod.Find('-') then begin
            Periodmoth := Objeperiod."Period Month";
            periodYear := Objeperiod."Period Year";
            PayrallPeriod := Objeperiod."Date Opened";

            if Objeperiod.Find('-') then begin
                PaymentHeader.reset;
                PaymentHeader.SetFilter(Posted, '=%1', true);
                PaymentHeader.SetFilter("Posted To Payroll", '=%1', false);
                PaymentHeader.SetFilter("Expected Date of Surrender", '<=%1', Today);


                IF PaymentHeader.Find('-') THEN begin
                    // TotalRec := PaymentHeader.Count;


                    repeat
                        //Create surrender
                        ImpSur.Reset;
                        ImpSur.SetRange("Created Via Recovery", true);
                        ImpSur.SetRange(Posted, false);
                        ImpSur.SetRange("Imprest Issue Doc. No", PaymentHeader."No.");
                        if not ImpSur.FindFirst() then begin
                            repeat
                                NextSurNo := NoSeriesMgt.GetNextNo('SURR', 0D, TRUE);
                                ImpSur.Init();
                                ImpSur.No := NextSurNo;
                                ImpSur."Surrender Date" := TODAY;
                                ImpSur."Account Type" := ImpSur."Account Type"::Customer;
                                ImpSur."Account No." := PaymentHeader."Account No.";
                                ImpSur.Validate("Account No.");

                                ImpSur."Imprest Issue Doc. No" := PaymentHeader."No.";
                                ImpSur.Validate("Imprest Issue Doc. No");
                                ImpSur."Created Via Recovery" := true;
                                ImpSur.Validate("Created Via Recovery");
                                ImpSur."post via Recovery" := true;
                                ImpSur.Status := ImpSur.Status::Approved;
                                //ImpSur.Validate("post via Recovery");


                                ImpSur.Insert();


                            until ImpSur.Next() = 0;

                            CommitBudgetSurrender(ImpSur);
                            //postimprest(ImpSur);





                        end;



                        EmpTransactions.reset;
                        EmpTransactions.SetRange("Employee Code", PaymentHeader."Account No.");
                        EmpTransactions.SetRange("Transaction Code", 'D-0001');
                        EmpTransactions.SetRange("Payroll Period", PayrallPeriod);
                        EmpTransactions.SetRange("Period Month", Periodmoth);
                        EmpTransactions.SetRange("Period Year", periodYear);
                        if not EmpTransactions.Find('-') then begin
                            PaymentHeader.CalcFields("Total Net Amount");
                            EmpTransactions.Init();
                            EmpTransactions."Employee Code" := PaymentHeader."Account No.";
                            EmpTransactions."Transaction Code" := 'D-0001';
                            EmpTransactions.Validate("Transaction Code");
                            EmpTransactions.Amount := PaymentHeader."Total Net Amount";
                            EmpTransactions."Period Month" := Periodmoth;
                            EmpTransactions."Period Year" := periodYear;
                            EmpTransactions."Payroll Period" := PayrallPeriod;
                            EmpTransactions."Recurance Index" := 1;
                            EmpTransactions.Insert();
                        end;
                        //if ImprestDetails."Acc interest Amount" <> 0 then begin
                        EmpTransactions.reset;
                        EmpTransactions.SetRange("Employee Code", PaymentHeader."Account No.");
                        EmpTransactions.SetRange("Transaction Code", 'D-0002');
                        EmpTransactions.SetRange("Payroll Period", PayrallPeriod);
                        EmpTransactions.SetRange("Period Month", Periodmoth);
                        EmpTransactions.SetRange("Period Year", periodYear);
                        if not EmpTransactions.Find('-') then begin
                            PaymentHeader.CalcFields("Total Net Amount");
                            EmpTransactions.Init();
                            EmpTransactions."Employee Code" := PaymentHeader."Account No.";
                            EmpTransactions."Transaction Code" := 'D-0002';
                            EmpTransactions.Validate("Transaction Code");
                            //GenledSetup.get;
                            //interest := genlegSetUp."Interest %";
                            EmpTransactions.Amount := PaymentHeader."Total Net Amount" * 15.84;
                            EmpTransactions."Period Month" := Periodmoth;
                            EmpTransactions."Period Year" := periodYear;
                            EmpTransactions."Payroll Period" := PayrallPeriod;
                            EmpTransactions."Recurance Index" := 1;
                            EmpTransactions.Insert();



                        end;


                        PaymentHeader."Posted To Payroll" := true;
                        PaymentHeader."Transfer By" := UserId;
                        PaymentHeader."Date Transfered" := Today;
                        PaymentHeader."Time Transfered" := TIME;
                        PaymentHeader."Interest Charged" := true;
                        PaymentHeader."Interest Transfered" := TRUE;
                        PaymentHeader.Modify()
                    until PaymentHeader.Next() = 0;
                    Message('Recovered  from  Payroll Succesfull');


                end;

            end;

        end;
    end;

    procedure CommitBudgetSurrender(var Sur: record "FIN-Imprest Surr. Header")
    var
        ImpSur: Record "FIN-Imprest Surr. Header";

        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT ((BCSetup.Mandatory)) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");

        FINImprestSurrLines.RESET;
        FINImprestSurrLines.SETRANGE("Surrender Doc No.", Sur.No);
        IF FINImprestSurrLines.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                // Expense Budget Here
                FINImprestSurrLines.TESTFIELD("Account No:");
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", FINImprestSurrLines."Account No:");
                IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, Sur."Global Dimension 1 Code");
                //DimensionValue.SETRANGE("Global Dimension No.", 2);
                IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
                IF (FINImprestSurrLines."Actual Spent" > 0) THEN BEGIN
                    // Commit Budget Here
                    PostBudgetEnties.ExpenseBudget(FINImprestSurrLines."Account No:", Sur."Surrender Date", Sur."Global Dimension 1 Code", '',
                    FINImprestSurrLines."Actual Spent", FINImprestSurrLines."Account Name", USERID, TODAY, 'IMPREST', Sur."Imprest Issue Doc. No" + FINImprestSurrLines."Account No:", '', Sur.Payee);
                END;
            END;
            UNTIL FINImprestSurrLines.NEXT = 0;
        END;
    end;

    procedure postimprest(var Surrender: record "FIN-Imprest Surr. Header")

    begin


        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
        IF GenledSetup.GET THEN BEGIN
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", GenledSetup."Surrender Template");
            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", GenledSetup."Surrender  Batch");
            GenJnlLine.DELETEALL(true);
        END;

        IF DefaultBatch.GET(GenledSetup."Surrender Template", GenledSetup."Surrender  Batch") THEN BEGIN
            DefaultBatch.DELETE;
        END;

        DefaultBatch.RESET;
        DefaultBatch."Journal Template Name" := GenledSetup."Surrender Template";
        DefaultBatch.Name := GenledSetup."Surrender  Batch";
        DefaultBatch.INSERT;
        LineNo := 0;

        ImprestDetails.RESET;
        ImprestDetails.SETRANGE(ImprestDetails."Surrender Doc No.", Surrender.No);
        IF ImprestDetails.FIND('-') THEN BEGIN
            REPEAT
                //Post Surrender Journal
                //Compare the amount issued =amount on cash reciecied.
                //Created new field for zero spent
                //

                //ImprestDetails.TESTFIELD("Actual Spent");
                //ImprestDetails.TESTFIELD("Actual Spent");
                IF (ImprestDetails."Cash Receipt Amount" + ImprestDetails."Actual Spent") <> ImprestDetails.Amount THEN
                    //ERROR(Txt0001);

                    //Surrender.TESTFIELD("Global Dimension 1 Code");

                LineNo := LineNo + 1000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := GenledSetup."Surrender Template";
                GenJnlLine."Journal Batch Name" := GenledSetup."Surrender  Batch";
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Account No." := ImprestDetails."Account No:";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                //Set these fields to blanks
                GenJnlLine."Posting Date" := Surrender."Surrender Date";
                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine.VALIDATE("Gen. Posting Type");
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine.VALIDATE("Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine.VALIDATE("Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := '';
                GenJnlLine.VALIDATE("VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := '';
                GenJnlLine.VALIDATE("VAT Prod. Posting Group");
                GenJnlLine."Document No." := Surrender.No;
                GenJnlLine.Amount := ImprestDetails."Actual Spent";
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::Customer;
                GenJnlLine."Bal. Account No." := ImprestDetails."Imprest Holder";
                GenJnlLine.Description := 'Imprest Surrendered by staff' + ':' + ImprestDetails."Imprest Holder";
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Currency Code" := Surrender."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                //Take care of Currency Factor
                GenJnlLine."Currency Factor" := Surrender."Currency Factor";
                GenJnlLine.VALIDATE("Currency Factor");

                GenJnlLine."Shortcut Dimension 1 Code" := Surrender."Global Dimension 1 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");

                IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer THEN BEGIN
                    GenJnlLine."Applies-to Doc. No." := Surrender."PV No";
                    GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                    GenJnlLine."Applies-to ID" := Surrender."Apply to ID";


                END;

                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT(True);

            //Post Interest
            /*if ImprestDetails."Acc interest Amount" <> 0 then begin
                genlegSetUp.get;
                genlegSetUp.TestField("Interest G/l Acc");
                InterestGLAccount := genlegSetUp."Interest G/l Acc";


                LineNo := LineNo + 10000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := GenledSetup."Surrender Template";
                GenJnlLine."Journal Batch Name" := GenledSetup."Surrender  Batch";
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                GenJnlLine."Account No." := ImprestDetails."Imprest Holder";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                //Set these fields to blanks
                GenJnlLine."Posting Date" := Surrender."Surrender Date";
                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine.VALIDATE("Gen. Posting Type");
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine.VALIDATE("Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine.VALIDATE("Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := '';
                GenJnlLine.VALIDATE("VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := '';
                GenJnlLine.VALIDATE("VAT Prod. Posting Group");
                GenJnlLine."Document No." := Surrender.No;
                GenJnlLine.Amount := ImprestDetails."Acc interest Amount";
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := InterestGLAccount;
                GenJnlLine.Description := 'Interest Charged : ' + ImprestDetails."Imprest Holder" + ' on ' + ImprestReq."No.";
                ;
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Currency Code" := Surrender."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                //Take care of Currency Factor
                GenJnlLine."Currency Factor" := Surrender."Currency Factor";
                GenJnlLine.VALIDATE("Currency Factor");

                GenJnlLine."Shortcut Dimension 1 Code" := Surrender."Global Dimension 1 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                //   GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");

                //Application of Surrender entries
                IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer THEN BEGIN
                    //GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                    GenJnlLine."Applies-to Doc. No." := Surrender."PV No";
                    GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                    GenJnlLine."Applies-to ID" := Surrender."Apply to ID";


                END;

                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT(True);
                ImprestReq.reset;
                ImprestReq.SetRange("No.", Surrender.No);
                if ImprestReq.find('-') then begin
                    ImprestReq."Interest Charged" := true;
                    ImprestReq."Interest Amount" := ImprestDetails."Acc interest Amount";
                end;


            end;*/

            //Post Cash Surrender
            /*IF ImprestDetails."Cash Receipt Amount" > 0 THEN BEGIN
                IF ImprestDetails."Bank/Petty Cash" = '' THEN
                    //ERROR('Select a Bank Code where the Cash Surrender will be posted');
                LineNo := LineNo + 1000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := GenledSetup."Surrender Template";
                GenJnlLine."Journal Batch Name" := GenledSetup."Surrender  Batch";
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                GenJnlLine."Account No." := ImprestDetails."Imprest Holder";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                //Set these fields to blanks
                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine.VALIDATE("Gen. Posting Type");
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine.VALIDATE("Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine.VALIDATE("Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := '';
                GenJnlLine.VALIDATE("VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := '';
                GenJnlLine.VALIDATE("VAT Prod. Posting Group");
                GenJnlLine."Posting Date" := Rec."Surrender Date";
                GenJnlLine."Document No." := Rec.No;
                GenJnlLine.Amount := -ImprestDetails."Cash Receipt Amount";
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Currency Code" := Rec."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                //Take care of Currency Factor
                GenJnlLine."Currency Factor" := Rec."Currency Factor";
                GenJnlLine.VALIDATE("Currency Factor");

                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
                GenJnlLine."Bal. Account No." := ImprestDetails."Bank/Petty Cash";
                GenJnlLine.Description := 'Imprest Surrender by staff';
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to ID" := ImprestDetails."Imprest Holder";

                //Application of Surrender entries
                IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer THEN BEGIN
                    //GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                    GenJnlLine."Applies-to Doc. No." := Rec."PV No";
                    GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                    GenJnlLine."Applies-to ID" := Rec."Apply to ID";

                    IF GenJnlLine.Amount <> 0 THEN
                        GenJnlLine.INSERT(True);

                END;
            END;*/
            //End Post Surrender Journal

            UNTIL ImprestDetails.NEXT = 0;
            //Post Entries
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", GenledSetup."Surrender Template");
            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", GenledSetup."Surrender  Batch");
            //Adjust Gen Jnl Exchange Rate Rounding Balances
            AdjustGenJnl.RUN(GenJnlLine);
            //End Adjust Gen Jnl Exchange Rate Rounding Balances

            //GenerateReceipt();
            // Message('Available');
            CODEUNIT.RUN(CODEUNIT::"Modified Gen. Jnl.-Post", GenJnlLine);
        END;

        //IF JournalPostSuccessful.PostedSuccessfully THEN BEGIN
        Surrender.Posted := TRUE;
        Surrender.Status := Surrender.Status::Posted;
        Surrender."Date Posted" := TODAY;
        Surrender."Time Posted" := TIME;
        Surrender."Posted By" := USERID;
        Surrender.MODIFY;
        //Tag the Source Imprest Requisition as Surrendered
        ImprestReq.RESET;
        ImprestReq.SETRANGE(ImprestReq."No.", Surrender."Imprest Issue Doc. No");
        IF ImprestReq.FIND('-') THEN BEGIN
            ImprestReq."Surrender Status" := ImprestReq."Surrender Status"::Full;
            ImprestReq.MODIFY;
        END;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterInsertEvent, '', false, false)]
    local procedure InsertToArchive(var Rec: Record "Gen. Journal Line")
    var
        JnlArchive: Record "General Journal Archive";
        rpt: Report 2;
        jnlarchive2: Record "General Journal Archive";
    begin
        JnlArchive.Init();
        JnlArchive.TransferFields(Rec);
        jnlarchive2.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        jnlarchive2.SetRange("Journal Template Name", Rec."Journal Template Name");
        jnlarchive2.SetRange("Line No.", Rec."Line No.");
        if not jnlarchive2.Find('-') then begin
            JnlArchive.Insert();
        end;
    end;

}
