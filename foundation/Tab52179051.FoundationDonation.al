table 52179051 "Foundation Donation"
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Donation';
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "Donor No."; Code[20])
        {
            Caption = 'Donor No.';
            TableRelation = "Foundation Donor";
            
            trigger OnValidate()
            var
                Donor: Record "Foundation Donor";
            begin
                if Donor.Get("Donor No.") then begin
                    "Donor Name" := Donor.Name;
                    "Donor Type" := Donor."Donor Type";
                end;
            end;
        }
        field(3; "Donor Name"; Text[100])
        {
            Caption = 'Donor Name';
            Editable = false;
        }
        field(4; "Donor Type"; Enum "Foundation Donor Type")
        {
            Caption = 'Donor Type';
            Editable = false;
        }
        field(5; "Donation Date"; Date)
        {
            Caption = 'Donation Date';
        }
        field(6; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 2:2;
        }
        field(7; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(8; "Payment Method"; Option)
        {
            Caption = 'Payment Method';
            OptionMembers = " ",Cash,"Bank Transfer",Cheque,"Credit Card","Debit Card",PayPal,Mpesa,"Wire Transfer",Other;
            OptionCaption = ' ,Cash,Bank Transfer,Cheque,Credit Card,Debit Card,PayPal,M-Pesa,Wire Transfer,Other';
        }
        field(9; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
        }
        field(10; "Purpose"; Enum "Foundation Donation Purpose")
        {
            Caption = 'Purpose';
        }
        field(11; "Specific Purpose"; Text[100])
        {
            Caption = 'Specific Purpose';
        }
        field(12; "Campaign Code"; Code[20])
        {
            Caption = 'Campaign Code';
            TableRelation = "Foundation Campaign";
        }
        field(13; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending,Received,Rejected,Cancelled;
            OptionCaption = 'Pending,Received,Rejected,Cancelled';
        }
        field(14; "Bank Reference"; Text[50])
        {
            Caption = 'Bank Reference';
        }
        field(15; "Pledge No."; Code[20])
        {
            Caption = 'Pledge No.';
            TableRelation = "Foundation Pledge";
        }
        field(16; "Tax Deductible"; Boolean)
        {
            Caption = 'Tax Deductible';
        }
        field(17; "Tax Certificate Issued"; Boolean)
        {
            Caption = 'Tax Certificate Issued';
        }
        field(18; "Tax Certificate No."; Code[30])
        {
            Caption = 'Tax Certificate No.';
        }
        field(19; "Tax Certificate Date"; Date)
        {
            Caption = 'Tax Certificate Date';
        }
        field(20; "Anonymous"; Boolean)
        {
            Caption = 'Anonymous';
        }
        field(21; "In Honor Of"; Text[100])
        {
            Caption = 'In Honor Of';
        }
        field(22; "In Memory Of"; Text[100])
        {
            Caption = 'In Memory Of';
        }
        field(23; "Acknowledgment Sent"; Boolean)
        {
            Caption = 'Acknowledgment Sent';
        }
        field(24; "Acknowledgment Date"; Date)
        {
            Caption = 'Acknowledgment Date';
        }
        field(25; "Thank You Letter Sent"; Boolean)
        {
            Caption = 'Thank You Letter Sent';
        }
        field(26; "Thank You Letter Date"; Date)
        {
            Caption = 'Thank You Letter Date';
        }
        field(30; "GL Account No."; Code[20])
        {
            Caption = 'GL Account No.';
            TableRelation = "G/L Account";
        }
        field(31; "Posted"; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(32; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
            Editable = false;
        }
        field(33; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            TableRelation = User."User Name";
            Editable = false;
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
        key(DonorNo; "Donor No.", "Donation Date")
        {
        }
        key(CampaignCode; "Campaign Code")
        {
        }
        key(DonationDate; "Donation Date")
        {
        }
        key(Status; "Status")
        {
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Donor Name", "Amount", "Donation Date")
        {
        }
    }
    
    trigger OnInsert()
    begin
        if "No." = '' then begin
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "No.", "No. Series");
        end;
        
        if "Donation Date" = 0D then
            "Donation Date" := WorkDate();
            
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;
    
    trigger OnModify()
    begin
        TestField(Posted, false);
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;
    
    trigger OnDelete()
    begin
        TestField(Posted, false);
    end;
    
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        
    procedure AssistEdit(OldDonation: Record "Foundation Donation"): Boolean
    var
        Donation: Record "Foundation Donation";
    begin
        Donation := Rec;
        TestNoSeries();
        if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldDonation."No. Series", Donation."No. Series") then begin
            TestNoSeries();
            NoSeriesMgt.SetSeries(Donation."No.");
            Rec := Donation;
            exit(true);
        end;
    end;
        
    local procedure TestNoSeries()
    var
        FoundationSetup: Record "Foundation Setup";
    begin
        FoundationSetup.Get();
        FoundationSetup.TestField("Donation Nos.");
    end;
    
    local procedure GetNoSeriesCode(): Code[20]
    var
        FoundationSetup: Record "Foundation Setup";
    begin
        FoundationSetup.Get();
        exit(FoundationSetup."Donation Nos.");
    end;
}