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
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Type of Audit"; Rec."Type of Audit")
                {
                    ApplicationArea = All;
                }
                field("Risk Assessment Rating"; Rec."Risk Assessment Rating")
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

