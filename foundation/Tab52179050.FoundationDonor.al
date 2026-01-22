table 52179050 "Foundation Donor"
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Donor';
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "Donor Type"; Enum "Foundation Donor Type")
        {
            Caption = 'Donor Type';
        }
        field(3; "Name"; Text[100])
        {
            Caption = 'Name';
        }
        field(4; "Name 2"; Text[100])
        {
            Caption = 'Name 2';
        }
        field(5; "Contact Person"; Text[100])
        {
            Caption = 'Contact Person';
        }
        field(6; "Email"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }
        field(7; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(8; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(9; "Address"; Text[100])
        {
            Caption = 'Address';
        }
        field(10; "Address 2"; Text[100])
        {
            Caption = 'Address 2';
        }
        field(11; "City"; Text[30])
        {
            Caption = 'City';
        }
        field(12; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(13; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
        }
        field(14; "Alumni ID"; Code[20])
        {
            Caption = 'Alumni ID';
        }
        field(15; "Graduation Year"; Integer)
        {
            Caption = 'Graduation Year';
        }
        field(16; "Faculty"; Text[50])
        {
            Caption = 'Faculty';
        }
        field(17; "Department"; Text[50])
        {
            Caption = 'Department';
        }
        field(20; "Total Donations"; Decimal)
        {
            Caption = 'Total Donations';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Foundation Donation"."Amount" where("Donor No." = field("No."), 
                                                                   "Status" = const(Received)));
        }
        field(21; "Last Donation Date"; Date)
        {
            Caption = 'Last Donation Date';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = max("Foundation Donation"."Donation Date" where("Donor No." = field("No.")));
        }
        field(22; "No. of Donations"; Integer)
        {
            Caption = 'No. of Donations';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Foundation Donation" where("Donor No." = field("No."), 
                                                           "Status" = const(Received)));
        }
        field(23; "Active Pledges"; Decimal)
        {
            Caption = 'Active Pledges';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Foundation Pledge"."Amount" where("Donor No." = field("No."), 
                                                                 "Status" = filter(Active | PartiallyFulfilled)));
        }
        field(30; "Donor Since"; Date)
        {
            Caption = 'Donor Since';
        }
        field(31; "Donor Category"; Option)
        {
            Caption = 'Donor Category';
            OptionMembers = " ",Major,Regular,Occasional,Prospect;
            OptionCaption = ' ,Major,Regular,Occasional,Prospect';
        }
        field(32; "Preferred Contact Method"; Option)
        {
            Caption = 'Preferred Contact Method';
            OptionMembers = Email,Phone,Mail,SMS;
            OptionCaption = 'Email,Phone,Mail,SMS';
        }
        field(33; "Tax Exempt No."; Text[30])
        {
            Caption = 'Tax Exempt No.';
        }
        field(34; "Anonymous Donor"; Boolean)
        {
            Caption = 'Anonymous Donor';
        }
        field(35; "Recognition Level"; Option)
        {
            Caption = 'Recognition Level';
            OptionMembers = " ",Bronze,Silver,Gold,Platinum,Diamond;
            OptionCaption = ' ,Bronze,Silver,Gold,Platinum,Diamond';
        }
        field(40; "Marketing Opt-In"; Boolean)
        {
            Caption = 'Marketing Opt-In';
        }
        field(41; "Newsletter Subscription"; Boolean)
        {
            Caption = 'Newsletter Subscription';
        }
        field(42; "Event Invitations"; Boolean)
        {
            Caption = 'Event Invitations';
        }
        field(43; "Annual Report"; Boolean)
        {
            Caption = 'Annual Report';
        }
        field(50; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(51; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
        }
        field(52; "PayPal Email"; Text[80])
        {
            Caption = 'PayPal Email';
            ExtendedDatatype = EMail;
        }
        field(60; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(61; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(62; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(63; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(70; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
        field(71; "Blocked"; Boolean)
        {
            Caption = 'Blocked';
        }
        field(80; "No. Series"; Code[20])
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
        key(Name; "Name")
        {
        }
        key(Email; "Email")
        {
        }
        key(AlumniID; "Alumni ID")
        {
        }
        key(DonorType; "Donor Type")
        {
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Name", "Donor Type", "Total Donations")
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
    
    trigger OnDelete()
    var
        FoundationDonation: Record "Foundation Donation";
        FoundationPledge: Record "Foundation Pledge";
    begin
        FoundationDonation.SetRange("Donor No.", "No.");
        if not FoundationDonation.IsEmpty then
            Error('Cannot delete donor with existing donations.');
            
        FoundationPledge.SetRange("Donor No.", "No.");
        if not FoundationPledge.IsEmpty then
            Error('Cannot delete donor with existing pledges.');
    end;
    
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        
    procedure AssistEdit(OldDonor: Record "Foundation Donor"): Boolean
    var
        Donor: Record "Foundation Donor";
    begin
        Donor := Rec;
        TestNoSeries();
        if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldDonor."No. Series", Donor."No. Series") then begin
            TestNoSeries();
            NoSeriesMgt.SetSeries(Donor."No.");
            Rec := Donor;
            exit(true);
        end;
    end;
        
    local procedure TestNoSeries()
    var
        FoundationSetup: Record "Foundation Setup";
    begin
        FoundationSetup.Get();
        FoundationSetup.TestField("Donor Nos.");
    end;
    
    local procedure GetNoSeriesCode(): Code[20]
    var
        FoundationSetup: Record "Foundation Setup";
    begin
        FoundationSetup.Get();
        exit(FoundationSetup."Donor Nos.");
    end;
}