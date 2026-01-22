page 50370 "HRM-Job Requirement Lines (B)"
{
    PageType = ListPart;
    SourceTable = "HRM-Job Requirement";
    InsertAllowed = true;
    DeleteAllowed = true;
    ModifyAllowed = true;

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
                field(Qualification; Rec.Qualification)
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

