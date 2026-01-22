#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 61163 "ACA-Hostel Ledger"
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
                                                                   Semester = field(Semester),
                                                                   Allocated = filter(true)));
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
            TableRelation = "ACA-Semesters".Code;
        }
        field(50003; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(50004; "User ID"; Code[100])
        {
            CalcFormula = lookup("ACA-Students Hostel Rooms"."Allocated By" where("Space No" = field("Space No"),
                                                                                   "Room No" = field("Room No"),
                                                                                   "Hostel No" = field("Hostel No"),
                                                                                   Semester = field(Semester)));
            FieldClass = FlowField;
        }
        field(50005; "Space Exists"; Boolean)
        {
            CalcFormula = exist("ACA-Room Spaces" where("Hostel Code" = field("Hostel No"),
                                                         "Room Code" = field("Room No"),
                                                         "Space Code" = field("Space No")));
            FieldClass = FlowField;
        }
        field(50006; Occurance; Integer)
        {
            CalcFormula = count("ACA-Hostel Ledger" where("Student No" = field("Student No"),
                                                           Semester = field(Semester),
                                                           "Academic Year" = field("Academic Year")));
            FieldClass = FlowField;
        }
        field(50007; "Student Name"; Text[150])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Student No")));
            FieldClass = FlowField;
        }
        field(50008; Address; Text[150])
        {
            CalcFormula = lookup(Customer.Address where("No." = field("Student No")));
            FieldClass = FlowField;
        }
        field(50009; City; Text[150])
        {
            CalcFormula = lookup(Customer.City where("No." = field("Student No")));
            FieldClass = FlowField;
        }
        field(50010; Phone; Code[150])
        {
            CalcFormula = lookup(Customer."Phone No." where("No." = field("Student No")));
            FieldClass = FlowField;
        }
        field(50011; "Old Student No."; Code[25])
        {
            CalcFormula = lookup(Customer."Old Student Code" where("No." = field("Student No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Space No", "Room No", "Hostel No")
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

    trigger OnDelete()
    begin
        Clear(counts);
        LedgerHistory.Reset;
        if LedgerHistory.Find('-') then begin
            counts := LedgerHistory.Count;
        end;
        roomSpaces.Reset;
        roomSpaces.SetRange(roomSpaces."Hostel Code", "Hostel No");
        roomSpaces.SetRange(roomSpaces."Room Code", "Room No");
        roomSpaces.SetRange(roomSpaces."Space Code", "Space No");
        if roomSpaces.Find('-') then begin
            roomSpaces.Status := roomSpaces.Status::Vaccant;
            roomSpaces."Student No" := '';
            roomSpaces."Receipt No" := '';
            roomSpaces.Modify;
            LedgerHistory.Init;
            LedgerHistory."Space No" := "Space No";
            LedgerHistory."Room No" := "Room No";
            LedgerHistory."Hostel No" := "Hostel No";
            LedgerHistory.No := counts + 1;
            LedgerHistory.Status := LedgerHistory.Status::"Fully Occupied";
            LedgerHistory."Room Cost" := "Room Cost";
            LedgerHistory."Student No" := "Student No";
            LedgerHistory."Receipt No" := "Receipt No";
            LedgerHistory.Booked := Booked;
            LedgerHistory."Reservation Remarks" := "Reservation Remarks";
            LedgerHistory."Reservation UserID" := "Reservation UserID";
            LedgerHistory."Reservation Date" := "Reservation Date";
            LedgerHistory.Semester := Semester;
            LedgerHistory."Semester Filter" := "Semester Filter";
            LedgerHistory."Booked Students" := "Booked Students";
            LedgerHistory."Students Count" := "Students Count";
            LedgerHistory.Gender := Gender;
            LedgerHistory.Campus := Campus;
            LedgerHistory."Hostel Name" := "Hostel Name";
            LedgerHistory.Insert;
        end;
    end;

    trigger OnInsert()
    begin
        Status := Status::"Fully Occupied";
        "User ID" := UserId;
    end;

    var
        roomSpaces: Record "ACA-Room Spaces";
        LedgerHistory: Record "ACA-Hostel Ledger History";
        counts: Integer;
}

