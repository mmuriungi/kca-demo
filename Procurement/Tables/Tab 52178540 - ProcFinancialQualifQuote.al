table 52178540 "Proc-Financial Qualif.Quote"
{
    DrillDownPageId = "Proc-Financial Qualif.Quote";
    LookupPageId = "Proc-Financial Qualif.Quote";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "No."; Code[30])
        {

        }
        field(3; "Description"; Text[500])
        {

        }
        field(4; "Can Exempt"; Boolean)
        {

        }
        field(5; "Budgeted Amount"; Decimal)
        {

        }

        field(6; "Quote No."; Code[30])
        {

        }
        field(7; "Quoted Amount"; Decimal)
        {
            /* FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Line Amount" where("Document No." = field("Quote No."))); */
            Editable = false;
        }
        field(8; "Tender Quoted Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Tender Submission Lines".Amount where("Document No." = field("Quote No.")));
            Editable = false;
        }
        field(9; "Lowest Quoted Price"; Decimal)
        {
        }
        field(10; "Maximum Marks"; Decimal)
        {
        }
        field(11; "Score"; Decimal)
        {
        }
        field(12; "Quote Status"; Option)
        {
            OptionMembers = Pending,Submitted,Preliminary,Technical,Demonstration,Financials,Failed;
        }
    }
    keys
    {
        key(pk; "Entry No.", "No.", "Quote No.")
        {

        }
    }
}