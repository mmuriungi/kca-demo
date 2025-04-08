page 52178285 "Audit Ratings"
{
    PageType = List;
    SourceTable = "Risk Rating";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Rating; Rating)
                {
                }
                field(Descriptor; Descriptor)
                {
                }
            }
        }
    }

    actions
    {
    }
}

