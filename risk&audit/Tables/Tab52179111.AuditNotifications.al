table 52179111 "Audit Notifications"
{
    Caption = 'Audit Notifications';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Notification No."; Code[20])
        {
            Caption = 'Notification No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Audit No."; Code[20])
        {
            Caption = 'Audit No.';
            TableRelation = "Audit Header"."No." WHERE(Type = CONST(Audit));
            DataClassification = ToBeClassified;
        }
        field(3; "Notification Type"; Option)
        {
            Caption = 'Notification Type';
            OptionMembers = "Audit Assignment","Task Due Date","Document Request","Meeting Schedule","Finding Response","Audit Completion";
            OptionCaption = 'Audit Assignment,Task Due Date,Document Request,Meeting Schedule,Finding Response,Audit Completion';
            DataClassification = ToBeClassified;
        }
        field(4; "Subject"; Text[250])
        {
            Caption = 'Subject';
            DataClassification = ToBeClassified;
        }
        field(5; "Message Text"; Text[250])
        {
            Caption = 'Message Text';
            DataClassification = ToBeClassified;
        }
        field(6; "Recipient Email"; Text[100])
        {
            Caption = 'Recipient Email';
            DataClassification = ToBeClassified;
        }
        field(7; "Recipient Name"; Text[100])
        {
            Caption = 'Recipient Name';
            DataClassification = ToBeClassified;
        }
        field(8; "Notification Date"; Date)
        {
            Caption = 'Notification Date';
            DataClassification = ToBeClassified;
        }
        field(9; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Delivery Status"; Option)
        {
            Caption = 'Delivery Status';
            OptionMembers = Pending,Sent,Failed;
            OptionCaption = 'Pending,Sent,Failed';
            DataClassification = ToBeClassified;
        }
        field(11; "Priority"; Option)
        {
            Caption = 'Priority';
            OptionMembers = Low,Normal,High;
            OptionCaption = 'Low,Normal,High';
            DataClassification = ToBeClassified;
        }
        field(12; "Sent Date"; DateTime)
        {
            Caption = 'Sent Date';
            DataClassification = ToBeClassified;
        }
        field(13; "Read Date"; DateTime)
        {
            Caption = 'Read Date';
            DataClassification = ToBeClassified;
        }
        field(14; "Response Required"; Boolean)
        {
            Caption = 'Response Required';
            DataClassification = ToBeClassified;
        }
        field(15; "Response Received"; Boolean)
        {
            Caption = 'Response Received';
            DataClassification = ToBeClassified;
        }
        field(16; "Response Date"; DateTime)
        {
            Caption = 'Response Date';
            DataClassification = ToBeClassified;
        }
        field(17; "Related Document Type"; Option)
        {
            Caption = 'Related Document Type';
            OptionMembers = " ",Task,Finding,WorkingPaper,Schedule;
            OptionCaption = ' ,Task,Finding,Working Paper,Schedule';
            DataClassification = ToBeClassified;
        }
        field(18; "Related Document No."; Code[20])
        {
            Caption = 'Related Document No.';
            DataClassification = ToBeClassified;
        }
        field(19; "Auto Generated"; Boolean)
        {
            Caption = 'Auto Generated';
            DataClassification = ToBeClassified;
        }
        field(20; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    
    keys
    {
        key(PK; "Notification No.")
        {
            Clustered = true;
        }
        key(Audit; "Audit No.", "Notification Date")
        {
        }
        key(Status; "Delivery Status", Priority)
        {
        }
        key(Type; "Notification Type", "Due Date")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
        
        if "Notification Date" = 0D then
            "Notification Date" := Today;
    end;
    
    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;
}