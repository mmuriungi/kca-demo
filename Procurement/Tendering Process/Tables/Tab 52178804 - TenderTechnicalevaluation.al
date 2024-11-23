table 52178804 "Tender Technical evaluation"
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
        field(5; "Maximum Score"; Decimal)
        {

        }
        field(6; score; Decimal)
        {

        }
        field(7; "Remarks"; Text[200])
        {

        }


    }

    keys
    {
        key(Key1; "Tender No.", Code)
        {

        }
    }
}