pageextension 50037 "General journal Ext" extends "General Journal"
{
    layout
    {
        addafter(Comment)
        {
            field("Vendor Transaction Type"; Rec."Vendor Transaction Type")
            {
                ApplicationArea = All;
            }
        }
    }
}
