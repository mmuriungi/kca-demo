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
                field(Rating; rec.Rating)
                {
                }
                field(Descriptor; rec.Descriptor)
                {
                }
            }
        }
    }

    actions
    {
    }
}

