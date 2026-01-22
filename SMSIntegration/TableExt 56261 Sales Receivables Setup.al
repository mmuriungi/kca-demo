tableextension 56261 "Sales & Receivables Setup SMS" extends "Sales & Receivables Setup"
{
    fields
    {
        field(56261; "SMS Campaign Nos."; Code[20])
        {
            Caption = 'SMS Campaign Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}