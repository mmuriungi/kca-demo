page 50406 "HRM-Board of Directors"
{
    PageType = Worksheet;
    SourceTable = "HRM-Board Of Directors";

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
                field("Other Names"; Rec."Other Names")
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

