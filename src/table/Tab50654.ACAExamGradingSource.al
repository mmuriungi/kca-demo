table 50654 "ACA-Exam Grading Source"
{
    DrillDownPageId = "ACA-Exam Grading Sources";
    LookupPageId = "ACA-Exam Grading Sources";
    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Exam Catregory"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Total Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Grade; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Pass; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Results Exists Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Both Exists,CAT Only,Exam Only,None Exists';
            OptionMembers = " ","Both Exists","CAT Only","Exam Only","None Exists";
        }
        field(12; "Consolidated Prefix"; Text[30])
        {
        }
        field(13; CatMarksExist; Boolean)
        {

        }
        field(14; ExamMarksExist; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Academic Year", "Exam Catregory", "Total Score", "Results Exists Status")
        {
        }
        key(Key2; Grade)
        {
        }
    }

    fieldgroups
    {
    }
}

