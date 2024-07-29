pageextension 50009 "Customer  cardExt" extends "Customer Card"
{
    layout
    {
        addbefore("Prepayment %")
        {
            field("Bank Code"; Rec."Bank Code") { ApplicationArea = all; }
            field("Branch Code"; Rec."Branch Code") { ApplicationArea = all; }
            field("Account No"; Rec."Account No") { ApplicationArea = all; }

        }

    }
}
