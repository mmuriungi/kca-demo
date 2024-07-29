table 54835 "HMS-Observation Form Line Proc"
{

    fields
    {
        field(1; "Observation No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Observation Form Header"."Observation No.";
        }
        field(2; "Process No."; Code[20])
        {
            NotBlank = true;
        }
        field(3; "Process Name"; Text[30])
        {
            FieldClass = Normal;
        }
        field(4; "Process Mandatory"; Boolean)
        {
            FieldClass = Normal;
        }
        field(5; "Process Remarks"; Text[100])
        {
        }
        field(6; "Process Result"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Observation No.", "Process No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

