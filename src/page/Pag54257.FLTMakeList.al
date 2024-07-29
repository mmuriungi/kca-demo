page 54257 "FLT-Make List"
{
    PageType = List;
    SourceTable = "FLT-Make";
    Caption = 'FLT-Make List';

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

