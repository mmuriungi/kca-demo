table 52179074 "Foundation Scholarship App."
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Scholarship Application';
    
    fields
    {
        field(1; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            NotBlank = true;
        }
        field(2; "Scholarship No."; Code[20])
        {
            Caption = 'Scholarship No.';
            TableRelation = "Foundation Scholarship";
        }
        field(3; "Scholarship Name"; Text[100])
        {
            Caption = 'Scholarship Name';
            Editable = false;
        }
        field(4; "Student No."; Code[20])
        {
            Caption = 'Student No.';
        }
        field(5; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
        }
        field(6; "Student Email"; Text[80])
        {
            Caption = 'Student Email';
            ExtendedDatatype = EMail;
        }
        field(7; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }
        field(8; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
        }
        field(9; "Program"; Text[50])
        {
            Caption = 'Program';
        }
        field(10; "Year of Study"; Integer)
        {
            Caption = 'Year of Study';
        }
        field(11; "GPA"; Decimal)
        {
            Caption = 'GPA';
            DecimalPlaces = 2:2;
        }
        field(12; "Financial Need Amount"; Decimal)
        {
            Caption = 'Financial Need Amount';
            DecimalPlaces = 2:2;
        }
        field(13; "Requested Amount"; Decimal)
        {
            Caption = 'Requested Amount';
            DecimalPlaces = 2:2;
        }
        field(14; "Awarded Amount"; Decimal)
        {
            Caption = 'Awarded Amount';
            DecimalPlaces = 2:2;
        }
        field(15; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Draft,Submitted,"Under Review",Approved,Rejected,Cancelled;
            OptionCaption = 'Draft,Submitted,Under Review,Approved,Rejected,Cancelled';
        }
        field(20; "Personal Statement"; Text[2000])
        {
            Caption = 'Personal Statement';
        }
        field(21; "Financial Circumstances"; Text[2000])
        {
            Caption = 'Financial Circumstances';
        }
        field(22; "Academic Achievements"; Text[2000])
        {
            Caption = 'Academic Achievements';
        }
        field(30; "Review Date"; Date)
        {
            Caption = 'Review Date';
        }
        field(31; "Reviewed By"; Code[50])
        {
            Caption = 'Reviewed By';
            TableRelation = User."User Name";
        }
        field(32; "Review Comments"; Text[2000])
        {
            Caption = 'Review Comments';
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
        field(50; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }
    
    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
        key(ScholarshipNo; "Scholarship No.")
        {
        }
        key(StudentNo; "Student No.")
        {
        }
        key(Status; "Status")
        {
        }
        key(ApplicationDate; "Application Date")
        {
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown; "Application No.", "Student Name", "Scholarship Name", "Status")
        {
        }
    }
    
    trigger OnInsert()
    begin        
        if "Application Date" = 0D then
            "Application Date" := WorkDate();
            
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;
    
    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;
    
}