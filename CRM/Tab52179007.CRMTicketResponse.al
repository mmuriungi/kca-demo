table 52179007 "CRM Ticket Response"
{
    DataClassification = CustomerContent;
    Caption = 'CRM Ticket Response';
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Ticket No."; Code[20])
        {
            Caption = 'Ticket No.';
            TableRelation = "CRM Support Ticket";
        }
        field(3; "Response Date"; DateTime)
        {
            Caption = 'Response Date';
        }
        field(4; "Response From"; Code[50])
        {
            Caption = 'Response From';
            TableRelation = User."User Name";
        }
        field(5; "Response Type"; Enum "CRM Response Source")
        {
            Caption = 'Response Type';
        }
        field(6; "Response Text"; Text[2000])
        {
            Caption = 'Response Text';
        }
        field(7; "Internal Response"; Boolean)
        {
            Caption = 'Internal Response';
        }
        field(8; "Customer Visible"; Boolean)
        {
            Caption = 'Customer Visible';
            InitValue = true;
        }
        field(9; "Time Spent (Minutes)"; Integer)
        {
            Caption = 'Time Spent (Minutes)';
        }
        field(10; "Billable"; Boolean)
        {
            Caption = 'Billable';
        }
        field(11; "Billing Rate"; Decimal)
        {
            Caption = 'Billing Rate';
        }
        field(12; "Billing Amount"; Decimal)
        {
            Caption = 'Billing Amount';
        }
        field(13; "Email Sent"; Boolean)
        {
            Caption = 'Email Sent';
        }
        field(14; "SMS Sent"; Boolean)
        {
            Caption = 'SMS Sent';
        }
        field(15; "Attachment"; Media)
        {
            Caption = 'Attachment';
        }
        field(16; "Resolution Provided"; Boolean)
        {
            Caption = 'Resolution Provided';
        }
        field(17; "Escalation Response"; Boolean)
        {
            Caption = 'Escalation Response';
        }
        field(18; "Customer Satisfaction"; Integer)
        {
            Caption = 'Customer Satisfaction';
            MinValue = 1;
            MaxValue = 5;
        }
        field(19; "Follow-up Required"; Boolean)
        {
            Caption = 'Follow-up Required';
        }
        field(20; "Follow-up Date"; DateTime)
        {
            Caption = 'Follow-up Date';
        }
        field(21; "Knowledge Base Used"; Boolean)
        {
            Caption = 'Knowledge Base Used';
        }
        field(22; "Knowledge Base Article"; Code[20])
        {
            Caption = 'Knowledge Base Article';
        }
        field(23; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(24; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(25; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(26; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = User."User Name";
            Editable = false;
        }
    }
    
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Ticket; "Ticket No.", "Response Date")
        {
        }
        key(ResponseFrom; "Response From", "Response Date")
        {
        }
        key(Date; "Response Date")
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
        if "Billing Amount" = 0 then
            "Billing Amount" := "Time Spent (Minutes)" * "Billing Rate" / 60;
    end;
    
    trigger OnModify()
    begin
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
        if "Billing Amount" = 0 then
            "Billing Amount" := "Time Spent (Minutes)" * "Billing Rate" / 60;
    end;
}