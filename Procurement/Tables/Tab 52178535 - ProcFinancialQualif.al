table 52178535 "Proc-Financial Qualif"
{
    DrillDownPageId = "Proc-Financial Qualif";
    LookupPageId = "Proc-Financial Qualif";
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

    }
    keys
    {
        key(pk; "Entry No.", "No.")
        {

        }
    }
}