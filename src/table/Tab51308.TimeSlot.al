table 51308 "Time Slot"
{
    Caption = 'Time Slot';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Day of Week"; enum "Day of Week")
        {
            Caption = 'Day of Week';
        }
        field(3; "Start Time"; Time)
        {
            Caption = 'Start Time';
        }
        field(4; "End Time"; Time)
        {
            Caption = 'End Time';
        }
        field(5; "Duration (Hours)"; Decimal)
        {
            Caption = 'Duration (Hours)';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        CalculateDuration();
    end;

    trigger OnModify()
    begin
        CalculateDuration();
    end;

    local procedure CalculateDuration()
    begin
        "Duration (Hours)" := ("End Time" - "Start Time") / 3600000; // Convert milliseconds to hours
    end;
}