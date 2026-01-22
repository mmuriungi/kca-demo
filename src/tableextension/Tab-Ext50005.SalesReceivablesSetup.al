tableextension 50005 "Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(56601; "Cash Sale Nos."; code[20])
        {

        }
        field(56602; "Room Refund Payment Type"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(56603; "Room Booking G/L Account"; Code[50])
        {
            TableRelation = "G/L Account"."No.";
        }
    }
}