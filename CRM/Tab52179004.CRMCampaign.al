table 52179004 "CRM Campaign"
{
    DataClassification = CustomerContent;
    Caption = 'CRM Campaign';
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Campaign Type"; Enum "CRM Campaign Type")
        {
            Caption = 'Campaign Type';
        }
        field(4; "Status"; Enum "CRM Campaign Status")
        {
            Caption = 'Status';
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(7; "Target Audience"; Enum "CRM Customer Type")
        {
            Caption = 'Target Audience';
        }
        field(8; "Segmentation Code"; Code[20])
        {
            Caption = 'Segmentation Code';
            TableRelation = "CRM Segmentation";
        }
        field(9; "Budget Amount"; Decimal)
        {
            Caption = 'Budget Amount';
        }
        field(10; "Actual Cost"; Decimal)
        {
            Caption = 'Actual Cost';
        }
        field(11; "Expected Response Rate"; Decimal)
        {
            Caption = 'Expected Response Rate (%)';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(12; "Actual Response Rate"; Decimal)
        {
            Caption = 'Actual Response Rate (%)';
            FieldClass = FlowField;
            CalcFormula = average("CRM Campaign Response"."Response Rate" where("Campaign No." = field("No.")));
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(13; "Target Count"; Integer)
        {
            Caption = 'Target Count';
        }
        field(14; "Actual Responses"; Integer)
        {
            Caption = 'Actual Responses';
            FieldClass = FlowField;
            CalcFormula = count("CRM Campaign Response" where("Campaign No." = field("No."), "Responded" = const(true)));
            Editable = false;
        }
        field(15; "Conversion Rate"; Decimal)
        {
            Caption = 'Conversion Rate (%)';
            FieldClass = FlowField;
            CalcFormula = average("CRM Campaign Response"."Conversion Rate" where("Campaign No." = field("No.")));
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(16; "ROI Amount"; Decimal)
        {
            Caption = 'ROI Amount';
            FieldClass = FlowField;
            CalcFormula = sum("CRM Transaction".Amount where("Campaign Code" = field("No.")));
            Editable = false;
        }
        field(17; "Channel"; Enum "CRM Marketing Channel")
        {
            Caption = 'Channel';
        }
        field(18; "Message Content"; Text[250])
        {
            Caption = 'Message Content';
        }
        field(19; "Subject Line"; Text[100])
        {
            Caption = 'Subject Line';
        }
        field(20; "Call to Action"; Text[100])
        {
            Caption = 'Call to Action';
        }
        field(21; "Landing Page URL"; Text[250])
        {
            Caption = 'Landing Page URL';
            ExtendedDatatype = URL;
        }
        field(22; "Tracking Code"; Code[50])
        {
            Caption = 'Tracking Code';
        }
        field(23; "Campaign Manager"; Code[50])
        {
            Caption = 'Campaign Manager';
            TableRelation = User."User Name";
        }
        field(24; "Approval Status"; Enum "CRM Approval Status")
        {
            Caption = 'Approval Status';
        }
        field(25; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            TableRelation = User."User Name";
        }
        field(26; "Approved Date"; DateTime)
        {
            Caption = 'Approved Date';
        }
        field(27; "Scheduled Send Date"; DateTime)
        {
            Caption = 'Scheduled Send Date';
        }
        field(28; "Actual Send Date"; DateTime)
        {
            Caption = 'Actual Send Date';
        }
        field(29; "Auto Follow-up"; Boolean)
        {
            Caption = 'Auto Follow-up';
        }
        field(30; "Follow-up Days"; Integer)
        {
            Caption = 'Follow-up Days';
        }
        field(31; "A/B Testing"; Boolean)
        {
            Caption = 'A/B Testing';
        }
        field(32; "Test Variant"; Text[50])
        {
            Caption = 'Test Variant';
        }
        field(33; "Priority"; Enum "CRM Priority Level")
        {
            Caption = 'Priority';
        }
        field(34; "Tags"; Text[250])
        {
            Caption = 'Tags';
        }
        field(35; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
        field(36; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(37; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(38; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(39; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(40; "Email Opens"; Integer)
        {
            Caption = 'Email Opens';
            FieldClass = FlowField;
            CalcFormula = sum("CRM Campaign Response"."Email Opens" where("Campaign No." = field("No.")));
            Editable = false;
        }
        field(41; "Email Clicks"; Integer)
        {
            Caption = 'Email Clicks';
            FieldClass = FlowField;
            CalcFormula = sum("CRM Campaign Response"."Email Clicks" where("Campaign No." = field("No.")));
            Editable = false;
        }
        field(42; "Unsubscribes"; Integer)
        {
            Caption = 'Unsubscribes';
            FieldClass = FlowField;
            CalcFormula = count("CRM Campaign Response" where("Campaign No." = field("No."), "Unsubscribed" = const(true)));
            Editable = false;
        }
    }
    
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Type; "Campaign Type")
        {
        }
        key(Status; "Status")
        {
        }
        key(Dates; "Start Date", "End Date")
        {
        }
        key(Manager; "Campaign Manager")
        {
        }
        key(Channel; "Channel")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
        if "Status" = "Status"::" " then
            "Status" := "Status"::Draft;
        if "Approval Status" = "Approval Status"::" " then
            "Approval Status" := "Approval Status"::Pending;
    end;
    
    trigger OnModify()
    begin
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
    end;
}