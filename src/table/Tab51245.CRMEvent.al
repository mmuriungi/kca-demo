// Table: CRM Event
table 51245 "CRM Event"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Name"; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; "Time"; Time)
        {
            Caption = 'Time';
        }
        field(5; "Location"; Text[100])
        {
            Caption = 'Location';
        }
        field(6; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(7; "Category"; Option)
        {
            Caption = 'Category';
            OptionMembers = Conference,Social,"Public Forum","Public Lecture";
        }
        field(8; "Registered Attendees"; Integer)
        {
            Caption = 'Registered Attendees';
            FieldClass = FlowField;
            CalcFormula = count("Event Attendee" where("Event No." = field("No.")));
        }
        field(9; "Checked-in Attendees"; Integer)
        {
            Caption = 'Checked-in Attendees';
            FieldClass = FlowField;
            CalcFormula = count("Event Attendee" where("Event No." = field("No."), "Checked In" = const(true)));
        }
        // field(10; "Feedback Score"; Decimal)
        // {
        //     Caption = 'Feedback Score';
        //     FieldClass = FlowField;
        //     CalcFormula = average("Event Feedback".Rating where("Event No." = field("No.")));
        // }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
