page 52148 "Journal Voicher Card"
{
    Caption = 'Journal Voicher Card';
    PageType = Card;
    SourceTable = "Journal Voucher Headder";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
                    trigger OnValidate()
                    begin
                        //  UpdateLines();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.', Comment = '%';
                    trigger OnValidate()
                    begin
                        //  UpdateLines();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference No. field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Posted "; Rec."Posted ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
            }
            part(lines; "Journal Vouchder Line")
            {
                SubPageLink = "Docuument No" = field("No.");

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = all;
                Image = Post;
                trigger OnAction()
                begin
                    if rec."Posted " then
                        error('Journal Voucher Already Posted');
                    posttojournal(Rec);
                    Rec."Posted " := TRUE;
                    Rec.MODIFY();


                end;

            }
            action("Reverse Journal")
            {
                ApplicationArea = all;
                Image = Reverse;
                trigger OnAction()
                begin
                    // if rec."Posted " then
                    //     error('Journal Voucher Already Posted');
                    ReverseJournal(Rec);
                    // Rec."Posted " := true;
                    // Rec.MODIFY();
                end;

            }
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                //  Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Request approval of the document.';

                trigger OnAction()
                var
                //ApprovalsMgmt: Codeunit "Workflow Management Handler";
                begin
                    // if ApprovalsMgmt.CheckJournalVoucherApprovalPossible(Rec) then
                    //  ApprovalsMgmt.OnSendJournalVoucerDocForApproval(Rec);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                //Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category9;
                ToolTip = 'Cancel the approval request.';

                trigger OnAction()
                var


                begin
                    // ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    // WorkflowWebhookMgt.FindAndCancel(RecordId);
                end;
            }

        }
    }

    var
        // ApprovalsMgmt: Codeunit "Approvals Management";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        //ApprovalsMgmt: Codeunit "Workflow Management Handler";
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
        BCSetup: Record "FIN-Budgetary Control Setup";
        FINBudgetEntries: Record "FIN-Budget Entries";
        JournalLine: Record "Journal Voucher Lines";
        PvLine: Record "Journal Voucher Lines";
        DefaultBatch: Record 232;
        JTemplate: code[20];
        JournalLine2: Record "Journal Voucher Lines";
        JBatch: code[20];
        Temp: Record "FIN-Cash Office User Template";
        CashierLinks: Record "FIN-Cash Office User Template";
        LastItem: Integer;
        Cashoffice: record "Cash Office Setup";
        GenLine: Record "Gen. Journal Line";
        lineno: Integer;

    procedure commitbudget()
    begin
        BCSetup.GET;
        //IF NOT ((BCSetup.Mandatory) AND (BCSetup."PV Budget Mandatory")) THEN EXIT;
        IF NOT ((BCSetup.Mandatory)) THEN EXIT;
        //BCSetup.TESTFIELD("Current Budget Code");
        //Rec.TESTFIELD("Shortcut Dimension 2 Code");
        //Get Current Lines to loop through
        JournalLine.RESET;
        JournalLine.SETRANGE("Docuument No", Rec."No.");
        JournalLine.SETRANGE("Account Type", JournalLine."Account Type"::"G/L Account");
        //JournalLine.SetRange("Account No", JournalLine."Account No");
        //JournalLine.SetRange("Line No", JournalLine."Line No");
        JournalLine.SETRANGE("Processed", FALSE);


        IF JournalLine.FIND('-') THEN BEGIN
            if JournalLine.Amount > 0 THEN BEGIN
                REPEAT

                BEGIN
                    // Check if budget exists
                    JournalLine.TESTFIELD("Account No");
                    GLAccount.RESET;
                    GLAccount.SETRANGE("No.", JournalLine."Account No");
                    IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                    DimensionValue.RESET;
                    // DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
                    // DimensionValue.SETRANGE("Global Dimension No.", 2);
                    DimensionValue.SetRange(Code, Rec."Global Dimension 1 Code");
                    DimensionValue.SETRANGE("Global Dimension No.", 2);
                    IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
                    FINBudgetEntries.RESET;
                    FINBudgetEntries.SETRANGE("Budget Name", BCSetup."Current Budget Code");
                    FINBudgetEntries.SETRANGE("G/L Account No.", JournalLine."Account No");
                    FINBudgetEntries.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    FINBudgetEntries.SETFILTER("Transaction Type", '%1|%2|%3', FINBudgetEntries."Transaction Type"::Expense,
                     FINBudgetEntries."Transaction Type"::Commitment, FINBudgetEntries."Transaction Type"::Allocation);
                    FINBudgetEntries.SETFILTER("Commitment Status", '%1|%2|%3', FINBudgetEntries."Commitment Status"::" ", FINBudgetEntries."Commitment Status"::"Commited/Posted",
                   FINBudgetEntries."Commitment Status"::Commitment);
                    // FINBudgetEntries.SETFILTER("Commitment Status", '%1|%2|%3', FINBudgetEntries."Commitment Status"::Cancelled,
                    // FINBudgetEntries."Commitment Status"::"Commited/Posted", FINBudgetEntries."Commitment Status"::Commitment);
                    //  FINBudgetEntries.setrange(Date, PostBudgetEnties.GetBudgetStartDate(Rec."Document Date"), PostBudgetEnties.GetBudgetEndDate(Rec."Document Date"));
                    IF FINBudgetEntries.FIND('-') THEN BEGIN
                        IF FINBudgetEntries.CALCSUMS(Amount) THEN BEGIN
                            IF FINBudgetEntries.Amount > 0 THEN BEGIN
                                IF (JournalLine.Amount > FINBudgetEntries.Amount) THEN ERROR('Less Funds, Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
                                // PostBudgetEnties.CheckBudgetAvailability(JournalLine."Account No", Rec."Document Date", Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code",
                                //JournalLine.Amount, JournalLine."Account Name", 'Jv', Rec."No." + JournalLine."Account No", Rec.Description);
                            END ELSE
                                ERROR('No allocation for  Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
                        END;
                    END ELSE
                        IF PostBudgetEnties.checkBudgetControl(JournalLine."Account No") THEN
                            ERROR('Missing Budget for  Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
                END;



                UNTIL JournalLine.NEXT = 0;

            END;


        end;
    end;

    procedure cancelcommitbudget()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT (BCSetup.Mandatory) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        Rec.TESTFIELD("Shortcut Dimension 2 Code");

        JournalLine.SETRANGE("Docuument No", Rec."No.");
        //  JournalLine.SetRange("Account No", JournalLine."Account No");
        //JournalLine.SetRange("Line No", JournalLine."Line No");
        JournalLine.SETRANGE("Account Type", JournalLine."Account Type"::"G/L Account");
        JournalLine.SETRANGE("Processed", FALSE);


        IF JournalLine.FIND('-') THEN BEGIN
            if JournalLine.Amount < 0 THEN BEGIN
                REPEAT
                BEGIN
                    // Expense Budget Here
                    JournalLine.TESTFIELD("Account No");
                    GLAccount.RESET;
                    GLAccount.SETRANGE("No.", JournalLine."Account No");
                    IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
                    DimensionValue.SETRANGE("Global Dimension No.", 2);
                    IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);


                    // PostBudgetEnties.CheckBudgetAvailability(JournalLine."Account No", Rec."Document Date", Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code",
                    //  JournalLine.Amount * -1, JournalLine."Account Name", 'Jv', Rec."No." + JournalLine."Account No", Rec.Description);

                END;
                UNTIL JournalLine.NEXT = 0;
            END;
        end;
    end;

    local procedure posttojournal(VourcherHeader: Record "Journal Voucher Headder")
    begin


        GenLine.RESET;
        GenLine.SetRange("Journal Template Name", 'GENERAL');
        GenLine.SetRange("Journal Batch Name", 'DEFAULT');
        IF GenLine.FindSet() THEN begin
            GenLine.DeleteAll();

        end;

        JournalLine.RESET;
        JournalLine.SETRANGE("Docuument No", VourcherHeader."No.");
        JournalLine.SETRANGE("Processed", FALSE);


        IF JournalLine.FindSet() THEN BEGIN
            REPEAT
            BEGIN
                // JournalLine2.RESET;
                // JournalLine2.SETRANGE("Line No", JournalLine."Line No");
                // // JournalLine2.SetRange("Posting Date", JournalLine."Posting Date");
                // if JournalLine2.FindSet() then begin
                //     // JournalLine2.TestField(externalDocumentNo);
                //     // JournalLine2.TestField("Account No");

                lineno := lineno + 10000;
                GenLine.INIT;
                GenLine."Journal Template Name" := 'GENERAL';
                GenLine."Journal Batch Name" := 'DEFAULT';
                GenLine."Line No." := lineno;
                GenLine."Document No." := JournalLine."Reference No";
                GenLine."Document Type" := JournalLine."Document Type";
                GenLine."Account Type" := JournalLine."Account Type";
                GenLine."Posting Date" := JournalLine."Posting Date";
                GenLine."User ID" := UserId;
                GenLine."Account No." := JournalLine."Account No";
                GenLine.Validate("Account No.");
                GenLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                GenLine."Description" := CopyStr(JournalLine."Description", 1, 100);
                GenLine."External Document No." := JournalLine.externalDocumentNo;
                GenLine."Amount" := JournalLine.Amount;
                GenLine."Bal. Account Type" := JournalLine."Bal. Account Type";
                GenLine."Bal. Account No." := JournalLine."Balancing Account No";
                GenLine.Validate("Bal. Account No.");
                GenLine.VALIDATE("Amount");
                GenLine.INSERT(); // Insert the line into the database
            END;
            JournalLine.processed := TRUE;
            JournalLine.Modify();


            UNTIL JournalLine.NEXT() = 0;


            rec."Posted " := TRUE;
            rec.MODIFY();

        end;
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenLine);
        /* if rec."Posted " then
             error('Journal Voucher Already Posted');
         JournalLine.RESET;
         JournalLine.SETRANGE("Docuument No", Rec."No.");

         IF JournalLine.FindSet() THEN BEGIN
             JournalLine2.RESET;
             JournalLine2.SETRANGE("Line No", JournalLine."Line No");
             // JournalLine2.SetRange("Posting Date", JournalLine."Posting Date");
             if JournalLine2.FindSet() then begin
                 lineno := 10000;
                 REPEAT
                 BEGIN
                     lineno := lineno + 10000;
                     GenLine.INIT;
                     GenLine."Journal Template Name" := 'GENERAL';
                     GenLine."Journal Batch Name" := 'DEFAULT';
                     GenLine."Line No." := lineno;

                     GenLine."Document No." := Rec."No.";
                     GenLine."Document Type" := JournalLine2."Document Type";
                     GenLine."Posting Date" := JournalLine2."Posting Date";
                     GenLine."Account Type" := JournalLine2."Account Type";
                     GenLine."Account No." := JournalLine2."Account No";
                     GenLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                     // GenLine."Shortcut Dimension 1 Code":=JournalLine."Global Dimension 1 Code;
                     // GenLine."Global Dimension 2 Code" := Rec."Global Dimension 2 Code;
                     GenLine."Description" := JournalLine2."Description";
                     GenLine."Amount" := JournalLine2.Amount;
                     GenLine.VALIDATE("Amount");
                     // GenLine."Amount LCY" := JournalLine.Amount;
                     // GenLine."Currency Code" := JournalLine."Currency Code";
                     // GenLine."Currency Factor" := JournalLine."Currency Factor";
                     GenLine."Bal. Account Type" := GenLine."Account Type"::"G/L Account";
                     // GenLine."Bal. Account No." := JournalLine."Bal. Account No";
                     // GenLine."Bal. Account Name" := JournalLine."Bal. Account Name";
                     // GenLine."Bal. Account Category" := JournalLine."Bal. Account Category";
                     // GenLine."Bal. Account Type" := JournalLine."Bal. Account Type";
                     GenLine."Bal. Account No." := JournalLine2."Balancing Account No";
                     GenLine.Insert()


                 end;
                 UNTIL JournalLine2.NEXT = 0;


                 JournalLine2.processed := TRUE;
                 JournalLine2.Modify();
             end;
             REC."Posted " := TRUE;
             REC.MODIFY;

         end;*/
    end;

    procedure ReverseJournal(PayHeader: record "Journal Voucher Headder")
    var
        bankledgerentry: Record "G/L Entry";
        bankledgerentrypage: Page "General Ledger Entries";
        ReversalEntry: Record "Reversal Entry";
    begin
        bankledgerentry.RESET;
        bankledgerentry.SETRANGE("Document No.", PayHeader."No.");
        // bankledgerentry.SetRange("Bank Account No.", PayHeader."Bank Code");
        // bankledgerentry.SetRange("Posting Date", PayHeader.Date);
        IF bankledgerentry.FINDFIRST THEN BEGIN
            ReversalEntry.Reset();
            Clear(ReversalEntry);
            if bankledgerentry.Reversed then
                Error('Transaction Already Reversed');
            if bankledgerentry."Journal Batch Name" = '' then
                ReversalEntry.TestFieldError;
            bankledgerentry.TestField("Transaction No.");
            ReversalEntry.ReverseTransaction(bankledgerentry."Transaction No.");

            PayHeader.Reversed := true;
            PayHeader."Reversed By" := USERID;
            PayHeader."Reversed Date" := TODAY;
            PayHeader.Modify();


        END;

    end;
}





