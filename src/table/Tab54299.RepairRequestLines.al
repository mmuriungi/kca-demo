table 54299 "Repair Request Lines"
{
    Caption = 'Repair Request Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "lineNo"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "No."; code[20])
        {

        }
        field(3; "Description"; Text[200])
        {

        }
        field(4; "Repair Types"; Text[200])
        {
            TableRelation = "Type of Repair".Description;
        }
    }
    keys
    {
        key(PK; lineNo, "No.", "Repair Types")
        {
            Clustered = true;
        }
    }
}
