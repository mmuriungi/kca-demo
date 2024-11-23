table 52178805 "Tender Demonstration Req"
{
    fields
    {
        field(1; "Tender No."; Code[30])
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
        field(5; "Maximum Score"; Decimal)
        {

        }

        field(6; "Score"; Decimal)
        {

        }
        field(7; "Remarks"; Text[200])
        {

        }
    }
    keys
    {
        key(key1; "Tender No.", Code)
        {

        }
    }
}