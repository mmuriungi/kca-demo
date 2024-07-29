table 55705 "Displinary Committess REC"
{
    fields
    {
        field(1; "Case No."; Code[30])
        {

        }
        field(2; "Committe"; code[50])
        {

        }
        field(3; "Reccomendation Code"; code[50])
        {

        }

        field(4; "Recommendation Description"; text[250])
        {

        }
        field(5; "Recommendation Description2"; text[250])
        {

        }
        field(6; "Recommendation Date"; Date)
        {

        }
        field(7; "Recommendation Effective Date"; Date)
        {

        }
        field(8; "Reccomendation Effected"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Case No.", Committe, "Reccomendation Code")
        {

        }
    }
}