// Table: Event Feedback
table 51248 "Event Feedback"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Event No."; Code[20])
        {
            Caption = 'Event No.';
            TableRelation = "CRM Event";
        }
        field(3; "Attendee No."; Code[20])
        {
            Caption = 'Attendee No.';
            TableRelation = Contact;
        }
        field(4; "Rating"; Integer)
        {
            Caption = 'Rating';
            MinValue = 1;
            MaxValue = 5;
        }
        field(5; "Comment"; Text[250])
        {
            Caption = 'Comment';
        }
        field(6; "Feedback Date"; Date)
        {
            Caption = 'Feedback Date';
        }
        field(7; "Email"; Code[50])
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
