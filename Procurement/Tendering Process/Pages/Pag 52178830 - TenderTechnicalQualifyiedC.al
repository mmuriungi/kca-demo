page 52178830 "Tender Technical QualifyiedC"
{
    PageType = Card;
    SourceTable = "Tender Header";
    // SourceTableView = where("Bid Status" = filter("Prelim Disqualif"));

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

            }
            part(SF; "Tender Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            part(ST; "Tender Technical QualifiedList")

            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Tender No." = FIELD("No."), "Bid Status" = filter("Tech Qualf");
                Visible = bidVisable;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(DemoReq)
            {
                Caption = 'Demonstration  Requirements';
                Image = ReceiveLoaner;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Tender Demonstration Req";
                RunPageLink = "Tender No." = field("No.");
            }
            /* action(LoadDefaults)
            {
                Caption = 'Load Default Setups';
                Image = ReceiveLoaner;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    tsetup: Record "Tender Technical Eval Setup";
                    psetup: Record "Tender Preliminary Reqs Setup";
                    fsetup: Record "Tender Financial Setups";
                    dsetup: Record "Tender Demo Setup";
                    tcSetup: Record "Tender Technical evaluation";
                    pcsetup: Record "Tender Prelim Reqs";
                    dcsetup: Record "Tender Demonstration Req";
                    fcsetup: Record "Tender Financial Evaluation";

                begin
                    tsetup.Reset();
                    if tsetup.Find('-') then begin
                        tcSetup.Reset();
                        tcSetup.SetRange("Tender No.", Rec."No.");
                        if tcSetup.Find('-') then
                            tcSetup.DeleteAll();
                        repeat
                            tcSetup.Init();
                            tcSetup."Tender No." := Rec."No.";
                            tcSetup.Code := tsetup.Code;
                            tcSetup.Description := tsetup.Description;
                            tcSetup."Description 2" := tsetup."Description 2";
                            tcSetup."Maximum Score" := tsetup."Maximum Score";

                            tcSetup.Insert()
                        UNTIL tsetup.Next() = 0;
                    end ELSE
                        ERROR('Not Found');

                    psetup.Reset();
                    if psetup.Find('-') then begin
                        pcsetup.Reset();
                        pcsetup.SetRange("Tender No.", Rec."No.");
                        if pcsetup.Find('-') then
                            pcsetup.DeleteAll();
                        repeat
                            pcsetup.Init();
                            pcsetup."Tender No." := Rec."No.";
                            pcsetup.Code := psetup.Code;
                            pcsetup.Description := psetup.Description;
                            pcsetup."Description 2" := psetup."Description 2";
                            pcsetup.Insert()
                    UNTIL psetup.Next() = 0;
                    end ELSE
                        ERROR('Not Found');

                    dsetup.Reset();
                    if dsetup.Find('-') then begin
                        dcsetup.Reset();
                        dcsetup.SetRange("Tender No.", Rec."No.");
                        if dcsetup.Find('-') then
                            dcsetup.DeleteAll();
                        repeat
                            dcsetup.Init();
                            dcsetup."Tender No." := Rec."No.";
                            dcsetup.Code := dsetup.Code;
                            dcsetup.Description := dsetup.Description;
                            dcsetup."Description 2" := dsetup."Description 2";
                            dcsetup.Insert()
                    UNTIL dsetup.Next() = 0;
                    end ELSE
                        ERROR('Not Found');

                    fsetup.Reset();
                    if fsetup.Find('-') then begin
                        fcsetup.Reset();
                        fcsetup.SetRange("Tender No.", Rec."No.");
                        if fcsetup.Find('-') then
                            fcsetup.DeleteAll();
                        repeat
                            fcsetup.Init();
                            fcsetup."Tender No." := Rec."No.";
                            fcsetup.Code := fsetup.Code;
                            fcsetup.Description := fsetup.Description;
                            fcsetup."Description 2" := fsetup."Description 2";
                            fcsetup."Maximum Quote Value" := fsetup."Maximum Quote Value";
                            fcsetup.Insert()
                    UNTIL fsetup.Next() = 0;
                    end ELSE
                        ERROR('Not Found');

                    Message('Default Setups Loaded Successiffully');
                end;
            } */

            group(Process)
            {
                Caption = 'Demo Evaluation';

                action(ValidateD)
                {
                    Caption = 'Validate Demo Evaluation';
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
                        pUpdate.SetRange("Bid Status", pUpdate."Bid Status"::"Tech Qualf");
                        if pUpdate.Find('-') then begin
                            tQualf.Reset();
                            tQualf.SetRange("Tender No.", Rec."No.");
                            if tQualf.FindFirst() then
                                mCap := tQualf."Demo Percentage";
                            repeat
                                pUpdate.CalcFields("Demo Total", "Demo  Score");
                                if ((pUpdate."Demo  Score" > 0) or (pUpdate."Demo Total" > 0)) then begin
                                    Bscore := (pUpdate."Demo  Score" / pUpdate."Demo Total") * 100;
                                    pUpdate."Demo  Score" := Bscore;
                                    if ((Bscore > mCap) or (Bscore = mCap)) then begin
                                        pUpdate."Bid Status" := pUpdate."Bid Status"::"Demo Qualif"
                                    end else
                                        pUpdate."Bid Status" := pUpdate."Bid Status"::"Demo Disqualif";
                                end else
                                    Message('Evaluation creteria not met');
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