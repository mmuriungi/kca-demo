table 51371 "Timetable Holidays"
{
    Caption = 'Timetable Holidays';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Date"; Date)
        {
            Caption = 'Date';
            trigger OnValidate()
            var
                DayOfWeek: Record Date;
            begin
                //Get day of the week
                DayOfWeek.Get(DayOfWeek."Period Type"::Date, "Date");
                "Day of The week" := DayOfWeek."Period Name";
            end;
        }
        field(2; "Day of The week"; Text[50])
        {
            Caption = 'Day of The week';
        }
        field(3; "Holiday Name"; Text[100])
        {
            Caption = 'Holiday Name';
        }
    }
    keys
    {
        key(PK; "Date")
        {
            Clustered = true;
        }
    }
}
