table 52179102 "Audit Task Management"
{
    Caption = 'Audit Task Management';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Task No."; Code[20])
        {
            Caption = 'Task No.';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                if "Task No." <> xRec."Task No." then begin
                    AuditSetup.Get();
                    NoSeriesMgt.TestManual(AuditSetup."Audit Task Nos.");
                end;
            end;
        }
        field(2; "Audit No."; Code[20])
        {
            Caption = 'Audit No.';
            TableRelation = "Audit Header"."No." WHERE(Type = CONST(Audit));
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            var
                AuditHeader: Record "Audit Header";
            begin
                if AuditHeader.Get("Audit No.") then begin
                    "Audit Description" := AuditHeader.Description;
                    "Department Code" := AuditHeader."Shortcut Dimension 1 Code";
                end;
            end;
        }
        field(3; "Audit Description"; Text[100])
        {
            Caption = 'Audit Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Task Description"; Text[250])
        {
            Caption = 'Task Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Assigned To"; Code[50])
        {
            Caption = 'Assigned To';
            TableRelation = "Auditors List"."Auditor No";
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            var
                Auditor: Record "Auditors List";
            begin
                if Auditor.Get("Assigned To") then
                    "Assigned To Name" := Auditor."Auditor Name";
            end;
        }
        field(6; "Assigned To Name"; Text[100])
        {
            Caption = 'Assigned To Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Assigned By"; Code[50])
        {
            Caption = 'Assigned By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Date Assigned"; DateTime)
        {
            Caption = 'Date Assigned';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                if "Due Date" < "Start Date" then
                    Error('Due Date cannot be before Start Date');
            end;
        }
        field(10; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(11; "Completion Date"; Date)
        {
            Caption = 'Completion Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = "Not Started","In Progress",Completed,"On Hold",Cancelled,"Pending Review";
            OptionCaption = 'Not Started,In Progress,Completed,On Hold,Cancelled,Pending Review';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                if Status = Status::Completed then begin
                    "Completion Date" := Today;
                    "Completion %" := 100;
                end;
            end;
        }
        field(13; "Priority"; Option)
        {
            Caption = 'Priority';
            OptionMembers = Low,Medium,High,Critical;
            OptionCaption = 'Low,Medium,High,Critical';
            DataClassification = ToBeClassified;
        }
        field(14; "Estimated Hours"; Decimal)
        {
            Caption = 'Estimated Hours';
            DataClassification = ToBeClassified;
        }
        field(15; "Actual Hours"; Decimal)
        {
            Caption = 'Actual Hours';
            DataClassification = ToBeClassified;
        }
        field(16; "Completion %"; Decimal)
        {
            Caption = 'Completion %';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 100;
        }
        field(17; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = ToBeClassified;
        }
        field(18; "Task Type"; Option)
        {
            Caption = 'Task Type';
            OptionMembers = Planning,Fieldwork,Review,Reporting,"Follow-up",Administrative;
            OptionCaption = 'Planning,Fieldwork,Review,Reporting,Follow-up,Administrative';
            DataClassification = ToBeClassified;
        }
        field(19; "Comments"; Text[250])
        {
            Caption = 'Comments';
            DataClassification = ToBeClassified;
        }
        field(20; "Overdue"; Boolean)
        {
            Caption = 'Overdue';
            FieldClass = FlowField;
            CalcFormula = Exist("Audit Task Management" WHERE("Task No." = FIELD("Task No."), 
                                                                "Due Date" = FILTER('< TODAY'), 
                                                                Status = FILTER('<> Completed & <> Cancelled')));
            Editable = false;
        }
        field(21; "Days Overdue"; Integer)
        {
            Caption = 'Days Overdue';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Reminder Sent"; Boolean)
        {
            Caption = 'Reminder Sent';
            DataClassification = ToBeClassified;
        }
        field(23; "Last Reminder Date"; Date)
        {
            Caption = 'Last Reminder Date';
            DataClassification = ToBeClassified;
        }
        field(24; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(25; "Resource Availability"; Boolean)
        {
            Caption = 'Resource Availability';
            DataClassification = ToBeClassified;
        }
        field(26; "Blocked"; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(27; "Blocking Reason"; Text[100])
        {
            Caption = 'Blocking Reason';
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(PK; "Task No.")
        {
            Clustered = true;
        }
        key(AuditNo; "Audit No.", "Task No.")
        {
        }
        key(AssignedTo; "Assigned To", "Due Date")
        {
        }
        key(Status; Status, Priority)
        {
        }
    }
    
    trigger OnInsert()
    var
        AuditSetup: Record "Audit Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "Task No." = '' then begin
            AuditSetup.Get();
            AuditSetup.TestField("Audit Task Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Audit Task Nos.", xRec."No. Series", 0D, "Task No.", "No. Series");
        end;
        
        "Assigned By" := UserId;
        "Date Assigned" := CurrentDateTime;
        
        if "Start Date" = 0D then
            "Start Date" := Today;
    end;
    
    trigger OnModify()
    begin
        CalculateOverdueDays();
    end;
    
    var
        AuditSetup: Record "Audit Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        
    local procedure CalculateOverdueDays()
    begin
        if (Status <> Status::Completed) and (Status <> Status::Cancelled) and ("Due Date" < Today) then
            "Days Overdue" := Today - "Due Date"
        else
            "Days Overdue" := 0;
    end;
}