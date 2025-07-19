table 52179000 "CRM Customer"
{
    DataClassification = CustomerContent;
    Caption = 'CRM Customer';
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "Customer Type"; Enum "CRM Customer Type")
        {
            Caption = 'Customer Type';
        }
        field(3; "First Name"; Text[50])
        {
            Caption = 'First Name';
        }
        field(4; "Middle Name"; Text[50])
        {
            Caption = 'Middle Name';
        }
        field(5; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(6; "Full Name"; Text[150])
        {
            Caption = 'Full Name';
        }
        field(7; "Email"; Text[100])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(9; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(10; "Address"; Text[100])
        {
            Caption = 'Address';
        }
        field(11; "Address 2"; Text[100])
        {
            Caption = 'Address 2';
        }
        field(12; "City"; Text[50])
        {
            Caption = 'City';
        }
        field(13; "County"; Text[50])
        {
            Caption = 'County';
        }
        field(14; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(15; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
        }
        field(16; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
        }
        field(17; "Gender"; Enum "CRM Gender")
        {
            Caption = 'Gender';
        }
        field(18; "Marital Status"; Enum "CRM Marital Status")
        {
            Caption = 'Marital Status';
        }
        field(19; "Nationality"; Code[10])
        {
            Caption = 'Nationality';
            TableRelation = "Country/Region";
        }
        field(20; "ID/Passport No."; Text[50])
        {
            Caption = 'ID/Passport No.';
        }
        field(21; "Student No."; Code[20])
        {
            Caption = 'Student No.';
        }
        field(22; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(23; "Alumni No."; Code[20])
        {
            Caption = 'Alumni No.';
        }
        field(24; "Parent/Guardian Name"; Text[100])
        {
            Caption = 'Parent/Guardian Name';
        }
        field(25; "Parent/Guardian Phone"; Text[30])
        {
            Caption = 'Parent/Guardian Phone';
            ExtendedDatatype = PhoneNo;
        }
        field(26; "Academic Program"; Code[20])
        {
            Caption = 'Academic Program';
        }
        field(27; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(28; "Graduation Date"; Date)
        {
            Caption = 'Graduation Date';
        }
        field(29; "Enrollment Date"; Date)
        {
            Caption = 'Enrollment Date';
        }
        field(30; "Lead Source"; Enum "CRM Lead Source")
        {
            Caption = 'Lead Source';
        }
        field(31; "Lead Status"; Enum "CRM Lead Status")
        {
            Caption = 'Lead Status';
        }
        field(32; "Lead Score"; Integer)
        {
            Caption = 'Lead Score';
            MinValue = 0;
            MaxValue = 100;
        }
        field(33; "Preferred Contact Method"; Enum "CRM Contact Method")
        {
            Caption = 'Preferred Contact Method';
        }
        field(34; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(35; "Segmentation Code"; Code[20])
        {
            Caption = 'Segmentation Code';
            TableRelation = "CRM Segmentation";
        }
        field(36; "Last Interaction Date"; Date)
        {
            Caption = 'Last Interaction Date';
            Editable = false;
        }
        field(37; "Total Interactions"; Integer)
        {
            Caption = 'Total Interactions';
            FieldClass = FlowField;
            CalcFormula = count("CRM Interaction Log" where("Customer No." = field("No.")));
            Editable = false;
        }
        field(38; "Engagement Score"; Decimal)
        {
            Caption = 'Engagement Score';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(39; "Lifetime Value"; Decimal)
        {
            Caption = 'Lifetime Value';
            FieldClass = FlowField;
            CalcFormula = sum("CRM Transaction".Amount where("Customer No." = field("No."), "Transaction Type" = const(Payment)));
            Editable = false;
        }
        field(40; "Total Donations"; Decimal)
        {
            Caption = 'Total Donations';
            FieldClass = FlowField;
            CalcFormula = sum("CRM Transaction".Amount where("Customer No." = field("No."), "Transaction Type" = const(Donation)));
            Editable = false;
        }
        field(41; "Last Donation Date"; Date)
        {
            Caption = 'Last Donation Date';
            Editable = false;
        }
        field(42; "VIP"; Boolean)
        {
            Caption = 'VIP';
        }
        field(43; "Do Not Contact"; Boolean)
        {
            Caption = 'Do Not Contact';
        }
        field(44; "Email Opt-In"; Boolean)
        {
            Caption = 'Email Opt-In';
        }
        field(45; "SMS Opt-In"; Boolean)
        {
            Caption = 'SMS Opt-In';
        }
        field(46; "Phone Opt-In"; Boolean)
        {
            Caption = 'Phone Opt-In';
        }
        field(47; "Social Media Handle"; Text[50])
        {
            Caption = 'Social Media Handle';
        }
        field(48; "LinkedIn Profile"; Text[100])
        {
            Caption = 'LinkedIn Profile';
            ExtendedDatatype = URL;
        }
        field(49; "Facebook Profile"; Text[100])
        {
            Caption = 'Facebook Profile';
            ExtendedDatatype = URL;
        }
        field(50; "Twitter Handle"; Text[50])
        {
            Caption = 'Twitter Handle';
        }
        field(51; "Instagram Handle"; Text[50])
        {
            Caption = 'Instagram Handle';
        }
        field(52; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
        }
        field(53; "Job Title"; Text[100])
        {
            Caption = 'Job Title';
        }
        field(54; "Industry"; Code[20])
        {
            Caption = 'Industry';
        }
        field(55; "Annual Income"; Decimal)
        {
            Caption = 'Annual Income';
        }
        field(56; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
        field(57; "Tags"; Text[250])
        {
            Caption = 'Tags';
        }
        field(58; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(59; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(60; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(61; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(62; "Inactive"; Boolean)
        {
            Caption = 'Inactive';
        }
        field(63; "GDPR Consent Date"; DateTime)
        {
            Caption = 'GDPR Consent Date';
        }
        field(64; "Data Retention Date"; Date)
        {
            Caption = 'Data Retention Date';
        }
        field(65; "Preferred Language"; Code[10])
        {
            Caption = 'Preferred Language';
            TableRelation = Language;
        }
        field(66; "Time Zone"; Text[50])
        {
            Caption = 'Time Zone';
        }
        field(67; "Campaign Responses"; Integer)
        {
            Caption = 'Campaign Responses';
            FieldClass = FlowField;
            CalcFormula = count("CRM Campaign Response" where("Customer No." = field("No.")));
            Editable = false;
        }
        field(68; "Event Attendance"; Integer)
        {
            Caption = 'Event Attendance';
            FieldClass = FlowField;
            CalcFormula = count("Event Attendee" where("Attendee No." = field("No.")));
            Editable = false;
        }
        field(69; "Support Tickets"; Integer)
        {
            Caption = 'Support Tickets';
            FieldClass = FlowField;
            CalcFormula = count("CRM Support Ticket" where("Customer No." = field("No.")));
            Editable = false;
        }
        field(70; "Satisfaction Score"; Decimal)
        {
            Caption = 'Satisfaction Score';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            MaxValue = 10;
        }
        field(71; "Age Group"; Enum "CRM Age Group")
        {
            Caption = 'Age Group';
        }
    }
    
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Email; "Email")
        {
        }
        key(CustomerType; "Customer Type")
        {
        }
        key(LeadStatus; "Lead Status")
        {
        }
        key(Segmentation; "Segmentation Code")
        {
        }
        key(LastInteraction; "Last Interaction Date")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
        UpdateFullName();
    end;
    
    trigger OnModify()
    begin
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
        UpdateFullName();
    end;
    
    local procedure UpdateFullName()
    begin
        "Full Name" := "First Name";
        if "Middle Name" <> '' then
            "Full Name" += ' ' + "Middle Name";
        if "Last Name" <> '' then
            "Full Name" += ' ' + "Last Name";
        "Full Name" := DelChr("Full Name", '<>', ' ');
    end;
}