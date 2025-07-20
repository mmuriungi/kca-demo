table 52179106 "Audit Performance Metrics"
{
    Caption = 'Audit Performance Metrics';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Metric ID"; Code[20])
        {
            Caption = 'Metric ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Period Type"; Option)
        {
            Caption = 'Period Type';
            OptionMembers = Daily,Weekly,Monthly,Quarterly,Annual;
            OptionCaption = 'Daily,Weekly,Monthly,Quarterly,Annual';
            DataClassification = ToBeClassified;
        }
        field(3; "Period Start Date"; Date)
        {
            Caption = 'Period Start Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Period End Date"; Date)
        {
            Caption = 'Period End Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = ToBeClassified;
        }
        field(10; "Total Audits Planned"; Integer)
        {
            Caption = 'Total Audits Planned';
            DataClassification = ToBeClassified;
        }
        field(11; "Total Audits Completed"; Integer)
        {
            Caption = 'Total Audits Completed';
            DataClassification = ToBeClassified;
        }
        field(12; "Audits In Progress"; Integer)
        {
            Caption = 'Audits In Progress';
            DataClassification = ToBeClassified;
        }
        field(13; "Audit Completion Rate %"; Decimal)
        {
            Caption = 'Audit Completion Rate %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(14; "On-Time Completion Rate %"; Decimal)
        {
            Caption = 'On-Time Completion Rate %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(15; "Average Days to Complete"; Decimal)
        {
            Caption = 'Average Days to Complete';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(20; "Total Findings"; Integer)
        {
            Caption = 'Total Findings';
            DataClassification = ToBeClassified;
        }
        field(21; "Critical Findings"; Integer)
        {
            Caption = 'Critical Findings';
            DataClassification = ToBeClassified;
        }
        field(22; "High Risk Findings"; Integer)
        {
            Caption = 'High Risk Findings';
            DataClassification = ToBeClassified;
        }
        field(23; "Medium Risk Findings"; Integer)
        {
            Caption = 'Medium Risk Findings';
            DataClassification = ToBeClassified;
        }
        field(24; "Low Risk Findings"; Integer)
        {
            Caption = 'Low Risk Findings';
            DataClassification = ToBeClassified;
        }
        field(25; "Repeat Findings %"; Decimal)
        {
            Caption = 'Repeat Findings %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(30; "Total Recommendations"; Integer)
        {
            Caption = 'Total Recommendations';
            DataClassification = ToBeClassified;
        }
        field(31; "Recommendations Accepted"; Integer)
        {
            Caption = 'Recommendations Accepted';
            DataClassification = ToBeClassified;
        }
        field(32; "Recommendations Implemented"; Integer)
        {
            Caption = 'Recommendations Implemented';
            DataClassification = ToBeClassified;
        }
        field(33; "Implementation Rate %"; Decimal)
        {
            Caption = 'Implementation Rate %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(34; "Average Implementation Days"; Decimal)
        {
            Caption = 'Average Implementation Days';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(40; "Total Actions"; Integer)
        {
            Caption = 'Total Actions';
            DataClassification = ToBeClassified;
        }
        field(41; "Actions Completed"; Integer)
        {
            Caption = 'Actions Completed';
            DataClassification = ToBeClassified;
        }
        field(42; "Actions Overdue"; Integer)
        {
            Caption = 'Actions Overdue';
            DataClassification = ToBeClassified;
        }
        field(43; "Action Completion Rate %"; Decimal)
        {
            Caption = 'Action Completion Rate %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(44; "Average Days Overdue"; Decimal)
        {
            Caption = 'Average Days Overdue';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(50; "Budget Utilization %"; Decimal)
        {
            Caption = 'Budget Utilization %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(51; "Resource Utilization %"; Decimal)
        {
            Caption = 'Resource Utilization %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(52; "Planned Hours"; Decimal)
        {
            Caption = 'Planned Hours';
            DataClassification = ToBeClassified;
        }
        field(53; "Actual Hours"; Decimal)
        {
            Caption = 'Actual Hours';
            DataClassification = ToBeClassified;
        }
        field(54; "Efficiency Rate %"; Decimal)
        {
            Caption = 'Efficiency Rate %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(60; "Compliance Score %"; Decimal)
        {
            Caption = 'Compliance Score %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(61; "Risk Coverage %"; Decimal)
        {
            Caption = 'Risk Coverage %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(62; "Audit Coverage %"; Decimal)
        {
            Caption = 'Audit Coverage %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(70; "Client Satisfaction Score"; Decimal)
        {
            Caption = 'Client Satisfaction Score';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
            MinValue = 0;
            MaxValue = 5;
        }
        field(71; "Quality Review Score"; Decimal)
        {
            Caption = 'Quality Review Score';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(80; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(81; "Last Updated"; DateTime)
        {
            Caption = 'Last Updated';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    
    keys
    {
        key(PK; "Metric ID")
        {
            Clustered = true;
        }
        key(Period; "Period Type", "Period Start Date")
        {
        }
        key(Department; "Department Code", "Period Start Date")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created DateTime" := CurrentDateTime;
        "Last Updated" := CurrentDateTime;
    end;
    
    trigger OnModify()
    begin
        "Last Updated" := CurrentDateTime;
        CalculateMetrics();
    end;
    
    local procedure CalculateMetrics()
    begin
        if "Total Audits Planned" > 0 then
            "Audit Completion Rate %" := ("Total Audits Completed" / "Total Audits Planned") * 100;
            
        if "Total Recommendations" > 0 then
            "Implementation Rate %" := ("Recommendations Implemented" / "Total Recommendations") * 100;
            
        if "Total Actions" > 0 then
            "Action Completion Rate %" := ("Actions Completed" / "Total Actions") * 100;
            
        if "Planned Hours" > 0 then
            "Efficiency Rate %" := ("Actual Hours" / "Planned Hours") * 100;
    end;
}