page 52178840 "Tender Disq Preliminary Card"
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
            }
            part(SF; "Tender Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            part(ST; "Tender Submission List")

            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Tender No." = FIELD("No."), "Bid Status" = filter("Prelim Disqualif");
                Visible = bidVisable;
            }
        }
    }

    actions
    {

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