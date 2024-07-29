table 54352 "Prac Evaluation questions"
{
    Caption = 'Prac Evaluation questions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Code[10])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = ,"EVALUATION OF LECTURER ON TEACHING BY STUDENTS","LECTURERS ATTENDANCE EVALUATION FORM";
        }
        field(4; Category; Option)
        {
            //OptionCaption = ',COURSE OUTLINE,CONTENT PRESENTATION,PERSONAL ATTRIBUTES,Numeric,COMMON AREAS OF ASSESMENT,CLASS MANAGEMENT AND LECTURE ASSESMENT,COURSES WITH PRACTICALS ONLY';
            OptionMembers = "Practical Experience";
        }
        field(5; Class; Option)
        {
            OptionMembers = Options,Description,Numeric;
        }
        field(7; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Semesters";
        }
    }
    keys
    {
        key(PK; ID, Semester)
        {
            Clustered = true;
        }
    }
}
