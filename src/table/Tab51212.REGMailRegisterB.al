table 51212 "REG-Mail Register (B)"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Subject of Doc."; Text[250])
        {
        }
        field(3; "Mail Date"; Date)
        {
        }
        field(4; Addressee; Code[50])
        {
        }
        field(5; "mail Time"; Time)
        {
        }
        field(6; Receiver; Code[50])
        {
        }
        field(7; "Addresee Type"; Option)
        {
            OptionMembers = External,Internal;
        }
        field(8; Comments; Text[250])
        {
        }
        field(9; "Doc type"; Option)
        {
            OptionMembers = Normal,Cheque;
        }
        field(10; "Cheque Amount"; Decimal)
        {
        }
        field(11; "Direction Type"; Option)
        {
            OptionMembers = "Incoming Mail (Internal)","Incoming Mail (External)","Outgoing Mail (Internal)","Outgoing Mail (External)";
        }
        field(12; "Folio Number"; Code[50])
        {
        }
        field(13; Received; Boolean)
        {
        }
        field(14; Dispatched; Boolean)
        {
        }
        field(15; "Dispatched by"; Code[50])
        {
        }
        field(16; "stamp cost"; Decimal)
        {
        }
        field(17; Email; Text[30])
        {
        }
        field(50000; "Doc Ref No."; Text[30])
        {
        }
        field(50001; "File Tab"; Text[200])
        {
        }
        field(50002; "Folio No"; Text[20])
        {
        }
        field(50003; "Person Recording"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

