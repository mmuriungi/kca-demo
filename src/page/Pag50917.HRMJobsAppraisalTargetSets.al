page 50917 "HRM-Jobs Appraisal Target Sets"
{
    PageType = List;
    SourceTable = "HRM-Job Appraisal Target Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Target Code"; Rec."Target Code")
                {
                }
                field("Target Description"; Rec."Target Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

