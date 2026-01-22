table 51019 MeeingAgenda
{
    Caption = 'MeeingAgenda';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Meeting Code"; Code[20])
        {

        }
        field(2; LineNo; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Agenda Item"; text[200])
        {

        }
    }
    keys
    {
        key(PK; "Meeting Code", LineNo)
        {
            Clustered = true;
        }
    }
}
