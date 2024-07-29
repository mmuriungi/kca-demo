table 50061 "Tender Bidder Fin Reqs"
{
    fields
    {
        field(1; "Tender No."; code[30])
        {

        }
        field(2; "Code"; code[30])
        {

        }
        field(3; "Description"; Text[250])
        {

        }
        field(4; "Description 2"; Text[250])
        {

        }
        field(5; "Budgeted Value"; Decimal)
        {

        }
        field(7; "Quoted Amount"; Decimal)
        {

        }
        field(8; "Remarks"; Text[200])
        {

        }
        field(9; "Bid No."; code[50])
        {

        }
        field(10; "Bidder No."; code[50])
        {

        }
        field(11; "Total Bid Amount"; Decimal)
        {

        }
    }
    keys
    {
        key(Key1; "Tender No.", Code, "Bid No.", "Bidder No.")
        {

        }
    }
}