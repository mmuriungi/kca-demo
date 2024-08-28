page 50760 "ACA-Units Option Combination"
{
    PageType = List;
    SourceTable = "ACA-Units Options Combination";

    layout
    {
        area(content)
        {
            repeater(___)
            {
                field(Option; Rec.Option)
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

