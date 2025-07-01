tableextension 50044 "Bank Acc Recon Line Ext" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50000; "Reconciled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Open Type"; Option)
        {
            OptionMembers = " ",Unpresented,Uncredited;
        }
        field(50005; "Bank Ledger Entry Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Bank Statement Entry Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
}
