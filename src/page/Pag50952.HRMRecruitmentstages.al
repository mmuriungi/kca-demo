page 50952 "HRM-Recruitment stages"
{
    PageType = ListPart;
    SourceTable = "HRM-Recruitment Stages (B)";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Recruitement Stage"; Rec."Recruitement Stage")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Failed Response Templates"; Rec."Failed Response Templates")
                {
                }
                field("Passed Response Templates"; Rec."Passed Response Templates")
                {
                }
            }
        }
    }

    actions
    {
    }
}

