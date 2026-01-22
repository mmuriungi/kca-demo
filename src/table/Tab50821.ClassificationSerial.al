table 50064 "Classification. Serial"
{
    Caption = 'Classification. Serial';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Student Number"; Code[20])
        {
            Caption = 'Student Number';
            DataClassification = CustomerContent;
        }
        field(2; "Serial"; Integer)
        {
            Caption = 'Serial';
            DataClassification = CustomerContent;
        }
        field(3; "Option"; Code[20])
        {
            Caption = 'Option';
            DataClassification = CustomerContent;
        }
        field(4; "Prog. Code"; Code[20])
        {
            Caption = 'Prog. Code';
            DataClassification = CustomerContent;
        }
        field(5; "StatusOrder"; Integer)
        {
            Caption = 'Status Order';
            DataClassification = CustomerContent;
        }
        field(6; "Classification"; Code[250])
        {
            Caption = 'Classification';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student Number", "Prog. Code", "Option", Classification)
        {
            Clustered = true;
        }
    }
}