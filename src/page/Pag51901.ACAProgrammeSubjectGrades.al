page 51901 "ACA-Programme Subject Grades"
{
    PageType = ListPart;
    SourceTable = "ACA-Programme Subject Grade";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Name"; Rec."Subject Name")
                {
                    ApplicationArea = All;
                }
                field("Mean Grade"; Rec."Mean Grade")
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

