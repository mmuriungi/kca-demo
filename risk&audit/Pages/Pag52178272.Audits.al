page 52178272 Audits
{
    PageType = List;
    SourceTable = Audit;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Type of Audit"; "Type of Audit")
                {
                }
                field("Risk Assessment Rating"; "Risk Assessment Rating")
                {
                }
            }
        }
    }

    actions
    {
    }
}

