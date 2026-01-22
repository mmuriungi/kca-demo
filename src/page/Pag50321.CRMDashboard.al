// Page: CRM Dashboard
page 50321 "CRM Dashboard"
{
    PageType = RoleCenter;
    Caption = 'CRM Dashboard';

    layout
    {
        area(RoleCenter)
        {
            part(Headlines; "Headline RC CRM")
            {
                ApplicationArea = All;
            }
            part(EventMetrics; "Event Metrics")
            {
                ApplicationArea = All;
            }
            part(AlumniMetrics; "Alumni Metrics")
            {
                ApplicationArea = All;
            }
            part(UpcomingEvents; "Upcoming Events")
            {
                ApplicationArea = All;
            }
            part(RecentDonations; "Recent Donations")
            {
                ApplicationArea = All;
            }
            part(EventFeedback; "Event Feedback Chart")
            {
                ApplicationArea = All;
            }
            part(AlumniEngagement; "Alumni Engagement Chart")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(EventManagement)
            {
                Caption = 'Event Management';
                action(Events)
                {
                    ApplicationArea = All;
                    RunObject = page "CRM Event List";
                }
                action(Attendees)
                {
                    ApplicationArea = All;
                    RunObject = page "Event Attendee List";
                }
                action(EventFeedback)
                {
                    ApplicationArea = All;
                    RunObject = page "Event Feedback List";
                }
            }
            group(AlumniManagement)
            {
                Caption = 'Alumni Management';
                action(Alumni)
                {
                    ApplicationArea = All;
                    RunObject = page "ACA-Student Aluminae List";
                }
                action(Donations)
                {
                    ApplicationArea = All;
                    RunObject = page "Donation List";
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                action(EventReport)
                {
                    ApplicationArea = All;
                    RunObject = report "Event Report";
                }
                action(AlumniEngagementReport)
                {
                    ApplicationArea = All;
                    RunObject = report "Alumni Engagement Report";
                }
                action(DonationReport)
                {
                    ApplicationArea = All;
                    RunObject = report "Donation Report";
                }
            }
        }
    }
}
