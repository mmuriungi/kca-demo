table 52179054 "Foundation Pledge"
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Pledge';
    
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
        field(5; "Pledge Date"; Date)
        {
            Caption = 'Pledge Date';
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
        field(8; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(9; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(10; "Frequency"; Option)
        {
            Caption = 'Frequency';
            OptionMembers = " ",OneTime,Monthly,Quarterly,SemiAnnual,Annual;
            OptionCaption = ' ,One Time,Monthly,Quarterly,Semi-Annual,Annual';
        }
        field(11; "No. of Installments"; Integer)
        {
            Caption = 'No. of Installments';
        }
        field(12; "Installment Amount"; Decimal)
        {
            Caption = 'Installment Amount';
            DecimalPlaces = 2:2;
        }
        field(13; "Amount Received"; Decimal)
        {
            Caption = 'Amount Received';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Foundation Donation"."Amount" where("Pledge No." = field("No."), 
                                                                   "Status" = const(Received)));
        }
        field(14; "Remaining Amount"; Decimal)
        {
            Caption = 'Remaining Amount';
            Editable = false;
        }
        field(15; "Status"; Enum "Foundation Pledge Status")
        {
            Caption = 'Status';
        }
        field(16; "Purpose"; Enum "Foundation Donation Purpose")
        {
            Caption = 'Purpose';
        }
        field(17; "Specific Purpose"; Text[100])
        {
            Caption = 'Specific Purpose';
        }
        field(18; "Campaign Code"; Code[20])
        {
            Caption = 'Campaign Code';
            TableRelation = "Foundation Campaign";
        }
        field(19; "Next Payment Date"; Date)
        {
            Caption = 'Next Payment Date';
        }
        field(20; "Last Payment Date"; Date)
        {
            Caption = 'Last Payment Date';
            Editable = false;
        }
        field(21; "No. of Payments Made"; Integer)
        {
            Caption = 'No. of Payments Made';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Foundation Donation" where("Pledge No." = field("No."), 
                                                           "Status" = const(Received)));
        }
        field(22; "Payment Reminder Sent"; Boolean)
        {
            Caption = 'Payment Reminder Sent';
        }
        field(23; "Reminder Date"; Date)
        {
            Caption = 'Reminder Date';
        }
        field(30; "Anonymous"; Boolean)
        {
            Caption = 'Anonymous';
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
        key(DonorNo; "Donor No.")
        {
        }
        key(Status; "Status")
        {
        }
        key(NextPaymentDate; "Next Payment Date")
        {
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Donor Name", "Amount", "Status")
        {
        }
    }
    
    trigger OnInsert()
    begin
        if "No." = '' then begin
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "No.", "No. Series");
        end;
        
        if "Pledge Date" = 0D then
            "Pledge Date" := WorkDate();
            
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;
    
    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
        
        CalcFields("Amount Received");
        "Remaining Amount" := "Amount" - "Amount Received";
        
        UpdateStatus();
    end;
    
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        
    local procedure TestNoSeries()
    var
        FoundationSetup: Record "Foundation Setup";
    begin
        FoundationSetup.Get();
        FoundationSetup.TestField("Pledge Nos.");
    end;
    
    local procedure GetNoSeriesCode(): Code[20]
    var
        FoundationSetup: Record "Foundation Setup";
    begin
        FoundationSetup.Get();
        exit(FoundationSetup."Pledge Nos.");
    end;
    
    local procedure UpdateStatus()
    begin
        if "Remaining Amount" = 0 then
            Status := Status::Fulfilled
        else if "Amount Received" > 0 then
            Status := Status::PartiallyFulfilled
        else if ("Next Payment Date" <> 0D) and ("Next Payment Date" < WorkDate()) then
            Status := Status::Overdue;
    end;
}