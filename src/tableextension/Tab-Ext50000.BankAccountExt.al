tableextension 50000 "Bank Account Ext" extends "Bank Account"
{
    fields
    {
        // Add changes to table fields here
        field(56601; "Bank Type"; Option)
        {
            Caption = 'Bank Type';
            OptionCaption = 'Normal,Cash,Fixed Deposit,SMPA,Chq Collection';
            OptionMembers = Normal,Cash,"Fixed Deposit",SMPA,"Chq Collection";
        }
        field(56602; "Receipt No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
    }


}