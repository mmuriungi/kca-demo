table 52179057 "Foundation Event"
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Event';
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "Event Name"; Text[100])
        {
            Caption = 'Event Name';
        }
        field(3; "Event Type"; Enum "Foundation Event Type")
        {
            Caption = 'Event Type';
        }
        field(4; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(5; "Event Date"; Date)
        {
            Caption = 'Event Date';
        }
        field(6; "Start Time"; Time)
        {
            Caption = 'Start Time';
        }
        field(7; "End Time"; Time)
        {
            Caption = 'End Time';
        }
        field(8; "Venue"; Text[100])
        {
            Caption = 'Venue';
        }
        field(9; "Address"; Text[250])
        {
            Caption = 'Address';
        }
        field(10; "City"; Text[30])
        {
            Caption = 'City';
        }
        field(11; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Planning,Scheduled,InProgress,Completed,Cancelled;
            OptionCaption = 'Planning,Scheduled,In Progress,Completed,Cancelled';
        }
        field(12; "Target Amount"; Decimal)
        {
            Caption = 'Target Amount';
            DecimalPlaces = 2:2;
        }
        field(13; "Raised Amount"; Decimal)
        {
            Caption = 'Raised Amount';
            DecimalPlaces = 2:2;
        }
        field(14; "Budget"; Decimal)
        {
            Caption = 'Budget';
            DecimalPlaces = 2:2;
        }
        field(15; "Actual Cost"; Decimal)
        {
            Caption = 'Actual Cost';
            DecimalPlaces = 2:2;
        }
        field(16; "Expected Attendance"; Integer)
        {
            Caption = 'Expected Attendance';
        }
        field(17; "Actual Attendance"; Integer)
        {
            Caption = 'Actual Attendance';
        }
        field(18; "Ticket Price"; Decimal)
        {
            Caption = 'Ticket Price';
            DecimalPlaces = 2:2;
        }
        field(19; "Sponsor Amount"; Decimal)
        {
            Caption = 'Sponsor Amount';
            DecimalPlaces = 2:2;
        }
        field(20; "Event Coordinator"; Code[50])
        {
            Caption = 'Event Coordinator';
            TableRelation = User."User Name";
        }
        field(21; "Campaign Code"; Code[20])
        {
            Caption = 'Campaign Code';
            TableRelation = "Foundation Campaign";
        }
        field(22; "Registration Required"; Boolean)
        {
            Caption = 'Registration Required';
        }
        field(23; "Registration Deadline"; Date)
        {
            Caption = 'Registration Deadline';
        }
        field(24; "Max Registrations"; Integer)
        {
            Caption = 'Max Registrations';
        }
        field(25; "No. Registered"; Integer)
        {
            Caption = 'No. Registered';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Foundation Event Registration" where("Event No." = field("No.")));
        }
        field(26; "No. Attended"; Integer)
        {
            Caption = 'No. Attended';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Foundation Event Registration" where("Event No." = field("No."), 
                                                                     "Attendance Status" = const(Attended)));
        }
        field(30; "Send Invitations"; Boolean)
        {
            Caption = 'Send Invitations';
        }
        field(31; "Invitations Sent"; Boolean)
        {
            Caption = 'Invitations Sent';
        }
        field(32; "Invitation Date"; Date)
        {
            Caption = 'Invitation Date';
        }
        field(33; "Send Reminders"; Boolean)
        {
            Caption = 'Send Reminders';
        }
        field(34; "Reminder Date"; Date)
        {
            Caption = 'Reminder Date';
        }
        field(35; "Thank You Sent"; Boolean)
        {
            Caption = 'Thank You Sent';
        }
        field(36; "Thank You Date"; Date)
        {
            Caption = 'Thank You Date';
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
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(EventDate; "Event Date")
        {
        }
        key(Status; "Status")
        {
        }
        key(EventType; "Event Type")
        {
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Event Name", "Event Date", "Status")
        {
        }
    }
    
    trigger OnInsert()
    begin
        if "No." = '' then begin
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "No.", "No. Series");
        end;
        
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;
    
    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;
    
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        
    local procedure TestNoSeries()
    var
        FoundationSetup: Record "Foundation Setup";
    begin
        FoundationSetup.Get();
        FoundationSetup.TestField("Event Nos.");
    end;
    
    local procedure GetNoSeriesCode(): Code[20]
    var
        FoundationSetup: Record "Foundation Setup";
    begin
        FoundationSetup.Get();
        exit(FoundationSetup."Event Nos.");
    end;
}