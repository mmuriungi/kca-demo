table 54838 "HMS-Off Duty"
{

    fields
    {
        field(1; "Treatment No."; Code[20])
        {
        }
        field(2; "Staff No"; Code[20])
        {
        }
        field(3; "Staff Name"; Text[30])
        {
        }
        field(4; "Off Duty Start Date"; Date)
        {
        }
        field(5; "Contact person"; Text[30])
        {
            FieldClass = Normal;
        }
        field(6; "Off Duty Reason Reason"; Text[250])
        {
        }
        field(7; "Referral Remarks"; Text[100])
        {
        }
        field(8; Status; Option)
        {
            FieldClass = Normal;
            OptionMembers = New,Referred,Released;
        }
        field(9; "No of days"; Decimal)
        {
        }
        field(10; "Patient No"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Treatment No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

