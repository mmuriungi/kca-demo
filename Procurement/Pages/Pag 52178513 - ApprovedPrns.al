page 52178513 "Approved Prns"
{
    Caption = 'Approved Internal Requistions';
    CardPageID = "PROC-Internal Requisitions";
    PageType = List;
    Editable = false;
    InsertAllowed = false;
    SourceTable = "Purchase Header";
    PromotedActionCategories = 'New,Process,Report,Approvals,Budget,History';
    // SourceTableView = WHERE("Document Type" = FILTER(Quote),
    //                         DocApprovalType = FILTER(Requisition),
    //                         Status = FILTER(<> Released));

    SourceTableView = WHERE("Document Type" = FILTER(Quote), "Document Type 2" = FILTER(Requisition), Status = filter(Released), Archived = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Memo No"; Rec."Memo No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Memo No field.';
                }
                field("Memo Description"; Rec."Memo Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Memo Description field.';
                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }


                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Id field.';
                }

            }
        }
    }

    actions
    {
        area(processing)
        {

            action("Co&mments")
            {
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Co&mments';
                Image = ViewComments;
                RunObject = Page "Purch. Comment Sheet";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."), "Document Line No." = CONST(0);
                ApplicationArea = All;
            }
            action("Make &Order")
            {
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                begin
                    rec.TestField(Status, rec.Status::Released);
                    CODEUNIT.RUN(CODEUNIT::"Purch Quote2Order Yes/No Mod", Rec);
                end;
            }
            action("Archi&ve Document")
            {
                ApplicationArea = all;
                Image = Archive;
                Caption = 'Archi&ve Document';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin

                    if ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text007, rec.DocApprovalType, rec."No."), true) then begin
                        pheader.Reset();
                        pheader.SetRange("No.", rec."No.");
                        pheader.SetRange(Archived, false);
                        if pheader.FindSet() then begin
                            plines.Reset();
                            plines.SetRange("Document No.", pheader."No.");
                            plines.SetRange(Archived, false);
                            if plines.FindSet() then begin
                                repeat
                                    plines.Archived := true;
                                    plines.Modify();
                                until plines.Next() = 0;
                            end;
                            ArchiveManagement.ArchPurchDocumentNoConfirm(Rec);
                            pheader.Archived := true;
                            pheader.Modify();
                        end;
                        CurrPage.UPDATE(true);
                        Message(Text001, rec."No.");
                    end;

                end;
            }

            separator(_______________)
            {

            }




            action("&Print")
            {
                ApplicationArea = all;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;


                trigger OnAction()
                begin
                    BCSetup.GET;
                    IF BCSetup.Mandatory THEN
                        IF LinesCommitted THEN
                            //ERROR('All Lines should be committed');

                            Rec.RESET();
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(report::"purchase requisitions", TRUE, TRUE, Rec);
                    Rec.RESET;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }

        }
    }

    var
        PurchSetup: Record "Purchases & Payables Setup";
        Text001: Label 'Document %1 has been archived.';
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit "ArchiveManagement";
        PurchInfoPaneMgmt: Codeunit "Purchases Info-Pane Management";
        Commitment: Codeunit "Budgetary Control";
        BCSetup: Record "FIN-Budgetary Control Setup";
        DeleteCommitment: Record "FIN-Committment";
        PurchLine: Record "Purchase Line";
        Text007: Label 'Archive %1 no.: %2?';
        ConfirmManagement: Codeunit "Confirm Management";
        pheader: record "Purchase Header";
        plines: Record "Purchase Line";

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