codeunit 50050 "Hostel Handler"
{
    Permissions = TableData "ACA-Students Hostel Rooms" = rimd,
                  TableData "ACA-Room Spaces" = rimd,
                  TableData "ACA-Hostel Ledger" = rimd,
                  TableData "ACA-Hostel Block Rooms" = rimd;

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Process all student semester allocations to a new semester
    /// </summary>
    /// <param name="OldSemesterCode">Code of the source semester</param>
    /// <param name="NewSemesterCode">Code of the target semester</param>
    /// <param name="NewAcademicYear">Academic year for the new semester</param>
    /// <returns>Text message with the result of the operation</returns>
    procedure ProcessSemesterAllocations(OldSemesterCode: Code[50]; NewSemesterCode: Code[50]): Text
    var
        OldStudentHostelRooms: Record "ACA-Students Hostel Rooms";
        NewStudentHostelRooms: Record "ACA-Students Hostel Rooms";
        RoomSpaces: Record "ACA-Room Spaces";
        HostelLedger: Record "ACA-Hostel Ledger";
        HostelCard: Record "ACA-Hostel Card";
        SemesterRec: Record "ACA-Semester";
        NewAcademicYear: Code[30];
        ProcessedCount: Integer;
        FailedCount: Integer;
        ErrorText: Text;
    begin
        // Validate parameters
        if OldSemesterCode = '' then
            Error('Old semester code must be specified');

        if NewSemesterCode = '' then
            Error('New semester code must be specified');


        // Check if new semester exists
        if not SemesterRec.Get(NewSemesterCode) then
            Error('New semester %1 does not exist', NewSemesterCode);
        NewAcademicYear := SemesterRec."Academic Year";

        if NewAcademicYear = '' then
            Error('New academic year must be specified');

        // Initialize counters
        ProcessedCount := 0;
        FailedCount := 0;

        // Get all student hostel allocations from the old semester
        OldStudentHostelRooms.Reset();
        OldStudentHostelRooms.SetRange(Semester, OldSemesterCode);

        if not OldStudentHostelRooms.FindSet() then
            exit('No hostel allocations found for semester ' + OldSemesterCode);

        // Process each allocation
        repeat
            // Check if student already has allocation in new semester
            NewStudentHostelRooms.Reset();
            NewStudentHostelRooms.SetRange(Student, OldStudentHostelRooms.Student);
            NewStudentHostelRooms.SetRange(Semester, NewSemesterCode);

            if not NewStudentHostelRooms.FindFirst() then begin
                // Check if space is available
                RoomSpaces.Reset();
                RoomSpaces.SetRange("Hostel Code", OldStudentHostelRooms."Hostel No");
                RoomSpaces.SetRange("Room Code", OldStudentHostelRooms."Room No");
                RoomSpaces.SetRange("Space Code", OldStudentHostelRooms."Space No");
                RoomSpaces.SetRange(Status, RoomSpaces.Status::Vaccant);

                if RoomSpaces.FindFirst() then begin
                    // Create new allocation
                    NewStudentHostelRooms.Init();
                    NewStudentHostelRooms.Student := OldStudentHostelRooms.Student;
                    NewStudentHostelRooms."Hostel No" := OldStudentHostelRooms."Hostel No";
                    NewStudentHostelRooms."Room No" := OldStudentHostelRooms."Room No";
                    NewStudentHostelRooms."Space No" := OldStudentHostelRooms."Space No";
                    NewStudentHostelRooms.Semester := NewSemesterCode;
                    NewStudentHostelRooms."Academic Year" := NewAcademicYear;
                    NewStudentHostelRooms."Allocation Date" := Today;
                    NewStudentHostelRooms.Gender := OldStudentHostelRooms.Gender;

                    // Get charges from hostel card
                    if HostelCard.Get(OldStudentHostelRooms."Hostel No") then begin
                        case GetStudentSettlementType(OldStudentHostelRooms.Student, NewSemesterCode) of
                            'JAB':
                                NewStudentHostelRooms.Charges := HostelCard."JAB Fees";
                            'SSP':
                                NewStudentHostelRooms.Charges := HostelCard."SSP Fees";
                            'Special Programme':
                                NewStudentHostelRooms.Charges := HostelCard."Special Programme";
                            else
                                NewStudentHostelRooms.Charges := HostelCard."JAB Fees";
                        end;
                    end;

                    // Insert new allocation
                    if NewStudentHostelRooms.Insert() then begin
                        // Update room space status
                        RoomSpaces.Status := RoomSpaces.Status::"Fully Occupied";
                        RoomSpaces.Booked := true;
                        RoomSpaces.Modify();

                        ProcessedCount += 1;
                    end else
                        FailedCount += 1;
                end else
                    FailedCount += 1;
            end;
        until OldStudentHostelRooms.Next() = 0;

        if FailedCount > 0 then
            ErrorText := StrSubstNo('\Failed to process %1 allocations. ', FailedCount);

        exit(StrSubstNo('Successfully processed %1 student hostel allocations to semester %2.%3',
            ProcessedCount, NewSemesterCode, ErrorText));
    end;

    /// <summary>
    /// Allocate a student to a hostel room for a specific semester
    /// </summary>
    /// <param name="StudentNo">Student number</param>
    /// <param name="HostelNo">Hostel number</param>
    /// <param name="RoomNo">Room number</param>
    /// <param name="SpaceNo">Space number</param>
    /// <param name="SemesterCode">Semester code</param>
    /// <param name="AcademicYear">Academic year</param>
    /// <returns>Text message with the result of the operation</returns>
    procedure AllocateStudentToHostel(StudentNo: Code[20]; HostelNo: Code[20]; RoomNo: Code[20]; SpaceNo: Code[20];
                                      SemesterCode: Code[50]; AcademicYear: Code[30]): Text
    var
        StudentHostelRooms: Record "ACA-Students Hostel Rooms";
        RoomSpaces: Record "ACA-Room Spaces";
        HostelCard: Record "ACA-Hostel Card";
        Customer: Record Customer;
        SemesterRec: Record "ACA-Semester";
    begin
        // Validate parameters
        if StudentNo = '' then
            Error('Student number must be specified');

        if HostelNo = '' then
            Error('Hostel number must be specified');

        if RoomNo = '' then
            Error('Room number must be specified');

        if SpaceNo = '' then
            Error('Space number must be specified');

        if SemesterCode = '' then
            Error('Semester code must be specified');

        if AcademicYear = '' then
            Error('Academic year must be specified');

        // Check if student exists
        if not Customer.Get(StudentNo) then
            Error('Student %1 does not exist', StudentNo);

        // Check if hostel exists
        if not HostelCard.Get(HostelNo) then
            Error('Hostel %1 does not exist', HostelNo);

        // Check if semester exists
        if not SemesterRec.Get(SemesterCode) then
            Error('Semester %1 does not exist', SemesterCode);

        // Check if space is available
        RoomSpaces.Reset();
        RoomSpaces.SetRange("Hostel Code", HostelNo);
        RoomSpaces.SetRange("Room Code", RoomNo);
        RoomSpaces.SetRange("Space Code", SpaceNo);
        RoomSpaces.SetRange(Status, RoomSpaces.Status::Vaccant);

        if not RoomSpaces.FindFirst() then
            Error('Space %1 in room %2 of hostel %3 is not available', SpaceNo, RoomNo, HostelNo);

        // Check if student already has allocation in this semester
        StudentHostelRooms.Reset();
        StudentHostelRooms.SetRange(Student, StudentNo);
        StudentHostelRooms.SetRange(Semester, SemesterCode);

        if StudentHostelRooms.FindFirst() then
            Error('Student %1 already has a hostel allocation for semester %2', StudentNo, SemesterCode);

        // Create new allocation
        StudentHostelRooms.Init();
        StudentHostelRooms.Student := StudentNo;
        StudentHostelRooms."Hostel No" := HostelNo;
        StudentHostelRooms."Room No" := RoomNo;
        StudentHostelRooms."Space No" := SpaceNo;
        StudentHostelRooms.Semester := SemesterCode;
        StudentHostelRooms."Academic Year" := AcademicYear;
        StudentHostelRooms."Allocation Date" := Today;
        StudentHostelRooms.Gender := Customer.Gender;

        // Get charges from hostel card
        case GetStudentSettlementType(StudentNo, SemesterCode) of
            'JAB':
                StudentHostelRooms.Charges := HostelCard."JAB Fees";
            'SSP':
                StudentHostelRooms.Charges := HostelCard."SSP Fees";
            'Special Programme':
                StudentHostelRooms.Charges := HostelCard."Special Programme";
            else
                StudentHostelRooms.Charges := HostelCard."JAB Fees";
        end;

        // Insert new allocation
        if StudentHostelRooms.Insert() then begin
            // Update room space status
            RoomSpaces.Status := RoomSpaces.Status::"Fully Occupied";
            RoomSpaces.Booked := true;
            RoomSpaces.Modify();

            exit(StrSubstNo('Successfully allocated student %1 to hostel %2, room %3, space %4 for semester %5',
                StudentNo, HostelNo, RoomNo, SpaceNo, SemesterCode));
        end else
            Error('Failed to allocate student %1 to hostel', StudentNo);
    end;

    /// <summary>
    /// Clear a student's hostel allocation for a specific semester
    /// </summary>
    /// <param name="StudentNo">Student number</param>
    /// <param name="SemesterCode">Semester code</param>
    /// <returns>Text message with the result of the operation</returns>
    procedure ClearStudentHostelAllocation(StudentNo: Code[20]; SemesterCode: Code[50]): Text
    var
        StudentHostelRooms: Record "ACA-Students Hostel Rooms";
        RoomSpaces: Record "ACA-Room Spaces";
    begin
        // Validate parameters
        if StudentNo = '' then
            Error('Student number must be specified');

        if SemesterCode = '' then
            Error('Semester code must be specified');

        // Find student's hostel allocation
        StudentHostelRooms.Reset();
        StudentHostelRooms.SetRange(Student, StudentNo);
        StudentHostelRooms.SetRange(Semester, SemesterCode);

        if not StudentHostelRooms.FindFirst() then
            Error('No hostel allocation found for student %1 in semester %2', StudentNo, SemesterCode);

        // Update room space status
        RoomSpaces.Reset();
        RoomSpaces.SetRange("Hostel Code", StudentHostelRooms."Hostel No");
        RoomSpaces.SetRange("Room Code", StudentHostelRooms."Room No");
        RoomSpaces.SetRange("Space Code", StudentHostelRooms."Space No");

        if RoomSpaces.FindFirst() then begin
            RoomSpaces.Status := RoomSpaces.Status::Vaccant;
            RoomSpaces.Booked := false;
            RoomSpaces.Modify();
        end;

        // Delete allocation
        StudentHostelRooms.Delete();

        exit(StrSubstNo('Successfully cleared hostel allocation for student %1 in semester %2',
            StudentNo, SemesterCode));
    end;

    /// <summary>
    /// Get a student's settlement type for a specific semester
    /// </summary>
    /// <param name="StudentNo">Student number</param>
    /// <param name="SemesterCode">Semester code</param>
    /// <returns>Settlement type (JAB, SSP, Special Programme)</returns>
    local procedure GetStudentSettlementType(StudentNo: Code[20]; SemesterCode: Code[50]): Text
    var
        CourseReg: Record "ACA-Course Registration";
        Programme: Record "ACA-Programme";
    begin
        CourseReg.Reset();
        CourseReg.SetRange("Student No.", StudentNo);
        CourseReg.SetRange(Semester, SemesterCode);

        if CourseReg.FindFirst() then begin
            if Programme.Get(CourseReg.Programmes) then begin
                if Programme."Special Programme" then
                    exit('Special Programme')
                else if CourseReg."Settlement Type" = 'KUCCPS' then
                    exit('JAB')
                else if CourseReg."Settlement Type" = 'PSSP' then
                    exit('SSP');
            end;
        end;

        exit('JAB'); // Default to JAB if no specific settlement type found
    end;

    /// <summary>
    /// Generate a report of student hostel allocations for a specific semester
    /// </summary>
    /// <param name="SemesterCode">Semester code</param>
    /// <returns>Text message with the result of the operation</returns>
    procedure GenerateHostelAllocationReport(SemesterCode: Code[50]): Text
    var
        StudentHostelRooms: Record "ACA-Students Hostel Rooms";
        TotalAllocations: Integer;
        MaleCount: Integer;
        FemaleCount: Integer;
    begin
        // Validate parameters
        if SemesterCode = '' then
            Error('Semester code must be specified');

        // Count allocations
        StudentHostelRooms.Reset();
        StudentHostelRooms.SetRange(Semester, SemesterCode);
        TotalAllocations := StudentHostelRooms.Count;

        // Count male allocations
        StudentHostelRooms.Reset();
        StudentHostelRooms.SetRange(Semester, SemesterCode);
        StudentHostelRooms.SetRange(Gender, StudentHostelRooms.Gender::Male);
        MaleCount := StudentHostelRooms.Count;

        // Count female allocations
        StudentHostelRooms.Reset();
        StudentHostelRooms.SetRange(Semester, SemesterCode);
        StudentHostelRooms.SetRange(Gender, StudentHostelRooms.Gender::Female);
        FemaleCount := StudentHostelRooms.Count;

        exit(StrSubstNo('Hostel Allocation Report for Semester %1:\Total Allocations: %2\Male Students: %3\Female Students: %4',
            SemesterCode, TotalAllocations, MaleCount, FemaleCount));
    end;
}