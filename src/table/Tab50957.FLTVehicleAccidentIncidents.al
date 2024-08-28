table 50957 "FLT-Vehicle Accident/Incidents"
{

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Vehicle No."; Code[20])
        {
            TableRelation = "FLT-Fleet Mgt Setup".Missing;
        }
        field(3; "Incidence Naration"; Text[250])
        {
        }
        field(4; "Date of Occur"; Date)
        {
        }
        field(5; "Driver Incharge"; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(6; "Cost of Damage"; Decimal)
        {
        }
        field(7; "Date Repaired"; Date)
        {
        }
        field(8; "Driver Incharge Name"; Text[30])
        {
            CalcFormula = Lookup("HRM-Employee C"."First Name" WHERE("No." = FIELD("Driver Incharge")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.", "Vehicle No.")
        {
        }
    }

    fieldgroups
    {
    }
}

