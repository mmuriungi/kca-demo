table 50348 "HRM-Leave Allowance Reg."
{

    fields
    {
        field(1; "Employee No"; Code[30])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(2; "First Name"; Text[100])
        {
            CalcFormula = Lookup("HRM-Employee C"."First Name" WHERE("No." = FIELD("Employee No")));
            FieldClass = FlowField;
        }
        field(3; "Middle Name"; Text[100])
        {
            CalcFormula = Lookup("HRM-Employee C"."Middle Name" WHERE("No." = FIELD("Employee No")));
            FieldClass = FlowField;
        }
        field(4; "Last Name"; Text[100])
        {
            CalcFormula = Lookup("HRM-Employee C"."Last Name" WHERE("No." = FIELD("Employee No")));
            FieldClass = FlowField;
        }
        field(5; "Leave Allowance Amount"; Decimal)
        {
        }
        field(6; "Reject Reason"; Text[100])
        {
        }
        field(7; "Payroll Period"; Date)
        {
            TableRelation = "PRL-Payroll Periods"."Date Opened";
        }
    }

    keys
    {
        key(Key1; "Employee No", "Payroll Period")
        {
        }
    }

    fieldgroups
    {
    }
}

