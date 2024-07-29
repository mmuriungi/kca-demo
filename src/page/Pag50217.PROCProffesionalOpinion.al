page 50217 "PROC Proffesional Opinion"
{
    Caption = 'Professional Opinion';
    PageType = Card;
    SourceTable = "PROC-Purchase Quote Header1";
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

                field("Expected Closing Date"; Rec."Expected Closing Date")
                {
                    ApplicationArea = All;
                }

                field("Expected Opening Date"; Rec."Expected Opening Date")
                {
                    ApplicationArea = All;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
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
            group("Awarded Bid")
            {

                field("Awarded BId/Quote"; Rec."Awarded BId")
                {
                    Editable = qedit;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Awarded BId/Quote field.';
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
                field("captured by"; Rec."captured by")
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
                field("ProfessionalOpinion"; Rec."Professional Opinion")
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
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }

            part("Awarded Quotes"; "Tender Subm AwardL")
            {
                Visible = qvisible;

                ApplicationArea = All;
                SubPageLink = "Request for Quote No." = field("No.");
            }

        }
    }

    actions
    {

        area(processing)
        {
            action("Award")
            {
                ApplicationArea = All;
                Image = Trendscape;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    procProcess: Codeunit "Procurement Process";
                begin
                    procProcess.AwardTender(Rec);

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
        if ((Rec."Expected Opening Date" < System.CurrentDateTime) or (Rec."Expected Opening Date" = System.CurrentDateTime)) then
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