page 54868 "HMS Lab Test Results Parameter"
{
    PageType = List;
    SourceTable = "HMS Lab Test Results Parameter";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Results Parameters"; Rec."Results Parameters")
                {
                    ApplicationArea = All;
                }
                field("Normal Ranges"; Rec."Normal Ranges")
                {
                    ApplicationArea = All;
                }
                field(Results; Rec.Results)
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

