table 52031 "Prerequsite Requirements"
{
    Caption = 'Prerequsite Requirements';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "lineNo"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Prerequisite Code"; code[20])
        {

        }
        field(3; "Prerequisite Score"; Code[20])
        {

        }
        field(4; "Work Experience"; text[200])
        {

        }
        field(5; "Application No"; code[20])
        {

        }
    }
    keys
    {
        key(PK; lineNo, "Application No")
        {
            Clustered = true;
        }
    }
}
