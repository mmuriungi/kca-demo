page 52178558 "Tender Tier Submission Header"
{
    Caption = 'Tender Submission Header';
    PageType = Card;
    SourceTable = "Tender Submission Header";
    PromotedActionCategories = 'New, Process,Reports,Evaluation';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    editable = false;
                    ApplicationArea = All;
                }
                field("Bidder No"; Rec."Bidder No")
                {
                    ToolTip = 'Specifies the value of the Bidder No field.';
                    ApplicationArea = All;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    editable = false;
                    ToolTip = 'Specifies the value of the Tender No. field.';
                    ApplicationArea = All;
                }

                field("Posting Description"; Rec."Posting Description")
                {
                    editable = false;
                    ApplicationArea = All;
                }

                field("Expected Closing Date"; Rec."Expected Closing Date")
                {
                    editable = false;
                    ApplicationArea = All;
                }
                field("Expected Opening Date"; Rec."Expected Opening Date")
                {
                    editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Procurement methods"; Rec."Procurement methods")
                {
                    editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement methods field.';
                }


                field("Bid Status"; Rec."Bid Status")
                {
                    // editable = false;
                    ToolTip = 'Specifies the value of the Bid Status field.';
                    ApplicationArea = All;
                }

                field("Created By"; Rec."Created By")
                {

                    Editable = false;
                    ApplicationArea = All;
                }

            }
            part(SF; "Tender Submission Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            part(Pre; "Proc-Preliminary Qualif.Quote")
            {
                SubPageLink = "Quote No." = field("No.");
                ApplicationArea = All;
                //Editable = false;

            }
            part(Tech; "Proc-Technical Qualif.Quote")
            {
                ApplicationArea = All;
                SubPageLink = "Quote No." = field("No.");
                // Editable = false;
            }
            part(Demo; "Proc-Demo Qualif.Quote")
            {
                ApplicationArea = All;
                SubPageLink = "Quote No." = field("No.");
                //  Editable = false;
            }
            part(Fin; "Proc-Fin.Tender Qualif.Quote")
            {
                ApplicationArea = All;
                SubPageLink = "Quote No." = field("No.");
                //  Editable = false;
            }


        }
    }

    actions
    {
        area(Processing)
        {
            action("Get Evaluation Params")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Evaluate;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    procprocess: Codeunit "Procurement Process";
                begin

                    if Confirm('Get Evaluation Parameters ?', true) = false then Error('Cancelled');
                    procprocess.TenderEvalSetups(Rec);
                    Message('Complete');

                end;
            }
            action(Attachments)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    DocumentAttachment: Page "Custom Document Attachments";
                begin
                    Clear(DocumentAttachment);
                    RecRef.GETTABLE(Rec);
                    DocumentAttachment.OpenForRecReference(RecRef);
                    DocumentAttachment.RUNMODAL;
                end;
            }

        }

    }

    trigger OnDeleteRecord(): Boolean
    begin
        IF Rec.Status = Rec.Status::Released THEN BEGIN
            ERROR('The RFQ has already been released you cannot delete records');
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Created By" := USERID;
        Rec."Procurement methods" := Rec."Procurement methods"::"Two Stage Tender";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Procurement methods" := Rec."Procurement methods"::"Two Stage Tender";
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
}