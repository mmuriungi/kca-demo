table 52178811 "Tender Bidder Fin Reqs"
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
        field(6; "Quoted Amount"; Decimal)
        {

        }
        field(7; "Remarks"; Text[200])
        {

        }
        field(8; "Bid No."; code[50])
        {

        }
        field(9; "Bidder No."; code[50])
        {

        }
        field(10; "Total Bid Amount"; Decimal)
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