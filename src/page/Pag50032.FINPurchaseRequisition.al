page 50032 "FIN-Purchase Requisition"
{
    CardPageID = "PROC-Internal Requisitions";
    PageType = List;
    //Editable = false;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Quote));
    //                         
    //                         Status = FILTER(<> Released));

    // SourceTableView = WHERE("Document Type" = FILTER(Quote), Status = FILTER(<> Released));
    //SourceTableView = order(descending) WHERE("Document Type" = FILTER(Quote));


    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }


                field("Posting Description"; Rec."Posting Description")
                {
                    //ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    // ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    // ApplicationArea = All;
                }

                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    //  ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    // ApplicationArea = All;
                }

                field(Department; Rec.Department)
                {
                    //  ApplicationArea = All;
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
                    ApplicationArea = Navigate;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 26;
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = Navigate;
                }
                action("Co&mments")
                {
                    ApplicationArea = Navigate;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 66;
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."), "Document Line No." = CONST(0);
                }
                action(Dimensionss)
                {
                    ApplicationArea = Navigate;
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Approval;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin

                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type".AsInteger(), Rec."No.");

                        ApprovalEntries.RUN;
                    end;
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

                        trigger OnAction()
                        begin
                            //CurrPage.PurchLines.PAGE.ItemAvailability(0);
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';

                        trigger OnAction()
                        begin
                            //CurrPage.PurchLines.PAGE.ItemAvailability(1);
                        end;
                    }

                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.ShowDimensions;
                    end;
                }
                action("Item Charge &Assignment")
                {
                    Caption = 'Item Charge &Assignment';

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
                ApplicationArea = Process;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                //ApprovalMgt: Codeunit "Approvals Management";
                begin
                    IF LinesCommitted THEN
                        ERROR('All Lines should be committed');

                    //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
                    CODEUNIT.RUN(CODEUNIT::"Purch.-Quote to Order (Yes/No)", Rec);
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                separator(_________________)
                {

                }
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts';

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.InsertExtendedText(TRUE);
                    end;
                }
                separator(_____________)
                {

                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(____________)
                {

                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;

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

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                separator(__________________)
                {

                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        BCSetup.GET;
                        IF BCSetup.Mandatory THEN BEGIN
                            IF LinesCommitted THEN
                                ERROR('All Lines should be committed');
                        END;

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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
                separator(_______________)
                {

                }
                action("Check Budget Availability")
                {
                    Caption = 'Check Budget Availability';
                    Image = CheckLedger;
                    Promoted = true;
                    PromotedIsBig = true;

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
                separator(________________)
                {

                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

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

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        IF LinesCommitted THEN
                            ERROR('All Lines should be committed');

                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(________________________)
                {

                }
                action("&Send BizTalk Rqst. for Purch. Quote")
                {
                    Caption = '&Send BizTalk Rqst. for Purch. Quote';

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    //ApprovalMgt: Codeunit "Approvals Management";
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

                trigger OnAction()
                begin
                    BCSetup.GET;
                    IF BCSetup.Mandatory THEN
                        IF LinesCommitted THEN
                            ERROR('All Lines should be committed');

                    Rec.RESET();
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(51505, TRUE, TRUE, Rec);
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

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupVendPurchaseHistory(Rec,"Buy-from Vendor No.",FALSE);
                end;
            }
            action("&Contacts")
            {
                Caption = '&Contacts';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupContacts(Rec);
                end;
            }
            action("Order &Addresses")
            {
                Caption = 'Order &Addresses';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupOrderAddr(Rec);
                end;
            }
        }
    }

    // trigger OnOpenPage()
    // begin
    //     begin
    //         Rec.SETFILTER("Assigned User ID", '=%1', USERID);
    //     end;
    // end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        if Rec."No." = '' then begin
            PurchSetup.Get();
            NoSeriesMgt.InitSeries(PurchSetup."Internal Requisition No.", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchSetup: Record "Purchases & Payables Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit "ArchiveManagement";
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition;

    local procedure ApproveCalcInvDisc()
    begin
        //CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure UpdateInfoPanel()
    var
        DifferBuyFromPayTo: Boolean;
    begin
        DifferBuyFromPayTo := Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        PurchHistoryBtnVisible := DifferBuyFromPayTo;
        PayToCommentPictVisible := DifferBuyFromPayTo;
        PayToCommentBtnVisible := DifferBuyFromPayTo;
    end;

    //[Scope('Internal')]
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

    //[Scope('Internal')]
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

    //[Scope('Internal')]
    procedure UpdateControls()
    begin
        IF Rec.Status <> Rec.Status::Open THEN BEGIN
            PurchLinesEditable := FALSE;
        END ELSE
            PurchLinesEditable := TRUE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    // local procedure OnAfterGetCurrRecord()
    // begin
    //     xRec := Rec;

    //     UpdateControls;
    // end;
}