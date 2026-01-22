// Table: Sports Equipment Cue
table 51267 "Sports Equipment Cue"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Issued Equipment"; Integer)
        {
            Caption = 'Issued Equipment';
            FieldClass = FlowField;
            CalcFormula = count("Equipment Issuance" where(Status = const(Issued)));
        }
        field(3; "Overdue Equipment"; Integer)
        {
            Caption = 'Overdue Equipment';
            FieldClass = FlowField;
            CalcFormula = count("Equipment Issuance" where(Status = const(Issued), "Return Date" = field(OverdueDate)));
        }
        field(4; "Lost Equipment"; Integer)
        {
            Caption = 'Lost Equipment';
            FieldClass = FlowField;
            CalcFormula = count("Equipment Issuance" where(Status = const(Lost)));
        }
        field(5; OverdueDate; Date)
        {
            Caption = 'Overdue Date';
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
