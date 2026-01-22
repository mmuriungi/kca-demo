report 50845 "ACA-Hostel Sem. Progression"
{
    Caption = 'Hostel Semester Progression';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("ACA-Students Hostel Rooms"; "ACA-Students Hostel Rooms X")
        {
            DataItemTableView = where(Allocated = const(true), Cleared = const(false), Reversed = const(false));

            trigger OnPreDataItem()
            begin
                if NewSemester = '' then
                    Error('Please select the new semester');
                if NewAcademicYear = '' then
                    Error('Please select the new academic year');

                ProgressDialog.Open('Processing student #1##################', StudentNo);
                TotalRecords := Count();
                ProcessedRecords := 0;
            end;

            trigger OnAfterGetRecord()
            var
                NewHostelAllocation: Record "ACA-Students Hostel Rooms X";
                CourseReg: Record "ACA-Course Registration";
                RoomSpace: Record "ACA-Room Spaces";
                HostelLedger: Record "ACA-Hostel Ledger";
                Customer: Record Customer;
            begin
                StudentNo := "ACA-Students Hostel Rooms".Student;
                ProgressDialog.Update(1, StudentNo);

                // Check if student is registered for new semester
                CourseReg.Reset();
                CourseReg.SetRange("Student No.", Student);
                CourseReg.SetRange(Semester, NewSemester);
                CourseReg.SetRange("Academic Year", NewAcademicYear);
                if not CourseReg.FindFirst() then begin
                    SkippedRecords += 1;
                    CurrReport.Skip();
                end;

                // Check if already allocated for new semester
                NewHostelAllocation.Reset();
                NewHostelAllocation.SetRange(Student, Student);
                NewHostelAllocation.SetRange(Semester, NewSemester);
                NewHostelAllocation.SetRange("Academic Year", NewAcademicYear);
                NewHostelAllocation.SetRange(Allocated, true);
                NewHostelAllocation.SetRange(Reversed, false);
                if NewHostelAllocation.FindFirst() then begin
                    SkippedRecords += 1;
                    CurrReport.Skip();
                end;

                // Get student gender
                Customer.Get(Student);

                // Create new allocation
                NewHostelAllocation.Init();
                NewHostelAllocation.Student := Student;
                NewHostelAllocation.Gender := Customer.Gender;
                NewHostelAllocation."Hostel No" := "Hostel No";
                NewHostelAllocation."Room No" := "Room No";
                NewHostelAllocation."Space No" := "Space No";
                NewHostelAllocation.Semester := NewSemester;
                NewHostelAllocation."Academic Year" := NewAcademicYear;
                NewHostelAllocation."Allocation Date" := Today;
                NewHostelAllocation."Allocated By" := UserId;
                NewHostelAllocation."Time allocated" := Time;
                NewHostelAllocation.Allocated := true;
                NewHostelAllocation.Status := NewHostelAllocation.Status::Allocated;
                
                // Get charges from hostel card
                if HostelCard.Get("Hostel No") then
                    NewHostelAllocation.Charges := HostelCard."JAB Fees";
                
                NewHostelAllocation.Insert(true);

                // Update room space status
                if RoomSpace.Get("Hostel No", "Room No", "Space No") then begin
                    RoomSpace.Status := RoomSpace.Status::"Fully Occupied";
                    RoomSpace."Student No" := Student;
                    RoomSpace."Receipt No" := '';
                    RoomSpace."Black List Reason" := '';
                    RoomSpace.Modify();
                end;

                // Create hostel ledger entry
                HostelLedger.Init();
                HostelLedger."Space No" := "Space No";
                HostelLedger."Room No" := "Room No";
                HostelLedger."Hostel No" := "Hostel No";
                HostelLedger."Student No" := Student;
                HostelLedger."Receipt No" := '';
                //HostelLedger.Amount := NewHostelAllocation.Charges;
                //HostelLedger."Posting Date" := Today;
                HostelLedger.Semester := NewSemester;
                HostelLedger."Academic Year" := NewAcademicYear;
                HostelLedger.Status := HostelLedger.Status::"Fully Occupied";
                HostelLedger.Insert();

                // Update hostel block room counts
                UpdateHostelBlockRoom("Hostel No", "Room No");

                // Create billing if requested
                if CreateBilling then
                    CreateHostelBilling(NewHostelAllocation);

                ProcessedRecords += 1;
            end;

            trigger OnPostDataItem()
            begin
                ProgressDialog.Close();
                Message('Semester Progression completed.\Processed: %1\Skipped: %2', ProcessedRecords, SkippedRecords);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Progression Options';
                    field(CurrentSemester; CurrentSemester)
                    {
                        ApplicationArea = All;
                        Caption = 'Current Semester';
                        TableRelation = "ACA-Semesters".Code;
                        ToolTip = 'Select the current semester';
                    }
                    field(CurrentAcademicYear; CurrentAcademicYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Current Academic Year';
                        TableRelation = "ACA-Academic Year".Code;
                        ToolTip = 'Select the current academic year';
                    }
                    field(NewSemester; NewSemester)
                    {
                        ApplicationArea = All;
                        Caption = 'New Semester';
                        TableRelation = "ACA-Semesters".Code;
                        ToolTip = 'Select the new semester to progress students to';
                        
                        trigger OnValidate()
                        var
                            Semester: Record "ACA-Semesters";
                        begin
                            if Semester.Get(NewSemester) then
                                NewAcademicYear := Semester."Academic Year";
                        end;
                    }
                    field(NewAcademicYear; NewAcademicYear)
                    {
                        ApplicationArea = All;
                        Caption = 'New Academic Year';
                        TableRelation = "ACA-Academic Year".Code;
                        ToolTip = 'Select the new academic year';
                    }
                    field(RetainSameRoom; RetainSameRoom)
                    {
                        ApplicationArea = All;
                        Caption = 'Retain Same Room';
                        ToolTip = 'Check to keep students in their current rooms';
                    }
                    field(OnlyRegisteredStudents; OnlyRegisteredStudents)
                    {
                        ApplicationArea = All;
                        Caption = 'Only Registered Students';
                        ToolTip = 'Process only students registered for the new semester';
                    }
                    field(CreateBilling; CreateBilling)
                    {
                        ApplicationArea = All;
                        Caption = 'Create Billing';
                        ToolTip = 'Create billing entries for the new semester allocations';
                    }
                }
            }
        }

        trigger OnOpenPage()
        var
            Semester: Record "ACA-Semesters";
        begin
            // Set default values
            Semester.Reset();
            Semester.SetRange("Current Semester", true);
            if Semester.FindFirst() then begin
                CurrentSemester := Semester.Code;
                CurrentAcademicYear := Semester."Academic Year";
            end;
            
            RetainSameRoom := true;
            OnlyRegisteredStudents := true;
            CreateBilling := true;
        end;
    }

    var
        CurrentSemester: Code[20];
        CurrentAcademicYear: Code[30];
        NewSemester: Code[20];
        NewAcademicYear: Code[30];
        RetainSameRoom: Boolean;
        OnlyRegisteredStudents: Boolean;
        CreateBilling: Boolean;
        ProgressDialog: Dialog;
        StudentNo: Code[20];
        TotalRecords: Integer;
        ProcessedRecords: Integer;
        SkippedRecords: Integer;
        HostelCard: Record "ACA-Hostel Card";

    local procedure UpdateHostelBlockRoom(HostelCode: Code[20]; RoomCode: Code[20])
    var
        HostelBlockRoom: Record "ACA-Hostel Block Rooms";
        RoomSpaces: Record "ACA-Room Spaces";
        OccupiedCount: Integer;
        VacantCount: Integer;
    begin
        if not HostelBlockRoom.Get(HostelCode, RoomCode) then
            exit;

        // Count occupied and vacant spaces
        RoomSpaces.Reset();
        RoomSpaces.SetRange("Hostel Code", HostelCode);
        RoomSpaces.SetRange("Room Code", RoomCode);
        RoomSpaces.SetRange(Status, RoomSpaces.Status::"Fully Occupied");
        OccupiedCount := RoomSpaces.Count();

        RoomSpaces.SetRange(Status, RoomSpaces.Status::Vaccant);
        VacantCount := RoomSpaces.Count();

        // Update hostel block room
        HostelBlockRoom."Occupied Spaces" := OccupiedCount;
        HostelBlockRoom."Vacant Spaces" := VacantCount;
        
        if VacantCount = 0 then
            HostelBlockRoom.Status := HostelBlockRoom.Status::"Fully Occupied"
        else if OccupiedCount = 0 then
            HostelBlockRoom.Status := HostelBlockRoom.Status::Vaccant
        else
            HostelBlockRoom.Status := HostelBlockRoom.Status::"Partially Occupied";
            
        HostelBlockRoom.Modify();

        // Update hostel card counts
        UpdateHostelCard(HostelCode);
    end;

    local procedure UpdateHostelCard(HostelCode: Code[20])
    var
        HostelCard: Record "ACA-Hostel Card";
        HostelBlockRoom: Record "ACA-Hostel Block Rooms";
    begin
        if not HostelCard.Get(HostelCode) then
            exit;

        HostelBlockRoom.Reset();
        HostelBlockRoom.SetRange("Hostel Code", HostelCode);
        
        HostelBlockRoom.SetRange(Status, HostelBlockRoom.Status::Vaccant);
        HostelCard.Vaccant := HostelBlockRoom.Count();
        
        HostelBlockRoom.SetRange(Status, HostelBlockRoom.Status::"Fully Occupied");
        HostelCard."Fully Occupied" := HostelBlockRoom.Count();
        
        HostelBlockRoom.SetRange(Status, HostelBlockRoom.Status::"Partially Occupied");
        HostelCard."Partially Occupied" := HostelBlockRoom.Count();
        
        HostelCard.Modify();
    end;

    local procedure CreateHostelBilling(var StudentHostelRoom: Record "ACA-Students Hostel Rooms X")
    var
        GenJournalLine: Record "Gen. Journal Line";
        CourseReg: Record "ACA-Course Registration";
        Programme: Record "ACA-Programme";
        StudentCharges: Record "ACA-Std Charges";
        LineNo: Integer;
    begin
        // Get course registration to determine settlement type
        CourseReg.Reset();
        CourseReg.SetRange("Student No.", StudentHostelRoom.Student);
        CourseReg.SetRange(Semester, StudentHostelRoom.Semester);
        if not CourseReg.FindFirst() then
            exit;

        // Create student charges entry (following existing system pattern)
        StudentCharges.Init();
        StudentCharges."Reg. Transacton ID" := CourseReg."Reg. Transacton ID";
        StudentCharges."Student No." := StudentHostelRoom.Student;
        StudentCharges.Semester := StudentHostelRoom.Semester;
        StudentCharges.Date := Today;
        StudentCharges.Code := 'ACCOMMODATION';
        StudentCharges.Description := 'Hostel Accommodation - ' + StudentHostelRoom.Semester;
        StudentCharges.Programme := CourseReg.Programmes;
        StudentCharges.Stage := CourseReg.Stage;
        StudentCharges.Amount := StudentHostelRoom.Charges;
        StudentCharges."Settlement Type" := CourseReg."Settlement Type";
        StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
        StudentCharges.Charge := true;
        StudentCharges.Posted := false;
        StudentCharges.accommodation := true;
        StudentCharges."Room Allocation" := StudentHostelRoom."Space No";
        StudentCharges.Insert(true);

        // Update hostel room as billed
        StudentHostelRoom.Billed := true;
        StudentHostelRoom."Billed Date" := Today;
        StudentHostelRoom.Modify();
    end;
}