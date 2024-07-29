table 54809 "HMS-Admission Form Nurse"
{

    fields
    {
        field(1; "Admission No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Nurse ID"; Code[20])
        {
            NotBlank = true;
            //TableRelation = Table2000000002.Field1;
        }
        field(3; Date; Date)
        {
        }
        field(4; Time; Time)
        {
        }
        field(5; Notes; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Admission No.", "Nurse ID", Date, Time)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Nurse ID" := USERID;
        Date := TODAY;
        Time := Time;
    end;
}

