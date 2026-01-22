table 50773 "TT-Days"
{
    DrillDownPageID = "TT-Days List";
    LookupPageID = "TT-Days List";

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Day Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Day Order"; Integer)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; "Academic Year", Semester, "Day Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TTDailyLessons.RESET;
        TTDailyLessons.SETRANGE(Semester, Rec.Semester);
        TTDailyLessons.SETRANGE("Day Code", Rec."Day Code");
        IF TTDailyLessons.FIND('-') THEN TTDailyLessons.DELETEALL;
    end;

    var
        TTDailyLessons: Record "TT-Daily Lessons";
}

