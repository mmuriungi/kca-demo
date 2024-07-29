page 51116 "HRM-Appraisal Setup 3"
{
    PageType = Card;
    SourceTable = "HRM-Appraisal Res. Setup";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Category; Rec.Category)
                {
                }
                field(Code; Rec.Code)
                {
                }
                field(Desription; Rec.Desription)
                {
                }
                field("Max. Score"; Rec."Max. Score")
                {
                }
                field("% Contrib. Final Score"; Rec."% Contrib. Final Score")
                {
                }
            }
        }
    }

    actions
    {
    }
}

