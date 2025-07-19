table 52179008 "CRM Lead"
{
    DataClassification = CustomerContent;
    Caption = 'CRM Lead';
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = "CRM Customer";
        }
        field(3; "First Name"; Text[50])
        {
            Caption = 'First Name';
        }
        field(4; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(5; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
        }
        field(6; "Email"; Text[100])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }
        field(7; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(8; "Lead Source"; Enum "CRM Lead Source")
        {
            Caption = 'Lead Source';
        }
        field(9; "Lead Status"; Enum "CRM Lead Status")
        {
            Caption = 'Lead Status';
        }
        field(10; "Lead Score"; Integer)
        {
            Caption = 'Lead Score';
            MinValue = 0;
            MaxValue = 100;
        }
        field(11; "Interest Level"; Enum "CRM Interest Level")
        {
            Caption = 'Interest Level';
        }
        field(12; "Academic Programme"; Code[20])
        {
            Caption = 'Academic Programme';
        }
        field(13; "Study Mode"; Enum "CRM Study Mode")
        {
            Caption = 'Study Mode';
        }
        field(14; "Preferred Start Date"; Date)
        {
            Caption = 'Preferred Start Date';
        }
        field(15; "Budget Range"; Enum "CRM Budget Range")
        {
            Caption = 'Budget Range';
        }
        field(16; "Decision Timeline"; Enum "CRM Decision Timeline")
        {
            Caption = 'Decision Timeline';
        }
        field(17; "Assigned To"; Code[50])
        {
            Caption = 'Assigned To';
            TableRelation = User."User Name";
        }
        field(18; "Campaign Code"; Code[20])
        {
            Caption = 'Campaign Code';
            TableRelation = "CRM Campaign";
        }
        field(19; "Qualification Date"; Date)
        {
            Caption = 'Qualification Date';
        }
        field(20; "Converted Date"; Date)
        {
            Caption = 'Converted Date';
        }
        field(21; "Last Contact Date"; Date)
        {
            Caption = 'Last Contact Date';
        }
        field(22; "Next Follow-up Date"; Date)
        {
            Caption = 'Next Follow-up Date';
        }
        field(23; "Priority"; Enum "CRM Priority Level")
        {
            Caption = 'Priority';
        }
        field(24; "City"; Text[50])
        {
            Caption = 'City';
        }
        field(25; "Country/Region"; Code[10])
        {
            Caption = 'Country/Region';
            TableRelation = "Country/Region";
        }
        field(26; "Age Group"; Enum "CRM Age Group")
        {
            Caption = 'Age Group';
        }
        field(27; "Gender"; Enum "CRM Gender")
        {
            Caption = 'Gender';
        }
        field(28; "Education Level"; Enum "CRM Education Level")
        {
            Caption = 'Education Level';
        }
        field(29; "Work Experience"; Integer)
        {
            Caption = 'Work Experience (Years)';
        }
        field(30; "Current Employer"; Text[100])
        {
            Caption = 'Current Employer';
        }
        field(31; "Job Title"; Text[100])
        {
            Caption = 'Job Title';
        }
        field(32; "Annual Income"; Decimal)
        {
            Caption = 'Annual Income';
        }
        field(33; "Pain Points"; Text[250])
        {
            Caption = 'Pain Points';
        }
        field(34; "Goals"; Text[250])
        {
            Caption = 'Goals';
        }
        field(35; "Objections"; Text[250])
        {
            Caption = 'Objections';
        }
        field(36; "Decision Makers"; Text[250])
        {
            Caption = 'Decision Makers';
        }
        field(37; "Competition"; Text[100])
        {
            Caption = 'Competition';
        }
        field(38; "Referral Source"; Text[100])
        {
            Caption = 'Referral Source';
        }
        field(39; "Website Visits"; Integer)
        {
            Caption = 'Website Visits';
        }
        field(40; "Email Opens"; Integer)
        {
            Caption = 'Email Opens';
        }
        field(41; "Email Clicks"; Integer)
        {
            Caption = 'Email Clicks';
        }
        field(42; "Content Downloads"; Integer)
        {
            Caption = 'Content Downloads';
        }
        field(43; "Event Attendance"; Integer)
        {
            Caption = 'Event Attendance';
        }
        field(44; "Social Media Engagement"; Integer)
        {
            Caption = 'Social Media Engagement';
        }
        field(45; "Nurture Stage"; Enum "CRM Nurture Stage")
        {
            Caption = 'Nurture Stage';
        }
        field(46; "Lifecycle Stage"; Enum "CRM Lifecycle Stage")
        {
            Caption = 'Lifecycle Stage';
        }
        field(47; "GDPR Consent"; Boolean)
        {
            Caption = 'GDPR Consent';
        }
        field(48; "Email Opt-In"; Boolean)
        {
            Caption = 'Email Opt-In';
        }
        field(49; "SMS Opt-In"; Boolean)
        {
            Caption = 'SMS Opt-In';
        }
        field(50; "Do Not Contact"; Boolean)
        {
            Caption = 'Do Not Contact';
        }
        field(51; "Tags"; Text[250])
        {
            Caption = 'Tags';
        }
        field(52; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
        field(53; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(54; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(55; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(56; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(57; "Lost Reason"; Text[100])
        {
            Caption = 'Lost Reason';
        }
        field(58; "Estimated Value"; Decimal)
        {
            Caption = 'Estimated Value';
        }
        field(59; "Probability (%)"; Integer)
        {
            Caption = 'Probability (%)';
            MinValue = 0;
            MaxValue = 100;
        }
        field(60; "Expected Close Date"; Date)
        {
            Caption = 'Expected Close Date';
        }
    }
    
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Customer; "Customer No.")
        {
        }
        key(Status; "Lead Status", "Lead Score")
        {
        }
        key(AssignedTo; "Assigned To", "Lead Status")
        {
        }
        key(Source; "Lead Source")
        {
        }
        key(FollowUp; "Next Follow-up Date")
        {
        }
        key(Created; "Created Date")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
        if "Lead Status" = "Lead Status"::" " then
            "Lead Status" := "Lead Status"::New;
        if "Priority" = "Priority"::" " then
            "Priority" := "Priority"::Medium;
        CalculateLeadScore();
    end;
    
    trigger OnModify()
    begin
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
        CalculateLeadScore();
    end;
    
    local procedure CalculateLeadScore()
    var
        Score: Integer;
    begin
        Score := 0;
        
        // Source scoring
        case "Lead Source" of
            "Lead Source"::Referral:
                Score += 20;
            "Lead Source"::Website:
                Score += 15;
            "Lead Source"::"Social Media":
                Score += 10;
            else
                Score += 5;
        end;
        
        // Engagement scoring
        Score += "Website Visits" * 2;
        Score += "Email Opens" * 1;
        Score += "Email Clicks" * 3;
        Score += "Content Downloads" * 5;
        Score += "Event Attendance" * 10;
        
        // Interest level scoring
        case "Interest Level" of
            "Interest Level"::High:
                Score += 30;
            "Interest Level"::Medium:
                Score += 15;
            "Interest Level"::Low:
                Score += 5;
        end;
        
        // Budget scoring
        case "Budget Range" of
            "Budget Range"::"Above 1M":
                Score += 25;
            "Budget Range"::"500K-1M":
                Score += 20;
            "Budget Range"::"100K-500K":
                Score += 15;
            "Budget Range"::"50K-100K":
                Score += 10;
            else
                Score += 5;
        end;
        
        if Score > 100 then
            Score := 100;
        
        "Lead Score" := Score;
    end;
}