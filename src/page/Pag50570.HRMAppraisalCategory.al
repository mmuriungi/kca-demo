page 50570 "HRM-Appraisal Category"
{
    PageType = List;
    SourceTable = "HRM-APPRAISAL CATEGORY";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
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

