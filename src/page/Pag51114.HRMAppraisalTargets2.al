page 51114 "HRM-Appraisal Targets2"
{
    PageType = List;
    SourceTable = "HRM-Appraisal Targets";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                }
                field(Desription; Rec.Desription)
                {
                }
                field("Appraisal Job Code"; Rec."Appraisal Job Code")
                {
                }
                field("Appraisal Year Code"; Rec."Appraisal Year Code")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
            }
        }
    }

    actions
    {
    }
}

