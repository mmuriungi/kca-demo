table 51022 "Design Request Lines"
{
    Caption = 'Desing Request Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Desing Req Code"; Code[20])
        {

        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Desing Request"; text[100])
        {

        }


    }
    keys
    {
        key(PK; "Desing Req Code", "Line No")
        {
            Clustered = true;
        }
    }
}
