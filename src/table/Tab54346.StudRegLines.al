table 54346 "Stud Reg Lines"
{
    Caption = 'Stud Reg Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; code[20])
        {

        }
        field(2; Semester; code[20])
        {

        }
        field(3; Process; text[300])
        {

        }
        field(4; Score; Option)
        {
            OptionMembers = Excellent,"Very Good","Good","Satisfactory","Needs Improvement",Poor;
        }
        field(5; Remark; text[100])
        {

        }
        field(6; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; "No.", "Line No.", Semester)
        {
            Clustered = true;
        }
    }
}
