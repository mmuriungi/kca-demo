page 54957 "HMS-Setup Process Card"
{
    PageType = Card;
    SourceTable = "PROC-Store Requistion Header";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Request date"; Rec."Request date")
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

