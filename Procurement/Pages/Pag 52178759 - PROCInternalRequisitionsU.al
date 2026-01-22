/// <summary>
/// Page PROC-Internal Requisitions U (ID 52178759).
/// </summary>
page 52178759 "PROC-Internal Requisitions U"
{
    Caption = 'Internal Requisition';
    DeleteAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Quote),
                            DocApprovalType = FILTER(Requisition));

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

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = all;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Procurement Type Code"; Rec."Procurement Type Code")
                {
                    ApplicationArea = all;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = all;
                    Caption = 'Requestor User ID';
                    Editable = false;
                }
                field(DocApprovalType; Rec.DocApprovalType)
                {
                    ApplicationArea = all;
                }
                field("Memo No"; Rec."Memo No")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Memo No field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
            }
            part(PurchLines; "Purchase Quote Subform")
            {
                ApplicationArea = all;
                Editable = PurchLinesEditable;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(VendInfoPanel)
            {
                Caption = 'Vendor Information';
                label(" ")
                {
                    CaptionClass = Text19023272;
                    ApplicationArea = All;
                }
                label("label2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                label("  ")
                {
                    CaptionClass = Text19005663;
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        /*CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter("Currency Code","Currency Factor",WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                          VALIDATE("Currency Factor",ChangeExchangeRate.GetParameter);
                          CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                         */

                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate;
                    end;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec."Area")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Quote")
            {
                Caption = '&Quote';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        COMMIT;
                        //RUNMODAL("Purchase Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ApplicationArea = All;
                }
                action(Dimensions2)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Fin-Approval Entries";
                    RunPageLink = "Document No." = field("No.");
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    action(Period)
                    {
                        Caption = 'Period';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //CurrPage.PurchLines.PAGE.ItemAvailability(0);
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //CurrPage.PurchLines.PAGE.ItemAvailability(1);
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //CurrPage.PurchLines.PAGE.ItemAvailability(2);
                        end;
                    }
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.ShowDimensions;
                    end;
                }
                action("Item Charge &Assignment")
                {
                    Caption = 'Item Charge &Assignment';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.ItemChargeAssgnt;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.OpenItemTrackingLines;
                    end;
                }
            }
        }
        area(processing)
        {
            action("Make &Order")
            {
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    ApprovalMgt: Codeunit "Export F/O Consolidation";
                begin
                    IF LinesCommitted THEN
                        ERROR('All Lines should be committed');

                    /* IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
                        CODEUNIT.RUN(CODEUNIT::"Purch.-Quote to Order (Yes/No)", Rec); */
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                separator("--")
                {
                }
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.InsertExtendedText(TRUE);
                    end;
                }
                separator("-")
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator("~~")
                {
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Archi&ve Document")
                {
                    Caption = 'Archi&ve Document';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                separator("~~~")
                {
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    /* trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                    begin
                        BCSetup.GET;
                        IF BCSetup.Mandatory THEN BEGIN
                            // IF LinesCommitted THEN
                            // ERROR('All Lines should be committed');
                        END;

                        //IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
                    end; */
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;

                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelledEntries;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    /* trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                    begin
                        //IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec, TRUE, TRUE) THEN;
                    end; */
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;

                }
                separator("---")
                {
                }
                action("Check Budget Availability")
                {
                    Caption = 'Check Budget Availability';
                    Image = CheckLedger;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BCSetup: Record "FIN-Budgetary Control Setup";
                    begin

                        BCSetup.GET;
                        IF NOT BCSetup.Mandatory THEN
                            EXIT;

                        IF Rec.Status = Rec.Status::Released THEN
                            ERROR('This document has already been released. This functionality is available for open documents only');
                        IF NOT SomeLinesCommitted THEN BEGIN
                            IF NOT CONFIRM('Some or All the Lines Are already Committed do you want to continue', TRUE, Rec."Document Type") THEN
                                ERROR('Budget Availability Check and Commitment Aborted');
                            DeleteCommitment.RESET;
                            DeleteCommitment.SETRANGE(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
                            DeleteCommitment.SETRANGE(DeleteCommitment."Document No.", Rec."No.");
                            DeleteCommitment.DELETEALL;
                        END;
                        Commitment.CheckPurchase(Rec);
                        MESSAGE('Budget Availability Checking Complete');
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    Caption = 'Cancel Budget Commitment';
                    Image = CancelledEntries;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF NOT CONFIRM('Are you sure you want to Cancel All Commitments Done for this document', TRUE, Rec."Document Type") THEN
                            ERROR('Budget Availability Check and Commitment Aborted');

                        DeleteCommitment.RESET;
                        DeleteCommitment.SETRANGE(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
                        DeleteCommitment.SETRANGE(DeleteCommitment."Document No.", Rec."No.");
                        DeleteCommitment.DELETEALL;
                        //Tag all the Purchase Line entries as Uncommitted
                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document Type", Rec."Document Type");
                        PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
                        IF PurchLine.FIND('-') THEN BEGIN
                            REPEAT
                                PurchLine.Committed := FALSE;
                                PurchLine.MODIFY;
                            UNTIL PurchLine.NEXT = 0;
                        END;

                        MESSAGE('Commitments Cancelled Successfully for Doc. No %1', Rec."No.");
                    end;
                }
                separator("~")
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        IF LinesCommitted THEN
                            ERROR('All Lines should be committed');

                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        IF LinesCommitted THEN
                            ERROR('All Lines should be committed');

                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator("+")
                {
                }
                action("&Send BizTalk Rqst. for Purch. Quote")
                {
                    Caption = '&Send BizTalk Rqst. for Purch. Quote';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        ApprovalMgt: Codeunit "Export F/O Consolidation";
                    begin
                        //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                        //  BizTalkManagement.SendReqforPurchQuote(Rec);
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    BCSetup.GET;
                    IF BCSetup.Mandatory THEN
                        IF LinesCommitted THEN
                            //ERROR('All Lines should be committed');

                    Rec.RESET;
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Purchase Requisitions", TRUE, TRUE, Rec);
                    Rec.RESET;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action(PurchHistoryBtn)
            {
                Caption = 'Purchase H&istory';
                Promoted = true;
                PromotedCategory = Process;
                Visible = PurchHistoryBtnVisible;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupVendPurchaseHistory(Rec,"Pay-to Vendor No.",TRUE);
                end;
            }
            action(PurchHistoryBtn1)
            {
                Caption = 'Purchase Histor&y';
                Promoted = true;
                PromotedCategory = Process;
                Visible = PurchHistoryBtn1Visible;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupVendPurchaseHistory(Rec,"Buy-from Vendor No.",FALSE);
                end;
            }
            action(EDMS)
            {
                ApplicationArea = All;
                Caption = 'EDMS Attachments';
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
                    RecRef.GETTABLE(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RUNMODAL;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // OnAfterGetCurrRecord;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if rec.Status <> rec.Status::Open then Error('The document has to pending');
    end;

    trigger OnInit()
    begin
        PurchLinesEditable := TRUE;
        PurchHistoryBtn1Visible := TRUE;
        PayToCommentBtnVisible := TRUE;
        PayToCommentPictVisible := TRUE;
        PurchHistoryBtnVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
        /*//Add dimensions if set by default here
        "Shortcut Dimension 1 Code":=UserMgt.GetSetDimensions(USERID,1);
        VALIDATE("Shortcut Dimension 1 Code");
        "Shortcut Dimension 2 Code":=UserMgt.GetSetDimensions(USERID,2);
        VALIDATE("Shortcut Dimension 2 Code");*/


        Rec.DocApprovalType := Rec.DocApprovalType::Requisition;
        Rec."Assigned User ID" := USERID;

        UpdateControls;
        //OnAfterGetCurrRecord;

    end;

    trigger OnOpenPage()
    begin
        /*IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;*/

    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management BR";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchInfoPaneMgmt: Codeunit "Purchases Info-Pane Management";
        Commitment: Codeunit "Budgetary Control";
        BCSetup: Record "FIN-Budgetary Control Setup";
        DeleteCommitment: Record "FIN-Committment";
        PurchLine: Record "Purchase Line";
        [InDataSet]

        PurchHistoryBtnVisible: Boolean;
        [InDataSet]
        PayToCommentPictVisible: Boolean;
        [InDataSet]
        PayToCommentBtnVisible: Boolean;
        [InDataSet]
        PurchHistoryBtn1Visible: Boolean;
        [InDataSet]
        PurchLinesEditable: Boolean;
        Text19023272: Label 'Buy-from Vendor';
        Text19005663: Label 'Pay-to Vendor';

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure UpdateInfoPanel()
    var
        DifferBuyFromPayTo: Boolean;
    begin
        DifferBuyFromPayTo := Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        PurchHistoryBtnVisible := DifferBuyFromPayTo;
        PayToCommentPictVisible := DifferBuyFromPayTo;
        PayToCommentBtnVisible := DifferBuyFromPayTo;
        //PurchHistoryBtn1Visible := PurchInfoPaneMgmt.DocExist(Rec,"Buy-from Vendor No.");
        //IF DifferBuyFromPayTo THEN
        // PurchHistoryBtnVisible := PurchInfoPaneMgmt.DocExist(Rec,"Pay-to Vendor No.")
    end;



    procedure LinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
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
        IF BCSetup.GET THEN BEGIN
            Exists := FALSE;
            PurchLines.RESET;
            PurchLines.SETRANGE(PurchLines."Document Type", Rec."Document Type");
            PurchLines.SETRANGE(PurchLines."Document No.", Rec."No.");
            PurchLines.SETRANGE(PurchLines.Committed, FALSE);
            IF PurchLines.FIND('-') THEN
                Exists := TRUE;
        END ELSE
            Exists := FALSE;
    end;


    procedure SomeLinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
        IF BCSetup.GET THEN BEGIN
            Exists := FALSE;
            PurchLines.RESET;
            PurchLines.SETRANGE(PurchLines."Document Type", Rec."Document Type");
            PurchLines.SETRANGE(PurchLines."Document No.", Rec."No.");
            PurchLines.SETRANGE(PurchLines.Committed, TRUE);
            IF PurchLines.FIND('-') THEN
                Exists := TRUE;
        END ELSE
            Exists := FALSE;
    end;


    procedure UpdateControls()
    begin
        IF Rec.Status <> Rec.Status::Open THEN BEGIN
            PurchLinesEditable := FALSE;
        END ELSE
            PurchLinesEditable := TRUE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;

        UpdateControls;
    end;
}

