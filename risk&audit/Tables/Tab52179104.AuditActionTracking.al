table 52179104 "Audit Action Tracking"
{
    Caption = 'Audit Action Tracking';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Action No."; Code[20])
        {
            Caption = 'Action No.';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                if "Action No." <> xRec."Action No." then begin
                    AuditSetup.Get();
                    NoSeriesMgt.TestManual(AuditSetup."Audit Action Nos.");
                end;
            end;
        }
        field(2; "Finding No."; Code[20])
        {
            Caption = 'Finding No.';
            TableRelation = "Audit Finding Enhanced"."Finding No.";
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            var
                Finding: Record "Audit Finding Enhanced";
            begin
                if Finding.Get("Finding No.") then begin
                    "Finding Description" := Finding."Finding Description";
                    "Audit No." := Finding."Audit No.";
                    "Risk Rating" := Finding."Risk Severity";
                end;
            end;
        }
        field(3; "Finding Description"; Text[250])
        {
            Caption = 'Finding Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Audit No."; Code[20])
        {
            Caption = 'Audit No.';
            TableRelation = "Audit Header"."No." WHERE(Type = CONST(Audit));
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Action Description"; Text[250])
        {
            Caption = 'Action Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Responsible Person"; Code[50])
        {
            Caption = 'Responsible Person';
            TableRelation = "HRM-Employee C"."No.";
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            var
                Employee: Record "HRM-Employee C";
            begin
                if Employee.Get("Responsible Person") then begin
                    "Responsible Person Name" := Employee.FullName;
                    "Responsible Email" := Employee."E-Mail";
                end;
            end;
        }
        field(7; "Responsible Person Name"; Text[100])
        {
            Caption = 'Responsible Person Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Responsible Email"; Text[100])
        {
            Caption = 'Responsible Email';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = ToBeClassified;
        }
        field(10; "Target Date"; Date)
        {
            Caption = 'Target Date';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                if "Target Date" < Today then
                    Message('Warning: Target date is in the past');
            end;
        }
        field(11; "Original Target Date"; Date)
        {
            Caption = 'Original Target Date';
            DataClassification = ToBeClassified;
        }
        field(12; "Revised Target Date"; Date)
        {
            Caption = 'Revised Target Date';
            DataClassification = ToBeClassified;
        }
        field(13; "Implementation Status"; Option)
        {
            Caption = 'Implementation Status';
            OptionMembers = "Not Started","In Progress","Partially Implemented","Fully Implemented","Not Applicable","Closed";
            OptionCaption = 'Not Started,In Progress,Partially Implemented,Fully Implemented,Not Applicable,Closed';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                if "Implementation Status" = "Implementation Status"::"Fully Implemented" then begin
                    "Completion Date" := Today;
                    "Completion %" := 100;
                end;
            end;
        }
        field(14; "Completion %"; Decimal)
        {
            Caption = 'Completion %';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 100;
        }
        field(15; "Completion Date"; Date)
        {
            Caption = 'Completion Date';
            DataClassification = ToBeClassified;
        }
        field(16; "Management Response"; Text[250])
        {
            Caption = 'Management Response';
            DataClassification = ToBeClassified;
        }
        field(17; "Auditee Comments"; Text[250])
        {
            Caption = 'Auditee Comments';
            DataClassification = ToBeClassified;
        }
        field(18; "Evidence of Implementation"; Text[250])
        {
            Caption = 'Evidence of Implementation';
            DataClassification = ToBeClassified;
        }
        field(19; "Follow-up Date"; Date)
        {
            Caption = 'Follow-up Date';
            DataClassification = ToBeClassified;
        }
        field(20; "Follow-up Status"; Option)
        {
            Caption = 'Follow-up Status';
            OptionMembers = "Pending","Scheduled","In Progress","Completed","Deferred";
            OptionCaption = 'Pending,Scheduled,In Progress,Completed,Deferred';
            DataClassification = ToBeClassified;
        }
        field(21; "Days Overdue"; Integer)
        {
            Caption = 'Days Overdue';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Risk Rating"; Option)
        {
            Caption = 'Risk Rating';
            OptionMembers = " ",Low,Medium,High,Critical;
            OptionCaption = ' ,Low,Medium,High,Critical';
            DataClassification = ToBeClassified;
        }
        field(23; "Priority"; Option)
        {
            Caption = 'Priority';
            OptionMembers = Low,Medium,High,Critical;
            OptionCaption = 'Low,Medium,High,Critical';
            DataClassification = ToBeClassified;
        }
        field(24; "Reminder Count"; Integer)
        {
            Caption = 'Reminder Count';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Last Reminder Date"; Date)
        {
            Caption = 'Last Reminder Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Escalated"; Boolean)
        {
            Caption = 'Escalated';
            DataClassification = ToBeClassified;
        }
        field(27; "Escalation Date"; Date)
        {
            Caption = 'Escalation Date';
            DataClassification = ToBeClassified;
        }
        field(28; "Escalated To"; Code[50])
        {
            Caption = 'Escalated To';
            TableRelation = "HRM-Employee C"."No.";
            DataClassification = ToBeClassified;
        }
        field(29; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(34; "Repeated Finding"; Boolean)
        {
            Caption = 'Repeated Finding';
            DataClassification = ToBeClassified;
        }
        field(35; "Web Access Enabled"; Boolean)
        {
            Caption = 'Web Access Enabled';
            DataClassification = ToBeClassified;
        }
        field(36; "Verification Status"; Option)
        {
            Caption = 'Verification Status';
            OptionMembers = "Not Verified","Under Verification","Verified","Verification Failed";
            OptionCaption = 'Not Verified,Under Verification,Verified,Verification Failed';
            DataClassification = ToBeClassified;
        }
        field(37; "Verified By"; Code[50])
        {
            Caption = 'Verified By';
            TableRelation = "Auditors List"."Auditor No";
            DataClassification = ToBeClassified;
        }
        field(38; "Verification Date"; Date)
        {
            Caption = 'Verification Date';
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(PK; "Action No.")
        {
            Clustered = true;
        }
        key(Finding; "Finding No.", "Action No.")
        {
        }
        key(Status; "Implementation Status", Priority)
        {
        }
        key(Overdue; "Target Date", "Implementation Status")
        {
        }
        key(Department; "Department Code", "Implementation Status")
        {
        }
    }
    
    trigger OnInsert()
    var
        AuditSetup: Record "Audit Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "Action No." = '' then begin
            AuditSetup.Get();
            AuditSetup.TestField("Audit Action Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Audit Action Nos.", xRec."No. Series", 0D, "Action No.", "No. Series");
        end;
        
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
        
        if "Original Target Date" = 0D then
            "Original Target Date" := "Target Date";
    end;
    
    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
        CalculateOverdueDays();
    end;
    
    var
        AuditSetup: Record "Audit Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        
    local procedure CalculateOverdueDays()
    begin
        if ("Implementation Status" <> "Implementation Status"::"Fully Implemented") and 
           ("Implementation Status" <> "Implementation Status"::Closed) and 
           ("Target Date" < Today) then
            "Days Overdue" := Today - "Target Date"
        else
            "Days Overdue" := 0;
    end;
}