table 54203 "Maintenance Plan Lines"
{

    fields
    {
        field(1; "Plan No."; Code[20])
        {
            TableRelation = "Maintenance Plan"."Plan No.";
        }
        field(5; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "Fixed Asset No."; Code[20])
        {
            TableRelation = "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                FA.RESET;
                IF FA.GET("Fixed Asset No.") THEN BEGIN
                    Description := FA.Description;
                    Location := FA."FA Location Code";
                    "Serial No." := FA."Serial No.";
                    "Service Date" := FA."Next Service Date";
                END
                ELSE BEGIN
                    Description := ' ';
                    Location := ' ';
                    "Serial No." := ' ';
                    "Service Date" := 0D;
                END;
            end;
        }
        field(15; Description; Text[50])
        {
        }
        field(20; Location; Code[20])
        {
            TableRelation = "FA Location";
        }
        field(25; "Serial No."; Text[30])
        {
        }
        field(30; "Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(35; "Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(40; "Service Date"; Date)
        {
        }
        field(45; "Estimated Cost"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Plan No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        FA: Record 5600;
}

