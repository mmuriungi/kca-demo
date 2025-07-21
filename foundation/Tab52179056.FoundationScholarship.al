table 52179056 "Foundation Scholarship"
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Scholarship';
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "Scholarship Name"; Text[100])
        {
            Caption = 'Scholarship Name';
        }
        field(3; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(4; "Scholarship Type"; Option)
        {
            Caption = 'Scholarship Type';
            OptionMembers = " ",Merit,Need,Athletic,Special;
            OptionCaption = ' ,Merit-Based,Need-Based,Athletic,Special';
        }
        field(5; "Amount Per Student"; Decimal)
        {
            Caption = 'Amount Per Student';
            DecimalPlaces = 2:2;
        }
        field(6; "Total Budget"; Decimal)
        {
            Caption = 'Total Budget';
            DecimalPlaces = 2:2;
        }
        field(7; "No. of Awards"; Integer)
        {
            Caption = 'No. of Awards';
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(9; "Semester"; Option)
        {
            Caption = 'Semester';
            OptionMembers = " ","First","Second",Both;
            OptionCaption = ' ,First,Second,Both';
        }
        field(10; "Application Start Date"; Date)
        {
            Caption = 'Application Start Date';
        }
        field(11; "Application End Date"; Date)
        {
            Caption = 'Application End Date';
        }
        field(12; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Planning,Open,Closed,"Under Review",Awarded,Completed;
            OptionCaption = 'Planning,Open,Closed,Under Review,Awarded,Completed';
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
        field(16; "Min GPA"; Decimal)
        {
            Caption = 'Min GPA';
            DecimalPlaces = 2:2;
        }
        field(17; "Faculty"; Text[50])
        {
            Caption = 'Faculty';
        }
        field(18; "Department"; Text[50])
        {
            Caption = 'Department';
        }
        field(19; "Program Level"; Option)
        {
            Caption = 'Program Level';
            OptionMembers = " ",Certificate,Diploma,Undergraduate,Postgraduate,PhD;
            OptionCaption = ' ,Certificate,Diploma,Undergraduate,Postgraduate,PhD';
        }
        field(20; "Year of Study"; Option)
        {
            Caption = 'Year of Study';
            OptionMembers = " ","1","2","3","4","5","6",All;
            OptionCaption = ' ,1,2,3,4,5,6,All';
        }
        field(21; "No. of Applications"; Integer)
        {
            Caption = 'No. of Applications';
            // Editable = false;
            // FieldClass = FlowField;
            // CalcFormula = count("Foundation Scholarship Application" where("Scholarship No." = field("No.")));
        }
        field(22; "No. Awarded"; Integer)
        {
            Caption = 'No. Awarded';
            // Editable = false;
            // FieldClass = FlowField;
            // CalcFormula = count("Foundation Scholarship Application" where("Scholarship No." = field("No."), 
               //                                                           "Status" = const(Awarded)));
        }
        field(23; "Total Awarded Amount"; Decimal)
        {
            Caption = 'Total Awarded Amount';
            // Editable = false;
            // FieldClass = FlowField;
            // CalcFormula = sum("Foundation Scholarship Application"."Award Amount" where("Scholarship No." = field("No."), 
               //                                                                                      "Status" = const(Awarded)));
        }
        field(24; "Renewable"; Boolean)
        {
            Caption = 'Renewable';
        }
        field(25; "Renewal Criteria"; Text[250])
        {
            Caption = 'Renewal Criteria';
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
        key(ApplicationDates; "Application Start Date", "Application End Date")
        {
        }
        key(AcademicYear; "Academic Year", "Semester")
        {
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Scholarship Name", "Amount Per Student", "Status")
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
        FoundationSetup.TestField("Scholarship Nos.");
    end;
    
    local procedure GetNoSeriesCode(): Code[20]
    var
        FoundationSetup: Record "Foundation Setup";
    begin
        FoundationSetup.Get();
        exit(FoundationSetup."Scholarship Nos.");
    end;
}