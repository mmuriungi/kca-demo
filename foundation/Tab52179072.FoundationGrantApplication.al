table 52179072 "Foundation Grant Application"
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Grant Application';
    
    fields
    {
        field(1; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            NotBlank = true;
        }
        field(2; "Grant No."; Code[20])
        {
            Caption = 'Grant No.';
            TableRelation = "Foundation Grant";
        }
        field(3; "Grant Name"; Text[100])
        {
            Caption = 'Grant Name';
            Editable = false;
        }
        field(4; "Applicant Type"; Option)
        {
            Caption = 'Applicant Type';
            OptionMembers = " ",Faculty,Student,Department,Research,External;
            OptionCaption = ' ,Faculty,Student,Department,Research,External';
        }
        field(5; "Applicant Name"; Text[100])
        {
            Caption = 'Applicant Name';
        }
        field(6; "Applicant Email"; Text[80])
        {
            Caption = 'Applicant Email';
            ExtendedDatatype = EMail;
        }
        field(7; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }
        field(8; "Requested Amount"; Decimal)
        {
            Caption = 'Requested Amount';
            DecimalPlaces = 2:2;
        }
        field(9; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DecimalPlaces = 2:2;
        }
        field(10; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Draft,Submitted,"Under Review",Approved,Rejected,Cancelled;
            OptionCaption = 'Draft,Submitted,Under Review,Approved,Rejected,Cancelled';
        }
        field(11; "Project Title"; Text[100])
        {
            Caption = 'Project Title';
        }
        field(12; "Project Description"; Text[2000])
        {
            Caption = 'Project Description';
        }
        field(13; "Start Date"; Date)
        {
            Caption = 'Project Start Date';
        }
        field(14; "End Date"; Date)
        {
            Caption = 'Project End Date';
        }
        field(15; "Department"; Text[50])
        {
            Caption = 'Department';
        }
        field(20; "Review Date"; Date)
        {
            Caption = 'Review Date';
        }
        field(21; "Reviewed By"; Code[50])
        {
            Caption = 'Reviewed By';
            TableRelation = User."User Name";
        }
        field(22; "Review Comments"; Text[2000])
        {
            Caption = 'Review Comments';
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
        key(PK; "Application No.")
        {
            Clustered = true;
        }
        key(GrantNo; "Grant No.")
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
        fieldgroup(DropDown; "Application No.", "Project Title", "Applicant Name", "Status")
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