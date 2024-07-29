table 52033 "Trainning Facilittaor"
{
    Caption = 'Trainning Facilittaor';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = '';
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Staff ID"; code[20])
        {
            TableRelation = "HRM-Employee C";
        }
        field(4; "Staff Name"; Text[200])
        {

        }
    }
    keys
    {
        key(PK; "No.", "Line No")
        {
            Clustered = true;
        }
    }
}
