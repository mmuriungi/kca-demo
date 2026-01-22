table 50460 "Publications Recruitment"
{
    Caption = 'Publications Recruitment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job Application No"; Code[20])
        {
            TableRelation = "HRM-Job Applications (B)"."Application No";
        }
        field(6; "Publication Code"; Code[45])
        {
            Caption = 'Publication Code';
        }
        field(2; "Publication Category"; Option)
        {
            Caption = 'Publication Category';
            OptionMembers = "",Articles,Books,"Journal Articles";
        }
        field(3; "Number of Books"; Integer)
        {
            Caption = 'Number of Books';
        }
        field(4; "Number of Chapters"; Integer)
        {
            Caption = 'Number of Chapters';
        }
        field(5; "Publication Title"; Code[200])
        {
            Caption = 'Publication Title';
        }

    }
    keys
    {
        key(PK; "Job Application No", "Publication Title")
        {
            Clustered = true;
        }
    }
}
