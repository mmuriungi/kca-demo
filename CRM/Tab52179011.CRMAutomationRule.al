table 52179011 "CRM Automation Rule"
{
    DataClassification = CustomerContent;
    Caption = 'CRM Automation Rule';
    
    fields
    {
        field(1; "Rule Code"; Code[20])
        {
            Caption = 'Rule Code';
            NotBlank = true;
        }
        field(2; "Rule Name"; Text[100])
        {
            Caption = 'Rule Name';
        }
        field(3; "Rule Type"; Option)
        {
            Caption = 'Rule Type';
            OptionMembers = "Lead Scoring","Email Campaign","SMS Campaign","Lead Assignment","Follow-up Reminder","Status Update","Data Enrichment","Notification";
            OptionCaption = 'Lead Scoring,Email Campaign,SMS Campaign,Lead Assignment,Follow-up Reminder,Status Update,Data Enrichment,Notification';
        }
        field(4; "Trigger Event"; Option)
        {
            Caption = 'Trigger Event';
            OptionMembers = "Lead Created","Lead Updated","Customer Created","Customer Updated","Campaign Response","Support Ticket Created","Transaction Created","Date Based","Manual";
            OptionCaption = 'Lead Created,Lead Updated,Customer Created,Customer Updated,Campaign Response,Support Ticket Created,Transaction Created,Date Based,Manual';
        }
        field(5; "Trigger Conditions"; Text[250])
        {
            Caption = 'Trigger Conditions';
        }
        field(6; "Action Description"; Text[250])
        {
            Caption = 'Action Description';
        }
        field(7; "Active"; Boolean)
        {
            Caption = 'Active';
            InitValue = true;
        }
        field(8; "Priority"; Integer)
        {
            Caption = 'Priority';
            InitValue = 10;
            MinValue = 1;
            MaxValue = 100;
        }
        field(9; "Execution Count"; Integer)
        {
            Caption = 'Execution Count';
            Editable = false;
        }
        field(10; "Last Executed"; DateTime)
        {
            Caption = 'Last Executed';
            Editable = false;
        }
        field(11; "Success Count"; Integer)
        {
            Caption = 'Success Count';
            Editable = false;
        }
        field(12; "Failure Count"; Integer)
        {
            Caption = 'Failure Count';
            Editable = false;
        }
        field(13; "Template Code"; Code[20])
        {
            Caption = 'Template Code';
            TableRelation = "CRM Marketing Template"."Template Code";
        }
        field(14; "Target Field"; Text[50])
        {
            Caption = 'Target Field';
        }
        field(15; "Target Value"; Text[100])
        {
            Caption = 'Target Value';
        }
        field(16; "Notification Recipients"; Text[250])
        {
            Caption = 'Notification Recipients';
        }
        field(17; "Schedule Type"; Option)
        {
            Caption = 'Schedule Type';
            OptionMembers = "Immediate","Daily","Weekly","Monthly","Custom";
            OptionCaption = 'Immediate,Daily,Weekly,Monthly,Custom';
        }
        field(18; "Schedule Time"; Time)
        {
            Caption = 'Schedule Time';
        }
        field(19; "Schedule Days"; Text[50])
        {
            Caption = 'Schedule Days';
        }
        field(20; "Next Execution"; DateTime)
        {
            Caption = 'Next Execution';
        }
        field(21; "Max Executions"; Integer)
        {
            Caption = 'Max Executions';
        }
        field(22; "Stop After Failures"; Integer)
        {
            Caption = 'Stop After Failures';
            InitValue = 5;
        }
        field(23; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(24; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(25; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(26; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(27; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
    }
    
    keys
    {
        key(PK; "Rule Code")
        {
            Clustered = true;
        }
        key(Type; "Rule Type")
        {
        }
        key(TriggerEvent; "Trigger Event")
        {
        }
        key(Priority; "Priority", "Active")
        {
        }
        key(NextExecution; "Next Execution")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
        CalculateNextExecution();
    end;
    
    trigger OnModify()
    begin
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
        CalculateNextExecution();
    end;

    procedure ExecuteRule(): Boolean
    var
        Success: Boolean;
    begin
        if not "Active" then
            exit(false);
            
        "Execution Count" += 1;
        "Last Executed" := CurrentDateTime;
        
        // Placeholder for rule execution logic
        Success := true; // Would contain actual execution logic
        
        if Success then
            "Success Count" += 1
        else
            "Failure Count" += 1;
            
        if ("Stop After Failures" > 0) and ("Failure Count" >= "Stop After Failures") then
            "Active" := false;
            
        CalculateNextExecution();
        Modify();
        
        exit(Success);
    end;

    local procedure CalculateNextExecution()
    begin
        case "Schedule Type" of
            "Schedule Type"::Immediate:
                "Next Execution" := CurrentDateTime;
            "Schedule Type"::Daily:
                "Next Execution" := CreateDateTime(CalcDate('<+1D>', Today), "Schedule Time");
            "Schedule Type"::Weekly:
                "Next Execution" := CreateDateTime(CalcDate('<+1W>', Today), "Schedule Time");
            "Schedule Type"::Monthly:
                "Next Execution" := CreateDateTime(CalcDate('<+1M>', Today), "Schedule Time");
            "Schedule Type"::Custom:
                "Next Execution" := CreateDateTime(CalcDate('<+1D>', Today), "Schedule Time"); // Simplified
        end;
    end;
}