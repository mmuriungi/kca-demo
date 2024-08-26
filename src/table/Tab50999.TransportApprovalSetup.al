table 50999 "Transport Approval Setup"
{
    LookupPageId = "Transport Approval Setup";
    DrillDownPageId = "Transport Approval Setup";
    fields
    {
        field(1; "Department"; code[30])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(2; "Head of Department"; code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(3; "Registrar VC"; code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(4; "Head Of Transport"; code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
    }
}