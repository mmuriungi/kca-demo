table 50980 "Visitor Personal Items"
{
    Caption = 'Visitor Personal Items';

    fields
    {
        field(1; "Visitor Code"; Code[30])
        {
        }
        field(2; "Visitor ID"; Code[30])
        {
        }
        field(3; "Item Code"; Integer)
        {
            AutoIncrement = true;
        }
        field(4; "Item Description"; Text[150])
        {
        }
        field(5; "Serial No."; Code[50])
        {
        }
        field(6; Cleared; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Visitor Code", "Visitor ID", "Item Code")
        {
        }
    }

    fieldgroups
    {
    }
}

