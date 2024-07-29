table 54909 "HMIS Ward Ledger History"
{
    // DrillDownPageID = 64503;
    //LookupPageID = 64503;

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = false;
        }
        field(2; "Ward No"; Code[20])
        {
            TableRelation = "HMIS Ward Card"."Asset No";
        }
        field(3; "Room No"; Code[20])
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Vaccant,Partially Occupied,Fully Occupied,Black-Listed,Partially Booked,Fully Booked';
            OptionMembers = Vaccant,"Partially Occupied","Fully Occupied","Black-Listed","Partially Booked","Fully Booked";
        }
        field(5; "Room Cost"; Decimal)
        {
        }
        field(6; "Patient No"; Code[20])
        {
        }
        field(7; "Receipt No"; Code[20])
        {
        }
        field(8; "Space No"; Code[20])
        {
        }
        field(9; Booked; Boolean)
        {
        }
        field(10; "Booked Patients"; Code[20])
        {
            /* CalcFormula = Lookup("HMIS Ward Rooms"."Patient No." WHERE (Space No=FIELD(Space No),
                                                                        Semester=FIELD(Semester Filter)));
            FieldClass = FlowField; */
        }
        field(11; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(12; "Patients Count"; Integer)
        {
            /*  CalcFormula = Count("HMIS Ward Rooms" WHERE (Space No=FIELD(Space No),
                                                          Semester=FIELD(Semester Filter)));
             FieldClass = FlowField; */
        }
        field(13; Gender; Code[20])
        {
            /* CalcFormula = Lookup("HMIS Ward Card".Gender WHERE (Asset No=FIELD(Ward No)));
            FieldClass = FlowField; */
        }
        field(14; "Reservation Remarks"; Text[100])
        {
        }
        field(15; "Reservation UserID"; Code[20])
        {
        }
        field(16; "Reservation Date"; Date)
        {
        }
        field(50000; Campus; Code[20])
        {
            /*  CalcFormula = Lookup("HMIS Ward Card"."Campus Code" WHERE (Asset No=FIELD(Ward No)));
             FieldClass = FlowField; */
        }
        field(50001; "Ward Name"; Text[100])
        {
            /* CalcFormula = Lookup("HMIS Ward Card".Description WHERE (Asset No=FIELD(Ward No)));
            FieldClass = FlowField; */
        }
        field(50002; "Inpatient No"; Code[20])
        {
        }
        field(50004; "User ID"; Code[100])
        {
        }
        field(50005; "Registration No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Space No", "Room No", "Ward No", "Patient No", "Inpatient No")
        {
        }
        key(Key2; "Ward No")
        {
        }
        key(Key3; "Patient No")
        {
        }
        key(Key4; "Room No", Status)
        {
        }
    }

    fieldgroups
    {
    }
}

