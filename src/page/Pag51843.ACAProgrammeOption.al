page 51843 "ACA-Programme Option"
{
    PageType = List;
    SourceTable = "ACA-Programme Options";

    layout
    {
        area(content)
        {
            repeater(___)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

