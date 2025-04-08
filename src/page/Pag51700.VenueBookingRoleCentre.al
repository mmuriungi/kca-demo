page 50089 "Venue Booking Role Centre"
{
    Caption = 'Venue Booking Role Centre';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control1904484608; "Venue Booking Activities")
            {
                Caption = 'Venue Booking Activities';
                ApplicationArea = All;
            }
            part(Control1907692008; "My Venue Bookings")
            {
                Caption = 'My Venue Bookings';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action("Venue Bookings")
            {
                Caption = 'Venue Bookings';
                Image = Calendar;
                RunObject = Page "Venue Booking List";
                RunPageView = WHERE(Status = FILTER(New));
                ApplicationArea = All;
            }
            action("Pending Approval Bookings")
            {
                Caption = 'Pending Approval Bookings';
                Image = Approval;
                RunObject = Page "Venue Booking List";
                RunPageView = WHERE(Status = FILTER("Pending Approval"));
                ApplicationArea = All;
            }
            action("Allocated Venues")
            {
                Caption = 'Allocated Venues';
                Image = Allocate;
                RunObject = Page "Venue Booking List";
                RunPageView = WHERE(Status = FILTER(Approved));
                ApplicationArea = All;
            }
            action("Cancelled Venues")
            {
                Caption = 'Cancelled Venues';
                Image = Cancel;
                RunObject = Page "Venue Booking List";
                RunPageView = WHERE(Status = FILTER(Cancelled));
                ApplicationArea = All;
            }
            action("Rejected Venues")
            {
                Caption = 'Rejected Venues';
                Image = Reject;
                RunObject = Page "Venue Booking List";
                RunPageView = WHERE(Status = FILTER(Rejected));
                ApplicationArea = All;
            }
            action("Venue General Setup")
            {
                Caption = 'Venue General Setup';
                Image = Setup;
                RunObject = Page "Venue General Setup";
                ApplicationArea = All;
            }
            action("Venue Setup")
            {
                Caption = 'Venue Setup';
                Image = Setup;
                RunObject = Page "Venue Setup List";
                ApplicationArea = All;
            }
            action("Venue Booking Permissions")
            {
                Caption = 'Venue Booking Permissions';
                Image = Permission;
                RunObject = Page "Venue Booking Permissions";
                ApplicationArea = All;
            }
        }
        area(processing)
        {
            group("Venue Management")
            {
                Caption = 'Venue Management';
                Image = Administration;

                action("Create New Booking")
                {
                    Caption = 'Create New Booking';
                    Image = NewDocument;
                    RunObject = Page "Venue Booking Header";
                    RunPageMode = Create;
                    ApplicationArea = All;
                }
                action("Allocate Venues")
                {
                    Caption = 'Allocate Venues';
                    Image = Allocate;
                    RunObject = Page "Venue Booking List";
                    RunPageView = WHERE(Status = FILTER("Pending Approval"));
                    ApplicationArea = All;
                }
                action("Venue Status Report")
                {
                    Caption = 'Venue Status Report';
                    Image = Report;
                    RunObject = Report "Venue Status Report";
                    ApplicationArea = All;
                }
            }
            group("Common Requisitions")
            {
                Caption = 'Common Requisitions';

                action("Stores Requisitions")
                {
                    Caption = 'Stores Requisitions';
                    ApplicationArea = All;
                    RunObject = Page "PROC-Store Requisition";
                }
                action("Imprest Requisitions")
                {
                    Caption = 'Imprest Requisitions';
                    ApplicationArea = All;
                    RunObject = Page "FIN-Imprests List";
                }
                action("Transport Requisition")
                {
                    Caption = 'Transport Requisition';
                    RunObject = Page "FLT-Transport Req. List";
                    ApplicationArea = All;
                }
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    ApplicationArea = All;
                    RunObject = Page "CAT-Meal Booking List";
                }
            }
        }
    }
}

profile "Venue Booking"
{
    ProfileDescription = 'Venue Booking';
    RoleCenter = "Venue Booking Role Centre";
    Caption = 'Venue Booking Profile';
}
