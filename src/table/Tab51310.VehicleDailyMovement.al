table 51310 "Vehicle Daily Movement"
{
    Caption = 'Vehicle Daily Movement';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
        }
        field(4; Destination; Text[50])
        {
            Caption = 'Destination';
        }
        field(5; "Time Out"; Time)
        {
            Caption = 'Time Out';
        }
        field(6; "Milage Out"; Integer)
        {
            Caption = 'Milage Out';
        }
        field(7; "Time In"; Time)
        {
            Caption = 'Time In';
        }
        field(8; "Milage In"; Integer)
        {
            Caption = 'Milage In';
        }
        field(9; "Drivers Name"; Text[50])
        {
            Caption = 'Drivers Name';
        }
        field(10; "Gate Officer"; Text[50])
        {
            Caption = 'Gate Officer';
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
