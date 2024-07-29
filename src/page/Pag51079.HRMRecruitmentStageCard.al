page 51079 "HRM-Recruitment  Stage Card"
{
    PageType = Card;
    SourceTable = "HRM-Recruitment Stages";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
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
        area(navigation)
        {
            group(Job)
            {
                action(Requirements)
                {
                    Caption = 'Requirements';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HRM-Stage Requirement Lines";
                    RunPageLink = "Stage Code" = FIELD(Code);
                }
            }
        }
    }
}

