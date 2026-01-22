table 52179088 "Legal Affairs Cue"
{
    Caption = 'Legal Affairs Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Open Cases"; Integer)
        {
            Caption = 'Open Cases';
            FieldClass = FlowField;
            CalcFormula = Count("Legal Case" WHERE("Case Status" = CONST(Open)));
        }
        field(3; "Cases In Progress"; Integer)
        {
            Caption = 'Cases In Progress';
            FieldClass = FlowField;
            CalcFormula = Count("Legal Case" WHERE("Case Status" = CONST("In Progress")));
        }
        field(4; "High Priority Cases"; Integer)
        {
            Caption = 'High Priority Cases';
            FieldClass = FlowField;
            CalcFormula = Count("Legal Case" WHERE(Priority = FILTER(High | Urgent)));
        }
        field(5; "Court Dates This Week"; Integer)
        {
            Caption = 'Court Dates This Week';
            FieldClass = FlowField;
            CalcFormula = Count("Legal Calendar Entry" WHERE("Event Date" = FIELD("Date Filter"),
                                                              "Event Type" = CONST("Court Date")));
        }
        field(6; "Open Compliance Tasks"; Integer)
        {
            Caption = 'Open Compliance Tasks';
            FieldClass = FlowField;
            CalcFormula = Count("Legal Compliance Task" WHERE(Status = CONST(Open)));
        }
        field(7; "Overdue Compliance Tasks"; Integer)
        {
            Caption = 'Overdue Compliance Tasks';
            FieldClass = FlowField;
            CalcFormula = Count("Legal Compliance Task" WHERE(Status = CONST(Overdue)));
        }
        field(8; "High Risk Assessments"; Integer)
        {
            Caption = 'High Risk Assessments';
            FieldClass = FlowField;
            CalcFormula = Count("Legal Risk Assessment" WHERE("Risk Level" = FILTER(High | Critical),
                                                               Status = CONST(Active)));
        }
        field(9; "Active Contracts"; Integer)
        {
            Caption = 'Active Contracts';
            FieldClass = FlowField;
            CalcFormula = Count("Project Header" WHERE(Status = CONST(Approved)));
        }
        field(10; "Expiring Contracts"; Integer)
        {
            Caption = 'Expiring Contracts';
            FieldClass = FlowField;
            CalcFormula = Count("Project Header" WHERE("Estimated End Date" = FIELD("Date Filter 2"),
                                                        Status = CONST(Approved)));
        }
        field(11; "Pending Legal Invoices"; Integer)
        {
            Caption = 'Pending Legal Invoices';
            FieldClass = FlowField;
            CalcFormula = Count("Legal Invoice" WHERE("Payment Status" = CONST(Pending)));
        }
        field(12; "Total Legal Costs MTD"; Decimal)
        {
            Caption = 'Total Legal Costs MTD';
            FieldClass = FlowField;
            CalcFormula = Sum("Legal Invoice"."Total Amount" WHERE("Invoice Date" = FIELD("Date Filter 3")));
        }
        field(20; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(21; "Date Filter 2"; Date)
        {
            Caption = 'Date Filter 2';
            FieldClass = FlowFilter;
        }
        field(22; "Date Filter 3"; Date)
        {
            Caption = 'Date Filter 3';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure CalculateCueFieldValues()
    begin
        // Set date filters for various calculations
        Rec.SetFilter("Date Filter", '%1..%2', CalcDate('<-CW>', Today), CalcDate('<CW>', Today));
        Rec.SetFilter("Date Filter 2", '..%1', CalcDate('<+90D>', Today));
        Rec.SetFilter("Date Filter 3", '%1..%2', CalcDate('<-CM>', Today), CalcDate('<CM>', Today));
        
        Rec.CalcFields("Open Cases", "Cases In Progress", "High Priority Cases", "Court Dates This Week",
                       "Open Compliance Tasks", "Overdue Compliance Tasks", "High Risk Assessments",
                       "Active Contracts", "Expiring Contracts", "Pending Legal Invoices", "Total Legal Costs MTD");
    end;
}