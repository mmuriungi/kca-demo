page 50977 "HRM-Job Requirements (B)"
{
    PageType = ListPart;
    SourceTable = "HRM-Job Requirement";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Qualification Type"; Rec."Qualification Type")
                {
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                }
                field(Priority; Rec.Priority)
                {
                }
                field("Score ID"; Rec."Score ID")
                {
                }
            }
        }
    }

    actions
    {
    }
}

