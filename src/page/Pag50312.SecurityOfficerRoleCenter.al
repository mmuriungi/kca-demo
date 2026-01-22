// Page: Security Officer Role Center
page 50312 "Security Officer Role Center"
{
    PageType = RoleCenter;
    Caption = 'Security Officer';

    layout
    {
        area(RoleCenter)
        {
            part(Headlines; "Headline RC Security Officer")
            {
                ApplicationArea = All;
            }
            part(Activities; "Security Activities Cue")
            {
                ApplicationArea = All;
            }
            part(GuestRegistrationChart; "Guest Registration Chart")
            {
                ApplicationArea = All;
            }
            part(RecentIncidents; "Recent Incidents List")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(SecurityManagement)
            {
                Caption = 'Security Management';
                action(GuestRegistration)
                {
                    ApplicationArea = All;
                    Caption = 'Guest Registration';
                    RunObject = page "Guest Registration List";
                }
                action(IncidentReports)
                {
                    ApplicationArea = All;
                    Caption = 'Incident Reports';
                    RunObject = page "Incident Report List";
                }
                action(DailyOccurrenceBook)
                {
                    ApplicationArea = All;
                    Caption = 'Daily Occurrence Book';
                    RunObject = page "Daily Occurrence Book List";
                }
                action("Vehicle Logs")
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle Daily Movement';
                    RunObject = page "Vehicle Daily Movement List";
                }
            }
            group("Security Setups")
            {
                action("Security Setup")
                {
                    ApplicationArea = All;
                    RunObject = page "Security Setup";
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                action(GuestRegisterReport)
                {
                    ApplicationArea = All;
                    Caption = 'Guest Register Report';
                    RunObject = report "Periodic Guest Register";
                }
                action(IncidentReport)
                {
                    ApplicationArea = All;
                    Caption = 'Incident Report';
                    RunObject = report "Periodic Incident Report";
                }
            }
        }
        area(Embedding)
        {
            action(EmbedGuestRegistration)
            {
                ApplicationArea = All;
                Caption = 'Guest Registration';
                RunObject = page "Guest Registration List";
            }
            action(EmbedIncidentReports)
            {
                ApplicationArea = All;
                Caption = 'Incident Reports';
                RunObject = page "Incident Report List";
            }
            action(EmbedDailyOccurrenceBook)
            {
                ApplicationArea = All;
                Caption = 'Daily Occurrence Book';
                RunObject = page "Daily Occurrence Book List";
            }
        }
    }
}
