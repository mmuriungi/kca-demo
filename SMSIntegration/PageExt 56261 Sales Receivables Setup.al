pageextension 56261 "Sales & Receivables Setup SMS" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Quote Nos.")
        {
            field("SMS Campaign Nos."; Rec."SMS Campaign Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number series to use for SMS campaigns.';
            }
        }
    }
}