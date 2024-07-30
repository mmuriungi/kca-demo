page 50125 "Posted Store Requisition"
{
    Caption = 'Posted Store Requisition';
    PageType = Card;
    SourceTable = "PROC-Store Requistion Header";
    SourceTableView = WHERE(Status = FILTER(Posted));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = All;
                    OptionCaption = 'Stationery,Grocery,Project,Cleaning,Hardware,Others,Food-Stuff,Hardware Materials,Drugs';
                }
                field("Request date"; Rec."Request date")
                {
                    ApplicationArea = All;
                }
                field("Required Date"; Rec."Required Date")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Function Name"; Rec."Function Name")
                {
                    Caption = '<Campus Name>';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    Caption = '<Department Name>';
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = true;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Editable = true;
                }
                field(Dim4; Rec.Dim4)
                {
                    Editable = true;
                }
                field("Request Description"; Rec."Request Description")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    HideValue = false;
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field("SRN.No"; Rec."SRN.No")
                {
                    ApplicationArea = All;
                }
                field(Committed; Rec.Committed)
                {
                }
                field("Issuing Store"; Rec."Issuing Store")
                {
                }
            }
            group(Lines)
            {
                Caption = 'Lines';
                part(page; "PROC-Store Requisition Line UP")
                {
                    ApplicationArea = All;
                    SubPageLink = "Requistion No" = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Post Store Requisition")
                {
                    Caption = 'Post Store Requisition';
                    Image = Post;
                    ApplicationArea = All;
                    Promoted = true;

                    trigger OnAction()
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
                        ReqLine.CALCFIELDS(ReqLine."Qty in store");
                        IF (ReqLine."Quantity To Issue" <= ReqLine."Qty in store")
                       THEN
                            ERROR('Quantity in store is less than quantity requested');
                        IF (ReqLine."Qty in store" >= 0)
                         THEN
                            ERROR(' insufficient stock');
                        IF (ReqLine."Quantity To Issue" >= 1)
                         THEN
                            ERROR('Quantity to issue must not be zero');
                        IF (ReqLine."Quantity Requested" <= ReqLine."Qty in store")
                       THEN
                            ERROR('Quantity in store is less than quantity requested');



                        /* ReqLine.SETFILTER(ReqLine."Quantity To Issue",'<=%1',ReqLine."Qty in store");
                      ReqLine.SETFILTER(ReqLine."Qty in store",'>=%1',0);
                     ReqLine.SETFILTER*/



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
                                GenJnline.Description := ReqLine.Description;
                                //GenJnline.Quantity:=ReqLine.Quantity;
                                GenJnline.Quantity := ReqLine."Quantity To Issue";
                                GenJnline."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                GenJnline.VALIDATE("Shortcut Dimension 1 Code");
                                GenJnline."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                GenJnline.VALIDATE("Shortcut Dimension 2 Code");
                                GenJnline.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                                GenJnline.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                                GenJnline.VALIDATE(Quantity);
                                GenJnline.VALIDATE("Unit Amount");
                                GenJnline."Reason Code" := '221';
                                GenJnline.VALIDATE("Reason Code");
                                GenJnline.INSERT(TRUE);

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
                            //
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
                            Rec.MODIFY;
                        END;
                        CurrPage.UPDATE;

                    end;
                }
                separator(swep)
                {
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    ApplicationArea = All;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        DocumentType := DocumentType::Requisition;
                        ApprovalEntries.SetRecordFilters(DATABASE::"PROC-Store Requistion Header", DocumentType, Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action(sendApproval)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Init Code";
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                        tableNo: Integer;
                        Amount: Decimal;
                    begin
                        IF NOT LinesExists THEN
                            ERROR('There are no Lines created for this Document');

                        State := State::Open;
                        IF Rec.Status <> Rec.Status::"Pending Approval" THEN State := State::Open;

                        // DocType := DocType::Requisition;
                        // CLEAR(tableNo);
                        // tableNo := DATABASE::"PROC-Store Requistion Header";
                        // Amount := 0;

                        ApprovalMgt.OnSendSRNforApproval(Rec);//(tableNo, Rec."No.", DocType, State, Rec."Responsibility Center", Amount) THEN;
                    end;
                }
                action(cancellsApproval)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Init Code";
                    // showmessage: Boolean;
                    // ManualCancel: Boolean;
                    // State: Option Open,"Pending Approval",Cancelled,Approved;
                    // DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    // tableNo: Integer;
                    begin
                        // DocType := DocType::Requisition;
                        // showmessage := TRUE;
                        // ManualCancel := TRUE;
                        // CLEAR(tableNo);
                        // tableNo := DATABASE::"PROC-Store Requistion Header";
                        ApprovalMgt.OnCancelSRNforApproval(Rec)//(tableNo, DocType, Rec."No.", showmessage, ManualCancel) THEN;
                    end;
                }
                separator(sep)
                {
                }
                action("Check Budget Availlabilty")
                {
                    Caption = 'Check Budget Availlabilty';
                    Image = Check;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        BCSetup.GET;
                        IF NOT BCSetup.Mandatory THEN
                            EXIT;
                        //IF ("Issuing Store"<>'MAIN') AND ("Issuing Store"<>'GENERAL') THEN ERROR('This function is only applicable to Central Stores')
                        ;
                        //IF Status=Status::Released THEN
                        //  ERROR('This document has already been released. This functionality is available for open documents only');
                        //IF NOT SomeLinesCommitted THEN BEGIN
                        //   IF NOT CONFIRM( 'Some or All the Lines Are already Committed do you want to continue',TRUE, "Document Type") THEN
                        //        ERROR('Budget Availability Check and Commitment Aborted');
                        DeleteCommitment.RESET;
                        DeleteCommitment.SETRANGE(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::Requisition);
                        DeleteCommitment.SETRANGE(DeleteCommitment."Document No.", Rec."No.");
                        DeleteCommitment.DELETEALL;
                        //END;

                        IF Rec."Requisition Type" = Rec."Requisition Type"::Stationery THEN
                            Commitment.CheckSRN(Rec);
                        // ELSE
                        // ERROR('Please note that only Stationery Items are voted');

                        Rec.Committed := TRUE;
                        Rec.MODIFY;
                        MESSAGE('Budget Availability Checking Complete');
                    end;
                }
                separator(sep2)
                {
                }
                action("Cancel Budget Commitments")
                {
                    Caption = 'Cancel Budget Commitments';
                    Image = CancelLine;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Committed);
                        IF NOT CONFIRM('Are you sure you want to Cancel All Commitments Done for this document', TRUE) THEN
                            ERROR('Budget Availability Check and Commitment Aborted');

                        DeleteCommitment.RESET;
                        DeleteCommitment.SETRANGE(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::Requisition);
                        DeleteCommitment.SETRANGE(DeleteCommitment."Document No.", Rec."No.");
                        DeleteCommitment.DELETEALL;
                        //Tag all the SRN entries as Uncommitted
                        Rec.Committed := FALSE;
                        Rec.MODIFY;
                        MESSAGE('Commitments Cancelled Successfully for Doc. No %1', Rec."No.");
                    end;
                }
                separator(sep22)
                {
                }
                action("Print/Preview")
                {
                    ApplicationArea = All;
                    Caption = 'Print/Preview';
                    Image = PreviewChecks;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        Rec.RESET;
                        Rec.SETFILTER("No.", Rec."No.");
                        REPORT.RUN(50021, TRUE, TRUE, Rec);
                        Rec.RESET;
                    end;
                }
                separator(swp)
                {
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //   OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Responsibility Center" := UserMgt.GetPurchasesFilter();
        //Add dimensions if set by default here
        Rec."Global Dimension 1 Code" := UserMgt.GetSetDimensions(USERID, 1);
        Rec.VALIDATE("Global Dimension 1 Code");
        Rec."Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(USERID, 2);
        Rec.VALIDATE("Shortcut Dimension 2 Code");
        Rec."Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(USERID, 3);
        Rec.VALIDATE("Shortcut Dimension 3 Code");
        Rec."Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(USERID, 4);
        Rec.VALIDATE("Shortcut Dimension 4 Code");
        Rec."Responsibility Center" := RespCentre.Code;
        Rec."User ID" := USERID;
        // OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;
        UpdateControls;
    end;

    var
        UserMgt: Codeunit "User Setup Management BR";
        ApprovalMgt: Codeunit 439;
        ReqLine: Record "PROC-Store Requistion Lines";
        InventorySetup: Record 313;
        GenJnline: Record 83;
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
        Loc: Record 14;
        ApprovalEntries: Page 658;
        FINBudgetEntries: Record "FIN-Budget Entries";
        PROCStoreRequistionHeader: Record "PROC-Store Requistion Header";
        PROCStoreRequistionLines: Record "PROC-Store Requistion Lines";
        Item: Record 27;
        RespCentre: Record "Responsibility Center";


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


    procedure UpdateControls()
    begin

        /* IF Status<>Status::Released THEN BEGIN
         CurrForm."Issue Date".EDITABLE:=FALSE;
         CurrForm.UPDATECONTROLS();
             END ELSE BEGIN
         CurrForm."Issue Date".EDITABLE:=TRUE;
         CurrForm.UPDATECONTROLS();
         END;
            IF Status=Status::Open THEN BEGIN
         CurrForm."Global Dimension 1 Code".EDITABLE:=TRUE;
         CurrForm."Request date" .EDITABLE:=TRUE;
         CurrForm."Responsibility Center" .EDITABLE:=TRUE;
         CurrForm."Issuing Store" .EDITABLE:=TRUE;
         CurrForm."Request Description".EDITABLE:=TRUE;
         CurrForm."Shortcut Dimension 2 Code".EDITABLE:=TRUE;
         CurrForm."Request Description".EDITABLE:=TRUE;
         CurrForm."Shortcut Dimension 3 Code".EDITABLE:=TRUE;
         CurrForm."Shortcut Dimension 4 Code".EDITABLE:=TRUE;
         CurrForm."Required Date".EDITABLE:=TRUE;
         CurrForm.UPDATECONTROLS();
         END ELSE BEGIN
         CurrForm."Responsibility Center".EDITABLE:=FALSE;
         CurrForm."Global Dimension 1 Code".EDITABLE:=FALSE;
         CurrForm."Request Description".EDITABLE:=FALSE;
         CurrForm."Shortcut Dimension 2 Code".EDITABLE:=FALSE;
         CurrForm."Required Date".EDITABLE:=FALSE;
         CurrForm."Shortcut Dimension 3 Code".EDITABLE:=FALSE;
         CurrForm."Shortcut Dimension 4 Code".EDITABLE:=FALSE;
         CurrForm."Required Date".EDITABLE:=FALSE;
          CurrForm."Request date".EDITABLE:=FALSE;
         CurrForm.UPDATECONTROLS();
         END
         */

    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;

    local procedure CommitBudget()
    var
        GLAccount: Record 15;
        DimensionValue: Record 349;
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT ((BCSetup.Mandatory) AND (BCSetup."Store Req. Budget Mamndatory")) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        Rec.TESTFIELD("Shortcut Dimension 2 Code");
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
                FINBudgetEntries.SETRANGE("Global Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                FINBudgetEntries.SETFILTER("Transaction Type", '%1|%2|%3', FINBudgetEntries."Transaction Type"::Expense, FINBudgetEntries."Transaction Type"::Commitment
                , FINBudgetEntries."Transaction Type"::Allocation);
                FINBudgetEntries.SETFILTER("Commitment Status", '%1|%2',
                FINBudgetEntries."Commitment Status"::" ", FINBudgetEntries."Commitment Status"::Commitment);
                FINBudgetEntries.SETFILTER(Date, PostBudgetEnties.GetBudgetStartAndEndDates(Rec."Request date"));
                IF FINBudgetEntries.FIND('-') THEN BEGIN
                    IF FINBudgetEntries.CALCSUMS(Amount) THEN BEGIN
                        IF FINBudgetEntries.Amount > 0 THEN BEGIN
                            IF (PROCStoreRequistionLines."Line Amount" > FINBudgetEntries.Amount) THEN ERROR('Less Funds, Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
                            // Commit Budget Here
                            PostBudgetEnties.CheckBudgetAvailability(Item."Item G/L Budget Account", Rec."Request date", '', Rec."Shortcut Dimension 2 Code",
                            PROCStoreRequistionLines."Line Amount", PROCStoreRequistionLines.Description, 'S-REQUISITION', Rec."No." + PROCStoreRequistionLines."No.", PROCStoreRequistionLines."Description 2", Format(Rec."User ID"));
                        END ELSE
                            ERROR('No allocation for  Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
                    END;
                END ELSE
                    ERROR('Missing Budget for  Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
            END;
            UNTIL PROCStoreRequistionLines.NEXT = 0;
        END;
    end;

    local procedure ExpenseBudget()
    var
        GLAccount: Record 15;
        DimensionValue: Record 349;
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT ((BCSetup.Mandatory) AND (BCSetup."Store Req. Budget Mamndatory")) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        Rec.TESTFIELD("Shortcut Dimension 2 Code");
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
                    PostBudgetEnties.ExpenseBudget(Item."Item G/L Budget Account", Rec."Request date", '', Rec."Shortcut Dimension 2 Code",
                    PROCStoreRequistionLines."Line Amount", PROCStoreRequistionLines.Description, USERID, TODAY, 'S-REQUISITION', Rec."No." + PROCStoreRequistionLines."No.", PROCStoreRequistionLines."Description 2", Format(Rec."User ID"));
                END;
            END;
            UNTIL PROCStoreRequistionLines.NEXT = 0;
        END;
    end;

    local procedure CancelCommitment()
    var
        GLAccount: Record 15;
        DimensionValue: Record 349;
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT ((BCSetup.Mandatory) AND (BCSetup."Store Req. Budget Mamndatory")) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        Rec.TESTFIELD("Shortcut Dimension 2 Code");
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
                    PostBudgetEnties.CancelBudgetCommitment(Item."Item G/L Budget Account", Rec."Request date", '', Rec."Shortcut Dimension 2 Code",
                    PROCStoreRequistionLines."Line Amount", PROCStoreRequistionLines.Description, USERID, 'S-REQUISITION', Rec."No." + PROCStoreRequistionLines."No.", PROCStoreRequistionLines."Description 2");
                END;
            END;
            UNTIL PROCStoreRequistionLines.NEXT = 0;
        END;
    end;



}
