tableextension 50042 "Vendor LedgersExt" extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        field(50000; "Custom Amount"; Decimal)
        {
            Caption = 'Custom Amounr';
            DataClassification = ToBeClassified;
        }
    }
}
