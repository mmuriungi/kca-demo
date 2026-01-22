table 52179006 "CRM Support Ticket"
{
    DataClassification = CustomerContent;
    Caption = 'CRM Support Ticket';
    
    fields
    {
        field(1; "Ticket No."; Code[20])
        {
            Caption = 'Ticket No.';
            NotBlank = true;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = "CRM Customer";
        }
        field(3; "Subject"; Text[100])
        {
            Caption = 'Subject';
        }
        field(4; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(5; "Category"; Enum "CRM Ticket Category")
        {
            Caption = 'Category';
        }
        field(6; "Sub-Category"; Text[50])
        {
            Caption = 'Sub-Category';
        }
        field(7; "Priority"; Enum "CRM Priority Level")
        {
            Caption = 'Priority';
        }
        field(8; "Status"; Enum "CRM Ticket Status")
        {
            Caption = 'Status';
        }
        field(9; "Source"; Enum "CRM Ticket Source")
        {
            Caption = 'Source';
        }
        field(10; "Assigned To"; Code[50])
        {
            Caption = 'Assigned To';
            TableRelation = User."User Name";
        }
        field(11; "Department"; Code[20])
        {
            Caption = 'Department';
        }
        field(12; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(13; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(14; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(15; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(16; "First Response Date"; DateTime)
        {
            Caption = 'First Response Date';
        }
        field(17; "Resolution Date"; DateTime)
        {
            Caption = 'Resolution Date';
        }
        field(18; "Closed Date"; DateTime)
        {
            Caption = 'Closed Date';
        }
        field(19; "Due Date"; DateTime)
        {
            Caption = 'Due Date';
        }
        field(20; "Escalated"; Boolean)
        {
            Caption = 'Escalated';
        }
        field(21; "Escalated To"; Code[50])
        {
            Caption = 'Escalated To';
            TableRelation = User."User Name";
        }
        field(22; "Escalation Date"; DateTime)
        {
            Caption = 'Escalation Date';
        }
        field(23; "Resolution"; Text[250])
        {
            Caption = 'Resolution';
        }
        field(24; "Customer Satisfaction"; Integer)
        {
            Caption = 'Customer Satisfaction';
            MinValue = 1;
            MaxValue = 5;
        }
        field(25; "Response Time (Hours)"; Decimal)
        {
            Caption = 'Response Time (Hours)';
            DecimalPlaces = 0 : 2;
        }
        field(26; "Resolution Time (Hours)"; Decimal)
        {
            Caption = 'Resolution Time (Hours)';
            DecimalPlaces = 0 : 2;
        }
        field(27; "Number of Responses"; Integer)
        {
            Caption = 'Number of Responses';
            FieldClass = FlowField;
            CalcFormula = count("CRM Ticket Response" where("Ticket No." = field("Ticket No.")));
            Editable = false;
        }
        field(28; "SLA Breached"; Boolean)
        {
            Caption = 'SLA Breached';
        }
        field(29; "SLA Due Date"; DateTime)
        {
            Caption = 'SLA Due Date';
        }
        field(30; "Contact Method"; Enum "CRM Contact Method")
        {
            Caption = 'Contact Method';
        }
        field(31; "Customer Email"; Text[100])
        {
            Caption = 'Customer Email';
            ExtendedDatatype = EMail;
        }
        field(32; "Customer Phone"; Text[30])
        {
            Caption = 'Customer Phone';
            ExtendedDatatype = PhoneNo;
        }
        field(33; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(34; "Tags"; Text[250])
        {
            Caption = 'Tags';
        }
        field(35; "Internal Notes"; Text[250])
        {
            Caption = 'Internal Notes';
        }
        field(36; "Customer Feedback"; Text[250])
        {
            Caption = 'Customer Feedback';
        }
        field(37; "Related Ticket No."; Code[20])
        {
            Caption = 'Related Ticket No.';
            TableRelation = "CRM Support Ticket";
        }
        field(38; "Product/Service"; Text[100])
        {
            Caption = 'Product/Service';
        }
        field(39; "Academic Programme"; Code[20])
        {
            Caption = 'Academic Programme';
        }
        field(40; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(41; "Student ID"; Code[20])
        {
            Caption = 'Student ID';
        }
        field(42; "Employee ID"; Code[20])
        {
            Caption = 'Employee ID';
        }
        field(43; "Cost Center"; Code[20])
        {
            Caption = 'Cost Center';
        }
        field(44; "Bill to Customer"; Boolean)
        {
            Caption = 'Bill to Customer';
        }
        field(45; "Billable Amount"; Decimal)
        {
            Caption = 'Billable Amount';
        }
        field(46; "Attachment"; Media)
        {
            Caption = 'Attachment';
        }
        field(47; "Reopened"; Boolean)
        {
            Caption = 'Reopened';
        }
        field(48; "Reopen Count"; Integer)
        {
            Caption = 'Reopen Count';
        }
        field(49; "Auto-Assigned"; Boolean)
        {
            Caption = 'Auto-Assigned';
        }
        field(50; "Knowledge Base Article"; Code[20])
        {
            Caption = 'Knowledge Base Article';
        }
    }
    
    keys
    {
        key(PK; "Ticket No.")
        {
            Clustered = true;
        }
        key(Customer; "Customer No.", "Created Date")
        {
        }
        key(Status; "Status", "Priority")
        {
        }
        key(AssignedTo; "Assigned To", "Status")
        {
        }
        key(Category; "Category", "Status")
        {
        }
        key(SLA; "SLA Due Date", "Status")
        {
        }
        key(Date; "Created Date")
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
            "Status" := "Status"::Open;
        if "Priority" = "Priority"::" " then
            "Priority" := "Priority"::Medium;
        CalculateSLADueDate();
    end;
    
    trigger OnModify()
    begin
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
    end;
    
    local procedure CalculateSLADueDate()
    var
        SLAHours: Integer;
    begin
        case "Priority" of
            "Priority"::Critical:
                SLAHours := 4;
            "Priority"::High:
                SLAHours := 24;
            "Priority"::Medium:
                SLAHours := 72;
            "Priority"::Low:
                SLAHours := 168; // 1 week
        end;
        
        "SLA Due Date" := "Created Date" + (SLAHours * 60 * 60 * 1000); // Add hours in milliseconds
    end;
}