page 52178832 "Tender Demo QualifyiedC"
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
                field("View Online"; Rec."View Online")
                {
                    ToolTip = 'Specifies the value of the View Online field.';
                    ApplicationArea = All;
                }

                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                group(Audit)
                {

                }


            }
            part(SF; "Tender Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            part(ST; "Tender Demo QualifiedList")

            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Tender No." = FIELD("No."), "Bid Status" = filter("Demo Qualif");
                Visible = bidVisable;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(FinReqs)
            {
                Caption = 'Financial Requirements';
                Image = ReceiveLoaner;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Tender Financial Evaluation";
                RunPageLink = "Tender No." = field("No.");
            }
            action(ValidateF)
            {
                Caption = 'Validate Finances';
                ApplicationArea = All;
                Promoted = true;
                Image = TotalValueInsured;

                trigger OnAction()
                var
                    pUpdate: Record "Tender Submission Header";
                    pUpdate2: Record "Tender Submission Header";
                    pUpdate3: Record "Tender Submission Header";
                    tReqs: Record "Tender Bidder Fin Reqs";
                    maxCap: Decimal;
                    minCap: Decimal;
                    Bscore: Decimal;
                begin
                    pUpdate.Reset();
                    pUpdate.SetRange("Tender No.", Rec."No.");
                    pUpdate.SetRange("Bid Status", pUpdate."Bid Status"::"Demo Qualif");
                    if pUpdate.Find('-') then begin
                        repeat
                            pUpdate.CalcFields("Financial Budgeted Amount", "Financial Quoted Amount");
                            if ((pUpdate."Financial Quoted Amount" > 0) or (pUpdate."Financial Budgeted Amount" > 0)) then begin
                                Bscore := ((pUpdate."Financial Budgeted Amount") - (pUpdate."Financial Quoted Amount"));
                                pUpdate."Financial Variation" := Bscore;
                                pUpdate."Financial Quoted Amount2" := pUpdate."Financial Quoted Amount";
                                pUpdate.Modify();
                            end else
                                Message('Financial creteria not updated');

                            tReqs.Reset();
                            tReqs.SetRange("Tender No.", pUpdate."Tender No.");
                            tReqs.SetRange("Bid No.", pUpdate."No.");
                            tReqs.SetRange("Bidder No.", pUpdate."Bidder No");
                            if tReqs.Find('-') then begin
                                repeat
                                    tReqs."Total Bid Amount" := pUpdate."Financial Quoted Amount2";
                                    tReqs.Modify();
                                until tReqs.Next() = 0;
                            end else
                                Message('not Possible')
                        until pUpdate.Next() = 0;
                        // Message('Evaluation Completed Successfully');


                        pUpdate2.Reset();
                        pUpdate2.SetRange("Tender No.", Rec."No.");
                        pUpdate2.SetRange("Bid Status", pUpdate2."Bid Status"::"Demo Qualif");
                        pUpdate2.SetRange("Financial Quoted Amount2", pUpdate."Financial Quoted Amount2");
                        if pUpdate2.Find('-') then begin
                            repeat
                                pUpdate2."Bid Status" := pUpdate2."Bid Status"::"Fin Qualif";
                                pUpdate2.Modify();
                            until pUpdate2.Next() = 0;
                        end else
                            Message('Not Possible here');
                        Message('Evaluation Completed Successfully');


                        pUpdate3.Reset();
                        pUpdate3.SetRange("Tender No.", Rec."No.");
                        pUpdate3.SetRange("Bid Status", pUpdate3."Bid Status"::"Demo Qualif");
                        pUpdate3.SetFilter("Financial Quoted Amount2", '<>%1', pUpdate."Financial Quoted Amount2");
                        if pUpdate3.Find('-') then begin
                            repeat
                                pUpdate3."Bid Status" := pUpdate3."Bid Status"::"Fin Disqualif";
                                pUpdate3.Modify();
                            until pUpdate3.Next() = 0;
                        end;
                        // Message('Evaluation Completed Successfully');

                    end;



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