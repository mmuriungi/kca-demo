table 52179002 "CRM Interaction Log"
{
    DataClassification = CustomerContent;
    Caption = 'CRM Interaction Log';
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
          //  AutoIncrement = true;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = "CRM Customer";
        }
        field(3; "Interaction Type"; Enum "CRM Interaction Type")
        {
            Caption = 'Interaction Type';
        }
        field(4; "Interaction Date"; Date)
        {
            Caption = 'Interaction Date';
        }
        field(5; "Interaction Time"; Time)
        {
            Caption = 'Interaction Time';
        }
        field(6; "Contact Method"; Enum "CRM Contact Method")
        {
            Caption = 'Contact Method';
        }
        field(7; "Subject"; Text[100])
        {
            Caption = 'Subject';
        }
        field(8; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(9; "Duration (Minutes)"; Integer)
        {
            Caption = 'Duration (Minutes)';
        }
        field(10; "Outcome"; Enum "CRM Interaction Outcome")
        {
            Caption = 'Outcome';
        }
        field(11; "Follow-up Required"; Boolean)
        {
            Caption = 'Follow-up Required';
        }
        field(12; "Follow-up Date"; Date)
        {
            Caption = 'Follow-up Date';
        }
        field(13; "Priority"; Enum "CRM Priority Level")
        {
            Caption = 'Priority';
        }
        field(14; "Campaign Code"; Code[20])
        {
            Caption = 'Campaign Code';
            TableRelation = "CRM Campaign";
        }
        field(15; "Sales Rep Code"; Code[20])
        {
            Caption = 'Sales Rep Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(16; "Document Type"; Enum "CRM Document Type")
        {
            Caption = 'Document Type';
        }
        field(17; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(18; "Cost"; Decimal)
        {
            Caption = 'Cost';
        }
        field(19; "Evaluation Score"; Integer)
        {
            Caption = 'Evaluation Score';
            MinValue = 1;
            MaxValue = 5;
        }
        field(20; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(21; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(22; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(23; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(24; "Attachment"; Media)
        {
            Caption = 'Attachment';
        }
        field(25; "Email Address"; Text[100])
        {
            Caption = 'Email Address';
            ExtendedDatatype = EMail;
        }
        field(26; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
            ExtendedDatatype = PhoneNo;
        }
        field(27; "Location"; Text[100])
        {
            Caption = 'Location';
        }
        field(28; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
        field(29; "Completed"; Boolean)
        {
            Caption = 'Completed';
        }
        field(30; "Customer Rating"; Integer)
        {
            Caption = 'Customer Rating';
            MinValue = 1;
            MaxValue = 10;
        }
    }
    
    keys
    {
        key(PK; "Entry No.", "Customer No.")
        {
            Clustered = true;
        }
        key(Customer; "Customer No.", "Interaction Date")
        {
        }
        key(Date; "Interaction Date")
        {
        }
        key(Type; "Interaction Type")
        {
        }
        key(Campaign; "Campaign Code")
        {
        }
        key(FollowUp; "Follow-up Required", "Follow-up Date")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
        if "Interaction Date" = 0D then
            "Interaction Date" := WorkDate();
        if "Interaction Time" = 0T then
            "Interaction Time" := Time;
            if "Entry No." = 0 then
                "Entry No." := Random(1000000);
    end;
    
    trigger OnModify()
    begin
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
    end;
}