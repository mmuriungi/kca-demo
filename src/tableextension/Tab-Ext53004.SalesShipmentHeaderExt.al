tableextension 53004 SalesShipmentHeaderExt extends "Sales Shipment Header"
{
    fields
    {
        field(60000; "Credit Sale"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(60001; "Document Amount"; Decimal)
        {
            Caption = 'Document Amount';
            CalcFormula = Sum("Sales Shipment Line"."Item Charge Base Amount" WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;

        }
        field(60002; "Cash Sale Order"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(60003; "Amount Paid"; Decimal)
        {

            CalcFormula = sum("Sales Header"."Cash Amount" where("No." = field("No.")));
            FieldClass = flowfield;
        }
        field(60004; "Period Month"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60005; "Paybill Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60006; "Sales Location Category"; Option)
        {

            OptionMembers = " ",Staff,Students;
            OptionCaption = ' ,Staff,Students';
            Caption = 'Sales Location Category';
            DataClassification = ToBeClassified;
        }

        field(60007; "Balance"; Decimal)
        {
            Caption = 'Balance';
            DataClassification = ToBeClassified;
        }

    }

}