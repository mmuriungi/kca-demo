pageextension 50021 "G/L Account Card" extends "G/L Account Card"
{
    layout
    {
        addafter(Balance)
        {
            field("Budget Controlled"; Rec."Budget Controlled")
            {
                ApplicationArea = All;

                Editable = true;
            }
        }
    }
}