table 50082 "Online Class Preference"
{
    Caption = 'Online Class Preference';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Unit Code"; Code[25])
        {
            Caption = 'Unit Code';
            TableRelation = "ACA-Units/Subjects";
        }
        field(2; "Year of Study"; Integer)
        {
            Caption = 'Year of Study';
        }
        field(3; "Schedule Priority"; option)
        {
            Caption = 'Schedule Priority';
            OptionMembers = "Physical First","Online First";
        }
    }
    keys
    {
        key(PK; "Unit Code", "Year of Study")
        {
            Clustered = true;
        }
    }
}
