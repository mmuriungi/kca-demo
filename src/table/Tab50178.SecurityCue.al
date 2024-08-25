
// Table: Security Cue
table 50178 "Security Cue"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Today's Registrations"; Integer)
        {
            CalcFormula = Count("Guest Registration" WHERE("Time In" = FIELD("DateTime Filter")));
            FieldClass = FlowField;
        }
        field(3; "Weekly Registrations"; Integer)
        {
            CalcFormula = Count("Guest Registration" WHERE("Time In" = FIELD("DateTime Filter")));
            FieldClass = FlowField;
        }
        field(4; "Open Incidents"; Integer)
        {
            CalcFormula = Count("Incident Report" WHERE(Status = CONST(Open)));
            FieldClass = FlowField;
        }
        field(5; "Incidents This Week"; Integer)
        {
            //FieldClass = FlowField;
        }
        field(20; "DateTime Filter"; DateTime)
        {
            Caption = 'DateTime Filter';
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
}
