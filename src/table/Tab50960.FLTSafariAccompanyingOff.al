table 50960 "FLT-Safari Accompanying Off."
{

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Safari No."; Code[10])
        {
        }
        field(3; "Employee No."; Code[10])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin
                emp.Reset;
                emp.SetRange(emp."No.", "Employee No.");
                if emp.Find('-') then begin
                    "Employee Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
                end;
            end;
        }
        field(4; "Employee Name"; Text[100])
        {
        }
        field(5; Designation; Code[10])
        {
        }
        field(6; "Emp. Pin No."; Code[10])
        {
        }
        field(7; Department; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('DEPARTMENT'));
        }
    }

    keys
    {
        key(Key1; "No.", "Safari No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        emp: Record "HRM-Employee C";
}

