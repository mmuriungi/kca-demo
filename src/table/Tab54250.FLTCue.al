table 54250 "FLT-Cue"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "New Transport Requisitions"; Integer)
        {
            CalcFormula = Count("FLT-Transport Requisition" WHERE(Status = FILTER(Open)));
            FieldClass = FlowField;
        }
        field(3; "Approved Transport Req"; Integer)
        {
            CalcFormula = Count("FLT-Transport Requisition" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(4; "New Safari Notices"; Integer)
        {
            CalcFormula = Count("FLT-Safari Notice" WHERE(Status = FILTER(Open)));
            FieldClass = FlowField;
        }
        field(5; "Approved Safari Notices"; Integer)
        {
            CalcFormula = Count("FLT-Safari Notice" WHERE(Status = FILTER(Submitted)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

