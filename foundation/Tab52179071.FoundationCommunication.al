table 52179071 "Foundation Communication"
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Communication';
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Communication Date"; Date)
        {
            Caption = 'Communication Date';
        }
        field(3; "Communication Time"; Time)
        {
            Caption = 'Communication Time';
        }
        field(4; "Donor No."; Code[20])
        {
            Caption = 'Donor No.';
            TableRelation = "Foundation Donor";
            
            trigger OnValidate()
            var
                Donor: Record "Foundation Donor";
            begin
                if Donor.Get("Donor No.") then begin
                    "Donor Name" := Donor.Name;
                    "Contact Email" := Donor.Email;
                    "Contact Phone" := Donor."Phone No.";
                end;
            end;
        }
        field(5; "Donor Name"; Text[100])
        {
            Caption = 'Donor Name';
            Editable = false;
        }
        field(10; "Communication Type"; Option)
        {
            Caption = 'Communication Type';
            OptionMembers = " ",Email,Phone,Letter,SMS,Meeting,"Social Media",Newsletter,"Thank You",Reminder,Invitation;
            OptionCaption = ' ,Email,Phone,Letter,SMS,Meeting,Social Media,Newsletter,Thank You,Reminder,Invitation';
        }
        field(11; "Subject"; Text[100])
        {
            Caption = 'Subject';
        }
        field(12; "Content"; Text[2000])
        {
            Caption = 'Content';
        }
        field(13; "Method"; Option)
        {
            Caption = 'Method';
            OptionMembers = " ",Manual,Automated,Scheduled,Template;
            OptionCaption = ' ,Manual,Automated,Scheduled,Template';
        }
        field(14; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Draft,Sent,Delivered,Failed,Bounced,Opened,Clicked,Replied;
            OptionCaption = 'Draft,Sent,Delivered,Failed,Bounced,Opened,Clicked,Replied';
        }
        field(15; "Direction"; Option)
        {
            Caption = 'Direction';
            OptionMembers = Outbound,Inbound;
            OptionCaption = 'Outbound,Inbound';
        }
        field(20; "Contact Email"; Text[80])
        {
            Caption = 'Contact Email';
            ExtendedDatatype = EMail;
        }
        field(21; "Contact Phone"; Text[30])
        {
            Caption = 'Contact Phone';
            ExtendedDatatype = PhoneNo;
        }
        field(22; "Campaign Code"; Code[20])
        {
            Caption = 'Campaign Code';
            TableRelation = "Foundation Campaign";
        }
        field(30; "Sent Date"; Date)
        {
            Caption = 'Sent Date';
        }
        field(31; "Sent Time"; Time)
        {
            Caption = 'Sent Time';
        }
        field(32; "Delivered Date"; Date)
        {
            Caption = 'Delivered Date';
        }
        field(33; "Opened Date"; Date)
        {
            Caption = 'Opened Date';
        }
        field(34; "Reply Date"; Date)
        {
            Caption = 'Reply Date';
        }
        field(40; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(41; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(50; "Response Required"; Boolean)
        {
            Caption = 'Response Required';
        }
        field(51; "Response Received"; Boolean)
        {
            Caption = 'Response Received';
        }
        field(52; "Follow Up Date"; Date)
        {
            Caption = 'Follow Up Date';
        }
    }
    
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(DonorNo; "Donor No.", "Communication Date")
        {
        }
        key(CommunicationType; "Communication Type")
        {
        }
        key(Status; "Status")
        {
        }
        key(CommunicationDate; "Communication Date")
        {
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Donor Name", "Subject", "Communication Date")
        {
        }
    }
    
    trigger OnInsert()
    begin
        if "Communication Date" = 0D then
            "Communication Date" := WorkDate();
            
        if "Communication Time" = 0T then
            "Communication Time" := Time;
            
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;
}