table 52179108 "Audit Schedule"
{
    Caption = 'Audit Schedule';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Audit No."; Code[20])
        {
            Caption = 'Audit No.';
            TableRelation = "Audit Header"."No." WHERE(Type = CONST(Audit));
            DataClassification = ToBeClassified;
        }
        field(3; "Task Description"; Text[250])
        {
            Caption = 'Task Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = ToBeClassified;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(7; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = ToBeClassified;
        }
        field(8; "Assigned To"; Code[50])
        {
            Caption = 'Assigned To';
            TableRelation = "Auditors List"."Auditor No";
            DataClassification = ToBeClassified;
        }
        field(9; "Assigned To Name"; Text[100])
        {
            Caption = 'Assigned To Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("Auditors List"."Auditor Name" WHERE("Auditor No" = FIELD("Assigned To")));
            Editable = false;
        }
        field(10; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = "Not Started",Scheduled,"In Progress",Completed,Cancelled;
            OptionCaption = 'Not Started,Scheduled,In Progress,Completed,Cancelled';
            DataClassification = ToBeClassified;
        }
        field(11; "Priority"; Option)
        {
            Caption = 'Priority';
            OptionMembers = Low,Normal,High,Critical;
            OptionCaption = 'Low,Normal,High,Critical';
            DataClassification = ToBeClassified;
        }
        field(12; "Estimated Hours"; Decimal)
        {
            Caption = 'Estimated Hours';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(13; "Actual Hours"; Decimal)
        {
            Caption = 'Actual Hours';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(14; "Location"; Text[100])
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;
        }
        field(15; "Task Type"; Option)
        {
            Caption = 'Task Type';
            OptionMembers = Planning,Fieldwork,Review,Reporting,"Follow-up",Meeting;
            OptionCaption = 'Planning,Fieldwork,Review,Reporting,Follow-up,Meeting';
            DataClassification = ToBeClassified;
        }
        field(16; "Completion %"; Decimal)
        {
            Caption = 'Completion %';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 100;
        }
        field(17; "Notes"; Text[250])
        {
            Caption = 'Notes';
            DataClassification = ToBeClassified;
        }
        field(18; "Resource Required"; Text[100])
        {
            Caption = 'Resource Required';
            DataClassification = ToBeClassified;
        }
        field(19; "Meeting Type"; Option)
        {
            Caption = 'Meeting Type';
            OptionMembers = " ",Opening,Progress,"Exit Meeting",Presentation;
            OptionCaption = ' ,Opening,Progress,Exit Meeting,Presentation';
            DataClassification = ToBeClassified;
        }
        field(20; "Attendees"; Text[250])
        {
            Caption = 'Attendees';
            DataClassification = ToBeClassified;
        }
        field(21; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(AuditDate; "Audit No.", "Start Date")
        {
        }
        key(AssignedTo; "Assigned To", "Start Date")
        {
        }
        key(Status; "Status", Priority)
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;
    
    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;
}