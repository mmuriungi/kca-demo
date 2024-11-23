table 51314 "HRM-Staff Tansfer"
{
    Caption = 'HRM-Staff Tansfer';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Staff No."; Code[50])
        {
            Caption = 'Staff No.';
        }
        field(2; "Type of transfer"; Option)
        {
            Caption = 'Type of transfer';
            OptionMembers= ,"Temporary",Permanent;
        }
        field(3; "Previous Designation"; Text[40])
        {
            Caption = 'Previous Designation';
        }
        field(4; "Current Office"; Text[40])
        {
            Caption = 'Current Office';
        }
        field(5; "Current Designition"; Text[40])
        {
            Caption = 'Current Designition';
        }
        field(6; "Reason for Transfer/Deployment"; Text[70])
        {
            Caption = 'Reason for Transfer/Deployment';
        }
        field(7; "Previous Office"; Text[40])
        {
            Caption = 'Previous Office';
        }
        field(8; "Payable Allowances"; Option)
        {
            Caption = 'Payable Allowances';
            OptionMembers= ,Settling,Passage,Baggage;
        }
        field(9;Date;Date)
        {
            
        }
    }
    keys
    {
        key(PK; "Staff No.")
        {
            Clustered = true;
        }
    }
}
