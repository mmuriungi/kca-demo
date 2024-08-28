page 50363 "Tribes List"
{
    PageType = List;
    SourceTable = Tribes;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tribe Code"; Rec."Tribe Code")
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

