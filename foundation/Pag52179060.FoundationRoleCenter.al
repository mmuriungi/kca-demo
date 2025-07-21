page 52179060 "Foundation Role Center"
{
    PageType = RoleCenter;
    Caption = 'Company Foundation';

    layout
    {
        area(RoleCenter)
        {
            // Welcome content would go in a CardPart if needed
            part("Headline"; "Headline RC Team Member")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(NewDonor)
            {
                ApplicationArea = All;
                Caption = 'New Donor';
                Image = New;
                RunObject = page "Foundation Donor Card";
                RunPageMode = Create;
                Promoted = true;
                PromotedCategory = New;
            }
            action(NewDonation)
            {
                ApplicationArea = All;
                Caption = 'New Donation';
                Image = Payment;
                RunObject = page "Foundation Donation Card";
                RunPageMode = Create;
                Promoted = true;
                PromotedCategory = New;
            }
            action(NewCampaign)
            {
                ApplicationArea = All;
                Caption = 'New Campaign';
                Image = Campaign;
                RunObject = page "Foundation Campaign Card";
                RunPageMode = Create;
                Promoted = true;
                PromotedCategory = New;
            }
            action(NewEvent)
            {
                ApplicationArea = All;
                Caption = 'New Event';
                Image = Calendar;
                RunObject = page "Foundation Event Card";
                RunPageMode = Create;
                Promoted = true;
                PromotedCategory = New;
            }
            action(NewPledge)
            {
                ApplicationArea = All;
                Caption = 'New Pledge';
                Image = Agreement;
                RunObject = page "Foundation Pledge Card";
                RunPageMode = Create;
                Promoted = true;
                PromotedCategory = New;
            }
        }

        area(Sections)
        {
            group(DonorManagement)
            {
                Caption = 'Donor & Alumni Management';

                action(Donors)
                {
                    ApplicationArea = All;
                    Caption = 'Donors';
                    RunObject = page "Foundation Donor List";
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action(AlumniDonors)
                {
                    ApplicationArea = All;
                    Caption = 'Alumni Donors';
                    RunObject = page "Foundation Donor List";
                    RunPageView = where("Donor Type" = const(Alumni));
                }
                action(CorporateDonors)
                {
                    ApplicationArea = All;
                    Caption = 'Corporate Donors';
                    RunObject = page "Foundation Donor List";
                    RunPageView = where("Donor Type" = const(Corporate));
                }
                action(MajorDonors)
                {
                    ApplicationArea = All;
                    Caption = 'Major Donors';
                    RunObject = page "Foundation Donor List";
                    RunPageView = where("Donor Category" = const(Major));
                }
            }

            group(FundraisingDonations)
            {
                Caption = 'Fundraising & Donations';

                action(Donations)
                {
                    ApplicationArea = All;
                    Caption = 'Donations';
                    RunObject = page "Foundation Donation List";
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action(Pledges)
                {
                    ApplicationArea = All;
                    Caption = 'Pledges';
                    RunObject = page "Foundation Pledge List";
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action(Campaigns)
                {
                    ApplicationArea = All;
                    Caption = 'Campaigns';
                    RunObject = page "Foundation Campaign List";
                }
            }

            group(GrantsScholarships)
            {
                Caption = 'Grants & Scholarships';

                action(Grants)
                {
                    ApplicationArea = All;
                    Caption = 'Grants';
                    RunObject = page "Foundation Grant List";
                }
                action(GrantApplications)
                {
                    ApplicationArea = All;
                    Caption = 'Grant Applications';
                    RunObject = page "Foundation Grant App. List";
                }
                action(Scholarships)
                {
                    ApplicationArea = All;
                    Caption = 'Scholarships';
                    RunObject = page "Foundation Scholarship List";
                }
                action(ScholarshipApplications)
                {
                    ApplicationArea = All;
                    Caption = 'Scholarship Applications';
                    RunObject = page "Foundation Scholar App List";
                }
            }

            group(EventsPartnerships)
            {
                Caption = 'Events & Partnerships';

                action(Events)
                {
                    ApplicationArea = All;
                    Caption = 'Events';
                    RunObject = page "Foundation Event List";
                }
                action(EventRegistrations)
                {
                    ApplicationArea = All;
                    Caption = 'Event Registrations';
                    RunObject = page "Foundation Event Reg. List";
                }
                action(Partnerships)
                {
                    ApplicationArea = All;
                    Caption = 'Partnerships';
                    RunObject = page "Foundation Partnership List";
                }
            }

            group(Communications)
            {
                Caption = 'Communications';

                action(CommunicationLog)
                {
                    ApplicationArea = All;
                    Caption = 'Communication Log';
                    RunObject = page "Foundation Communication List";
                }
            }

            group(Administration)
            {
                Caption = 'Administration';

                action(DemoDataGenerator)
                {
                    ApplicationArea = All;
                    Caption = 'Demo Data Generator';
                    RunObject = page "Foundation Demo Data";
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action(Setup)
                {
                    ApplicationArea = All;
                    Caption = 'Foundation Setup';
                    Image = Setup;
                    RunObject = page "Foundation Setup";
                    Promoted = true;
                    PromotedCategory = Category4;
                }
            }
        }

        area(Reporting)
        {
            group(DonorReports)
            {
                Caption = 'Donor Reports';

                action(DonorList)
                {
                    ApplicationArea = All;
                    Caption = 'Donor List';
                    Image = Report;
                    RunObject = report "Foundation Donor List";
                }
                action(DonorAnalysis)
                {
                    ApplicationArea = All;
                    Caption = 'Donor Analysis';
                    Image = Report;
                    RunObject = report "Foundation Donor Analysis";
                }
                action(MajorDonorsReport)
                {
                    ApplicationArea = All;
                    Caption = 'Major Donors';
                    Image = Report;
                    RunObject = report "Foundation Major Donors";
                }
                action(DonorStatement)
                {
                    ApplicationArea = All;
                    Caption = 'Donor Statement';
                    Image = Report;
                    RunObject = report "Foundation Donor Statement";
                }
            }

            group(DonationReports)
            {
                Caption = 'Donation Reports';

                action(DonationReport)
                {
                    ApplicationArea = All;
                    Caption = 'Donation Report';
                    Image = Report;
                    RunObject = report "Foundation Donation Report";
                }
                action(DonationSummary)
                {
                    ApplicationArea = All;
                    Caption = 'Donation Summary';
                    Image = Report;
                    RunObject = report "Foundation Donation Summary";
                }
                action(DonationHistory)
                {
                    ApplicationArea = All;
                    Caption = 'Donation History';
                    Image = Report;
                    RunObject = report "Foundation Donation History";
                }
            }
        }
    }
}