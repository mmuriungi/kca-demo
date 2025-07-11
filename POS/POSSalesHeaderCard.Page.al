#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 99407 "POS Sales Header Card"
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
                Editable = true;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Amount"; Rec."Total Amount")
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
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Income Account"; Rec."Income Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = Basic;
                }
                field("M-pesa Trans Missing"; Rec."M-pesa Trans Missing")
                {
                    ApplicationArea = Basic;
                }
                field("M-Pesa Transaction Number"; Rec."M-Pesa Transaction Number")
                {
                    ApplicationArea = Basic;
                }
                field("Till Number"; Rec."Till Number")
                {
                    ApplicationArea = Basic;
                }
                field("Cash Account"; Rec."Cash Account")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account"; Rec."Bank Account")
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
            group(Lines)
            {
                Caption = 'Lines';

                part(SalesLines; "POS Sales Lines") // Page 99411
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No." = field("No."),
                                  "Posting date" = field("Posting date"),
                                  "Serving Category" = field("Customer Type");
                    Editable = IsEditable;
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
                Caption = 'Print';
                Image = PrintChecklistReport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Print or reprint the sales document.';

                trigger OnAction()
                var
                    SalesHeader: Record "POS Sales Header";
                begin
                    begin
                        SalesHeader.Reset();
                        SalesHeader.SetRange("No.", Rec."No.");
                        SalesHeader.SetRange(Posted, true);
                        Report.Run(Report::"POS Students_Staff PrintOut", true, false, SalesHeader);
                    end;

                    CurrPage.Close();
                end;
            }
            action("Manual Post")
            {
                trigger OnAction()
                begin
                    if not Rec.Posted then begin
                        Rec.PostSale();
                    end
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetEditableStatus();
    end;

    trigger OnAfterGetRecord()
    begin
        SetEditableStatus();
    end;

    var
        PosSetup: Record "POS Setup"; // Table 99401
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PosLines: Record "POS Sales Lines"; // Table 99407
        GenJnlLine: Record "Gen. Journal Line";
        Batch: Record "Gen. Journal Batch";
        ItemLedger: Record "POS Item Ledger"; // Table 99403
        LineNo: Integer;
        IsEditable: Boolean;

    local procedure SetEditableStatus()
    begin
        IsEditable := true;
        if Rec.Posted then
            IsEditable := false;
    end;
}