page 50122 "Audit Ratings"
{
    PageType = List;
    SourceTable = "Risk Rating";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                }
                field(Descriptor; Rec.Descriptor)
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

