table 52178814 "Tender Series Setup"
{
    fields
    {
        field(1; "Primary Key"; Integer)
        {

        }
        field(2; "Tender No."; code[30])
        {
            TableRelation = "No. Series";
        }
        field(3; "Tender Submission No."; code[30])
        {
            TableRelation = "No. Series";
        }
    }
}