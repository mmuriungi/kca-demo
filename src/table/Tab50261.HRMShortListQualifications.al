table 50261 "HRM-ShortListQualifications"
{
    Caption = 'HR Qualifications';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "PRL-Employee History";
    LookupPageID = "PRL-Employee History";

    fields
    {
        field(1; "ShortList Type"; Code[50])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("ShortListing Criteria"));
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
            NotBlank = true;
        }
        field(7; "Job Id"; Code[25])
        {
            DataClassification = ToBeClassified;

        }
        //"Desired Score"
        field(8; "Desired Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "ShortList Type", "Code", "Job Id")
        {
        }
    }

    fieldgroups
    {
    }
}

