table 52179053 "Foundation Campaign"
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Campaign';
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "Name"; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(6; "Status"; Enum "Foundation Campaign Status")
        {
            Caption = 'Status';
        }
        field(7; "Goal Amount"; Decimal)
        {
            Caption = 'Goal Amount';
            DecimalPlaces = 2:2;
        }
        field(8; "Raised Amount"; Decimal)
        {
            Caption = 'Raised Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Foundation Donation"."Amount" where("Campaign Code" = field("No."), 
                                                                   "Status" = const(Received)));
        }
        field(9; "No. of Donations"; Integer)
        {
            Caption = 'No. of Donations';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Foundation Donation" where("Campaign Code" = field("No."), 
                                                           "Status" = const(Received)));
        }
        field(10; "No. of Donors"; Integer)
        {
            Caption = 'No. of Donors';
            Editable = false;
        }
        field(11; "Average Donation"; Decimal)
        {
            Caption = 'Average Donation';
            Editable = false;
            DecimalPlaces = 2:2;
        }
        field(12; "Purpose"; Enum "Foundation Donation Purpose")
        {
            Caption = 'Purpose';
        }
        field(13; "Campaign Manager"; Code[50])
        {
            Caption = 'Campaign Manager';
            TableRelation = User."User Name";
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
        field(16; "ROI Percentage"; Decimal)
        {
            Caption = 'ROI Percentage';
            Editable = false;
            DecimalPlaces = 2:2;
        }
        field(20; "Target Audience"; Text[100])
        {
            Caption = 'Target Audience';
        }
        field(21; "Marketing Channels"; Text[250])
        {
            Caption = 'Marketing Channels';
        }
        field(22; "Website URL"; Text[250])
        {
            Caption = 'Website URL';
            ExtendedDatatype = URL;
        }
        field(30; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(31; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(32; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(33; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(40; "No. Series"; Code[20])
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
        key(StartDate; "Start Date")
        {
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Name", "Goal Amount", "Raised Amount")
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
        CalcFields("Raised Amount", "No. of Donations");
        if "No. of Donations" <> 0 then
            "Average Donation" := "Raised Amount" / "No. of Donations"
        else
            "Average Donation" := 0;
            
        if "Actual Cost" <> 0 then
            "ROI Percentage" := (("Raised Amount" - "Actual Cost") / "Actual Cost") * 100
        else
            "ROI Percentage" := 0;
    end;
    
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        
    local procedure TestNoSeries()
    var
        FoundationSetup: Record "Foundation Setup";
    begin
        FoundationSetup.Get();
        FoundationSetup.TestField("Campaign Nos.");
    end;
    
    local procedure GetNoSeriesCode(): Code[20]
    var
        FoundationSetup: Record "Foundation Setup";
    begin
        FoundationSetup.Get();
        exit(FoundationSetup."Campaign Nos.");
    end;
}