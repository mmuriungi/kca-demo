page 51283 "Venue Booking Permissions"
{
    PageType = List;
    SourceTable = "Venue Booking Permissions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Id"; Rec."User Id")
                {
                }
                field("Can Edit/Create Venues"; Rec."Can Edit/Create Venues")
                {
                }
                field("Can Approve Booking"; Rec."Can Approve Booking")
                {
                }
                field("Can Edit Pending Bookings"; Rec."Can Edit Pending Bookings")
                {
                }
            }
        }
    }

    actions
    {
    }
}

