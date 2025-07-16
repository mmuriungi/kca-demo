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
        //select
        field(50008; select; Boolean)
        {
            Caption = 'Select';
            DataClassification = ToBeClassified;
        }
        //Reference No
        field(50009; "Reference No"; code[200])
        {
            Caption = 'Reference No';
            DataClassification = ToBeClassified;
        }
        //Unreconcile Previously
        field(50010; "Unreconcile Previously"; Boolean)
        {
            Caption = 'Unreconcile Previously';
            DataClassification = ToBeClassified;
        }
        //Credit Amount
        field(50011; "Credit Amount"; Decimal)
        {
            Caption = 'Credit Amount';
            DataClassification = ToBeClassified;
        }
        //Debit Amount
        field(50012; "Debit Amount"; Decimal)
        {
            Caption = 'Debit Amount';
            DataClassification = ToBeClassified;
        }
    }
}
