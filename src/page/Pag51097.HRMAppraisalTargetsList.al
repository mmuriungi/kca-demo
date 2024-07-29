page 51097 "HRM-Appraisal Targets List"
{
    Editable = true;
    PageType = List;
    SourceTable = "HRM-Appraisal Targets";

    layout
    {
        area(content)
        {
            repeater(genaral)
            {
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
}

