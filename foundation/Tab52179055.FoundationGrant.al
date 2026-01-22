table 52179055 "Foundation Grant"
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Grant';
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "Grant Name"; Text[100])
        {
            Caption = 'Grant Name';
        }
        field(3; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(4; "Grant Type"; Option)
        {
            Caption = 'Grant Type';
            OptionMembers = " ",Research,Academic,Infrastructure,Equipment,Innovation,Other;
            OptionCaption = ' ,Research,Academic,Infrastructure,Equipment,Innovation,Other';
        }
        field(5; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DecimalPlaces = 2:2;
        }
        field(6; "Available Amount"; Decimal)
        {
            Caption = 'Available Amount';
            DecimalPlaces = 2:2;
        }
        field(7; "Allocated Amount"; Decimal)
        {
            Caption = 'Allocated Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Foundation Grant Application"."Approved Amount" where("Grant No." = field("No."), 
                                                                                    "Status" = const(Approved)));
        }
        field(8; "Disbursed Amount"; Decimal)
        {
            Caption = 'Disbursed Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Foundation Grant Disbursement"."Amount" where("Grant No." = field("No."), 
                                                                            "Posted" = const(true)));
        }
        field(9; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(10; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(11; "Application Deadline"; Date)
        {
            Caption = 'Application Deadline';
        }
        field(12; "Status"; Enum "Foundation Grant Status")
        {
            Caption = 'Status';
        }
        field(13; "Donor No."; Code[20])
        {
            Caption = 'Donor No.';
            TableRelation = "Foundation Donor";
        }
        field(14; "Donor Name"; Text[100])
        {
            Caption = 'Donor Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Foundation Donor".Name where("No." = field("Donor No.")));
        }
        field(15; "Eligibility Criteria"; Text[250])
        {
            Caption = 'Eligibility Criteria';
        }
        field(16; "Application Form"; Code[20])
        {
            Caption = 'Application Form';
        }
        field(17; "Review Committee"; Text[100])
        {
            Caption = 'Review Committee';
        }
        field(18; "Max Amount Per Applicant"; Decimal)
        {
            Caption = 'Max Amount Per Applicant';
            DecimalPlaces = 2:2;
        }
        field(19; "Min Amount Per Applicant"; Decimal)
        {
            Caption = 'Min Amount Per Applicant';
            DecimalPlaces = 2:2;
        }
        field(20; "No. of Applications"; Integer)
        {
            Caption = 'No. of Applications';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Foundation Grant Application" where("Grant No." = field("No.")));
        }
        field(21; "No. Approved"; Integer)
        {
            Caption = 'No. Approved';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Foundation Grant Application" where("Grant No." = field("No."), 
                                                                    "Status" = const(Approved)));
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
        key(ApplicationDeadline; "Application Deadline")
        {
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Grant Name", "Total Amount", "Status")
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
        FoundationSetup.TestField("Grant Nos.");
    end;
    
    local procedure GetNoSeriesCode(): Code[20]
    var
        FoundationSetup: Record "Foundation Setup";
    begin
        FoundationSetup.Get();
        exit(FoundationSetup."Grant Nos.");
    end;
}