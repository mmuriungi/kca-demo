page 50574 "HRM-Appraisal HOD Det"
{
    PageType = List;
    SourceTable = "HRM-HOD Dept. Loading";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal Job Code"; Rec."Appraisal Job Code")
                {
                }
                field("Appraisal Period Code"; Rec."Appraisal Period Code")
                {
                }
                field("Appraisal Target"; Rec."Appraisal Target")
                {
                }
                field("Appraisal Target Description"; Rec."Appraisal Target Description")
                {
                }
                field(HOD; Rec.HOD)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}

