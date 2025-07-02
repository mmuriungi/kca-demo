#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 99430 "POS Sales Card (Staff)"
{
    DeleteAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "POS Sales Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; Rec."Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Till Number"; Rec."Till Number")
                {
                    ApplicationArea = Basic;
                }
                field("M-Pesa Transaction Number"; Rec."M-Pesa Transaction Number")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Code';
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(Control1000000008)
            {
                part(Control1000000018; "POS Sales Lines")
                {
                    SubPageLink = "Document No." = field("No."),
                                  "Posting date" = field("Posting date"),
                                  "Serving Category" = field("Customer Type");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Print)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = VendorContact;
                trigger OnAction()
                begin
                    CurrPage.UPDATE();
                    Rec.PostSale();
                    saleheader.RESET();
                    saleheader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(REPORT::"POS Restaurants PrintOut", FALSE, TRUE, saleheader);

                    CurrPage.CLOSE;
                end;

            }
        }
    }
    var

    saleheader: Record "POS Sales Header";
    itemledger: Record "POS Item Ledger";
    LineNo: Integer;
    Batch: Record "Gen. Journal Batch";
    GenJnLine: Record "Gen. Journal Line";
    posLines: Record "POS Sales Lines";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    PosSetup: Record "POS Setup";
}