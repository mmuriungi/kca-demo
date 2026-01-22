#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 99410 "POS Sales Header List"
{
    CardPageID = "POS Sales Header Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "POS Sales Header";

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
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Posting date"; Rec."Posting date")
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Rec.Cashier)
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
                field("Income Account"; Rec."Income Account")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

