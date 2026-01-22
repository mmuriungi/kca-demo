page 50620 "PRL-View Filter Payrol"
{
    PageType = List;
    SourceTable = "PRL-Filter View Payroll";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                }
                field("View Payroll"; Rec."View Payroll")
                {
                }
            }
        }
    }

    actions
    {
    }
}

