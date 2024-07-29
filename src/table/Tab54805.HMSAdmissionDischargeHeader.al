table 54805 "HMS-Admission Discharge Header"
{
    LookupPageID = "HMS Admission Discharge List";

    fields
    {
        field(1; "Admission No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Patient No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Patient"."Patient No.";
        }
        field(3; "Discharge Date"; Date)
        {
        }
        field(4; "Discharge Time"; Time)
        {
        }
        field(5; "Doctor ID"; Code[20])
        {
            TableRelation = "HMS-Setup Doctor"."User ID";
        }
        field(6; "Nurse ID"; Code[20])
        {
            //TableRelation = Table2000000002.Field1;
        }
        field(7; Remarks; Text[200])
        {
        }
        field(8; Status; Option)
        {
            OptionMembers = New,Completed;
        }
        field(9; "Ward No."; Code[20])
        {
        }
        field(10; "Bed No."; Code[20])
        {
        }
        field(11; "Date of Admission"; Date)
        {
        }
        field(12; "Time Of Admission"; Time)
        {
        }
        field(27; Surname; Text[100])
        {
            CalcFormula = Lookup("HMS-Patient".Surname WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(28; "Middle Name"; Text[30])
        {
            CalcFormula = Lookup("HMS-Patient"."Middle Name" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(29; "Last Name"; Text[50])
        {
            CalcFormula = Lookup("HMS-Patient"."Last Name" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(30; "ID Number"; Code[20])
        {
            CalcFormula = Lookup("HMS-Patient"."ID Number" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(31; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = Lookup("HMS-Patient"."Correspondence Address 1" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(32; "Telephone No. 1"; Code[100])
        {
            CalcFormula = Lookup("HMS-Patient"."Telephone No. 1" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(33; Email; Text[100])
        {
            CalcFormula = Lookup("HMS-Patient".Email WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(34; "Patient Ref. No."; Code[20])
        {
            CalcFormula = Lookup("HMS-Patient"."Patient Ref. No." WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Admission No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*Insert the processes to the database*/
        Process.RESET;
        IF Process.FIND('-') THEN BEGIN
                                      REPEAT
                                          Line.INIT;
                                          Line."Admission No." := "Admission No.";
                                          Line."Process Code" := Process.Code;
                                          Line.INSERT();
                                      UNTIL Process.NEXT = 0;
        END;

    end;

    var
        Process: Record "HMS-Setup Discharge Processes";
        Line: Record "HMS-Admission Discharge Line";
}

