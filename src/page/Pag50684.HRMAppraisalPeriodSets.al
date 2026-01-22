page 50684 "HRM-Appraisal Period Sets"
{
    PageType = List;
    SourceTable = "HRM-Appraisal Periods Set";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Order; Rec.Order)
                {
                }
                field("Period Code"; Rec."Period Code")
                {
                }
                field("Period Description"; Rec."Period Description")
                {
                }
                field("Period Month"; Rec."Period Month")
                {
                }
            }
        }
    }

    actions
    {
    }
}

