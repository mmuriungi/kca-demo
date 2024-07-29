tableextension 50006 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50000; "Deposit Slip No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Deposit No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }


    }

    var
        myInt: Integer;
}