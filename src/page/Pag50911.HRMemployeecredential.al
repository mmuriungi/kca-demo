page 50911 "HRM-employee credential"
{
    PageType = CardPart;
    SourceTable = "HRM-Employee C";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                label(" ")
                {
                }
                field("Portal Password"; Rec."Portal Password")
                {
                    ExtendedDatatype = None;
                }
                field("Changed Password"; Rec."Changed Password")
                {
                }
            }
        }
    }

    actions
    {
    }
}

