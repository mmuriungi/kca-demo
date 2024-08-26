page 50513 "HRM-Appraisal Evaluation Line"
{
    PageType = ListPart;
    SourceTable = "HRM-Appraisal Evaluations";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Evaluation Code"; Rec."Evaluation Code")
                {
                }
                field(Category; Rec.Category)
                {
                }
                field("Sub Category"; Rec."Sub Category")
                {
                }
                field("Evaluation Description"; Rec."Evaluation Description")
                {
                }
                field(Score; Rec.Score)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }

    actions
    {
    }
}

