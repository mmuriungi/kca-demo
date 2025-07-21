page 52179060 "Foundation Role Center"
{
    PageType = RoleCenter;
    Caption = 'Company Foundation';
    
    layout
    {
        area(RoleCenter)
        {
            // Welcome content would go in a CardPart if needed
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
    }
}