table 54912 "HMIS Room Spaces"
{

    fields
    {
        field(1; "Ward Code"; Code[20])
        {
            TableRelation = "HMIS Ward Card"."Asset No";
        }
        field(2; "Room Code"; Code[20])
        {
            TableRelation = "HMIS Ward Block Rooms"."Room Code";
        }
        field(3; "Space Code"; Code[20])
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Vaccant,Partially Occupied,Fully Occupied,Black-Listed,Partially Booked,Fully Booked';
            OptionMembers = Vaccant,"Partially Occupied","Fully Occupied","Black-Listed","Partially Booked","Fully Booked";
        }
        field(9; Booked; Boolean)
        {
        }
        field(10; "Booked Patients"; Code[20])
        {
        }
        field(11; "Patient No"; Code[20])
        {
        }
        field(12; "Receipt No"; Code[20])
        {
        }
        field(13; "Patient Name"; Text[250])
        {
        }
        field(14; "Black List reason"; Text[30])
        {
        }
        field(15; "Room Cost"; Decimal)
        {
        }
        field(16; "Current Patient"; Code[30])
        {
            CalcFormula = Lookup("HMIS Ward Ledger"."Patient No" WHERE("Space No" = FIELD("Space Code"),
                                                                        "Room No" = FIELD("Room Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Ward Code", "Room Code", "Space Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        rmsLedger.RESET;
        //rmsLedger.SETRANGE(rmsLedger."Ward No","Asset No");
        rmsLedger.SETRANGE(rmsLedger."Room No", "Room Code");
        rmsLedger.SETRANGE(rmsLedger."Space No", "Space Code");
        IF rmsLedger.FIND('-') THEN BEGIN
            ERROR('Allocations exists for this Space. Clear the space first.');
        END;
    end;

    var
        rmsLedger: Record "HMIS Ward Ledger";
}

