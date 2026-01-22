page 52130 "Vice Chancellor Role Center"
{
    Caption = 'Vice Chancellor Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(ApprovalsActivities; "Approvals Activities")
            {
                Caption = 'Requests to Approve';
                ApplicationArea = Suite;
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action("Requests to Approve")
            {
                Caption = 'Requests to Approve';
                RunObject = Page "Requests to Approve";
                ApplicationArea = All;
            }
        }
    }
}