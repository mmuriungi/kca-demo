page 50781 "ACA-Application Form Employ."
{
    PageType = ListPart;
    SourceTable = "ACA-Applic. Form Employment";

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                }
                field("To date"; Rec."To date")
                {
                    ApplicationArea = All;
                }
                field(Organisation; Rec.Organisation)
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
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

