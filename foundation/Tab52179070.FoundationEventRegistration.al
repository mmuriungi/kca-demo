table 52179070 "Foundation Event Registration"
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Event Registration';
    
    fields
    {
        field(1; "Registration No."; Code[20])
        {
            Caption = 'Registration No.';
            NotBlank = true;
        }
        field(2; "Event No."; Code[20])
        {
            Caption = 'Event No.';
            TableRelation = "Foundation Event";
            
            trigger OnValidate()
            var
                Events: Record "Foundation Event";
            begin
                if Events.Get("Event No.") then begin
                    "Event Name" := Events."Event Name";
                    "Event Date" := Events."Event Date";
                end;
            end;
        }
        field(3; "Event Name"; Text[100])
        {
            Caption = 'Event Name';
            Editable = false;
        }
        field(4; "Event Date"; Date)
        {
            Caption = 'Event Date';
            Editable = false;
        }
        field(5; "Donor No."; Code[20])
        {
            Caption = 'Donor No.';
            TableRelation = "Foundation Donor";
            
            trigger OnValidate()
            var
                Donor: Record "Foundation Donor";
            begin
                if Donor.Get("Donor No.") then begin
                    "Donor Name" := Donor.Name;
                    Email := Donor.Email;
                    "Phone No." := Donor."Phone No.";
                end;
            end;
        }
        field(6; "Donor Name"; Text[100])
        {
            Caption = 'Donor Name';
            Editable = false;
        }
        field(10; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
        }
        field(11; "Registration Time"; Time)
        {
            Caption = 'Registration Time';
        }
        field(12; "Attendance Status"; Option)
        {
            Caption = 'Attendance Status';
            OptionMembers = Registered,Confirmed,Attended,"No Show",Cancelled;
            OptionCaption = 'Registered,Confirmed,Attended,No Show,Cancelled';
        }
        field(13; "Ticket Type"; Option)
        {
            Caption = 'Ticket Type';
            OptionMembers = " ",General,VIP,Sponsor,Student,Faculty,Alumni;
            OptionCaption = ' ,General,VIP,Sponsor,Student,Faculty,Alumni';
        }
        field(14; "Registration Fee"; Decimal)
        {
            Caption = 'Registration Fee';
            DecimalPlaces = 2:2;
        }
        field(15; "Payment Status"; Option)
        {
            Caption = 'Payment Status';
            OptionMembers = " ",Pending,Paid,Waived,Refunded;
            OptionCaption = ' ,Pending,Paid,Waived,Refunded';
        }
        field(20; "Email"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }
        field(21; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(22; "Dietary Requirements"; Text[100])
        {
            Caption = 'Dietary Requirements';
        }
        field(23; "Special Needs"; Text[100])
        {
            Caption = 'Special Needs';
        }
        field(30; "Guest Count"; Integer)
        {
            Caption = 'Guest Count';
        }
        field(31; "Table Assignment"; Code[20])
        {
            Caption = 'Table Assignment';
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
        field(42; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(43; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(50; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
        field(60; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }
    
    keys
    {
        key(PK; "Registration No.")
        {
            Clustered = true;
        }
        key(EventNo; "Event No.", "Registration Date")
        {
        }
        key(DonorNo; "Donor No.")
        {
        }
        key(AttendanceStatus; "Attendance Status")
        {
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown; "Registration No.", "Donor Name", "Event Name", "Registration Date")
        {
        }
    }
    
    trigger OnInsert()
    begin        
        if "Registration Date" = 0D then
            "Registration Date" := WorkDate();
            
        if "Registration Time" = 0T then
            "Registration Time" := Time;
            
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;
    
    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;
    
}