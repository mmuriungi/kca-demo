// Table: Event Attendee
table 51246 "Event Attendee"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Event No."; Code[20])
        {
            Caption = 'Event No.';
            TableRelation = "CRM Event";
        }
        field(2; "Attendee No."; Code[20])
        {
            Caption = 'Attendee No.';
            TableRelation = Contact;
        }
        field(3; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
        }
        field(4; "Checked In"; Boolean)
        {
            Caption = 'Checked In';
        }
        field(5; "Check-in Time"; DateTime)
        {
            Caption = 'Check-in Time';
        }
    }

    keys
    {
        key(PK; "Event No.", "Attendee No.")
        {
            Clustered = true;
        }
    }
}
