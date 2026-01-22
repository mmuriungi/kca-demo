table 52178533 "Proc-Technical Qualif"
{
    // DrillDownPageId = "Proc-Technical Qualif";
    //LookupPageId = "Proc-Technical Qualif";
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
        field(5; "Maximum Score"; Decimal)
        {

        }
        field(6; "Satisfactory Score"; Decimal)
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