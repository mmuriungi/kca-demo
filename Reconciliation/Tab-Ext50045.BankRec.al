tableextension 50045 BankRec extends "Bank Acc. Reconciliation"
{
    fields
    {

        field(50000; "Unreconcile Statement Amount"; decimal)

        {
            Caption = 'Unreconcile Statement Amount';
            DataClassification = ToBeClassified;
        }
    }


}
