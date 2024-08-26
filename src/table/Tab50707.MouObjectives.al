table 50707 MouObjectives
{
    Caption = 'MouObjectives';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No"; Code[20])
        {

        }
        field(2; LineNo; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Objective; text[100])
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
