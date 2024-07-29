table 56010 "Feedback Response"
{
    fields
    {
        Field(1; "No."; Integer)
        {

            AutoIncrement = true;
        }
        Field(2; Code; Code[30])
        {

        }
        Field(3; Response; Text[200])
        {

        }
        Field(4; UserID; Code[20])
        {
            TableRelation = User;
        }
    }
    keys

    {

        key(key1; "No.", Code)
        {
            Clustered = true;
        }
    }
}