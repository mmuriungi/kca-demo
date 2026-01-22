page 52178822 "Tender Demo QualifiedCard"
{
    PageType = Card;
    SourceTable = "Tender Submission Header";
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Bidder No"; Rec."Bidder No")
                {
                    ToolTip = 'Specifies the value of the Bidder No field.';
                    ApplicationArea = All;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    ToolTip = 'Specifies the value of the Tender No. field.';
                    ApplicationArea = All;
                }

                field("Posting Description"; Rec."Posting Description")
                {
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Audit)
            {


                field("Financial Budgeted Amount"; Rec."Financial Budgeted Amount")
                {
                    ToolTip = 'Specifies the value of the Financial Budgeted Amount field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Financial Quoted Amount"; Rec."Financial Quoted Amount")
                {
                    ToolTip = 'Specifies the value of the Financial Quoted Amount field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Financial Variation"; Rec."Financial Variation")
                {
                    ToolTip = 'Specifies the value of the Financial Percentage Variation field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Financial Quoted Amount2"; Rec."Financial Quoted Amount2")
                {
                    ToolTip = 'Specifies the value of the Financial Quoted Amount2 field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Minimum Quoted Amount"; Rec."Minimum Quoted Amount")
                {
                    ToolTip = 'Specifies the value of the Minimum Quoted Amount field.';
                    ApplicationArea = All;

                }
            }

            part(SF; "Tender Submission Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }

        }
    }

    actions
    {

        area(processing)
        {
            action(FinReq)
            {
                Caption = 'Finacial Results Results';
                Image = ReceiveLoaner;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Tender Bidder Fin Reqs";
                RunPageLink = "Tender No." = field("Tender No."), "Bid No." = field("No."), "Bidder No." = field("Bidder No");
            }

            action(getParams)
            {
                Caption = 'GetParams';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    tpReqs: Record "Tender Financial Evaluation";
                    tsheader: Record "Tender Submission Header";
                    tbReqs: Record "Tender Bidder Fin Reqs";

                begin
                    tbReqs.Reset();
                    tbReqs.SetRange("Tender No.", tpReqs."Tender No.");
                    tbReqs.SetRange("Bid No.", Rec."No.");
                    tbReqs.SetRange("Bidder No.", Rec."Bidder No");
                    if tbReqs.Find('-') then
                        tbReqs.DeleteAll();
                    tpReqs.Reset();
                    tpReqs.SetRange("Tender No.", Rec."Tender No.");
                    if tpReqs.Find('-') then begin
                        repeat
                            tbReqs.Init();
                            tbReqs."Bid No." := rec."No.";
                            tbReqs.Validate("Bid No.");
                            tbReqs."Bidder No." := Rec."Bidder No";
                            tbReqs.Validate("Bidder No.");
                            tbReqs."Tender No." := Rec."Tender No.";
                            tbReqs.Code := tpReqs.Code;
                            tbReqs.Description := tpReqs.Description;
                            tbReqs."Description 2" := tpReqs."Description 2";
                            tbReqs."Budgeted Value" := tpReqs."Budgeted Value";
                            tbReqs.Insert();
                        until tpReqs.Next() = 0;
                        MESSAGE('Financial  Requirements Updated Successfully')
                    end else
                        ERROR('Issue Encountered when fetching the parameters')
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