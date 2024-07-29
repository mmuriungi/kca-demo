table 54337 "Students Complain"
{
    Caption = 'Students Complain';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; no; Code[68])
        {
            Caption = 'no';
            TableRelation = customer."No.";
        }
        field(2; "Student  No"; Code[50])
        {
            Caption = 'Student  No';
        }
        field(3; "student name"; Code[50])
        {
            Caption = 'student name';
        }
        field(4; "student complain "; Text[160])
        {
            Caption = 'student complain ';
            Editable = false;
        }
        field(5; "completion  status"; Option)
        {
            Caption = 'completion  status';
            OptionMembers = " ",open,Complete,onProgress;
        }
        field(6; "student comment"; Text[160])
        {
            Caption = 'student comment';
        }
        field(7; "head of hostel comment"; Text[180])
        {
            Caption = 'head of hostel comment';
        }
    }
    keys
    {
        key(PK; no)
        {
            Clustered = true;
        }
    }
}
