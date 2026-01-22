page 52178567 "PROC Proff Opinion.Quote"
{
    Caption = 'Professional Opinion';
    PageType = Card;
    SourceTable = "Proc Proffessional Opinion";
    PromotedActionCategories = 'Attachment, Recommend for Award,Reports, Award';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field("Expected Closing Date"; Rec."Closing Date")
                {
                    Editable = Editability;
                    ApplicationArea = All;
                }

                field("Expected Opening Date"; Rec."Openning Date")
                {
                    Editable = Editability;
                    ApplicationArea = All;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    Editable = Editability;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No. field.';
                }
                field("Post Qual Minutes"; Rec."Post Qual Minutes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Qual Minutes field.';
                }
                field("Opening Minutes"; Rec."Opening Minutes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Opening Minutes field.';
                }
                field("Procurement methods"; Rec."Procurement methods")
                {

                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement methods field.';
                }
            }
            /* group("Recommended for Award")
            {
                field("Awarded Quote"; Rec."Recommended for Award")
                {
                    Caption = 'Recommended for Award';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Awarded Quote field.';
                }
                field("Bidder/Supplier"; Rec."Bidder/Supplier")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bidder/Supplier field.';
                }
                field("Issue Order"; Rec."Issue Order")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Issue Order field.';
                }
                field("captured by"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the captured by field.';
                }
            } */
            group("PROFESSIONAL OPINION")
            {
                //Editable = Editability;
                //ShowCaption = false;
                Editable = qedit;
                field("ProfessionalOpinion"; Rec."Proffessional Opinion")
                {
                    ShowCaption = false;
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
            part("Recommended Bidder(s)"; "Proc Bidder Quoted Amounts")
            {
                ApplicationArea = all;
                SubPageLink = "Document No" = field("No.");
            }


        }
    }

    actions
    {

        area(processing)
        {
            action("Opinion")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = report;
                Image = Report;
                trigger OnAction()
                begin
                    rec.Reset();
                    rec.SetRange("No.", rec."No.");
                    if rec.Find('-') then
                        report.Run(report::"Proffessional Opinion", true, false, rec);
                end;
            }
            action("Evaluation Report")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = report;
                Image = Report;
                trigger OnAction()
                var
                    Pheader: Record "Purchase Header";
                    Purchasequote: Record "Proc-Purchase Quote Header";
                    eval: Record "Proc Evaluation Report";
                begin
                    PurchHeader.Reset();
                    PurchHeader.SetRange("Request for Quote No.", rec."No.");
                    if PurchHeader.find('-') then begin
                        report.RunModal(Report::"Committee Eval Report", true, false, PurchHeader);
                        eval.Reset();
                        eval.SetRange("No.", Rec."No.");
                        if eval.Find('-') then;
                    end;
                end;
            }
            action("Recommend For Award")
            {
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                Visible = ActionVisible;
                trigger OnAction()
                var
                    procProc: Codeunit "Procurement Process";
                    BidderAmounts: Record "Proc Bidder Quoted Amounts";
                begin
                    if Confirm('Forward to accounting officer ?', true) = false then Error('Cancelled');
                    BidderAmounts.Reset();
                    BidderAmounts.SetRange("Document No", rec."No.");
                    BidderAmounts.SetRange(Select, true);
                    if BidderAmounts.Count < 1 then Error('You have not selected any bid for recommendation');
                    procProc.validateProfOpinion();
                    procProc.AccountingOfficer(Rec);
                    Rec."Submitted By" := UserId;
                    rec.Status := rec.Status::"Pending Approval";
                    rec."Date Submitted" := Today;
                    Rec.Modify();
                    Message('Submitted successfully to the accounting officer');
                    CurrPage.Close();
                end;
            }
            action("Intention To Award ")
            {
                ApplicationArea = all;
                Image = SalutationFormula;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    procProcess.IntentionToAward(rec);
                end;
            }

            action("Award")
            {
                ApplicationArea = All;
                Image = Workflow;
                Promoted = true;
                PromotedCategory = category4;
                Visible = ActionVisible1;
                trigger OnAction()
                var
                    procProcess: Codeunit "Procurement Process";
                begin
                    if Confirm('Accept recommended bidder(s) ?', true) = false then Error('Cancelled');
                    procProcess.validateAccOff();
                    procProcess.AwardQuotation(Rec);
                    Rec.Status := rec.Status::Released;
                    rec.Modify();
                    CurrPage.Close();
                end;
            }
            action("Reject Award")
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedCategory = category4;
                Visible = ActionVisible1;
                trigger OnAction()
                var
                    procProcess: Codeunit "Procurement Process";
                begin
                    if Confirm('Reject recommended bidder ?', true) = false then Error('Cancelled');
                    procProcess.validateAccOff();
                    rec.TestField("Submitted By");
                    Rec.Status := rec.Status::Rejected;
                    rec.Modify();
                    CurrPage.Close();
                end;
            }
            action("Attachment")
            {
                ApplicationArea = all;
                Image = Attach;
                Promoted = true;
                PromotedCategory = New;
                trigger OnAction()
                var
                    RecRef: RecordRef;
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }

        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        IF Rec.Status = Rec.Status::Released THEN BEGIN
            ERROR('The Record has been released, you cannot delete ');
        END;
    end;

    trigger OnOpenPage()
    begin
        Editability := true;
        if Rec.Status <> Rec.Status::Open then begin
            Editability := false;
        end;
        QuoteVisible();
        if rec.Status = rec.Status::Open then ActionVisible := true else ActionVisible := false;
        if rec."Accounting Officer" = UserId then ActionVisible1 := true else ActionVisible1 := false;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        QuoteVisible();
        if rec.Status = rec.Status::Open then ActionVisible := true else ActionVisible := false;
        if rec."Accounting Officer" = UserId then ActionVisible1 := true else ActionVisible1 := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec."Created By" := USERID;

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if rec.Status = rec.Status::Open then ActionVisible := true else ActionVisible := false;
        if rec."Accounting Officer" = UserId then ActionVisible1 := true else ActionVisible1 := false;
    end;

    trigger OnModifyRecord(): Boolean
    begin

        if (rec.Status = rec.Status::Open) and (rec."Accounting Officer" = ' ') then ActionVisible := true else ActionVisible := false;
        if rec."Accounting Officer" = UserId then ActionVisible1 := true else ActionVisible1 := false;

    end;

    var
        PurchHeader: Record "Purchase Header";
        PParams: Record "PROC-Purchase Quote Params";
        Lines: Record "PROC-Purchase Quote Line";
        PQH: Record "PROC-Purchase Quote Header";
        repVend: Report "Purchase Quote Report";
        RFQ: Code[10];
        vends: Record "PROC-Quotation Request Vendors";
        Purchaselines: Record "Purchase line";
        GETLINES: Page "PROC-PRF Lines";
        ActionVisible: Boolean;
        ActionVisible1: Boolean;
        Editability: Boolean;
        qvisible: Boolean;
        procProcess: Codeunit "Procurement Process";
        qedit: Boolean;

    procedure QuoteVisible()
    var
        mem: Record "Proc-Committee Membership";
    begin
        qvisible := false;
        // if ((Rec."Expected Opening Date" < System.CurrentDateTime) or (Rec."Expected Opening Date" = System.CurrentDateTime)) then
        qvisible := true;
        mem.Reset();
        mem.SetRange("No.", Rec."No.");
        mem.SetRange("Committee Type", mem."Committee Type"::"Opening Commitee");
        mem.SetRange("Opening Confirmed", false);
        if mem.Find('-') then begin
            qvisible := false;

        end;
        qedit := true;
        if Rec."Issue Order" = true then
            qedit := false;
    end;


}