pageextension 50240 "General Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {

            field("Cheque Bank"; Rec."Cheque Bank")
            {

            }

        }
    }
}