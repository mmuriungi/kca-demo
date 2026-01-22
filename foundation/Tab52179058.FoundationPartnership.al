table 52179058 "Foundation Partnership"
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Partnership';
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "Partner Name"; Text[100])
        {
            Caption = 'Partner Name';
        }
        field(3; "Partnership Type"; Enum "Foundation Partnership Type")
        {
            Caption = 'Partnership Type';
        }
        field(4; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(7; "Status"; Enum "Foundation Partnership Status")
        {
            Caption = 'Status';
        }
        field(8; "Contact Person"; Text[100])
        {
            Caption = 'Contact Person';
        }
        field(9; "Email"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }
        field(10; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(11; "Address"; Text[100])
        {
            Caption = 'Address';
        }
        field(12; "City"; Text[30])
        {
            Caption = 'City';
        }
        field(13; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(14; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
        }
        field(15; "Agreement No."; Code[30])
        {
            Caption = 'Agreement No.';
        }
        field(16; "Agreement Date"; Date)
        {
            Caption = 'Agreement Date';
        }
        field(17; "Agreement Type"; Option)
        {
            Caption = 'Agreement Type';
            OptionMembers = " ",MOU,Contract,LOI,Other;
            OptionCaption = ' ,MOU,Contract,Letter of Intent,Other';
        }
        field(18; "Financial Commitment"; Decimal)
        {
            Caption = 'Financial Commitment';
            DecimalPlaces = 2:2;
        }
        field(19; "Total Contributed"; Decimal)
        {
            Caption = 'Total Contributed';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Foundation Donation"."Amount" where("Donor No." = field("Related Donor No."), 
                                                                   "Status" = const(Received)));
        }
        field(20; "Related Donor No."; Code[20])
        {
            Caption = 'Related Donor No.';
            TableRelation = "Foundation Donor";
        }
        field(21; "Objectives"; Text[250])
        {
            Caption = 'Objectives';
        }
        field(22; "Key Deliverables"; Text[250])
        {
            Caption = 'Key Deliverables';
        }
        field(23; "Performance Metrics"; Text[250])
        {
            Caption = 'Performance Metrics';
        }
        field(24; "Review Date"; Date)
        {
            Caption = 'Review Date';
        }
        field(25; "Renewal Date"; Date)
        {
            Caption = 'Renewal Date';
        }
        field(26; "Auto Renewal"; Boolean)
        {
            Caption = 'Auto Renewal';
        }
        field(27; "Termination Clause"; Text[250])
        {
            Caption = 'Termination Clause';
        }
        field(30; "Primary Contact"; Code[50])
        {
            Caption = 'Primary Contact';
            TableRelation = User."User Name";
        }
        field(31; "Secondary Contact"; Code[50])
        {
            Caption = 'Secondary Contact';
            TableRelation = User."User Name";
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
        key(Status; "Status")
        {
        }
        key(PartnershipType; "Partnership Type")
        {
        }
        key(EndDate; "End Date")
        {
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Partner Name", "Partnership Type", "Status")
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
        FoundationSetup.TestField("Partnership Nos.");
    end;
    
    local procedure GetNoSeriesCode(): Code[20]
    var
        FoundationSetup: Record "Foundation Setup";
    begin
        FoundationSetup.Get();
        exit(FoundationSetup."Partnership Nos.");
    end;
}