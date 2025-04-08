// Table: Guest Registration
table 50170 "Guest Registration"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Visitor Name"; Text[100])
        {
        }
        field(3; "Reason for Visit"; Text[250])
        {
        }
        field(4; "Time In"; Time)
        {
        }
        field(5; "Time Out"; Time)
        {
        }
        field(6; "Vehicle Plate Number"; Code[20])
        {
        }
        field(7; "Is Staff"; Boolean)
        {
        }
        field(8; "ID No"; Code[20])
        {
        }
        field(9; "Phone No"; Code[20])
        {
        }
        //date
        field(10; "Date"; Date)
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
