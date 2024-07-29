table 54303 CueTable
{
    Caption = 'CueTable';
    DataClassification = ToBeClassified;

    fields
    {
        field(4; "Primary Key"; BigInteger)
        {

        }
        field(1; "Approved Workplan List"; Integer)
        {
            Caption = 'Approved Workplan List';
            FieldClass = FlowField;
            CalcFormula = count("DepartMent Work Plan" where(Status = const(Released)));
        }
        field(2; "Resolved Complaint"; Integer)
        {
            Caption = 'Resolved Complaint';
            FieldClass = FlowField;
            CalcFormula = count("Complaint Affair" where("Complaint Status" = const(Resolved)));
        }
        field(3; "Approved Retirement List"; Integer)
        {
            Caption = 'Approved Retirement List';

            FieldClass = FlowField;
            // CalcFormula = count("Retirement Receipt Header" where(Status = const(Released)));
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
