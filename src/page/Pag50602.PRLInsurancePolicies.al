page 50602 "PRL-Insurance Policies"
{
    PageType = List;
    SourceTable = "PRL-InsurancePolicies";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Policy Number"; Rec."Policy Number")
                {
                }
                field("Insurance Code"; Rec."Insurance Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Deduct premium"; Rec."Deduct premium")
                {
                }
                field(balance; Rec.balance)
                {
                }
            }
        }
    }

    actions
    {
    }
}

