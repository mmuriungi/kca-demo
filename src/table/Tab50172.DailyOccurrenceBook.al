// Table: Daily Occurrence Book (OB)
table 50172 "Daily Occurrence Book"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Date"; Date)
        {
        }
        field(3; "Time"; Time)
        {
        }
        field(4; "Description"; Text[250])
        {
        }
        field(5; "Recorded By"; Code[50])
        {
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
