tableextension 50019 "Customer Ext" extends Customer
{
    fields
    {
        field(50000; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
        }
        field(50001; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            DataClassification = ToBeClassified;
        }
        field(50002; "Account No"; Code[100])
        {
            Caption = 'Account No';
            DataClassification = ToBeClassified;
        }
    }
}
