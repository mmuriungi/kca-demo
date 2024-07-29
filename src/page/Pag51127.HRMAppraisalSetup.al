page 51127 "HRM-Appraisal Setup"
{
    PageType = List;
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

