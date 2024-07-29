table 54207 "Asset Incident Lines"
{

    fields
    {
        field(1; "Incident No."; Code[20])
        {
            TableRelation = "Asset Incident"."Incident No.";
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
                END
                ELSE BEGIN
                    Description := ' ';
                    Location := ' ';
                    "Serial No." := ' ';
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
        field(40; "Incident Description"; Text[100])
        {
        }
        field(45; "Incident Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Incident No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        FA: Record 5600;
}

