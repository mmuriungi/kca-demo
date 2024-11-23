table 52178803 "Tender Prelim Reqs"
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

        field(5; "Requirements Met?"; Boolean)
        {

        }
        field(6; Remarks; Text[200])
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