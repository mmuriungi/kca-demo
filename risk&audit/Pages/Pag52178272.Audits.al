page 50110 Audits
{
    PageType = List;
    SourceTable = Audit;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description;rec. Description)
                {
                }
                field("Type of Audit"; rec."Type of Audit")
                {
                }
                field("Risk Assessment Rating"; rec."Risk Assessment Rating")
                {
                }
            }
        }
    }

    actions
    {
    }
}

