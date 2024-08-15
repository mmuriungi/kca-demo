page 50017 "FIN-Payment Header"
{
    Caption = 'Payment Voucher';
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "FIN-Payments Header";
    SourceTableView = WHERE(Posted = filter(false), Status = FILTER(<> Cancelled));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Imprest Voucher"; Rec."Imprest Voucher")
                {
                    ApplicationArea = all;
                    Visible = false;

                }
                field(Date; Rec.Date)
                {
                    Editable = DateEditable;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code") { ApplicationArea = all; }
                field("Expense Code"; Rec."Expense Code")
                {
                    //ApplicationArea = All;
                }
                field("PF No"; Rec."PF No")
                {
                    //ApplicationArea = All;
                    Visible = false;
                }
                field(Payee; Rec.Payee)
                {
                    Caption = 'Payment to';
                    Importance = Promoted;
                    ApplicationArea = All;
                    Editable = "Payment NarrationEditable";
                    ShowMandatory = true;
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Editable = "Payment NarrationEditable";
                    Importance = Promoted;
                    MultiLine = true;
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                    //ApplicationArea = All;
                }
                field("Invoice Currency Code"; Rec."Invoice Currency Code")
                {
                    Editable = "Invoice Currency CodeEditable";
                    Visible = false;
                    //ApplicationArea = All;
                }
                field(Cashier; Rec.Cashier)
                {
                    Caption = 'Prepared By';
                    Editable = false;
                    //ApplicationArea = All;
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    Caption = 'Total Net Amount';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = "Payment NarrationEditable";
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = All;
                }
                field("Actual Expenditure"; Rec."Actual Expenditure")
                {
                    //ApplicationArea = All;
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    //ApplicationArea = All;
                }
                field("Budget Balance"; Rec."Budget Balance")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    //Editable = "Payment Release DateEditable";
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Tax Voucher"; Rec."Tax Voucher")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;

                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    //Editable = PaymodeEditable;
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec."Pay Mode" = Rec."Pay Mode"::Cheque then
                            ChequeBufferNoEditable := true
                        else
                            ChequeBufferNoEditable := false;
                    end;
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ApplicationArea = All;
                    // Editable = "Cheque TypeEditable";

                    trigger OnValidate()
                    begin
                        IF Rec."Cheque Type" = Rec."Cheque Type"::"Computer Check" THEN
                            "Cheque No.Editable" := FALSE
                        ELSE
                            "Cheque No.Editable" := TRUE;
                    end;
                }
                field("Cheque Buffer No"; Rec."Cheque Buffer No")
                {
                    ApplicationArea = ALL;
                    Visible = ChequeBufferNoEditable;

                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    // Editable = PaymodeEditable;
                    //Enabled = PaymodeEditable;
                    ApplicationArea = All;
                }

                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(PVLines; "FIN-Payment Lines")
            {
                ApplicationArea = All;
                SubPageLink = No = FIELD("No.");
                Editable = PVLinesEditable;
            }
        }
    }

    actions
    {

        area(processing)
        {
            action(postPvs)
            {
                Caption = 'Post Payment';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ExpenseBudget;
                    CurrPage.SAVERECORD;
                    CheckPVRequiredItems(Rec);
                    PostPaymentVoucher(Rec);
                end;
            }

            separator(_______)
            {

            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page "Fin-Approval Entries";
                RunPageLink = "Document No." = field("No.");

                /* trigger OnAction()
                var
                    Approvalentries: Page "Approval Entries";
                //WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                begin
                    DocumentType := DocumentType::"Payment Voucher";
                    Approvalentries.Setfilters(DATABASE::"FIN-Payments Header", 6, Rec."No.");
                    Approvalentries.RUN;
                end; */
            }
            action(sendApproval)
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt2: codeunit "Init Code";
                    ApprovalMgt: Codeunit 439;
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    tableNo: Integer;
                begin
                    CommitBudget;
                    IF NOT LinesExists THEN
                        ERROR('There are no Lines created for this Document');
                    ApprovalMgt2.OnSendPVSforApproval(Rec);
                end;
            }
            action(cancellsApproval)
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    // ApprovalMgt: Codeunit 439;
                    ApprovalMgt2: codeunit "Init Code";
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    tableNo: Integer;
                begin
                    showmessage := true;
                    CancelCommitment;
                    ApprovalMgt2.OnCancelPVSForApproval(Rec);


                end;
            }
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
                end;
            }
            separator(____________)
            {

            }
            action(CheckBudget)
            {
                Caption = 'Check Budgetary Availability';
                Image = Balance;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    BCSetup: Record "FIN-Budgetary Control Setup";
                begin
                    BCSetup.GET;
                    IF NOT BCSetup.Mandatory THEN
                        EXIT;
                    //Ensure only Pending Documents are commited
                    Rec.TESTFIELD(Status, Rec.Status::"Pending Approval");

                    IF NOT AllFieldsEntered THEN
                        ERROR('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');
                    //First Check whether other lines are already committed.
                    Commitments.RESET;
                    Commitments.SETRANGE(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                    Commitments.SETRANGE(Commitments."Document No.", Rec."No.");
                    IF Commitments.FIND('-') THEN BEGIN
                        IF CONFIRM('Lines in this Document appear to be committed do you want to re-commit?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Commitments.RESET;
                        Commitments.SETRANGE(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                        Commitments.SETRANGE(Commitments."Document No.", Rec."No.");
                        Commitments.DELETEALL;
                    END;

                    CheckBudgetAvail.CheckPayments(Rec);
                end;
            }
            action(CancelBudget)
            {
                Caption = 'Cancel Budget Commitment';
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    //Ensure only Pending Documents are commited
                    Rec.TESTFIELD(Status, Rec.Status::Pending);

                    IF CONFIRM('Do you Wish to Cancel the Commitment entries for this document', FALSE) = FALSE THEN BEGIN EXIT END;

                    Commitments.RESET;
                    Commitments.SETRANGE(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                    Commitments.SETRANGE(Commitments."Document No.", Rec."No.");
                    Commitments.DELETEALL;

                    PayLine.RESET;
                    PayLine.SETRANGE(PayLine.No, Rec."No.");
                    IF PayLine.FIND('-') THEN BEGIN
                        REPEAT
                            PayLine.Committed := FALSE;
                            PayLine.MODIFY;
                        UNTIL PayLine.NEXT = 0;
                    END;
                end;
            }
            separator(_______________)
            {

            }
            action(Print)
            {
                Caption = 'Print/Preview';
                Image = ConfirmAndPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    // IF Rec.Status <> Rec.Status::Approved THEN
                    //     ERROR('You can only print a Payment Voucher after it is fully Approved');


                    // //IF Status=Status::Pending THEN
                    // //ERROR('You cannot Print until the document is released for approval');
                    Rec.RESET;
                    Rec.SETFILTER("No.", Rec."No.");
                    REPORT.RUN(report::"Payment Voucher Reports", TRUE, TRUE, Rec);
                    Rec.RESET;

                    CurrPage.UPDATE;
                    CurrPage.SAVERECORD;

                end;

            }
            separator(__________________)
            {

            }
            action(CanelDoc)
            {
                Caption = 'Cancel Document';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Text000: Label 'Are you sure you want to cancel this Document?';
                    Text001: Label 'You have selected not to Cancel the Document';
                begin
                    CancelCommitment;

                    Rec.TESTFIELD(Status, Rec.Status::Approved);
                    IF CONFIRM(Text000, TRUE) THEN BEGIN
                        //Post Reversal Entries for Commitments
                        Doc_Type := Doc_Type::"Payment Voucher";
                        CheckBudgetAvail.ReverseEntries(Doc_Type, Rec."No.");
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.MODIFY;
                    END ELSE
                        ERROR(Text001);
                end;
            }
            action(ShowInvDet)
            {
                Caption = 'Show Invoice Details';
                Enabled = false;
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    IF PurchInvHeader.GET(CurrPage.PVLines.PAGE.GetDocNo) THEN BEGIN
                        PAGE.RUNMODAL(138, PurchInvHeader)
                    END ELSE BEGIN
                        MESSAGE('not found')
                    END;
                end;
            }
            group("Cheque Printing")
            {
                Caption = 'Cheque Printing';
                action("P&review Check")
                {
                    Caption = 'P&review Check';
                    RunObject = Page 404;
                    Visible = false;

                    trigger OnAction()
                    begin

                        ImprestHeader.RESET;
                        ImprestHeader.SETFILTER("No.", Rec."Apply to Document No");
                        REPORT.RUN(39005666, TRUE, TRUE, ImprestHeader);
                        //RESET;
                    end;
                }
                action("Generate Check")
                {
                    Caption = 'Generate Check';
                    Image = PrintCheck;

                    trigger OnAction()
                    begin
                        //CheckPVRequiredItems(Rec);
                        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                        // GenJnlLine.RESET;
                        // GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
                        // GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
                        // IF GenJnlLine.FIND('+') THEN
                        //     GenJnlLine.DELETEALL;
                        //GenJnlLine.RESET;

                        // PopulateCheckJournal(Payments);
                        // GenSetup.GET;
                        // GenSetup."Casuals  Register Nos" := Rec."Paying Bank Account";
                        // GenSetup.MODIFY;


                        // UPDATE CHEQUE NO
                        IF BankAcc.GET(Rec."Paying Bank Account") THEN BEGIN
                            Rec."Cheque No." := INCSTR(BankAcc."Last Check No.");
                            Rec."Cheque Printed" := TRUE;
                            Rec."Payment Release Date" := TODAY;
                            Rec.MODIFY(True);
                        END;

                        //REPORT.RUN(1401,TRUE,TRUE);
                    end;
                }
                action("Print Cheque")
                {
                    Caption = 'Print Cheque';

                    trigger OnAction()
                    begin


                        Payments.RESET;
                        Payments.SETFILTER(Payments."No.", rec."No.");
                        //IF Payments.FIND('-') THEN
                        REPORT.RUN(50023, TRUE, TRUE, Payments);
                    end;
                }
                action("Void Check")
                {
                    Caption = 'Void Check';
                    Image = VoidCheck;

                    trigger OnAction()
                    begin
                        GenJnlLine.RESET;
                        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
                        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
                        IF GenJnlLine.FIND('+') THEN BEGIN
                            GenJnlLine.TESTFIELD(GenJnlLine."Bank Payment Type", GenJnlLine."Bank Payment Type"::"Computer Check");
                            GenJnlLine.TESTFIELD("Check Printed", TRUE);
                            IF CONFIRM(Text000, FALSE, Rec."Cheque No.") THEN
                                CheckManagement.VoidCheck(GenJnlLine);
                            Rec."Cheque No." := '';
                            Rec."Cheque Printed" := FALSE;
                            Rec.MODIFY;
                        END;
                    end;
                }
            }
            group("EFT Generation")
            {
                Caption = 'EFT Generation';

                action("Generate EFT")
                {
                    Caption = 'Generate EFT';
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        IF Rec.Status <> Rec.Status::Approved THEN ERROR('PV must be approved');
                        Rec.TESTFIELD("Cheque No.");

                        EFTHeader.RESET;
                        EFTHeader.SETRANGE(EFTHeader."No.", Rec."Cheque No.");
                        if EFTHeader.FIND('-') THEN BEGIN
                            PayLine.RESET;
                            PayLine.SETRANGE(PayLine.No, Rec."No.");
                            if PayLine.FIND('-') THEN BEGIN
                                EFTline.INIT;
                                EFTline."Doc No" := EFTHeader."No.";
                                EFTline.Date := EFTHeader.Date;
                                EFTline."Bank Code" := PayLine."Bank Code";
                                EFTline."Bank Branch No" := PayLine."Branch Code";
                                EFTline."Bank A/C Name" := PayLine."Account Name";
                                EFTline.Payee := Rec.Payee;
                                EFTline."Bank A/C No" := PayLine."Bank Account No";
                                EFTline.Amount := PayLine."Net Amount";
                                EFTline."PV Number" := PayLine.No;
                                EFTline.Description := Rec."Payment Narration";
                                EFTline.INSERT;

                            END;
                        END;
                        EFTHeader.Posted := TRUE;
                        EFTHeader."Posted by" := USERID;
                        EFTHeader.MODIFY;
                        ExpenseBudget;
                        //Post PV Entries
                        //TESTFIELD("Expense Code");
                        CurrPage.SAVERECORD;
                        CheckPVRequiredItems(Rec);
                        PostPaymentVoucher(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        PVLinesEditable := TRUE;
        DateEditable := TRUE;
        PayeeEditable := TRUE;
        ShortcutDimension2CodeEditable := TRUE;
        "Payment NarrationEditable" := TRUE;
        GlobalDimension1CodeEditable := TRUE;
        "Currency CodeEditable" := FALSE;
        "Invoice Currency CodeEditable" := TRUE;
        "Cheque TypeEditable" := TRUE;
        "Payment Release DateEditable" := TRUE;
        "Cheque No.Editable" := TRUE;
        PaymodeEditable := TRUE;
        ChequeBufferNoEditable := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        Rec."Payment Type" := Rec."Payment Type"::Normal;
        Rec."Cheque Type" := Rec."Cheque Type"::"Manual Check";
        CompanyInfo.get();
        Rec."On Behalf Of" := CompanyInfo.Name;


        rcpt.RESET;
        rcpt.SETRANGE(rcpt.Posted, FALSE);
        rcpt.SETRANGE(rcpt.Cashier, USERID);
        IF rcpt.COUNT > 0 THEN BEGIN
            IF CONFIRM('There are still some unposted payments. Continue?', FALSE) = FALSE THEN BEGIN
                ERROR('There are still some unposted payments. Please utilise them first');
            END;
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
        //Add dimensions if set by default here
        /* "Global Dimension 1 Code":=UserMgt.GetSetDimensions(USERID,1);
         VALIDATE("Global Dimension 1 Code");
         "Shortcut Dimension 2 Code":=UserMgt.GetSetDimensions(USERID,2);
         VALIDATE("Shortcut Dimension 2 Code");
         "Shortcut Dimension 3 Code":=UserMgt.GetSetDimensions(USERID,3);
         VALIDATE("Shortcut Dimension 3 Code");
         "Shortcut Dimension 4 Code":=UserMgt.GetSetDimensions(USERID,4);
         VALIDATE("Shortcut Dimension 4 Code");
         "Responsibility Center":='MAIN';*/
        //OnAfterGetCurrRecord;

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
        Text001: Label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        Text000: Label 'Do you want to Void Check No %1';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
        GLEntry: Record 17;
        rcpt: Record "FIN-Payments Header";
        PayLine: Record "FIN-Payment Line";
        //PVUsers: Record "61711";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments3: Record "FIN-Payments Header";
        Payments: Record "FIN-Payments Header";
        RecPayTypes: Record "FIN-Receipts and Payment Types";
        TarriffCodes: Record "FIN-Tariff Codes";
        GenJnlLine: Record 81;
        DefaultBatch: Record 232;
        CashierLinks: Record "FIN-Cash Office User Template";
        LineNo: Integer;
        Temp: Record "FIN-Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        //PCheck: Codeunit "50110";
        Post: Boolean;
        FaLedgers: Record "FA Ledger Entry";
        Fa: Record "Fixed Asset";
        strText: Text[100];
        ChequeBufferNoEditable: Boolean;
        PVHead: Record "FIN-Payments Header";
        BankAcc: Record "Bank Account";
        CompanyInfo: Record 79;
        CheckBudgetAvail: Codeunit "Budgetary Control";
        Commitments: Record "FIN-Committment";
        ChequeBuffer: Record "FIN-Cheaque Collection Header";
        ChequeLedgers: Record "FIN-Collection  Header Buffer";
        UserMgt: Codeunit "User Setup Management";
        JournlPosted: Codeunit "Journal Post Successful";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition;
        DocPrint: Codeunit 229;
        CheckLedger: Record 272;
        CheckManagement: Codeunit 367;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AdjustGenJnl: Codeunit 407;
        [InDataSet]
        "Cheque No.Editable": Boolean;
        [InDataSet]
        "Payment Release DateEditable": Boolean;
        [InDataSet]
        "Cheque TypeEditable": Boolean;
        [InDataSet]
        "Invoice Currency CodeEditable": Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        [InDataSet]
        "Payment NarrationEditable": Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        PayeeEditable: Boolean;
        [InDataSet]
        ShortcutDimension3CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension4CodeEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        PVLinesEditable: Boolean;
        PayingBankAccountEditable: Boolean;
        ImprestHeader: Record "FIN-Imprest Header";
        PaymodeEditable: Boolean;
        PurchInvHeader: Record 122;
        //ApprovalEntries: Page "658";
        VarVariant: Variant;
        //CustomApprovals: Codeunit "60277";
        GenSetup: Record 98;
        checkAmount: Decimal;
        BCSetup: Record "FIN-Budgetary Control Setup";
        FINBudgetEntries: Record "FIN-Budget Entries";
        FINPaymentLine: Record "FIN-Payment Line";
        EFTHeader: Record "EFT Batch Header";
        EFTline: Record "EFT batch Lines";

    //[Scope('Internal')]
    procedure PostPaymentVoucher(rec: Record "FIN-Payments Header")
    begin


        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
        IF GenJnlLine.FIND('+') THEN BEGIN
            LineNo := GenJnlLine."Line No." + 1000;
        END
        ELSE BEGIN
            LineNo := 1000;
        END;
        GenJnlLine.DELETEALL;
        GenJnlLine.RESET;

        Payments.RESET;
        Payments.SETRANGE(Payments."No.", Rec."No.");
        IF Payments.FIND('-') THEN BEGIN
            PayLine.RESET;
            PayLine.SETRANGE(PayLine.No, Payments."No.");
            IF PayLine.FIND('-') THEN BEGIN
                REPEAT
                    PostHeader(Payments);
                UNTIL PayLine.NEXT = 0;
            END;

            Post := FALSE;
            Post := JournlPosted.PostedSuccessfully();
            GLEntry.RESET;
            GLEntry.SETRANGE("Document No.", Rec."No.");
            IF GLEntry.FIND('-') THEN
                Post := TRUE ELSE
                Post := FALSE;
            IF Post = TRUE THEN BEGIN
                Rec.Posted := TRUE;
                Rec.Status := Payments.Status::Posted;
                Rec."Posted By" := USERID;
                Rec."Date Posted" := TODAY;
                Rec."Time Posted" := TIME;
                Rec.MODIFY;

                //Post Reversal Entries for Commitments
                Doc_Type := Doc_Type::"Payment Voucher";
                CheckBudgetAvail.ReverseEntries(Doc_Type, Rec."No.");
            END;
        END;
    end;

    //[Scope('Internal')]
    procedure PostHeader(var Payment: Record "FIN-Payments Header")
    begin

        IF (Payments."Pay Mode" = Payments."Pay Mode"::Cheque) AND (Rec."Cheque Type" = Rec."Cheque Type"::" ") THEN
            ERROR('Cheque type has to be specified');

        IF Payments."Pay Mode" = Payments."Pay Mode"::Cheque THEN BEGIN
            IF (Payments."Cheque No." = '') AND (Rec."Cheque Type" = Rec."Cheque Type"::"Manual Check") THEN BEGIN
                ERROR('Please ensure that the cheque number is inserted');
            END;
        END;

        IF Payments."Pay Mode" = Payments."Pay Mode"::EFT THEN BEGIN
            IF Payments."Cheque No." = '' THEN BEGIN
                ERROR('Please ensure that the EFT number is inserted');
            END;
        END;

        IF Payments."Pay Mode" = Payments."Pay Mode"::"Letter of Credit" THEN BEGIN
            IF Payments."Cheque No." = '' THEN BEGIN
                ERROR('Please ensure that the Letter of Credit ref no. is entered.');
            END;
        END;
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);

        IF GenJnlLine.FIND('+') THEN BEGIN
            LineNo := GenJnlLine."Line No." + 1000;
        END
        ELSE BEGIN
            LineNo := 1000;
        END;


        LineNo := LineNo + 1000;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Payment."Payment Release Date";
        /*IF CustomerPayLinesExist THEN
         GenJnlLine."Document Type":=GenJnlLine."Document Type"::" "
        ELSE
          GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment; */
        GenJnlLine."Document No." := Payments."No.";
        GenJnlLine."External Document No." := Payments."Cheque No.";

        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := Payments."Paying Bank Account";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");

        GenJnlLine."Currency Code" := Payments."Currency Code";
        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
        //CurrFactor
        GenJnlLine."Currency Factor" := Payments."Currency Factor";
        GenJnlLine.VALIDATE("Currency Factor");

        Payments.CALCFIELDS(Payments."Total Net Amount", Payments."Total VAT Amount");
        GenJnlLine.Amount := -(Payments."Total Net Amount");
        GenJnlLine.VALIDATE(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';

        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

        GenJnlLine.Description := COPYSTR('Pay To:' + Payments.Payee, 1, 50);
        GenJnlLine.VALIDATE(GenJnlLine.Description);

        IF Rec."Pay Mode" <> Rec."Pay Mode"::Cheque THEN BEGIN
            GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::" "
        END ELSE BEGIN
            IF Rec."Cheque Type" = Rec."Cheque Type"::"Computer Check" THEN
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check"
            ELSE
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::" "

        END;
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;


        //Post Other Payment Journal Entries

        PostPV(Payments);

    end;

    //[Scope('Internal')]
    procedure GetAppliedEntries(var LineNo: Integer) InvText: Text[100]
    var
        Appl: Record "FIN-CshMgt Application";
    begin

        InvText := '';
        Appl.RESET;
        Appl.SETRANGE(Appl."Document Type", Appl."Document Type"::PV);
        Appl.SETRANGE(Appl."Document No.", Rec."No.");
        Appl.SETRANGE(Appl."Line No.", LineNo);
        IF Appl.FINDFIRST THEN BEGIN
            REPEAT
                InvText := COPYSTR(InvText + ',' + Appl."Appl. Doc. No", 1, 50);
            UNTIL Appl.NEXT = 0;
        END;
    end;

    //[Scope('Internal')]
    // procedure InsertApproval()
    // var
    //     Appl: Record "61729";
    //     LineNo: Integer;
    // begin
    //     LineNo := 0;
    //     Appl.RESET;
    //     IF Appl.FINDLAST THEN BEGIN
    //         LineNo := Appl."Line No.";
    //     END;

    //     LineNo := LineNo + 1;

    //     Appl.RESET;
    //     Appl.INIT;
    //     Appl."Line No." := LineNo;
    //     Appl."Document Type" := Appl."Document Type"::PV;
    //     Appl."Document No." := Rec."No.";
    //     Appl."Document Date" := Rec.Date;
    //     Appl."Process Date" := TODAY;
    //     Appl."Process Time" := TIME;
    //     Appl."Process User ID" := USERID;
    //     Appl."Process Name" := Rec."Current Status";
    //     //Appl."Process Machine":=ENVIRON('COMPUTERNAME');
    //     Appl.INSERT;
    // end;

    //[Scope('Internal')]
    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCSetup: Record "FIN-Budgetary Control Setup";
    begin
        IF BCSetup.GET() THEN BEGIN
            IF NOT BCSetup.Mandatory THEN BEGIN
                Exists := FALSE;
                EXIT;
            END;
        END ELSE BEGIN
            Exists := FALSE;
            EXIT;
        END;
        Exists := FALSE;
        PayLine.RESET;
        PayLine.SETRANGE(PayLine.No, Rec."No.");
        PayLine.SETRANGE(PayLine.Committed, FALSE);
        PayLine.SETRANGE(PayLine."Budgetary Control A/C", TRUE);
        IF PayLine.FIND('-') THEN
            Exists := TRUE;
    end;

    ////[Scope('Internal')]
    procedure CheckPVRequiredItems(rec: Record "FIN-Payments Header")
    begin
        IF Rec.Posted THEN BEGIN
            ERROR('The Document has already been posted');
        END;

        Rec.TESTFIELD(Status, Rec.Status::Approved);
        Rec.TESTFIELD("Paying Bank Account");
        Rec.TESTFIELD("Pay Mode");
        Rec.TESTFIELD("Payment Release Date");
        //Confirm whether Bank Has the Cash
        /*IF "Pay Mode"="Pay Mode"::Cash THEN
         CheckBudgetAvail.CheckFundsAvailability(Rec);*/

        //Confirm Payment Release Date is today);
        /*IF "Pay Mode"="Pay Mode"::Cash THEN
          TESTFIELD("Payment Release Date",WORKDATE);*/

        /*Check if the user has selected all the relevant fields*/
        Temp.GET(USERID);

        JTemplate := Temp."Payment Journal Template";
        JBatch := Temp."Payment Journal Batch";

        IF JTemplate = '' THEN BEGIN
            ERROR('Ensure the PV Template is set up in Cash Office Setup');
        END;
        IF JBatch = '' THEN BEGIN
            ERROR('Ensure the PV Batch is set up in the Cash Office Setup')
        END;
        IF (Rec."Pay Mode" = Rec."Pay Mode"::Cheque) AND (Rec."Cheque No." = '') THEN
            ERROR('Kindly specify the Cheque No');
        IF (Rec."Pay Mode" = Rec."Pay Mode"::Cheque) AND (Rec."Cheque Type" = Rec."Cheque Type"::"Computer Check") THEN BEGIN
            IF NOT CONFIRM(Text002, FALSE) THEN
                ERROR('You have selected to Abort PV Posting');
        END;
        //Check whether there is any printed cheques and lines not posted
        CheckLedger.RESET;
        CheckLedger.SETRANGE(CheckLedger."Document No.", Rec."No.");
        CheckLedger.SETRANGE(CheckLedger."Entry Status", CheckLedger."Entry Status"::Printed);
        IF CheckLedger.FIND('-') THEN BEGIN
            //Ask whether to void the printed cheque
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.FINDFIRST;
            IF CONFIRM(Text000, FALSE, CheckLedger."Check No.") THEN
                CheckManagement.VoidCheck(GenJnlLine)
            ELSE
                ERROR(Text001, Rec."No.", CheckLedger."Check No.");
        END;

    end;

    ////[Scope('Internal')]
    procedure PostPV(var Payment: Record "FIN-Payments Header")
    var
        StaffClaim: Record "FIN-Staff Claims Header";
        PayReqHeader: Record "FIN-Payments Header";
        FINReceiptsandPaymentTypes: Record "FIN-Receipts and Payment Types";
        FINTariffCodes: Record "FIN-Tariff Codes";
        TaxLedgers: Record "Fin-Witholding Tax Ledges";
        Vend: Record Vendor;
        VendorLedgerEntries: Record "Vendor Ledger Entry";
    begin
        PayLine.RESET;
        PayLine.SETRANGE(PayLine.No, Payments."No.");
        IF PayLine.FIND('-') THEN BEGIN


            REPEAT

                strText := GetAppliedEntries(PayLine."Line No.");
                Payment.TESTFIELD(Payment.Payee);
                PayLine.TESTFIELD(PayLine.Amount);
                // PayLine.TESTFIELD(PayLine."Global Dimension 1 Code");

                //BANK
                VendorLedgerEntries.reset;
                VendorLedgerEntries.SetRange("Applies-to ID", Payments."No.");
                if VendorLedgerEntries.find('-') then begin
                    FaLedgers.reset;
                    FaLedgers.SetRange("Document No.", VendorLedgerEntries."Document No.");
                    if FaLedgers.Find('-') then begin
                        Fa.reset;
                        Fa.SetRange("No.", FaLedgers."FA No.");
                        if Fa.Find('-') THEN begin
                            Fa."Payment Voucher No." := Payments."No.";
                            Fa.Modify()
                        end;
                    end;
                end;
                IF PayLine."Pay Mode" = PayLine."Pay Mode"::Cash THEN BEGIN
                    CashierLinks.RESET;
                    CashierLinks.SETRANGE(CashierLinks.UserID, USERID);
                END;
                //Posting to Tax Ledgers
                IF PayLine."Withholding Tax Amount" <> 0 THEN BEGIN
                    TaxLedgers.Reset;
                    TaxLedgers.setrange("Vendor Pv No", PayLine.No);
                    //TaxLedgers.setrange(Posted, false);
                    if not TaxLedgers.find('-') then begin
                        TaxLedgers.init;
                        TaxLedgers."Entry No" := GetLastTaxEntryNo() + 1;
                        //TaxLedgers.validate("Entry No");
                        TaxLedgers."Vendor Pv No" := Rec."No.";
                        TaxLedgers."Vendor No" := PayLine."Account No.";
                        TaxLedgers."Vendor Name" := PayLine."Account Name";
                        TaxLedgers."Gl No" := PayLine."Votehead Name";
                        TaxLedgers."Tax Type" := TaxLedgers."Tax Type"::"W/Tax";
                        TaxLedgers."Account Type" := PayLine."Account Type";
                        // TaxLedgers.validate("Vendor No");
                        TaxLedgers."Net  Amount" := PayLine."Net Amount";
                        TaxLedgers."Vat Withold" := PayLine."Withholding Tax Amount";
                        TaxLedgers."Vat Amount" := (PayLine."Withholding Tax Amount" * 16 / 2);
                        TaxLedgers."Posting Date" := Rec."Payment Release Date";
                        TaxLedgers.Insert();
                        VendorLedgerEntries.Reset;
                        VendorLedgerEntries.SetRange("Applies-to ID", TaxLedgers."Vendor Pv No");
                        if VendorLedgerEntries.FindFirst() then begin
                            TaxLedgers."Invoice Date" := VendorLedgerEntries."Posting Date";
                            TaxLedgers."Invoice No" := VendorLedgerEntries."External Document No.";
                            TaxLedgers.Modify();
                            Vend.Reset;
                            Vend.SetRange("No.", TaxLedgers."Vendor No");
                            if vend.FindFirst() then begin
                                TaxLedgers."Pin No" := vend."Kra Pin";
                                TaxLedgers.Modify();

                            end;


                        end;
                    end;
                END;
                IF Payments."Pay Mode" = Payments."Pay Mode"::Cheque THEN BEGIN
                    ChequeBuffer.reset;
                    ChequeBuffer.SetFilter(Closed, '%1', false);
                    ChequeBuffer.SetRange("No.", Payments."Cheque Buffer No");

                    if ChequeBuffer.FindFirst() then begin
                        Payments.CalcFields("Total Net Amount");
                        ChequeLedgers.Init();
                        ChequeLedgers.No := Payments."Cheque Buffer No";
                        ChequeLedgers."PV No" := Payments."No.";
                        ChequeLedgers."Cheque No" := Payments."Cheque No.";
                        ChequeLedgers."Payee Name" := Payments.Payee;
                        ChequeLedgers.Amount := Payments."Total Net Amount";
                        ChequeLedgers.Remarks := Payments."Payment Narration";
                        ChequeLedgers.Date := Payments."Payment Release Date";
                        ChequeLedgers.time := TIME;
                        ChequeLedgers."Posted By" := UserId;
                        ChequeLedgers.Insert();




                    end;

                end;

                //CHEQUE
                LineNo := LineNo + 1000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document No." := PayLine.No;
                /*IF PayLine."Account Type"=PayLine."Account Type"::Customer THEN
                GenJnlLine."Document Type":=GenJnlLine."Document Type"::" "
                ELSE
                  GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;*/
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine.Description := COPYSTR(PayLine."Transaction Name" + ':' + Payment.Payee, 1, 50);
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.VALIDATE("Currency Factor");
                IF PayLine."VAT Code" = '' THEN BEGIN
                    GenJnlLine.Amount := PayLine."Net Amount";
                END
                ELSE BEGIN
                    GenJnlLine.Amount := PayLine."Net Amount";
                END;
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."VAT Prod. Posting Group" := PayLine."VAT Prod. Posting Group";
                GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                // GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                // GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                // GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Applies-to Doc. No.";
                GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Applies-to ID";
                //JEFF
                IF PayLine."Account Type" = PayLine."Account Type"::"Fixed Asset" THEN BEGIN
                    GenJnlLine."FA Posting Date" := Payment."Payment Release Date";
                    GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost"
                END;
                //JEFF

                IF GenJnlLine.Amount <> 0 THEN GenJnlLine.INSERT;
                /*
                //Post VAT to GL[VAT GL]
                TarriffCodes.RESET;
                TarriffCodes.SETRANGE(TarriffCodes.Code,PayLine."VAT Code");
                IF TarriffCodes.FIND('-') THEN BEGIN
                TarriffCodes.TESTFIELD(TarriffCodes."Account No.");
                LineNo:=LineNo+1000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name":=JTemplate;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name":=JBatch;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code":='PAYMENTJNL';
                GenJnlLine."Line No.":=LineNo;
                GenJnlLine."Posting Date":=Payment."Payment Release Date";
                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No.":=PayLine.No;
                GenJnlLine."External Document No.":=Payments."Cheque No.";
                GenJnlLine."Account Type":=TarriffCodes."Account Type";//GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Account No.":=TarriffCodes."Account No.";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."Currency Code":=Payments."Currency Code";
                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                //CurrFactor
                GenJnlLine."Currency Factor":=Payments."Currency Factor";
                GenJnlLine.VALIDATE("Currency Factor");

                GenJnlLine."Gen. Posting Type":=GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                GenJnlLine."Gen. Bus. Posting Group":='';
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group":='';
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group":='';
                GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group":='';
                GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine.Amount:=-PayLine."VAT Amount";
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No.":='';
                GenJnlLine.Description:=COPYSTR('VAT:' + FORMAT(PayLine."Account Type") + '::' + FORMAT(PayLine."Account Name"),1,50);
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");

                IF GenJnlLine.Amount<>0 THEN GenJnlLine.INSERT;
                END;
                 */

                //Post VAT Withheld
                TarriffCodes.RESET;
                TarriffCodes.SETRANGE(TarriffCodes.Code, PayLine."VAT Withheld Code");
                IF TarriffCodes.FIND('-') THEN BEGIN

                    TarriffCodes.TESTFIELD(TarriffCodes."G/L Account");
                    LineNo := LineNo + 1000;
                    GenJnlLine.INIT;
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Payment."Payment Release Date";
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No.";
                    GenJnlLine."Account Type" := TarriffCodes."Account Type";//GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine."Account No." := TarriffCodes."G/L Account";
                    GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                    //CurrFactor
                    GenJnlLine."Currency Factor" := Payments."Currency Factor";
                    GenJnlLine.VALIDATE("Currency Factor");

                    GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                    GenJnlLine."Gen. Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                    GenJnlLine."VAT Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                    GenJnlLine."VAT Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                    GenJnlLine.Amount := -PayLine."VAT Withheld Amount";
                    GenJnlLine.VALIDATE(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := COPYSTR('VAT Withheld:' + FORMAT(PayLine."Account Name") + '::' + strText, 1, 50);
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    //GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                    //GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                    // GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                    // GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                    IF GenJnlLine.Amount <> 0 THEN
                        GenJnlLine.INSERT;


                END;

                //POST W/TAX to Respective W/TAX GL Account
                TarriffCodes.RESET;
                TarriffCodes.SETRANGE(TarriffCodes.Code, PayLine."Withholding Tax Code");
                IF TarriffCodes.FIND('-') THEN BEGIN
                    TarriffCodes.TESTFIELD(TarriffCodes."G/L Account");
                    LineNo := LineNo + 1000;
                    GenJnlLine.INIT;
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Payment."Payment Release Date";
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No.";
                    GenJnlLine."Account Type" := TarriffCodes."Account Type";//GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine."Account No." := TarriffCodes."G/L Account";
                    GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                    //CurrFactor
                    GenJnlLine."Currency Factor" := Payments."Currency Factor";
                    GenJnlLine.VALIDATE("Currency Factor");

                    GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                    GenJnlLine."Gen. Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                    GenJnlLine."VAT Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                    GenJnlLine."VAT Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                    GenJnlLine.Amount := -PayLine."Withholding Tax Amount";
                    GenJnlLine.VALIDATE(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := COPYSTR('W/Tax:' + FORMAT(PayLine."Account Name") + '::' + strText, 1, 50);
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    // GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                    // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                    // GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                    // GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                    IF GenJnlLine.Amount <> 0 THEN
                        GenJnlLine.INSERT;
                END;

                //////////////////////////////////////////////////////////////////////////////////////
                //POST Retension to the Retension Account
                //Get Retension Code Here
                IF PayLine."Retention  Amount" <> 0 THEN BEGIN

                    FINReceiptsandPaymentTypes.RESET;
                    FINReceiptsandPaymentTypes.SETRANGE(Code, PayLine.Type);
                    IF FINReceiptsandPaymentTypes.FIND('-') THEN
                        FINReceiptsandPaymentTypes.TESTFIELD("Retention Code")
                    ELSE
                        ERROR('Retensions/Code Not Specified');
                    // get the retension Acount Here
                    TarriffCodes.RESET;
                    TarriffCodes.SETRANGE(Code, FINReceiptsandPaymentTypes."Retention Code");
                    IF TarriffCodes.FIND('-') THEN
                        TarriffCodes.TESTFIELD("G/L Account")
                    ELSE
                        ERROR('Retension Code Not Defined');
                    // TarriffCodes.RESET;
                    // TarriffCodes.SETRANGE(TarriffCodes.Code,PayLine."Withholding Tax Code");
                    IF TarriffCodes.FIND('-') THEN BEGIN
                        TarriffCodes.TESTFIELD(TarriffCodes."G/L Account");
                        LineNo := LineNo + 1000;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := JTemplate;
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := JBatch;
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Source Code" := 'PAYMENTJNL';
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Posting Date" := Payment."Payment Release Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PayLine.No;
                        GenJnlLine."External Document No." := Payments."Cheque No.";
                        GenJnlLine."Account Type" := TarriffCodes."Account Type";//GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine."Account No." := TarriffCodes."G/L Account";
                        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := Payments."Currency Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                        //CurrFactor
                        GenJnlLine."Currency Factor" := Payments."Currency Factor";
                        GenJnlLine.VALIDATE("Currency Factor");

                        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := -PayLine."Retention  Amount";
                        GenJnlLine.VALIDATE(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                        GenJnlLine.Description := COPYSTR('Retension ' + FORMAT(PayLine."Account Name") + '::' + strText, 1, 50);
                        GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                        // GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                        // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                        // GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                        // GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;
                        //Post Retension Balancing Account
                        LineNo := LineNo + 1000;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := JTemplate;
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := JBatch;
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Source Code" := 'PAYMENTJNL';
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Posting Date" := Payment."Payment Release Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PayLine.No;
                        GenJnlLine."External Document No." := Payments."Cheque No.";
                        GenJnlLine."Account Type" := PayLine."Account Type";
                        GenJnlLine."Account No." := PayLine."Account No.";
                        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := Payments."Currency Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                        //CurrFactor
                        GenJnlLine."Currency Factor" := Payments."Currency Factor";
                        GenJnlLine.VALIDATE("Currency Factor");

                        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := PayLine."Retention  Amount";
                        GenJnlLine.VALIDATE(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Description := COPYSTR('Retension Balancing-' + Payments.Payee, 1, 50);
                        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                        // GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                        // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                        // GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                        // GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                        GenJnlLine."Applies-to Doc. No." := PayLine."Apply to";
                        GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PayLine."Apply to ID";
                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;

                    END;
                END;
                //////////////////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////////////////
                //POST PAYE to the PAYE Account
                //Get PAYE Code Here
                IF PayLine."PAYE Amount" <> 0 THEN BEGIN
                    //Post to Tax Ledgers
                    // IF PayLine."PAYE Amount" <> 0 THEN begin
                    TaxLedgers.Reset;
                    TaxLedgers.setrange("Vendor Pv No", PayLine.No);
                    //TaxLedgers.setrange(Posted, false);
                    if not TaxLedgers.find('-') then begin
                        TaxLedgers.init;
                        TaxLedgers."Entry No" := GetLastTaxEntryNo() + 1;
                        //TaxLedgers.validate("Entry No");
                        TaxLedgers."Vendor Pv No" := Rec."No.";
                        TaxLedgers."Vendor No" := PayLine."Account No.";
                        TaxLedgers."Vendor Name" := PayLine."Account Name";
                        TaxLedgers."Gl No" := PayLine."Votehead Name";
                        TaxLedgers."Tax Type" := TaxLedgers."Tax Type"::PAYE;
                        TaxLedgers."Account Type" := PayLine."Account Type";
                        // TaxLedgers.validate("Vendor No");
                        TaxLedgers."Net  Amount" := PayLine."Net Amount";
                        TaxLedgers."Vat Withold" := PayLine."PAYE Amount";
                        TaxLedgers."Posting Date" := Rec."Payment Release Date";
                        TaxLedgers.Insert();
                        if VendorLedgerEntries.FindFirst() then begin
                            TaxLedgers."Invoice Date" := VendorLedgerEntries."Posting Date";
                            TaxLedgers."Invoice No" := VendorLedgerEntries."External Document No.";
                            TaxLedgers.Modify();
                        end;
                        Vend.Reset;
                        Vend.SetRange("No.", TaxLedgers."Vendor No");
                        if vend.FindFirst() then begin
                            TaxLedgers."Pin No" := vend."Kra Pin";
                            TaxLedgers.Modify();
                        end;
                    end;
                    //end;
                    FINReceiptsandPaymentTypes.RESET;
                    FINReceiptsandPaymentTypes.SETRANGE(Code, PayLine.Type);
                    IF FINReceiptsandPaymentTypes.FIND('-') THEN
                        FINReceiptsandPaymentTypes.TESTFIELD("PAYE Tax Code")
                    ELSE
                        ERROR('PAYE Code Not Specified');
                    // get the PAYE Acount Here
                    TarriffCodes.RESET;
                    TarriffCodes.SETRANGE(Code, FINReceiptsandPaymentTypes."PAYE Tax Code");
                    IF TarriffCodes.FIND('-') THEN
                        TarriffCodes.TESTFIELD("G/L Account")
                    ELSE
                        ERROR('PAYE Code Not Defined');
                    IF TarriffCodes.FIND('-') THEN BEGIN
                        TarriffCodes.TESTFIELD(TarriffCodes."G/L Account");
                        LineNo := LineNo + 1000;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := JTemplate;
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := JBatch;
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Source Code" := 'PAYMENTJNL';
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Posting Date" := Payment."Payment Release Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PayLine.No;
                        GenJnlLine."External Document No." := Payments."Cheque No.";
                        GenJnlLine."Account Type" := TarriffCodes."Account Type";//GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine."Account No." := TarriffCodes."G/L Account";
                        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := Payments."Currency Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                        //CurrFactor
                        GenJnlLine."Currency Factor" := Payments."Currency Factor";
                        GenJnlLine.VALIDATE("Currency Factor");

                        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := -PayLine."PAYE Amount";
                        GenJnlLine.VALIDATE(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                        GenJnlLine.Description := COPYSTR('PAYE ' + FORMAT(PayLine."Account Name") + '::' + strText, 1, 50);
                        GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                        // GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                        // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                        // GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                        // GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;
                        //Post PAYE Balancing Account
                        LineNo := LineNo + 1000;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := JTemplate;
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := JBatch;
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Source Code" := 'PAYMENTJNL';
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Posting Date" := Payment."Payment Release Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PayLine.No;
                        GenJnlLine."External Document No." := Payments."Cheque No.";
                        GenJnlLine."Account Type" := PayLine."Account Type";
                        GenJnlLine."Account No." := PayLine."Account No.";
                        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := Payments."Currency Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                        //CurrFactor
                        GenJnlLine."Currency Factor" := Payments."Currency Factor";
                        GenJnlLine.VALIDATE("Currency Factor");

                        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := PayLine."PAYE Amount";
                        GenJnlLine.VALIDATE(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Description := COPYSTR('PAYE Balancing-' + Payments.Payee, 1, 50);
                        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                        // GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                        // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                        // GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                        // GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                        GenJnlLine."Applies-to Doc. No." := PayLine."Apply to";
                        GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PayLine."Apply to ID";
                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;

                    END;
                END;
                //////////////////////////////////////////////////////////////////////////////////////




                // // // // //    //POST P.A.Y.E to Respective P.A.Y.E GL Account
                // // // // //    TarriffCodes.RESET;
                // // // // //    TarriffCodes.SETRANGE(TarriffCodes.Code,PayLine."PAYE Code");
                // // // // //    IF TarriffCodes.FIND('-') THEN BEGIN
                // // // // //    TarriffCodes.TESTFIELD(TarriffCodes."Account No.");
                // // // // //    LineNo:=LineNo+1000;
                // // // // //    GenJnlLine.INIT;
                // // // // //    GenJnlLine."Journal Template Name":=JTemplate;
                // // // // //    GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                // // // // //    GenJnlLine."Journal Batch Name":=JBatch;
                // // // // //    GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                // // // // //    GenJnlLine."Source Code":='PAYMENTJNL';
                // // // // //    GenJnlLine."Line No.":=LineNo;
                // // // // //    GenJnlLine."Posting Date":=Payment."Payment Release Date";
                // // // // //    GenJnlLine."Document Type":=GenJnlLine."Document Type"::" ";
                // // // // //    GenJnlLine."Document No.":=PayLine.No;
                // // // // //    GenJnlLine."External Document No.":=Payments."Cheque No.";
                // // // // //    GenJnlLine."Account Type":=TarriffCodes."Account Type";//GenJnlLine."Account Type"::"G/L Account";
                // // // // //    GenJnlLine."Account No.":=TarriffCodes."Account No.";
                // // // // //    GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                // // // // //    GenJnlLine."Currency Code":=Payments."Currency Code";
                // // // // //    GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                // // // // //    //CurrFactor
                // // // // //    GenJnlLine."Currency Factor":=Payments."Currency Factor";
                // // // // //    GenJnlLine.VALIDATE("Currency Factor");
                // // // // //
                // // // // //    GenJnlLine."Gen. Posting Type":=GenJnlLine."Gen. Posting Type"::" ";
                // // // // //    GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                // // // // //    GenJnlLine."Gen. Bus. Posting Group":='';
                // // // // //    GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                // // // // //    GenJnlLine."Gen. Prod. Posting Group":='';
                // // // // //    GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                // // // // //    GenJnlLine."VAT Bus. Posting Group":='';
                // // // // //    GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                // // // // //    GenJnlLine."VAT Prod. Posting Group":='';
                // // // // //    GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                // // // // //    GenJnlLine.Amount:=-PayLine."PAYE Amount";
                // // // // //    GenJnlLine.VALIDATE(GenJnlLine.Amount);
                // // // // //    GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                // // // // //    GenJnlLine."Bal. Account No.":='';
                // // // // //    GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                // // // // //    GenJnlLine.Description:=COPYSTR('P.A.Y.E:' + FORMAT(PayLine."Account Name") +'::' + strText,1,50);
                // // // // //    GenJnlLine."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
                // // // // //    GenJnlLine."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                // // // // //    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                // // // // //    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                // // // // //    GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                // // // // //    GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                // // // // //
                // // // // //    IF GenJnlLine.Amount<>0 THEN
                // // // // //    GenJnlLine.INSERT;
                // // // // //    END;

                /*
                //Post VAT Balancing Entry Goes to Vendor
                LineNo:=LineNo+1000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name":=JTemplate;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name":=JBatch;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code":='PAYMENTJNL';
                GenJnlLine."Line No.":=LineNo;
                GenJnlLine."Posting Date":=Payment."Payment Release Date";
                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No.":=PayLine.No;
                GenJnlLine."External Document No.":=Payments."Cheque No.";
                GenJnlLine."Account Type":=PayLine."Account Type";
                GenJnlLine."Account No.":=PayLine."Account No.";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."Currency Code":=Payments."Currency Code";
                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                //CurrFactor
                GenJnlLine."Currency Factor":=Payments."Currency Factor";
                GenJnlLine.VALIDATE("Currency Factor");

                IF PayLine."VAT Code"='' THEN
                  BEGIN
                    GenJnlLine.Amount:=0;
                  END
                ELSE
                  BEGIN
                    GenJnlLine.Amount:=PayLine."VAT Amount";
                  END;
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No.":='';
                GenJnlLine.Description:=COPYSTR('VAT:' + FORMAT(PayLine."Account Type") + '::' + FORMAT(PayLine."Account Name"),1,50) ;
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No.":=PayLine."Apply to";
                GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID":=PayLine."Apply to ID";
                IF GenJnlLine.Amount<>0 THEN
                GenJnlLine.INSERT;
                 */
                //Post VAt WithHeld Balancing Entry Goes to Vendor
                LineNo := LineNo + 1000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                //CurrFactor
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.VALIDATE("Currency Factor");

                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine.Amount := PayLine."VAT Withheld Amount";
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Description := COPYSTR(Payments.Payee, 1, 50);
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                // GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                // GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                // GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Apply to";
                GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Apply to ID";
                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT;


                //Post W/TAX Balancing Entry Goes to Vendor
                LineNo := LineNo + 1000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                //CurrFactor
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.VALIDATE("Currency Factor");

                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine.Amount := PayLine."Withholding Tax Amount";
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Description := COPYSTR('W/Tax Balancing-' + Payments.Payee, 1, 50);
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                // GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                // GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                // GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Apply to";
                GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Apply to ID";
                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT;

            //end;


            UNTIL PayLine.NEXT = 0;


            COMMIT;


            //Post the Journal Lines
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
            //Adjust Gen Jnl Exchange Rate Rounding Balances
            AdjustGenJnl.RUN(GenJnlLine);
            //End Adjust Gen Jnl Exchange Rate Rounding Balances


            //Before posting if paymode is cheque print the cheque
            IF (Rec."Pay Mode" = Rec."Pay Mode"::Cheque) AND (Rec."Cheque Type" = Rec."Cheque Type"::"Computer Check") THEN BEGIN
                DocPrint.PrintCheck(GenJnlLine);
                CODEUNIT.RUN(CODEUNIT::"Adjust Gen. Journal Balance", GenJnlLine);
                //Confirm Cheque printed //Not necessary.
            END;
            IF PayLine."VAT Withheld Amount" <> 0 THEN begin
                TaxLedgers.Reset;
                TaxLedgers.setrange("Vendor Pv No", PayLine.No);
                TaxLedgers.setrange(Posted, false);
                if not TaxLedgers.find('-') then begin
                    TaxLedgers.init;
                    TaxLedgers."Entry No" := GetLastTaxEntryNo() + 1;
                    //TaxLedgers.validate("Entry No");
                    TaxLedgers."Vendor Pv No" := Rec."No.";
                    // TaxLedgers.validate("Vendor No");
                    TaxLedgers."Net  Amount" := PayLine."Net Amount";
                    TaxLedgers."Vat Withold" := PayLine."VAT Withheld Amount";
                    TaxLedgers."Posting Date" := Rec."Payment Release Date";
                    TaxLedgers.Insert();
                end;
            end;
            IF PayLine."Retention  Amount" <> 0 THEN begin
                TaxLedgers.Reset;
                TaxLedgers.setrange("Vendor Pv No", PayLine.No);
                //TaxLedgers.setrange(Posted, false);
                if not TaxLedgers.find('-') then begin
                    TaxLedgers.init;
                    TaxLedgers."Entry No" := GetLastTaxEntryNo() + 1;
                    //TaxLedgers.validate("Entry No");
                    TaxLedgers."Vendor Pv No" := Rec."No.";
                    TaxLedgers."Vendor No" := PayLine."Account No.";
                    TaxLedgers."Vendor Name" := PayLine."Account Name";
                    TaxLedgers."Gl No" := PayLine."Vote Head";
                    TaxLedgers."Tax Type" := TaxLedgers."Tax Type"::Retention;
                    TaxLedgers."Account Type" := PayLine."Account Type";
                    TaxLedgers."Posting Date" := Rec."Payment Release Date";
                    // TaxLedgers.validate("Vendor No");
                    TaxLedgers."Net  Amount" := PayLine."Net Amount";
                    TaxLedgers."Vat Withold" := PayLine."Retention  Amount";

                    TaxLedgers.Insert();
                    VendorLedgerEntries.Reset;
                    VendorLedgerEntries.SetRange("Applies-to ID", TaxLedgers."Vendor Pv No");
                    if VendorLedgerEntries.FindFirst() then begin
                        TaxLedgers."Invoice Date" := VendorLedgerEntries."Posting Date";
                        TaxLedgers."Invoice No" := VendorLedgerEntries."External Document No.";
                        TaxLedgers.Modify();
                    end;
                end;
            END;

            CODEUNIT.RUN(CODEUNIT::"Modified Gen. Jnl.-Post", GenJnlLine);
            Post := FALSE;
            Post := JournlPosted.PostedSuccessfully();
            IF Post THEN BEGIN
                IF PayLine.FINDFIRST THEN BEGIN
                    REPEAT
                        PayLine."Date Posted" := TODAY;
                        PayLine."Time Posted" := TIME;
                        PayLine."Posted By" := USERID;
                        PayLine.Status := PayLine.Status::Posted;
                        PayLine.MODIFY;
                    UNTIL PayLine.NEXT = 0;
                END;
            END;

        END;

    end;

    //[Scope('Internal')]
    procedure GetLastTaxEntryNo(): Integer;
    var
        mrktLedger: Record "Fin-Witholding Tax Ledges";
    begin
        mrktLedger.Reset();
        if mrktLedger.FindLast() then
            exit(mrktLedger."Entry No")
        else
            exit(0);
    end;

    procedure UpdateControls()
    begin
        IF Rec.Status <> Rec.Status::Approved THEN BEGIN
            "Payment Release DateEditable" := FALSE;
            PayingBankAccountEditable := FALSE;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            //CurrForm."Pay Mode".EDITABLE:=FALSE;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            "Currency CodeEditable" := FALSE;
            "Cheque No.Editable" := FALSE;
            "Cheque TypeEditable" := FALSE;
            PaymodeEditable := FALSE;
            "Invoice Currency CodeEditable" := TRUE;
        END ELSE BEGIN
            "Payment Release DateEditable" := TRUE;
            PaymodeEditable := TRUE;
            PayingBankAccountEditable := TRUE;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            //CurrForm."Pay Mode".EDITABLE:=TRUE;
            IF Rec."Pay Mode" = Rec."Pay Mode"::Cheque THEN
                "Cheque TypeEditable" := TRUE;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            IF Rec."Cheque Type" <> Rec."Cheque Type"::"Computer Check" THEN
                "Cheque No.Editable" := TRUE;
            "Invoice Currency CodeEditable" := FALSE;


        END;


        IF Rec.Status = Rec.Status::Pending THEN BEGIN
            "Currency CodeEditable" := FALSE;
            GlobalDimension1CodeEditable := TRUE;
            "Payment NarrationEditable" := TRUE;
            ShortcutDimension2CodeEditable := TRUE;
            PayeeEditable := TRUE;
            ShortcutDimension3CodeEditable := TRUE;
            ShortcutDimension4CodeEditable := TRUE;
            DateEditable := TRUE;
            PVLinesEditable := TRUE;

        END ELSE BEGIN
            "Currency CodeEditable" := FALSE;
            GlobalDimension1CodeEditable := FALSE;
            "Payment NarrationEditable" := FALSE;
            ShortcutDimension2CodeEditable := FALSE;
            PayeeEditable := FALSE;
            ShortcutDimension3CodeEditable := FALSE;
            ShortcutDimension4CodeEditable := FALSE;
            DateEditable := FALSE;
            PVLinesEditable := FALSE;



        END
    end;

    //[Scope('Internal')]
    procedure LinesExists(): Boolean
    var
        PayLines: Record "FIN-Payment Line";
    begin
        HasLines := FALSE;
        PayLines.RESET;
        PayLines.SETRANGE(PayLines.No, Rec."No.");
        IF PayLines.FIND('-') THEN BEGIN
            HasLines := TRUE;
            EXIT(HasLines);
        END;
    end;

    //[Scope('Internal')]
    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "FIN-Payment Line";
    begin
        AllKeyFieldsEntered := TRUE;
        PayLines.RESET;
        PayLines.SETRANGE(PayLines.No, Rec."No.");
        IF PayLines.FIND('-') THEN BEGIN
            REPEAT
                IF (PayLines."Account No." = '') OR (PayLines.Amount <= 0) THEN
                    AllKeyFieldsEntered := FALSE;
            UNTIL PayLines.NEXT = 0;
            EXIT(AllKeyFieldsEntered);
        END;
    end;

    //[Scope('Internal')]
    procedure CustomerPayLinesExist(): Boolean
    var
        PayLine: Record "FIN-Payment Line";
    begin
        PayLine.RESET;
        PayLine.SETRANGE(PayLine.No, Rec."No.");
        PayLine.SETRANGE(PayLine."Account Type", PayLine."Account Type"::Customer);
        EXIT(PayLine.FINDFIRST);
    end;

    //[Scope('Internal')]
    procedure PopulateCheckJournal(var Payment: Record "FIN-Payments Header")
    begin
        PayLine.RESET;
        PayLine.SETRANGE(PayLine.No, Rec."No.");
        IF PayLine.FIND('-') THEN BEGIN

            REPEAT
                //  strText:=GetAppliedEntries(PayLine."Line No.");
                //Payment.TESTFIELD(Payment.Payee);
                PayLine.TESTFIELD(PayLine.Amount);
                // PayLine.TESTFIELD(PayLine."Global Dimension 1 Code");

                //BANK
                IF PayLine."Pay Mode" <> PayLine."Pay Mode"::Cheque THEN;

                //CHEQUE
                LineNo := LineNo + 1000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Rec."Payment Release Date";
                GenJnlLine."Document No." := PayLine.No;
                IF PayLine."Account Type" = PayLine."Account Type"::Customer THEN
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                ELSE
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := Rec."Cheque No.";

                GenJnlLine."Currency Code" := Rec."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                GenJnlLine."Currency Factor" := Rec."Currency Factor";
                GenJnlLine.VALIDATE("Currency Factor");
                IF PayLine."VAT Code" = '' THEN BEGIN
                    GenJnlLine.Amount := PayLine."Net Amount";
                END
                ELSE BEGIN
                    GenJnlLine.Amount := PayLine."Net Amount";
                END;
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."VAT Prod. Posting Group" := PayLine."VAT Prod. Posting Group";
                GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine."Bal. Account No." := Rec."Paying Bank Account";
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check";
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Applies-to Doc. No.";
                GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Applies-to ID";
                GenJnlLine.Description := Rec.Payee;
                ///GenJnlLine."Received By":=Payee;
                IF GenJnlLine.Amount <> 0 THEN GenJnlLine.INSERT;


            UNTIL PayLine.NEXT = 0;

        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;

    local procedure CommitBudget()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";

    begin

        BCSetup.GET;
        //IF NOT ((BCSetup.Mandatory) AND (BCSetup."PV Budget Mandatory")) THEN EXIT;
        IF NOT ((BCSetup.Mandatory)) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        Rec.TESTFIELD("Shortcut Dimension 2 Code");
        //Get Current Lines to loop through
        FINPaymentLine.RESET;
        FINPaymentLine.SETRANGE(No, Rec."No.");
        FINPaymentLine.SETRANGE("Account Type", FINPaymentLine."Account Type"::"G/L Account");

        IF FINPaymentLine.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                // Check if budget exists
                FINPaymentLine.TESTFIELD("Account No.");
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", FINPaymentLine."Account No.");
                IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
                // DimensionValue.SETRANGE("Global Dimension No.", 2);
                //DimensionValue.SetRange(Code, Rec."Global Dimension 1 Code");
                IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
                FINBudgetEntries.RESET;
                FINBudgetEntries.SETRANGE("Budget Name", BCSetup."Current Budget Code");
                FINBudgetEntries.SETRANGE("G/L Account No.", FINPaymentLine."Account No.");
                FINBudgetEntries.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                FINBudgetEntries.SETRANGE("Global Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                FINBudgetEntries.SETFILTER("Transaction Type", '%1|%2|%3', FINBudgetEntries."Transaction Type"::Expense,
                 FINBudgetEntries."Transaction Type"::Commitment, FINBudgetEntries."Transaction Type"::Allocation);
                // FINBudgetEntries.SETFILTER("Commitment Status", '%1|%2|%3', FINBudgetEntries."Commitment Status"::Cancelled,
                // FINBudgetEntries."Commitment Status"::"Commited/Posted", FINBudgetEntries."Commitment Status"::Commitment);
                FINBudgetEntries.SETFILTER(Date, PostBudgetEnties.GetBudgetStartAndEndDates(Rec.Date));
                IF FINBudgetEntries.FIND('-') THEN BEGIN
                    IF FINBudgetEntries.CALCSUMS(Amount) THEN BEGIN
                        IF FINBudgetEntries.Amount > 0 THEN BEGIN
                            IF (FINPaymentLine.Amount > FINBudgetEntries.Amount) THEN ERROR('Less Funds, Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
                            PostBudgetEnties.CheckBudgetAvailability(FINPaymentLine."Account No.", Rec.Date, Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code",
                            FINPaymentLine.Amount, FINPaymentLine."Account Name", 'PV', Rec."No." + FINPaymentLine."Account No.", Rec.Payee, Rec.Payee);
                        END ELSE
                            ERROR('No allocation for  Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
                    END;
                END ELSE
                    IF PostBudgetEnties.checkBudgetControl(FINPaymentLine."Account No.") THEN
                        ERROR('Missing Budget for  Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
            END;
            UNTIL FINPaymentLine.NEXT = 0;
        END;
    end;

    local procedure ExpenseBudget()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        //IF NOT ((BCSetup.Mandatory) AND (BCSetup."PV Budget Mandatory")) THEN EXIT;
        IF NOT ((BCSetup.Mandatory)) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        //Rec.TESTFIELD("Shortcut Dimension 2 Code");
        //Get Current Lines to loop through
        FINPaymentLine.SETRANGE(No, Rec."No.");
        FINPaymentLine.SETRANGE("Account Type", FINPaymentLine."Account Type"::"G/L Account");
        IF FINPaymentLine.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                // Expense Budget Here
                FINPaymentLine.TESTFIELD("Account No.");
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", FINPaymentLine."Account No.");
                IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, Rec."Global Dimension 1 Code");
                // DimensionValue.SETRANGE("Global Dimension No.", 2);
                IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
                IF (FINPaymentLine.Amount > 0) THEN BEGIN
                    // Commit Budget Here
                    PostBudgetEnties.ExpenseBudget(FINPaymentLine."Account No.", Rec.Date, Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code",
                    FINPaymentLine.Amount, FINPaymentLine."Account Name", USERID, TODAY, 'PV', Rec."No." + FINPaymentLine."Account No.", Rec.Payee, Rec.Payee);
                END;
            END;
            UNTIL FINPaymentLine.NEXT = 0;
        END;
    end;

    local procedure CancelCommitment()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT (BCSetup.Mandatory) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        Rec.TESTFIELD("Shortcut Dimension 2 Code");
        //Get Current Lines to loop through
        FINPaymentLine.SETRANGE(No, Rec."No.");
        FINPaymentLine.SETRANGE("Account Type", FINPaymentLine."Account Type"::"G/L Account");
        IF FINPaymentLine.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                // Expense Budget Here
                FINPaymentLine.TESTFIELD("Account No.");
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", FINPaymentLine."Account No.");
                IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
                DimensionValue.SETRANGE("Global Dimension No.", 2);
                IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
                IF (FINPaymentLine.Amount > 0) THEN BEGIN
                    // Commit Budget Here
                    PostBudgetEnties.CancelBudgetCommitment(FINPaymentLine."Account No.", Rec.Date, Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code",
                    FINPaymentLine.Amount, FINPaymentLine."Account Name", USERID, 'PV', Rec."No." + FINPaymentLine."Account No.", Rec.Payee);
                END;
            END;
            UNTIL FINPaymentLine.NEXT = 0;
        END;
    end;
}
