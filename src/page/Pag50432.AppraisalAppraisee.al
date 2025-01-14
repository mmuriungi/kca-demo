page 50432 "Appraisal Appraisee"
{
    CardPageID = "Appraisal Header";
    PageType = List;
    SourceTable = "Appraisal Card";
    SourceTableView = WHERE(Status = FILTER(Appraisee));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal Code"; Rec."Appraisal Code")
                {
                }
                field("Staff No"; Rec."Staff No")
                {
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                }
            }
        }
    }

    actions
    {
    }
}

