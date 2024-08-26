table 51057 "Lec Experience Lines"
{
    Caption = 'Lec Experience Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Semester; Code[20])
        {
            Caption = 'Semester';
        }
        field(3; "PF No."; Code[20])
        {
            Caption = 'PF No.';
        }
        field(4; Question; Text[100])
        {
            Caption = 'Question';
        }
        field(5; Score; Option)
        {
            Caption = 'Score';
            OptionMembers = "Strongly Agree",Agree,Neutral,Disagree,"Strongly Disagree";
        }
        field(6; "Comment(s)"; Text[100])
        {
            Caption = 'Comment(s)';
        }
        field(7; Type; Option)
        {
            OptionMembers = "Teaching Experience","Teaching and Learning","Practical Teaching",General;
        }
    }
    keys
    {
        key(PK; "No.", "PF No.", Semester)
        {
            Clustered = true;
        }
    }
}
