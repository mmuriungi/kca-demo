table 51274 "Contract Cues"
{
    Caption = 'Contract Cues';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PK; Integer)
        {

        }
        field(145; "Contracts (Open)"; Integer)
        {
            Caption = 'Contracts (Open)';
            FieldClass = FlowField;
            CalcFormula = count("Project Header" WHERE(Status = FILTER(Open | "Pending Approval")));
        }
        field(146; "Contracts (Running)"; Integer)
        {
            Caption = 'Contracts (Running)';
            FieldClass = FlowField;
            CalcFormula = count("Project Header" WHERE(Status = FILTER(Approved)));
        }
        field(147; "Contracts (Finished)"; Integer)
        {
            Caption = 'Contracts (Finished)';
            FieldClass = FlowField;
            CalcFormula = count("Project Header" WHERE(Status = FILTER(Finished)));
        }
        field(148; "Contracts (Suspended)"; Integer)
        {
            Caption = 'Contracts (Suspended)';
            FieldClass = FlowField;
            CalcFormula = count("Project Header" WHERE(Status = FILTER(Suspended)));
        }
        field(149; "Contracts (Pending Verif)"; Integer)
        {
            Caption = 'Contracts (Pending Verification)';
            FieldClass = FlowField;
            CalcFormula = count("Project Header" WHERE(Status = FILTER("Pending Verification")));
        }
        field(150; "Contracts (Verified)"; Integer)
        {
            Caption = 'Contracts (Verified)';
            FieldClass = FlowField;
            CalcFormula = count("Project Header" WHERE(Status = FILTER(Verified)));
        }
    }
    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }
}
