table 54834 "HMS-Observation Form Injection"
{

    fields
    {
        field(1; "Observation No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Observation Form Header"."Observation No.";
        }
        field(2; "Injection No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Setup Injection".Code;

            trigger OnValidate()
            begin
                Injection.RESET;
                Injection.GET("Injection No.");
                "Item No." := Injection."Item No.";
            end;
        }
        field(3; "Injection Name"; Text[100])
        {
            CalcFormula = Lookup("HMS-Setup Injection".Description WHERE(Code = FIELD("Injection No.")));
            FieldClass = FlowField;
        }
        field(4; "Injection Date"; Date)
        {
        }
        field(5; "Injection Time"; Time)
        {
        }
        field(6; "Injection Remarks"; Text[100])
        {
        }
        field(7; "Item No."; Code[20])
        {
            CalcFormula = Lookup("HMS-Setup Injection"."Item No." WHERE(Code = FIELD("Injection No.")));
            FieldClass = FlowField;
            TableRelation = Item."No.";
        }
        field(8; Location; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(9; "Item Unit Of Measure"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(10; Quantity; Decimal)
        {
        }
        field(11; Posted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Observation No.", "Injection No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Injection: Record "HMS-Setup Injection";
}

