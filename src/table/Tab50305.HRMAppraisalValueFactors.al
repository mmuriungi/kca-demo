table 50305 "HRM-Appraisal Value Factors"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Factor; Text[250])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = 'Values,Core Competencies,Managerial & Supervisory';
            OptionMembers = Values,"Core Competencies","Managerial & Supervisory";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

