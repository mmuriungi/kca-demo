page 51067 "HRM-Hiring Criteria"
{
    PageType = List;
    SourceTable = "HRM-Hiring Criteria";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application Code"; Rec."Application Code")
                {
                }
                field("Hiring Criteria"; Rec."Hiring Criteria")
                {
                }
            }
        }
    }

    actions
    {
    }
}

