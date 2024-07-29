table 54245 "FLT-Department Vehicle Alloc"
{

    fields
    {
        field(1; "Vehicle No"; Code[20])
        {
        }
        field(2; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('INSTITUTE'));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, Department);
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                if DimVal.Find('-') then
                    "Department Name" := DimVal.Name;
            end;
        }
        field(3; "Department Name"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Vehicle No", Department)
        {
        }
    }

    fieldgroups
    {
    }

    var
        DimVal: Record "Dimension Value";
}

