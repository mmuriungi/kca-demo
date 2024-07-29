page 51100 "HRM-Appraisal Targets"
{
    PageType = List;
    SourceTable = "HRM-Appraisal Targets";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Appraisal Job Code"; Rec."Appraisal Job Code")
                {
                }
                field("Appraisal Year Code"; Rec."Appraisal Year Code")
                {
                }
                field(Code; Rec.Code)
                {
                }
                field(Desription; Rec.Desription)
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

    var
        UnitsSubj: Record "HRM-Appraisal Targets";
}

