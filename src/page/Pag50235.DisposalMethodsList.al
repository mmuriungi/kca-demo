page 50235 "Disposal Methods List"
{
    PageType = List;
    SourceTable = "Disposal Methods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Disposal Methods"; Rec."Disposal Methods")
                {
                }
                field("Disposal Description"; Rec."Disposal Description")
                {
                }
                field(Date; Rec.Date)
                {
                }
            }
        }
    }

    actions
    {
    }
}

