#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 99431 "POS Receipts List (Staff)"
{
    CardPageID = "POS Sales Card (Staff)";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "POS Sales Header";
    SourceTableView = where("Customer Type" = filter(Staff),
                            Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Income Account"; Rec."Income Account")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Payment Method"; Rec."Payment Method")
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
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(PrintCopy)
            {
                ApplicationArea = Basic;
                Caption = 'Print Copy';
                Image = PrintVoucher;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                begin
                    Clear(POSSalesHeader);
                    POSSalesHeader.Reset;
                    POSSalesHeader.SetRange("No.", Rec."No.");
                    if POSSalesHeader.Find('-') then
                        Report.Run(99413, true, false, POSSalesHeader);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SetFilter(Cashier, UserId);
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter(Cashier, UserId);
    end;

    var
        POSSalesHeader: Record "POS Sales Header";
}

