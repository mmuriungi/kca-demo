page 50427 "HRM-Committee Board Of Direc."
{
    PageType = ListPart;
    SourceTable = "HRM-Committee Board Of Direct.";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                }
                field(SurName; Rec.SurName)
                {
                }
                field(OtherNames; Rec.OtherNames)
                {
                }
                field(Designation; Rec.Designation)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}

