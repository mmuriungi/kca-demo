page 52178828 "Tender Header PQualifyiedC"
{
    PageType = Card;
    SourceTable = "Tender Header";


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
            part(SF; "Tender Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            part(ST; "Tender Preliminary QualfyList")

            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Tender No." = FIELD("No."), "Bid Status" = filter("Prelim Qualif");
                Visible = bidVisable;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Requirements)
            {
                Caption = 'Requirements';
                action(TechnicalReq)
                {
                    Caption = 'Technical Requirements';
                    Image = ReceiveLoaner;
                    ApplicationArea = All;
                    Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Tender Technical evaluation";
                    RunPageLink = "Tender No." = field("No.");
                }
            }

            group(Process)
            {
                Caption = 'Technical Evaluation';

                action(ValidateT)
                {
                    Caption = 'Validate Technical Evaluation';
                    ApplicationArea = All;
                    Promoted = true;
                    Image = TotalValueInsured;

                    trigger OnAction()
                    var
                        pUpdate: Record "Tender Submission Header";
                        tQualf: Record "Tender Qualification Setup";
                        mCap: Decimal;
                        Bscore: Decimal;
                    begin
                        pUpdate.Reset();
                        pUpdate.SetRange("Tender No.", Rec."No.");
                        pUpdate.SetRange("Bid Status", pUpdate."Bid Status"::"Prelim Qualif");
                        if pUpdate.Find('-') then begin
                            tQualf.Reset();
                            tQualf.SetRange("Tender No.", Rec."No.");
                            if tQualf.FindFirst() then
                                mCap := tQualf."Technical Percentage";
                            repeat
                                pUpdate.CalcFields("Technical Total", "Technical Score");
                                if ((pUpdate."Technical Score" > 0) or (pUpdate."Technical Total" > 0)) then begin
                                    Bscore := (pUpdate."Technical Score" / pUpdate."Technical Total") * 100;
                                    pUpdate."Technical Percentage" := Bscore;
                                    if ((Bscore > mCap) or (Bscore = mCap)) then begin
                                        pUpdate."Bid Status" := pUpdate."Bid Status"::"Tech Qualf"
                                    end else
                                        pUpdate."Bid Status" := pUpdate."Bid Status"::"Tech Disqualif";
                                end else
                                    Message('Evaluation Yet to be done');
                                pUpdate.Modify();
                            until pUpdate.Next() = 0;
                            Message('Evaluation Completed Successfully')
                        end;
                    end;
                }


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

    trigger OnOpenPage()
    var
        tcommittee: Record "Tender Evaluation Committee";
    begin
        bidVisable := true;
        if Rec."Expected Opening Date" > Rec."Expected Closing Date" then
            bidVisable := false;
        tcommittee.Reset();
        tcommittee.SetRange("Tender No.", Rec."No.");
        tcommittee.SetRange("Is Active", false);
        if tcommittee.Find('-') then begin
            bidVisable := false
        end
        else
            bidVisable := true;
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
        bidVisable: Boolean;
}