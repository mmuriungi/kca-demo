table 52179073 "Foundation Grant Disbursement"
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Grant Disbursement';
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Grant No."; Code[20])
        {
            Caption = 'Grant No.';
            TableRelation = "Foundation Grant";
        }
        field(3; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            TableRelation = "Foundation Grant Application";
        }
        field(4; "Disbursement Date"; Date)
        {
            Caption = 'Disbursement Date';
        }
        field(5; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 2:2;
        }
        field(6; "Payment Method"; Option)
        {
            Caption = 'Payment Method';
            OptionMembers = " ","Bank Transfer",Cheque,"Electronic Transfer",Cash;
            OptionCaption = ' ,Bank Transfer,Cheque,Electronic Transfer,Cash';
        }
        field(7; "Reference No."; Code[30])
        {
            Caption = 'Reference No.';
        }
        field(8; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Planned,Approved,Disbursed,Failed,Cancelled;
            OptionCaption = 'Planned,Approved,Disbursed,Failed,Cancelled';
        }
        field(9; "Recipient Name"; Text[100])
        {
            Caption = 'Recipient Name';
        }
        field(10; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(11; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
        }
        field(12; "Purpose"; Text[100])
        {
            Caption = 'Purpose';
        }
        field(20; "Posted"; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(21; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
            Editable = false;
        }
        field(22; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            TableRelation = User."User Name";
            Editable = false;
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
        field(40; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
    }
    
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(GrantNo; "Grant No.", "Disbursement Date")
        {
        }
        key(ApplicationNo; "Application No.")
        {
        }
        key(Status; "Status")
        {
        }
        key(DisbursementDate; "Disbursement Date")
        {
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Grant No.", "Amount", "Disbursement Date")
        {
        }
    }
    
    trigger OnInsert()
    begin
        if "Disbursement Date" = 0D then
            "Disbursement Date" := WorkDate();
            
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
}