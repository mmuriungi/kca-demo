tableextension 50001 "Fixed Asset Ext" extends "Fixed Asset"
{
    fields
    {
        // Add changes to table fields here
        field(56601; "Barcode"; Code[30])
        {

        }
        field(56602; "Registration No."; text[10])
        {

        }
        field(56603; "Tag No"; code[50])
        {

        }
        field(56604; "Asset Code"; code[50])
        {

        }
        field(56605; "Asset Nos"; Code[50])
        {

        }
        field(56606; "Source of Funds"; text[100])
        {

        }
        field(56607; "Make or Model"; code[100])
        {

        }
        field(56608; "Date of Delivery"; date)
        {

        }
        field(56609; "Date Placed in Use"; date)
        {

        }
        field(56610; "Last Physical Check"; date)
        {

        }
        field(56611; "Replacement Date"; date)
        {

        }
        field(56612; "Depreciation Rate"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("FA Depreciation Book"."Declining-Balance %" where("FA No." = field("No.")));
        }
        field(56613; "Disposal Date"; Decimal)
        {

        }
        field(56614; "Disposal Amount"; Decimal)
        {

        }
        field(56615; "Notes"; text[250])
        {

        }
        field(56616; "Vendor"; code[20])
        {

        }
        field(56617; "Payment Voucher No."; code[20])
        {

        }
        field(56618; "Asset Description"; text[200])
        {

        }
        field(56619; "Serial No"; code[20])
        {

        }
        field(56620; "Current Location"; Text[100])
        {
            //TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(56621; "Purchase Amount"; Decimal)
        {

        }
        field(56622; "Responsible Officer"; text[100])

        {
            TableRelation = "HRM-Employee C"."No.";

        }
        field(56623; "Asset Condition"; Option)
        {
            OptionMembers = " ",Good,bad,serviceable,obsolete;
        }
        //Model,Manufacturer
        field(56624; "Model"; Text[100])
        {

        }
        field(56625; "Manufacturer"; Text[100])
        {

        }


        modify("Responsible Employee")
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        modify("Location Code")
        {
            Caption = 'Original Location';
        }


    }
}