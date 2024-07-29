page 50245 "Evaluation Report"
{
    Caption = 'Evaluation Report';
    PageType = Card;
    SourceTable = "Proc Evaluation Report";
    RefreshOnActivate = true;
    PromotedActionCategories = 'New, Process, Report';
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
                    Editable = qedit;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Awarded Quote field.';
                }
                field("Bidder/Supplier"; Rec."Bidder/Supplier")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bidder/Supplier field.';
                }
                field(name; Rec.name)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the name field.';
                }


            }
            part("Confirmed"; "Proc-Confirm Recommended")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");

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

            action("Send for Confirmation")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Image = SelectEntries;
                trigger OnAction()
                begin
                    procProcess.SendEvaluationConf(rec."No.");
                end;
            }
            action("Report")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Report;
                trigger OnAction()
                var
                    Pheader: Record "Purchase Header";
                    Purchasequote: Record "Proc-Purchase Quote Header";
                    eval: Record "Proc Evaluation Report";
                begin
                    PurchHeader.Reset();
                    PurchHeader.SetRange("Request for Quote No.", rec."No.");
                    if PurchHeader.find('-') then begin
                          report.RunModal(Report::"Committee Eval Report", true, false, PurchHeader);
                        eval.Reset();
                        eval.SetRange("No.", Rec."No.");
                        if eval.Find('-') then;
                           // report.RunModal(Report::"Committee Eval Report", true, false, eval);
                        //Report.Run(Report::"Committee Eval Report", true, false, eval);
                    end;

                end;
            }



        }
    }


    trigger OnOpenPage()
    begin
        Quoteedit();
    end;



    trigger OnNewRecord(BelowxRec: Boolean)
    begin


        //Rec."Procurement methods" := Rec."Procurement methods"::"Open Tendering";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        // Rec."Procurement methods" := Rec."Procurement methods"::"Open Tendering";
    end;


    var
        quoteno: Code[50];
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

    procedure Quoteedit()
    var
        mem: Record "Proc-Committee Membership";
    begin
        qedit := true;
        if Rec.Confirmed = true then
            qedit := false;

    end;
}