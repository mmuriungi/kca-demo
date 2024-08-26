table 51172 "HMS-Treatment Form Injection"
{

    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Injection No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Setup Injection".Code;

            trigger OnValidate()
            var
                hms: Record "HMS-Setup Injection";
            begin
                hms.RESET();
                IF hms.GET("Injection No.") THEN BEGIN
                    rec."Injection Name" := HMS.Description;
                    REC.Amount := HMS.Amount;
                END;
            end;
        }
        field(3; "Injection Name"; Text[100])
        {
            CalcFormula = Lookup("HMS-Setup Injection".Description WHERE(Code = FIELD("Injection No.")));
            FieldClass = FlowField;
        }
        field(4; "Injection Given"; Boolean)
        {
        }
        field(5; "Injection Remarks"; Text[100])
        {
        }
        field(6; "Injection Unit of Measure"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(7; "Injection Quantity"; Decimal)
        {
        }
        field(8; "Item No."; Code[20])
        {
        }
        field(9; Location; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(10; Posted; Boolean)
        {
        }
        field(11; Duration; Text[30])
        {
        }
        field(12; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Injection No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record 27;
        Injection: Record "HMS-Setup Injection";
}

