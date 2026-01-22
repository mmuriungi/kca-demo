table 50105 "Fin-Witholding Tax Ledges"
{
    Caption = 'Fin-Witholding Tax Ledges';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
        field(2; "Vendor No"; Code[20])
        {
            Caption = 'Vendor No';
        }
        field(3; "Vendor Name"; Text[250])
        {
            Caption = 'Vendor Name';
        }
        field(4; "Vendor Pv No"; Code[20])
        {
            Caption = 'Vendor Pv No';
            // Caption = 'Paid Amount';

        }

        field(5; "Gl No"; Text[100])
        {
            Caption = 'Gl No';
        }
        field(6; "Invoice No"; Code[50])
        {
            Caption = 'Invoice No';
        }
        field(7; "Net  Amount"; Decimal)
        {
            Caption = 'Net  Amount';
        }
        field(8; "Vat Amount"; Decimal)
        {
            Caption = 'Vat Amount';
        }
        field(9; "Vat Withold"; Decimal)
        {
            Caption = 'Vat Withold';
        }
        field(10; "Paid Amount"; Decimal)
        {
            Caption = 'Paid Amount';
            FieldClass = FlowField;
            CalcFormula = sum("FIN-Tax Payment Ledgers"."Paid Amount" where("Vendor  Pv No" = field("Vendor Pv No"), "Vendo No" = field("Vendor No")));
        }
        field(11; "Pin No"; Text[100])
        {
            Caption = 'Pin No';
        }
        field(12; "Invoice Date"; Date)
        {
            Caption = 'Invoice Date';
        }
        field(13; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(14; "Tax Type"; Option)
        {
            Caption = 'Tax Type';
            OptionMembers = " ","W/Tax",VAT,Excise,Others,Retention,PAYE,Commision;
        }
        field(15; "Tax G/l "; Code[20])
        {
            Caption = 'Tax G/l';

        }
        field(16; "Tax Pv No"; Code[20])
        {
            Caption = 'Tax Pv No';
            FieldClass = FlowField;
            CalcFormula = lookup("FIN-Tax Payment Ledgers"."Tax Pv No" where("Vendor  Pv No" = field("Vendor Pv No"), "Vendo No" = field("Vendor No")));

        }
        field(17; Reversed; Boolean)
        {

        }
        field(18; "Fully Paid"; Boolean)
        {

        }
        field(19; "Posted By"; code[20])
        {

        }
        field(20; "Description"; text[250])
        {

        }
        field(21; Posted; Boolean)
        {

        }
        field(22; "Account Type"; Enum "Gen. Journal Account Type")
        {

        }
        field(23; "payment Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("FIN-Tax Payment Ledgers"."Posting Date" where("Vendor  Pv No" = field("Vendor Pv No"), "Vendo No" = field("Vendor No")));



        }

    }
    keys
    {
        key(PK; "Entry No", "Vendor No", "Net  Amount", "Vat Withold", "Vendor Pv No")
        {
            Clustered = true;
        }
        // KEY(kEY2; )
        // {

        // }
    }
}
