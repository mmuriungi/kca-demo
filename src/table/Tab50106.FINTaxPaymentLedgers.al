table 50106 "FIN-Tax Payment Ledgers"
{
    Caption = 'FIN-Tax Payment Ledgers';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
        field(2; "Tax Type"; Option)
        {
            Caption = 'Tax Type';

            OptionMembers = " ","W/Tax",VAT,Excise,Others,Retention,PAYE,Commision;
        }
        field(3; "Tax Pv No"; Code[20])
        {
            Caption = 'Tax Pv No';
        }
        field(4; "Paid Amount"; Decimal)
        {
            Caption = 'Paid Amount';
        }
        field(5; "Vendo No"; Code[20])
        {
            Caption = 'Vendo No';
        }
        field(6; "Vendor  Pv No"; Code[20])
        {
            Caption = 'Vendor  Pv No';
        }
        field(7; Reversed; Boolean)
        {

        }
        field(8; "Posting Date"; Date)
        {

        }
        field(9; Description; text[250])
        {

        }


    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}
