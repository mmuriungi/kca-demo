table 51073 "Lec TakeOff Lines"
{
    Caption = 'Lec TakeOff Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {

        }
        field(2; "Semester"; code[20])
        {

        }
        field(3; "Lecturer Hall"; Code[20])
        {

        }
        field(4; "Programme"; code[20])
        {
            TableRelation = "ACA-Programme";
        }
        field(5; "Course Code"; code[20])
        {
            TableRelation = "ACA-Units/Subjects".Code where("Programme Code" = field(Programme));

        }
        field(6; "Course Name"; text[100])
        {

        }
        field(7; Department; code[20])
        {

        }
        field(8; "Lecturer"; code[20])
        {
            TableRelation = "ACA-Lecturers Units".Lecturer where(Unit = field("Course Code"), Semester = field(Semester));
        }
        field(9; Attended; Boolean)
        {

        }
        field(10; "Date Submitted"; Date)
        {

        }
        field(11; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; "No.", Semester, "Date Submitted", "Line No.")
        {
            Clustered = true;
        }
    }
}
