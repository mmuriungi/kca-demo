page 50872 "ACA-Student Comments"
{
    PageType = List;
    SourceTable = "ACA-Std Comments";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

