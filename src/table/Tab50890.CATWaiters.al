table 50890 "CAT-Waiters"
{
    DrillDownPageID = "ACA-Semester Card";
    LookupPageID = "ACA-Semester Card";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(3; "Employee Name"; Text[100])
        {
            CalcFormula = Lookup("HRM-Employee C"."First Name" WHERE("No." = FIELD("Employee No.")));
            FieldClass = FlowField;
        }
        field(4; Position; Code[20])
        {
        }
        field(5; Category; Option)
        {
            OptionCaption = ' ,Cook,Waiter/Waitress,Cleaner,Laundry';
            OptionMembers = " ",Cook,"Waiter/Waitress",Cleaner,Laundry;
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }
}

