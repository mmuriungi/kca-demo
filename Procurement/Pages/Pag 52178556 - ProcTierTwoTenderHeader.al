page 52178556 "Proc-Tier Two Tender Header"
{
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Two Stage Tendering';
    PageType = Card;
    SourceTable = "PROC-Purchase Quote Header";
    PromotedActionCategories = 'New,Process, Report,Evaluation Matrix';
    layout
    {
        area(content)
        {
            group(General)
            {

                Caption = 'General';

                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field("Expected Closing Date"; Rec."Expected Closing Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field("Expected Opening Date"; Rec."Expected Opening Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No. field.';
                }
                field("Procurement methods"; Rec."Procurement methods")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement methods field.';
                }
                field("Expected Closing Date II"; Rec."Expected Closing Date II")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Closing Date field.';
                }
                field("Expected Opening Date II"; Rec."Expected Opening Date II")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Opening Date field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Has Evaluation"; Rec."Has Evaluation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Has Evaluation field.';
                    trigger OnValidate()
                    begin

                        // if rec."Has Evaluation" = rec."Has Evaluation"::Yes then
                        //  CriteriaVisible1 := true else
                        //  CriteriaVisible1 := false;
                    end;
                }
            }
            group("Two Tier Header")
            {
                Editable = false;
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
                Editable = false;
                ApplicationArea = All;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }

            part("Demo"; "Proc-Demo Qualif")
            {
                Editable = Editability;
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part("Fin"; "Proc-Financial Qualif")
            {
                Editable = false;
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
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


        }
    }

    actions
    {

        area(processing)
        {

            action("Financial Evaluation")
            {
                ApplicationArea = All;
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    if (rec."Has Evaluation" = rec."Has Evaluation"::Yes) and (rec."Financial Evaluation" = rec."Financial Evaluation"::Yes) then
                        procProcess.FinancialEvaluation(Rec."No.") else
                        Error('Financial evaluation is not set to yes');

                end;
            }

            group("Award")
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
                action("Evaluation Report")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = report;
                    Image = ApplicationWorksheet;
                    trigger OnAction()
                    begin
                        procProcess.EvaluationReport(Rec);
                    end;
                }
                action("Professional Opinion")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = report;
                    Image = ApplicationWorksheet;
                    trigger OnAction()
                    begin
                        Page.Run(Page::"PROC Proffesional Opinion", Rec);
                    end;
                }

            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        IF Rec.Status = Rec.Status::Released THEN BEGIN
            ERROR('The Tender has already been released you cannot delete records');
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
        Editability: Boolean;
        qvisible: Boolean;
        procProcess: Codeunit "Procurement Process";

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