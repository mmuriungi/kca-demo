reportextension 50104 "Bank Det.Trial Bal" extends "Bank Acc. - Detail Trial Bal."
{

    RDLCLayout = './Bank Acc. - Detail Trial Bal.rdl';

    dataset
    {

        add("Bank Account Ledger Entry")
        {
            column(Remarks; Remarks)
            {

            }
            column(Payee_Name; "Payee Name")
            {

            }
            column(Customer_Name; "Customer Name")
            {

            }
            column(Debit_Amount; "Debit Amount")
            {

            }
            column(Credit_Amount; "Credit Amount")
            {

            }
        }
    }




}









