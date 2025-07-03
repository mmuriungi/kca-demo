#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 61155 "ACA-Students Hostel Rooms"
{
    DrillDownPageID = "ACA-Stud. Hostel Rooms2";
    LookupPageID = "ACA-Stud. Hostel Rooms2";

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Space No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Room Spaces"."Space Code" where("Hostel Code" = field("Hostel No"),
                                                                  "Room Code" = field("Room No"),
                                                                  Status = filter(Vaccant));

            trigger OnValidate()
            var
                ACAHostelBlockRooms: Record "ACA-Hostel Block Rooms";
            begin
                validateModification();
                Clear(settlementType);
                courseReg.Reset;
                courseReg.SetRange(courseReg."Student No.", Student);
                courseReg.SetRange(courseReg.Semester, Semester);
                //  courseReg.SETRANGE(courseReg."Academic Year","Academic Year");
                if courseReg.Find('-') then begin
                    if prog.Get(courseReg.Programme) then begin
                        if prog."Special Programme" then
                            settlementType := Settlementtype::"Special Programme"
                        else if courseReg."Settlement Type" = 'KUCCPS' then
                            settlementType := Settlementtype::JAB
                        else if courseReg."Settlement Type" = 'PSSP' then settlementType := Settlementtype::SSP;
                    end;
                end;
                Clear(billAmount);
                Rooms.Reset;
                Rooms.SetRange(Rooms."Hostel Code", "Hostel No");
                Rooms.SetRange(Rooms."Room Code", "Room No");
                if Rooms.Find('-') then begin
                    Rooms.Validate("Room Code");
                    if settlementType = Settlementtype::"Special Programme" then
                        billAmount := Rooms."Special Programme"
                    else if settlementType = Settlementtype::JAB then
                        billAmount := Rooms."JAB Fees"
                    else if settlementType = Settlementtype::SSP then
                        billAmount := Rooms."SSP Fees"
                end;
                Charges := billAmount;
                /*
               IF billAmount>0 THEN BEGIN
               hstR.RESET;
               hstR.SETRANGE(hstR.Student,Student);
               hstR.SETRANGE(hstR."Line No","Line No");
               //hstR.SETRANGE(hstR."Space No","Space No");
               hstR.SETRANGE(hstR."Room No","Room No");
               hstR.SETRANGE(hstR."Hostel No","Hostel No");
               hstR.SETRANGE(hstR.Semester,Semester);
               hstR.SETRANGE(hstR.Cleared,FALSE);
               IF hstR.FIND('-') THEN BEGIN
                hstR.Charges:=billAmount;
                hstR.MODIFY;
                END;
                END;  */
                ACAHostelBlockRooms.Reset;
                //ACAHostelBlockRooms.COPYFILTERS(Rec);
                if ACAHostelBlockRooms.Find('-') then begin
                    repeat
                        ACAHostelBlockRooms.Validate(Status);
                    until ACAHostelBlockRooms.Next = 0;
                end;


            end;
        }
        field(3; "Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Block Rooms"."Room Code" where("Hostel Code" = field("Hostel No"),
                                                                        Status = filter(Vaccant | "Partially Occupied"));

            trigger OnValidate()
            begin
                "Space No" := '';
                validateModification();
                roomSpaces.Reset;
                roomSpaces.SetRange(roomSpaces."Hostel Code", Rec."Hostel No");
                roomSpaces.SetRange(roomSpaces."Room Code", Rec."Room No");
                roomSpaces.SetFilter(roomSpaces.Status, '=%1', roomSpaces.Status::Vaccant);
                if roomSpaces.Find('-') then begin
                    "Space No" := roomSpaces."Space Code";
                    Validate("Space No");
                end;
                Clear(Rooms);
                Rooms.Reset;
                Rooms.SetRange("Hostel Code", Rec."Hostel No");
                Rooms.SetRange("Room Code", Rec."Room No");
                if Rooms.Find('-') then begin
                    Rec.Charges := Rooms."Room Cost";
                end;
            end;
        }
        field(4; "Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No";

            trigger OnValidate()
            var
                ObjCust: Record Customer;
            begin
                HostRec.Reset;
                HostRec.SetRange("Asset No", "Hostel No");
                if HostRec.FindFirst then begin
                    ObjCust.Reset;
                    ObjCust.SetRange("No.", Student);
                    if ObjCust.FindFirst then begin
                        if ObjCust.Gender <> HostRec.Gender then
                            Error('Gender mismatch');
                    end;
                end;
                validateModification();
                "Room No" := '';
                "Space No" := '';
                Rooms.Reset;
                Rooms.SetRange("Hostel Code", Rec."Hostel No");
                Rooms.SetFilter(Rooms.Status, '=%1|%2', Rooms.Status::"Partially Occupied", Rooms.Status::Vaccant);
                if Rooms.Find('-') then begin
                    "Room No" := Rooms."Room Code";
                    Validate("Room No");
                end;

            end;
        }
        field(5; "Accomodation Fee"; Decimal)
        {
        }
        field(6; "Allocation Date"; Date)
        {
        }
        field(7; "Clearance Date"; Date)
        {
        }
        field(8; Charges; Decimal)
        {
        }
        field(9; Student; Code[20])
        {
            TableRelation = Customer."No." where("Customer Type" = const(Student));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                validateModification();
            end;
        }
        field(10; Billed; Boolean)
        {
        }
        field(11; "Billed Date"; Date)
        {
        }
        field(12; Semester; Code[20])
        {
            TableRelation = "ACA-Semesters".Code where("Current Semester" = const(true));
        }
        field(13; Cleared; Boolean)
        {
        }
        field(14; "Over Paid"; Boolean)
        {
        }
        field(15; "Over Paid Amt"; Decimal)
        {
        }
        field(16; "Eviction Code"; Code[20])
        {
            TableRelation = "HRM-Disciplinary Cases".Code;
        }
        field(17; Gender; Option)
        {
            CalcFormula = lookup(Customer.Gender where("No." = field(Student)));
            FieldClass = FlowField;
            OptionCaption = ',Male,Female';
            OptionMembers = ,Male,Female;
        }
        field(18; "Hostel Assigned"; Boolean)
        {
        }
        field(19; "Hostel Name"; Text[50])
        {
            CalcFormula = lookup("Fixed Asset".Description where("No." = field("Hostel No")));
            FieldClass = FlowField;
        }
        field(50000; "Student Name"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field(Student)));
            FieldClass = FlowField;
        }
        field(50001; "Academic Year"; Code[30])
        {
            TableRelation = "ACA-Academic Year".Code where(Current = const(true));
        }
        field(50002; Session; Code[10])
        {
            TableRelation = "ACA-Intake".Code;
        }
        field(50003; Allocated; Boolean)
        {
        }
        field(50004; Select; Boolean)
        {
        }
        field(50005; Balance; Decimal)
        {
        }
        field(50006; "Transfer to Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No" where(Gender = field(Gender));
        }
        field(50007; "Transfer to Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Block Rooms"."Room Code" where("Hostel Code" = field("Transfer to Hostel No"),
                                                                        Status = filter(Vaccant | "Partially Occupied"));
        }
        field(50008; "Transfer to Space No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Room Spaces"."Space Code" where("Hostel Code" = field("Transfer to Hostel No"),
                                                                  "Room Code" = field("Transfer to Room No"),
                                                                  Status = filter(Vaccant));

            trigger OnValidate()
            begin
                Clear(settlementType);
                courseReg.Reset;
                courseReg.SetRange(courseReg."Student No.", Student);
                courseReg.SetRange(courseReg.Semester, Semester);
                //  courseReg.SETRANGE(courseReg."Academic Year","Academic Year");
                if courseReg.Find('-') then begin
                    if prog.Get(courseReg.Programme) then begin
                        if prog."Special Programme" then
                            settlementType := Settlementtype::"Special Programme"
                        else if courseReg."Settlement Type" = 'JAB' then
                            settlementType := Settlementtype::JAB
                        else if courseReg."Settlement Type" = 'SSP' then settlementType := Settlementtype::SSP;
                    end;
                end;
                Clear(billAmount);
                Rooms.Reset;
                Rooms.SetRange(Rooms."Hostel Code", "Hostel No");
                Rooms.SetRange(Rooms."Room Code", "Room No");
                if Rooms.Find('-') then begin
                    if settlementType = Settlementtype::"Special Programme" then
                        billAmount := Rooms."Special Programme"
                    else if settlementType = Settlementtype::JAB then
                        billAmount := Rooms."JAB Fees"
                    else if settlementType = Settlementtype::SSP then
                        billAmount := Rooms."SSP Fees"
                end;

                if billAmount > 0 then Charges := billAmount;
            end;
        }
        field(50009; Transfered; Boolean)
        {
        }
        field(50010; Reversed; Boolean)
        {
        }
        field(50011; Switched; Boolean)
        {
        }
        field(50012; "Switched from Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No" where(Gender = field(Gender));
        }
        field(50013; "Switched from Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Block Rooms"."Room Code" where("Hostel Code" = field("Transfer to Hostel No"),
                                                                        Status = filter(Vaccant | "Partially Occupied"));
        }
        field(50014; "Switched from Space No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Room Spaces"."Space Code" where("Hostel Code" = field("Transfer to Hostel No"),
                                                                  "Room Code" = field("Transfer to Room No"),
                                                                  Status = filter(Vaccant));

            trigger OnValidate()
            begin
                Clear(settlementType);
                courseReg.Reset;
                courseReg.SetRange(courseReg."Student No.", Student);
                courseReg.SetRange(courseReg.Semester, Semester);
                //  courseReg.SETRANGE(courseReg."Academic Year","Academic Year");
                if courseReg.Find('-') then begin
                    if prog.Get(courseReg.Programme) then begin
                        if prog."Special Programme" then
                            settlementType := Settlementtype::"Special Programme"
                        else if courseReg."Settlement Type" = 'JAB' then
                            settlementType := Settlementtype::JAB
                        else if courseReg."Settlement Type" = 'SSP' then settlementType := Settlementtype::SSP;
                    end;
                end;
                Clear(billAmount);
                Rooms.Reset;
                Rooms.SetRange(Rooms."Hostel Code", "Hostel No");
                Rooms.SetRange(Rooms."Room Code", "Room No");
                if Rooms.Find('-') then begin
                    if settlementType = Settlementtype::"Special Programme" then
                        billAmount := Rooms."Special Programme"
                    else if settlementType = Settlementtype::JAB then
                        billAmount := Rooms."JAB Fees"
                    else if settlementType = Settlementtype::SSP then
                        billAmount := Rooms."SSP Fees"
                end;

                if billAmount > 0 then Charges := billAmount;
            end;
        }
        field(50015; "Switched to Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No" where(Gender = field(Gender));
        }
        field(50016; "Switched to Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Block Rooms"."Room Code" where("Hostel Code" = field("Switched to Hostel No"),
                                                                        Status = filter("Fully Occupied" | "Partially Occupied"));
        }
        field(50017; "Switched to Space No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Room Spaces"."Space Code" where("Hostel Code" = field("Switched to Hostel No"),
                                                                  "Room Code" = field("Switched to Room No"),
                                                                  Status = filter("Fully Occupied"));

            trigger OnValidate()
            begin
                Clear(settlementType);
                courseReg.Reset;
                courseReg.SetRange(courseReg."Student No.", Student);
                courseReg.SetRange(courseReg.Semester, Semester);
                //  courseReg.SETRANGE(courseReg."Academic Year","Academic Year");
                if courseReg.Find('-') then begin
                    if prog.Get(courseReg.Programme) then begin
                        if prog."Special Programme" then
                            settlementType := Settlementtype::"Special Programme"
                        else if courseReg."Settlement Type" = 'JAB' then
                            settlementType := Settlementtype::JAB
                        else if courseReg."Settlement Type" = 'SSP' then settlementType := Settlementtype::SSP;
                    end;
                end;
                Clear(billAmount);
                Rooms.Reset;
                Rooms.SetRange(Rooms."Hostel Code", "Hostel No");
                Rooms.SetRange(Rooms."Room Code", "Room No");
                if Rooms.Find('-') then begin
                    if settlementType = Settlementtype::"Special Programme" then
                        billAmount := Rooms."Special Programme"
                    else if settlementType = Settlementtype::JAB then
                        billAmount := Rooms."JAB Fees"
                    else if settlementType = Settlementtype::SSP then
                        billAmount := Rooms."SSP Fees"
                end;

                if billAmount > 0 then Charges := billAmount;
            end;
        }
        field(50018; "Transfed from Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No" where("JAB Fees" = filter(4.000),
                                                                "SSP Fees" = filter(8.000),
                                                                Gender = field(Gender));
        }
        field(50019; "Transfed from Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Block Rooms"."Room Code" where("Hostel Code" = field("Transfer to Hostel No"),
                                                                        Status = filter(Vaccant | "Partially Occupied"));
        }
        field(50020; "Transfed from Space No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Room Spaces"."Space Code" where("Hostel Code" = field("Transfer to Hostel No"),
                                                                  "Room Code" = field("Transfer to Room No"),
                                                                  Status = filter(Vaccant));

            trigger OnValidate()
            begin
                Clear(settlementType);
                courseReg.Reset;
                courseReg.SetRange(courseReg."Student No.", Student);
                courseReg.SetRange(courseReg.Semester, Semester);
                //  courseReg.SETRANGE(courseReg."Academic Year","Academic Year");
                if courseReg.Find('-') then begin
                    if prog.Get(courseReg.Programme) then begin
                        if prog."Special Programme" then
                            settlementType := Settlementtype::"Special Programme"
                        else if courseReg."Settlement Type" = 'JAB' then
                            settlementType := Settlementtype::JAB
                        else if courseReg."Settlement Type" = 'SSP' then settlementType := Settlementtype::SSP;
                    end;
                end;
                Clear(billAmount);
                Rooms.Reset;
                Rooms.SetRange(Rooms."Hostel Code", "Hostel No");
                Rooms.SetRange(Rooms."Room Code", "Room No");
                if Rooms.Find('-') then begin
                    if settlementType = Settlementtype::"Special Programme" then
                        billAmount := Rooms."Special Programme"
                    else if settlementType = Settlementtype::JAB then
                        billAmount := Rooms."JAB Fees"
                    else if settlementType = Settlementtype::SSP then
                        billAmount := Rooms."SSP Fees"
                end;

                if billAmount > 0 then Charges := billAmount;
            end;
        }
        field(50021; Status; Option)
        {
            OptionCaption = 'Booking,Allocated';
            OptionMembers = Booking,Allocated;
        }
        field(50022; "Invoice Printed"; Boolean)
        {
        }
        field(50026; "Invoice Printed By"; Code[20])
        {
        }
        field(50027; "Swithed By"; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                //"Swithed By":=USERID;
            end;
        }
        field(50028; "Transfered By"; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                //"Transfered By":=USERID;
            end;
        }
        field(50029; "Reverse Allocated By"; Code[20])
        {
        }
        field(50030; "Key Allocated"; Boolean)
        {
        }
        field(50031; "Key No"; Code[10])
        {
        }
        field(50032; "Allocated By"; Code[30])
        {
        }
        field(50033; "Time allocated"; Time)
        {
        }
        field(50034; "Time Reversed"; Time)
        {
        }
        field(50035; "Time Transfered"; Time)
        {
        }
        field(50036; "Time Swithed"; Time)
        {
        }
        field(50037; "Date Reversed"; Date)
        {
        }
        field(50038; "Date Transfered"; Date)
        {
        }
        field(50039; "Date Switched"; Date)
        {
        }
        field(50040; "Key Allocated By"; Code[30])
        {
        }
        field(50041; "Key Allocated Time"; Time)
        {
        }
        field(50042; "Key Allocated Date"; Date)
        {
        }
        field(50044; "Reversed By"; Code[100])
        {
        }
        field(50045; "Switched By"; Code[100])
        {
        }
        field(50046; "Start Date"; Date)
        {
            CalcFormula = lookup("ACA-Course Registration"."Registration Date" where("Student No." = field(Student),
                                                                                      Semester = field(Semester)));
            FieldClass = FlowField;
        }
        field(50047; "End Date"; Date)
        {
            CalcFormula = lookup("ACA-Academic Year Schedule"."End Date" where(Semester = field(Semester)));
            FieldClass = FlowField;
        }
        field(50048; "Settlement Type"; Code[10])
        {
            CalcFormula = lookup("ACA-Course Registration"."Settlement Type" where("Student No." = field(Student),
                                                                                    Semester = field(Semester)));
            FieldClass = FlowField;
        }
        field(50049; "Campus Code"; Code[20])
        {
            CalcFormula = lookup(Customer."Global Dimension 1 Code" where("No." = field(Student)));
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(50050; Valid; Boolean)
        {
            CalcFormula = exist("ACA-Hostel Ledger" where("Hostel No" = field("Hostel No"),
                                                           "Room No" = field("Room No"),
                                                           "Space No" = field("Space No"),
                                                           "Student No" = field(Student),
                                                           Semester = field(Semester)));
            FieldClass = FlowField;
        }
        field(50051; "Reason for transfer"; Code[100])
        {
        }
        field(50052; "Reason for Switch"; Code[100])
        {
        }
        field(50053; "Student Exists"; Boolean)
        {
            CalcFormula = exist(Customer where("No." = field(Student)));
            FieldClass = FlowField;
        }
        field(50054; "Student Counts"; Integer)
        {
            CalcFormula = count("ACA-Students Hostel Rooms" where(Semester = field(Semester),
                                                                   "Academic Year" = field("Academic Year"),
                                                                   Student = field(Student)));
            FieldClass = FlowField;
        }
        field(50055; "Registered For Current Academi"; Boolean)
        {
            CalcFormula = exist("ACA-Course Registration" where("Student No." = field(Student),
                                                                 Semester = field(Semester)));
            FieldClass = FlowField;
        }
        field(50056; Imported; Boolean)
        {
        }
        field(50057; Invoiced; Boolean)
        {
        }
        field(50058; "Old Student No."; Code[25])
        {
            CalcFormula = lookup(Customer."Old Student Code" where("No." = field(Student)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Student, "Line No")
        {
            Clustered = true;
        }
        key(Key2; "Hostel No")
        {
        }
        key(Key3; "Line No")
        {
        }
        key(Key4; "Allocation Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        // validateModification();
        if Rec.Allocated then Error('Access denied! Transaction is already posted!');
    end;

    trigger OnInsert()
    var
        Hostel_Rooms: Record "ACA-Hostel Block Rooms";
        Host_Ledger: Record "ACA-Hostel Ledger";
        Hostel_Rooms2: Record "ACA-Hostel Block Rooms";
        counts: Integer;
        Custs: Record Customer;
        LedgVal: Integer;
        ACAStudentsHostelRooms: Record "ACA-Students Hostel Rooms";
        MailBody: Text;
        PgHostelRooms: Page "ACA-Stud. Hostel Rooms";
        settlementType: Option " ",JAB,SSP,"Special Programme";
        Creg1: Record UnknownRecord61532;
        prog: Record UnknownRecord61511;
        RptFilename: Text;
    begin

        Clear(Custs);
        Custs.Reset;
        Custs.SetRange("No.");
        if Custs.Find('-') then begin

        end else begin
            Error('Invalid Student No.: ' + Format(Student));
        end;
        if Imported = false then begin
            "Transfered By" := UserId;
            "Switched By" := UserId;
            "Swithed By" := UserId;
            AcadYear.Reset;
            AcadYear.SetRange(AcadYear.Current, true);
            if AcadYear.Find('-') then begin
                Sem.Reset;
                Sem.SetRange(Sem."Current Semester", true);
                if Sem.Find('-') then begin
                    courseReg.Reset;
                    courseReg.SetRange(courseReg."Student No.", Student);
                    //  courseReg.SETRANGE(courseReg."Academic Year",AcadYear.Code);
                    courseReg.SetRange(courseReg.Semester, Sem.Code);
                    if not (courseReg.Find('-')) then Error('The student has not been registered for the current Academic Year.');
                    "Academic Year" := AcadYear.Code;
                    Semester := Sem.Code;
                    // Pick Accommondation fees and the student balance.
                    if cust.Get(Student) then begin
                        cust.CalcFields(cust."Balance (LCY)");
                        Balance := cust."Balance (LCY)";
                    end;
                    stageCharges.Reset;
                    stageCharges.SetRange(stageCharges."Programme Code", courseReg.Programme);
                    stageCharges.SetRange(stageCharges."Stage Code", courseReg.Stage);
                    stageCharges.SetRange(stageCharges."Settlement Type", courseReg."Settlement Type");
                    stageCharges.SetRange(stageCharges.Code, 'ACCOMMODATION');
                    if stageCharges.Find('-') then begin
                        //  Charges:=stageCharges.Amount;
                        // Billed:=stageCharges.Amount;
                        if cust."Balance (LCY)" < 0 then begin
                            "Over Paid" := true;
                            "Over Paid Amt" := cust."Balance (LCY)" - stageCharges.Amount;
                        end;

                    end;// ELSE ERROR('Accommodation missing in the fee setup for: Prog:-'+courseReg.Programme+' Stage:- '+courseReg.Stage+' Type:- '+courseReg."Settlement Type");
                        //  IF courseReg."Settlement Type"='JAB' THEN Charges:=4000;
                        //  IF courseReg."Settlement Type"='SSP' THEN Charges:=8000;
                end else
                    Error('The Current Semester has not been set.\Consult the system administrator.');
            end else
                Error('The Current academic year has not been set.');
        end else begin
            Clear(counts);
            if (Student <> '') and ("Room No" <> '') and ("Space No" <> '') then begin
                if Custs.Gender = Custs.Gender::Male then begin
                    Gender := Gender::Male;
                end else if Custs.Gender = Custs.Gender::Male then begin
                    Gender := Gender::Female;
                end;
                Charges := Rec.Charges;
                Clear(ACAStudentsHostelRooms);
                ACAStudentsHostelRooms.Reset;
                if ACAStudentsHostelRooms.Find('+') then;
                Clear(LedgVal);
                LedgVal := ACAStudentsHostelRooms."Line No";
                LedgVal := LedgVal + 1;
                "Line No" := LedgVal;
                // Post to  the Ledger Tables
                Host_Ledger.Reset;
                if Host_Ledger.Find('-') then counts := Host_Ledger.Count;
                Host_Ledger.Init;
                Host_Ledger."Space No" := "Space No";
                Host_Ledger."Room No" := "Room No";
                Host_Ledger."Hostel No" := "Hostel No";
                Host_Ledger.No := counts;
                Host_Ledger.Status := Host_Ledger.Status::"Fully Occupied";
                Host_Ledger."Room Cost" := Charges;
                Host_Ledger."Student No" := Student;
                Host_Ledger."Receipt No" := '';
                Host_Ledger.Semester := Semester;
                Host_Ledger.Gender := Gender;
                Host_Ledger."Hostel Name" := '';
                Host_Ledger.Campus := cust."Global Dimension 1 Code";
                Host_Ledger."Academic Year" := "Academic Year";
                Host_Ledger.Insert(true);


                Hostel_Rooms.Reset;
                Hostel_Rooms.SetRange(Hostel_Rooms."Hostel Code", "Hostel No");
                Hostel_Rooms.SetRange(Hostel_Rooms."Room Code", "Room No");
                if Hostel_Rooms.Find('-') then begin
                    Hostel_Rooms.CalcFields(Hostel_Rooms."Bed Spaces", Hostel_Rooms."Occupied Spaces");
                    if Hostel_Rooms."Bed Spaces" = Hostel_Rooms."Occupied Spaces" then
                        Hostel_Rooms.Status := Hostel_Rooms.Status::"Fully Occupied"
                    else if Hostel_Rooms."Occupied Spaces" < Hostel_Rooms."Bed Spaces" then
                        Hostel_Rooms.Status := Hostel_Rooms.Status::"Partially Occupied";
                    Hostel_Rooms.Modify;
                end;




            end;
            ///create sales invoice
            if not Invoiced then begin
                //fnCreateHostelSalesInvoice(Rec);
                Creg1.Reset;
                Creg1.SetRange(Creg1."Student No.", Student);
                Creg1.SetRange(Creg1.Semester, Semester);
                //  Creg1.SETRANGE(Creg1."Academic Year","Academic Year");
                if Creg1.Find('-') then begin
                    // Check if Prog is Special
                    if prog.Get(Creg1.Programme) then begin
                        if prog."Special Programme" then
                            settlementType := Settlementtype::"Special Programme"
                        else if Creg1."Settlement Type" = 'KUCCPS' then
                            settlementType := Settlementtype::JAB
                        else if Creg1."Settlement Type" = 'PSSP' then settlementType := Settlementtype::SSP;
                        //       ELSE
                        //        IF Creg1."Settlement Type"='NFM' THEN settlementType
                    end;

                end;
                PgHostelRooms.SetRecord(Rec);
                PgHostelRooms.BookRoom(settlementType);
                Invoiced := true;
            end;
            CoreBankingDetails.Reset;
            CoreBankingDetails.SetRange(CoreBankingDetails."Pesa Flow Stud. Ref.", Student);
            if CoreBankingDetails.FindFirst then begin
                CoreBankingDetails.PostReceiptsFromBuffer(CoreBankingDetails);
            end;
            //END;
            Billed := true;
            "Billed Date" := Today;
            "Allocation Date" := Today;
            Allocated := true;
            "Allocated By" := UserId;
            "Time allocated" := Time;

            //if no errorss send communication
            Commit();
            /*
            BEGIN
            cust.RESET;
            cust.SETRANGE("No.",Rec.Student);
            IF cust.FINDFIRST THEN BEGIN
              cust.TESTFIELD("E-Mail");
              MailBody:='This is to notify you that you have been allocated accommodation at the university. '+
        'You have been allocated Block '+"Hostel No"+', Room no: '+"Room No"+', Space: '+"Space No"+
        'Kindly collect the keys and other items from the Hostel manager on the reporting day. Fill the attached form and present it to the hostel manager';
        RptFilename:='D:\'+'Room Agreement_'+DELCHR(Student,'=','/')+'.pdf';
        
        IF EXISTS(RptFilename) THEN
          ERASE(RptFilename);
        REPORT.SAVEASPDF(REPORT::"Resident Room Agreement",RptFilename,cust);
              SendMail.SendEmailEasy_WithAttachment('Dear ',cust.Name,MailBody,'','Karatina University','Hostel Manager',cust."E-Mail",'HOSTEL ALLOCATION BLOCK',RptFilename,RptFilename);
        IF EXISTS(RptFilename) THEN
          ERASE(RptFilename);
              END;
            END;
            */
            //check if ledger is inserted
            Host_Ledger.Reset;
            Host_Ledger.SetRange("Student No", Student);
            Host_Ledger.SetRange("Space No", "Space No");
            Host_Ledger.SetRange("Room No", "Room No");
            Host_Ledger.SetRange("Hostel No", "Hostel No");
            if not Host_Ledger.FindFirst then begin
                Host_Ledger.Init;
                Host_Ledger."Space No" := "Space No";
                Host_Ledger."Room No" := "Room No";
                Host_Ledger."Hostel No" := "Hostel No";
                Host_Ledger.No := counts;
                Host_Ledger.Status := Host_Ledger.Status::"Fully Occupied";
                Host_Ledger."Room Cost" := Charges;
                Host_Ledger."Student No" := Student;
                Host_Ledger."Receipt No" := '';
                Host_Ledger.Semester := Semester;
                Host_Ledger.Gender := Gender;
                Host_Ledger."Hostel Name" := '';
                Host_Ledger.Campus := cust."Global Dimension 1 Code";
                Host_Ledger."Academic Year" := "Academic Year";
                Host_Ledger.Insert(true);
            end;
        end;

    end;

    var
        courseReg: Record UnknownRecord61532;
        AcadYear: Record UnknownRecord61382;
        Sem: Record UnknownRecord61692;
        stageCharges: Record UnknownRecord61533;
        cust: Record Customer;
        roomSpaces: Record UnknownRecord61824;
        Rooms: Record "ACA-Hostel Block Rooms";
        prog: Record UnknownRecord61511;
        settlementType: Option " ",JAB,SSP,"Special Programme";
        billAmount: Decimal;
        HostRec: Record "ACA-Hostel Card";
        hstR: Record "ACA-Students Hostel Rooms";
        ACAHostelLedger: Record "ACA-Hostel Ledger";
        SendMail: Codeunit webportals;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CoreBankingDetails: Record Core_Banking_Details;

    local procedure validateModification()
    begin
        if ((Allocated)) then begin
            ACAHostelLedger.Reset;
            ACAHostelLedger.SetRange("Space No", Rec."Space No");
            ACAHostelLedger.SetRange("Room No", Rec."Room No");
            ACAHostelLedger.SetRange("Hostel No", Rec."Hostel No");
            if ACAHostelLedger.Find('-') then
                Error('Deletion/Modification of allocated Record is not allowed');
        end;
    end;

    local procedure fnCreateHostelSalesInvoice(var HostelRooms: Record "ACA-Students Hostel Rooms")
    var
        Kastoma: Record Customer;
    begin
        Kastoma.Reset;
        Kastoma.SetRange("No.", HostelRooms.Student);
        if Kastoma.FindFirst then begin
            if Kastoma."Gen. Bus. Posting Group" = '' then begin
                Kastoma."Gen. Bus. Posting Group" := 'LOCAL';
                Kastoma.Modify();
            end;
        end;

        SalesHeader.Init;
        SalesHeader."Document Type" := SalesHeader."document type"::Invoice;

        SalesHeader."No." := '';
        SalesHeader."Document Date" := Today();
        SalesHeader."Sell-to Customer No." := HostelRooms.Student;
        SalesHeader.Validate("Sell-to Customer No.");
        if SalesHeader.Insert(true) then begin
            SalesLine.Init;
            SalesLine."Document Type" := SalesLine."document type"::Invoice;
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine.Validate("Document No.");
            SalesLine.Type := 1;
            SalesLine.Validate(Type);
            SalesLine."No." := '60055';
            SalesLine.Validate("No.");
            SalesLine."Line No." := 10000;
            SalesLine.Quantity := 1;
            SalesLine.Validate(Quantity);
            SalesLine."Unit Price" := HostelRooms.Charges;
            SalesLine.Validate("Unit Price");
            SalesLine."Line Amount" := HostelRooms.Charges;
            SalesLine.Validate("Line Amount");
            SalesLine.Type := 1;
            SalesLine.Insert(true);
            HostelRooms.Invoiced := true;

        end;
    end;


    procedure fnReceipt()
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        // GenJournalLine.Init;
        //        GenJournalLine."Journal Template Name" := 'PAYMENT';
        //        GenJournalLine."Journal Batch Name" := 'RECEIPT';
        //        GenJournalLine."Document No." := ;
        //        GenJournalLine."Line No." := 1000;
        //        GenJournalLine."Account Type" := AccountType;
        //        GenJournalLine."Account No." := AccountNo;
        //        GenJournalLine.Validate(GenJournalLine."Account No.");
        //        GenJournalLine."Posting Date" := TransactionDate;
        //        GenJournalLine.Description := CopyStr(TransactionDescription, 1, 100);
        //        GenJournalLine.Validate(GenJournalLine."Currency Code");
        //        GenJournalLine.Amount := TransactionAmount;
        //        GenJournalLine."External Document No." := ExternalDocumentNo;
        //        GenJournalLine.Validate(GenJournalLine.Amount);
        //        GenJournalLine."Shortcut Dimension 1 Code" := DimensionOne;
        //        GenJournalLine."Shortcut Dimension 2 Code" := DimensionTwo;
        //        GenJournalLine."Currency Code" := CurrencyCode;
        //        GenJournalLine.Validate("Currency Code");
        //        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        //        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        //
        //        if GenJournalLine.Amount <> 0 then
        //            GenJournalLine.Insert;
    end;
}

