pageextension 50241 "Posted Purchase Receipts" extends "Posted Purchase Receipt"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addbefore("&Print")
        {
            /*  action("&Print Inspection cert")
             {
                 Caption = '&Print Inspection cert';
                 Ellipsis = true;
                 Image = Print;
                 ApplicationArea = All;
                 Promoted = true;
                 PromotedCategory = Process;
                 PromotedIsBig = true;

                 trigger OnAction()
                 begin
                     CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
                     PurchRcptHeader.PrintRecords(TRUE);

                     CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
                     PurchRcptHeader.PrintRecords(TRUE);
                     PurchRcptHeader.SETRANGE(PurchRcptHeader."No.", Rec."No.");
                     REPORT.RUN(50009, TRUE, FALSE, PurchRcptHeader);
                 end;
             } */
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