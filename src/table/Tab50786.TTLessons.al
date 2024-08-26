table 50786 "TT-Lessons"
{
    DrillDownPageID = "TT-Lessons";
    LookupPageID = "TT-Lessons";

    fields
    {
        field(1; "Lesson Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Lesson Order"; Integer)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End TIme"; Time)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Lesson Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

