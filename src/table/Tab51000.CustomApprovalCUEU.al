table 51000 "Custom Approval CUEU"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(3; "HOD Requests"; Integer)
        {
            CalcFormula = Count("FLT-Transport Requisition" WHERE("Head of Department" = FIELD("User ID Filter"),
                                                        "Approval Stage" = FILTER("Head of Department"), status = filter("Pending Approval")));
            Caption = 'HOD Requests';
            FieldClass = FlowField;
        }
        field(4; "Transport Officer"; Integer)
        {
            CalcFormula = Count("FLT-Transport Requisition" WHERE("Transport Officer" = FIELD("User ID Filter"),
                                                        "Approval Stage" = FILTER("Transport Officer"), status = filter("Pending Approval")));
            Caption = 'Transport Requests';
            FieldClass = FlowField;
        }
        field(5; "Registra Requests"; Integer)
        {
            CalcFormula = Count("FLT-Transport Requisition" WHERE("Registrar HRM" = FIELD("User ID Filter"),
                                                        "Approval Stage" = FILTER("Registra HRM"), status = filter("Pending Approval")));
            Caption = 'Registra Requests';
            FieldClass = FlowField;
        }



    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}