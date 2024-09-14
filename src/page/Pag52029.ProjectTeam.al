page 52029 "Project Team"
{
    PageType = List;
    SourceTable = "Project Team";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID No"; Rec."ID No")
                {
                }
                field("Full Name"; Rec."Full Name")
                {
                }
                field(Company; Rec.Company)
                {
                }
            }
        }
    }

    actions
    {
    }
}

