page 52178536 "Proc-Purchase Quote.Card"
{
    Caption = 'Card';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Evaluation,Request Approval,Attachments';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                // Editable = false;
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;

                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Bidder No."; Rec."Bidder No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bidder No. field.';

                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    //Editable = false;
                    Caption = 'Vendor';
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Caption = 'Name';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
                            IF Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                                Rec.SETRANGE("Buy-from Vendor No.");
                        CurrPage.UPDATE;
                    end;
                }


                field("Request for Quote No."; Rec."Request for Quote No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Expected Closing Date"; Rec."Expected Closing Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Closing Date field.';
                }
                field("Expected Opening Date"; Rec."Expected Opening Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Opening Date field.';
                }

                field("Quote Status"; Rec."Quote Status")
                {
                    //Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quote Status field.';
                }
            }
            part(PurchLines; "Purchase Quote Subform")
            {
                ApplicationArea = All;
                //  Editable = false;

                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }


            part(Pre; "Proc-Preliminary Qualif.Quote")
            {
                SubPageLink = "Quote No." = field("No.");
                ApplicationArea = All;
                Editable = false;

            }
            part(Tech; "Proc-Technical Qualif.Quote")
            {
                ApplicationArea = All;
                SubPageLink = "Quote No." = field("No.");
                Editable = false;
            }
            part(Demo; "Proc-Demo Qualif.Quote")
            {
                ApplicationArea = All;
                SubPageLink = "Quote No." = field("No.");
                Editable = false;
            }


        }
        area(factboxes)
        {



            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
                //Visible = false;
                ApplicationArea = All;
            }


        }
    }

    actions
    {

        area(processing)
        {




            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = process;
                ;

                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Custom Document Attachments";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecReference(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }

    }


    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::Quote;
        Rec."Document Type 2" := Rec."Document Type 2"::Quote;
        Rec.DocApprovalType := Rec.DocApprovalType::Quote;
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;

        IF (NOT DocNoVisible) AND (Rec."No." = '') THEN
            Rec.SetBuyFromVendorFromFilter;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FILTERGROUP(0);
        END;

        SetDocNoVisible;
    end;

    var
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        ChangeExchangeRate: Page "Change Exchange Rate";
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CreateIncomingDocumentEnabled: Boolean;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Quote, Rec."No.");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (NOT HasIncomingDocument) AND (Rec."No." <> '')
    end;
}
