page 52178820 "Tender Technical QualifiedCard"
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
                group(Audit)
                {

                    field("Demo Total"; Rec."Demo Total")
                    {
                        ToolTip = 'Specifies the value of the Demo Total field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Demo  Score"; Rec."Demo  Score")
                    {
                        ToolTip = 'Specifies the value of the Demo  Score field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Demo Percentage"; Rec."Demo Percentage")
                    {
                        ToolTip = 'Specifies the value of the Demo Percentage field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
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

            action(DemoReq)
            {
                Caption = 'Demonstration Requirements';
                Image = ReceiveLoaner;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Tender Bidder Demo Reqs";
                RunPageLink = "Tender No." = field("Tender No."), "Bid No." = field("No."), "Bidder No." = field("Bidder No");
            }


            /*  action(getParamss)
             {
                 Caption = 'GetParams';
                 Promoted = true;
                 PromotedCategory = Process;
                 trigger OnAction()
                 var
                     tpReqs: Record "Tender Technical evaluation";
                     tsheader: Record "Tender Submission Header";
                     tReqsb: Record "Tender Bidder Technical Reqs";
                 begin
                     tpReqs.Reset();
                     tpReqs.SetRange("Tender No.", Rec."Tender No.");
                     if tpReqs.Find('-') then begin
                         tReqsb.Reset();
                         tReqsb.SetRange("Tender No.", tpReqs."Tender No.");
                         tReqsb.SetRange("Bid No.", Rec."No.");
                         tReqsb.SetRange("Bidder No.", Rec."Bidder No");
                         if tReqsb.Find('-') then
                             tReqsb.DeleteAll();
                         repeat
                             tReqsb.Init();
                             tReqsb."Bid No." := rec."No.";
                             tReqsb.Validate("Bid No.");
                             tReqsb."Bidder No." := Rec."Bidder No";
                             tReqsb.Validate("Bidder No.");
                             tReqsb."Tender No." := Rec."Tender No.";
                             tReqsb.Code := tpReqs.Code;
                             tReqsb.Description := tpReqs.Description;
                             tReqsb."Description 2" := tpReqs."Description 2";
                             tReqsb."Maximum Score" := tpReqs."Maximum Score";
                             tReqsb."Desired Score" := tpReqs."Desired Score";
                             tReqsb.Remarks := tpReqs.Remarks;
                             tReqsb.Insert();
                         until tpReqs.Next() = 0;
                         MESSAGE('Success');
                     end;
                 end;
             } */
            action(getParams)
            {
                Caption = 'GetParams';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    tpReqs: Record "Tender Demonstration Req";
                    tsheader: Record "Tender Submission Header";
                    tbReqs: Record "Tender Bidder Demo Reqs";
                    tcommittee: Record "Tender Evaluation Committee";
                begin
                    tcommittee.Reset();
                    tcommittee.SetRange("Tender No.", Rec."Tender No.");
                    if tcommittee.Find('-') then begin
                        tbReqs.Reset();
                        tbReqs.SetRange("Tender No.", tpReqs."Tender No.");
                        tbReqs.SetRange("Bid No.", Rec."No.");
                        tbReqs.SetRange("Bidder No.", Rec."Bidder No");
                        tbReqs.SetRange("User Name", tcommittee."User Name");
                        tbReqs.SetRange("Employee no", tcommittee."Employee no");
                        if tbReqs.Find('-') then
                            tbReqs.DeleteAll();
                        repeat
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
                                    tbReqs."Maximum Score" := tpReqs."Maximum Score";
                                    tbReqs."Employee no" := tcommittee."Employee no";
                                    tbReqs."User Name" := tcommittee."User Name";
                                    tbReqs.Insert();
                                until tpReqs.Next() = 0;
                            end
                        until tcommittee.Next() = 0;
                        MESSAGE('Demo  Requirements Updated Successfully')
                    end else
                        MESSAGE('Tender Committee has not been Set')
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