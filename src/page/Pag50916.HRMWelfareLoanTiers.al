page 50916 "HRM Welfare Loan Tiers"
{
    PageType = List;
    SourceTable = "HRM Welfare Loan Tiers";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lower Limit"; Rec."Lower Limit")
                {
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }

    actions
    {
    }
}

