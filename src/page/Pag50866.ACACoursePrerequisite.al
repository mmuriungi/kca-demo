page 50866 "ACA-Course Prerequisite"
{
    PageType = List;
    SourceTable = "ACA-Course Prerequisite";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Requirement; Rec.Requirement)
                {
                    ApplicationArea = All;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

