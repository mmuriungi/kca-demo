page 51198 "HRM-Emp. Performance Target"
{
    PageType = ListPart;
    SourceTable = "HRM-Emp. Performance Target";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                }
                field("Code"; Rec.Code)
                {
                }
                field(Target; Rec.Target)
                {
                }
                field("Appraisee Rating"; Rec."Appraisee Rating")
                {
                }
                field("Appraiser Rating"; Rec."Appraiser Rating")
                {
                }
                field("Agreed Rating"; Rec."Agreed Rating")
                {
                }
                field("Maximum Rating"; Rec."Maximum Rating")
                {
                }
                field("Total Targets"; Rec."Total Targets")
                {
                }
                field("Total Rating"; Rec."Total Rating")
                {
                }
                field("Overall Rating"; Rec."Overall Rating")
                {
                }
                field(Barriers; Rec.Barriers)
                {
                }
                field("Action Plan"; Rec."Action Plan")
                {
                }
            }
        }
    }

    actions
    {
    }
}

