#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 77341 "ACA-Batch Room Alloc. Details"
{

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
        }
        field(2; "Hostel Block"; Code[20])
        {
        }
        field(3; "Imported By"; Code[20])
        {
        }
        field(4; "Date Imported"; Date)
        {
        }
        field(5; "Time Imported"; Time)
        {
        }
        field(6; "Student No."; Code[20])
        {

            trigger OnValidate()
            begin

                Clear(Customer);
                Customer.Reset;
                Customer.SetRange("No.", Rec."Student No.");
                if Customer.Find('-') then begin
                    Rec."Student Name" := Customer.Name;
                    Rec."Phone Number" := Customer."Phone No.";
                    Rec."Email Address" := Customer."E-Mail";
                end else begin
                    // Check  in KUCCPS Impirts
                    Clear(KUCCPSImports);
                    KUCCPSImports.Reset;
                    KUCCPSImports.SetRange(Admin, Rec."Student No.");
                    if KUCCPSImports.Find('-') then begin
                        // Strudent is in  Kuccps Imptorts
                        Rec."Student Name" := KUCCPSImports.Names;
                        Rec."Phone Number" := KUCCPSImports.Phone;
                        Rec."Email Address" := KUCCPSImports.Email;
                    end;
                end;
            end;
        }
        field(7; "Student Name"; Text[150])
        {
        }
        field(8; "Room No"; Code[20])
        {
        }
        field(9; "Room Space"; Code[20])
        {
        }
        field(10; "Notification Send"; Boolean)
        {
        }
        field(11; "posted to Hostels?"; Boolean)
        {
        }
        field(12; "Room Cost"; Decimal)
        {
        }
        field(13; "Phone Number"; Text[50])
        {
        }
        field(14; "Email Address"; Text[150])
        {
        }
        field(15; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(16; Selected; Boolean)
        {

            trigger OnValidate()
            begin
                if Rec.Selected = true then begin
                    Clear(ACABatchRoomAllocDetails);
                    ACABatchRoomAllocDetails.Reset;
                    ACABatchRoomAllocDetails.SetRange("Academic Year", Rec."Academic Year");
                    ACABatchRoomAllocDetails.SetRange("Student No.", Rec."Student No.");
                    if ACABatchRoomAllocDetails.Find('-') then begin
                        ACABatchRoomAllocDetails.CalcFields("Exists in Student List", Credits);
                        if ACABatchRoomAllocDetails."Exists in Student List" = false then Error('Invalid student!');
                        if ACABatchRoomAllocDetails.Credits < 6500 then Error('No hostel payments available');
                    end;
                end;
            end;
        }
        field(17; "Posted By"; Code[20])
        {
        }
        field(18; "Posted Date"; Date)
        {
        }
        field(19; "Posted Time"; Time)
        {
        }
        field(20; "Exists in Student List"; Boolean)
        {
            CalcFormula = exist(Customer where("No." = field("Student No.")));
            FieldClass = FlowField;
        }
        field(21; Credits; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Credit Amount" where("Customer No." = field("Student No.")));
            FieldClass = FlowField;
        }
        field(22; "Temp. Allocation Billed"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Academic Year", "Student No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ACAArchRoomAllocDetails: Record "ACA-Arch. Room Alloc. Details";
        UserSetup: Record "User Setup";
    begin
        Clear(UserSetup);
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if not (UserSetup.Find('-')) then Error('Access Denied!');
        UserSetup.TestField("Can Archive Prof. Host. Allocs");

        ACAArchRoomAllocDetails.Init;
        ACAArchRoomAllocDetails."Academic Year" := Rec."Academic Year";
        ACAArchRoomAllocDetails."Hostel Block" := Rec."Hostel Block";
        ACAArchRoomAllocDetails."Imported By" := Rec."Imported By";
        ACAArchRoomAllocDetails."Date Imported" := Rec."Date Imported";
        ACAArchRoomAllocDetails."Time Imported" := Rec."Time Imported";
        ACAArchRoomAllocDetails."Student No." := Rec."Student No.";
        ACAArchRoomAllocDetails."Student Name" := Rec."Student Name";
        ACAArchRoomAllocDetails."Room No" := Rec."Room No";
        ACAArchRoomAllocDetails."Room Space" := Rec."Room Space";
        ACAArchRoomAllocDetails."Notification Send" := Rec."Notification Send";
        ACAArchRoomAllocDetails."posted to Hostels?" := Rec."posted to Hostels?";
        ACAArchRoomAllocDetails."Room Cost" := Rec."Room Cost";
        ACAArchRoomAllocDetails."Phone Number" := Rec."Phone Number";
        ACAArchRoomAllocDetails."Email Address" := Rec."Email Address";
        ACAArchRoomAllocDetails.Gender := Rec.Gender;
        ACAArchRoomAllocDetails.Selected := Rec.Selected;
        ACAArchRoomAllocDetails."Posted By" := Rec."Posted By";
        ACAArchRoomAllocDetails."Posted Date" := Rec."Posted Date";
        ACAArchRoomAllocDetails."Posted Time" := Rec."Posted Time";
        ACAArchRoomAllocDetails."Exists in Student List" := Rec."Exists in Student List";
        ACAArchRoomAllocDetails.Credits := Rec.Credits;
        ACAArchRoomAllocDetails.Insert(true);
    end;

    trigger OnInsert()
    begin
        if Rec."Hostel Block" = '' then Error('Specify the Hostel Block');
        if Rec."Room No" = '' then Error('Specify the Hostel Room');
        if Rec."Room Space" = '' then Error('Specify the Hostel Room Space');
        if Rec."Academic Year" = '' then Error('Specify the Academic Year');
        Clear(ACAHostelBlockRooms);
        ACAHostelBlockRooms.Reset;
        ACAHostelBlockRooms.SetRange("Room Code", Rec."Room No");
        if ACAHostelBlockRooms.Find('-') then begin
            Rec."Room Cost" := ACAHostelBlockRooms."Room Cost";
        end;
        "Imported By" := UserId;
        "Date Imported" := Today;
        "Time Imported" := Time;
        Clear(Customer);
        Customer.Reset;
        Customer.SetRange("No.", Rec."Student No.");
        if Customer.Find('-') then begin
            Rec."Student Name" := Customer.Name;
            Rec."Phone Number" := Customer."Phone No.";
            Rec."Email Address" := Customer."E-Mail";
        end else begin
            // Check  in KUCCPS Impirts
            Clear(KUCCPSImports);
            KUCCPSImports.Reset;
            KUCCPSImports.SetRange(Admin, Rec."Student No.");
            if KUCCPSImports.Find('-') then begin
                // Strudent is in  Kuccps Imptorts
                Rec."Student Name" := KUCCPSImports.Names;
                Rec."Phone Number" := KUCCPSImports.Phone;
                Rec."Email Address" := KUCCPSImports.Email;
            end;
        end;
        // Create Header Here
        ACABatchRoomAllocHeader.Init;
        ACABatchRoomAllocHeader."Hostel Block" := Rec."Hostel Block";
        ACABatchRoomAllocHeader."Academic Year" := Rec."Academic Year";
        ACABatchRoomAllocHeader."Created By" := UserId;
        ACABatchRoomAllocHeader."Date Created" := Today;
        ACABatchRoomAllocHeader."Time Created" := Time;
        if ACABatchRoomAllocHeader.Insert then;
    end;

    trigger OnModify()
    begin
        if Rec."posted to Hostels?" = true then Error('Posted allocations can not be deleted!');
    end;

    var
        ACAHostelBlockRooms: Record "ACA-Hostel Block Rooms";
        Customer: Record Customer;
        KUCCPSImports: Record "KUCCPS Imports";
        ACABatchRoomAllocHeader: Record "ACA-Batch Room Alloc. Header";
        ACABatchRoomAllocDetails: Record "ACA-Batch Room Alloc. Details";
        GenJournalBatch: Record "Gen. Journal Batch";


    procedure AllocateStudentHostel(BufferAllocations: Record "ACA-Batch Room Alloc. Details")
    var
        ACAStudentsHostelRooms: Record "ACA-Students Hostel Rooms";
        ACAStudentsHostelRooms12: Record "ACA-Students Hostel Rooms";
        userst: Record "User Setup";
        AccPayment: Boolean;
        hostStus: Record "ACA-Students Hostel Rooms";
        charges1: Record "ACA-Charge";
        cou: Integer;
        studRoomBlock: Record "ACA-Students Hostel Rooms";
        Blocks: Record "ACA-Hostel Card";
        coReg: Record "ACA-Course Registration";
        HostelLedger: Record "ACA-Hostel Ledger";
        Sem: Record "ACA-Semesters";
        Registered: Boolean;
        acadYear: Record "ACA-Academic Year";
        semz: Record "ACA-Semesters";
        PictureExists: Boolean;
        StudentPayments: Record "ACA-Std Payments";
        StudentCharge: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        ChargesRec: Record "ACA-Charge";
        PaidAmt: Decimal;
        Receipt: Record "ACA-Receipt";
        NoRoom: Integer;
        ReceiptItems: Record "ACA-Receipt Items";
        "GenSetUp.": Record "ACA-General Set-Up";
        StudentCharges2: Record "ACA-Std Charges";
        CourseReg: Record "ACA-Course Registration";
        CurrentBill: Decimal;
        GLEntry: Record "G/L Entry";
        CustLed: Record "Cust. Ledger Entry";
        BankLedg: Record "Bank Account Ledger Entry";
        DCustLedg: Record "Detailed Cust. Ledg. Entry";
        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record "Vendor Ledger Entry";
        DVendLedg: Record "Detailed Vendor Ledg. Entry";
        NoSeries: Record "No. Series Line";
        VATEntry: Record "VAT Entry";
        CReg: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        LastNo: Code[20];
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        ChangeLog: Record "Change Log Entry";
        StudentHostel: Record "ACA-Students Hostel Rooms";
        StudentCharges: Record "ACA-Std Charges";
        GenSetUp: Record "ACA-General Set-Up";
        Rooms_Spaces: Record "ACA-Room Spaces";
        Hostel_Rooms: Record "ACA-Hostel Block Rooms";
        Host_Ledger: Record "ACA-Hostel Ledger";
        counts: Integer;
        hostcard: Record "ACA-Hostel Card";
        studItemInv: Record "ACA-Std Hostel Inventory Items";
        invItems: Record "ACA-Hostel Inventory";
        Hostel_Rooms2: Record "ACA-Hostel Block Rooms";
        settlementType: Option " ",JAB,SSP,"Special Programme";
        Creg1: Record "ACA-Course Registration";
        prog: Record "ACA-Programme";
        allocations: Record "ACA-Students Hostel Rooms";
        "Settlement Type": Record "ACA-Settlement Type";
        ACAHostelBasicSetups: Record "ACA-Hostel Basic Setups";
    begin
        //Check the Policy

        Clear(ACAHostelBasicSetups);
        ACAHostelBasicSetups.Reset;
        if ACAHostelBasicSetups.Find('-') then begin
            ACAHostelBasicSetups.TestField("Current Semester");
            ACAHostelBasicSetups.TestField("Current Academic Year");
        end else
            Error('The hostel basic setups are missing');
        semz.Reset;
        semz.SetRange(semz.Code, ACAHostelBasicSetups."Current Semester");
        if semz.Find('-') then begin
        end else
            Error('Invalid semester!');
        ACAStudentsHostelRooms.Init;
        ACAStudentsHostelRooms.Student := BufferAllocations."Student No.";
        ACAStudentsHostelRooms."Space No" := BufferAllocations."Room Space";
        ACAStudentsHostelRooms."Room No" := BufferAllocations."Room No";
        ACAStudentsHostelRooms."Hostel No" := BufferAllocations."Hostel Block";
        ACAStudentsHostelRooms."Academic Year" := semz."Academic Year";
        ACAStudentsHostelRooms.Semester := semz.Code;
        ACAStudentsHostelRooms.Insert;
        Clear(ACAStudentsHostelRooms12);
        ACAStudentsHostelRooms12.Reset;
        ACAStudentsHostelRooms12.SetRange(Student, BufferAllocations."Student No.");
        ACAStudentsHostelRooms12.SetRange("Space No", BufferAllocations."Room Space");
        ACAStudentsHostelRooms12.SetRange("Room No", BufferAllocations."Room No");
        ACAStudentsHostelRooms12.SetRange("Hostel No", BufferAllocations."Hostel Block");
        ACAStudentsHostelRooms12.SetRange("Academic Year", semz."Academic Year");
        ACAStudentsHostelRooms12.SetRange(Semester, semz.Code);
        if ACAStudentsHostelRooms12.Find('-') then begin
            with ACAStudentsHostelRooms12 do begin
                if BufferAllocations."Room Space" = '' then exit;
                TestField(Allocated, false);
                if Cust.Get(Student) then begin
                    Cust.CalcFields(Cust.Balance);
                    CReg.Reset;
                    CReg.SetRange(CReg."Student No.", Cust."No.");
                    if semz.Find('-') then
                        CReg.SetRange(CReg.Semester, semz.Code);
                    CReg.SetRange(CReg.Posted, true);
                    if CReg.Find('-') then begin  //2
                        CReg.CalcFields(CReg."Total Billed");
                        if CReg."Total Billed" <> 0 then begin  // 1
                            allocations.Reset;
                            allocations.SetRange(allocations.Student, Cust."No.");
                            allocations.SetRange(allocations."Hostel No", Cust."Hostel No.");
                            allocations.SetRange(allocations."Room No", Cust."Room Code");
                            allocations.SetRange(allocations."Space No", Cust."Space Booked");
                            //allocations.SETRANGE(allocations."Academic Year","Academic Year");
                            allocations.SetRange(allocations.Semester, Cust.Semester);
                            // IF Allocations.FIND('-') THEN
                            // REPORT.RUN(52017900,TRUE,FALSE,Allocations);
                        end else begin  //1
                                        //ERROR('Fees payment Accommodation policy error --Billing');
                        end; //1
                    end else begin //2
                        if Cust.Balance > 0 then
                            Error('Fees payment Accommodation policy error --Registration');
                    end; //rec.2
                end;

                if Cust."Hostel Black Listed" = false then begin
                    // IF CONFIRM('Allocate the Specified Room?', TRUE)=FALSE THEN ERROR('Cancelled by user!');
                    Creg1.Reset;
                    Creg1.SetRange(Creg1."Student No.", Student);
                    Creg1.SetRange(Creg1.Semester, Semester);
                    //  Creg1.SETRANGE(Creg1."Academic Year","Academic Year");
                    if Creg1.Find('-') then begin
                        // Check if Prog is Special
                        if prog.Get(Creg1.Programmes) then begin
                            if prog."Special Programme" then
                                settlementType := Settlementtype::"Special Programme"
                            else if Creg1."Settlement Type" = 'PSSP' then
                                settlementType := Settlementtype::SSP
                            else
                                settlementType := Settlementtype::JAB;
                        end;

                    end;

                    BookRoom(settlementType, ACAStudentsHostelRooms12);
                    // Assign Items
                    hostcard.Reset;
                    hostcard.SetRange(hostcard."Asset No", "Hostel No");
                    if hostcard.Find('-') then begin
                        invItems.Reset;
                        if hostcard.Gender = hostcard.Gender::Male then
                            invItems.SetFilter(invItems."Hostel Gender", '%1|%2', 1, 2);
                        if invItems.Find('-') then begin
                            studItemInv.Reset;
                            studItemInv.SetRange(studItemInv."Student No.", Student);
                            studItemInv.SetRange(studItemInv.Semester, Semester);
                            if studItemInv.Find('-') then studItemInv.DeleteAll;
                            repeat
                            begin
                                studItemInv.Init;
                                studItemInv."Hostel Block" := "Hostel No";
                                studItemInv."Room Code" := "Room No";
                                studItemInv."Space Code" := "Space No";
                                studItemInv."Item Code" := invItems.Item;
                                studItemInv."Academic Year" := "Academic Year";
                                studItemInv.Semester := Semester;
                                studItemInv.Quantity := invItems."Quantity Per Room";
                                studItemInv."Fine Amount" := invItems."Fine Amount";
                                studItemInv.Insert(true);
                            end;
                            until invItems.Next = 0;
                        end;
                    end;
                end;
            end;
        end;
    end;


    procedure BookRoom(settle_m: Option " ",JAB,SSP,"Special Programme"; ACAStudentsHostelRooms: Record "ACA-Students Hostel Rooms")
    var
        rooms: Record "ACA-Hostel Block Rooms";
        billAmount: Decimal;
        ACAStudentsHostelRooms12: Record "ACA-Students Hostel Rooms";
        userst: Record "User Setup";
        AccPayment: Boolean;
        hostStus: Record "ACA-Students Hostel Rooms";
        charges1: Record "ACA-Charge";
        cou: Integer;
        studRoomBlock: Record "ACA-Students Hostel Rooms";
        Blocks: Record "ACA-Hostel Card";
        coReg: Record "ACA-Course Registration";
        HostelLedger: Record "ACA-Hostel Ledger";
        Sem: Record "ACA-Semesters";
        Registered: Boolean;
        acadYear: Record "ACA-Academic Year";
        semz: Record "ACA-Semesters";
        PictureExists: Boolean;
        StudentPayments: Record "ACA-Std Payments";
        StudentCharge: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        ChargesRec: Record "ACA-Charge";
        PaidAmt: Decimal;
        Receipt: Record "ACA-Receipt";
        NoRoom: Integer;
        ReceiptItems: Record "ACA-Receipt Items";
        "GenSetUp.": Record "ACA-General Set-Up";
        StudentCharges2: Record "ACA-Std Charges";
        CourseReg: Record "ACA-Course Registration";
        CurrentBill: Decimal;
        GLEntry: Record "G/L Entry";
        CustLed: Record "Cust. Ledger Entry";
        BankLedg: Record "Bank Account Ledger Entry";
        DCustLedg: Record "Detailed Cust. Ledg. Entry";
        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record "Vendor Ledger Entry";
        DVendLedg: Record "Detailed Vendor Ledg. Entry";
        NoSeries: Record "No. Series Line";
        VATEntry: Record "VAT Entry";
        CReg: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        LastNo: Code[20];
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        ChangeLog: Record "Change Log Entry";
        StudentHostel: Record "ACA-Students Hostel Rooms";
        StudentCharges: Record "ACA-Std Charges";
        GenSetUp: Record "ACA-General Set-Up";
        Rooms_Spaces: Record "ACA-Room Spaces";
        Hostel_Rooms: Record "ACA-Hostel Block Rooms";
        Host_Ledger: Record "ACA-Hostel Ledger";
        counts: Integer;
        hostcard: Record "ACA-Hostel Card";
        studItemInv: Record "ACA-Std Hostel Inventory Items";
        invItems: Record "ACA-Hostel Inventory";
        Hostel_Rooms2: Record "ACA-Hostel Block Rooms";
        settlementType: Option " ",JAB,SSP,"Special Programme";
        Creg1: Record "ACA-Course Registration";
        prog: Record "ACA-Programme";
        allocations: Record "ACA-Students Hostel Rooms";
        "Settlement Type": Record "ACA-Settlement Type";
    begin
        // --------Check If More Than One Room Has Been Selected
        Clear(billAmount);
        rooms.Reset;
        rooms.SetRange(rooms."Hostel Code", ACAStudentsHostelRooms."Hostel No");
        rooms.SetRange(rooms."Room Code", "Room No");
        if rooms.Find('-') then begin
            if settle_m = Settle_m::"Special Programme" then
                billAmount := rooms."Special Programme"
            else if settle_m = Settle_m::JAB then
                billAmount := rooms."JAB Fees"
            else if settle_m = Settle_m::SSP then
                billAmount := rooms."SSP Fees"

        end;
        Cust.Reset;
        Cust.SetRange(Cust."No.", ACAStudentsHostelRooms.Student);
        if Cust.Find('-') then begin
        end;
        Clear(StudentHostel);
        StudentHostel.Reset;
        NoRoom := 0;
        StudentHostel.SetRange(StudentHostel.Student, Cust."No.");
        StudentHostel.SetRange(StudentHostel.Cleared, false);
        StudentHostel.SetFilter(StudentHostel."Space No", '<>%1', '');
        if StudentHostel.Find('-') then begin
            repeat
                // Get the Hostel Name
                StudentHostel.TestField(StudentHostel.Semester);
                // StudentHostel.TESTFIELD(StudentHostel."Academic Year");
                StudentHostel.TestField(StudentHostel."Space No");
                NoRoom := NoRoom + 1;
                if NoRoom > 1 then begin
                    Error('Please Note That You Can Not Select More Than One Room')
                end;
                // check if the room is still vacant
                Rooms_Spaces.Reset;
                Rooms_Spaces.SetRange(Rooms_Spaces."Space Code", StudentHostel."Space No");
                Rooms_Spaces.SetRange(Rooms_Spaces."Room Code", StudentHostel."Room No");
                Rooms_Spaces.SetRange(Rooms_Spaces."Hostel Code", StudentHostel."Hostel No");
                if Rooms_Spaces.Find('-') then begin
                    if Rooms_Spaces.Status <> Rooms_Spaces.Status::Vaccant then Error('The selected room is nolonger vacant');
                end;
                // ----------Check If He has UnCleared Room
                StudentHostel.Reset;
                StudentHostel.SetRange(StudentHostel.Student, Cust."No.");
                StudentHostel.SetRange(StudentHostel.Cleared, false);
                if StudentHostel.Find('-') then begin
                    if StudentHostel.Count > 1 then begin
                        exit;
                        //     ERROR('Please Note That You Must First Clear Your Old Rooms Before You Allocate Another Room')
                    end;
                end;
                //---Check if The Student Have Paid The Accomodation Fee
                charges1.Reset;
                charges1.SetRange(charges1.Hostel, true);
                if charges1.Find('-') then begin
                end else
                    Error('Accommodation not setup.');

                StudentCharges.Reset;
                StudentCharges.SetRange(StudentCharges."Student No.", ACAStudentsHostelRooms.Student);
                StudentCharges.SetRange(StudentCharges.Semester, ACAStudentsHostelRooms.Semester);
                StudentCharges.SetRange(StudentCharges.Code, charges1.Code);
                //StudentCharges.SETRANGE(Posted,TRUE);
                if Blocks.Get(ACAStudentsHostelRooms."Hostel No") then begin
                end;

                if not StudentCharges.Find('-') then begin
                    coReg.Reset;
                    coReg.SetRange(coReg."Student No.", ACAStudentsHostelRooms.Student);
                    coReg.SetRange(coReg.Semester, ACAStudentsHostelRooms.Semester);
                    if coReg.Find('-') then begin
                        StudentCharges.Init;
                        StudentCharges."Transacton ID" := '';
                        StudentCharges.Validate(StudentCharges."Transacton ID");
                        StudentCharges."Student No." := coReg."Student No.";
                        StudentCharges."Reg. Transacton ID" := coReg."Reg. Transacton ID";
                        StudentCharges."Transaction Type" := StudentCharges."transaction type"::Charges;
                        StudentCharges.Code := charges1.Code;
                        StudentCharges.Description := 'Accommodation Fees';
                        StudentCharges.Amount := billAmount;
                        StudentCharges.Date := Today;
                        StudentCharges.Programme := coReg.Programmes;
                        StudentCharges.Stage := coReg.Stage;
                        StudentCharges.Semester := coReg.Semester;
                        StudentCharges.Insert();
                    end;
                end;

                if PaidAmt > StudentHostel."Accomodation Fee" then begin
                    StudentHostel."Over Paid" := true;
                    StudentHostel."Over Paid Amt" := PaidAmt - StudentHostel."Accomodation Fee";
                    StudentHostel.Modify;
                end;

                Rooms_Spaces.Reset;
                Rooms_Spaces.SetRange(Rooms_Spaces."Space Code", StudentHostel."Space No");
                if Rooms_Spaces.Find('-') then begin
                    Rooms_Spaces.Status := Rooms_Spaces.Status::"Fully Occupied";
                    Rooms_Spaces.Modify;
                    Clear(counts);
                    // Post to  the Ledger Tables
                    Host_Ledger.Reset;
                    if Host_Ledger.Find('-') then counts := Host_Ledger.Count;
                    Host_Ledger.Init;
                    Host_Ledger."Space No" := StudentHostel."Space No";
                    Host_Ledger."Room No" := "Room No";
                    Host_Ledger."Hostel No" := StudentHostel."Hostel No";
                    Host_Ledger.No := counts;
                    Host_Ledger.Status := Host_Ledger.Status::"Fully Occupied";
                    Host_Ledger."Room Cost" := StudentHostel.Charges;
                    Host_Ledger."Student No" := StudentHostel.Student;
                    Host_Ledger."Receipt No" := '';
                    Host_Ledger.Semester := StudentHostel.Semester;
                    Host_Ledger.Gender := Gender;
                    Host_Ledger."Hostel Name" := '';
                    Host_Ledger.Campus := Cust."Global Dimension 1 Code";
                    Host_Ledger."Academic Year" := StudentHostel."Academic Year";
                    Host_Ledger.Insert(true);


                    Hostel_Rooms.Reset;
                    Hostel_Rooms.SetRange(Hostel_Rooms."Hostel Code", StudentHostel."Hostel No");
                    Hostel_Rooms.SetRange(Hostel_Rooms."Room Code", StudentHostel."Room No");
                    if Hostel_Rooms.Find('-') then begin
                        Hostel_Rooms.CalcFields(Hostel_Rooms."Bed Spaces", Hostel_Rooms."Occupied Spaces");
                        if Hostel_Rooms."Bed Spaces" = Hostel_Rooms."Occupied Spaces" then
                            Hostel_Rooms.Status := Hostel_Rooms.Status::"Fully Occupied"
                        else if Hostel_Rooms."Occupied Spaces" < Hostel_Rooms."Bed Spaces" then
                            Hostel_Rooms.Status := Hostel_Rooms.Status::"Partially Occupied";
                        Hostel_Rooms.Modify;
                    end;



                end;
            until StudentHostel.Next = 0;
        end;

        postCharge(ACAStudentsHostelRooms);
    end;


    procedure AllocateStudentHostelTemp(BufferAllocations: Record "ACA-Batch Room Alloc. Details")
    var
        ACAStudentsHostelRooms: Record "ACA-Students Hostel Rooms";
        ACAStudentsHostelRooms12: Record "ACA-Students Hostel Rooms";
        userst: Record "User Setup";
        AccPayment: Boolean;
        hostStus: Record "ACA-Students Hostel Rooms";
        charges1: Record "ACA-Charge";
        cou: Integer;
        studRoomBlock: Record "ACA-Students Hostel Rooms";
        Blocks: Record "ACA-Hostel Card";
        coReg: Record "ACA-Course Registration";
        HostelLedger: Record "ACA-Hostel Ledger";
        Sem: Record "ACA-Semesters";
        Registered: Boolean;
        acadYear: Record "ACA-Academic Year";
        semz: Record "ACA-Semesters";
        PictureExists: Boolean;
        StudentPayments: Record "ACA-Std Payments";
        StudentCharge: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        ChargesRec: Record "ACA-Charge";
        PaidAmt: Decimal;
        Receipt: Record "ACA-Receipt";
        NoRoom: Integer;
        ReceiptItems: Record "ACA-Receipt Items";
        "GenSetUp.": Record "ACA-General Set-Up";
        StudentCharges2: Record "ACA-Std Charges";
        CourseReg: Record "ACA-Course Registration";
        CurrentBill: Decimal;
        GLEntry: Record "G/L Entry";
        CustLed: Record "Cust. Ledger Entry";
        BankLedg: Record "Bank Account Ledger Entry";
        DCustLedg: Record "Detailed Cust. Ledg. Entry";
        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record "Vendor Ledger Entry";
        DVendLedg: Record "Detailed Vendor Ledg. Entry";
        NoSeries: Record "No. Series Line";
        VATEntry: Record "VAT Entry";
        CReg: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        LastNo: Code[20];
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        ChangeLog: Record "Change Log Entry";
        StudentHostel: Record "ACA-Students Hostel Rooms";
        StudentCharges: Record "ACA-Std Charges";
        GenSetUp: Record "ACA-General Set-Up";
        Rooms_Spaces: Record "ACA-Room Spaces";
        Hostel_Rooms: Record "ACA-Hostel Block Rooms";
        Host_Ledger: Record "ACA-Hostel Ledger";
        counts: Integer;
        hostcard: Record "ACA-Hostel Card";
        studItemInv: Record "ACA-Std Hostel Inventory Items";
        invItems: Record "ACA-Hostel Inventory";
        Hostel_Rooms2: Record "ACA-Hostel Block Rooms";
        settlementType: Option " ",JAB,SSP,"Special Programme";
        Creg1: Record "ACA-Course Registration";
        prog: Record "ACA-Programme";
        allocations: Record "ACA-Students Hostel Rooms";
        "Settlement Type": Record "ACA-Settlement Type";
        ACAHostelBasicSetups: Record "ACA-Hostel Basic Setups";
    begin
        //Check the Policy
        Clear(ACAHostelBasicSetups);
        ACAHostelBasicSetups.Reset;
        if ACAHostelBasicSetups.Find('-') then begin
            ACAHostelBasicSetups.TestField("Current Semester");
            ACAHostelBasicSetups.TestField("Current Academic Year");
        end else
            Error('The hostel basic setups are missing');
        Clear(semz);
        semz.Reset;
        semz.SetRange(semz.Code, ACAHostelBasicSetups."Current Semester");
        if semz.Find('-') then begin
        end else
            Error('Invalid semester!');
        // // ACAStudentsHostelRooms.INIT;
        // // ACAStudentsHostelRooms.Student := BufferAllocations."Student No.";
        // // ACAStudentsHostelRooms."Space No" := BufferAllocations."Room Space";
        // // ACAStudentsHostelRooms."Room No" := BufferAllocations."Room No";
        // // ACAStudentsHostelRooms."Hostel No" := BufferAllocations."Hostel Block";
        // // ACAStudentsHostelRooms."Academic Year"  := semz."Academic Year";
        // // ACAStudentsHostelRooms.Semester := semz.Code;
        //ACAStudentsHostelRooms.INSERT;
        Clear(ACAStudentsHostelRooms12);
        ACAStudentsHostelRooms12.Reset;
        ACAStudentsHostelRooms12.SetRange(Student, BufferAllocations."Student No.");
        ACAStudentsHostelRooms12.SetRange("Space No", BufferAllocations."Room Space");
        ACAStudentsHostelRooms12.SetRange("Room No", BufferAllocations."Room No");
        ACAStudentsHostelRooms12.SetRange("Hostel No", BufferAllocations."Hostel Block");
        ACAStudentsHostelRooms12.SetRange("Academic Year", semz."Academic Year");
        ACAStudentsHostelRooms12.SetRange(Semester, semz.Code);
        if ACAStudentsHostelRooms12.Find('-') then begin
            WITH ACAStudentsHostelRooms12 DO BEGIN
                if BufferAllocations."Room Space" = '' then exit;
                //TESTFIELD(Allocated,FALSE);
                if Cust.Get(Student) then begin
                    Cust.CalcFields(Cust.Balance);
                    CReg.Reset;
                    CReg.SetRange(CReg."Student No.", Cust."No.");
                    if semz.Find('-') then
                        CReg.SetRange(CReg.Semester, semz.Code);
                    CReg.SetRange(CReg.Posted, true);
                    if CReg.Find('-') then begin  //2
                        CReg.CalcFields(CReg."Total Billed");
                        if CReg."Total Billed" <> 0 then begin  // 1
                            allocations.Reset;
                            allocations.SetRange(allocations.Student, Cust."No.");
                            allocations.SetRange(allocations."Hostel No", Cust."Hostel No.");
                            allocations.SetRange(allocations."Room No", Cust."Room Code");
                            allocations.SetRange(allocations."Space No", Cust."Space Booked");
                            //allocations.SETRANGE(allocations."Academic Year","Academic Year");
                            allocations.SetRange(allocations.Semester, Cust.Semester);
                            // IF Allocations.FIND('-') THEN
                            // REPORT.RUN(52017900,TRUE,FALSE,Allocations);
                        end else begin  //1
                                        //ERROR('Fees payment Accommodation policy error --Billing');
                        end; //1
                    end else begin //2
                        if Cust.Balance > 0 then;
                        // ERROR('Fees payment Accommodation policy error --Registration');
                    end; //rec.2
                end;

                if Cust."Hostel Black Listed" = false then begin
                    // IF CONFIRM('Allocate the Specified Room?', TRUE)=FALSE THEN ERROR('Cancelled by user!');
                    Creg1.Reset;
                    Creg1.SetRange(Creg1."Student No.", Student);
                    Creg1.SetRange(Creg1.Semester, Semester);
                    //  Creg1.SETRANGE(Creg1."Academic Year","Academic Year");
                    if Creg1.Find('-') then begin
                        // Check if Prog is Special
                        if prog.Get(Creg1.Programmes) then begin
                            if prog."Special Programme" then
                                settlementType := Settlementtype::"Special Programme"
                            else if Creg1."Settlement Type" = 'PSSP' then
                                settlementType := Settlementtype::SSP
                            else
                                settlementType := Settlementtype::JAB;
                        end;
                    end;
                end;
                BookRoomFromTemp(settlementType, ACAStudentsHostelRooms12);
                // Assign Items
                /*    hostcard.RESET;
                    hostcard.SETRANGE(hostcard."Asset No","Hostel No");
                    IF hostcard.FIND('-') THEN BEGIN
                      invItems.RESET;
                      IF hostcard.Gender=hostcard.Gender::Male THEN
                      invItems.SETFILTER(invItems."Hostel Gender",'%1|%2',1,2);
                      IF invItems.FIND('-') THEN BEGIN
                        studItemInv.RESET;
                        studItemInv.SETRANGE(studItemInv."Student No.",Student);
                        studItemInv.SETRANGE(studItemInv.Semester,Semester);
                        IF studItemInv.FIND('-') THEN studItemInv.DELETEALL;
                        REPEAT
                          BEGIN
                            studItemInv.INIT;
                            studItemInv."Hostel Block":="Hostel No";
                            studItemInv."Room Code":="Room No";
                            studItemInv."Space Code":="Space No";
                            studItemInv."Item Code":=invItems.Item;
                            studItemInv."Academic Year":="Academic Year";
                            studItemInv.Semester:=Semester;
                            studItemInv.Quantity:=invItems."Quantity Per Room";
                            studItemInv."Fine Amount":=invItems."Fine Amount";
                        //    studItemInv.INSERT(TRUE);
                          END;
                        UNTIL invItems.NEXT=0;
                      END;
                    END;*/
            end;
        end;


    end;


    procedure BookRoomFromTemp(settle_m: Option " ",JAB,SSP,"Special Programme"; ACAStudentsHostelRooms: Record "ACA-Students Hostel Rooms")
    var
        rooms: Record "ACA-Hostel Block Rooms";
        billAmount: Decimal;
        ACAStudentsHostelRooms12: Record "ACA-Students Hostel Rooms";
        userst: Record "User Setup";
        AccPayment: Boolean;
        hostStus: Record "ACA-Students Hostel Rooms";
        charges1: Record "ACA-Charge";
        cou: Integer;
        studRoomBlock: Record "ACA-Students Hostel Rooms";
        Blocks: Record "ACA-Hostel Card";
        coReg: Record "ACA-Course Registration";
        HostelLedger: Record "ACA-Hostel Ledger";
        Sem: Record "ACA-Semesters";
        Registered: Boolean;
        acadYear: Record "ACA-Academic Year";
        semz: Record "ACA-Semesters";
        PictureExists: Boolean;
        StudentPayments: Record "ACA-Std Payments";
        StudentCharge: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        ChargesRec: Record "ACA-Charge";
        PaidAmt: Decimal;
        Receipt: Record "ACA-Receipt";
        NoRoom: Integer;
        ReceiptItems: Record "ACA-Receipt Items";
        "GenSetUp.": Record "ACA-General Set-Up";
        StudentCharges2: Record "ACA-Std Charges";
        CourseReg: Record "ACA-Course Registration";
        CurrentBill: Decimal;
        GLEntry: Record "G/L Entry";
        CustLed: Record "Cust. Ledger Entry";
        BankLedg: Record "Bank Account Ledger Entry";
        DCustLedg: Record "Detailed Cust. Ledg. Entry";
        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record "Vendor Ledger Entry";
        DVendLedg: Record "Detailed Vendor Ledg. Entry";
        NoSeries: Record "No. Series Line";
        VATEntry: Record "VAT Entry";
        CReg: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        LastNo: Code[20];
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        ChangeLog: Record "Change Log Entry";
        StudentHostel: Record "ACA-Students Hostel Rooms";
        StudentCharges: Record "ACA-Std Charges";
        GenSetUp: Record "ACA-General Set-Up";
        Rooms_Spaces: Record "ACA-Room Spaces";
        Hostel_Rooms: Record "ACA-Hostel Block Rooms";
        Host_Ledger: Record "ACA-Hostel Ledger";
        counts: Integer;
        hostcard: Record "ACA-Hostel Card";
        studItemInv: Record "ACA-Std Hostel Inventory Items";
        invItems: Record "ACA-Hostel Inventory";
        Hostel_Rooms2: Record "ACA-Hostel Block Rooms";
        settlementType: Option " ",JAB,SSP,"Special Programme";
        Creg1: Record "ACA-Course Registration";
        prog: Record "ACA-Programme";
        allocations: Record "ACA-Students Hostel Rooms";
        "Settlement Type": Record "ACA-Settlement Type";
    begin
        // --------Check If More Than One Room Has Been Selected
        Clear(billAmount);
        rooms.Reset;
        rooms.SetRange(rooms."Hostel Code", ACAStudentsHostelRooms."Hostel No");
        rooms.SetRange(rooms."Room Code", ACAStudentsHostelRooms."Room No");
        if rooms.Find('-') then begin
            if settle_m = Settle_m::"Special Programme" then
                billAmount := rooms."Special Programme"
            else if settle_m = Settle_m::JAB then
                billAmount := rooms."JAB Fees"
            else if settle_m = Settle_m::SSP then
                billAmount := rooms."SSP Fees"

        end;
        Cust.Reset;
        Cust.SetRange(Cust."No.", ACAStudentsHostelRooms.Student);
        if Cust.Find('-') then begin
        end;
        Clear(StudentHostel);
        StudentHostel.Reset;
        NoRoom := 0;
        StudentHostel.SetRange(StudentHostel.Student, Cust."No.");
        StudentHostel.SetRange(StudentHostel.Cleared, false);
        StudentHostel.SetFilter(StudentHostel."Space No", '<>%1', '');
        if StudentHostel.Find('-') then begin
            repeat
                // Get the Hostel Name
                StudentHostel.TestField(StudentHostel.Semester);
                // StudentHostel.TESTFIELD(StudentHostel."Academic Year");
                StudentHostel.TestField(StudentHostel."Space No");
                NoRoom := NoRoom + 1;
                if NoRoom > 1 then begin
                    // ERROR('Please Note That You Can Not Select More Than One Room')
                end;
                // check if the room is still vacant
                Rooms_Spaces.Reset;
                Rooms_Spaces.SetRange(Rooms_Spaces."Space Code", StudentHostel."Space No");
                Rooms_Spaces.SetRange(Rooms_Spaces."Room Code", StudentHostel."Room No");
                Rooms_Spaces.SetRange(Rooms_Spaces."Hostel Code", StudentHostel."Hostel No");
                if Rooms_Spaces.Find('-') then begin
                    //   IF Rooms_Spaces.Status<>Rooms_Spaces.Status::Vaccant THEN ERROR('The selected room is nolonger vacant');
                end;
                // ----------Check If He has UnCleared Room
                StudentHostel.Reset;
                StudentHostel.SetRange(StudentHostel.Student, Cust."No.");
                StudentHostel.SetRange(StudentHostel.Cleared, false);
                if StudentHostel.Find('-') then begin
                    //IF StudentHostel.COUNT>1 THEN BEGIN
                    //  EXIT;
                    //     ERROR('Please Note That You Must First Clear Your Old Rooms Before You Allocate Another Room')
                    //  END;
                end;
                //---Check if The Student Have Paid The Accomodation Fee
                charges1.Reset;
                charges1.SetRange(charges1.Hostel, true);
                if charges1.Find('-') then begin
                end;// ELSE ERROR('Accommodation not setup.');

                StudentCharges.Reset;
                StudentCharges.SetRange(StudentCharges."Student No.", ACAStudentsHostelRooms.Student);
                StudentCharges.SetRange(StudentCharges.Semester, ACAStudentsHostelRooms.Semester);
                StudentCharges.SetRange(StudentCharges.Code, charges1.Code);
                //StudentCharges.SETRANGE(Posted,TRUE);
                if Blocks.Get(ACAStudentsHostelRooms."Hostel No") then begin
                end;

                if not StudentCharges.Find('-') then begin
                    coReg.Reset;
                    coReg.SetRange(coReg."Student No.", ACAStudentsHostelRooms.Student);
                    coReg.SetRange(coReg.Semester, ACAStudentsHostelRooms.Semester);
                    if coReg.Find('-') then begin
                        StudentCharges.Init;
                        StudentCharges."Transacton ID" := '';
                        StudentCharges.Validate(StudentCharges."Transacton ID");
                        StudentCharges."Student No." := coReg."Student No.";
                        StudentCharges."Reg. Transacton ID" := coReg."Reg. Transacton ID";
                        StudentCharges."Transaction Type" := StudentCharges."transaction type"::Charges;
                        StudentCharges.Code := charges1.Code;
                        StudentCharges.Description := 'Accommodation Fees';
                        StudentCharges.Amount := billAmount;
                        StudentCharges.Date := Today;
                        StudentCharges.Programme := coReg.Programmes;
                        StudentCharges.Stage := coReg.Stage;
                        StudentCharges.Semester := coReg.Semester;
                        StudentCharges.Insert();
                    end;
                end;

                if PaidAmt > StudentHostel."Accomodation Fee" then begin
                    StudentHostel."Over Paid" := true;
                    StudentHostel."Over Paid Amt" := PaidAmt - StudentHostel."Accomodation Fee";
                    StudentHostel.Modify;
                end;

                Rooms_Spaces.Reset;
                Rooms_Spaces.SetRange(Rooms_Spaces."Space Code", StudentHostel."Space No");
                if Rooms_Spaces.Find('-') then begin
                    Rooms_Spaces.Status := Rooms_Spaces.Status::"Fully Occupied";
                    Rooms_Spaces.Modify;
                    Clear(counts);
                    // Post to  the Ledger Tables
                    Host_Ledger.Reset;
                    if Host_Ledger.Find('-') then counts := Host_Ledger.Count;
                    Host_Ledger.Init;
                    Host_Ledger."Space No" := ACAStudentsHostelRooms."Space No";
                    Host_Ledger."Room No" := "Room No";
                    Host_Ledger."Hostel No" := ACAStudentsHostelRooms."Hostel No";
                    Host_Ledger.No := counts;
                    Host_Ledger.Status := Host_Ledger.Status::"Fully Occupied";
                    Host_Ledger."Room Cost" := StudentHostel.Charges;
                    Host_Ledger."Student No" := StudentHostel.Student;
                    Host_Ledger."Receipt No" := '';
                    Host_Ledger.Semester := StudentHostel.Semester;
                    Host_Ledger.Gender := Gender;
                    Host_Ledger."Hostel Name" := '';
                    Host_Ledger.Campus := Cust."Global Dimension 1 Code";
                    Host_Ledger."Academic Year" := StudentHostel."Academic Year";
                    //Host_Ledger.INSERT(TRUE);


                    Hostel_Rooms.Reset;
                    Hostel_Rooms.SetRange(Hostel_Rooms."Hostel Code", StudentHostel."Hostel No");
                    Hostel_Rooms.SetRange(Hostel_Rooms."Room Code", StudentHostel."Room No");
                    if Hostel_Rooms.Find('-') then begin
                        Hostel_Rooms.CalcFields(Hostel_Rooms."Bed Spaces", Hostel_Rooms."Occupied Spaces");
                        if Hostel_Rooms."Bed Spaces" = Hostel_Rooms."Occupied Spaces" then
                            Hostel_Rooms.Status := Hostel_Rooms.Status::"Fully Occupied"
                        else if Hostel_Rooms."Occupied Spaces" < Hostel_Rooms."Bed Spaces" then
                            Hostel_Rooms.Status := Hostel_Rooms.Status::"Partially Occupied";
                        Hostel_Rooms.Modify;
                    end;



                end;
            until StudentHostel.Next = 0;
        end;

        postCharge(ACAStudentsHostelRooms);
    end;

    local procedure postCharge(var ACAStudentsHostelRooms: Record "ACA-Students Hostel Rooms")
    var
        ACAStudentsHostelRooms12: Record "ACA-Students Hostel Rooms";
        userst: Record "User Setup";
        AccPayment: Boolean;
        hostStus: Record "ACA-Students Hostel Rooms";
        charges1: Record "ACA-Charge";
        cou: Integer;
        studRoomBlock: Record "ACA-Students Hostel Rooms";
        Blocks: Record "ACA-Hostel Card";
        coReg: Record "ACA-Course Registration";
        HostelLedger: Record "ACA-Hostel Ledger";
        Sem: Record "ACA-Semesters";
        Registered: Boolean;
        acadYear: Record "ACA-Academic Year";
        semz: Record "ACA-Semesters";
        PictureExists: Boolean;
        StudentPayments: Record "ACA-Std Payments";
        StudentCharge: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        ChargesRec: Record "ACA-Charge";
        PaidAmt: Decimal;
        Receipt: Record "ACA-Receipt";
        NoRoom: Integer;
        ReceiptItems: Record "ACA-Receipt Items";
        "GenSetUp.": Record "ACA-General Set-Up";
        StudentCharges2: Record "ACA-Std Charges";
        CourseReg: Record "ACA-Course Registration";
        CurrentBill: Decimal;
        GLEntry: Record "G/L Entry";
        CustLed: Record "Cust. Ledger Entry";
        BankLedg: Record "Bank Account Ledger Entry";
        DCustLedg: Record "Detailed Cust. Ledg. Entry";
        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record "Vendor Ledger Entry";
        DVendLedg: Record "Detailed Vendor Ledg. Entry";
        NoSeries: Record "No. Series Line";
        VATEntry: Record "VAT Entry";
        CReg: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        LastNo: Code[20];
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        ChangeLog: Record "Change Log Entry";
        StudentHostel: Record "ACA-Students Hostel Rooms";
        StudentCharges: Record "ACA-Std Charges";
        GenSetUp: Record "ACA-General Set-Up";
        Rooms_Spaces: Record "ACA-Room Spaces";
        Hostel_Rooms: Record "ACA-Hostel Block Rooms";
        Host_Ledger: Record "ACA-Hostel Ledger";
        counts: Integer;
        hostcard: Record "ACA-Hostel Card";
        studItemInv: Record "ACA-Std Hostel Inventory Items";
        invItems: Record "ACA-Hostel Inventory";
        Hostel_Rooms2: Record "ACA-Hostel Block Rooms";
        settlementType: Option " ",JAB,SSP,"Special Programme";
        Creg1: Record "ACA-Course Registration";
        prog: Record "ACA-Programme";
        allocations: Record "ACA-Students Hostel Rooms";
        "Settlement Type": Record "ACA-Settlement Type";
        entryNo: Integer;
    begin
        // Check if Jornal Batch exists
        GenJnl.Reset;
        GenJnl.SetRange("Journal Template Name", 'SALES');
        GenJnl.SetRange("Journal Batch Name", 'ACCOM');
        if GenJnl.Find('+') then begin
        end;
        Clear(entryNo);
        entryNo := GenJnl."Line No.";
        ACAStudentsHostelRooms.Charges := 6500;
        ACAStudentsHostelRooms.Modify;



        //BILLING
        charges1.Reset;
        charges1.SetRange(charges1.Hostel, true);
        if not charges1.Find('-') then begin
            Error('The charges Setup does not have an item tagged as Hostel.');
        end;

        AccPayment := false;
        StudentCharges.Reset;
        StudentCharges.SetRange(StudentCharges."Student No.", ACAStudentsHostelRooms.Student);
        StudentCharges.SetRange(StudentCharges.Recognized, false);
        StudentCharges.SetRange(Description, 'Accommodation Fees');
        if not StudentCharges.Find('-') then begin //3
                                                   // The charge does not exist. Created it, but check first if it exists as unrecognized
            StudentCharges.Reset;
            StudentCharges.SetRange(StudentCharges."Student No.", ACAStudentsHostelRooms.Student);
            //StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
            StudentCharges.SetFilter(StudentCharges.Code, '=%1', charges1.Code);
            if not StudentCharges.Find('-') then begin //4
                                                       // Does not exist hence just create
                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStudentsHostelRooms.Student);
                CReg.SetRange(CReg.Semester, ACAStudentsHostelRooms.Semester);
                if CReg.Find('-') then begin //5
                    GenSetUp.Get();
                    if GenSetUp.Find('-') then begin  //6
                        NoSeries.Reset;
                        NoSeries.SetRange(NoSeries."Series Code", GenSetUp."Transaction Nos.");
                        if NoSeries.Find('-') then begin // 7
                            LastNo := NoSeries."Last No. Used"
                        end;  // 7
                    end; // 6
                         //message(LastNo);
                    LastNo := IncStr(LastNo);
                    NoSeries."Last No. Used" := LastNo;
                    NoSeries.Modify;
                    StudentCharges.Init();
                    StudentCharges."Transacton ID" := LastNo;
                    StudentCharges.Validate(StudentCharges."Transacton ID");
                    StudentCharges."Student No." := ACAStudentsHostelRooms.Student;
                    StudentCharges."Transaction Type" := StudentCharges."transaction type"::Charges;
                    StudentCharges."Reg. Transacton ID" := CReg."Reg. Transacton ID";
                    StudentCharges.Description := 'Accommodation Fees';
                    StudentCharges.Amount := 6500;
                    StudentCharges.Date := Today;
                    StudentCharges.Code := charges1.Code;
                    StudentCharges.Charge := true;
                    StudentCharges.Insert(true);
                    // Billed:=TRUE;
                    //"Billed Date":=TODAY;
                    //  MODIFY;
                end; //5

            end else begin//4
                          // Charge Exists, Delete from the charges then create a new one
                StudentCharges.Delete;

                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStudentsHostelRooms.Student);
                CReg.SetRange(CReg.Semester, ACAStudentsHostelRooms.Semester);
                if CReg.Find('-') then begin //5
                    GenSetUp.Get();
                    if GenSetUp.Find('-') then begin  //6
                        NoSeries.Reset;
                        NoSeries.SetRange(NoSeries."Series Code", GenSetUp."Transaction Nos.");
                        if NoSeries.Find('-') then begin // 7
                            LastNo := NoSeries."Last No. Used"
                        end;  // 7
                    end; // 6
                         //message(LastNo);
                    LastNo := IncStr(LastNo);
                    NoSeries."Last No. Used" := LastNo;
                    NoSeries.Modify;
                    StudentCharges.Init();
                    StudentCharges."Transacton ID" := LastNo;
                    StudentCharges.Validate(StudentCharges."Transacton ID");
                    StudentCharges."Student No." := ACAStudentsHostelRooms.Student;
                    StudentCharges."Transaction Type" := StudentCharges."transaction type"::Charges;
                    StudentCharges."Reg. Transacton ID" := CReg."Reg. Transacton ID";
                    StudentCharges.Description := 'Accommodation Fees';
                    ;
                    StudentCharges.Amount := 6500;
                    StudentCharges.Date := Today;
                    StudentCharges.Code := charges1.Code;
                    StudentCharges.Charge := true;
                    StudentCharges.Insert(true);
                    // Billed:=TRUE;
                    // "Billed Date":=TODAY;
                    // MODIFY;
                end; //5
            end;//4

        end; //3


        CReg.Reset;
        CReg.SetRange(CReg."Student No.", ACAStudentsHostelRooms.Student);
        CReg.SetRange(CReg.Semester, ACAStudentsHostelRooms.Semester);
        if CReg.Find('-') then begin //10
        end // 10
        else begin // 10.1
            Error('The Settlement Type Does not Exists in the Course Registration for: ' + ACAStudentsHostelRooms.Student);
        end;//10.1



        if Cust.Get(ACAStudentsHostelRooms.Student) then;


        GenSetUp.Get();

        // Charge Student - Accommodation- if not charged
        StudentCharges.Reset;
        StudentCharges.SetRange(StudentCharges."Student No.", ACAStudentsHostelRooms.Student);
        StudentCharges.SetRange(StudentCharges.Recognized, false);
        StudentCharges.SetFilter(StudentCharges.Code, '=%1', charges1.Code);
        if StudentCharges.Find('-') then begin

            repeat

                DueDate := StudentCharges.Date;
                if DueDate = 0D then DueDate := Today;
                entryNo += 1000;
                GenJnl.Init;
                GenJnl."Line No." := entryNo;
                GenJnl."Posting Date" := Today;
                GenJnl."Document No." := StudentCharges."Transacton ID";
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'ACCOM';
                GenJnl."Account Type" := GenJnl."account type"::Customer;
                //
                if Cust.Get(ACAStudentsHostelRooms.Student) then begin
                    if Cust."Bill-to Customer No." <> '' then
                        GenJnl."Account No." := Cust."Bill-to Customer No."
                    else
                        GenJnl."Account No." := ACAStudentsHostelRooms.Student;
                end;

                GenJnl.Amount := 6500;
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := StudentCharges.Description;
                GenJnl."Bal. Account Type" := GenJnl."account type"::"G/L Account";

                if (StudentCharges."Transaction Type" = StudentCharges."transaction type"::"Stage Fees") and
                   (StudentCharges.Charge = false) then begin

                    CReg.Reset;
                    CReg.SetCurrentkey(CReg."Reg. Transacton ID");
                    CReg.SetRange(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                    CReg.SetRange(CReg."Student No.", StudentCharges."Student No.");
                    if CReg.Find('-') then begin
                        if CReg."Register for" = CReg."register for"::Stage then begin
                            Stages.Reset;
                            Stages.SetRange(Stages."Programme Code", CReg.Programmes);
                            Stages.SetRange(Stages.Code, CReg.Stage);
                            if Stages.Find('-') then begin
                                if (Stages."Modules Registration" = true) and (Stages."Ignore No. Of Units" = false) then begin
                                    CReg.CalcFields(CReg."Units Taken");
                                    if CReg.Modules <> CReg."Units Taken" then
                                        Error('Units Taken must be equal to the no of modules registered for.');

                                end;
                            end;
                        end;

                        CReg.Posted := true;
                        CReg.Modify;
                    end;


                end else if (StudentCharges."Transaction Type" = StudentCharges."transaction type"::"Unit Fees") and
                            (StudentCharges.Charge = false) then begin
                    StudentCharges.CalcFields(StudentCharges."Settlement Type");


                    CReg.Reset;
                    CReg.SetCurrentkey(CReg."Reg. Transacton ID");
                    CReg.SetRange(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                    if CReg.Find('-') then begin
                        CReg.Posted := true;
                        CReg.Modify;
                    end;



                end else if StudentCharges."Transaction Type" = StudentCharges."transaction type"::"Stage Exam Fees" then begin
                    if ExamsByStage.Get(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Semester, StudentCharges.Code) then
                        GenJnl."Bal. Account No." := ExamsByStage."G/L Account";

                end else if StudentCharges."Transaction Type" = StudentCharges."transaction type"::"Unit Exam Fees" then begin
                    if ExamsByUnit.Get(StudentCharges.Programme, StudentCharges.Stage, ExamsByUnit."Unit Code", StudentCharges.Semester,
                    StudentCharges.Code) then
                        GenJnl."Bal. Account No." := ExamsByUnit."G/L Account";

                end else if (StudentCharges."Transaction Type" = StudentCharges."transaction type"::Charges) or
                            (StudentCharges.Charge = true) then begin
                    if charges1.Get(StudentCharges.Code) then
                        GenJnl."Bal. Account No." := charges1."G/L Account";
                end;


                GenJnl.Validate(GenJnl."Bal. Account No.");
                GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                if prog.Get(StudentCharges.Programme) then begin
                    prog.TestField(prog."Department Code");
                    GenJnl."Shortcut Dimension 2 Code" := prog."Department Code";
                end;



                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                GenJnl."Due Date" := DueDate;
                GenJnl.Validate(GenJnl."Due Date");
                if StudentCharges."Recovery Priority" <> 0 then
                    GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                else
                    GenJnl."Recovery Priority" := 25;
                GenJnl.Insert;

                //Distribute Money
                if StudentCharges."Tuition Fee" = true then begin
                    if Stages.Get(StudentCharges.Programme, StudentCharges.Stage) then begin
                        if (Stages."Distribution Full Time (%)" > 0) or (Stages."Distribution Part Time (%)" > 0) then begin
                            Stages.TestField(Stages."Distribution Account");
                            StudentCharges.TestField(StudentCharges.Distribution);
                            if Cust.Get(ACAStudentsHostelRooms.Student) then begin
                                CustPostGroup.Get(Cust."Customer Posting Group");

                                entryNo += 1000;
                                GenJnl.Init;
                                GenJnl."Line No." := entryNo + 1000;
                                GenJnl."Posting Date" := Today;
                                GenJnl."Document No." := StudentCharges."Transacton ID";
                                GenJnl.Validate(GenJnl."Document No.");
                                GenJnl."Journal Template Name" := 'SALES';
                                GenJnl."Journal Batch Name" := 'ACCOM';
                                GenJnl."Account Type" := GenJnl."account type"::"G/L Account";
                                GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                GenJnl.Validate(GenJnl."Account No.");
                                GenJnl.Validate(GenJnl.Amount);
                                GenJnl.Description := 'Fee Distribution';
                                GenJnl."Bal. Account Type" := GenJnl."bal. account type"::"G/L Account";

                                StudentCharges.CalcFields(StudentCharges."Settlement Type");

                                GenJnl.Validate(GenJnl."Bal. Account No.");
                                GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                if prog.Get(StudentCharges.Programme) then begin
                                    prog.TestField(prog."Department Code");
                                    GenJnl."Shortcut Dimension 2 Code" := prog."Department Code";
                                end;

                                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");

                                GenJnl.Insert;

                            end;
                        end;
                    end;
                end else begin
                    //Distribute Charges
                    if StudentCharges.Distribution > 0 then begin
                        StudentCharges.TestField(StudentCharges."Distribution Account");
                        if charges1.Get(StudentCharges.Code) then begin
                            charges1.TestField(charges1."G/L Account");

                            entryNo += 1000;
                            GenJnl.Init;
                            GenJnl."Line No." := entryNo + 1000;
                            ;
                            GenJnl."Posting Date" := Today;
                            GenJnl."Document No." := StudentCharges."Transacton ID";
                            GenJnl.Validate(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'ACCOM';
                            GenJnl."Account Type" := GenJnl."account type"::"G/L Account";
                            GenJnl."Account No." := StudentCharges."Distribution Account";
                            GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                            GenJnl.Validate(GenJnl."Account No.");
                            GenJnl.Validate(GenJnl.Amount);
                            GenJnl.Description := 'Fee Distribution';
                            GenJnl."Bal. Account Type" := GenJnl."bal. account type"::"G/L Account";
                            GenJnl."Bal. Account No." := charges1."G/L Account";
                            GenJnl.Validate(GenJnl."Bal. Account No.");
                            GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";

                            if prog.Get(StudentCharges.Programme) then begin
                                prog.TestField(prog."Department Code");
                                GenJnl."Shortcut Dimension 2 Code" := prog."Department Code";
                            end;
                            GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                            GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                            GenJnl.Insert;

                        end;
                    end;
                end;
                //End Distribution


                StudentCharges.Recognized := true;
                //StudentCharges.MODIFY;
                //.......BY Wanjala
                StudentCharges.Posted := true;
                StudentCharges.Modify;


            until StudentCharges.Next = 0;

            ACAStudentsHostelRooms.Billed := true;
            ACAStudentsHostelRooms.Charges := 6500;
            ACAStudentsHostelRooms."Billed Date" := Today;
            ACAStudentsHostelRooms."Allocation Date" := Today;
            ACAStudentsHostelRooms.Allocated := true;
            ACAStudentsHostelRooms."Allocated By" := UserId;
            ACAStudentsHostelRooms."Time allocated" := Time;
            ACAStudentsHostelRooms.Modify;



            Cust."Application Method" := Cust."application method"::"Apply to Oldest";
            //Cust.Status:=Cust.Status::Current;
            Cust.Modify;

        end;
    end;
}

