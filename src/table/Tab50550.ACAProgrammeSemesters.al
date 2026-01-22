table 50550 "ACA-Programme Semesters"
{
    DrillDownPageID = "ACA-Programme Semesters";
    LookupPageID = "ACA-Programme Semesters";

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Semesters".Code;
        }
        field(3; Remarks; Text[150])
        {
        }
        field(4; Budget; Integer)
        {
        }
        field(5; Current; Boolean)
        {
        }
        //"Marks Entry Deadline"
        field(6; "Marks Entry Deadline"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Programme Code", Semester)
        {
        }
    }

    fieldgroups
    {
    }
}

