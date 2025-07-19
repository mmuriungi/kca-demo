codeunit 52179000 "CRM Demo Data Generator"
{
    procedure GenerateCustomers()
    var
        Customer: Record "CRM Customer";
        Segmentation: Record "CRM Segmentation";
        i: Integer;
    begin
        // Generate segmentation data first
        GenerateSegmentation();
        
        // Generate 100 demo customers
        for i := 1 to 100 do begin
            Customer.Init();
            Customer."No." := 'DEMO' + Format(i, 6, '<Integer,6><Filler Character,0>');
            Customer."Customer Type" := GetRandomCustomerType();
            Customer."First Name" := GetRandomFirstName();
            Customer."Last Name" := GetRandomLastName();
            Customer."Email" := LowerCase(Customer."First Name" + '.' + Customer."Last Name" + '@demo.com');
            Customer."Phone No." := '+254' + Format(Random(999999999), 9, '<Integer,9><Filler Character,0>');
            Customer."Mobile Phone No." := '+254' + Format(Random(999999999), 9, '<Integer,9><Filler Character,0>');
            Customer."Address" := GetRandomAddress();
            Customer."City" := GetRandomCity();
            Customer."County" := GetRandomCounty();
            Customer."Country/Region Code" := 'KE';
            Customer."Post Code" := Format(Random(99999), 5, '<Integer,5><Filler Character,0>');
            Customer."Date of Birth" := CalcDate('<-' + Format(Random(50) + 18) + 'Y>', WorkDate());
            Customer."Gender" := GetRandomGender();
            Customer."Marital Status" := GetRandomMaritalStatus();
            Customer."Nationality" := 'KE';
            Customer."Lead Source" := GetRandomLeadSource();
            Customer."Lead Status" := GetRandomLeadStatus();
            Customer."Lead Score" := Random(100);
            Customer."Preferred Contact Method" := GetRandomContactMethod();
            Customer."Segmentation Code" := GetRandomSegmentationCode();
            Customer."Engagement Score" := Random(100);
            Customer."VIP" := (Random(10) = 1); // 10% chance of being VIP
            Customer."Email Opt-In" := (Random(10) > 2); // 80% chance
            Customer."SMS Opt-In" := (Random(10) > 3); // 70% chance
            Customer."Phone Opt-In" := (Random(10) > 5); // 50% chance
            Customer."Academic Program" := GetRandomAcademicProgram();
            Customer."Academic Year" := GetRandomAcademicYear();
            Customer."Company Name" := GetRandomCompanyName();
            Customer."Job Title" := GetRandomJobTitle();
            Customer."Annual Income" := Random(2000000) + 100000;
            Customer."Tags" := GetRandomTags();
            Customer."Notes" := 'Demo customer generated on ' + Format(CurrentDateTime);
            Customer."GDPR Consent Date" := CurrentDateTime;
            Customer."Satisfaction Score" := Random(10) + 1;
            
            if Customer.Insert(true) then begin
                GenerateInteractionHistory(Customer."No.");
                GenerateTransactionHistory(Customer."No.");
                GenerateCampaignResponses(Customer."No.");
                GenerateSupportTickets(Customer."No.");
            end;
        end;
        
        GenerateLeads();
        GenerateCampaigns();
    end;
    
    local procedure GenerateSegmentation()
    var
        Segmentation: Record "CRM Segmentation";
        SegmentationList: List of [Text];
        SegmentText: Text;
    begin
        SegmentationList.Add('YOUNG_PROFESSIONALS|Young Professionals|Demographic|Age 25-35, Career-focused');
        SegmentationList.Add('SENIOR_EXECUTIVES|Senior Executives|Demographic|Age 40+, Management positions');
        SegmentationList.Add('RECENT_GRADUATES|Recent Graduates|Academic|Graduated within last 2 years');
        SegmentationList.Add('RETURNING_STUDENTS|Returning Students|Academic|Career changers, upgrading skills');
        SegmentationList.Add('INTERNATIONAL|International Students|Geographic|Non-Kenyan students');
        SegmentationList.Add('HIGH_ENGAGERS|High Engagers|Engagement|Frequent website visitors, event attendees');
        SegmentationList.Add('DONORS|Active Donors|Revenue Based|Regular financial contributors');
        SegmentationList.Add('ALUMNI_NETWORK|Alumni Network|Academic|Graduated students');
        
        foreach SegmentText in SegmentationList do begin
            Segmentation.Init();
            Segmentation.Code := CopyStr(SelectStr(1, SegmentText), 1, 20);
            Segmentation.Description := CopyStr(SelectStr(2, SegmentText), 1, 100);
            if SelectStr(3, SegmentText) = 'Demographic' then
                Segmentation."Segmentation Type" := Segmentation."Segmentation Type"::Demographic
            else if SelectStr(3, SegmentText) = 'Academic' then
                Segmentation."Segmentation Type" := Segmentation."Segmentation Type"::Academic
            else if SelectStr(3, SegmentText) = 'Geographic' then
                Segmentation."Segmentation Type" := Segmentation."Segmentation Type"::Geographic
            else if SelectStr(3, SegmentText) = 'Engagement' then
                Segmentation."Segmentation Type" := Segmentation."Segmentation Type"::Engagement
            else if SelectStr(3, SegmentText) = 'Revenue Based' then
                Segmentation."Segmentation Type" := Segmentation."Segmentation Type"::"Revenue Based";
            
            Segmentation.Criteria := CopyStr(SelectStr(4, SegmentText), 1, 250);
            Segmentation.Active := true;
            Segmentation."Marketing Priority" := Segmentation."Marketing Priority"::Medium;
            if not Segmentation.Insert(true) then
                Segmentation.Modify(true);
        end;
    end;
    
    local procedure GenerateInteractionHistory(CustomerNo: Code[20])
    var
        InteractionLog: Record "CRM Interaction Log";
        i: Integer;
        NumInteractions: Integer;
    begin
        NumInteractions := Random(10) + 1; // 1-10 interactions per customer
        
        for i := 1 to NumInteractions do begin
            InteractionLog.Init();
            InteractionLog."Customer No." := CustomerNo;
            InteractionLog."Interaction Type" := GetRandomInteractionType();
            InteractionLog."Interaction Date" := CalcDate('<-' + Format(Random(365)) + 'D>', WorkDate());
            InteractionLog."Interaction Time" := Time;
            InteractionLog."Contact Method" := GetRandomContactMethod();
            InteractionLog.Subject := GetRandomInteractionSubject();
            InteractionLog.Description := 'Demo interaction logged for testing purposes.';
            InteractionLog."Duration (Minutes)" := Random(60) + 5;
            InteractionLog.Outcome := GetRandomInteractionOutcome();
            InteractionLog."Follow-up Required" := (Random(10) < 3); // 30% chance
            if InteractionLog."Follow-up Required" then
                InteractionLog."Follow-up Date" := CalcDate('<+' + Format(Random(30) + 1) + 'D>', InteractionLog."Interaction Date");
            InteractionLog.Priority := GetRandomPriority();
            InteractionLog."Evaluation Score" := Random(5) + 1;
            InteractionLog.Completed := (Random(10) > 1); // 90% completed
            InteractionLog."Customer Rating" := Random(10) + 1;
            InteractionLog.Insert(true);
        end;
    end;
    
    local procedure GenerateTransactionHistory(CustomerNo: Code[20])
    var
        Transaction: Record "CRM Transaction";
        i: Integer;
        NumTransactions: Integer;
    begin
        NumTransactions := Random(5) + 1; // 1-5 transactions per customer
        
        for i := 1 to NumTransactions do begin
            Transaction.Init();
            Transaction."Customer No." := CustomerNo;
            Transaction."Transaction Type" := GetRandomTransactionType();
            Transaction."Transaction Date" := CalcDate('<-' + Format(Random(365)) + 'D>', WorkDate());
            Transaction.Amount := Random(500000) + 10000; // 10K to 510K
            Transaction."Currency Code" := 'KES';
            Transaction.Description := GetRandomTransactionDescription();
            Transaction."Reference No." := 'REF' + Format(Random(999999), 6, '<Integer,6><Filler Character,0>');
            Transaction."Payment Method" := GetRandomPaymentMethod();
            Transaction.Status := GetRandomTransactionStatus();
            Transaction."Academic Year" := GetRandomAcademicYear();
            Transaction."Net Amount" := Transaction.Amount * 0.9; // Assuming 10% tax
            Transaction."Tax Amount" := Transaction.Amount * 0.1;
            Transaction."Processed Date" := CurrentDateTime;
            Transaction."Processed By" := UserId;
            Transaction.Insert(true);
        end;
    end;
    
    local procedure GenerateCampaignResponses(CustomerNo: Code[20])
    var
        CampaignResponse: Record "CRM Campaign Response";
        i: Integer;
    begin
        // Generate 1-3 campaign responses per customer
        for i := 1 to Random(3) + 1 do begin
            CampaignResponse.Init();
            CampaignResponse."Campaign No." := GetRandomCampaignNo();
            CampaignResponse."Customer No." := CustomerNo;
            CampaignResponse."Response Date" := CreateDateTime(CalcDate('<-' + Format(Random(180)) + 'D>', WorkDate()), Time);
            CampaignResponse.Responded := (Random(10) > 3); // 70% response rate
            CampaignResponse."Response Type" := GetRandomResponseType();
            CampaignResponse."Response Rating" := Random(5) + 1;
            CampaignResponse."Email Delivered" := true;
            CampaignResponse."Email Opens" := Random(5) + 1;
            CampaignResponse."Email Clicks" := Random(3);
            CampaignResponse."Response Rate" := Random(100);
            CampaignResponse."Conversion Rate" := Random(50);
            CampaignResponse."Lead Generated" := (Random(10) < 2); // 20% lead generation
            CampaignResponse."Sale Made" := (Random(10) < 1); // 10% sale conversion
            if CampaignResponse."Sale Made" then
                CampaignResponse."Sale Amount" := Random(100000) + 10000;
            CampaignResponse."Channel Used" := GetRandomMarketingChannel();
            CampaignResponse."Device Type" := GetRandomDeviceType();
            CampaignResponse."Time Spent (Seconds)" := Random(300) + 30;
            CampaignResponse."Pages Visited" := Random(10) + 1;
            CampaignResponse."Satisfaction Score" := Random(10) + 1;
            CampaignResponse."Engagement Score" := Random(100);
            CampaignResponse.Insert(true);
        end;
    end;
    
    local procedure GenerateSupportTickets(CustomerNo: Code[20])
    var
        SupportTicket: Record "CRM Support Ticket";
        i: Integer;
    begin
        // Generate 0-2 support tickets per customer
        for i := 1 to Random(3) do begin
            SupportTicket.Init();
            SupportTicket."Ticket No." := 'TKT' + Format(Random(999999), 6, '<Integer,6><Filler Character,0>');
            SupportTicket."Customer No." := CustomerNo;
            SupportTicket.Subject := GetRandomTicketSubject();
            SupportTicket.Description := 'Demo support ticket for testing purposes.';
            SupportTicket.Category := GetRandomTicketCategory();
            SupportTicket.Priority := GetRandomPriority();
            SupportTicket.Status := GetRandomTicketStatus();
            SupportTicket.Source := GetRandomTicketSource();
            SupportTicket."Assigned To" := UserId;
            SupportTicket."Due Date" := CreateDateTime(CalcDate('<+' + Format(Random(7) + 1) + 'D>', WorkDate()), Time);
            SupportTicket."Response Time (Hours)" := Random(24) + 1;
            SupportTicket."Customer Satisfaction" := Random(5) + 1;
            SupportTicket.Insert(true);
        end;
    end;
    
    local procedure GenerateLeads()
    var
        Lead: Record "CRM Lead";
        i: Integer;
    begin
        // Generate 50 leads
        for i := 1 to 50 do begin
            Lead.Init();
            Lead."No." := 'LEAD' + Format(i, 6, '<Integer,6><Filler Character,0>');
            Lead."First Name" := GetRandomFirstName();
            Lead."Last Name" := GetRandomLastName();
            Lead."Email" := LowerCase(Lead."First Name" + '.' + Lead."Last Name" + '@leads.com');
            Lead."Phone No." := '+254' + Format(Random(999999999), 9, '<Integer,9><Filler Character,0>');
            Lead."Lead Source" := GetRandomLeadSource();
            Lead."Lead Status" := GetRandomLeadStatus();
            Lead."Lead Score" := Random(100);
            Lead."Interest Level" := GetRandomInterestLevel();
            Lead."Academic Programme" := GetRandomAcademicProgram();
            Lead."Study Mode" := GetRandomStudyMode();
            Lead."Preferred Start Date" := CalcDate('<+' + Format(Random(365)) + 'D>', WorkDate());
            Lead."Budget Range" := GetRandomBudgetRange();
            Lead."Decision Timeline" := GetRandomDecisionTimeline();
            Lead."Assigned To" := UserId;
            Lead."Last Contact Date" := CalcDate('<-' + Format(Random(30)) + 'D>', WorkDate());
            Lead."Next Follow-up Date" := CalcDate('<+' + Format(Random(14) + 1) + 'D>', WorkDate());
            Lead.Priority := GetRandomPriority();
            Lead.City := GetRandomCity();
            Lead."Country/Region" := 'KE';
            Lead."Age Group" := GetRandomAgeGroup();
            Lead.Gender := GetRandomGender();
            Lead."Education Level" := GetRandomEducationLevel();
            Lead."Work Experience" := Random(20) + 1;
            Lead."Current Employer" := GetRandomCompanyName();
            Lead."Job Title" := GetRandomJobTitle();
            Lead."Annual Income" := Random(2000000) + 200000;
            Lead."Website Visits" := Random(20) + 1;
            Lead."Email Opens" := Random(10) + 1;
            Lead."Email Clicks" := Random(5);
            Lead."Content Downloads" := Random(3);
            Lead."Event Attendance" := Random(2);
            Lead."Nurture Stage" := GetRandomNurtureStage();
            Lead."Lifecycle Stage" := GetRandomLifecycleStage();
            Lead."GDPR Consent" := true;
            Lead."Email Opt-In" := (Random(10) > 2);
            Lead."SMS Opt-In" := (Random(10) > 3);
            Lead."Estimated Value" := Random(500000) + 50000;
            Lead."Probability (%)" := Random(100);
            Lead."Expected Close Date" := CalcDate('<+' + Format(Random(180) + 30) + 'D>', WorkDate());
            Lead.Insert(true);
        end;
    end;
    
    local procedure GenerateCampaigns()
    var
        Campaign: Record "CRM Campaign";
        i: Integer;
        CampaignNames: List of [Text];
        CampaignName: Text;
    begin
        CampaignNames.Add('Spring Enrollment Drive 2024');
        CampaignNames.Add('MBA Program Promotion');
        CampaignNames.Add('Alumni Reunion Campaign');
        CampaignNames.Add('New Student Orientation');
        CampaignNames.Add('Research Excellence Awards');
        CampaignNames.Add('Distance Learning Launch');
        CampaignNames.Add('Corporate Partnership Drive');
        CampaignNames.Add('Scholarship Fundraising');
        CampaignNames.Add('Digital Innovation Summit');
        CampaignNames.Add('Career Fair Outreach');
        
        for i := 1 to 10 do begin
            Campaign.Init();
            Campaign."No." := 'CAMP' + Format(i, 6, '<Integer,6><Filler Character,0>');
            CampaignNames.Get(i, CampaignName);
            Campaign.Description := CopyStr(CampaignName, 1, 100);
            Campaign."Campaign Type" := GetRandomCampaignType();
            Campaign.Status := GetRandomCampaignStatus();
            Campaign."Start Date" := CalcDate('<-' + Format(Random(90)) + 'D>', WorkDate());
            Campaign."End Date" := CalcDate('<+' + Format(Random(120) + 30) + 'D>', Campaign."Start Date");
            Campaign."Target Audience" := GetRandomCustomerType();
            Campaign."Budget Amount" := Random(1000000) + 100000;
            Campaign."Actual Cost" := Campaign."Budget Amount" * (0.7 + (Random(30) / 100)); // 70-100% of budget
            Campaign."Expected Response Rate" := Random(50) + 10; // 10-60%
            Campaign."Target Count" := Random(1000) + 100;
            Campaign.Channel := GetRandomMarketingChannel();
            Campaign."Message Content" := 'Join us for an exciting opportunity to advance your career and education.';
            Campaign."Subject Line" := 'Transform Your Future with ' + Campaign.Description;
            Campaign."Call to Action" := 'Register Now';
            Campaign."Campaign Manager" := UserId;
            Campaign."Approval Status" := Campaign."Approval Status"::Approved;
            Campaign."Approved By" := UserId;
            Campaign."Approved Date" := CurrentDateTime;
            Campaign.Priority := GetRandomPriority();
            Campaign.Insert(true);
        end;
    end;
    
    // Helper functions for random data generation
    local procedure GetRandomCustomerType(): Enum "CRM Customer Type"
    var
        CustomerTypes: List of [Integer];
        RandomIndex: Integer;
    begin
        CustomerTypes.Add(1); // Prospective Student
        CustomerTypes.Add(2); // Current Student
        CustomerTypes.Add(3); // Alumni
        CustomerTypes.Add(4); // Faculty
        CustomerTypes.Add(5); // Staff
        CustomerTypes.Add(6); // Parent
        CustomerTypes.Add(7); // Donor
        
        RandomIndex := Random(CustomerTypes.Count);
        exit("CRM Customer Type".FromInteger(CustomerTypes.Get(RandomIndex)));
    end;
    
    local procedure GetRandomFirstName(): Text[50]
    var
        Names: List of [Text];
        RandomIndex: Integer;
    begin
        Names.Add('John');
        Names.Add('Mary');
        Names.Add('James');
        Names.Add('Patricia');
        Names.Add('Robert');
        Names.Add('Jennifer');
        Names.Add('Michael');
        Names.Add('Linda');
        Names.Add('William');
        Names.Add('Elizabeth');
        Names.Add('David');
        Names.Add('Barbara');
        Names.Add('Richard');
        Names.Add('Susan');
        Names.Add('Joseph');
        Names.Add('Jessica');
        Names.Add('Thomas');
        Names.Add('Sarah');
        Names.Add('Charles');
        Names.Add('Karen');
        Names.Add('Christopher');
        Names.Add('Nancy');
        Names.Add('Daniel');
        Names.Add('Lisa');
        Names.Add('Matthew');
        Names.Add('Betty');
        Names.Add('Anthony');
        Names.Add('Helen');
        Names.Add('Mark');
        Names.Add('Sandra');
        Names.Add('Grace');
        Names.Add('Peter');
        Names.Add('Faith');
        Names.Add('Stephen');
        Names.Add('Joy');
        Names.Add('Samuel');
        Names.Add('Rose');
        Names.Add('Paul');
        Names.Add('Catherine');
        Names.Add('Moses');
        
        RandomIndex := Random(Names.Count) + 1;
        exit(CopyStr(Names.Get(RandomIndex), 1, 50));
    end;
    
    local procedure GetRandomLastName(): Text[50]
    var
        Names: List of [Text];
        RandomIndex: Integer;
    begin
        Names.Add('Smith');
        Names.Add('Johnson');
        Names.Add('Williams');
        Names.Add('Brown');
        Names.Add('Jones');
        Names.Add('Garcia');
        Names.Add('Miller');
        Names.Add('Davis');
        Names.Add('Rodriguez');
        Names.Add('Martinez');
        Names.Add('Kamau');
        Names.Add('Wanjiku');
        Names.Add('Mwangi');
        Names.Add('Njeri');
        Names.Add('Kiprotich');
        Names.Add('Achieng');
        Names.Add('Otieno');
        Names.Add('Wambui');
        Names.Add('Mutua');
        Names.Add('Nyong');
        Names.Add('Kiptoo');
        Names.Add('Waweru');
        Names.Add('Gitau');
        Names.Add('Chepkwony');
        Names.Add('Mbugua');
        Names.Add('Kimani');
        Names.Add('Macharia');
        Names.Add('Karanja');
        Names.Add('Ndung');
        Names.Add('Kiarie');
        
        RandomIndex := Random(Names.Count) + 1;
        exit(CopyStr(Names.Get(RandomIndex), 1, 50));
    end;
    
    local procedure GetRandomAddress(): Text[100]
    var
        Addresses: List of [Text];
        RandomIndex: Integer;
    begin
        Addresses.Add('123 Main Street');
        Addresses.Add('456 Oak Avenue');
        Addresses.Add('789 Pine Road');
        Addresses.Add('321 Cedar Lane');
        Addresses.Add('654 Maple Drive');
        Addresses.Add('987 Elm Street');
        Addresses.Add('147 Birch Avenue');
        Addresses.Add('258 Willow Road');
        Addresses.Add('369 Poplar Street');
        Addresses.Add('741 Ash Lane');
        Addresses.Add('852 Kenyatta Avenue');
        Addresses.Add('963 Uhuru Highway');
        Addresses.Add('159 Moi Avenue');
        Addresses.Add('357 Kimathi Street');
        Addresses.Add('486 Haile Selassie Avenue');
        
        RandomIndex := Random(Addresses.Count) + 1;
        exit(CopyStr(Addresses.Get(RandomIndex), 1, 100));
    end;
    
    local procedure GetRandomCity(): Text[50]
    var
        Cities: List of [Text];
        RandomIndex: Integer;
    begin
        Cities.Add('Nairobi');
        Cities.Add('Mombasa');
        Cities.Add('Kisumu');
        Cities.Add('Nakuru');
        Cities.Add('Eldoret');
        Cities.Add('Thika');
        Cities.Add('Machakos');
        Cities.Add('Meru');
        Cities.Add('Nyeri');
        Cities.Add('Karatina');
        Cities.Add('Embu');
        Cities.Add('Kitale');
        Cities.Add('Garissa');
        Cities.Add('Kakamega');
        Cities.Add('Malindi');
        
        RandomIndex := Random(Cities.Count) + 1;
        exit(CopyStr(Cities.Get(RandomIndex), 1, 50));
    end;
    
    local procedure GetRandomCounty(): Text[50]
    var
        Counties: List of [Text];
        RandomIndex: Integer;
    begin
        Counties.Add('Nairobi');
        Counties.Add('Mombasa');
        Counties.Add('Kisumu');
        Counties.Add('Nakuru');
        Counties.Add('Uasin Gishu');
        Counties.Add('Kiambu');
        Counties.Add('Machakos');
        Counties.Add('Meru');
        Counties.Add('Nyeri');
        Counties.Add('Embu');
        Counties.Add('Trans Nzoia');
        Counties.Add('Garissa');
        Counties.Add('Kakamega');
        Counties.Add('Kilifi');
        Counties.Add('Murang a');
        
        RandomIndex := Random(Counties.Count) + 1;
        exit(CopyStr(Counties.Get(RandomIndex), 1, 50));
    end;
    
    local procedure GetRandomGender(): Enum "CRM Gender"
    begin
        case Random(3) + 1 of
            1:
                exit("CRM Gender"::Male);
            2:
                exit("CRM Gender"::Female);
            else
                exit("CRM Gender"::"Prefer not to say");
        end;
    end;
    
    local procedure GetRandomMaritalStatus(): Enum "CRM Marital Status"
    begin
        case Random(6) + 1 of
            1:
                exit("CRM Marital Status"::Single);
            2:
                exit("CRM Marital Status"::Married);
            3:
                exit("CRM Marital Status"::Divorced);
            4:
                exit("CRM Marital Status"::Widowed);
            5:
                exit("CRM Marital Status"::Separated);
            else
                exit("CRM Marital Status"::"Prefer not to say");
        end;
    end;
    
    local procedure GetRandomLeadSource(): Enum "CRM Lead Source"
    begin
        case Random(14) + 1 of
            1:
                exit("CRM Lead Source"::Website);
            2:
                exit("CRM Lead Source"::"Social Media");
            3:
                exit("CRM Lead Source"::"Search Engine");
            4:
                exit("CRM Lead Source"::Referral);
            5:
                exit("CRM Lead Source"::Email);
            6:
                exit("CRM Lead Source"::"Trade Show");
            7:
                exit("CRM Lead Source"::Advertisement);
            8:
                exit("CRM Lead Source"::"Cold Call");
            9:
                exit("CRM Lead Source"::"Direct Mail");
            10:
                exit("CRM Lead Source"::"Word of Mouth");
            11:
                exit("CRM Lead Source"::Partner);
            12:
                exit("CRM Lead Source"::"Walk-in");
            13:
                exit("CRM Lead Source"::"Open Day");
            else
                exit("CRM Lead Source"::"Alumni Network");
        end;
    end;
    
    local procedure GetRandomLeadStatus(): Enum "CRM Lead Status"
    begin
        case Random(12) + 1 of
            1:
                exit("CRM Lead Status"::New);
            2:
                exit("CRM Lead Status"::Qualified);
            3:
                exit("CRM Lead Status"::"In Progress");
            4:
                exit("CRM Lead Status"::Nurturing);
            5:
                exit("CRM Lead Status"::"Hot Lead");
            6:
                exit("CRM Lead Status"::"Warm Lead");
            7:
                exit("CRM Lead Status"::"Cold Lead");
            8:
                exit("CRM Lead Status"::Converted);
            9:
                exit("CRM Lead Status"::Lost);
            10:
                exit("CRM Lead Status"::Disqualified);
            11:
                exit("CRM Lead Status"::"Not Interested");
            else
                exit("CRM Lead Status"::"Follow Up");
        end;
    end;
    
    local procedure GetRandomContactMethod(): Enum "CRM Contact Method"
    begin
        case Random(8) + 1 of
            1:
                exit("CRM Contact Method"::Email);
            2:
                exit("CRM Contact Method"::Phone);
            3:
                exit("CRM Contact Method"::SMS);
            4:
                exit("CRM Contact Method"::"Social Media");
            5:
                exit("CRM Contact Method"::"Direct Mail");
            6:
                exit("CRM Contact Method"::"In Person");
            7:
                exit("CRM Contact Method"::WhatsApp);
            else
                exit("CRM Contact Method"::Telegram);
        end;
    end;
    
    local procedure GetRandomSegmentationCode(): Code[20]
    var
        Codes: List of [Text];
        RandomIndex: Integer;
    begin
        Codes.Add('YOUNG_PROFESSIONALS');
        Codes.Add('SENIOR_EXECUTIVES');
        Codes.Add('RECENT_GRADUATES');
        Codes.Add('RETURNING_STUDENTS');
        Codes.Add('INTERNATIONAL');
        Codes.Add('HIGH_ENGAGERS');
        Codes.Add('DONORS');
        Codes.Add('ALUMNI_NETWORK');
        
        RandomIndex := Random(Codes.Count) + 1;
        exit(CopyStr(Codes.Get(RandomIndex), 1, 20));
    end;
    
    local procedure GetRandomAcademicProgram(): Code[20]
    var
        Programs: List of [Text];
        RandomIndex: Integer;
    begin
        Programs.Add('MBA');
        Programs.Add('BSC-CS');
        Programs.Add('BSC-IT');
        Programs.Add('BA-ECON');
        Programs.Add('BSC-MATH');
        Programs.Add('BA-ENG');
        Programs.Add('BSC-BIO');
        Programs.Add('BA-HIST');
        Programs.Add('BSC-CHEM');
        Programs.Add('BA-PHIL');
        Programs.Add('MSC-CS');
        Programs.Add('MSC-IT');
        Programs.Add('MA-ECON');
        Programs.Add('PHD-CS');
        Programs.Add('DIP-IT');
        
        RandomIndex := Random(Programs.Count) + 1;
        exit(CopyStr(Programs.Get(RandomIndex), 1, 20));
    end;
    
    local procedure GetRandomAcademicYear(): Code[20]
    var
        Years: List of [Text];
        RandomIndex: Integer;
    begin
        Years.Add('2023/2024');
        Years.Add('2024/2025');
        Years.Add('2022/2023');
        Years.Add('2021/2022');
        Years.Add('2020/2021');
        
        RandomIndex := Random(Years.Count) + 1;
        exit(CopyStr(Years.Get(RandomIndex), 1, 20));
    end;
    
    local procedure GetRandomCompanyName(): Text[100]
    var
        Companies: List of [Text];
        RandomIndex: Integer;
    begin
        Companies.Add('Safaricom PLC');
        Companies.Add('Kenya Commercial Bank');
        Companies.Add('Equity Bank');
        Companies.Add('East African Breweries');
        Companies.Add('Kenya Airways');
        Companies.Add('Bamburi Cement');
        Companies.Add('Standard Chartered Bank');
        Companies.Add('Co-operative Bank');
        Companies.Add('Nation Media Group');
        Companies.Add('Kenya Power');
        Companies.Add('Jubilee Insurance');
        Companies.Add('NCBA Group');
        Companies.Add('Diamond Trust Bank');
        Companies.Add('Liberty Kenya Holdings');
        Companies.Add('Centum Investment');
        
        RandomIndex := Random(Companies.Count) + 1;
        exit(CopyStr(Companies.Get(RandomIndex), 1, 100));
    end;
    
    local procedure GetRandomJobTitle(): Text[100]
    var
        Titles: List of [Text];
        RandomIndex: Integer;
    begin
        Titles.Add('Software Engineer');
        Titles.Add('Marketing Manager');
        Titles.Add('Financial Analyst');
        Titles.Add('Project Manager');
        Titles.Add('Sales Representative');
        Titles.Add('Operations Manager');
        Titles.Add('HR Specialist');
        Titles.Add('Business Analyst');
        Titles.Add('Account Manager');
        Titles.Add('Product Manager');
        Titles.Add('Data Scientist');
        Titles.Add('Teacher');
        Titles.Add('Consultant');
        Titles.Add('Entrepreneur');
        Titles.Add('Government Officer');
        
        RandomIndex := Random(Titles.Count) + 1;
        exit(CopyStr(Titles.Get(RandomIndex), 1, 100));
    end;
    
    local procedure GetRandomTags(): Text[250]
    var
        TagSets: List of [Text];
        RandomIndex: Integer;
    begin
        TagSets.Add('technology,innovation,career-growth');
        TagSets.Add('leadership,management,strategy');
        TagSets.Add('finance,investment,analytics');
        TagSets.Add('marketing,digital,social-media');
        TagSets.Add('education,research,academic');
        TagSets.Add('healthcare,medical,wellness');
        TagSets.Add('agriculture,sustainability,environment');
        TagSets.Add('business,entrepreneurship,startup');
        TagSets.Add('government,policy,public-service');
        TagSets.Add('arts,culture,creative');
        
        RandomIndex := Random(TagSets.Count) + 1;
        exit(CopyStr(TagSets.Get(RandomIndex), 1, 250));
    end;
    
    local procedure GetRandomInteractionType(): Enum "CRM Interaction Type"
    begin
        case Random(20) + 1 of
            1:
                exit("CRM Interaction Type"::Call);
            2:
                exit("CRM Interaction Type"::Email);
            3:
                exit("CRM Interaction Type"::Meeting);
            4:
                exit("CRM Interaction Type"::"Web Chat");
            5:
                exit("CRM Interaction Type"::SMS);
            6:
                exit("CRM Interaction Type"::"Social Media");
            7:
                exit("CRM Interaction Type"::"Direct Mail");
            8:
                exit("CRM Interaction Type"::"Event Attendance");
            9:
                exit("CRM Interaction Type"::"Website Visit");
            10:
                exit("CRM Interaction Type"::Survey);
            11:
                exit("CRM Interaction Type"::Support);
            12:
                exit("CRM Interaction Type"::Complaint);
            13:
                exit("CRM Interaction Type"::Feedback);
            14:
                exit("CRM Interaction Type"::"Follow Up");
            15:
                exit("CRM Interaction Type"::Inquiry);
            16:
                exit("CRM Interaction Type"::Application);
            17:
                exit("CRM Interaction Type"::Enrollment);
            18:
                exit("CRM Interaction Type"::Payment);
            19:
                exit("CRM Interaction Type"::Donation);
            else
                exit("CRM Interaction Type"::Newsletter);
        end;
    end;
    
    local procedure GetRandomInteractionSubject(): Text[100]
    var
        Subjects: List of [Text];
        RandomIndex: Integer;
    begin
        Subjects.Add('Program Inquiry');
        Subjects.Add('Admission Requirements');
        Subjects.Add('Fee Payment');
        Subjects.Add('Course Registration');
        Subjects.Add('Technical Support');
        Subjects.Add('Academic Guidance');
        Subjects.Add('Scholarship Information');
        Subjects.Add('Campus Tour Request');
        Subjects.Add('Application Status');
        Subjects.Add('Document Submission');
        Subjects.Add('Event Registration');
        Subjects.Add('Alumni Services');
        Subjects.Add('Research Collaboration');
        Subjects.Add('Partnership Inquiry');
        Subjects.Add('General Information');
        
        RandomIndex := Random(Subjects.Count) + 1;
        exit(CopyStr(Subjects.Get(RandomIndex), 1, 100));
    end;
    
    local procedure GetRandomInteractionOutcome(): Enum "CRM Interaction Outcome"
    begin
        case Random(12) + 1 of
            1:
                exit("CRM Interaction Outcome"::Successful);
            2:
                exit("CRM Interaction Outcome"::"Partially Successful");
            3:
                exit("CRM Interaction Outcome"::Unsuccessful);
            4:
                exit("CRM Interaction Outcome"::"No Response");
            5:
                exit("CRM Interaction Outcome"::"Needs Follow-up");
            6:
                exit("CRM Interaction Outcome"::Completed);
            7:
                exit("CRM Interaction Outcome"::Cancelled);
            8:
                exit("CRM Interaction Outcome"::Postponed);
            9:
                exit("CRM Interaction Outcome"::"Not Interested");
            10:
                exit("CRM Interaction Outcome"::"Information Provided");
            11:
                exit("CRM Interaction Outcome"::"Issue Resolved");
            else
                exit("CRM Interaction Outcome"::Escalated);
        end;
    end;
    
    local procedure GetRandomPriority(): Enum "CRM Priority Level"
    begin
        case Random(4) + 1 of
            1:
                exit("CRM Priority Level"::Low);
            2:
                exit("CRM Priority Level"::Medium);
            3:
                exit("CRM Priority Level"::High);
            else
                exit("CRM Priority Level"::Critical);
        end;
    end;
    
    local procedure GetRandomTransactionType(): Enum "CRM Transaction Type"
    begin
        case Random(18) + 1 of
            1:
                exit("CRM Transaction Type"::Payment);
            2:
                exit("CRM Transaction Type"::Donation);
            3:
                exit("CRM Transaction Type"::Refund);
            4:
                exit("CRM Transaction Type"::"Tuition Fee");
            5:
                exit("CRM Transaction Type"::"Application Fee");
            6:
                exit("CRM Transaction Type"::"Accommodation Fee");
            7:
                exit("CRM Transaction Type"::"Library Fee");
            8:
                exit("CRM Transaction Type"::"Medical Fee");
            9:
                exit("CRM Transaction Type"::"Graduation Fee");
            10:
                exit("CRM Transaction Type"::"Exam Fee");
            11:
                exit("CRM Transaction Type"::"Student Union Fee");
            12:
                exit("CRM Transaction Type"::"Research Fee");
            13:
                exit("CRM Transaction Type"::"Late Payment Fee");
            14:
                exit("CRM Transaction Type"::"Alumni Contribution");
            15:
                exit("CRM Transaction Type"::"Scholarship Fund");
            16:
                exit("CRM Transaction Type"::"Equipment Purchase");
            17:
                exit("CRM Transaction Type"::"Building Fund");
            else
                exit("CRM Transaction Type"::"General Donation");
        end;
    end;
    
    local procedure GetRandomTransactionDescription(): Text[100]
    var
        Descriptions: List of [Text];
        RandomIndex: Integer;
    begin
        Descriptions.Add('Semester Fee Payment');
        Descriptions.Add('Annual Tuition Fee');
        Descriptions.Add('Library Services Fee');
        Descriptions.Add('Examination Fee');
        Descriptions.Add('Research Project Fee');
        Descriptions.Add('Graduation Ceremony Fee');
        Descriptions.Add('Student Union Contribution');
        Descriptions.Add('Medical Services Fee');
        Descriptions.Add('Alumni Annual Donation');
        Descriptions.Add('Equipment Purchase');
        Descriptions.Add('Building Fund Contribution');
        Descriptions.Add('Scholarship Donation');
        Descriptions.Add('Late Payment Penalty');
        Descriptions.Add('Accommodation Fee');
        Descriptions.Add('Application Processing Fee');
        
        RandomIndex := Random(Descriptions.Count) + 1;
        exit(CopyStr(Descriptions.Get(RandomIndex), 1, 100));
    end;
    
    local procedure GetRandomPaymentMethod(): Enum "CRM Payment Method"
    begin
        case Random(15) + 1 of
            1:
                exit("CRM Payment Method"::Cash);
            2:
                exit("CRM Payment Method"::"Bank Transfer");
            3:
                exit("CRM Payment Method"::Cheque);
            4:
                exit("CRM Payment Method"::"Credit Card");
            5:
                exit("CRM Payment Method"::"Debit Card");
            6:
                exit("CRM Payment Method"::"Mobile Money");
            7:
                exit("CRM Payment Method"::"Online Payment");
            8:
                exit("CRM Payment Method"::"Direct Debit");
            9:
                exit("CRM Payment Method"::"Standing Order");
            10:
                exit("CRM Payment Method"::PayPal);
            11:
                exit("CRM Payment Method"::"M-Pesa");
            12:
                exit("CRM Payment Method"::"Airtel Money");
            13:
                exit("CRM Payment Method"::"Bank Draft");
            14:
                exit("CRM Payment Method"::"Money Order");
            else
                exit("CRM Payment Method"::Cryptocurrency);
        end;
    end;
    
    local procedure GetRandomTransactionStatus(): Enum "CRM Transaction Status"
    begin
        case Random(11) + 1 of
            1:
                exit("CRM Transaction Status"::Pending);
            2:
                exit("CRM Transaction Status"::Completed);
            3:
                exit("CRM Transaction Status"::Failed);
            4:
                exit("CRM Transaction Status"::Cancelled);
            5:
                exit("CRM Transaction Status"::"In Progress");
            6:
                exit("CRM Transaction Status"::"Partially Paid");
            7:
                exit("CRM Transaction Status"::Refunded);
            8:
                exit("CRM Transaction Status"::"On Hold");
            9:
                exit("CRM Transaction Status"::Disputed);
            10:
                exit("CRM Transaction Status"::Approved);
            else
                exit("CRM Transaction Status"::Rejected);
        end;
    end;
    
    local procedure GetRandomCampaignNo(): Code[20]
    var
        CampaignNos: List of [Text];
        RandomIndex: Integer;
    begin
        CampaignNos.Add('CAMP000001');
        CampaignNos.Add('CAMP000002');
        CampaignNos.Add('CAMP000003');
        CampaignNos.Add('CAMP000004');
        CampaignNos.Add('CAMP000005');
        CampaignNos.Add('CAMP000006');
        CampaignNos.Add('CAMP000007');
        CampaignNos.Add('CAMP000008');
        CampaignNos.Add('CAMP000009');
        CampaignNos.Add('CAMP000010');
        
        RandomIndex := Random(CampaignNos.Count) + 1;
        exit(CopyStr(CampaignNos.Get(RandomIndex), 1, 20));
    end;
    
    local procedure GetRandomResponseType(): Enum "CRM Response Type"
    begin
        case Random(20) + 1 of
            1:
                exit("CRM Response Type"::"Email Open");
            2:
                exit("CRM Response Type"::"Email Click");
            3:
                exit("CRM Response Type"::"Website Visit");
            4:
                exit("CRM Response Type"::"Form Submission");
            5:
                exit("CRM Response Type"::"Phone Call");
            6:
                exit("CRM Response Type"::"In-Person Visit");
            7:
                exit("CRM Response Type"::"Social Media Engagement");
            8:
                exit("CRM Response Type"::Download);
            9:
                exit("CRM Response Type"::Purchase);
            10:
                exit("CRM Response Type"::Subscription);
            11:
                exit("CRM Response Type"::Registration);
            12:
                exit("CRM Response Type"::Application);
            13:
                exit("CRM Response Type"::Inquiry);
            14:
                exit("CRM Response Type"::Referral);
            15:
                exit("CRM Response Type"::"Event Attendance");
            16:
                exit("CRM Response Type"::Survey);
            17:
                exit("CRM Response Type"::Feedback);
            18:
                exit("CRM Response Type"::Complaint);
            19:
                exit("CRM Response Type"::"Support Request");
            else
                exit("CRM Response Type"::Unsubscribe);
        end;
    end;
    
    local procedure GetRandomMarketingChannel(): Enum "CRM Marketing Channel"
    begin
        case Random(25) + 1 of
            1:
                exit("CRM Marketing Channel"::Email);
            2:
                exit("CRM Marketing Channel"::SMS);
            3:
                exit("CRM Marketing Channel"::WhatsApp);
            4:
                exit("CRM Marketing Channel"::Facebook);
            5:
                exit("CRM Marketing Channel"::Instagram);
            6:
                exit("CRM Marketing Channel"::Twitter);
            7:
                exit("CRM Marketing Channel"::LinkedIn);
            8:
                exit("CRM Marketing Channel"::YouTube);
            9:
                exit("CRM Marketing Channel"::TikTok);
            10:
                exit("CRM Marketing Channel"::Website);
            11:
                exit("CRM Marketing Channel"::Blog);
            12:
                exit("CRM Marketing Channel"::"Google Ads");
            13:
                exit("CRM Marketing Channel"::"Facebook Ads");
            14:
                exit("CRM Marketing Channel"::"Print Media");
            15:
                exit("CRM Marketing Channel"::Radio);
            16:
                exit("CRM Marketing Channel"::Television);
            17:
                exit("CRM Marketing Channel"::"Outdoor Billboard");
            18:
                exit("CRM Marketing Channel"::"Direct Mail");
            19:
                exit("CRM Marketing Channel"::Telemarketing);
            20:
                exit("CRM Marketing Channel"::"Trade Show");
            21:
                exit("CRM Marketing Channel"::Webinar);
            22:
                exit("CRM Marketing Channel"::Podcast);
            23:
                exit("CRM Marketing Channel"::"Influencer Marketing");
            24:
                exit("CRM Marketing Channel"::"Affiliate Marketing");
            else
                exit("CRM Marketing Channel"::"Content Marketing");
        end;
    end;
    
    local procedure GetRandomDeviceType(): Enum "CRM Device Type"
    begin
        case Random(7) + 1 of
            1:
                exit("CRM Device Type"::Desktop);
            2:
                exit("CRM Device Type"::Laptop);
            3:
                exit("CRM Device Type"::Mobile);
            4:
                exit("CRM Device Type"::Tablet);
            5:
                exit("CRM Device Type"::"Smart TV");
            6:
                exit("CRM Device Type"::"Smart Watch");
            else
                exit("CRM Device Type"::Other);
        end;
    end;
    
    local procedure GetRandomTicketSubject(): Text[100]
    var
        Subjects: List of [Text];
        RandomIndex: Integer;
    begin
        Subjects.Add('Login Issues');
        Subjects.Add('Grade Inquiry');
        Subjects.Add('Fee Payment Problem');
        Subjects.Add('Course Registration Error');
        Subjects.Add('System Access Denied');
        Subjects.Add('Document Upload Failed');
        Subjects.Add('Email Not Received');
        Subjects.Add('Transcript Request');
        Subjects.Add('Password Reset');
        Subjects.Add('Account Verification');
        Subjects.Add('Application Status');
        Subjects.Add('Technical Error');
        Subjects.Add('Report Generation Issue');
        Subjects.Add('Data Update Request');
        Subjects.Add('General Inquiry');
        
        RandomIndex := Random(Subjects.Count) + 1;
        exit(CopyStr(Subjects.Get(RandomIndex), 1, 100));
    end;
    
    local procedure GetRandomTicketCategory(): Enum "CRM Ticket Category"
    begin
        case Random(22) + 1 of
            1:
                exit("CRM Ticket Category"::"Technical Support");
            2:
                exit("CRM Ticket Category"::"Academic Support");
            3:
                exit("CRM Ticket Category"::"Admission Inquiry");
            4:
                exit("CRM Ticket Category"::"Financial Services");
            5:
                exit("CRM Ticket Category"::"Registration Issues");
            6:
                exit("CRM Ticket Category"::Accommodation);
            7:
                exit("CRM Ticket Category"::"Library Services");
            8:
                exit("CRM Ticket Category"::"Health Services");
            9:
                exit("CRM Ticket Category"::"Student Services");
            10:
                exit("CRM Ticket Category"::"Alumni Services");
            11:
                exit("CRM Ticket Category"::"HR Services");
            12:
                exit("CRM Ticket Category"::"IT Services");
            13:
                exit("CRM Ticket Category"::Facilities);
            14:
                exit("CRM Ticket Category"::Transportation);
            15:
                exit("CRM Ticket Category"::Security);
            16:
                exit("CRM Ticket Category"::"Research Support");
            17:
                exit("CRM Ticket Category"::Examination);
            18:
                exit("CRM Ticket Category"::Transcripts);
            19:
                exit("CRM Ticket Category"::Complaints);
            20:
                exit("CRM Ticket Category"::Suggestions);
            21:
                exit("CRM Ticket Category"::"General Inquiry");
            else
                exit("CRM Ticket Category"::Other);
        end;
    end;
    
    local procedure GetRandomTicketStatus(): Enum "CRM Ticket Status"
    begin
        case Random(14) + 1 of
            1:
                exit("CRM Ticket Status"::Open);
            2:
                exit("CRM Ticket Status"::"In Progress");
            3:
                exit("CRM Ticket Status"::"Pending Customer");
            4:
                exit("CRM Ticket Status"::"Pending Internal");
            5:
                exit("CRM Ticket Status"::"Waiting for Approval");
            6:
                exit("CRM Ticket Status"::Escalated);
            7:
                exit("CRM Ticket Status"::"On Hold");
            8:
                exit("CRM Ticket Status"::Resolved);
            9:
                exit("CRM Ticket Status"::Closed);
            10:
                exit("CRM Ticket Status"::Cancelled);
            11:
                exit("CRM Ticket Status"::Reopened);
            12:
                exit("CRM Ticket Status"::Duplicate);
            13:
                exit("CRM Ticket Status"::"Cannot Reproduce");
            else
                exit("CRM Ticket Status"::"Will Not Fix");
        end;
    end;
    
    local procedure GetRandomTicketSource(): Enum "CRM Ticket Source"
    begin
        case Random(17) + 1 of
            1:
                exit("CRM Ticket Source"::Email);
            2:
                exit("CRM Ticket Source"::Phone);
            3:
                exit("CRM Ticket Source"::"Web Portal");
            4:
                exit("CRM Ticket Source"::"Live Chat");
            5:
                exit("CRM Ticket Source"::"Social Media");
            6:
                exit("CRM Ticket Source"::"In Person");
            7:
                exit("CRM Ticket Source"::"Mobile App");
            8:
                exit("CRM Ticket Source"::SMS);
            9:
                exit("CRM Ticket Source"::WhatsApp);
            10:
                exit("CRM Ticket Source"::"Self Service");
            11:
                exit("CRM Ticket Source"::API);
            12:
                exit("CRM Ticket Source"::"System Generated");
            13:
                exit("CRM Ticket Source"::"Internal Request");
            14:
                exit("CRM Ticket Source"::Escalation);
            15:
                exit("CRM Ticket Source"::"Voice Mail");
            16:
                exit("CRM Ticket Source"::Fax);
            else
                exit("CRM Ticket Source"::"Direct Mail");
        end;
    end;
    
    local procedure GetRandomInterestLevel(): Enum "CRM Interest Level"
    begin
        case Random(6) + 1 of
            1:
                exit("CRM Interest Level"::Low);
            2:
                exit("CRM Interest Level"::Medium);
            3:
                exit("CRM Interest Level"::High);
            4:
                exit("CRM Interest Level"::"Very High");
            5:
                exit("CRM Interest Level"::"Not Interested");
            else
                exit("CRM Interest Level"::Low);
        end;
    end;
    
    local procedure GetRandomStudyMode(): Enum "CRM Study Mode"
    begin
        case Random(8) + 1 of
            1:
                exit("CRM Study Mode"::"Full Time");
            2:
                exit("CRM Study Mode"::"Part Time");
            3:
                exit("CRM Study Mode"::"Distance Learning");
            4:
                exit("CRM Study Mode"::Online);
            5:
                exit("CRM Study Mode"::"Evening Classes");
            6:
                exit("CRM Study Mode"::"Weekend Classes");
            7:
                exit("CRM Study Mode"::Hybrid);
            else
                exit("CRM Study Mode"::"Block Release");
        end;
    end;
    
    local procedure GetRandomBudgetRange(): Enum "CRM Budget Range"
    begin
        case Random(7) + 1 of
            1:
                exit("CRM Budget Range"::"Under 50K");
            2:
                exit("CRM Budget Range"::"50K-100K");
            3:
                exit("CRM Budget Range"::"100K-500K");
            4:
                exit("CRM Budget Range"::"500K-1M");
            5:
                exit("CRM Budget Range"::"Above 1M");
            6:
                exit("CRM Budget Range"::"Not Specified");
            else
                exit("CRM Budget Range"::"To Be Determined");
        end;
    end;
    
    local procedure GetRandomDecisionTimeline(): Enum "CRM Decision Timeline"
    begin
        case Random(7) + 1 of
            1:
                exit("CRM Decision Timeline"::Immediate);
            2:
                exit("CRM Decision Timeline"::"1-3 Months");
            3:
                exit("CRM Decision Timeline"::"3-6 Months");
            4:
                exit("CRM Decision Timeline"::"6-12 Months");
            5:
                exit("CRM Decision Timeline"::"Over 1 Year");
            6:
                exit("CRM Decision Timeline"::Undecided);
            else
                exit("CRM Decision Timeline"::"Just Researching");
        end;
    end;
    
    local procedure GetRandomAgeGroup(): Enum "CRM Age Group"
    begin
        case Random(8) + 1 of
            1:
                exit("CRM Age Group"::"Under 18");
            2:
                exit("CRM Age Group"::"18-24");
            3:
                exit("CRM Age Group"::"25-34");
            4:
                exit("CRM Age Group"::"35-44");
            5:
                exit("CRM Age Group"::"45-54");
            6:
                exit("CRM Age Group"::"55-64");
            7:
                exit("CRM Age Group"::"65+");
            else
                exit("CRM Age Group"::"Prefer not to say");
        end;
    end;
    
    local procedure GetRandomEducationLevel(): Enum "CRM Education Level"
    begin
        case Random(10) + 1 of
            1:
                exit("CRM Education Level"::"High School");
            2:
                exit("CRM Education Level"::Diploma);
            3:
                exit("CRM Education Level"::Certificate);
            4:
                exit("CRM Education Level"::"Bachelor Degree");
            5:
                exit("CRM Education Level"::"Master Degree");
            6:
                exit("CRM Education Level"::"Doctorate/PhD");
            7:
                exit("CRM Education Level"::"Professional Certification");
            8:
                exit("CRM Education Level"::"Trade School");
            9:
                exit("CRM Education Level"::"Some College");
            else
                exit("CRM Education Level"::Other);
        end;
    end;
    
    local procedure GetRandomNurtureStage(): Enum "CRM Nurture Stage"
    begin
        case Random(9) + 1 of
            1:
                exit("CRM Nurture Stage"::Awareness);
            2:
                exit("CRM Nurture Stage"::Interest);
            3:
                exit("CRM Nurture Stage"::Consideration);
            4:
                exit("CRM Nurture Stage"::Intent);
            5:
                exit("CRM Nurture Stage"::Evaluation);
            6:
                exit("CRM Nurture Stage"::Purchase);
            7:
                exit("CRM Nurture Stage"::Retention);
            8:
                exit("CRM Nurture Stage"::Advocacy);
            else
                exit("CRM Nurture Stage"::"Re-engagement");
        end;
    end;
    
    local procedure GetRandomLifecycleStage(): Enum "CRM Lifecycle Stage"
    begin
        case Random(9) + 1 of
            1:
                exit("CRM Lifecycle Stage"::Subscriber);
            2:
                exit("CRM Lifecycle Stage"::Lead);
            3:
                exit("CRM Lifecycle Stage"::"Marketing Qualified Lead");
            4:
                exit("CRM Lifecycle Stage"::"Sales Qualified Lead");
            5:
                exit("CRM Lifecycle Stage"::Opportunity);
            6:
                exit("CRM Lifecycle Stage"::Student);
            7:
                exit("CRM Lifecycle Stage"::Alumni);
            8:
                exit("CRM Lifecycle Stage"::Evangelist);
            else
                exit("CRM Lifecycle Stage"::Other);
        end;
    end;
    
    local procedure GetRandomCampaignType(): Enum "CRM Campaign Type"
    begin
        case Random(20) + 1 of
            1:
                exit("CRM Campaign Type"::Email);
            2:
                exit("CRM Campaign Type"::SMS);
            3:
                exit("CRM Campaign Type"::"Social Media");
            4:
                exit("CRM Campaign Type"::"Direct Mail");
            5:
                exit("CRM Campaign Type"::"Print Advertisement");
            6:
                exit("CRM Campaign Type"::"Radio Advertisement");
            7:
                exit("CRM Campaign Type"::"TV Advertisement");
            8:
                exit("CRM Campaign Type"::"Online Advertisement");
            9:
                exit("CRM Campaign Type"::Webinar);
            10:
                exit("CRM Campaign Type"::"Open Day");
            11:
                exit("CRM Campaign Type"::"Trade Show");
            12:
                exit("CRM Campaign Type"::"Alumni Outreach");
            13:
                exit("CRM Campaign Type"::Recruitment);
            14:
                exit("CRM Campaign Type"::Fundraising);
            15:
                exit("CRM Campaign Type"::"Brand Awareness");
            16:
                exit("CRM Campaign Type"::"Lead Generation");
            17:
                exit("CRM Campaign Type"::"Student Retention");
            18:
                exit("CRM Campaign Type"::"Research Promotion");
            19:
                exit("CRM Campaign Type"::Newsletter);
            else
                exit("CRM Campaign Type"::Survey);
        end;
    end;
    
    local procedure GetRandomCampaignStatus(): Enum "CRM Campaign Status"
    begin
        case Random(11) + 1 of
            1:
                exit("CRM Campaign Status"::Draft);
            2:
                exit("CRM Campaign Status"::"Pending Approval");
            3:
                exit("CRM Campaign Status"::Approved);
            4:
                exit("CRM Campaign Status"::Scheduled);
            5:
                exit("CRM Campaign Status"::"In Progress");
            6:
                exit("CRM Campaign Status"::Completed);
            7:
                exit("CRM Campaign Status"::Cancelled);
            8:
                exit("CRM Campaign Status"::Paused);
            9:
                exit("CRM Campaign Status"::"On Hold");
            10:
                exit("CRM Campaign Status"::Failed);
            else
                exit("CRM Campaign Status"::"Under Review");
        end;
    end;
}