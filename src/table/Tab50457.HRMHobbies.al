table 50457 "HRM-Hobbies"
{
    Caption = 'HRM-Hobbies';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "PF No"; code[20])
        {

        }
        field(2; "line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Category; Option)
        {
            OptionMembers = " ",Talent,Hobby;
        }
        field(4; Description; Text[100])
        {

        }
    }
    keys
    {
        key(PK; "PF No", "line No")
        {
            Clustered = true;
        }
    }
}
