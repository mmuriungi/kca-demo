page 50218 "PROC Proff Opinion.Quote"
{
    Caption = 'Professional Opinion';
    PageType = Card;
    SourceTable = "Proc Proffessional Opinion";
    PromotedActionCategories = 'New, Recommend for Award,Reports, Award';
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
                field("Procurement methods"; Rec."Procurement methods")
                {

                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement methods field.';
                }
            }
            group("Recommended for Award")
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
            }
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
            part(SF; "PROC-Purchase Quote Req. Line")
            {
                Editable = false;
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }

            part("Quotes"; "Proc-Total Quotes")
            {
                ApplicationArea = All;
                SubPageLink = "Request for Quote No." = field("No.");
            }

        }
    }

    actions
    {

        area(processing)
        {
            action("Recommend Award")
            {
                ApplicationArea = All;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    procProc: Codeunit "Procurement Process";
                begin
                    if Confirm('Forward to accounting officer ?', true) = false then Error('Cancelled');

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
            action("Award")
            {
                ApplicationArea = All;
                Image = Trendscape;
                Promoted = true;
                PromotedCategory = category4;
                trigger OnAction()
                var
                    procProcess: Codeunit "Procurement Process";
                begin
                    if Confirm('Accept recommended bidder ?', true) = false then Error('Cancelled');
                    procProcess.validateAccOff();
                    procProcess.AwardQuotation(Rec);

                end;
            }
            action("Reject Award")
            {
                ApplicationArea = All;
                Image = Trendscape;
                Promoted = true;
                PromotedCategory = category4;
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

    end;

    trigger OnAfterGetCurrRecord()
    begin
        QuoteVisible();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec."Created By" := USERID;
        Rec."Procurement methods" := Rec."Procurement methods"::"Open Tendering";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Procurement methods" := Rec."Procurement methods"::"Open Tendering";
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