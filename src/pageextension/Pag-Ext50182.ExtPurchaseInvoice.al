pageextension 50182 "ExtPurchase Invoice" extends "Purchase Invoice"
{
    layout
    {
        modify("Buy-from")
        {
            Visible = false;
        }
        addafter("Buy-from Vendor Name")
        {
            field("Department"; Rec."Shortcut Dimension 1 Code")
            {
                Importance = Promoted;
                ApplicationArea = Dimensions;
                ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                trigger OnValidate()
                begin
                    ShortcutDimension1CodeOnAfterV;
                end;
            }
        }
    }
    actions
    {
        modify(CancelApprovalRequest)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                CancelCommitment();
            end;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            begin
                //Rec."Shortcut Dimension 1 Code" := 'Administration';
                Rec.Modify();
                CommitBudget();
            end;
        }
        modify(Post)
        {
            trigger OnAfterAction()
            begin
                ExpenseBudget();
            end;
        }
        addbefore(Post)
        {
            action("Update Posting Group")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                var
                    gl: Record "G/L Account";
                    purheader: Record "Purchase Header";
                    purLine: Record "Purchase Line";
                begin
                    purLine.Reset();
                    purLine.SetRange("Document No.", Rec."No.");
                    if purLine.Find('-') then begin
                        repeat
                            gl.Reset();
                            gl.SetRange("No.", purLine."No.");
                            if gl.Find('-') then begin
                                purLine."Gen. Bus. Posting Group" := gl."Gen. Bus. Posting Group";
                                purLine."Gen. Prod. Posting Group" := gl."Gen. Prod. Posting Group";
                                purLine.Modify();
                            end;
                        until purLine.Next() = 0;
                        Message('Updated Successfully');
                    end;

                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Assigned User ID" := UserId;
        rec."Assigned User ID 2" := UserId;
        rec."User Id" := UserId;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec."Assigned User ID" := UserId;
        rec."Assigned User ID 2" := UserId;
        rec."User Id" := UserId;
    end;

    procedure CommitBudget()
    var
        Bdgt: Code[50];
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.reset;
        if BCSetup.Find('-') then
            Bdgt := BCSetup."Current Budget Code";
        BCSetup.TESTFIELD("Current Budget Code");
        // Rec.TESTFIELD("Shortcut Dimension 1 Code");
        //Get Current Lines to loop through
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document No.", Rec."No.");
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETFILTER(Type, '%1|%2|%3', PurchaseLine.Type::Item, PurchaseLine.Type::"Fixed Asset", PurchaseLine.Type::"G/L Account");
        IF PurchaseLine.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                // Check if budget exists
                CLEAR(GLAccountz);
                PurchaseLine.TESTFIELD("No.");
                IF PurchaseLine.Type = PurchaseLine.Type::Item THEN BEGIN
                    Item.RESET;
                    Item.SETRANGE("No.", PurchaseLine."No.");
                    IF Item.FIND('-') THEN;
                    Item.TESTFIELD("Item G/L Budget Account");
                    GLAccountz := Item."Item G/L Budget Account";
                END ELSE
                    IF PurchaseLine.Type = PurchaseLine."Type"::"Fixed Asset" THEN BEGIN
                        FixedAsset.RESET;
                        FixedAsset.SETRANGE("No.", PurchaseLine."No.");
                        IF FixedAsset.FIND('-') THEN BEGIN
                            FixedAsset.TESTFIELD("FA Posting Group");
                            FAPostingGroup.RESET;
                            FAPostingGroup.SETRANGE(Code, FixedAsset."FA Posting Group");
                            IF FAPostingGroup.FIND('-') THEN BEGIN
                                FAPostingGroup.TESTFIELD("Acquisition Cost Account");
                                GLAccountz := FAPostingGroup."Acquisition Cost Account";
                            END;
                        END;
                    END ELSE
                        IF PurchaseLine.Type = PurchaseLine.Type::"G/L Account" THEN BEGIN
                            GLAccountz := PurchaseLine."No.";
                        END;
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", GLAccountz);
                IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                DimensionValue.RESET;


                FINBudgetEntries.RESET;
                FINBudgetEntries.SETRANGE("Budget Name", BCSetup."Current Budget Code");
                FINBudgetEntries.SETRANGE("G/L Account No.", GLAccountz);
                FINBudgetEntries.SETRANGE("Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                FINBudgetEntries.SETRANGE("Global Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                // FINBudgetEntries.SETRANGE("Budget Dimension 3 Code", Rec."Shortcut Dimension 3 Code");
                // FINBudgetEntries.SETRANGE("Budget Dimension 4 Code", Rec."Shortcut Dimension 4 Code");
                FINBudgetEntries.SETFILTER("Transaction Type", '%1|%2|%3', FINBudgetEntries."Transaction Type"::Expense, FINBudgetEntries."Transaction Type"::Commitment
                , FINBudgetEntries."Transaction Type"::Allocation);
                FINBudgetEntries.SETFILTER("Commitment Status", '%1|%2',
                FINBudgetEntries."Commitment Status"::" ", FINBudgetEntries."Commitment Status"::Commitment);
                FINBudgetEntries.SETFILTER(Date, PostBudgetEnties.GetBudgetStartAndEndDates(Rec."Order Date"));
                IF FINBudgetEntries.FIND('-') THEN BEGIN
                    IF checkBudgetControl(FINBudgetEntries."G/L Account No.") = FALSE THEN EXIT;
                    IF FINBudgetEntries.CALCSUMS(Amount) THEN BEGIN
                        IF FINBudgetEntries.Amount > 0 THEN BEGIN
                            IF (PurchaseLine."Line Amount" > FINBudgetEntries.Amount) THEN ERROR('Less Funds, Account:' + GLAccount.Name);
                            // Commit Budget Here
                            //PostBudgetEnties.CheckBudgetAvailability(GLAccountz, Rec."Order Date", rec."Shortcut Dimension 1 Code", rec."Shortcut Dimension 2 Code", rec."Shortcut Dimension 3 Code", rec."Shortcut Dimension 4 Code",
                            //PurchaseLine."Line Amount", PurchaseLine.Description, 'Invoice', Rec."No." + PurchaseLine."No.", PurchaseLine."Description 2",rec."Buy-from Vendor Name");
                        END ELSE
                            ERROR('No allocation for  Account:' + GLAccount.Name);
                    END;
                END;
            END;
            UNTIL PurchaseLine.NEXT = 0;
        END;
    end;

    procedure checkBudgetControl(var glAcc: Code[20]) IsBudgetControlled: Boolean
    var
        GLAccount: Record "G/L Account";
    begin
        CLEAR(IsBudgetControlled);
        GLAccount.RESET;
        GLAccount.SETRANGE("No.", glAcc);
        IF GLAccount.FIND('-') THEN;
        IF GLAccount."Budget Controlled" THEN;
        IsBudgetControlled := GLAccount."Budget Controlled";
        //ELSE ERROR('Missing account');
    end;

    local procedure ExpenseBudget()
    var
        Bdgt: Code[50];
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.reset;
        if BCSetup.Find('-') then
            Bdgt := BCSetup."Current Budget Code";
        //Get Current Lines to loop through
        PurchaseLine.SETRANGE("Document No.", Rec."No.");
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETFILTER(Type, '%1|%2|%3', PurchaseLine.Type::Item, PurchaseLine.Type::"Fixed Asset", PurchaseLine.Type::"G/L Account");
        IF PurchaseLine.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                // Expense Budget Here
                CLEAR(GLAccountz);
                PurchaseLine.TESTFIELD("No.");
                IF PurchaseLine.Type = PurchaseLine.Type::Item THEN BEGIN
                    Item.RESET;
                    Item.SETRANGE("No.", PurchaseLine."No.");
                    IF Item.FIND('-') THEN;
                    Item.TESTFIELD("Item G/L Budget Account");
                    GLAccountz := Item."Item G/L Budget Account";
                END ELSE
                    IF PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" THEN BEGIN
                        FixedAsset.RESET;
                        FixedAsset.SETRANGE("No.", PurchaseLine."No.");
                        IF FixedAsset.FIND('-') THEN BEGIN
                            FixedAsset.TESTFIELD("FA Posting Group");
                            FAPostingGroup.RESET;
                            FAPostingGroup.SETRANGE(Code, FixedAsset."FA Posting Group");
                            IF FAPostingGroup.FIND('-') THEN BEGIN
                                FAPostingGroup.TESTFIELD("Acquisition Cost Account");
                                GLAccountz := FAPostingGroup."Acquisition Cost Account";
                            END;
                        END;
                    END ELSE
                        IF PurchaseLine.Type = PurchaseLine.Type::"G/L Account" THEN BEGIN
                            GLAccountz := PurchaseLine."No.";
                        END;
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", GLAccountz);
                IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 1 Code");
                //DimensionValue.SETRANGE("Global Dimension No.", 2);
                IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
                IF (PurchaseLine."Line Amount" > 0) THEN BEGIN
                    // Commit Budget Here
                    // PostBudgetEnties.ExpenseBudget(GLAccountz, Rec."Order Date", PurchaseLine."Shortcut Dimension 1 Code", PurchaseLine."Shortcut Dimension 2 Code", PurchaseLine."Shortcut Dimension 3 Code", PurchaseLine."Shortcut Dimension 4 Code",
                    // PurchaseLine."Line Amount", PurchaseLine.Description, USERID, TODAY, 'Invoice', Rec."No." + PurchaseLine."No.", PurchaseLine."Description 2");
                END;
            END;
            UNTIL PurchaseLine.NEXT = 0;
        END;
    end;

    local procedure CancelCommitment()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT BCSetup.Mandatory THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");

        //Get Current Lines to loop through
        PurchaseLine.SETRANGE("Document No.", Rec."No.");
        IF PurchaseLine.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                // Expense Budget Here
                PurchaseLine.TESTFIELD("No.");
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", PurchaseLine."No.");
                IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
                DimensionValue.SETRANGE("Global Dimension No.", 2);
                IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
                IF (PurchaseLine.Amount > 0) THEN BEGIN
                    // Commit Budget Here
                    //  PostBudgetEnties.CancelBudgetCommitment(PurchaseLine."No.", Rec."Document Date", PurchaseLine."Shortcut Dimension 1 Code", PurchaseLine."Shortcut Dimension 2 Code", PurchaseLine."Shortcut Dimension 3 Code", PurchaseLine."Shortcut Dimension 4 Code",
                    //  PurchaseLine.Amount, PurchaseLine.Description, USERID, 'INVOICE', Rec."No." + PurchaseLine."No.", PurchaseLine.Description);
                END;
            END;
            UNTIL PurchaseLine.NEXT = 0;
        END;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update();
    end;

    var
        BCSetup: Record "FIN-Budgetary Control Setup";
        FINBudgetEntries: Record "FIN-Budget Entries";
        PurchaseLine: Record "Purchase Line";
        GLAccountz: Code[20];
        FixedAsset: Record "Fixed Asset";
        item: Record Item;
        FAPostingGroup: Record "FA Posting Group";
}