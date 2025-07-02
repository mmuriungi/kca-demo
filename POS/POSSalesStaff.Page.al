#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 99408 "POS Sales Staff"
{
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
                    Caption = 'Till Number/Service ID';
                }
                field("M-pesa Trans Missing"; Rec."M-pesa Trans Missing")
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
            group(Lines)
            {
                Caption = 'Lines';
                
                part(SalesLines; "POS Sales Lines") // Page 99411
                {
                    ApplicationArea = All;
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
                Caption = 'Print';
                Image = VendorContact;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Print the staff sales receipt.';

                trigger OnAction()
                var
                    SalesHeader: Record "POS Sales Header"; // Table 99408
                    POSRestaurantsPrintOut: Report "POS Restaurants PrintOut";
                begin
                    CurrPage.Update();
                    Rec.PostSale();
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    Report.Run(Report::"POS Restaurants PrintOut", false, true, SalesHeader);
                    CurrPage.Close();
                end;
            }
        }
    }

    trigger OnInit()
    begin
        InitializeStaffRecord();
    end;

    trigger OnOpenPage()
    begin
        InitializeStaffRecord();
    end;

    trigger OnAfterGetRecord()
    begin
        InitializeStaffRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec."No." = '' then begin
            PosSetup.Get();
            PosSetup.TestField("Sales No.");
            NoSeriesMgt.InitSeries(PosSetup."Sales No.", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
            InitializeStaffRecord();
        end;
    end;

    var
        PosSetup: Record "POS Setup"; // Table 99401
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PosLines: Record "POS Sales Lines"; // Table 99407
        GenJnlLine: Record "Gen. Journal Line";
        Batch: Record "Gen. Journal Batch";
        ItemLedger: Record "POS Item Ledger"; // Table 99403
        LineNo: Integer;

    local procedure InitializeStaffRecord()
    begin
        Rec.SetFilter("Customer Type", '=%1', Rec."Customer Type"::Staff);
        PosSetup.Get();
        Rec."Posting Description" := 'Staff Food sales on ' + Format(Today());
        Rec."Posting date" := Today();
        Rec.Cashier := UserId();
        Rec."Customer Type" := Rec."Customer Type"::Staff;
        Rec."Current Date Time" := CurrentDateTime;
        Rec."Cash Account" := PosSetup."Cash Account";
        Rec."Income Account" := PosSetup."Staff Sales Account";
        Rec.Validate("Income Account");
    end;
}