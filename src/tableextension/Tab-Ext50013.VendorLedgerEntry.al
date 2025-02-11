tableextension 50013 "Vendor Ledger Entry" extends "Vendor Ledger Entry"
{
    fields
    {
        field(56601; "VAT Bus. Posting Group"; code[20])
        {

        }
        field(56602; "VAT %"; Decimal)
        {

        }
        field(56603; "VAT Prod. Posting Group"; code[20])
        {

        }
        field(56604; "Order No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56605; "Vendor Transaction Type"; Enum "Vendor Transaction Type")
        {
            DataClassification = ToBeClassified;
        }
    }
}