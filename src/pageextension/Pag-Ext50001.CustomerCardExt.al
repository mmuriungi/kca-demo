pageextension 52178880 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addafter("E-Mail")
        {
            field(Password; Rec.Password)
            {
                ApplicationArea = all;

            }
        }
    }
}
