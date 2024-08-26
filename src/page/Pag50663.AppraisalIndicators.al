page  50663 "Appraisal Indicators"
{
    PageType = List;
    SourceTable = "HR Appraisal indicators";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field("Performance Indicator"; Rec."Performance Indicator")
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

