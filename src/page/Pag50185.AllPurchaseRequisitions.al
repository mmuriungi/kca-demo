page 50185 "All Purchase Requisitions"
{
    Caption = 'Purchase Requisistions';
    CardPageID = "PROC-Internal Requisitions";
    PageType = List;
    Editable = false;
    InsertAllowed = true;
    SourceTable = "Purchase Header";
    // SourceTableView = WHERE("Document Type" = FILTER(Quote),
    //                         DocApprovalType = FILTER(Requisition),
    //                         Status = FILTER(<> Released));

    SourceTableView = WHERE(DocApprovalType = FILTER(Requisition), "Document Type" = FILTER(Quote), Archived = filter(false), Status = filter(<> Released));

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

                field("Posting Description"; Rec."Posting Description")
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





            }
        }
    }

    actions
    {

        area(processing)
        {
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
                    PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
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
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = report;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    BCSetup.GET;
                    IF BCSetup.Mandatory THEN
                        IF LinesCommitted THEN
                            //ERROR('All Lines should be committed');

                    Rec.RESET();
                    Rec.SETRANGE("No.", Rec."No.");
                    // REPORT.RUN(Report::"Purchase Requisitions1", TRUE, TRUE, Rec);
                    //Rec.RESET;
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

    trigger OnModifyRecord(): Boolean
    begin
        SendApprovalMail();
    end;

    var
        useremail: text[150];
        usersetup: record "User Setup";
        EmailMessage: Codeunit "Email Message";

        Email: Codeunit Email;
        Subject: Text;
        Recipients: List of [Text];
        Body: Text;
        TaskMessage2: Label 'PRN APPROVAL';
        TaskSubject2: Label 'Dear <b> %1%2</b> <br> <br> This is to inform you that your PRN No: <b>%3</b> has been approved';
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