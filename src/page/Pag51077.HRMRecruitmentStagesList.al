page 51077 "HRM-Recruitment Stages List"
{
    CardPageID = "HRM-Recruitment  Stage Card";
    Editable = false;
    PageType = List;
    SourceTable = "HRM-Recruitment Stages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

