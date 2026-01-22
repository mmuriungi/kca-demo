table 50640 "ACA-Programme Graduation Group"
{
    DrillDownPageID = "ACA-Programme Grad. Groups";
    LookupPageID = "ACA-Programme Grad. Groups";

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Admission Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year";
        }
        field(3; "Graduation Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year";
        }
        field(4; "Number of Students Admitted"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Academic Year is Current"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Programme Code", "Admission Academic Year")
        {
        }
    }

    fieldgroups
    {
    }
}

