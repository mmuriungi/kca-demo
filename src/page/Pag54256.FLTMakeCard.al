page 54256 "FLT-Make Card"
{
    PageType = List;
    SourceTable = "FLT-Make";
    Caption = 'FLT-Make Card';

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
            }
        }
    }

    actions
    {
    }
}

