page 50448 "HRM-Job Shortlist Qualif."
{
    PageType = List;
    SourceTable = "HRM-ShortListQualifications";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("ShortList Type"; Rec."ShortList Type")
                {
                }
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

