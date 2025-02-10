tableextension 50010 "Detailed Vendor Ext" extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        field(50000; "Vendor Transaction Type"; Enum "Vendor Transaction Type")
        {
            Caption = 'Vendor Transaction Type';
            DataClassification = ToBeClassified;
        }
    }
}
