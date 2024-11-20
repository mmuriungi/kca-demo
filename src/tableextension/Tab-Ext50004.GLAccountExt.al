tableextension 50004 "G/L Account Ext" extends "G/L Account"
{
    fields
    {
        // Add changes to table fields here
        field(56601; "Budget Controlled"; Boolean)
        {

        }
        field(56602; "Date Filters"; Date)
        {
            Caption = 'Date Filters';
            FieldClass = FlowFilter;

            TableRelation = "G/L Entry" where("Posting Date" = FIELD("Date Filter"));
        }
        field(50022; Commitment; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("FIN-Budget Entries"."Amount" WHERE("G/L Account No." = FIELD("No."), Date = FIELD("Date Filter"),
                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 code" = FIELD("Global Dimension 2 Filter"),
                        "G/L Account No." = FIELD(FILTER(Totaling)), "Dimension Set ID" = FIELD("Dimension Set ID Filter"),
                        "Budget Name" = FIELD("Budget Filter")));
        }

        field(50023; Encumberance; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("FIN-Budget Entries"."Amount" WHERE("G/L Account No." = FIELD("No."), Date = FIELD("Date Filter"),
                        "Global Dimension 1 code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 code" = FIELD("Global Dimension 2 Filter"),
                        "G/L Account No." = FIELD(FILTER(Totaling)), "Dimension Set ID" = FIELD("Dimension Set ID Filter"),
                        "Budget Name" = FIELD("Budget Filter")));
        }
    }

    var
        myInt: Integer;
}