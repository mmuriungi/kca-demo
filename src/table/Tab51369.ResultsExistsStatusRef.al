table 51369 "Results Exists Status Ref"
{
    Caption = 'Results Exists Status Ref';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(57; "Results Exists Status"; Option)
        {
            Caption = 'Results Exists Status';
            OptionMembers = " ","Both Exists","CAT Only","Exam Only","None Exists";
        }
        field(58; "CAT Marks Exists"; Boolean)
        {
            Caption = 'CAT Marks Exists';
        }
        field(59; "Exam Marks Exists"; Boolean)
        {
            Caption = 'Exam Marks Exists';
        }
    }
    keys
    {
        key(PK; "Results Exists Status")
        {
            Clustered = true;
        }
    }
}
