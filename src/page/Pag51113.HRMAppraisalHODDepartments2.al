page 51113 "HRM-Appraisal HOD Departments2"
{
    PageType = List;
    SourceTable = "HRM-HOD Dept. Loading";

    layout
    {
        area(content)
        {
            repeater(General)
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

