/// <summary>
/// Page PROC-Store Req. Header (B) (ID 52178503).
/// </summary>
page 52178503 "PROC-Store Req. Header (B)"
{
    PageType = Card;
    SourceTable = "PROC-Store Requistion Header";
    PromotedActionCategories = 'New,Process,Report,Approvals';


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = all;
                    //OptionCaption = 'Stationery,Grocery,Project,Cleaning,Hardware,Others,Food-Stuff,Hardware Materials,Drugs';
                }
                field("Request date"; Rec."Request date")
                {
                    ApplicationArea = all;
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Function Name"; Rec."Function Name")
                {
                    ApplicationArea = all;
                    Caption = 'Directorate Name';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    ApplicationArea = all;
                    Caption = 'Department Name';
                    Editable = false;
                }



                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = all;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = all;

                    HideValue = false;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("Issuing Store"; Rec."Issuing Store")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("SRN.No"; Rec."SRN.No")
                {
                    Visible = false;
                    ApplicationArea = all;
                }

                field("User ID"; Rec."User ID")
                {
                    Caption = 'Requestor';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(Issuer; Rec.Issuer)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Issuer field.';
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = all;
                }

            }
            group("Request Description")
            {
                field("Request Description1"; Rec."Request Description")
                {
                    ShowCaption = false;
                    ApplicationArea = all;
                }
            }
            group("Remarks")
            {
                field(Remarks1; Rec.Remarks)
                {
                    ShowCaption = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
            group(Lines)
            {
                Caption = 'Lines';
                part(page; "PROC-Store Requisition Line UP")
                {
                    ApplicationArea = all;
                    SubPageLink = "Requistion No" = FIELD("No.");//, "Shortcut Dimension 1 Code" = field("Global Dimension 1 Code"),
                    // "Shortcut Dimension 2 Code" = field("Shortcut Dimension 2 Code"), "Issuing Store" = field("Issuing Store");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {


            action("Post Store Requisition")
            {
                ApplicationArea = all;
                Caption = 'Post Store Requisition';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    items: Record Item;
                begin

                    IF NOT LinesExists THEN
                        ERROR('There are no Lines created for this Document');

                    IF Rec.Status = Rec.Status::Posted THEN
                        ERROR('The Document Has Already been Posted');

                    IF Rec.Status <> Rec.Status::Released THEN
                        ERROR('The Document Has not yet been Approved');
                    // TESTFIELD("Issuing Store");
                    ReqLine.RESET;
                    ReqLine.SETRANGE(ReqLine."Requistion No", Rec."No.");
                    IF ReqLine.FIND('-') THEN BEGIN
                        IF InventorySetup.GET THEN BEGIN
                            //  ERROR('1');
                            InventorySetup.TESTFIELD(InventorySetup."Item Issue Template");
                            InventorySetup.TESTFIELD(InventorySetup."Item Issue Batch");
                            GenJnline.RESET;
                            GenJnline.SETRANGE(GenJnline."Journal Template Name", InventorySetup."Item Issue Template");
                            GenJnline.SETRANGE(GenJnline."Journal Batch Name", InventorySetup."Item Issue Batch");
                            IF GenJnline.FIND('-') THEN GenJnline.DELETEALL;
                        END;
                        REPEAT
                        BEGIN
                            //Issue
                            LineNo := LineNo + 1000;
                            GenJnline.INIT;
                            GenJnline."Journal Template Name" := InventorySetup."Item Issue Template";
                            GenJnline."Journal Batch Name" := InventorySetup."Item Issue Batch";
                            GenJnline."Line No." := LineNo;
                            GenJnline."Entry Type" := GenJnline."Entry Type"::"Negative Adjmt.";
                            GenJnline."Document No." := Rec."No.";
                            GenJnline."Item No." := ReqLine."No.";
                            GenJnline.VALIDATE("Item No.");
                            GenJnline."Location Code" := ReqLine."Issuing Store";
                            GenJnline.VALIDATE("Location Code");
                            GenJnline."Posting Date" := Rec."Request date";
                            /// GenJnline."Posting Date" := 20240630D;
                            GenJnline.Description := ReqLine.Description;
                            items.Reset;
                            items.SetRange("No.", ReqLine."No.");
                            if items.Find('-') then
                                GenJnline."Gen. Prod. Posting Group" := items."Gen. Prod. Posting Group";
                            //GenJnline.Quantity:=ReqLine.Quantity;
                            GenJnline."Unit Cost" := ReqLine."Unit Cost";
                            GenJnline."Unit Amount" := ReqLine."Unit Cost";
                            GenJnline.Quantity := ReqLine."Quantity To Issue";
                            GenJnline.VALIDATE(Quantity);
                            GenJnline.VALIDATE("Unit Cost");
                            GenJnline."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                            GenJnline.VALIDATE("Shortcut Dimension 1 Code");
                            GenJnline."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                            GenJnline.VALIDATE("Shortcut Dimension 2 Code");
                            GenJnline.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                            GenJnline.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

                            GenJnline."Reason Code" := 'STOCK';
                            // GenJnline.VALIDATE("Reason Code");
                            GenJnline.VALIDATE("Item No.");
                            if GenJnline.Quantity <> 0 then
                                GenJnLine.INSERT(True);
                            ReqLine."Quantity Issued" := ReqLine."Quantity Issued" + ReqLine."Quantity To Issue";
                            ReqLine."Quantity To Issue" := 0;
                            IF ReqLine."Quantity Issued" = ReqLine."Quantity Requested" THEN
                                ReqLine."Request Status" := ReqLine."Request Status"::Closed;
                            ReqLine.MODIFY;
                        END;
                        UNTIL ReqLine.NEXT = 0;
                        //Post Entries
                        GenJnline.RESET;
                        GenJnline.SETRANGE(GenJnline."Journal Template Name", InventorySetup."Item Issue Template");
                        GenJnline.SETRANGE(GenJnline."Journal Batch Name", InventorySetup."Item Issue Batch");
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", GenJnline);
                        //End Post entries
                        //Modify All
                        Post := JournlPosted.PostedSuccessfully();
                        IF Post THEN
                            ReqLine.MODIFYALL(ReqLine."Request Status", ReqLine."Request Status"::Closed);
                    END ELSE
                        ERROR('Check quantity to issue against  quantity in store');
                    Post := TRUE;
                    ReqLine.RESET;
                    ReqLine.SETRANGE(ReqLine."Requistion No", Rec."No.");
                    IF ReqLine.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            IF ReqLine."Quantity Issued" <> ReqLine."Quantity Requested" THEN
                                IF (Post = TRUE) THEN
                                    Post := FALSE;
                        END;
                        UNTIL ReqLine.NEXT = 0;
                    END;
                    IF Post = TRUE THEN BEGIN
                        Rec.Status := Rec.Status::Posted;
                        rec.Issuer := UserId;
                        Rec.MODIFY;
                        ExpenseBudget();
                        RequisitionMgnt.CheckItemReorderLevel(Rec."No.");
                    END;
                    // CurrPage.UPDATE;

                end;
            }
            separator(swep)
            {
            }

            action(sendApproval)
            {
                ApplicationArea = all;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest; 
                Promoted = true;
                PromotedCategory = category4;
                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approval Workflows V1";
                    variant: Variant;
                    Text000: Label 'Are you sure you want to send for approval?';
                begin
                    IF NOT LinesExists THEN
                        ERROR('There are no Lines created for this Document');
                    variant := Rec;
                    IF ApprovalMgt.CheckApprovalsWorkflowEnabled(variant) THEN BEGIN
                        ApprovalMgt.OnSendDocForApproval(variant);
                        CommitBudget();
                    END ELSE
                        ;

                end;
            }
            action(Approvals)
            {
                ApplicationArea = All;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = category4;
                RunObject = page "Fin-Approval Entries";
                RunPageLink = "Document No." = field("No.");
            }
            action(cancellsApproval)
            {
                ApplicationArea = all;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = category4;
                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approval Workflows V1";
                    variant: Variant;
                begin
                    variant := Rec;
                    ApprovalMgt.OnCancelDocApprovalRequest(variant);
                    CancelCommitment();
                end;
            }

            action("Print/Preview")
            {
                ApplicationArea = all;
                Caption = 'Print';
                Image = PreviewChecks;
                Promoted = true;
                PromotedCategory = report;

                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SETFILTER("No.", Rec."No.");
                    REPORT.RUN(Report::"Store Requisition", TRUE, TRUE, Rec);
                    Rec.RESET;
                end;
            }


        }
    }


    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec."User ID" := USERID;

    end;

    trigger OnModifyRecord(): Boolean
    begin
        if rec.Status = rec.Status::Posted then Error('The document is already posted');
    end;

    trigger OnOpenPage()
    begin
        /* IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END; */
        IF QtyStore.GET(Rec."No.") THEN
            QtyStore.CALCFIELDS(QtyStore.Inventory);

    end;

    var
        UserMgt: Codeunit "User Setup Management BR";

        ApprovalMgt: Codeunit "Export F/O Consolidation";
        ReqLine: Record "PROC-Store Requistion Lines";
        InventorySetup: Record "Inventory Setup";
        GenJnline: Record "Item Journal Line";
        LineNo: Integer;
        Post: Boolean;
        JournlPosted: Codeunit "Journal Post Successful";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        FixedAsset: Record "Fixed Asset";
        //MinorAssetsIssue: Record 61725;
        Commitment: Codeunit "Budgetary Control";
        BCSetup: Record "FIN-Budgetary Control Setup";
        DeleteCommitment: Record "FIN-Committment";
        Loc: Record Location;
        ApprovalEntries: Page "Fin-Approval Entries";
        FINBudgetEntries: Record "FIN-Budget Entries";
        PROCStoreRequistionHeader: Record "PROC-Store Requistion Header";
        PROCStoreRequistionLines: Record "PROC-Store Requistion Lines";
        Item: Record Item;
        RespCentre: Record "Responsibility Center";
        RequisitionMgnt: Codeunit "Requisition Management";


    procedure LinesExists(): Boolean
    var
        PayLines: Record "PROC-Store Requistion Lines";
    begin
        HasLines := FALSE;
        PayLines.RESET;
        PayLines.SETRANGE(PayLines."Requistion No", Rec."No.");
        IF PayLines.FIND('-') THEN BEGIN
            HasLines := TRUE;
            EXIT(HasLines);
        END;
    end;




    trigger OnAfterGetCurrRecord()
    begin

    end;

    local procedure CommitBudget()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT ((BCSetup.Mandatory) AND (BCSetup."Store Req. Budget Mamndatory")) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        //Get Current Lines to loop through
        PROCStoreRequistionLines.RESET;
        PROCStoreRequistionLines.SETRANGE("Requistion No", Rec."No.");
        IF PROCStoreRequistionLines.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                // Check if budget exists
                PROCStoreRequistionLines.TESTFIELD("No.");
                Item.RESET;
                Item.SETRANGE("No.", PROCStoreRequistionLines."No.");
                IF Item.FIND('-') THEN;
                Item.TESTFIELD("Item G/L Budget Account");
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", Item."Item G/L Budget Account");
                IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
                DimensionValue.SETRANGE("Global Dimension No.", 2);
                IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
                FINBudgetEntries.RESET;
                FINBudgetEntries.SETRANGE("Budget Name", BCSetup."Current Budget Code");
                FINBudgetEntries.SETRANGE("G/L Account No.", Item."Item G/L Budget Account");
                FINBudgetEntries.SETFILTER("Transaction Type", '%1|%2|%3', FINBudgetEntries."Transaction Type"::Expense, FINBudgetEntries."Transaction Type"::Commitment
                , FINBudgetEntries."Transaction Type"::Allocation);
                FINBudgetEntries.SETFILTER("Commitment Status", '%1|%2',
                FINBudgetEntries."Commitment Status"::" ", FINBudgetEntries."Commitment Status"::Commitment);
                FINBudgetEntries.SETFILTER(Date, PostBudgetEnties.GetBudgetStartAndEndDates(Rec."Request date"));
                IF FINBudgetEntries.FIND('-') THEN BEGIN
                    IF FINBudgetEntries.CALCSUMS(Amount) THEN BEGIN
                        IF FINBudgetEntries.Amount > 0 THEN BEGIN
                            IF (PROCStoreRequistionLines."Line Amount" > FINBudgetEntries.Amount) THEN ERROR('Less Funds, Account:' + GLAccount.Name);
                            // Commit Budget Here
                            // PostBudgetEnties.CheckBudgetAvailability(Item."Item G/L Budget Account", Rec."Request date", Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code", Rec."Shortcut Dimension 3 Code", Rec."Shortcut Dimension 4 Code",
                            // PROCStoreRequistionLines."Line Amount", PROCStoreRequistionLines.Description, 'STORE', Rec."No." + PROCStoreRequistionLines."No.", rec."Request Description");
                        END ELSE
                            ERROR('No allocation for  Account:' + GLAccount.Name);
                    END;
                END ELSE
                    ERROR('Missing Budget for  Account:' + GLAccount.Name);
            END;
            UNTIL PROCStoreRequistionLines.NEXT = 0;
        END;
    end;

    local procedure ExpenseBudget()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT ((BCSetup.Mandatory) AND (BCSetup."Store Req. Budget Mamndatory")) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");

        //Get Current Lines to loop through
        PROCStoreRequistionLines.RESET;
        PROCStoreRequistionLines.SETRANGE("Requistion No", Rec."No.");
        IF PROCStoreRequistionLines.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                // Expense Budget Here
                PROCStoreRequistionLines.TESTFIELD("No.");
                Item.RESET;
                Item.SETRANGE("No.", PROCStoreRequistionLines."No.");
                IF Item.FIND('-') THEN;
                Item.TESTFIELD("Item G/L Budget Account");
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", Item."Item G/L Budget Account");
                IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
                DimensionValue.SETRANGE("Global Dimension No.", 2);
                IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
                IF (PROCStoreRequistionLines."Line Amount" > 0) THEN BEGIN
                    // Commit Budget Here
                    // PostBudgetEnties.ExpenseBudget(Item."Item G/L Budget Account", Rec."Request date", Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code", Rec."Shortcut Dimension 3 Code", Rec."Shortcut Dimension 4 Code",
                    // PROCStoreRequistionLines."Line Amount", PROCStoreRequistionLines.Description, USERID, TODAY, 'STORE', Rec."No." + PROCStoreRequistionLines."No.", PROCStoreRequistionLines."Description 2");
                END;
            END;
            UNTIL PROCStoreRequistionLines.NEXT = 0;
        END;
    end;

    local procedure CancelCommitment()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT ((BCSetup.Mandatory) AND (BCSetup."Store Req. Budget Mamndatory")) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");

        //Get Current Lines to loop through
        PROCStoreRequistionLines.RESET;
        PROCStoreRequistionLines.SETRANGE("Requistion No", Rec."No.");
        IF PROCStoreRequistionLines.FIND('-') THEN BEGIN
            REPEAT

                // Expense Budget Here
                PROCStoreRequistionLines.TESTFIELD("No.");
                Item.RESET;
                Item.SETRANGE("No.", PROCStoreRequistionLines."No.");
                IF Item.FIND('-') THEN begin
                    Item.TESTFIELD("Item G/L Budget Account");
                    GLAccount.RESET;
                    GLAccount.SETRANGE("No.", Item."Item G/L Budget Account");
                    IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
                    DimensionValue.SETRANGE("Global Dimension No.", 2);
                    IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
                    IF (PROCStoreRequistionLines."Line Amount" > 0) THEN BEGIN
                        // Commit Budget Here
                        // PostBudgetEnties.CancelBudgetCommitment(Item."Item G/L Budget Account", Rec."Request date", Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code", Rec."Shortcut Dimension 3 Code", Rec."Shortcut Dimension 4 Code",
                        // PROCStoreRequistionLines."Line Amount", PROCStoreRequistionLines.Description, USERID, 'STORE', Rec."No." + PROCStoreRequistionLines."No.", PROCStoreRequistionLines."Description 2");
                    END;
                end;

            UNTIL PROCStoreRequistionLines.NEXT = 0;
        END;
    end;

    trigger OnClosePage()
    begin
        IF QtyStore.GET(Rec."No.") THEN
            QtyStore.CALCFIELDS(QtyStore.Inventory);

    end;



    var
        QtyStore: Record Item;
}

