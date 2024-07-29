table 52029 "MOU JIC"
{
    Caption = 'MOU JIC';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {

        }
        field(2; LineNo; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Full Names"; text[200])
        {

        }
        field(4; "E-mail"; text[20])
        {
            
        }
    }
    keys
    {
        key(PK; No, LineNo)
        {
            Clustered = true;
        }
    }
}
