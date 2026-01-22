table 52179005 "CRM Campaign Response"
{
    DataClassification = CustomerContent;
    Caption = 'CRM Campaign Response';
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = "CRM Campaign";
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = "CRM Customer";
        }
        field(4; "Response Date"; DateTime)
        {
            Caption = 'Response Date';
        }
        field(5; "Responded"; Boolean)
        {
            Caption = 'Responded';
        }
        field(6; "Response Type"; Enum "CRM Response Type")
        {
            Caption = 'Response Type';
        }
        field(7; "Response Rating"; Integer)
        {
            Caption = 'Response Rating';
            MinValue = 1;
            MaxValue = 5;
        }
        field(8; "Email Delivered"; Boolean)
        {
            Caption = 'Email Delivered';
        }
        field(9; "Email Opens"; Integer)
        {
            Caption = 'Email Opens';
        }
        field(10; "Email Clicks"; Integer)
        {
            Caption = 'Email Clicks';
        }
        field(11; "Email Bounced"; Boolean)
        {
            Caption = 'Email Bounced';
        }
        field(12; "Unsubscribed"; Boolean)
        {
            Caption = 'Unsubscribed';
        }
        field(13; "Marked as Spam"; Boolean)
        {
            Caption = 'Marked as Spam';
        }
        field(14; "Response Rate"; Decimal)
        {
            Caption = 'Response Rate (%)';
            DecimalPlaces = 0 : 2;
        }
        field(15; "Conversion Rate"; Decimal)
        {
            Caption = 'Conversion Rate (%)';
            DecimalPlaces = 0 : 2;
        }
        field(16; "Lead Generated"; Boolean)
        {
            Caption = 'Lead Generated';
        }
        field(17; "Opportunity Created"; Boolean)
        {
            Caption = 'Opportunity Created';
        }
        field(18; "Sale Made"; Boolean)
        {
            Caption = 'Sale Made';
        }
        field(19; "Sale Amount"; Decimal)
        {
            Caption = 'Sale Amount';
        }
        field(20; "Channel Used"; Enum "CRM Marketing Channel")
        {
            Caption = 'Channel Used';
        }
        field(21; "Device Type"; Enum "CRM Device Type")
        {
            Caption = 'Device Type';
        }
        field(22; "IP Address"; Text[50])
        {
            Caption = 'IP Address';
        }
        field(23; "Geographic Location"; Text[100])
        {
            Caption = 'Geographic Location';
        }
        field(24; "User Agent"; Text[250])
        {
            Caption = 'User Agent';
        }
        field(25; "Time Spent (Seconds)"; Integer)
        {
            Caption = 'Time Spent (Seconds)';
        }
        field(26; "Pages Visited"; Integer)
        {
            Caption = 'Pages Visited';
        }
        field(27; "Download Occurred"; Boolean)
        {
            Caption = 'Download Occurred';
        }
        field(28; "Form Submitted"; Boolean)
        {
            Caption = 'Form Submitted';
        }
        field(29; "Video Watched"; Boolean)
        {
            Caption = 'Video Watched';
        }
        field(30; "Video Watch Time (%)"; Integer)
        {
            Caption = 'Video Watch Time (%)';
            MinValue = 0;
            MaxValue = 100;
        }
        field(31; "Social Share"; Boolean)
        {
            Caption = 'Social Share';
        }
        field(32; "Comments Made"; Integer)
        {
            Caption = 'Comments Made';
        }
        field(33; "Referrals Generated"; Integer)
        {
            Caption = 'Referrals Generated';
        }
        field(34; "Follow-up Required"; Boolean)
        {
            Caption = 'Follow-up Required';
        }
        field(35; "Follow-up Date"; Date)
        {
            Caption = 'Follow-up Date';
        }
        field(36; "Follow-up Completed"; Boolean)
        {
            Caption = 'Follow-up Completed';
        }
        field(37; "Customer Feedback"; Text[250])
        {
            Caption = 'Customer Feedback';
        }
        field(38; "Satisfaction Score"; Integer)
        {
            Caption = 'Satisfaction Score';
            MinValue = 1;
            MaxValue = 10;
        }
        field(39; "A/B Test Variant"; Text[50])
        {
            Caption = 'A/B Test Variant';
        }
        field(40; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(41; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(42; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(43; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(44; "UTM Source"; Text[50])
        {
            Caption = 'UTM Source';
        }
        field(45; "UTM Medium"; Text[50])
        {
            Caption = 'UTM Medium';
        }
        field(46; "UTM Campaign"; Text[50])
        {
            Caption = 'UTM Campaign';
        }
        field(47; "UTM Term"; Text[50])
        {
            Caption = 'UTM Term';
        }
        field(48; "UTM Content"; Text[50])
        {
            Caption = 'UTM Content';
        }
        field(49; "Engagement Score"; Decimal)
        {
            Caption = 'Engagement Score';
            DecimalPlaces = 0 : 2;
        }
        field(50; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
    }
    
    keys
    {
        key(PK; "Entry No.", "Customer No.")
        {
            Clustered = true;
        }
        key(Campaign; "Campaign No.", "Customer No.")
        {
        }
        key(Customer; "Customer No.", "Response Date")
        {
        }
        key(Response; "Responded", "Response Date")
        {
        }
        key(Channel; "Channel Used")
        {
        }
        key(Conversion; "Sale Made", "Sale Amount")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
        if "Response Date" = 0DT then
            "Response Date" := CurrentDateTime;
        if "Entry No." = 0 then 
            "Entry No." := Random(1000000);
    end;
    
    trigger OnModify()
    begin
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
    end;
}