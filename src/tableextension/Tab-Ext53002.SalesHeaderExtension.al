tableextension 53002 SalesHeaderExtension extends "Sales Header"
{
    fields
    {
        field(80000; "Cash Sale Order"; Boolean)
        {
            Caption = 'Cash Sale Order';
            DataClassification = ToBeClassified;
        }
        field(80001; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(80002; "Document Amount"; Decimal)
        {
            Caption = 'Document Amount';
            CalcFormula = Sum("Sales Line".Amount WHERE("Document Type" = FIELD("Document Type"),
                                                         "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(80003; "Sales Location Category"; Option)
        {

            OptionMembers = " ",Staff,Students;
            OptionCaption = ' ,Staff,Students';
            Caption = 'Sales Location Category';
            DataClassification = ToBeClassified;
        }

        field(80004; "Paybill Amount"; Decimal)
        {
            Caption = 'Paybill Amount';
            DataClassification = ToBeClassified;
        }
        field(80005; "Cash Amount"; Decimal)
        {
            Caption = 'Cash Amount';
            DataClassification = ToBeClassified;
        }
        field(80006; "Balance"; Decimal)
        {
            Caption = 'Balance';
            DataClassification = ToBeClassified;
        }
        field(80007; "Amount Paid"; Decimal)
        {
            Caption = 'Amount Paid';
            DataClassification = ToBeClassified;
        }
        field(80008; "Credit Sale"; Boolean)
        {
            Caption = 'Credit Sale';
            DataClassification = ToBeClassified;
        }
        field(80009; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;

        }


    }

}