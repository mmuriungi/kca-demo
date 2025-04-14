table 51357 "Drill Down Answers"
{
    Caption = 'Drill Down Answers';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Semester Code"; Code[25])
        {
            Caption = 'Semester Code';
            TableRelation = "ACA-Semesters";
        }
        field(2; "Quiz No."; Integer)
        {
            Caption = 'Quiz No.';
        }
        field(3; Choice; Text[2048])
        {
            Caption = 'Choice';
        }
        field(4; "Survey Code"; Code[20])
        {
            Caption = 'Survey Code';
            TableRelation = "Survey Header"."Survey Code";
        }
        field(5; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; "Semester Code", "Quiz No.", "Survey Code", "Entry No")
        {
            Clustered = true;
        }
    }
}
