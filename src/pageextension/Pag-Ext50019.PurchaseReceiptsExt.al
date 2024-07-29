pageextension 50019 "Purchase Receipts Ext" extends "Posted Purchase Receipts"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addbefore("&Print")
        {

        }
        addafter("&Print")
        {
            action("Print GRN")
            {
                ApplicationArea = All;
                Caption = 'Print GRN';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SETFILTER("No.", Rec."No.");
                    REPORT.RUN(50010, TRUE, TRUE, Rec);
                    Rec.RESET;
                end;
            }
            action("Print Inspection")
            {
                ApplicationArea = All;
                Caption = 'Print Inspection';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SETFILTER("No.", Rec."No.");
                    REPORT.RUN(50009, TRUE, TRUE, Rec);
                    Rec.RESET;
                end;
            }
        }
    }
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
}