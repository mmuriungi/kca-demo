table 54907 "HMIS Ward Ledger"
{
    //DrillDownPageID = 64503;
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
            TableRelation = "HMIS Ward Block Rooms"."Room Code" WHERE("Ward Code" = filter('Ward No'));
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
            TableRelation = "HMIS Room Spaces"."Space Code" WHERE("Ward Code" = Filter('Ward No'),
                                                                   "Room Code" = Filter('Room No'));
        }
        field(9; Booked; Boolean)
        {
        }
        field(10; "Booked Patients"; Code[20])
        {
            /*   CalcFormula = Lookup("HMIS Ward Rooms"."Patient No." WHERE (Space No=FIELD(Space No),
                                                                          Semester=FIELD(Semester Filter)));
              FieldClass = FlowField; */
        }
        field(11; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(12; "Patients Count"; Integer)
        {
            /* CalcFormula = Count("HMIS Ward Rooms" WHERE (Space No=FIELD(Space No),
                                                         Semester=FIELD(Semester Filter),
                                                         Allocated=FILTER(Yes)));
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
            /*   CalcFormula = Lookup("HMIS Ward Card"."Campus Code" WHERE (Asset No=FIELD(Ward No)));
              FieldClass = FlowField; */
        }
        field(50001; "Ward Name"; Text[100])
        {
            /* CalcFormula = Lookup("HMIS Ward Card".Description WHERE (Asset No=FIELD(Ward No)));
            FieldClass = FlowField; */
        }
        field(50002; "Inpatient no."; Code[20])
        {
        }
        field(50003; "Registration No."; Code[20])
        {
            //TableRelation = "ACA-Academic Year".Code;
        }
        field(50004; "User ID"; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; "Space No", "Room No", "Ward No")
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

    trigger OnDelete()
    begin
        CLEAR(counts);
        LedgerHistory.RESET;
        IF LedgerHistory.FIND('-') THEN BEGIN
            counts := LedgerHistory.COUNT;
        END;
        roomSpaces.RESET;
        roomSpaces.SETRANGE(roomSpaces."Ward Code", "Ward No");
        roomSpaces.SETRANGE(roomSpaces."Room Code", "Room No");
        roomSpaces.SETRANGE(roomSpaces."Space Code", "Space No");
        IF roomSpaces.FIND('-') THEN BEGIN
            roomSpaces.Status := roomSpaces.Status::Vaccant;
            roomSpaces."Patient No" := '';
            roomSpaces."Receipt No" := '';
            roomSpaces.MODIFY;
            LedgerHistory.INIT;
            LedgerHistory."Space No" := "Space No";
            LedgerHistory."Room No" := "Room No";
            LedgerHistory."Ward No" := "Ward No";
            LedgerHistory.No := counts + 1;
            LedgerHistory.Status := LedgerHistory.Status::"Fully Occupied";
            LedgerHistory."Room Cost" := "Room Cost";
            LedgerHistory."Patient No" := "Patient No";
            LedgerHistory."Receipt No" := "Receipt No";
            LedgerHistory.Booked := Booked;
            LedgerHistory."Reservation Remarks" := "Reservation Remarks";
            LedgerHistory."Reservation UserID" := "Reservation UserID";
            LedgerHistory."Reservation Date" := "Reservation Date";
            LedgerHistory."Inpatient No" := "Inpatient no.";
            LedgerHistory."Semester Filter" := "Semester Filter";
            LedgerHistory."Booked Patients" := "Booked Patients";
            LedgerHistory."Patients Count" := "Patients Count";
            LedgerHistory.Gender := Gender;
            LedgerHistory.Campus := Campus;
            LedgerHistory."Ward Name" := "Ward Name";
            LedgerHistory.INSERT;
        END;
    end;

    trigger OnInsert()
    begin
        Status := Status::"Fully Occupied"
    end;

    var
        roomSpaces: Record "HMIS Room Spaces";
        LedgerHistory: Record "HMIS Ward Ledger History";
        counts: Integer;
}

