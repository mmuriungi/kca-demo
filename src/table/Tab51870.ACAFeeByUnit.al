table 51870 "ACA-Fee By Unit"
{
    DrillDownPageID = "ACA-Fees By Unit";
    LookupPageID = "ACA-Fees By Unit";

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Stage Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(3; "Unit Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Programme Code"),
                                                           "Stage Code" = FIELD("Stage Code"));
        }
        field(4; "Settlemet Type"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(5; "Seq."; Integer)
        {
            NotBlank = true;
        }
        field(6; "Break Down"; Decimal)
        {
        }
        field(7; Remarks; Text[150])
        {
        }
        field(9; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(10; "Student Type"; Option)
        {
            OptionCaption = 'Full Time,Part Time,Distance Learning';
            OptionMembers = "Full Time","Part Time","Distance Learning";
        }
    }

    keys
    {
        key(Key1; "Programme Code", "Stage Code", "Unit Code", Semester, "Student Type", "Settlemet Type", "Seq.")
        {
        }
    }

    fieldgroups
    {
    }
}

