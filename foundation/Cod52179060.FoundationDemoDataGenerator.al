codeunit 52179060 "Foundation Demo Data Generator"
{
    procedure GenerateFoundationDemoData()
    begin
        CreateFoundationSetup();
        CreateDemoDonors();
        CreateDemoCampaigns();
        CreateDemoDonations();
        CreateDemoPledges();
        CreateDemoGrants();
        CreateDemoScholarships();
        CreateDemoEvents();
        CreateDemoPartnerships();

        Message('Foundation demo data generated successfully!');
    end;

    local procedure CreateFoundationSetup()
    var
        FoundationSetup: Record "Foundation Setup";
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
    begin
        if not FoundationSetup.Get() then begin
            FoundationSetup.Init();
            FoundationSetup."Primary Key" := '';

            // Create number series
            CreateNumberSeries('DONOR', 'Donors', 'D-00001', 'D-99999');
            CreateNumberSeries('DONATION', 'Donations', 'DN-00001', 'DN-99999');
            CreateNumberSeries('CAMPAIGN', 'Campaigns', 'CP-00001', 'CP-99999');
            CreateNumberSeries('PLEDGE', 'Pledges', 'PL-00001', 'PL-99999');
            CreateNumberSeries('GRANT', 'Grants', 'GR-00001', 'GR-99999');
            CreateNumberSeries('SCHOLAR', 'Scholarships', 'SC-00001', 'SC-99999');
            CreateNumberSeries('EVENT', 'Events', 'EV-00001', 'EV-99999');
            CreateNumberSeries('PARTNER', 'Partnerships', 'PT-00001', 'PT-99999');

            FoundationSetup."Donor Nos." := 'DONOR';
            FoundationSetup."Donation Nos." := 'DONATION';
            FoundationSetup."Campaign Nos." := 'CAMPAIGN';
            FoundationSetup."Pledge Nos." := 'PLEDGE';
            FoundationSetup."Grant Nos." := 'GRANT';
            FoundationSetup."Scholarship Nos." := 'SCHOLAR';
            FoundationSetup."Event Nos." := 'EVENT';
            FoundationSetup."Partnership Nos." := 'PARTNER';

            FoundationSetup."Min. Major Donor Amount" := 100000;
            FoundationSetup."Bronze Level Amount" := 10000;
            FoundationSetup."Silver Level Amount" := 25000;
            FoundationSetup."Gold Level Amount" := 50000;
            FoundationSetup."Platinum Level Amount" := 100000;
            FoundationSetup."Diamond Level Amount" := 250000;

            FoundationSetup."Auto Send Acknowledgment" := true;
            FoundationSetup."Enable PayPal" := true;
            FoundationSetup."Enable M-Pesa" := true;

            FoundationSetup.Insert();
        end;
    end;

    local procedure CreateNumberSeries(SeriesCode: Code[20]; Description: Text[100]; StartingNo: Code[20]; EndingNo: Code[20])
    var
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
    begin
        if not NoSeries.Get(SeriesCode) then begin
            NoSeries.Init();
            NoSeries.Code := SeriesCode;
            NoSeries.Description := Description;
            NoSeries."Default Nos." := true;
            NoSeries."Manual Nos." := true;
            NoSeries.Insert();

            NoSeriesLine.Init();
            NoSeriesLine."Series Code" := SeriesCode;
            NoSeriesLine."Line No." := 10000;
            NoSeriesLine."Starting Date" := Today;
            NoSeriesLine."Starting No." := StartingNo;
            NoSeriesLine."Ending No." := EndingNo;
            NoSeriesLine."Increment-by No." := 1;
            NoSeriesLine.Open := true;
            NoSeriesLine.Insert();
        end;
    end;

    local procedure CreateDemoDonors()
    begin
        // Corporate Donors
        CreateDonor('Safaricom Foundation', 'foundation@safaricom.co.ke', "Foundation Donor Type"::Corporate, '', 0);
        CreateDonor('Equity Bank Foundation', 'foundation@equitybank.co.ke', "Foundation Donor Type"::Corporate, '', 0);
        CreateDonor('Kenya Commercial Bank Foundation', 'foundation@kcb.co.ke', "Foundation Donor Type"::Corporate, '', 0);

        // Alumni Donors
        CreateDonor('Dr. Mary Wanjiku', 'mary.wanjiku@gmail.com', "Foundation Donor Type"::Alumni, 'ALU1001', 2010);
        CreateDonor('Prof. James Mwangi', 'james.mwangi@yahoo.com', "Foundation Donor Type"::Alumni, 'ALU1002', 2005);
        CreateDonor('Sarah Njeri Kamau', 'sarah.kamau@hotmail.com', "Foundation Donor Type"::Alumni, 'ALU1003', 2015);

        // Individual Donors
        CreateDonor('John Smith', 'john.smith@email.com', "Foundation Donor Type"::Individual, '', 0);
        CreateDonor('Grace Wanjiru', 'grace.wanjiru@gmail.com', "Foundation Donor Type"::Individual, '', 0);
        CreateDonor('Peter Kiprotich', 'peter.kiprotich@email.com', "Foundation Donor Type"::Individual, '', 0);
        CreateDonor('Anne Muthoni', 'anne.muthoni@gmail.com', "Foundation Donor Type"::Individual, '', 0);
    end;

    local procedure CreateDonor(Name: Text[100]; Email: Text[80]; DonorType: Enum "Foundation Donor Type"; AlumniID: Code[20]; GraduationYear: Integer)
    var
        Donor: Record "Foundation Donor";
    begin
        Donor.Init();
        Donor."No." := '';
        Donor.Validate(Name, Name);
        Donor.Validate(Email, Email);
        Donor.Validate("Donor Type", DonorType);

        if AlumniID <> '' then begin
            Donor."Alumni ID" := AlumniID;
            Donor."Graduation Year" := GraduationYear;
            Donor.Faculty := GetRandomFaculty();
        end;

        Donor."Phone No." := '+254' + Format(Random(999999999), 9, '<Integer,9><Filler Character,0>');
        Donor.City := GetRandomCity();
        Donor."Country/Region Code" := 'KE';
        Donor."Donor Since" := CalcDate('-' + Format(Random(2000)) + 'D', Today);
        Donor."Marketing Opt-In" := Random(2) = 1;
        Donor."Newsletter Subscription" := Random(2) = 1;
        Donor."Event Invitations" := Random(2) = 1;

        Donor.Insert(true);
    end;

    local procedure CreateDemoCampaigns()
    begin
        CreateCampaign('Build the Future - Library Expansion', "Foundation Donation Purpose"::Library);
        CreateCampaign('Student Scholarship Fund 2024', "Foundation Donation Purpose"::Scholarship);
        CreateCampaign('Research Excellence Initiative', "Foundation Donation Purpose"::Research);
        CreateCampaign('Sports Complex Development', "Foundation Donation Purpose"::Sports);
        CreateCampaign('Emergency Student Support Fund', "Foundation Donation Purpose"::Emergency);
    end;

    local procedure CreateCampaign(Name: Text[100]; Purpose: Enum "Foundation Donation Purpose")
    var
        Campaign: Record "Foundation Campaign";
    begin
        Campaign.Init();
        Campaign."No." := '';
        Campaign.Validate(Name, Name);
        Campaign.Validate(Purpose, Purpose);
        Campaign."Start Date" := CalcDate('-' + Format(Random(90)) + 'D', Today);
        Campaign."End Date" := CalcDate('+' + Format(30 + Random(300)) + 'D', Today);
        Campaign."Goal Amount" := (Random(10) + 1) * 100000;
        Campaign."Budget" := Campaign."Goal Amount" * 0.1;
        Campaign.Status := "Foundation Campaign Status"::Active;
        Campaign."Campaign Manager" := UserId;
        Campaign.Insert(true);
    end;

    local procedure CreateDemoDonations()
    var
        Donation: Record "Foundation Donation";
        Donor: Record "Foundation Donor";
        Campaign: Record "Foundation Campaign";
        i: Integer;
        DonationCount: Integer;
    begin
        if Donor.FindSet() then
            repeat
                DonationCount := 1 + Random(3);
                for i := 1 to DonationCount do begin
                    Donation.Init();
                    Donation."No." := '';
                    Donation.Validate("Donor No.", Donor."No.");
                    Donation."Donation Date" := CalcDate('-' + Format(Random(365)) + 'D', Today);

                    case Donor."Donor Type" of
                        Donor."Donor Type"::Corporate:
                            Donation.Amount := (Random(50) + 10) * 10000;
                        Donor."Donor Type"::Alumni:
                            Donation.Amount := (Random(20) + 5) * 1000;
                        else
                            Donation.Amount := (Random(10) + 1) * 1000;
                    end;

                    if Random(2) = 1 then begin
                        Campaign.Reset();
                        Campaign.SetRange(Status, Campaign.Status::Active);
                        if Campaign.FindSet() then begin
                            Campaign.Next(Random(Campaign.Count()));
                            Donation."Campaign Code" := Campaign."No.";
                            Donation.Purpose := Campaign.Purpose;
                        end;
                    end else
                        Donation.Purpose := GetRandomPurpose();

                    Donation."Payment Method" := GetRandomPaymentMethod();
                    Donation.Status := Donation.Status::Received;
                    Donation."Tax Deductible" := Random(2) = 1;
                    Donation."Receipt No." := 'RCP' + Format(Random(99999), 5, '<Integer,5><Filler Character,0>');
                    Donation."Acknowledgment Sent" := Random(2) = 1;
                    if Donation."Acknowledgment Sent" then
                        Donation."Acknowledgment Date" := Donation."Donation Date" + Random(7);

                    Donation.Insert(true);
                end;
            until Donor.Next() = 0;
    end;

    local procedure CreateDemoPledges()
    var
        Pledge: Record "Foundation Pledge";
        Donor: Record "Foundation Donor";
    begin
        Donor.SetFilter("Donor Type", '%1|%2', Donor."Donor Type"::Corporate, Donor."Donor Type"::Alumni);
        if Donor.FindSet() then
            repeat
                if Random(10) <= 3 then begin
                    Pledge.Init();
                    Pledge."No." := '';
                    Pledge.Validate("Donor No.", Donor."No.");
                    Pledge."Pledge Date" := CalcDate('-' + Format(Random(180)) + 'D', Today);
                    Pledge."Start Date" := Pledge."Pledge Date";
                    Pledge."End Date" := CalcDate('+' + Format(1 + Random(3)) + 'Y', Pledge."Start Date");

                    case Donor."Donor Type" of
                        Donor."Donor Type"::Corporate:
                            Pledge.Amount := (Random(100) + 50) * 10000;
                        else
                            Pledge.Amount := (Random(50) + 10) * 1000;
                    end;

                    Pledge.Frequency := GetRandomFrequency();
                    Pledge.Purpose := GetRandomPurpose();
                    Pledge."Next Payment Date" := CalcDate('+1M', Pledge."Start Date");
                    Pledge.Status := "Foundation Pledge Status"::Active;

                    Pledge.Insert(true);
                end;
            until Donor.Next() = 0;
    end;

    local procedure CreateDemoGrants()
    begin
        CreateGrant('Research Innovation Grant');
        CreateGrant('Faculty Development Grant');
        CreateGrant('Student Research Grant');
        CreateGrant('Infrastructure Improvement Grant');
        CreateGrant('Technology Enhancement Grant');
    end;

    local procedure CreateGrant(GrantName: Text[100])
    var
        Grant: Record "Foundation Grant";
    begin
        Grant.Init();
        Grant."No." := '';
        Grant."Grant Name" := GrantName;
        Grant."Total Amount" := (Random(50) + 10) * 10000;
        Grant."Available Amount" := Grant."Total Amount";
        Grant."Start Date" := Today;
        Grant."End Date" := CalcDate('+2Y', Today);
        Grant."Application Deadline" := CalcDate('+3M', Today);
        Grant.Status := "Foundation Grant Status"::ApplicationOpen;
        Grant."Max Amount Per Applicant" := Grant."Total Amount" / (2 + Random(8));
        Grant."Min Amount Per Applicant" := Grant."Max Amount Per Applicant" / 2;
        Grant."Eligibility Criteria" := 'Must be enrolled student or faculty member';
        Grant.Insert(true);
    end;

    local procedure CreateDemoScholarships()
    begin
        CreateScholarship('Excellence Merit Scholarship');
        CreateScholarship('Need-Based Support Scholarship');
        CreateScholarship('Alumni Legacy Scholarship');
        CreateScholarship('First Generation College Scholarship');
        CreateScholarship('STEM Leadership Scholarship');
    end;

    local procedure CreateScholarship(ScholarshipName: Text[100])
    var
        Scholarship: Record "Foundation Scholarship";
    begin
        Scholarship.Init();
        Scholarship."No." := '';
        Scholarship."Scholarship Name" := ScholarshipName;
        Scholarship."Amount Per Student" := (Random(10) + 5) * 10000;
        Scholarship."No. of Awards" := 2 + Random(8);
        Scholarship."Total Budget" := Scholarship."Amount Per Student" * Scholarship."No. of Awards";
        Scholarship."Academic Year" := Format(Date2DMY(Today, 3)) + '/' + Format(Date2DMY(Today, 3) + 1);
        Scholarship."Application Start Date" := Today;
        Scholarship."Application End Date" := CalcDate('+2M', Today);
        Scholarship.Status := Scholarship.Status::Open;
        Scholarship."Min GPA" := 2.5 + (Random(15) / 10);
        Scholarship.Renewable := Random(2) = 1;
        Scholarship.Insert(true);
    end;

    local procedure CreateDemoEvents()
    begin
        CreateFoundationEvent('Annual Fundraising Gala', "Foundation Event Type"::Gala);
        CreateFoundationEvent('Alumni Homecoming Weekend', "Foundation Event Type"::AlumniReunion);
        CreateFoundationEvent('Donor Recognition Dinner', "Foundation Event Type"::DonorRecognition);
        CreateFoundationEvent('Chancellor''s Charity Golf Tournament', "Foundation Event Type"::GolfTournament);
        CreateFoundationEvent('CEO Cycling Challenge', "Foundation Event Type"::CyclingTour);
    end;

    local procedure CreateFoundationEvent(EventName: Text[100]; EventType: Enum "Foundation Event Type")
    var
        Events: Record "Foundation Event";
    begin
        Events.Init();
        Events."No." := '';
        Events."Event Name" := EventName;
        Events."Event Type" := EventType;
        Events."Event Date" := CalcDate('+' + Format(30 + Random(300)) + 'D', Today);
        Events."Start Time" := 180000T + Random(36000000);
        Events."End Time" := Events."Start Time" + 36000000;
        Events.Venue := GetRandomVenue();
        Events.City := GetRandomCity();
        Events."Target Amount" := (Random(20) + 5) * 100000;
        Events."Expected Attendance" := (Random(200) + 50);
        Events."Ticket Price" := (Random(50) + 10) * 1000;
        Events.Status := Events.Status::Scheduled;
        Events."Registration Required" := true;
        Events."Registration Deadline" := Events."Event Date" - 7;
        Events."Max Registrations" := Events."Expected Attendance";
        Events.Insert(true);
    end;

    local procedure CreateDemoPartnerships()
    begin
        CreatePartnership('World Bank Education Partnership', "Foundation Partnership Type"::Government);
        CreatePartnership('IBM Technology Innovation Partnership', "Foundation Partnership Type"::Corporate);
        CreatePartnership('University of Oxford Research Collaboration', "Foundation Partnership Type"::Academic);
        CreatePartnership('Kenya Red Cross Community Partnership', "Foundation Partnership Type"::Community);
        CreatePartnership('UNESCO Educational Excellence Partnership', "Foundation Partnership Type"::International);
    end;

    local procedure CreatePartnership(PartnerName: Text[100]; PartnershipType: Enum "Foundation Partnership Type")
    var
        Partnership: Record "Foundation Partnership";
    begin
        Partnership.Init();
        Partnership."No." := '';
        Partnership."Partner Name" := PartnerName;
        Partnership."Partnership Type" := PartnershipType;
        Partnership."Start Date" := CalcDate('-' + Format(Random(365)) + 'D', Today);
        Partnership."End Date" := CalcDate('+' + Format(1 + Random(4)) + 'Y', Partnership."Start Date");
        Partnership.Status := "Foundation Partnership Status"::Active;
        Partnership."Financial Commitment" := (Random(100) + 50) * 10000;
        Partnership."Agreement Date" := Partnership."Start Date";
        Partnership."Agreement Type" := Partnership."Agreement Type"::MOU;
        Partnership.Email := GetPartnerEmail(Partnership."Partner Name");
        Partnership."Phone No." := '+254' + Format(Random(999999999), 9, '<Integer,9><Filler Character,0>');
        Partnership."Primary Contact" := UserId;
        Partnership.Insert(true);
    end;

    // Helper procedures
    local procedure GetRandomFaculty(): Text[50]
    begin
        case Random(5) of
            0:
                exit('School of Business');
            1:
                exit('School of Education');
            2:
                exit('School of Pure and Applied Sciences');
            3:
                exit('School of Agriculture');
            4:
                exit('School of Natural Resources');
        end;
    end;

    local procedure GetRandomCity(): Text[30]
    begin
        case Random(7) of
            0:
                exit('Nairobi');
            1:
                exit('Mombasa');
            2:
                exit('Kisumu');
            3:
                exit('Nakuru');
            4:
                exit('Eldoret');
            5:
                exit('Nyeri');
            6:
                exit('Karatina');
        end;
    end;

    local procedure GetRandomPaymentMethod(): Option
    begin
        case Random(6) of
            0:
                exit(1); // Cash
            1:
                exit(2); // Bank Transfer
            2:
                exit(3); // Cheque
            3:
                exit(4); // Credit Card
            4:
                exit(6); // PayPal
            5:
                exit(7); // Mpesa
        end;
    end;

    local procedure GetRandomFrequency(): Option
    begin
        case Random(3) of
            0:
                exit(2); // Monthly
            1:
                exit(3); // Quarterly
            2:
                exit(5); // Annual
        end;
    end;

    local procedure GetRandomPurpose(): Enum "Foundation Donation Purpose"
    begin
        case Random(12) of
            0:
                exit("Foundation Donation Purpose"::GeneralFund);
            1:
                exit("Foundation Donation Purpose"::Scholarship);
            2:
                exit("Foundation Donation Purpose"::Research);
            3:
                exit("Foundation Donation Purpose"::Infrastructure);
            4:
                exit("Foundation Donation Purpose"::Equipment);
            5:
                exit("Foundation Donation Purpose"::Library);
            6:
                exit("Foundation Donation Purpose"::Sports);
            7:
                exit("Foundation Donation Purpose"::StudentWelfare);
            8:
                exit("Foundation Donation Purpose"::FacultyDevelopment);
            9:
                exit("Foundation Donation Purpose"::Innovation);
            10:
                exit("Foundation Donation Purpose"::Emergency);
            11:
                exit("Foundation Donation Purpose"::Endowment);
        end;
    end;

    local procedure GetRandomVenue(): Text[100]
    begin
        case Random(5) of
            0:
                exit('Appkings Solutions Main Hall');
            1:
                exit('Safari Park Hotel');
            2:
                exit('Villa Rosa Kempinski');
            3:
                exit('Windsor Golf & Country Club');
            4:
                exit('Nairobi National Museum');
        end;
    end;

    local procedure GetPartnerEmail(PartnerName: Text): Text[80]
    begin
        case PartnerName of
            'World Bank Education Partnership':
                exit('education@worldbank.org');
            'IBM Technology Innovation Partnership':
                exit('partnerships@ibm.com');
            'University of Oxford Research Collaboration':
                exit('partnerships@ox.ac.uk');
            'Kenya Red Cross Community Partnership':
                exit('partnerships@redcross.or.ke');
            'UNESCO Educational Excellence Partnership':
                exit('partnerships@unesco.org');
            else
                exit('info@partner.org');
        end;
    end;
}