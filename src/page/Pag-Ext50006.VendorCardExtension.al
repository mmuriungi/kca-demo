pageextension 50006 "Vendor Card Extension" extends "Vendor Card"
{
    layout
    {
        addafter(Address)
        {
            //KRA page field
            field("Kra Pin";Rec."Kra Pin")
            {
                ApplicationArea = All;
            }
        }
    }
}
