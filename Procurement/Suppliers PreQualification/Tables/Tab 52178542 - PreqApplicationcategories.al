table 52178542 "Preq Application categories"
{
    LookupPageId = "Preq Application categories";
    DrillDownPageId = "Preq Application categories";
    fields
    {
        field(1; "VAT Registration"; Code[30])
        {

        }
        field(2; "Period"; Code[30])
        {
            TableRelation = "Proc-Prequalification Years"."Preq. Year";
        }
        field(3; Category; Code[30])
        {
            TableRelation = "Proc-Prequalif. Categories"."Category Code";
        }

        field(4; "Prequalified"; Boolean)
        {

        }
        field(5; "Category Approved"; Option)
        {
            OptionMembers = " ",Approved,Rejected;
        }
    }

    keys
    {
        key(pk; "VAT Registration", Period, Category)
        {

        }
    }
}