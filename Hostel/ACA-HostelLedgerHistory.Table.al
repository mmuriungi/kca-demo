#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 61825 "ACA-Hostel Ledger History"
{
    DrillDownPageID = "ACA-Hostel Ledger";
    LookupPageID = "ACA-Hostel Ledger";

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = false;
        }
        field(2; "Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No";
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
        field(6; "Student No"; Code[20])
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
        field(10; "Booked Students"; Code[20])
        {
            CalcFormula = lookup("ACA-Students Hostel Rooms".Student where("Space No" = field("Space No"),
                                                                            Semester = field("Semester Filter")));
            FieldClass = FlowField;
        }
        field(11; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(12; "Students Count"; Integer)
        {
            CalcFormula = count("ACA-Students Hostel Rooms" where("Space No" = field("Space No"),
                                                                   Semester = field("Semester Filter")));
            FieldClass = FlowField;
        }
        field(13; Gender; Option)
        {
            CalcFormula = lookup("ACA-Hostel Card".Gender where("Asset No" = field("Hostel No")));
            FieldClass = FlowField;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
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
            CalcFormula = lookup("ACA-Hostel Card"."Campus Code" where("Asset No" = field("Hostel No")));
            FieldClass = FlowField;
        }
        field(50001; "Hostel Name"; Text[100])
        {
            CalcFormula = lookup("ACA-Hostel Card".Description where("Asset No" = field("Hostel No")));
            FieldClass = FlowField;
        }
        field(50002; Semester; Code[20])
        {
        }
        field(50004; "User ID"; Code[100])
        {
            CalcFormula = lookup("ACA-Students Hostel Rooms"."Allocated By" where("Space No" = field("Space No"),
                                                                                   "Room No" = field("Room No"),
                                                                                   "Hostel No" = field("Hostel No"),
                                                                                   Semester = field(Semester)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Space No", "Room No", "Hostel No", "Student No", Semester)
        {
            Clustered = true;
        }
        key(Key2; "Hostel No")
        {
        }
        key(Key3; "Student No")
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

