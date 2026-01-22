/// <summary>
/// Page PROC-Internal Requisitions (ID 52178701).
/// </summary>
page 52178701 "PROC-Internal Requisitions"
{
    Caption = 'Internal Requisition';
    DeleteAllowed = true;
    // InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    PromotedActionCategories = 'New,Process,Report,Approvals,Budget,History';
    //SourceTableView = WHERE("Document Type" = FILTER(Quote), DocApprovalType = FILTER(Requisition));
    //                         Status = FILTER(<> Released));
    //SourceTableView = WHERE("Document Type" = FILTER(Quote), Status = FILTER(<> Released));

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
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    //  TableRelation = "Responsibility Center".code where(Grouping = filter('PRN'));

                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    // ApplicationArea = All;

                    // trigger OnValidate()
                    // begin
                    //     ShortcutDimension2CodeOnAfterV;
                    // end;
                }









                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Caption = 'Requestor User ID';
                    Editable = false;
                    //Visible = false;

                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    //Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        SendApprovalMail2();
                    end;
                }
                group("Memo Details")
                {
                    field("Memo No"; Rec."Memo No")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Memo No field.';
                    }
                    field("Memo Description"; Rec."Memo Description")
                    {
                        MultiLine = true;

                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Memo Description field.';
                    }
                }

            }
            group("Purchase Lines")
            {
                part(PurchLines; "Purchase Quote Subform")
                {

                    ApplicationArea = All;
                    Editable = PurchLinesEditable;
                    SubPageLink = "Document No." = FIELD("No.");
                }
            }

            group(VendInfoPanel)
            {
                Caption = 'Vendor Information';
                // label(Reqy)
                // {
                //     CaptionClass = Text19023272;
                // }
                // label(yrt)
                // {
                //     Editable = false;
                // }
                // label(iruru)
                // {
                //     CaptionClass = Text19005663;
                // }
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

            }
        }
    }
    actions
    {
        area(processing)
        {
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
            action("Archi&ve Document")
            {
                ApplicationArea = all;
                Image = Archive;
                Caption = 'Archi&ve Document';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
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
            action("Validate Vendor")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    rec.Reset();
                    rec.SetRange("No.", rec."No.");
                    if rec.Find('-') then begin
                        Pline.Reset();
                        Pline.SetRange("Document No.", rec."No.");
                        if Pline.Find('-') then begin
                            Pline."Buy-from Vendor No." := rec."Buy-from Vendor No.";
                            Pline.Validate("Buy-from Vendor No.");
                            Pline.Modify();
                        end;
                        Message('Updated');
                    end

                end;
            }

            separator(_______________)
            {

            }
            action("Send A&pproval Request")
            {
                ApplicationArea = all;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    BCSetup.GET;
                    IF BCSetup.Mandatory THEN BEGIN
                        /* IF LinesCommitted THEN
                            ERROR('All Lines should be committed'); */
                    END;
                    if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(Rec) = true then
                        ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec) else
                        Error('No workflow');

                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;
                trigger OnAction()
                var
                    Approvalentries: Page "Fin-Approval Entries";
                begin
                    Approvalentries.Setfilters(DATABASE::"Purchase Header", 0, Rec."No.");
                    Approvalentries.RUN;
                end;
            }
            action("Cancel Approval Re&quest")
            {
                ApplicationArea = all;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelledEntries;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                end;
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

    procedure SendApprovalMail();
    begin
        if Rec.Status = Rec.Status::Released then begin
            if (Rec."User Id" <> '') or (rec."Assigned User ID" <> '') then begin
                Rec.Reset();
                Rec.SetRange("No.", Rec."No.");
                if Rec.FindSet(true, true) then begin
                    repeat
                        usersetup.Reset();
                        usersetup.SetRange("User Id", rec."User Id");
                        if usersetup.Find('-') then begin
                            Recipients.Add(usersetup."E-Mail");
                        end;
                        usersetup.Reset();
                        usersetup.SetRange("Employee No.", rec."Assigned User ID");
                        if usersetup.Find('-') then begin
                            useremail := usersetup."User ID";
                            Recipients.Add(usersetup."E-Mail");
                        end;

                    until Rec.Next() = 0;

                    Subject := StrSubstNo(TaskMessage2, Rec."No.");
                    Body := StrSubstNo(TaskSubject2, rec."User Id", useremail, rec."No.");
                    EmailMessage.Create(Recipients, Subject, Body, true);
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    Rec.Modify();
                    //message('Reliever notified  successfully');
                end;

            end;


        end;
    end;

    procedure SendApprovalMail2();
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Recipients: List of [Text];
        Body: Text;
        usersetup: Record "User Setup";
        TaskMessage2: Label 'PRN APPROVAL';
        TaskSubject2: Label 'Dear <b> %1</b> <br> <br> This is to inform you that PRN No: <b> %2 </b> has been approved';

    begin
        IF (rec.Status = rec.Status::Released) and (rec.DocApprovalType = rec.DocApprovalType::Requisition) then begin
            Rec.Reset();
            Rec.SetRange("No.", Rec."No.");
            if Rec.FindSet(true, true) then begin
                repeat
                    usersetup.Reset();
                    usersetup.SetRange("Prn Notification", true);
                    if usersetup.Find('-') then begin
                        Recipients.Add(usersetup."E-Mail");
                    end;
                until Rec.Next() = 0;
                Subject := StrSubstNo(TaskMessage2, Rec."No.");
                Body := StrSubstNo(TaskSubject2, usersetup."User ID", rec."No.");
                EmailMessage.Create(Recipients, Subject, Body, true);
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                Rec.Modify();
            end;
        end;


    end;

    var
        Pline: Record "Purchase Line";
        useremail: text[150];
        usersetup: record "User Setup";
        EmailMessage: Codeunit "Email Message";

        Email: Codeunit Email;
        Subject: Text;
        Recipients: List of [Text];
        Body: Text;
        TaskMessage2: Label 'PRN APPROVAL';
        TaskSubject2: Label 'Dear <b> %1%2</b> <br> <br> This is to inform you that your PRN No: <b>%3</b> has been approved';

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
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


        UpdateControls;
        //OnAfterGetCurrRecord;

    end;







    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;

    end;

    trigger OnModifyRecord(): Boolean
    begin
        if rec.Status <> rec.Status::Open then Error('The document has to pending');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        USetup.RESET;
        USetup.SETRANGE(USetup."User ID", USERID);
        USetup.SETRANGE(USetup.HOD, false);
        IF USetup.FIND('-') THEN ERROR('Kindly generate the prn from the memo');



        if rec."No." = '' then begin
            PurchSetup.Get();
            PurchSetup.TestField("Internal Requisition No.");
            NoSeriesMgt.InitSeries(PurchSetup."Internal Requisition No.", xRec."No. Series", 0D, Rec."No.", rec."No. Series");
            plines."Document Type 2" := pheader."Document Type 2";

            // rec."User Id" := UserId;
        end;


    end;

    var
        Text007: Label 'Archive %1 no.: %2?';
        ConfirmManagement: Codeunit "Confirm Management";
        pheader: record "Purchase Header";
        plines: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        EMP: Record "HRM-Employee C";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchInfoPaneMgmt: Codeunit "Purchases Info-Pane Management";
        Text001: Label 'Document %1 has been archived.';
        Commitment: Codeunit "Budgetary Control";
        BCSetup: Record "FIN-Budgetary Control Setup";
        DeleteCommitment: Record "FIN-Committment";
        USetup: Record "User Setup";
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

    procedure ApproveCalcInvDisc()
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

    /*  trigger OnInsertRecord(BelowxRec: Boolean): Boolean
     begin
         if Rec."No." <> xRec."No." then begin
             PurchSetup.Get();
             PurchSetup.TestField("Requisition No");
             NoSeriesMgt.InitSeries(PurchSetup."Requisition No", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
         end;

     end;
  */

    // local procedure OnAfterGetCurrRecord()
    // begin
    //     xRec := Rec;

    //     UpdateControls;
    // end;
}
