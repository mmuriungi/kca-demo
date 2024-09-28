table 51302 "Certificate Issuance Setup"
{
    Caption = 'Certificate Issuance Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Pk; Code[10])
        {
            Caption = 'Pk';
        }
        field(2; "Issuance Nos"; Code[20])
        {
            Caption = 'Issuance Nos';
        }
        field(3; "Replacement Fee"; Decimal)
        {
            Caption = 'Replacement Fee';
        }
        field(4; "Storage Fee"; Decimal)
        {
            Caption = 'Storage Fee';
        }
        field(5; "Storage Fee Frequency"; Decimal)
        {
            Caption = 'Storage Fee Frequency';
        }
        field(6; "Transcript Re-issuance Fee"; Decimal)
        {
            Caption = 'Transcript Re-issuance Fee';
        }
        field(7; "Transcript Pick-Up Duration"; DateFormula)
        {
            Caption = 'Transcript Pick-Up Duration';
        }
        //Storage fees account, Replacement Fees Account,Replacement Fee Account, Transcript Re-issuance Fee Acc. 
        field(8; "Storage Fees Account"; Code[20])
        {
            Caption = 'Storage Fees Account';
            TableRelation = "G/L Account";
        }
        field(9; "Replacement Fees Account"; Code[20])
        {
            Caption = 'Replacement Fees Account';
            TableRelation = "G/L Account";
        }
        field(10; "Replacement Fee Account"; Code[20])
        {
            Caption = 'Replacement Fee Account';
            TableRelation = "G/L Account";
        }
        field(11; "Transcript Re-issuance Fee Acc."; Code[20])
        {
            Caption = 'Transcript Re-issuance Fee Account';
            TableRelation = "G/L Account";
        }


    }
    keys
    {
        key(PK; Pk)
        {
            Clustered = true;
        }
    }
}
