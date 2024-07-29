table 56009 "Complaint Committee"
{
    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;

        }
        field(2; Code; Code[30])
        {

        }
        field(3; "Staff No"; Code[30])
        {
            TableRelation = "HRM-Employee (D)";
            trigger OnValidate()
            var
                HRMEmp: Record "HRM-Employee (D)";
            begin
                if HRMEmp.Get("Staff No") then begin
                    "Staff Name" := HRMEmp.FullName;
                end;
            end;
        }
        field(4; "Staff Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Region; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            var
                Dimval: Record "Dimension Value";
            begin
                if Dimval.Get(Region) then begin
                    "Region Name" := Dimval.Name;
                end;
            end;
        }
        field(6; "Region Name"; Text[50])
        {

        }
        field(7; "Cost Center"; Text[100])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            var
                Dimval: Record "Dimension Value";
            begin
                if Dimval.Get("Cost Center") then begin
                    "Cost Center Name" := Dimval.Name;
                end;
            end;
        }
        field(8; "Cost Center Name"; Text[100])
        {

        }
        field(9; "User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.", Code)
        {
            Clustered = true;
        }
        key(Key2; "Staff No")
        {

        }
    }
}

