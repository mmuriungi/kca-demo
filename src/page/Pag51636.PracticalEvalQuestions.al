page 51636 "Practical Eval Questions"
{
    Caption = 'Practical Eval Questions';
    PageType = ListPart;
    SourceTable = "Prac Evaluation questions";
    //DeleteAllowed = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field(Class; Rec.Class)
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
