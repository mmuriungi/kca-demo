table 51063 "Teaching Practice Lines"
{
    Caption = 'Teaching Practice Lines';
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
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(4; Category; Option)
        {
            Caption = 'Category';
            OptionMembers = "Placement Of Students","Teaching Practice Experience",Remark;

        }
        field(5; Score; Option)
        {
            Caption = 'Score';
            OptionMembers = "Strongly Agree",Agree,"Partially Agree",Disagree,"Stronly Disagree";
        }
        field(6; Question; text[200])
        {

        }
    }
    keys
    {
        key(PK; "No.", Semester)
        {
            Clustered = true;
        }
    }
}
