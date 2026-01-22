table 50084 "FIN-Budget Quaterly Periods"
{
    DrillDownPageId = "Fin Quatery Budget Periods";
    LookupPageId = "Fin Quatery Budget Periods";
    fields
    {
        field(1; "Budget Name"; code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(100; "Q1 Budget Start Date"; Date)
        {
        }
        field(101; "Q1 Budget End Date"; Date)
        {
        }
        field(102; "Q2 Budget Start Date"; Date)
        {
        }
        field(103; "Q2 Budget End Date"; Date)
        {
        }
        field(104; "Q3 Budget Start Date"; Date)
        {
        }
        field(105; "Q3 Budget End Date"; Date)
        {
        }
        field(106; "Q4 Budget Start Date"; Date)
        {
        }
        field(107; "Q4 Budget End Date"; Date)
        {
        }
    }
}