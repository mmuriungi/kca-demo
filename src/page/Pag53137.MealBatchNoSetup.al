page 53137 "Meal Batch No. Setup"
{
    PageType = List;
    SourceTable = "Batch number Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Class"; Rec."Product Class")
                {
                }
                field("Batch No. Series"; Rec."Batch No. Series")
                {
                }
                field("Expiration computation"; Rec."Expiration computation")
                {
                }
            }
        }
    }

    actions
    {
    }
}

