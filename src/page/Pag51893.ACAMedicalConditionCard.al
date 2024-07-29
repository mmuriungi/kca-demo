page 51893 "ACA-Medical Condition Card"
{
    PageType = Card;
    SourceTable = "ACA-Medical Condition";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                }
                field(Family; Rec.Family)
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

