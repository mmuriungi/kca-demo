table 54837 "HMS-Observation Symptoms"
{

    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            TableRelation = "HMS-Treatment Form Header"."Treatment No.";
        }

        field(3; "Symptom Description"; Text[100])
        {
            FieldClass = Normal;
        }
        field(4; "Symptom Code"; Code[20])
        {
            TableRelation = "HMS-Systems".Code;
            trigger OnValidate()
            var
                sympCode: Record "HMS-Systems";
            begin
                sympCode.Reset();
                sympCode.SetRange(Code, "Symptom Code");
                if sympCode.Find('-') then
                    "Symptom Description" := sympCode.Description;

            end;
        }
        field(5; Duration; Text[30])
        {
        }
        field(6; Description; Text[200])
        {
        }
        field(7; Characteristics; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Symptom Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Symp: Record "HMS-Symptoms Setup";
}

