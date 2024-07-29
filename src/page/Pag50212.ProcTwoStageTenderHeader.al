page 50212 "Proc-Two Stage.Tender Header"
{
    Caption = 'Two Stage Tendering';
    PageType = Card;
    SourceTable = "PROC-Purchase Quote Header1";
    PromotedActionCategories = 'New,Process, Report,Evaluation Matrix, Tier Tendering,Bid,Award, Attachments';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Editability;
                Caption = 'General';

                field("No."; Rec."No.")
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
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No. field.';
                }
                field("Prequalification Period"; Rec."Prequalification Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prequalification Period field.';
                }
                field("Suppliers Category"; Rec."Suppliers Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Suppliers Category field.';
                }
                field("Category Description"; Rec."Category Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Description field.';
                }
                field("Procurement methods"; Rec."Procurement methods")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement methods field.';
                }
                field("Initiate Tier Two"; Rec."Initiate Tier Two")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Initiate Tier Two field.';
                }
                field("Has Evaluation"; Rec."Has Evaluation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Has Evaluation field.';
                    trigger OnValidate()
                    begin
                        Initializevariables();
                        if rec."Has Evaluation" = rec."Has Evaluation"::Yes then
                            CriteriaVisible1 := true else
                            CriteriaVisible1 := false;
                    end;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }


            }
            group("Two Tier Header")
            {
                Editable = Editability;
                //ShowCaption = false;
                field("Description"; Rec."Description")
                {
                    ShowCaption = false;
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }

            part(SF; "PROC-Purchase Quote Req. Line")
            {
                Editable = Editability;
                ApplicationArea = All;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            group("Evaluation Creteria")
            {
                Visible = CriteriaVisible;
                field("Preliminary Evaluation "; Rec."Preliminary Evaluation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preliminary Evaluation field.';
                    trigger OnValidate()
                    begin
                        Initializevariables();
                    end;
                }

                field("TechnicalEvaluation"; Rec."Technical Evaluation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Technical Evaluation field.';
                    trigger OnValidate()
                    begin
                        Initializevariables();
                        if rec."Technical Evaluation" = rec."Technical Evaluation"::Yes then Passmark1 := true else Passmark1 := false;
                    end;
                }
                field("Technical Passmark Score"; Rec."Technical Passmark Score")
                {

                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Technical Passmark Score field.';
                }
                field("Demonistration Evaluation"; Rec."Demonistration Evaluation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Demonistration Evaluation field.';
                    trigger OnValidate()
                    begin
                        Initializevariables();
                        if rec."Demonistration Evaluation" = rec."Demonistration Evaluation"::Yes then Passmark2 := true else Passmark2 := false;
                    end;
                }
                field("Demo Passmark Score"; Rec."Demo Passmark Score")
                {
                    //Editable = Passmark2;
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Demo Passmark Score field.';
                }
                field("Financial Evaluation "; Rec."Financial Evaluation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Evaluation field.';
                    trigger OnValidate()
                    begin
                        Initializevariables();
                        if rec."Financial Evaluation" = rec."Financial Evaluation"::Yes then
                            Passmark3 := true else
                            Passmark3 := false;
                    end;
                }
                field("Financial Evaluation Score"; Rec."Financial Evaluation Score")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Evaluation Score field.';
                }
                field("Post-Qualification "; Rec."Post-Qualification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post-Qualification field.';
                    trigger OnValidate()
                    begin
                        Initializevariables();
                    end;
                }


            }
            part("PRQ"; "Proc-Preliminary Qualif")
            {
                Visible = Passmark;
                Editable = Editability;
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }

            part("Technical"; "Proc-Technical Qualif")
            {
                Visible = Passmark1;
                Editable = Editability;
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part("Demo"; "Proc-Demo Qualif")
            {
                Visible = Passmark2;
                Editable = Editability;
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }


            part(PostQual; "Proc Post Qualif")
            {
                Visible = Passmark4;
                Editable = Editability;
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }

            part(OpenC; "Proc-Opening Commitee")
            {

                Caption = 'Opening Committee';
                Editable = Editability;
                ApplicationArea = All;
                SubPageLink = "No." = field("No."), "Committee Type" = filter("Opening Commitee");
            }

            part("EvalC"; "Proc-Committee Membership")
            {
                Caption = 'Evaluation Commitee';
                Editable = Editability;
                ApplicationArea = All;
                SubPageLink = "No." = field("No."), "Committee Type" = filter("Evaluation Committee");
            }
            part("Vendor Quotes"; "Proc-Purchase Quotes.LPart")
            {
                Visible = qvisible;
                ApplicationArea = All;
                SubPageLink = "Request for Quote No." = field("No.");
            }
            part("Qualif Quotes"; "Proc-Purchase Qualif.Quotes")
            {
                Visible = qvisible;
                ApplicationArea = All;
                SubPageLink = "Request for Quote No." = field("No.");
            }
            part("Disq Quotes"; "Proc-Purchase Disq.Quotes")
            {
                Visible = qvisible;
                ApplicationArea = All;
                SubPageLink = "Request for Quote No." = field("No.");
            }
            part("Awarded Quotes"; "Proc-Purchase Awarded.Quotes")
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
            group(Evaluation)
            {
                action("Re-Do Evaluation")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Image = Redo;
                    Visible = CriteriaVisible1;
                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to restart evaluation for ' + rec."No." + '?', true) = false then Error('Aborted');
                        procProcess.RedoEvaluation(rec."No.");
                    end;
                }
                action("Evaluation Parameters")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    Image = Evaluate;
                    PromotedCategory = Category4;
                    Visible = CriteriaVisible1;
                    trigger OnAction()
                    begin
                        if Confirm('Get Evaluation Parameters?', true) = false then Error('Cancelled');
                        procprocess.EvaluationSetups(rec."No.");
                    end;
                }

                action("Preliminary Evaluation")
                {
                    ApplicationArea = All;
                    Image = ShowMatrix;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = CriteriaVisible1;
                    trigger OnAction()
                    begin
                        procProcess.PreliminaryEvaluation(Rec."No.");
                    end;
                }
                action("Technical Evaluation")
                {
                    ApplicationArea = All;
                    Image = ShowMatrix;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = CriteriaVisible1;
                    trigger OnAction()
                    begin
                        procProcess.TechnicalEvaluation(Rec."No.");

                    end;
                }
                action("Demo Evaluation")
                {
                    ApplicationArea = All;
                    Image = ShowMatrix;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = CriteriaVisible1;
                    trigger OnAction()
                    begin
                        procProcess.DemoEvaluation(Rec."No.");
                    end;
                }


            }


            group("Stage Two")
            {
                action("Initiate Stage Two")
                {
                    ApplicationArea = All;
                    Image = "8ball";
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        if Rec."Initiate Tier Two" <> true then
                            Rec."Initiate Tier Two" := true;
                        Rec.Modify();
                    end;
                }
                action("Two Tier Evaluation")
                {
                    ApplicationArea = All;
                    Image = "8ball";
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        if Rec."Initiate Tier Two" = true then
                            page.Run(Page::"PROC-Tier Two Tender Header", Rec)
                        else
                            Error('Two Tier Tendering not activated');
                    end;
                }
            }
            group(Reports)
            {
                action("Preliminary Report")
                {
                    ApplicationArea = all;
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    trigger OnAction()
                    var
                        Preq: Record "Proc-Preliminary Qualif.Quote";
                    begin
                        Preq.Reset();
                        Preq.SetRange("No.", rec."No.");
                        if Preq.Find('-') then
                            report.run(report::"Preliminary Evaluation Report", true, true, Preq)
                    end;
                }
                action("Technical Report")
                {
                    ApplicationArea = all;
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    trigger OnAction()
                    var
                        Preq: Record "Proc-Technical Qualif.Quote";
                    begin
                        Preq.Reset();
                        Preq.SetRange("No.", rec."No.");
                        if Preq.Find('-') then
                            report.run(report::"Technical Evaluation Report", true, true, Preq)
                    end;
                }
                action("Demo Report")
                {
                    ApplicationArea = all;
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    trigger OnAction()
                    var
                        Preq: Record "Proc-Demo Qualif.Quote";
                    begin
                        Preq.Reset();
                        Preq.SetRange("No.", rec."No.");
                        if Preq.Find('-') then
                            report.run(report::"Demo Evaluation Report", true, true, Preq)
                    end;
                }
                action("Tender Opening")
                {
                    Caption = 'Bids Report';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Report;
                    Image = Report;

                    trigger OnAction()
                    var
                        header: Record "PROC-Purchase Quote Header1";
                        comm: Record "Proc-Committee Membership";
                    begin
                        header.Reset();
                        header.SetRange("No.", Rec."No.");
                        if header.Find('-') then begin
                            if ((System.CurrentDateTime) < (header."Expected Closing Date")) then
                                Error('You cannot access this report at the moment');
                            comm.Reset();
                            comm.SetRange("No.", header."No.");
                            comm.SetRange("Committee Type", comm."Committee Type"::"Opening Commitee");
                            comm.SetRange("Opening Confirmed", false);
                            if comm.Find('-') then
                                Error('%1%2', comm.Name, 'has not confirmed opening the tender');

                            Report.Run(Report::"Tender/Bid Opening", true, false, header);

                        end;

                    end;

                }
            }

            group("Generate Bid")
            {
                action("Create A Bid")
                {
                    ApplicationArea = All;
                    Image = CreateDocuments;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    begin
                        procProcess.GenerateQuote(Rec);
                    end;
                }
            }

            group("Approval")
            {
                action("Send Approval")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    var
                        approvalmgt: Codeunit "Init Code";
                    begin
                        // if approvalmgt.IsPurchaseQuoteEnabled(Rec) = true then
                        //     approvalmgt.OnSendPurchaseQuoteforApproval(Rec)
                        // else
                        Message('Check Your workflow if enabled');


                    end;
                }
                action("Cancel Approval")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    var
                        approvalmgt: Codeunit "Init Code";
                    begin
                        if Confirm('Cancel Request ?', true) = false then Error('Cancelled');
                        //approvalmgt.OnCancelPurchaseQuoteforApproval(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = page "Fin-Approval Entries";
                    RunPageLink = "Document No." = field("No.");

                }

            }
            group(Attachments)
            {
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = category8;

                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
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

    trigger OnOpenPage()
    begin
        Editability := true;
        if Rec.Status <> Rec.Status::Open then begin
            Editability := false;
        end;
        QuoteVisible();
        Initializevariables();
        if rec."Has Evaluation" = rec."Has Evaluation"::Yes then
            CriteriaVisible1 := true else
            CriteriaVisible1 := false;

    end;

    trigger OnAfterGetCurrRecord()
    begin
        QuoteVisible();
        Initializevariables();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin


        Rec."Procurement methods" := Rec."Procurement methods"::"Two Stage Tender";
        Initializevariables();
        if rec."No." = '' then
            Purchasespaybles.reset();
        Purchasespaybles.SetRange("Doc Type", Purchasespaybles."Doc Type"::"Two Stage Tender");
        if Purchasespaybles.Find('-') then begin
            Newrefcode := Noseriesmgt.GetNextNo(Purchasespaybles."Number Series", Today, true);
            rec."No." := Purchasespaybles."Institution Code" + '/' + Purchasespaybles.FY + '/' + Purchasespaybles.Prefix + '-' + Newrefcode;
            Rec."Created By" := USERID;
            rec."Document Date" := Today;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        Rec."Procurement methods" := Rec."Procurement methods"::"Two Stage Tender";
    end;

    local procedure Initializevariables()
    begin
        case Rec."Has Evaluation" of
            Rec."Has Evaluation"::No:
                SetFieldsVisible(false);
            Rec."Has Evaluation"::Yes:
                SetFieldsVisible(true);
        end;
        case rec."Preliminary Evaluation" of
            Rec."Preliminary Evaluation"::No:
                SetFieldsVisible1(false);
            Rec."Preliminary Evaluation"::Yes:
                SetFieldsVisible1(true);
        end;
        case rec."Technical Evaluation" of
            Rec."Technical Evaluation"::No:
                SetFieldsVisible2(false);
            Rec."Technical Evaluation"::Yes:
                SetFieldsVisible2(true);
        end;
        case rec."Demonistration Evaluation" of

            Rec."Demonistration Evaluation"::No:
                SetFieldsVisible3(false);
            Rec."Demonistration Evaluation"::Yes:
                SetFieldsVisible3(true);
        end;
        case rec."Financial Evaluation" of
            Rec."Financial Evaluation"::No:
                SetFieldsVisible4(false);
            Rec."Financial Evaluation"::Yes:
                SetFieldsVisible4(true);
        end;


        case rec."Post-Qualification" of
            Rec."Post-Qualification"::No:
                SetFieldsVisible5(false);
            Rec."Post-Qualification"::Yes:
                SetFieldsVisible5(true);
        end;
        rec.CalcFields("Financial Evaluation Score");
        rec.CalcFields("Technical Passmark Score");



    end;

    local procedure SetFieldsVisible(CarVisible: Boolean)
    begin
        CriteriaVisible := CarVisible;
    end;

    local procedure SetFieldsVisible1(NewCarVisible: Boolean)
    begin
        Passmark := NewCarVisible;
    end;

    local procedure SetFieldsVisible2(NewCarVisible: Boolean)
    begin
        Passmark1 := NewCarVisible;

    end;

    local procedure SetFieldsVisible3(NewCarVisible: Boolean)
    begin

        Passmark2 := NewCarVisible;

    end;

    local procedure SetFieldsVisible4(NewCarVisible: Boolean)
    begin

        Passmark3 := NewCarVisible;
    end;

    local procedure SetFieldsVisible5(NewCarVisible: Boolean)
    begin

        Passmark4 := NewCarVisible;
    end;


    var
        [InDataSet]
        CriteriaVisible, Passmark, Passmark1, Passmark2, Passmark3, Passmark4, Passmark5, Fieldseditable : Boolean;
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
        CriteriaVisible1: Boolean;
        CriteriaVisible2: Boolean;
        CriteriaVisible3: Boolean;
        qvisible: Boolean;
        procProcess: Codeunit "Procurement Process";
        Newrefcode: Code[20];
        Purchasespaybles: Record "Proc Number Setups";
        Noseriesmgt: Codeunit NoSeriesManagement;

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

        end



    end;
}