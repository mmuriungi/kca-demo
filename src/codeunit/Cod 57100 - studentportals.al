codeunit 57100 studentportals
{
    trigger OnRun()
    begin
        PreRegisterStudents2('SAS/CY/01988/020', 'Y3S2', 'SEM 2 2022/2023', 'BAC', '2022/2023', 'KUCCPS', '');
        //AppMgt.SendApproval(61125,'LV000958',31,0,'',0);
        //CheckFeeStatus('ACR/00204/019','SEM 1 19/20');
        //GenerateStudentStatement('CI/00136/018','FeeStatement'+'-CI00136018');

    end;

    var
        "Employee Card": Record "HRM-Employee c";
        "Supervisor Card": Record "User Setup";
        ApprovalEntry: Record "Approval Entry";
        ApprovalEntry_2: Record "Approval Entry";
        NoSeriesMgt: Codeunit 396;
        NextLeaveApplicationNo: Code[20];
        EmployeeUserId: Text;
        SupervisorId: Text;
        "Supervisor ID": Text;
        test: Boolean;
        testDate: Date;
        dates: Record "Date";
        varDaysApplied: Decimal;
        Customer: Record "Customer";
        "Fee By Stage": Record "ACA-Fee By Unit";
        CourseRegistration: Record "ACA-Course Registration";
        AppMgt: Codeunit 439;
        Text004: Label 'Approval Setup not found.';
        RelieverName: Text;
        ExamResults: Record "ACA-Exam Results";
        showmessage: Boolean;
        ManualCancel: Boolean;
        State: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        tableNo: Integer;
        ApproverComments: Record "Approval Comment Line";
        GenSetup: Record "ACA-General Set-Up";
        NextStoreqNo: Code[10];
        NextMtoreqNo: Code[10];
        Programme: Record "ACA-Programme";
        Receiptz: Record "ACA-Receipt";
        StudentCard: Record "Customer";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        CurrentSem: Record "ACA-Semesters";
        StudCharges: Record "ACA-Std Charges";
        AcademicYr: Record "ACA-Academic Year";
        UnitSubjects: Record "ACA-Units/Subjects";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        StudentUnits: Record "ACA-Student Units";
        StudentUnitBaskets: Record "ACA-Student Units Reservour";
        EmployeeCard: Record "HRM-Employee C";
        LedgerEntries: Record "Detailed Cust. Ledg. Entry";
        Stages: Record "ACA-Programme Stages";
        HostelLedger: Record "ACA-Hostel Ledger";
        HostelRooms: Record "ACA-Students Hostel Rooms";
        HostelCard: Record "ACA-Hostel Card";
        HostelBlockRooms: Record "ACA-Hostel Block Rooms";
        RoomSpaces: Record "ACA-Room Spaces";
        PurchaseRN: Record "Purchase Header";
        LecEvaluation: Record "ACA-Lecturers Evaluation";
        ExamsSetup: Record "ACA-Exams Setup";
        AplicFormHeader: Record "ACA-Applic. Form Header";
        ProgEntrySubjects: Record "ACA-Programme Entry Subjects";
        ApplicFormAcademic: Record "ACA-Applic. Form Academic";
        Intake: Record "ACA-Intake";
        ProgramSem: Record "ACA-Programme Semesters";
        filename2: Text[250];
        FILESPATH: Label 'C:\inetpub\wwwroot\StudentsPortal\Downloads\';
        FILESPATH_A: Label 'C:\inetpub\wwwroot\ApplyLive\Downloads\';
        FILESPATH_SSP: Label 'C:\inetpub\wwwroot\ApplyLive\Downloads\';
        FILESPATH_APP: Label 'C:\inetpub\wwwroot\AdmissionsPortal\Downloads\';
        /* FILESPATH_A: Label 'C:\PORTALS\TMUCApply\TMUCApply\Downloads\';
        FILESPATH_SSP: Label 'C:\PORTALS\TMUCApply\TMUCApply\Downloads\'; */
        AdmissionFormHeader: Record "ACA-Applic. Form Header";
        ApplicQualification: Record "ACA-Applic. Form Qualification";
        ApplicpPostGraduate: Record "ACA-Applic Form PostGraduate";
        ApplicPostEmployment: Record "ACA-Applic. Form Employment";
        ApplicPhd: Record "ACA-Applic Form pHD additional";
        ApplicPostReferee: Record "ACA-Applic Form Referee";
        //ImportsBuffer: Record "77762";
        Admissions: Record "ACA-Applic. Form Header";
        ApplicationSubject: Record "ACA-Applic. Form Academic";
        AdmissionSubject: Record "ACA-Applic. Setup Subjects";
        LineNo: Integer;
        MedicalCondition: Record "ACA-Medical Condition";
        AdmissionMedical: Record "ACA-Adm. Form Medical Form";
        AdmissionFamily: Record "ACA-Adm. Form Family Medical";
        Immunization: Record "ACA-Immunization";
        AdmissionImmunization: Record "ACA-Adm. Form Immunization";
        AdminKin: Record "ACA-Adm. Form Next of Kin";
        StudentKin: Record "ACA-Student Kin";
        StudentGuardian: Record "ACA-Student Sponsors Details";
        Approvals: Codeunit 439;
        SupUnits: Record "Aca-Special Exams Details";
        SupUnitsBasket: Record "Aca-Special Exams Basket";
        CourseReg: Record "ACA-Course Registration";
        filename: Text;
        IStream: InStream;
        Bytes: DotNet Bytes;
        Convert: DotNet Convert;
        MemStream: DotNet MemoryStream;
        TTTimetableFInalCollector: Record "ACA-Time Table";
        EXTTimetableFInalCollector: Record "ACA-Time Table";
        KUCCPSRaw: Record "KUCCPS Imports";
        ImportsBuffer: Record "ACA-Imp. Receipts Buffer";
        ClearanceHeader: Record "ACA-Clearance Header";
        NextJobapplicationNo: Text;
        studetUnits: Record "ACA-Student Units";
        StudentsTransfer: Record "ACA-Students Transfer";
        AcaSpecialExamsDetailss: Record "Aca-Special Exams Details";
        InterSchoolTransfer: Record "ACA-Students Transfer";
        ProgStages: Record "ACA-Programme Stages";
        ClassifiactionStudents: Record "ACA-Exam Classification Studs";
        OnlineUsersz: Record OnlineUsers;
        FullNames: Text;
        fabList: Record "ACA-Applic. Form Header";
        programs: Record "ACA-Programme";
        AdminSetup: Record "ACA-Adm. Number Setup";
        programstages: Record "ACA-Programme Stages";
        intakes: Record "ACA-Intake";
        semesters: Record "ACA-Programme Semesters";
        centralsetup: Record "ACA-Academics Central Setups";
        relationships: Record Relative;
        //counties: Record County;
        countries: Record "Country/Region";
        campus: Record "Dimension Value";
        studymodes: Record "ACA-Student Types";
        //ethnicity: Record "HRM-Ethnicity";
        marketingstrategies: Record "ACA-Marketing Strategies";
        religions: Record "ACA-Religions";
        counties: Record County;
        unitregapprovals: Record RegProcessApprovalEntry;
        BlockRooms: Record "ACA-Hostel Block Rooms";
        StudentHostelRooms: Record "ACA-Students Hostel Rooms";
        DefferedStudents: Record defferedStudents;
        applicqualifications: Record "ACA-Applic. Form Qualification";
        entrysubjects: Record "ACA-Programme Entry Subjects";
        hostelItems: Record "ACA-Std Hostel Inventory Items";
        hostelInventory: Record "ACA-Hostel Inventory";
        stdClearance: Record "Student Clerance";
        dimensions: Record "Dimension Value";
        ApprovalsMgmt: Codeunit "Approval Mgnt. Util.";
        ProgramOptions: Record "ACA-Programme Options";
        // graduationlist: Record ;
        accommodationBooking: Record "Accomodation and Booking";
#pragma warning disable AL0667

#pragma warning restore AL0667
    procedure IsEligibleforGraduation(stdNo: Code[20]) msg: Boolean
    begin
        // graduationlist.Reset;
        // graduationlist.SetRange("Admission No", stdNo);
        // if graduationlist.Find('-') then begin
        //     msg := true;
        // end;
    end;

    // procedure GetGraduationApplications(stdNo: Code[20]) msg: Text
    // var
    //     approver: Text;
    // begin
    //     stdClearance.Reset;
    //     stdClearance.SetRange("Student No", stdNo);
    //     if stdClearance.Find('-') then begin
    //         repeat
    //             ApprovalEntry.Reset;
    //             ApprovalEntry.SetRange("Document No.", stdClearance."Clearance No");
    //             ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
    //             ApprovalEntry.SetRange("Table ID", Database::"Student Clerance");
    //             if ApprovalEntry.Find('-') then begin
    //                 /*"Employee Card".Reset;
    //                 "Employee Card".SetRange("No.", ApprovalEntry."Approver ID");
    //                 if "Employee Card".Find('-') then begin
    //                     approver := "Employee Card"."Department Name";
    //                 end;*/
    //                 approver := GetFullName(ApprovalEntry."Approver ID");
    //             end else begin
    //                 approver := ' '
    //             end;
    //             msg += stdClearance."Clearance No" + '::' + Format(stdClearance.Status) + '::' + Format(stdClearance."Graduation Fee Paid") + '::' + approver + ':::';
    //         until stdClearance.Next = 0;
    //     end;
    // end;

    procedure GetFullName(empNo: Code[20]) fullname: Text;
    begin

        fullname := '';
        if EmployeeCard."First Name" <> '' then
            fullname += EmployeeCard."First Name";
        if EmployeeCard."Middle Name" <> '' then begin
            if fullname <> '' then begin
                fullname += ' ' + EmployeeCard."Middle Name";
            end else
                fullname += EmployeeCard."Middle Name";
        end;
        if EmployeeCard."Last Name" <> '' then
            fullname += ' ' + EmployeeCard."Last Name";
    end;

    procedure GraduationClearanceApplication(stdNo: Code[20]; dept: Code[20]; school: Code[20]) msg: Text
    var
        AppNo: Code[20];
    begin
        AppNo := NoSeriesMgt.GetNextNo('STD CLR', 0D, TRUE);
        stdClearance.Init;
        Customer.Reset;
        Customer.SetRange("No.", stdNo);
        if Customer.Find('-') then begin
            Customer.calcfields(Balance);
            stdClearance."Clearance No" := AppNo;
            stdClearance."Student No" := stdNo;
            stdClearance."Student Name " := Customer.Name;
            stdClearance."Department Code" := dept;
            stdClearance.School := school;
            stdClearance."Mobile No" := Customer."Mobile Phone No.";
            stdClearance.Insert;
            if Customer.Balance <= 0 then begin
                stdClearance.Reset;
                stdClearance.SetRange("Clearance No", AppNo);
                if stdClearance.Find('-') then begin
                    If ApprovalsMgmt.CheckstudentClearanceWorkflowEnable(stdClearance) then
                        ApprovalsMgmt.OnSendstudentClearanceForApproval(stdClearance);
                end;
            end;
            msg := AppNo;
        end
    end;

    Procedure GetDepartments() msg: Text
    begin
        dimensions.Reset;
        dimensions.SetRange("Dimension Code", 'DEPARTMENT');
        dimensions.SetFilter(Name, '<>%1', '');
        if dimensions.Find('-') then begin
            repeat
                msg += dimensions.Code + '::' + dimensions.Name + ':::';
            until dimensions.Next = 0;
        end
    end;

    Procedure GetFaculties() msg: Text
    begin
        dimensions.Reset;
        dimensions.SetRange("Dimension Code", 'FACULTY');
        dimensions.SetFilter(Name, '<>%1', '');
        if dimensions.Find('-') then begin
            repeat
                msg += dimensions.Code + '::' + dimensions.Name + ':::';
            until dimensions.Next = 0;
        end
    end;

    procedure GetEntrySubjects(progcode: Code[20]) subjects: Text
    begin
        entrysubjects.Reset;
        entrysubjects.SetRange(Programme, progcode);
        if entrysubjects.Find('-') then begin
            Repeat
                subjects += entrysubjects.Subject + '::';
            until entrysubjects.Next = 0;
        end;
    end;

    procedure GetRequirementDescription(progcode: Code[20]) req: Text
    begin
        programs.Reset;
        programs.SetRange(Code, progcode);
        if programs.Find('-') then begin
            req := programs."Program Requirement";
        end;
    end;

    procedure GenerateAdmLetter2(AdmNo: Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH_A + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        /*KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Admin,AdmNo);

      IF KUCCPSRaw.FIND('-') THEN BEGIN
        //REPORT.SAVEASPDF(51343,filename,KUCCPSRaw);
        IF AdmNo<>'' THEN
        REPORT.SAVEASPDF(51863,filename,AdmissionFormHeader);*/





        AdmissionFormHeader.RESET;
        AdmissionFormHeader.SETRANGE(AdmissionFormHeader."Admission No", AdmNo);

        IF AdmissionFormHeader.FIND('-') THEN BEGIN
            //REPORT.SAVEASPDF(51343,filename,AdmissionFormHeader);
            REPORT.SAVEASPDF(Report::"Official Admission Letter -JAB", filename, KUCCPSRaw);
        END;

    end;

    procedure GenerateStudentStatement("Student No": Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", "Student No");

        IF Customer.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Student Fee Statement 2", filename, Customer);
        END;
    end;

    // Procedure FetchStudentUnitsForMarks(SemesterCode: Code[20]; ProgCode: Code[20]; UnitCode: Code[20]; LectCode: Code[20]) ResBufferDetails: Record "TBL Exam Res. Buff. Det"
    // var
    //     ExamRes: Record "ACA-Exam Results";
    //     ExamResCAT: Record "ACA-Exam Results";
    //     StudUnits: Record "ACA-Student Units";
    //     Semes: Record "ACA-Semesters";
    //     emps: Record "HRM-Employee C";
    // begin
    //     // if confirm('Submit Filters?', true) = false then Error('Cancelled by user!');
    //     if ProgCode = '' then Error('Specify Programme FIlter!');
    //     if SemesterCode = '' then Error('Specify Semester FIlter!');
    //     if UnitCode = '' then Error('Specify Unit FIlter!');
    //     if LectCode = '' then Error('Specify Lecturer FIlter!');
    //     emps.Reset();
    //     emps.SetRange("No.", LectCode);
    //     if emps.Find('-') then;

    //     Semes.Reset();
    //     Semes.SetRange("code", SemesterCode);
    //     if Semes.Find('-') then
    //         Semes.TestField("Academic Year")
    //     else
    //         Error('Missing Academic Year on Semester definition');

    //     StudUnits.Reset();
    //     StudUnits.SetRange(Programme, ProgCode);
    //     StudUnits.SetRange(semester, SemesterCode);
    //     StudUnits.SetRange(Unit, UnitCode);
    //     StudUnits.SetRange("Reg. Reversed", false);
    //     if StudUnits.find('-') then begin
    //         repeat
    //         begin
    //             clear(ExamRes);
    //             ExamRes.Reset();
    //             ExamRes.SetRange(Programmes, ProgCode);
    //             ExamRes.SetRange(semester, SemesterCode);
    //             ExamRes.SetRange(Unit, UnitCode);
    //             examRes.SetRange("Student No.", StudUnits."Student No.");
    //             ExamRes.SetFilter(ExamType, '%1|%2|%3', 'EXAM', 'FINAL EXAM', 'FINAL');
    //             if ExamRes.find('-') then;
    //             clear(ExamResCAT);
    //             ExamResCAT.Reset();
    //             ExamResCAT.SetRange(Programmes, ProgCode);
    //             ExamResCAT.SetRange(semester, SemesterCode);
    //             ExamResCAT.SetRange(Unit, UnitCode);
    //             ExamResCAT.SetRange("Student No.", StudUnits."Student No.");
    //             ExamResCAT.SetFilter(ExamType, '%1|%2|%3|%4', 'CAT', 'CATS', 'CAT 1', 'CAT 2');
    //             if ExamResCAT.find('-') then;
    //             ResBufferDetails.Init();
    //             ResBufferDetails."Academic Year" := Semes."Academic Year";
    //             ResBufferDetails."Semester Code" := SemesterCode;
    //             ResBufferDetails."Lecturer Code" := LectCode;
    //             ResBufferDetails."Student No." := StudUnits."Student No.";
    //             ResBufferDetails."Programme Code" := ProgCode;
    //             ResBufferDetails."Unit Code" := StudUnits.Unit;
    //             if ExamResCAT.Score <> 0 then begin
    //                 ResBufferDetails."CAT Score" := ExamResCAT.Score;
    //                 ResBufferDetails."CAT Captured By" := ExamResCAT."User Code";
    //             end;
    //             if ExamRes.Score <> 0 then begin
    //                 ResBufferDetails."Exam Score" := ExamRes.Score;
    //                 ResBufferDetails."Exam Captured By" := ExamRes."User Code";
    //             end;
    //             if ResBufferDetails.Insert(true) then;
    //             clear(ResBufferDetails);
    //             ResBufferDetails.Reset();
    //             ResBufferDetails.SetRange(ResBufferDetails."Programme Code", ProgCode);
    //             ResBufferDetails.SetRange(ResBufferDetails."Semester Code", SemesterCode);
    //             ResBufferDetails.SetRange(ResBufferDetails."Unit Code", UnitCode);
    //             ResBufferDetails.SetRange(ResBufferDetails."Student No.", StudUnits."Student No.");
    //             if ResBufferDetails.Find('-') then begin
    //                 if ResBufferDetails."CAT Score" = 0 then
    //                     if ExamResCAT.Score <> 0 then begin
    //                         ResBufferDetails."CAT Score" := ExamResCAT.Score;
    //                         ResBufferDetails."CAT Captured By" := ExamResCAT."User Code";
    //                     end;
    //                 if ResBufferDetails."Exam Score" = 0 then
    //                     if ExamRes.Score <> 0 then begin
    //                         ResBufferDetails."Exam Score" := ExamRes.Score;
    //                         ResBufferDetails."Exam Captured By" := ExamRes."User Code";
    //                     end;
    //                 if ResBufferDetails.Modify(true) then;
    //             end;
    //         end;
    //         until StudUnits.Next() = 0;
    //     end;
    //     clear(ResBufferDetails);
    //     ResBufferDetails.Reset();
    //     ResBufferDetails.SetRange(ResBufferDetails."Programme Code", ProgCode);
    //     ResBufferDetails.SetRange(ResBufferDetails."Semester Code", SemesterCode);
    //     ResBufferDetails.SetRange(ResBufferDetails."Unit Code", UnitCode);
    //     if ResBufferDetails.Find('-') then begin

    //     end else
    //         Error('No students Registered in ' + ProgCode + ' ' + UnitCode + ' ' + SemesterCode);

    // end;

    procedure AllMyUnits(StudenNo: code[20]) AcaStudUnits: Record "ACA-Student Units";
    var

    begin
        Clear(AcaStudUnits);
        AcaStudUnits.Reset();
        AcaStudUnits.SetRange("Student No.", StudenNo);
        if AcaStudUnits.find('-') then;
    end;

    // procedure SelectMyUnits(StudenNo: code[20]; Stage: code[20]; ProgCode: code[20]) UnitsBasket: Record "ACA-Students Units Busket";
    // var

    //     UnitsSubjects: Record "ACA-Units/Subjects";

    // begin
    //     // Populate Units Busket Here Before Picking

    //     Clear(UnitsSubjects);
    //     UnitsSubjects.Reset();
    //     if ((Stage = 'Y1S1') OR (Stage = 'Y1S2')) then
    //         UnitsSubjects.SetFilter("Stage Code", '%1|%2', 'Y1S1', 'Y1S2')
    //     else
    //         if ((Stage = 'Y2S1') OR (Stage = 'Y2S2')) then
    //             UnitsSubjects.SetFilter("Stage Code", '%1|%2', 'Y2S1', 'Y2S2')
    //         else
    //             if ((Stage = 'Y3S1') OR (Stage = 'Y3S2')) then
    //                 UnitsSubjects.SetFilter("Stage Code", '%1|%2', 'Y3S1', 'Y3S2')
    //             else
    //                 if ((Stage = 'Y4S1') OR (Stage = 'Y4S2')) then
    //                     UnitsSubjects.SetFilter("Stage Code", '%1|%2', 'Y4S1', 'Y4S2')
    //                 else
    //                     if ((Stage = 'Y5S1') OR (Stage = 'Y5S2')) then
    //                         UnitsSubjects.SetFilter("Stage Code", '%1|%2', 'Y5S1', 'Y5S2')
    //                     else
    //                         if ((Stage = 'Y6S1') OR (Stage = 'Y6S2')) then
    //                             UnitsSubjects.SetFilter("Stage Code", '%1|%2', 'Y6S1', 'Y6S2');

    //     if UnitsSubjects.find('-') then begin
    //         repeat
    //         begin
    //             UnitsBasket.Init();
    //             UnitsBasket."Student No." := StudenNo;
    //             UnitsBasket.Description := UnitsSubjects.Desription;
    //             UnitsBasket."Unit Code" := UnitsSubjects.Code;
    //             if UnitsBasket.Insert(true) then;
    //         end;
    //         until UnitsSubjects.Next() = 0;
    //     end;
    //     Clear(UnitsBasket);
    //     UnitsBasket.Reset();
    //     UnitsBasket.SetRange("Student No.", StudenNo);
    //     UnitsBasket.SetRange(Registered, false);
    //     if UnitsBasket.find('-') then;
    // end;


    procedure GenerateStudentProformaInvoice("Programme Code": Text; "Stage Code": Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        "Fee By Stage".RESET;
        "Fee By Stage".SETRANGE("Fee By Stage"."Programme Code", "Programme Code");
        "Fee By Stage".SETRANGE("Fee By Stage"."Stage Code", "Stage Code");

        IF "Fee By Stage".FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(Report::"Student Proforma Invoice", filename, "Fee By Stage");
        END;
    end;


    procedure GenerateStudentExamCard(StudentNo: Text; Sem: Text; filenameFromApp: Text) msg: Text
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Semester, Sem);
        IF CourseRegistration.FINDFIRST THEN BEGIN
            REPORT.SAVEASPDF(report::"Exam Card Final", filename, CourseRegistration);
            /*
            IF CourseRegistration.FIND('-') THEN BEGIN
              REPORT.SAVEASPDF(51515,filename,CourseRegistration);
            END;
            Customer.RESET;
            Customer.SETRANGE("No.",StudentNo);
            Customer.SETFILTER("Semester Filter",sem);
            IF Customer.FINDFIRST THEN BEGIN
               REPORT.SAVEASPDF(51515,filename,Customer);*/
        END;

    end;


    procedure GenerateStudentProvisionalResults(StudentNo: Text; filenameFromApp: Text; sem: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Semester, sem);

        IF CourseRegistration.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Official University Resultslip", filename, CourseRegistration);
        END;
    end;




    procedure GetProfilePictureStudent(StudentNo: Text) BaseImage: Text
    var
        ToFile: Text;
        IStream: InStream;
    // Bytes: DotNet BCArray;
    // Convert: DotNet BCConvert;
    // MemoryStream: DotNet BCMemoryStream;
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", StudentNo);

        IF Customer.FIND('-') THEN BEGIN
            // IF Customer.Picture.HASVALUE THEN BEGIN
            //     Customer.CALCFIELDS(Picture);
            //     Customer.Picture.CREATEINSTREAM(IStream);
            //     MemoryStream := MemoryStream.MemoryStream();
            //     COPYSTREAM(MemoryStream, IStream);
            //     Bytes := MemoryStream.GetBuffer();
            //     BaseImage := Convert.ToBase64String(Bytes);
            // END;
        END;
    end;


    procedure ExamResultsCreate(StudentNo: Text; Prog: Text; Stage: Text; Sem: Text; Unit: Text; Score: Integer; ExamType: Text; AcademicYear: Text; RegistrationType: Option)
    begin
        ExamResults.INIT;
        ExamResults."Student No." := StudentNo;
        ExamResults.Programmes := Prog;
        ExamResults.Stage := Stage;
        ExamResults.Unit := Unit;
        ExamResults.Semester := Sem;
        ExamResults.Score := Score;
        ExamResults.ExamType := ExamType;
        ExamResults."Academic Year" := AcademicYear;
        //ExamResults."Registration Type":=RegistrationType;
        ExamResults.INSERT;
    end;

    procedure CheckValidOnlineUserzEmail(email: Text) Msg: Text
    begin
        OnlineUsersz.Reset();
        OnlineUsersz.SetRange(OnlineUsersz."Email Address", email);
        if OnlineUsersz.Find('-') then begin
            Msg := 'Yes::' + OnlineUsersz.Password;
        end;
    end;

    procedure StaffLogin(Username: Text; UserPassword: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'Incorrect Username or Password';
        TXTCorrectDetails: Label 'Login';
        FullNames: Text;
    begin
        "Employee Card".RESET;
        "Employee Card".SETRANGE("Employee Card"."No.", Username);
        IF "Employee Card".FIND('-') THEN BEGIN
            IF ("Employee Card"."Changed Password" = TRUE) THEN BEGIN
                IF ("Employee Card"."Portal Password" = UserPassword) THEN BEGIN
                    FullNames := "Employee Card"."First Name" + ' ' + "Employee Card"."Middle Name" + ' ' + "Employee Card"."Last Name";
                    Message := TXTCorrectDetails + '::' + FORMAT("Employee Card"."Changed Password") + '::' + "Employee Card"."No." + '::' + "Employee Card"."User ID" + '::' + FullNames;
                END ELSE BEGIN
                    Message := TXTIncorrectDetails + '::' + FORMAT("Employee Card"."Changed Password");
                END
            END ELSE BEGIN
                IF ("Employee Card"."ID Number" = UserPassword) THEN BEGIN
                    Message := TXTCorrectDetails + '::' + FORMAT("Employee Card"."Changed Password") + '::' + "Employee Card"."No." + '::' + "Employee Card"."User ID" + '::' + FullNames;
                END ELSE BEGIN
                    Message := TXTIncorrectDetails + '::' + FORMAT("Employee Card"."Changed Password");
                END
            END
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::';
        END
    end;


    procedure GetFullName(EmployeeNo: Text)
    begin
        "Employee Card".RESET;
        "Employee Card".SETRANGE("Employee Card"."No.", EmployeeNo);

        IF "Employee Card".FIND('-')
        THEN BEGIN
            MESSAGE("Employee Card".FullName);
        END
    end;





    procedure PreRegisterStudents2(studentNo: Text; stage: Text; semester: Text; Programme: Text; AcademicYear: Text; settlementType: Text; ProgrammeOption: Code[20]) CourseRegId: Code[30]
    var
        Progs: Code[20];
        GenBatch: Record "Gen. Journal Batch";
        GenTemplates: record "Gen. Journal Template";
        PictureExists: Boolean;
        StudentPayments: Record "ACA-Std Payments";
        StudentCharges: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        Receipt: Record "ACA-Receipt";
        ReceiptItems: Record "ACA-Receipt Items";
        GenSetUp: Record "ACA-General Set-Up";
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
        VATEntry: Record "VAT Entry";
        CReg: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        Receipts: Record "ACA-Receipt";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        ChangeLog: Record "Change Log Entry";
        CurrentBal: Decimal;
        Prog: Record "ACA-Programme";
        "Settlement Type": Record "ACA-Settlement Type";
        Recz: Record Customer;
        AccPayment: Boolean;
        // SettlementType: Code[20];
        myInt: Integer;
        SettlementTypes: Record "ACA-Settlement Type";
        GenJnl2: Record "Gen. Journal Line";
        SpecificStudBatch: Code[10];
    begin
        Clear(SpecificStudBatch);
        SpecificStudBatch := CopyStr(studentNo, 4, 10);
        GenSetup.GET;
        CLEAR(Progs);
        IF EVALUATE(Progs, Programme) THEN;
        CourseReg.RESET;
        CourseReg.SETRANGE(CourseReg."Student No.", studentNo);
        CourseReg.SETRANGE(CourseReg.Programmes, Progs);
        CourseReg.SETRANGE(CourseReg.Semester, semester);
        CourseReg.SETRANGE(CourseReg.Reversed, FALSE);

        IF CourseReg.FIND('-') THEN
            ERROR('You have already registered for Semester %1, Year %2', semester, CourseReg.Stage);

        CourseReg.INIT;
        CourseRegId := NoSeriesMgt.GetNextNo(GenSetup."Registration Nos.", TODAY, TRUE);
        CourseReg."Reg. Transacton ID" := CourseRegId;
        CourseReg."Student No." := studentNo;
        CourseReg.Options := ProgrammeOption;
        CourseReg.Programmes := Progs;
        CourseReg.VALIDATE(Programmes);
        CourseReg.Stage := stage;
        CourseReg.VALIDATE(Stage);
        //CourseReg."Date Registered":=TODAY;
        //CourseReg.Semester:=semester;
        //CourseReg."Academic Year":=AcademicYear;
        CourseReg."Settlement Type" := settlementType;
        CourseReg.INSERT(TRUE);
        CourseReg.VALIDATE("Settlement Type");
        /*if CourseReg.INSERT(TRUE) then begin
            // Post Charges for the Semester
            GenBatch.Init();
            GenBatch."Journal Template Name" := 'SALES';
            GenBatch.Name := SpecificStudBatch;
            if GenBatch.Insert(true) then;

            GenJnl.RESET;
            GenJnl.SETRANGE(GenJnl."Journal Template Name", 'SALES');
            GenJnl.SETRANGE(GenJnl."Journal Batch Name", SpecificStudBatch);
            GenJnl.DELETEALL;

            GenSetUp.GET();
            /////// Buld GenLedgerHere

            //BILLING
            Recz.Reset();
            Recz.SetRange("No.", studentNo);
            if Recz.find('-') then;
            AccPayment := FALSE;
            StudentCharges.RESET;
            StudentCharges.SETRANGE(StudentCharges."Student No.", studentNo);
            StudentCharges.SETRANGE(StudentCharges.Posted, FALSE);
            StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
            StudentCharges.SETFILTER(StudentCharges.Code, '<>%1', '');
            IF StudentCharges.FIND('-') THEN BEGIN
                // IF NOT CONFIRM('Un-billed charges will be posted. Do you wish to continue?', FALSE) = TRUE THEN
                //    ERROR('You have selected to Abort Student Billing');


                // SettlementType := '';
                // CReg.RESET;
                // CReg.SETFILTER(CReg."Settlement Type", '<>%1', '');
                // CReg.SETRANGE(CReg."Student No.", ACACourseRegistration."Student No.");
                // IF CReg.FIND('-') THEN
                //     SettlementType := CReg."Settlement Type"
                // ELSE
                //     ERROR('The Settlement Type Does not Exists in the Course Registration');

                SettlementTypes.GET(SettlementType);
                SettlementTypes.TESTFIELD(SettlementTypes."Tuition G/L Account");




                // MANUAL APPLICATION OF ACCOMODATION FOR PREPAYED STUDENTS BY BKK...//
                IF StudentCharges.COUNT = 1 THEN BEGIN
                    Recz.CALCFIELDS(Balance);
                    IF Recz.Balance < 0 THEN BEGIN
                        IF ABS(Recz.Balance) > StudentCharges.Amount THEN BEGIN
                            Recz."Application Method" := Recz."Application Method"::Manual;
                            AccPayment := TRUE;
                            Recz.MODIFY;
                        END;
                    END;
                END;

            END;


            //ERROR('TESTING '+FORMAT("Application Method"));

            IF Cust.GET(Recz."No.") THEN;

            //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");

            //Charge Student if not charged
            StudentCharges.RESET;
            StudentCharges.SETRANGE(StudentCharges."Student No.", Recz."No.");
            StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
            StudentCharges.SETRANGE(StudentCharges.Posted, FALSE);
            IF StudentCharges.FIND('-') THEN BEGIN

                REPEAT

                    DueDate := StudentCharges.Date;
                    IF Sems.GET(StudentCharges.Semester) THEN BEGIN
                        IF Sems.From <> 0D THEN BEGIN
                            IF Sems.From > DueDate THEN
                                DueDate := Sems.From;
                        END;
                    END;

                    GenJnl2.RESET;
                    GenJnl2.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl2.SETRANGE("Journal Batch Name", SpecificStudBatch);
                    IF GenJnl2.FIND('+') THEN;

                    GenJnl.INIT;
                    GenJnl."Line No." := GenJnl2."Line No." + 10000;
                    GenJnl."Posting Date" := TODAY;
                    GenJnl."Document No." := StudentCharges."Transacton ID";
                    GenJnl.VALIDATE(GenJnl."Document No.");
                    GenJnl."Journal Template Name" := 'SALES';
                    GenJnl."Journal Batch Name" := SpecificStudBatch;
                    GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                    //
                    IF Cust.GET(Recz."No.") THEN BEGIN
                        IF Cust."Bill-to Customer No." <> '' THEN
                            GenJnl."Account No." := Cust."Bill-to Customer No."
                        ELSE
                            GenJnl."Account No." := Recz."No.";
                    END;

                    GenJnl.Amount := StudentCharges.Amount;
                    GenJnl.VALIDATE(GenJnl."Account No.");
                    GenJnl.VALIDATE(GenJnl.Amount);
                    GenJnl.Description := StudentCharges.Description;
                    GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";

                    IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") AND
                       (StudentCharges.Charge = FALSE) THEN BEGIN
                        GenJnl."Bal. Account No." := SettlementTypes."Tuition G/L Account";

                        CReg.RESET;
                        CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                        CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                        CReg.SETRANGE(CReg."Student No.", StudentCharges."Student No.");
                        IF CReg.FIND('-') THEN BEGIN
                            IF CReg."Register for" = CReg."Register for"::Stage THEN BEGIN
                                Stages.RESET;
                                Stages.SETRANGE(Stages."Programme Code", CReg.Programmes);
                                Stages.SETRANGE(Stages.Code, CReg.Stage);
                                IF Stages.FIND('-') THEN BEGIN
                                    IF (Stages."Modules Registration" = TRUE) AND (Stages."Ignore No. Of Units" = FALSE) THEN BEGIN
                                        CReg.CALCFIELDS(CReg."Units Taken");
                                        IF CReg.Modules <> CReg."Units Taken" THEN
                                            ERROR('Units Taken must be equal to the no of modules registered for.');

                                    END;
                                END;
                            END;

                            CReg.Posted := TRUE;
                            CReg.MODIFY;
                        END;


                    END ELSE
                        IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") AND
                           (StudentCharges.Charge = FALSE) THEN BEGIN
                            //GenJnl."Bal. Account No.":=GenSetUp."Pre-Payment Account";
                            StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
                            GenJnl."Bal. Account No." := SettlementTypes."Tuition G/L Account";


                            CReg.RESET;
                            CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                            CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                            IF CReg.FIND('-') THEN BEGIN
                                CReg.Posted := TRUE;
                                CReg.MODIFY;
                            END;



                        END ELSE
                            IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" THEN BEGIN
                                IF ExamsByStage.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Semester, StudentCharges.Code) THEN
                                    GenJnl."Bal. Account No." := ExamsByStage."G/L Account";

                            END ELSE
                                IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" THEN BEGIN
                                    IF ExamsByUnit.GET(StudentCharges.Programme, StudentCharges.Stage, ExamsByUnit."Unit Code", StudentCharges.Semester,
                                    StudentCharges.Code) THEN
                                        GenJnl."Bal. Account No." := ExamsByUnit."G/L Account";

                                END ELSE
                                    IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges) OR
                                       (StudentCharges.Charge = TRUE) THEN BEGIN
                                        IF Charges.GET(StudentCharges.Code) THEN
                                            GenJnl."Bal. Account No." := Charges."G/L Account";
                                    END;


                    GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                    GenJnl."Shortcut Dimension 1 Code" := Recz."Global Dimension 1 Code";
                    IF Prog.GET(StudentCharges.Programme) THEN BEGIN
                        Prog.TESTFIELD(Prog."Department Code");
                        GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                    END;



                    GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                    GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                    GenJnl."Due Date" := DueDate;
                    GenJnl.VALIDATE(GenJnl."Due Date");
                    IF StudentCharges."Recovery Priority" <> 0 THEN;
                    //     GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                    // ELSE
                    //     GenJnl."Recovery Priority" := 25;
                    GenJnl.INSERT;

                    //Distribute Money
                    IF StudentCharges."Tuition Fee" = TRUE THEN BEGIN
                        IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                            IF (Stages."Distribution Full Time (%)" > 0) OR (Stages."Distribution Part Time (%)" > 0) THEN BEGIN
                                Stages.TESTFIELD(Stages."Distribution Account");
                                StudentCharges.TESTFIELD(StudentCharges.Distribution);
                                IF Cust.GET(Recz."No.") THEN BEGIN
                                    CustPostGroup.GET(Cust."Customer Posting Group");

                                    GenJnl2.RESET;
                                    GenJnl2.SETRANGE("Journal Template Name", 'SALES');
                                    GenJnl2.SETRANGE("Journal Batch Name", SpecificStudBatch);
                                    IF GenJnl2.FIND('+') THEN;
                                    GenJnl.INIT;
                                    GenJnl."Line No." := GenJnl2."Line No." + 10000;
                                    GenJnl."Posting Date" := TODAY;
                                    GenJnl."Document No." := StudentCharges."Transacton ID";
                                    //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                                    GenJnl.VALIDATE(GenJnl."Document No.");
                                    GenJnl."Journal Template Name" := 'SALES';
                                    GenJnl."Journal Batch Name" := SpecificStudBatch;
                                    GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                    //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
                                    GenJnl."Account No." := SettlementTypes."Tuition G/L Account";
                                    GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                    GenJnl.VALIDATE(GenJnl."Account No.");
                                    GenJnl.VALIDATE(GenJnl.Amount);
                                    GenJnl.Description := 'Fee Distribution';
                                    GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                    //GenJnl."Bal. Account No.":=Stages."Distribution Account";

                                    StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
                                    SettlementTypes.GET(StudentCharges."Settlement Type");
                                    GenJnl."Bal. Account No." := SettlementTypes."Tuition G/L Account";

                                    GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                    GenJnl."Shortcut Dimension 1 Code" := Recz."Global Dimension 1 Code";
                                    IF Prog.GET(StudentCharges.Programme) THEN BEGIN
                                        Prog.TESTFIELD(Prog."Department Code");
                                        GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                                    END;

                                    GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                                    GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");

                                    GenJnl.INSERT;

                                END;
                            END;
                        END;
                    END ELSE BEGIN
                        //Distribute Charges
                        IF StudentCharges.Distribution > 0 THEN BEGIN
                            StudentCharges.TESTFIELD(StudentCharges."Distribution Account");
                            IF Charges.GET(StudentCharges.Code) THEN BEGIN
                                Charges.TESTFIELD(Charges."G/L Account");

                                GenJnl2.RESET;
                                GenJnl2.SETRANGE("Journal Template Name", 'SALES');
                                GenJnl2.SETRANGE("Journal Batch Name", SpecificStudBatch);
                                IF GenJnl2.FIND('+') THEN;
                                GenJnl.INIT;
                                GenJnl."Line No." := GenJnl2."Line No." + 10000;
                                GenJnl."Posting Date" := TODAY;
                                GenJnl."Document No." := StudentCharges."Transacton ID";
                                GenJnl.VALIDATE(GenJnl."Document No.");
                                GenJnl."Journal Template Name" := 'SALES';
                                GenJnl."Journal Batch Name" := SpecificStudBatch;
                                GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                GenJnl."Account No." := StudentCharges."Distribution Account";
                                GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                GenJnl.VALIDATE(GenJnl."Account No.");
                                GenJnl.VALIDATE(GenJnl.Amount);
                                GenJnl.Description := 'Fee Distribution';
                                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                GenJnl."Bal. Account No." := Charges."G/L Account";
                                GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                GenJnl."Shortcut Dimension 1 Code" := Recz."Global Dimension 1 Code";

                                IF Prog.GET(StudentCharges.Programme) THEN BEGIN
                                    Prog.TESTFIELD(Prog."Department Code");
                                    GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                                END;
                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                                GenJnl.INSERT;

                            END;
                        END;
                    END;
                    //End Distribution


                    StudentCharges.Recognized := TRUE;
                    StudentCharges.MODIFY;
                    //.......BY BKK
                    StudentCharges.Posted := TRUE;
                    StudentCharges.MODIFY;

                    //CReg.Posted := TRUE;
                    //CReg.MODIFY;
                    CReg.RESET;
                    CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                    CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                    IF CReg.FIND('-') THEN BEGIN
                        CReg.Posted := TRUE;
                        CReg.MODIFY;
                    END;


                //.....END BKK

                UNTIL StudentCharges.NEXT = 0;

                Recz."Application Method" := Recz."Application Method"::"Apply to Oldest";
                Cust.Status := Cust.Status::Current;
                Cust.MODIFY;

            END;
            GenJnl.RESET;
            GenJnl.SETRANGE(GenJnl."Journal Template Name", 'SALES');
            GenJnl.SETRANGE(GenJnl."Journal Batch Name", SpecificStudBatch);
            IF GenJnl.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnl);
            END;
        end;*/
    end;

    procedure GenerateFeeStructure(Programz: Code[20]; SettlementType: Code[20]; filenameFromApp: Text) filename: Text
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        //MESSAGE('OK');
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, Programz);
        Programme.SETFILTER(Programme."Settlement Type Filter", '%1', SettlementType);

        IF Programme.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Fee Structure Summary Report", filename, Programme);   //52017726
        END;
        EXIT(filename);
    end;


    procedure GenerateReceipt(ReceiptNo: Code[20]; filenameFromApp: Text) filename: Text
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        //MESSAGE('OK');
        Receiptz.RESET;
        Receiptz.SETRANGE(Receiptz."Receipt No.", ReceiptNo);

        IF Receiptz.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Student Fee Receipts", filename, Receiptz);   //52017726
        END;
        EXIT(filename);
    end;


    procedure StudentsLogin(Username: Text; UserPassword: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'Incorrect Username or Password';
        TXTCorrectDetails: Label 'Login';
        FullNames: Text;
    begin
        StudentCard.RESET;
        StudentCard.SETRANGE(StudentCard."No.", Username);
        IF StudentCard.FIND('-') THEN BEGIN
            IF (StudentCard."Changed Password" = TRUE) THEN BEGIN
                IF (StudentCard.Password = UserPassword) THEN BEGIN
                    FullNames := StudentCard.Name;
                    Message := TXTCorrectDetails + '::' + FORMAT(StudentCard."Changed Password") + '::' + StudentCard."No." + '::' + StudentCard.Name + '::' + FORMAT(StudentCard.Status);
                END ELSE BEGIN
                    Message := TXTIncorrectDetails + '::' + FORMAT(StudentCard."Changed Password");
                END
            END ELSE BEGIN
                IF (StudentCard."ID No" = UserPassword) THEN BEGIN
                    Message := TXTCorrectDetails + '::' + FORMAT(StudentCard."Changed Password") + '::' + StudentCard."No." + '::' + StudentCard.Name + '::' + FORMAT(StudentCard.Status);
                END ELSE BEGIN
                    Message := TXTIncorrectDetails + '::' + FORMAT(StudentCard."Changed Password");
                END
            END
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::' + FORMAT(StudentCard.Status);
        END

    end;


    procedure GetStudentFullName(StudentNo: Text) Message: Text
    var
        FullDetails: Integer;
    begin
        StudentCard.RESET;
        StudentCard.SETRANGE(StudentCard."No.", StudentNo);
        IF StudentCard.FIND('-') THEN BEGIN
            Message := StudentCard."No." + '::' + StudentCard.Name + '::' + StudentCard."E-Mail" + '::' + StudentCard."ID No" + '::' + FORMAT(StudentCard.Gender) + '::' + FORMAT(StudentCard."Date Of Birth") + '::' + StudentCard."Post Code" + '::' + StudentCard.Address;

        END
    end;

    procedure GetStudentCred(StudentNo: Text) Message: Text
    begin
        StudentCard.RESET;
        StudentCard.SETRANGE(StudentCard."No.", StudentNo);
        IF StudentCard.FIND('-') THEN BEGIN
            Message := StudentCard."E-Mail" + ' :: ' + StudentCard.Password;
        END
    end;

    procedure IsStudentRegistered(StudentNo: Text; Sem: Text) Message: Text
    var
        TXTNotRegistered: Label 'Not registered';
        TXTRegistered: Label 'Registered';
    begin
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Semester, Sem);
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);
        IF CourseRegistration.FIND('-') THEN BEGIN
            Message := TXTRegistered + '::';
        END ELSE BEGIN
            Message := TXTNotRegistered + '::';
        END
    end;


    procedure LoadUnits(ProgCode: Code[20]; StageCode: Code[20]) Message: Text
    begin
        ACAUnitsSubjects.RESET;
        ACAUnitsSubjects.SETRANGE("Programme Code", ProgCode);
        ACAUnitsSubjects.SETRANGE("Stage Code", StageCode);
        ACAUnitsSubjects.SETRANGE("Time Table", TRUE);
        ACAUnitsSubjects.SETRANGE("Old Unit", FALSE);
        IF ACAUnitsSubjects.FIND('-') THEN BEGIN
            Message := ACAUnitsSubjects.Code + '::' + ACAUnitsSubjects.Desription;
        END;
    end;


    procedure GetCurrentSemData() Message: Text
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE(CurrentSem."Current Semester", TRUE);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem.Code + '::' + CurrentSem.Description + '::' + FORMAT(CurrentSem."Registration Deadline") + '::' +
  FORMAT(CurrentSem."Lock CAT Editting") + '::' + FORMAT(CurrentSem."Lock Exam Editting") + '::' + FORMAT(CurrentSem."Ignore Editing Rule")
  + '::' + FORMAT(CurrentSem."Mark entry Dealine") + '::' + FORMAT(CurrentSem."Lock Lecturer Editing") + '::' + FORMAT(CurrentSem.AllowDeanEditing) + '::' + FORMAT(CurrentSem."Unit Registration Deadline");
        END
    end;


    procedure GetStudentCourseData(StudentNo: Text; Sem: Text) Message: Text
    begin
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        //CourseRegistration.SETRANGE(CourseRegistration.Semester,Sem);
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);
        //CourseRegistration.SETRANGE(CourseRegistration.Posted,FALSE);
        CourseRegistration.SETCURRENTKEY(Stage);
        IF CourseRegistration.FIND('+') THEN BEGIN
            Message := CourseRegistration.Stage + '::' + CourseRegistration.Programmes + '::' + CourseRegistration."Reg. Transacton ID" + '::' + CourseRegistration.Semester + '::'
    + CourseRegistration."Settlement Type" + '::' + GetProgram(CourseRegistration.Programmes) + '::' + GetSchool(CourseRegistration.Programmes) + ' ::' + CourseRegistration.Options;
        END;
    end;

    procedure UpdateProgramOption(StudentNo: Code[20]; Option: Code[20]) Message: Boolean
    begin
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);
        CourseRegistration.SETCURRENTKEY(Stage);
        IF CourseRegistration.FIND('+') THEN BEGIN
            CourseRegistration.Options := Option;
            CourseRegistration.Modify;
            Message := true;
        END;
    end;

    procedure GetProgram(ProgID: Text) Message: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, ProgID);
        IF Programme.FIND('-') THEN BEGIN
            Message := Programme.Description;
        END
    end;

    procedure GetProgramMaxUnits(ProgID: Text) maxunits: Integer;
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, ProgID);
        IF Programme.FIND('-') THEN BEGIN
            maxunits := Programme."Max No. of Courses";
        END
    end;

    procedure RequireProgramOption(ProgID: Text) Message: Boolean
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, ProgID);
        IF Programme.FIND('-') THEN BEGIN
            Message := Programme."Requires Combination";
        END
    end;

    procedure GetProgramOptions(ProgID: Code[20]) Message: Text
    begin
        programOptions.RESET;
        programOptions.SETRANGE("Programme Code", ProgID);
        IF programOptions.FIND('-') THEN BEGIN
            repeat
                Message += programOptions.Code + '::' + programOptions.Desription + ' :::';
            until programOptions.Next = 0;
        END
    end;

    procedure GetBilled(StudentNo: Text; Sem: Text) Message: Text
    var
        ACACourseRegistration: Record "ACA-Course Registration";
    begin
        ACACourseRegistration.RESET;
        ACACourseRegistration.SETRANGE(ACACourseRegistration."Student No.", StudentNo);
        ACACourseRegistration.SETRANGE(ACACourseRegistration.Semester, Sem);
        ACACourseRegistration.SETRANGE(ACACourseRegistration.Reversed, FALSE);
        ACACourseRegistration.SETRANGE(ACACourseRegistration.Posted, TRUE);
        IF StudCharges.FIND('-') THEN BEGIN
            Message := ACACourseRegistration.Semester;
        END;
    end;


    procedure GetAcademicYr() Message: Text
    begin
        AcademicYr.RESET;
        AcademicYr.SETRANGE(AcademicYr.Current, TRUE);
        IF AcademicYr.FIND('-') THEN BEGIN
            Message := AcademicYr.Code + '::' + AcademicYr.Description;
        END
    end;


    procedure UnitDescription(ProgID: Text; UnitID: Text) Message: Text
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects."Programme Code", ProgID);
        UnitSubjects.SETRANGE(UnitSubjects.Code, UnitID);
        //UnitSubjects.SETRANGE(UnitSubjects."Time Table", TRUE);
        //UnitSubjects.SETRANGE(UnitSubjects."Old Unit", FALSE);
        IF UnitSubjects.FIND('-') THEN BEGIN
            Message := UnitSubjects.Desription;
        END
    end;

    procedure SendUnitsApprovalRequest(stdNo: Code[20]; prog: Code[20]; stage: Code[20]) msg: Boolean
    begin
        unitregapprovals.Reset;
        unitregapprovals.SetRange(studNo, stdNo);
        unitregapprovals.SetRange(Semester, GetCurrentSemester());
        if unitregapprovals.Find('-') then begin
            unitregapprovals."Approval Status" := unitregapprovals."Approval Status"::Resubmitted;
            unitregapprovals.Modify;
            msg := true;
        end else begin
            unitregapprovals.Init;
            unitregapprovals.studNo := stdNo;
            unitregapprovals.Semester := GetCurrentSemester();
            programs.Reset;
            programs.SetRange(Code, prog);
            if programs.Find('-') then begin
                unitregapprovals.Programe := programs.Code;
                unitregapprovals."Programme Description" := programs.Description;
            end;
            unitregapprovals.stage := stage;
            unitregapprovals."Approval Status" := unitregapprovals."Approval Status"::Submitted;
            unitregapprovals.Insert;
            msg := true;
        end;
    end;

    Procedure UnitRegStatus(stdNo: Code[20]) msg: Text
    begin
        unitregapprovals.Reset;
        unitregapprovals.SetRange(studNo, stdNo);
        unitregapprovals.SetRange(Semester, GetCurrentSemester());
        if unitregapprovals.Find('-') then begin
            msg := FORMAT(unitregapprovals."Approval Status");
        end;
    end;

    Procedure UnitRegRejectionReason(stdNo: Code[20]) msg: Text
    begin
        unitregapprovals.Reset;
        unitregapprovals.SetRange(studNo, stdNo);
        unitregapprovals.SetRange(Semester, GetCurrentSemester());
        if unitregapprovals.Find('-') then begin
            msg := unitregapprovals."Rejection Reason";
        end;
    end;

    procedure GetCurrentSemester() msg: Text
    begin
        CurrentSem.Reset;
        CurrentSem.SetRange("Current Semester", true);
        if CurrentSem.Find('-') then begin
            msg := CurrentSem.Code;
        end;
    end;

    procedure SubmitUnits(studentNo: Text; Unit: Text; Prog: Text; myStage: Text; sem: Text; RegTransID: Text; UnitDescription: Text; AcademicYear: Text) ReturnMessage: Text[150]
    var
        Customer: Record "Customer";
    begin
        // IF Customer.GET(studentNo) THEN BEGIN
        //     Customer.CALCFIELDS(Balance);
        //     IF Customer.Balance > 0 THEN BEGIN
        //         ReturnMessage := 'Units not registered! Your Balance is greater than zero!';
        //     END;
        // END;
        //  IF NOT (Customer.Balance > 0) THEN BEGIN
        StudentUnits.INIT;
        StudentUnits."Student No." := studentNo;
        StudentUnits.Unit := Unit;
        StudentUnits.Programme := Prog;
        StudentUnits.Stage := myStage;
        StudentUnits.Semester := sem;
        StudentUnits.Taken := TRUE;
        StudentUnits."Reg. Transacton ID" := RegTransID;
        StudentUnits."Unit Description" := UnitDescription;
        StudentUnits."Academic Year" := AcademicYear;
        StudentUnits.INSERT(TRUE);
        ReturnMessage := 'Units registered Successfully!';

        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE("Student No.", studentNo);
        StudentUnitBaskets.SETRANGE(Unit, Unit);
        StudentUnitBaskets.SETRANGE(Programme, Prog);
        StudentUnitBaskets.SETRANGE(Stage, myStage);
        StudentUnitBaskets.SETRANGE(Semester, sem);
        StudentUnitBaskets.SETRANGE("Reg. Transacton ID", RegTransID);
        StudentUnitBaskets.SETRANGE("Academic Year", AcademicYear);
        IF StudentUnitBaskets.FIND('-') THEN begin
            StudentUnitBaskets.Delete();
        end;
        //  END;
    end;

    procedure DeleteUnits(studentNo: Text; Prog: Text; myStage: Text; sem: Text; RegTransID: Text; AcademicYear: Text) ReturnMessage: Text[150]
    begin
        StudentUnits.RESET;
        StudentUnits.SETRANGE(StudentUnits."Student No.", studentNo);
        StudentUnits.SETRANGE(StudentUnits.Programme, Prog);
        StudentUnits.SETRANGE(StudentUnits.Stage, myStage);
        StudentUnits.SETRANGE(StudentUnits.Semester, sem);
        StudentUnits.SETRANGE(StudentUnits.Taken, TRUE);
        StudentUnits.SETRANGE(StudentUnits."Reg. Transacton ID", RegTransID);
        StudentUnits.SETRANGE(StudentUnits."Academic Year", AcademicYear);
        IF StudentUnits.FIND('-') then begin
            StudentUnits.DeleteAll();
            ReturnMessage := 'Units Deleted Successfully!'
        end;
    end;

    procedure DeleteUnit(studentNo: Text; UnitCode: Text) ReturnMessage: Text[150]
    var
        Customer: Record "Customer";
    begin
        StudentUnits.Reset();
        StudentUnits.SetRange("Student No.", studentNo);
        StudentUnits.SetRange(Unit, UnitCode);
        if StudentUnits.find('-') then
            if StudentUnits.Delete(true) then
                ReturnMessage := 'Units deleted Successfully!';
        if ReturnMessage = '' then ReturnMessage := 'Unit not Deleted!';

    end;

    procedure GetUnitTaken(UnitID: Text; StudentNo: Text; Stage: Text) Message: Text
    var
        TXTtaken: Label 'Taken';
        TXTNotTaken: Label 'Not Taken';
    begin
        StudentUnits.RESET;
        StudentUnits.SETRANGE(StudentUnits.Unit, UnitID);
        StudentUnits.SETRANGE(StudentUnits."Student No.", StudentNo);
        StudentUnits.SETRANGE(StudentUnits.Stage, Stage);
        IF StudentUnits.FIND('-') THEN BEGIN
            Message := TXTtaken + '::';
        END ELSE BEGIN
            Message := TXTNotTaken + '::';
        END
    end;


    procedure SubmitUnitsBaskets(studentNo: Text; Unit: Text; Prog: Text; myStage: Text; sem: Text; RegTransID: Text; UnitDescription: Text; AcademicYear: Text)
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE("Student No.", studentNo);
        StudentUnitBaskets.SETRANGE(Unit, Unit);
        StudentUnitBaskets.SETRANGE(Programme, Prog);
        StudentUnitBaskets.SETRANGE(Stage, myStage);
        StudentUnitBaskets.SETRANGE(Semester, sem);
        StudentUnitBaskets.SETRANGE("Reg. Transacton ID", RegTransID);
        StudentUnitBaskets.SETRANGE("Academic Year", AcademicYear);
        IF NOT StudentUnitBaskets.FIND('-') THEN BEGIN
            StudentUnitBaskets.INIT;
            StudentUnitBaskets."Student No." := studentNo;
            StudentUnitBaskets.Unit := Unit;
            StudentUnitBaskets.Programme := Prog;
            StudentUnitBaskets.Stage := myStage;
            StudentUnitBaskets.Taken := TRUE;
            StudentUnitBaskets.Semester := sem;
            StudentUnitBaskets."Reg. Transacton ID" := RegTransID;
            StudentUnitBaskets.Description := UnitDescription;
            StudentUnitBaskets."Academic Year" := AcademicYear;
            //StudentUnitBaskets.Posted := FALSE;
            StudentUnitBaskets.INSERT(TRUE);
        END ELSE BEGIN
            //StudentUnitBaskets.Posted := FALSE;
            StudentUnitBaskets.MODIFY;
        END;
    end;


    procedure GetUnitSelected(UnitID: Text; StudentNo: Text; Stage: Text) Message: Text
    var
        TXTtaken: Label 'Taken';
        TXTNotTaken: Label 'Not Taken';
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets.Unit, UnitID);
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets."Student No.", StudentNo);
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets.Stage, Stage);
        // StudentUnitBaskets.SETRANGE(StudentUnitBaskets.Posted, FALSE);
        IF StudentUnitBaskets.FIND('-') THEN BEGIN
            Message := TXTtaken + '::';
        END ELSE BEGIN
            Message := TXTNotTaken + '::';
        END
    end;


    procedure DeleteSelectedUnit(studentNo: Text; UnitID: Text)
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets."Student No.", studentNo);
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets.Unit, UnitID);
        IF StudentUnitBaskets.FIND('-') THEN BEGIN
            StudentUnitBaskets.DELETE;
            MESSAGE('Deleted Successfully');
        END;
    end;


    procedure DeleteSubmittedUnit(studentNo: Text)
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE(StudentUnitBaskets."Student No.", studentNo);
        IF StudentUnitBaskets.FIND('-') THEN BEGIN
            REPEAT
                //StudentUnitBaskets.Posted := TRUE;
                StudentUnitBaskets.MODIFY;
                MESSAGE('Deleted Successfully');
            UNTIL StudentUnitBaskets.NEXT = 0;
        END;
    end;

    //
    procedure CheckStaffPasswordChanged(username: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'No';
        TXTCorrectDetails: Label 'Yes';
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            IF (EmployeeCard."Changed Password" = TRUE) THEN BEGIN
                Message := TXTCorrectDetails + '::' + FORMAT(EmployeeCard."Changed Password");
            END ELSE BEGIN
                Message := TXTIncorrectDetails + '::' + FORMAT(EmployeeCard."Changed Password");
            END
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::';
        END
    end;

    procedure GenerateTranscript(StudentNo: Text; filenameFromApp: Text; sem: Text) details: Text
    var
        courseReg1: Record "ACA-Exam. Course Registration";
        filename: Text;
        AcademicYear: Code[20];
        courseReg: Record "ACA-Exam. Course Registration";
    begin
        filename := FILESPATH + filenameFromApp;
        CLEAR(AcademicYear);
        AcademicYear := sem;
        IF EXISTS(filename) THEN
            ERASE(filename);
        courseReg1.RESET;
        courseReg1.SETRANGE(courseReg1."Student Number", StudentNo);
        courseReg1.SETRANGE(courseReg1."Academic Year", AcademicYear);
        IF courseReg1.FIND('-') THEN BEGIN

            REPORT.SAVEASPDF(report::"Official Masters Transcript", filename, courseReg1);
            details := 'Transcript generated successfully';
        END;
    end;



    procedure GetStaffDetails(username: Text) Message: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."ID Number" + '::' + EmployeeCard.Citizenship + '::' + EmployeeCard."Postal Address" + '::' +
  EmployeeCard."Job Title" + '::' + EmployeeCard."Company E-Mail" + '::' + FORMAT(EmployeeCard.Title) + '::' + FORMAT(EmployeeCard."Date Of Birth");

        END
    end;


    procedure GetStaffGender(username: Text) Message: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := FORMAT(EmployeeCard.Gender) + '::' + EmployeeCard."Cellular Phone Number";

        END
    end;


    procedure HasFinances(StudentNo: Text) Message: Text
    var
        TXTNotRegistered: Label 'No';
        TXTRegistered: Label 'Yes';
    begin
        LedgerEntries.RESET;
        LedgerEntries.SETRANGE(LedgerEntries."Customer No.", StudentNo);
        IF LedgerEntries.FIND('-') THEN BEGIN
            Message := TXTRegistered + '::';
        END ELSE BEGIN
            Message := TXTNotRegistered + '::';
        END
    end;


    procedure GetCurrentSTageOrder(stage: Text; "Program": Text) Message: Text
    begin
        Stages.RESET;
        Stages.SETRANGE(Stages.Code, stage);
        Stages.SETRANGE(Stages."Programme Code", "Program");
        IF Stages.FIND('-') THEN BEGIN
            IF Stages."Final Stage" = true then begin
                Message := FORMAT(Stages.Order - 1);
            end else begin
                Message := FORMAT(Stages.Order);
            end;
        END
    end;

    procedure GetStage(stdno: code[20]; sem: code[20]) Msg: Text
    begin
        CourseReg.reset;
        CourseReg.SETRANGE(CourseReg."Student No.", stdno);
        CourseReg.SETRANGE(CourseReg.Semester, sem);
        IF CourseReg.FIND('-') THEN begin
            Msg := CourseReg.Stage;
        end;
    end;

    procedure GetNextSTage(orderd: Integer; Progz: Text) Message: Text
    begin
        Stages.RESET;
        Stages.SETRANGE(Stages.Order, orderd);
        Stages.SETRANGE(Stages."Programme Code", Progz);
        IF Stages.FIND('-') THEN BEGIN
            Message := Stages.Code;
        END
    end;


    procedure SubmitSpecialAndSupplementary(StudNo: Code[20]; LectNo: Code[20]; Marks: Decimal; AcademicYear: Code[20]; UnitCode: Code[20]) ReturnMessage: Text[250]
    var
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
    //AcaSpecialExamsResults: Record "Aca-Special Exams Results";
    begin
        // CLEAR(ReturnMessage);
        // AcaSpecialExamsDetails.RESET;
        // AcaSpecialExamsDetails.SETRANGE("Current Academic Year", AcademicYear);
        // AcaSpecialExamsDetails.SETRANGE("Student No.", StudNo);
        // AcaSpecialExamsDetails.SETRANGE("Unit Code", UnitCode);
        // IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
        //     AcaSpecialExamsResults.RESET;
        //     AcaSpecialExamsResults.SETRANGE("Current Academic Year", AcademicYear);
        //     AcaSpecialExamsResults.SETRANGE("Student No.", StudNo);
        //     AcaSpecialExamsResults.SETRANGE(Unit, UnitCode);
        //     IF AcaSpecialExamsResults.FIND('-') THEN BEGIN
        //         AcaSpecialExamsResults.VALIDATE(Score, Marks);
        //         AcaSpecialExamsResults.UserID := LectNo;
        //         AcaSpecialExamsResults."Modified Date" := TODAY;
        //         AcaSpecialExamsResults.Category := AcaSpecialExamsDetails.Category;
        //         AcaSpecialExamsResults.MODIFY;
        //         ReturnMessage := '1'
        //     END ELSE BEGIN
        //         AcaSpecialExamsResults.INIT;
        //         AcaSpecialExamsResults.Programmes := AcaSpecialExamsDetails.Programme;
        //         AcaSpecialExamsResults.Stage := AcaSpecialExamsDetails.Stage;
        //         AcaSpecialExamsResults.Unit := UnitCode;
        //         AcaSpecialExamsResults.Semester := AcaSpecialExamsDetails.Semester;
        //         AcaSpecialExamsResults."Student No." := AcaSpecialExamsDetails."Student No.";
        //         AcaSpecialExamsResults."Academic Year" := AcaSpecialExamsDetails."Academic Year";
        //         AcaSpecialExamsResults."Admission No" := StudNo;
        //         AcaSpecialExamsResults."Current Academic Year" := AcaSpecialExamsDetails."Current Academic Year";
        //         AcaSpecialExamsResults.UserID := LectNo;
        //         AcaSpecialExamsResults."Capture Date" := TODAY;
        //         AcaSpecialExamsResults.Category := AcaSpecialExamsDetails.Category;
        //         AcaSpecialExamsResults.VALIDATE(Score, Marks);
        //         AcaSpecialExamsResults.INSERT;
        //         AcaSpecialExamsResults.VALIDATE(Unit);
        //         ReturnMessage := '1';
        //     END;
        // END;
    end;


    procedure GetFees(StudentNo: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", StudentNo);
        IF Customer.FIND('-') THEN BEGIN
            Customer.CALCFIELDS("Debit Amount", "Credit Amount", Balance);
            Message := FORMAT(Customer."Debit Amount") + '::' + FORMAT(Customer."Credit Amount") + '::' + FORMAT(Customer.Balance);

        END
    end;


    procedure GetStaffProfileDetails(username: Text) Message: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."ID Number" + '::' + EmployeeCard.Citizenship + '::' + EmployeeCard."Postal Address" + '::' +
  EmployeeCard."Job Title" + '::' + EmployeeCard."Company E-Mail" + '::' + FORMAT(EmployeeCard.Title) + '::' + FORMAT(EmployeeCard."Date Of Birth") + '::' + FORMAT(EmployeeCard.Gender) + '::' + EmployeeCard."Cellular Phone Number";

        END
    end;


    procedure IsHostelBlacklisted(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := FORMAT(Customer."Hostel Black Listed");

        END
    end;


    procedure GetAccomodationFee(stdNo: Code[20]) Message: Decimal
    var
        PesaFlowIntegration: Record "PesaFlow Integration";
        PesaFlowInvoices: Record "PesaFlow Invoices";
    begin
        PesaFlowIntegration.Reset;
        PesaFlowIntegration.SetRange(CustomerRefNo, stdNo);
        PesaFlowIntegration.SetRange(ServiceID, '5360529');
        PesaFlowIntegration.SetRange(Posted, False);
        if PesaFlowIntegration.Find('-') then begin
            Message := PesaFlowIntegration.PaidAmount;
        end;
        /*StudCharges.RESET;
        StudCharges.SETRANGE(StudCharges."Student No.", username);
        StudCharges.SETRANGE(StudCharges.Semester, Sem);
        StudCharges.SETRANGE(StudCharges.accommodation, TRUE);
        IF StudCharges.FIND('-') THEN BEGIN
            Message := FORMAT(StudCharges.Amount);
        END;*/
    end;


    procedure GetStudentGender(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := FORMAT(Customer.Gender);

        END
    end;


    procedure GetSettlementType(username: Text) Message: Text
    begin
        CourseRegistration.SETCURRENTKEY(Stage);
        CourseRegistration.Ascending(true);
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", username);
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, false);
        IF CourseRegistration.FIND('+') THEN BEGIN
            Message := FORMAT(CourseRegistration."Settlement Type");

        END
    end;


    procedure GetRoomCostNum(SpaceNo: Text) Message: Text
    begin
        HostelLedger.RESET;
        HostelLedger.SETRANGE(HostelLedger."Space No", SpaceNo);
        IF HostelLedger.FIND('-') THEN BEGIN
            Message := HostelLedger."Room No" + '::' + FORMAT(HostelLedger."Room Cost");

        END
    end;


    procedure GetHasBooked(username: Text; sem: Text) Message: Text
    begin
        HostelRooms.RESET;
        HostelRooms.SETRANGE(HostelRooms.Student, username);
        HostelRooms.SETRANGE(HostelRooms.Semester, sem);
        IF HostelRooms.FIND('-') THEN BEGIN
            Message := HostelRooms.Student + '::' + HostelRooms."Space No" + '::' + HostelRooms."Room No" + '::' +
  HostelRooms."Hostel No" + '::' + FORMAT(HostelRooms."Accomodation Fee") + '::' + HostelRooms.Semester + '::' + FORMAT(HostelRooms."Allocation Date");

        END
    end;

    procedure GetAllocatedItems(username: Text; sem: Text) Msg: Text
    begin
        hostelItems.Reset;
        hostelItems.SetRange("Student No.", username);
        hostelItems.SetRange(Semester, sem);
        if hostelItems.Find('-') then begin
            repeat
                hostelInventory.Reset;
                hostelInventory.SetRange(Item, hostelItems."Item Code");
                if hostelInventory.Find('-') then begin
                    hostelInventory.CalcFields(Description);
                    msg += hostelItems."Item Code" + '::' + hostelInventory.Description + '::' + Format(hostelItems.Quantity) + '::' + Format(hostelItems.Cleared) + ':::';
                end;
            until hostelItems.Next = 0;
        end;
    end;

    procedure GetHostelDesc(HostelNo: Text) Message: Text
    begin
        HostelCard.RESET;
        HostelCard.SETRANGE(HostelCard."Asset No", HostelNo);
        IF HostelCard.FIND('-') THEN BEGIN
            Message := HostelCard.Description;

        END
    end;


    procedure GetRoomSpaceCosts(HostelNo: Text) Message: Text
    begin
        HostelBlockRooms.RESET;
        HostelBlockRooms.SETRANGE(HostelBlockRooms."Hostel Code", HostelNo);
        IF HostelBlockRooms.FIND('-') THEN BEGIN
            Message := FORMAT(HostelBlockRooms."Room Cost") + '::' + FORMAT(HostelBlockRooms."JAB Fees") + '::' + FORMAT(HostelBlockRooms."SSP Fees");

        END
    end;


    procedure BookHostel(studentNo: Text; MyHostelNo: Text; MySemester: Text; myRoomNo: Text; MyAccomFee: Decimal; mySpaceNo: Text; MyspaceCost: Decimal) ReturnMessage: Text
    begin
        HostelRooms.RESET;
        HostelRooms.INIT;
        HostelRooms.SETRANGE(HostelRooms.Student, studentNo);
        HostelRooms.SETRANGE(HostelRooms.Semester, MySemester);
        IF NOT HostelRooms.FIND('-') THEN BEGIN
            HostelRooms.Student := studentNo;
            HostelRooms.Charges := MyspaceCost;
            HostelRooms."Space No" := mySpaceNo;
            HostelRooms."Room No" := myRoomNo;
            HostelRooms."Hostel No" := MyHostelNo;
            HostelRooms."Accomodation Fee" := MyAccomFee;
            HostelRooms."Allocation Date" := TODAY;
            HostelRooms.Semester := MySemester;
            HostelRooms.INSERT;

            RoomSpaces.RESET;
            RoomSpaces.SETRANGE(RoomSpaces."Space Code", mySpaceNo);
            IF RoomSpaces.FIND('-') THEN BEGIN
                RoomSpaces.Booked := TRUE;
                RoomSpaces.VALIDATE(RoomSpaces."Space Code");
                RoomSpaces.MODIFY;
                ReturnMessage := 'You have successfully booked ' + mySpaceNo + ' space::';
            END
            ELSE BEGIN
                ReturnMessage := 'You have already booked ' + mySpaceNo + ' space::';
            END
        END;
    end;

    procedure SaveAccommodationBooking(billRefNo: Code[20]; invoiceNo: Code[20]; studentNo: code[20]; studentName: Text; MyHostelNo: Text; MySemester: Text; myRoomNo: Text; mySpaceNo: Text; MyspaceCost: Decimal) ReturnMessage: Text
    begin
        accommodationBooking.INIT;
        accommodationBooking.BillRefNo := billRefNo;
        accommodationBooking.InvoiceNo := invoiceNo;
        accommodationBooking.StudentNo := studentNo;
        accommodationBooking.StudentName := studentName;
        accommodationBooking.Semester := MySemester;
        accommodationBooking.SpaceCost := MyspaceCost;
        accommodationBooking.SpaceNo := mySpaceNo;
        accommodationBooking.RoomNo := myRoomNo;
        accommodationBooking.HostelNo := MyHostelNo;
        accommodationBooking.ServiceCode := '5360529';
        accommodationBooking.Description := 'Accommodation Fee';
        accommodationBooking."Booking Date" := TODAY;
        accommodationBooking.INSERT;
    end;

    procedure PreservedForFirstYears() msg: Boolean
    var
        GeneralSetup: Record "ACA-General Set-Up";
    begin
        GeneralSetup.Reset;
        if GeneralSetup.Find('-') then begin
            msg := GeneralSetup."Restrict to Year 1";
        end;
    end;

    procedure StudentSpecificTimetables(Semesters: Code[20]; StudentNo: Code[20]; TimetableType: Text[20]; filenameFromApp: Text) TimetableReturn: Text
    var
        ACACourseRegistration: Record "ACA-Course Registration";
        ACAStudentUnits: Record "ACA-Student Units";
        UnitFilterString: Text[1024];
        NoOfLoops: Integer;
        EXTTimetableFInalCollector: Record "EXT-Timetable FInal Collector";
        TTTimetableFInalCollector: Record "TT-Timetable FInal Collector";
        filename: Text;
    begin
        CLEAR(TimetableReturn);
        ACACourseRegistration.RESET;
        ACACourseRegistration.SETRANGE(Semester, Semesters);
        ACACourseRegistration.SETRANGE("Student No.", StudentNo);
        IF ACACourseRegistration.FIND('-') THEN BEGIN
            ACAStudentUnits.RESET;
            ACAStudentUnits.SETRANGE(Semester, Semesters);
            ACAStudentUnits.SETRANGE("Student No.", StudentNo);
            ACAStudentUnits.SETFILTER("Reg. Reversed", '=%1', FALSE);
            IF ACAStudentUnits.FIND('-') THEN BEGIN
                CLEAR(UnitFilterString);
                CLEAR(NoOfLoops);
                REPEAT
                BEGIN
                    IF NoOfLoops > 0 THEN
                        UnitFilterString := UnitFilterString + '|';
                    UnitFilterString := UnitFilterString + ACAStudentUnits.Unit;
                    NoOfLoops := NoOfLoops + 1;
                END;
                UNTIL ACAStudentUnits.NEXT = 0;
            END ELSE
                TimetableReturn := 'You have not registered for Units in ' + Semesters;
        END ELSE
            TimetableReturn := 'You are not registered in ' + Semesters;
        IF UnitFilterString <> '' THEN BEGIN
            //Render the timetables here
            //**1. Class Timetable
            IF TimetableType = 'CLASS' THEN BEGIN
                TTTimetableFInalCollector.RESET;
                TTTimetableFInalCollector.SETRANGE(Programme, ACACourseRegistration.Programmes);
                TTTimetableFInalCollector.SETRANGE(Semester, Semesters);
                TTTimetableFInalCollector.SETFILTER(Unit, UnitFilterString);
                IF TTTimetableFInalCollector.FIND('-') THEN BEGIN//Pull the Class Timetable Here
                    REPORT.RUN(report::"TT-Master Timetable (Final) 2", TRUE, FALSE, TTTimetableFInalCollector);
                    filename := FILESPATH + StudentNo + '_ClassTimetable_' + Semesters;
                    IF EXISTS(filename) THEN
                        ERASE(filename);
                    REPORT.SAVEASPDF(report::"TT-Master Timetable (Final) 2", filename, TTTimetableFInalCollector);
                END;
            END ELSE
                IF TimetableType = 'EXAM' THEN BEGIN
                    //**2. Exam Timetable
                    EXTTimetableFInalCollector.RESET;
                    EXTTimetableFInalCollector.SETRANGE(Programme, ACACourseRegistration.Programmes);
                    EXTTimetableFInalCollector.SETRANGE(Semester, Semesters);
                    EXTTimetableFInalCollector.SETFILTER(Unit, UnitFilterString);
                    IF EXTTimetableFInalCollector.FIND('-') THEN BEGIN//Pull the Exam Timetable Here
                        REPORT.RUN(report::"EXT-Master Timetable (Final) 2", TRUE, FALSE, EXTTimetableFInalCollector);
                        // // // //     filename :=FILESPATH_S+StudentNo+'_ExamTimetable_'+Semesters;
                        // // // //     IF EXISTS(filename) THEN
                        // // // //      ERASE(filename);
                        // // // //     REPORT.SAVEASPDF(74551,filename,EXTTimetableFInalCollector);
                    END;
                END;
        END;

        //EXIT(filename);
    end;


    procedure LecturerSpecificTimetables(Semesters: Code[20]; LecturerNo: Code[20]; TimetableType: Text[20]; filenameFromApp: Text[150]) TimetableReturn: Text
    var
        UnitFilterString: Text[1024];
        NoOfLoops: Integer;
        // EXTTimetableFInalCollector: Record "74568";
        // TTTimetableFInalCollector: Record "74523";
        ACALecturersUnits: Record "ACA-Lecturers Units";
        filename: Text;
        pesaflow: codeunit "PesaFlow Integration";
    begin
        CLEAR(TimetableReturn);
        ACALecturersUnits.RESET;
        ACALecturersUnits.SETRANGE(Semester, Semesters);
        ACALecturersUnits.SETRANGE(Lecturer, LecturerNo);
        IF ACALecturersUnits.FIND('-') THEN BEGIN
            CLEAR(UnitFilterString);
            CLEAR(NoOfLoops);
            REPEAT
            BEGIN
                IF NoOfLoops > 0 THEN
                    UnitFilterString := UnitFilterString + '|';
                UnitFilterString := UnitFilterString + ACALecturersUnits.Unit;
                NoOfLoops := NoOfLoops + 1;
            END;
            UNTIL ACALecturersUnits.NEXT = 0;
        END ELSE
            TimetableReturn := 'You''ve not been allocated units in ' + Semesters;
        IF UnitFilterString <> '' THEN BEGIN
            //Render the timetables here
            //**1. Class Timetable
            IF TimetableType = 'CLASS' THEN BEGIN
                TTTimetableFInalCollector.RESET;
                TTTimetableFInalCollector.SETRANGE(Lecturer, LecturerNo);
                TTTimetableFInalCollector.SETRANGE(Semester, Semesters);
                TTTimetableFInalCollector.SETFILTER(Unit, UnitFilterString);
                IF TTTimetableFInalCollector.FIND('-') THEN BEGIN//Pull the Class Timetable Here
                                                                 //    REPORT.RUN(74501,TRUE,FALSE,TTTimetableFInalCollector);
                                                                 // filename :=FILESPATH_S+LecturerNo+'_ClassTimetable_'+Semesters;
                    filename := FILESPATH + filenameFromApp;
                    IF EXISTS(filename) THEN
                        ERASE(filename);
                    REPORT.SAVEASPDF(report::"TT-Master Timetable (Final) 2", filename, TTTimetableFInalCollector);
                END;
            END ELSE
                IF TimetableType = 'EXAM' THEN BEGIN
                    //**2. Exam Timetable
                    EXTTimetableFInalCollector.RESET;
                    EXTTimetableFInalCollector.SETRANGE(Semester, Semesters);
                    EXTTimetableFInalCollector.SETFILTER(Unit, UnitFilterString);
                    IF EXTTimetableFInalCollector.FIND('-') THEN BEGIN//Pull the Exam Timetable Here
                                                                      //  REPORT.RUN(74551,TRUE,FALSE,EXTTimetableFInalCollector);
                                                                      // filename :=FILESPATH_S+LecturerNo+'_ExamTimetable_'+Semesters;
                        filename := FILESPATH + filenameFromApp;
                        IF EXISTS(filename) THEN
                            ERASE(filename);
                        REPORT.SAVEASPDF(report::"EXT-Master Timetable (Final) 2", filename, EXTTimetableFInalCollector);
                    END;
                END;
        END;
    end;


    procedure KUCCPSLogin(username: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'Incorrect Username or Password';
        TXTCorrectDetails: Label 'Login';
        TXTInactive: Label 'Your Account is not active';
        FullNames: Text;
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        //EmployeeCard.SETRANGE(EmployeeCard.Status,EmployeeCard.Status::Active);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            FullNames := KUCCPSRaw.Names + ' ' + KUCCPSRaw."Middle Name" + ' ' + KUCCPSRaw.Surname;
            Message := TXTCorrectDetails + '::' + KUCCPSRaw.Index + '::' + FullNames + '::' + KUCCPSRaw.Admin + '::' + KUCCPSRaw.Names + ' ::' + KUCCPSRaw."Middle Name" + ' ::' + KUCCPSRaw.Surname;
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::';
        END
    end;


    procedure GetKUCCPSUserData(username: Text) Message: Text
    var
        Email: Text;
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            fablist.Reset;
            fablist.SetRange("Index Number", username);
            if fablist.Find('-') then begin
                if fablist."Student E-Mail" <> '' then begin
                    Email := fablist."Student E-Mail";
                end else begin
                    Email := fablist.Email;
                end;
                Message := KUCCPSRaw.Admin + '::' + KUCCPSRaw.Names + '::' + FORMAT(KUCCPSRaw.Gender) + '::' +
      Email + '::' + fablist."Telephone No. 1" + '::' + GetSchool(KUCCPSRaw.Prog) + '::' + GetProgram(KUCCPSRaw.Prog) + '::' + KUCCPSRaw.Prog;
            end;
        end;
    end;


    procedure Islecturer(username: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'No';
        TXTCorrectDetails: Label 'Yes';
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := FORMAT(EmployeeCard.Lecturer);
        END
    end;


    procedure VerifyOldStudentPassword(username: Text; OldPass: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'No';
        TXTCorrectDetails: Label 'Yes';
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        Customer.SETRANGE(Customer.Password, OldPass);
        IF Customer.FIND('-') THEN BEGIN
            Message := TXTCorrectDetails;
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::';
        END
    end;


    procedure ChangeStudentPassword(username: Text; Pass: Text)
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Customer.Password := Pass;
            Customer."Changed Password" := TRUE;
            Customer.MODIFY;
            MESSAGE('Password Updated Successfully');
        END;
    end;


    procedure CheckStudentPasswordChanged(username: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'No';
        TXTCorrectDetails: Label 'Yes';
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            IF (Customer."Changed Password" = TRUE) THEN BEGIN
                Message := TXTCorrectDetails + '::' + FORMAT(Customer."Changed Password");
            END ELSE BEGIN
                Message := TXTIncorrectDetails + '::' + FORMAT(Customer."Changed Password");
            END
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::' + FORMAT(Customer."Changed Password");
        END
    end;

    procedure ResetStudentPassword(username: Text) Message: boolean
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Customer."Changed Password" := False;
            Customer.Modify;
            Message := True;
        end;
    end;

    procedure CheckStudentLoginForUnchangedPass(username: Text; Passwordz: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'Warning!, login failed! Ensure you login with your Admission Number as both your username as well as password!';
        TXTCorrectDetails: Label 'Login';
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        //Customer.SETRANGE(Customer.Status,Customer.Status::);
        IF Customer.FIND('-') THEN BEGIN
            IF (Customer."No." = Passwordz) THEN BEGIN
                Message := TXTCorrectDetails + '::' + Customer."No." + '::' + Customer."E-Mail";
            END ELSE BEGIN
                Message := TXTIncorrectDetails + '::';
            END
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::';
        END
    end;


    procedure ChangeStaffPassword(username: Text; password: Text)
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            EmployeeCard."Portal Password" := password;
            EmployeeCard."Changed Password" := TRUE;
            EmployeeCard.MODIFY;
            MESSAGE('Password Updated Successfully');
        END;
    end;


    procedure PurchaseHeaderCreate(BusinessCode: Code[50]; DepartmentCode: Code[50]; ResponsibilityCentre: Code[50]; UserID: Text; Purpose: Text)
    begin
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('QUO3456', 0D, TRUE);
        PurchaseRN.INIT;
        PurchaseRN."No." := NextLeaveApplicationNo;
        PurchaseRN."Document Type" := PurchaseRN."Document Type"::Quote;
        //PurchaseRN.Department:=DepartmentCode;
        PurchaseRN."Buy-from Vendor No." := 'DEPART';
        PurchaseRN."Pay-to Vendor No." := 'DEPART';
        PurchaseRN."Invoice Disc. Code" := 'DEPART';
        PurchaseRN."Shortcut Dimension 1 Code" := BusinessCode;
        PurchaseRN."Shortcut Dimension 2 Code" := DepartmentCode;
        PurchaseRN."Responsibility Center" := ResponsibilityCentre;
        PurchaseRN."Assigned User ID" := UserID;
        PurchaseRN."Order Date" := TODAY;
        PurchaseRN."Due Date" := TODAY;
        PurchaseRN."Expected Receipt Date" := TODAY;
        PurchaseRN."Posting Description" := Purpose;
        PurchaseRN.INSERT;
    end;

    procedure GetStudentRegStatus(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := FORMAT(Customer.Status);

        END
    end;


    procedure EvaluateLecturer(Programme: Text; Stage: Text; Unit: Text; Semester: Text; StudentNo: Text; LecturerNo: Text; QuestionNo: Code[10]; Response: Text; EvaluationDate: Text; ResponseAnalysis: Integer)
    begin
        IF (Programme = '') THEN BEGIN
            ERROR('Programme cannot be null');
        END;
        IF (Semester = '') THEN BEGIN
            ERROR('Semester cannot be null');
        END
        ELSE BEGIN
            LecEvaluation.INIT;
            LecEvaluation.Programme := Programme;
            LecEvaluation.Stage := Stage;
            LecEvaluation.Unit := Unit;
            LecEvaluation.Semester := Semester;
            LecEvaluation."Student No" := StudentNo;
            LecEvaluation."Lecturer No" := LecturerNo;
            LecEvaluation."Question No" := QuestionNo;
            LecEvaluation.Response := Response;
            LecEvaluation."Date Time" := CURRENTDATETIME;
            LecEvaluation."Response Analysis" := ResponseAnalysis;
            LecEvaluation.INSERT(TRUE);

            StudentUnits.RESET;
            StudentUnits.INIT;
            StudentUnits.SETRANGE(StudentUnits."Student No.", StudentNo);
            StudentUnits.SETRANGE(StudentUnits.Unit, Unit);
            StudentUnits.SETRANGE(StudentUnits.Semester, Semester);
            IF StudentUnits.FIND('-') THEN BEGIN
                StudentUnits.Evaluated := TRUE;
                StudentUnits."Evaluated semester" := Semester;
                StudentUnits."Evaluated Date" := EvaluationDate;
                StudentUnits.MODIFY;
            END
        END;
    end;

    procedure GetEvaluated(Username: Text; "Program": Text; Stage: Text; Unit: Text; Sem: Text) Message: Text
    var
        TXTNotEvaluated: Label 'No';
        TXTEvaluated: Label 'Yes';
    begin
        LecEvaluation.RESET;
        LecEvaluation.SETRANGE(LecEvaluation."Student No", Username);
        LecEvaluation.SETRANGE(LecEvaluation.Programme, "Program");
        LecEvaluation.SETRANGE(LecEvaluation.Stage, Stage);
        LecEvaluation.SETRANGE(LecEvaluation.Unit, Unit);
        LecEvaluation.SETRANGE(LecEvaluation.Semester, Sem);
        IF LecEvaluation.FIND('-') THEN BEGIN
            Message := TXTEvaluated + '::';
        END ELSE BEGIN
            Message := TXTNotEvaluated + '::';
        END
    end;


    procedure GetSchool(Prog: Code[20]) SchoolName: Text
    var
        ACAProgramme2: Record "ACA-Programme";
        DimensionValue: Record "Dimension Value";
    begin
        CLEAR(SchoolName);
        IF ACAProgramme2.GET(Prog) THEN BEGIN
            /*DimensionValue.RESET;
            DimensionValue.SETRANGE("Dimension Code", 'FACULTY');
            DimensionValue.SETRANGE(Code, ACAProgramme2."School Code");
            IF DimensionValue.FIND('-') THEN SchoolName := DimensionValue.Name;*/
            ACAProgramme2.CalcFields("Faculty Name");
            SchoolName := ACAProgramme2."Faculty Name";
        END;
    end;


    procedure LoadAssignedScores(studentNo: Text; unitz: Text; ExamTypez: Text; Semz: Text) Message: Text
    begin
        ExamResults.RESET;
        ExamResults.SETRANGE(ExamResults."Student No.", studentNo);
        ExamResults.SETRANGE(ExamResults.Unit, unitz);
        ExamResults.SETRANGE(ExamResults.ExamType, ExamTypez);
        ExamResults.SETRANGE(ExamResults.Semester, Semz);
        IF ExamResults.FIND('-') THEN BEGIN
            Message := FORMAT(ExamResults.Score) + '::' + FORMAT(ExamResults."Edit Count");

        END
    end;


    procedure SubmitMarks(prog: Text; stage: Text; sem: Text; units: Text; StudentNo: Text; CatMark: Decimal; ExamTypes: Text; Reg_TransactonID: Text; AcademicYear: Text; username: Text; LectName: Text)
    begin
        ExamResults.RESET;
        ExamResults.SETRANGE(Programmes, prog);
        ExamResults.SETRANGE(Stage, stage);
        ExamResults.SETRANGE(Semester, sem);
        ExamResults.SETRANGE(Unit, units);
        ExamResults.SETRANGE("Student No.", StudentNo);
        ExamResults.SETRANGE(ExamType, ExamTypes);
        //ExamResults.SETRANGE("Reg. Transaction ID",Reg_TransactonID);
        IF NOT ExamResults.FIND('-') THEN BEGIN
            ExamResults.INIT;
            ExamResults.Programmes := prog;
            ExamResults.Stage := stage;
            ExamResults.Semester := sem;
            ExamResults.Unit := units;
            ExamResults."Student No." := StudentNo;
            ExamResults.Score := CatMark;
            ExamResults.ExamType := ExamTypes;
            ExamResults."Submitted On" := TODAY;
            ExamResults."Last Edited On" := TODAY;
            ExamResults.Exam := ExamTypes;
            ExamResults."Reg. Transaction ID" := Reg_TransactonID;
            ExamResults."User Name" := username;
            ExamResults."Lecturer Names" := LectName;
            IF ExamResults.INSERT THEN;
        END ELSE BEGIN
            ExamResults.Score := CatMark;
            ExamResults."User Name" := username;
            ExamResults."Lecturer Names" := LectName;
            ExamResults.MODIFY;
        END;
    end;


    procedure GetMaxScores(ProgCat: Text; Typez: Integer) Message: Text
    begin
        ExamsSetup.RESET;
        ExamsSetup.SETRANGE(ExamsSetup.Category, ProgCat);
        ExamsSetup.SETRANGE(ExamsSetup.Type, Typez);
        IF ExamsSetup.FIND('-') THEN BEGIN
            Message := FORMAT(ExamsSetup."Max. Score");

        END
    end;


    procedure GetDefaultProgramCategory(Progz: Text) Message: Text
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects.Code, Progz);
        IF UnitSubjects.FIND('-') THEN BEGIN
            Message := UnitSubjects."Default Exam Category";
        END
    end;


    procedure GetProgramCategory(programz: Text) Message: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, programz);
        IF Programme.FIND('-') THEN BEGIN
            Message := Programme."Exam Category";
        END
    end;


    procedure GetFinalExamScore(StudentNo: Text; unitz: Text; ExmaType: Text) Message: Text
    begin
        ExamResults.RESET;
        ExamResults.SETRANGE(ExamResults."Student No.", StudentNo);
        ExamResults.SETRANGE(ExamResults.Unit, unitz);
        ExamResults.SETRANGE(ExamResults.ExamType, ExmaType);
        IF ExamResults.FIND('-') THEN BEGIN
            Message := FORMAT(ExamResults.Score);

        END
    end;


    procedure SubmitUnitsBasketsRegister(studentNo: Text; Unit: Text; Prog: Text; myStage: Text; sem: Text; RegTransID: Text; UnitDescription: Text; AcademicYear: Text; HODz: Text)
    begin
        StudentUnitBaskets.INIT;
        StudentUnitBaskets."Student No." := studentNo;
        StudentUnitBaskets.Unit := Unit;
        StudentUnitBaskets.Programme := Prog;
        StudentUnitBaskets.Stage := myStage;
        StudentUnitBaskets.Taken := TRUE;
        StudentUnitBaskets.Semester := sem;
        StudentUnitBaskets."Reg. Transacton ID" := RegTransID;
        StudentUnitBaskets.Description := UnitDescription;
        StudentUnitBaskets."Academic Year" := AcademicYear;
        // StudentUnitBaskets.HOD := HODz;
        // StudentUnitBaskets.Posted := FALSE;
        // StudentUnitBaskets.New := TRUE;
        StudentUnitBaskets.INSERT(TRUE);
    end;


    procedure GetAdmissionNo(IdNumber: Text) Message: Text
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."ID Number", IdNumber);
        IF AplicFormHeader.FIND('-') THEN BEGIN
            Message := AplicFormHeader."Admission No" + '::' + AplicFormHeader."Application No." + '::' + AplicFormHeader."First Degree Choice" + '::' + FORMAT(AplicFormHeader.Gender) + '::' + FORMAT(AplicFormHeader."Academic Year");
        END
    end;

    procedure GetCourseApplicNumber(progz: Text; IDNumber: Text) Message: Text
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."First Degree Choice", progz);
        AplicFormHeader.SETRANGE(AplicFormHeader."ID Number", IDNumber);
        IF AplicFormHeader.FIND('-') THEN BEGIN
            Message := AplicFormHeader."Application No." + '::' + FORMAT(AplicFormHeader."Points Acquired") + '::' + AplicFormHeader."Mean Grade Acquired";
        END
    end;


    procedure GeProgrammeMinimumPoints(ProgzCode: Text) Message: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, ProgzCode);
        IF Programme.FIND('-') THEN BEGIN
            Message := FORMAT(Programme."Minimum Points") + '::' + Programme."Minimum Grade";
        END
    end;


    procedure ValidateSubjectGrade(Programme: Text; SubjectCode: Text) Message: Text
    begin
        ProgEntrySubjects.RESET;
        ProgEntrySubjects.SETRANGE(ProgEntrySubjects.Programme, Programme);
        ProgEntrySubjects.SETRANGE(ProgEntrySubjects.Subject, SubjectCode);
        IF ProgEntrySubjects.FIND('-') THEN BEGIN
            Message := FORMAT(ProgEntrySubjects."Minimum Points") + '::' + ProgEntrySubjects."Minimum Grade" + '::' + GetAttainedPoints(ProgEntrySubjects."Minimum Grade");
        END
    end;


    procedure GetGradeForSelectedSubject(SubjectCode: Text; ApplicationNo: Text) Message: Text
    begin
        ApplicFormAcademic.RESET;
        ApplicFormAcademic.SETRANGE(ApplicFormAcademic."Subject Code", SubjectCode);
        ApplicFormAcademic.SETRANGE(ApplicFormAcademic."Application No.", ApplicationNo);
        IF ApplicFormAcademic.FIND('-') THEN BEGIN
            Message := ApplicFormAcademic.Grade;
        END
    end;


    procedure SubmitOnlineCourseApplication(Surnamez: Text; OtherNames: Text; DateOfBirth: Date; Gender: Integer; IDNumber: Text; PermanentHomeAddress: Text; CorrAddress: Text; MobileNo: Text; EmailAddress: Text; programz: Text; CampusCode: Text; ModeOfStudy: Text; HowDid: Text)
    begin
        AplicFormHeader.INIT;
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('STD-APPLIC', 0D, TRUE);
        AplicFormHeader."Application No." := NextLeaveApplicationNo;
        AplicFormHeader.Date := TODAY;
        AplicFormHeader."Application Date" := TODAY;
        AplicFormHeader.Surname := Surnamez;
        AplicFormHeader."Other Names" := OtherNames;
        AplicFormHeader."Date Of Birth" := DateOfBirth;
        AplicFormHeader.Gender := Gender;
        AplicFormHeader."First Degree Choice" := programz;
        AplicFormHeader.School1 := GetSchool(programz);
        AplicFormHeader."ID Number" := IDNumber;
        AplicFormHeader."Address for Correspondence2" := PermanentHomeAddress;
        AplicFormHeader."Address for Correspondence1" := CorrAddress;
        AplicFormHeader."Telephone No. 1" := MobileNo;
        AplicFormHeader.Email := EmailAddress;
        AplicFormHeader."Emergency Email" := EmailAddress;
        AplicFormHeader.Campus := CampusCode;
        AplicFormHeader."No. Series" := 'STD-APPLIC';
        AplicFormHeader."Mode of Study" := ModeOfStudy;
        AplicFormHeader."Knew College Thru" := HowDid;
        AplicFormHeader.INSERT(TRUE);
    end;


    procedure SubmitSujects(ApplicationNo: Text; SubjectCode: Text; MinGrade: Text; Gradez: Text) Message: Text
    begin
        ApplicFormAcademic.RESET;
        ApplicFormAcademic.SETRANGE(ApplicFormAcademic."Application No.", ApplicationNo);
        ApplicFormAcademic.SETRANGE(ApplicFormAcademic."Subject Code", SubjectCode);

        IF NOT ApplicFormAcademic.FIND('-') THEN BEGIN
            ApplicFormAcademic.INIT;
            ApplicFormAcademic."Application No." := ApplicationNo;
            ApplicFormAcademic."Subject Code" := SubjectCode;
            ApplicFormAcademic."Min Grade" := MinGrade;
            ApplicFormAcademic.Grade := Gradez;
            ApplicFormAcademic.INSERT(TRUE);
        END ELSE BEGIN
            ApplicFormAcademic."Min Grade" := MinGrade;
            ApplicFormAcademic.Grade := Gradez;
            ApplicFormAcademic.MODIFY;
        END;
    end;


    procedure UpdateApplication(gradez: Text; pointz: Integer; ApplicationNo: Text)
    begin
        ApplicFormAcademic.RESET;
        ApplicFormAcademic.SETRANGE(ApplicFormAcademic."Application No.", ApplicationNo);

        IF ApplicFormAcademic.FIND('-') THEN BEGIN
            ApplicFormAcademic.Grade := gradez;
            ApplicFormAcademic.Points := pointz;
            ApplicFormAcademic.MODIFY;
        END;
    end;


    procedure GetAttainedPoints(AttainedCode: Code[30]) Message: Text
    var
        ACAApplicSetupGrade: Record "ACA-Applic. Setup";
    begin
        CLEAR(Message);
        IF ACAApplicSetupGrade.GET(AttainedCode) THEN BEGIN
            ACAApplicSetupGrade.RESET;
            IF ACAApplicSetupGrade.FIND('-') THEN;
            //Message := FORMAT(ACAApplicSetupGrade.Points);
        END;
    end;


    procedure CurrentIntake() Message: Text
    begin
        Intake.RESET;
        Intake.SETRANGE(Intake.Current, TRUE);
        IF Intake.FIND('-') THEN BEGIN
            Message := Intake.Code + '::' + Intake.Description;
        END
    end;

    procedure GetProgramSemesters(Progz: Code[50]) Message: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Code, Progz);
        Programme.SETRANGE("Use Stage Semesters", true);
        IF Programme.FIND('-') THEN BEGIN
            ProgramSem.RESET;
            ProgramSem.SETRANGE(ProgramSem."Programme Code", Progz);
            ProgramSem.SETRANGE(ProgramSem.Current, TRUE);
            IF ProgramSem.FIND('-') THEN BEGIN
                Message := ProgramSem.Semester;
            END;
        END ELSE BEGIN
            CurrentSem.RESET;
            CurrentSem.SETRANGE("Current Semester", true);
            IF CurrentSem.FIND('-') THEN BEGIN
                Message := CurrentSem.Code;
            END;
        END;
    end;

    procedure DownloadExamCard() Message: Boolean
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE("Current Semester", true);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem."DownLoad Exam Card";
        END;
    end;

    procedure CheckFeeStatus(StudentN: Code[20]; Semest: Code[20]) Register: Code[20]
    var
        BilledAmount: Decimal;
        "50Percent": Decimal;
        Customerz1: Record Customer;
        ACACourseRegistrationz: Record "ACA-Course Registration";
    begin
        Register := 'NO';
        Customerz1.RESET;
        Customerz1.SETRANGE("No.", StudentN);
        IF Customerz1.FIND('-') THEN BEGIN
            IF Customerz1.CALCFIELDS(Balance) THEN;
            ACACourseRegistrationz.RESET;
            ACACourseRegistrationz.SETRANGE("Student No.", StudentN);
            ACACourseRegistrationz.SETRANGE(Semester, Semest);
            IF ACACourseRegistrationz.FIND('-') THEN BEGIN
                //IF ACACourseRegistrationz.CALCFIELDS("Total Billed") THEN BEGIN
                IF NOT (Customerz1.Balance > ((ACACourseRegistrationz."Total Billed") / 2)) THEN Register := 'YES';
                //END;
            END;
        END;

        //MESSAGE('Register Status: '+Register);
    end;


    procedure UpdateApplicationLevel(ApplicNum: Text; NumSq: Integer)
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."Application No.", ApplicNum);

        IF AplicFormHeader.FIND('-') THEN BEGIN
            AplicFormHeader.OnlineSeq := NumSq;
            AplicFormHeader.MODIFY;
        END;
    end;


    procedure UpdateApplicationIntake(AppLicNum: Text; Intake: Text; academicYear: Text)
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."Application No.", AppLicNum);

        IF AplicFormHeader.FIND('-') THEN BEGIN
            AplicFormHeader."Academic Year" := academicYear;
            AplicFormHeader."Intake Code" := Intake;
            AplicFormHeader.MODIFY;
        END;
    end;


    procedure UpdateApplicationPayments(ApplicNum: Text; PayMode: Text; TransID: Text)
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."Application No.", ApplicNum);

        IF AplicFormHeader.FIND('-') THEN BEGIN
            AplicFormHeader."Mode Of Payment" := PayMode;
            AplicFormHeader."Receipt Slip No." := TransID;
            AplicFormHeader.MODIFY;
        END;
    end;


    procedure GenerateAdmLetter(AdmNo: Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH_A + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Admin, AdmNo);

        IF KUCCPSRaw.FIND('-') THEN BEGIN
            //REPORT.SAVEASPDF(51343, filename, KUCCPSRaw);
            REPORT.SAVEASPDF(report::"Official Admission LetterJAb", filename, KUCCPSRaw);
            //AdmissionFormHeader.RESET;
            //AdmissionFormHeader.SETRANGE(AdmissionFormHeader."Admission No.",AdmNo);

            //IF AdmissionFormHeader.FIND('-') THEN BEGIN
            //REPORT.SAVEASPDF(51343,filename,AdmissionFormHeader);
            // REPORT.SAVEASPDF(51863,filename,AdmissionFormHeader);
        END;
    end;


    procedure GenerateOfferLetter(AdmNo: Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH_SSP + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."Admission No", AdmNo);

        IF AplicFormHeader.FIND('-') THEN BEGIN
            //REPORT.SAVEASPDF(report::"TMUC Admission letter - SSP", filename, AplicFormHeader);
        END;
    end;


    procedure GetUnderApllicLevel(username: Text) Message: Text
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader.Email, username);
        AplicFormHeader.SETRANGE(AplicFormHeader."Post Graduate", FALSE);
        AplicFormHeader.SETFILTER(AplicFormHeader.OnlineSeq, '%1|%2|%3|%4', 1, 2, 3, 4);
        //AplicFormHeader.SETFILTER(AplicFormHeader.OnlineSeq,FORMAT(3));
        IF AplicFormHeader.FIND('-') THEN BEGIN
            Message := FORMAT(AplicFormHeader.OnlineSeq) + '::' + AplicFormHeader."First Degree Choice";

        END
    end;


    procedure GenerateAdmissionNo(var ProgCode: Code[20]; IndexNo: Code[30])
    var
        AdminSetup: Record "ACA-Adm. Number Setup";
        NewAdminCode: Code[20];
        KuccpsImport: Record "KUCCPS Imports";
    begin
        KuccpsImport.RESET;
        KuccpsImport.SETRANGE(Index, IndexNo);
        IF KuccpsImport.FIND('-') THEN BEGIN
            AdminSetup.RESET;
            AdminSetup.SETRANGE(AdminSetup.Degree, ProgCode);
            IF AdminSetup.FIND('-') THEN BEGIN
                NewAdminCode := NoSeriesMgt.GetNextNo(AdminSetup."No. Series", 0D, TRUE);
                NewAdminCode := AdminSetup."JAB Prefix" + '/' + NewAdminCode + '/' + AdminSetup.Year;
            END
            ELSE BEGIN
                ERROR('The Admission Number Setup For Programme ' + FORMAT(KuccpsImport.Prog) + ' Does Not Exist');
            END;
            KuccpsImport.Admin := NewAdminCode;
            KuccpsImport.Generated := TRUE;
            KuccpsImport.MODIFY;
        END;
    end;


    procedure UpdateStudentProfile(username: Text; genderz: Integer; DoB: Date; Countyz: Text; Tribes: Text; Disabled: Integer)
    begin
        StudentCard.RESET;
        StudentCard.SETRANGE(StudentCard."No.", username);
        IF StudentCard.FIND('-') THEN BEGIN
            StudentCard.Gender := genderz;
            StudentCard."Date Of Birth" := DoB;
            StudentCard.County := Countyz;
            StudentCard.Tribe := Tribes;
            StudentCard."Disability Status" := Disabled;
            StudentCard.MODIFY;
            MESSAGE('Updated Successfully');
        END;
    end;

    procedure RegistrarCleared(stdNo: Code[20]) msg: Boolean
    begin
        Customer.Reset;
        Customer.SetRange("No.", stdNo);
        if Customer.Find('-') then begin
            msg := Customer."Registar Cleared";
        end
    end;

    procedure GenerateKUCCPSFeeStructure(Programz: Code[20]; SettlementType: Code[20]; filenameFromApp: Text) filename: Text
    begin
        filename := FILESPATH_A + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        //MESSAGE('OK');
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, Programz);
        Programme.SETFILTER(Programme."Settlement Type Filter", '%1', SettlementType);

        IF Programme.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Fee Structure Generation", filename, Programme);   //52017726
        END;
        EXIT(filename);
    end;


    procedure HasAdmissionNumber(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw.Admin;

        END
    end;


    procedure GetPostApllicLevel(username: Text) Message: Text
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader.Email, username);
        AplicFormHeader.SETRANGE(AplicFormHeader."Post Graduate", TRUE);
        AplicFormHeader.SETFILTER(AplicFormHeader.OnlineSeq, '%1|%2|%3|%4|%5|%6', 1, 2, 3, 4, 5, 6);
        //AplicFormHeader.SETFILTER(AplicFormHeader.OnlineSeq,FORMAT(3));
        IF AplicFormHeader.FIND('-') THEN BEGIN
            Message := FORMAT(AplicFormHeader.OnlineSeq) + '::' + AplicFormHeader."First Degree Choice";

        END
    end;


    procedure SubmitOnlinePostCourseApplication(Surnamez: Text; OtherNames: Text; DateOfBirth: Date; Gender: Integer; IDNumber: Text; PermanentHomeAddress: Text; CorrAddress: Text; MobileNo: Text; EmailAddress: Text; programz: Text; CampusCode: Text; ModeOfStudy: Text; HowDid: Text; Intake: Text)
    begin
        AplicFormHeader.INIT;
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('STD-APPLIC', 0D, TRUE);
        AplicFormHeader."Application No." := NextLeaveApplicationNo;
        AplicFormHeader.Date := TODAY;
        AplicFormHeader."Application Date" := TODAY;
        AplicFormHeader.Surname := Surnamez;
        AplicFormHeader."Other Names" := OtherNames;
        AplicFormHeader."Date Of Birth" := DateOfBirth;
        AplicFormHeader.Gender := Gender;
        AplicFormHeader."First Degree Choice" := programz;
        AplicFormHeader.School1 := GetSchool(programz);
        AplicFormHeader."ID Number" := IDNumber;
        AplicFormHeader."Address for Correspondence2" := PermanentHomeAddress;
        AplicFormHeader."Address for Correspondence1" := CorrAddress;
        AplicFormHeader."Telephone No. 1" := MobileNo;
        AplicFormHeader.Email := EmailAddress;
        AplicFormHeader."Emergency Email" := EmailAddress;
        AplicFormHeader.Campus := CampusCode;
        AplicFormHeader."Post Graduate" := TRUE;
        AplicFormHeader."No. Series" := 'STD-APPLIC';
        AplicFormHeader."Mode of Study" := ModeOfStudy;
        AplicFormHeader."Knew College Thru" := HowDid;
        AplicFormHeader."Intake Code" := Intake;
        AplicFormHeader.INSERT(TRUE);
    end;


    procedure PostFormerSchool(applicNo: Text; SchoolCode: Text)
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader."Application No.", applicNo);

        IF AplicFormHeader.FIND('-') THEN BEGIN
            AplicFormHeader."Former School Code" := SchoolCode;
            AplicFormHeader.MODIFY;
        END;
    end;


    procedure SubmitPostDegrees(ApplicationNo: Text; WhereObtained: Text; FromDate: Date; ToDate: Date; Qualificationz: Text; Awardz: Text; dateAwarded: Date)
    begin
        ApplicQualification.INIT;
        ApplicQualification."Application No." := ApplicationNo;
        ApplicQualification."Where Obtained" := WhereObtained;
        ApplicQualification."From Date" := FromDate;
        ApplicQualification."To Date" := ToDate;
        ApplicQualification.Qualification := Qualificationz;
        ApplicQualification.Award := Awardz;
        ApplicQualification."Date Awarded" := dateAwarded;
        ApplicQualification.INSERT(TRUE);
    end;


    procedure SubmitPostGrad(ApplicationNo: Text; OtherDegrees: Text; ResarchExperience: Text; Languages: Text; OtherResearchInstitution: Text; Sourceoffinance: Text)
    begin
        ApplicpPostGraduate.INIT;
        ApplicpPostGraduate.ApplicationNo := ApplicationNo;
        ApplicpPostGraduate."Other Degrees/Diploma" := OtherDegrees;
        ApplicpPostGraduate."Resarch Experience" := ResarchExperience;
        ApplicpPostGraduate.Languages := ResarchExperience;
        ApplicpPostGraduate."Other Research Institution" := OtherResearchInstitution;
        ApplicpPostGraduate."Source of finance" := Sourceoffinance;
        ApplicpPostGraduate.INSERT(TRUE);
    end;


    procedure SubmitPostEmployment(ApplicationNo: Text; Organisationz: Text; JobTitlez: Text; Fromz: Date; Toz: Date)
    begin
        ApplicPostEmployment.INIT;
        ApplicPostEmployment."Application No." := ApplicationNo;
        ApplicPostEmployment.Organisation := Organisationz;
        ApplicPostEmployment."Job Title" := JobTitlez;
        ApplicPostEmployment.From := Fromz;
        ApplicPostEmployment."To date" := Toz;
        ApplicPostEmployment.INSERT(TRUE);
    end;


    procedure SubmitForpHD(ApplicationNo: Text; MastersTypez: Integer; MasterthesisTitle: Text; MasterProjectTitle: Text)
    begin
        ApplicPhd.INIT;
        ApplicPhd."Application No" := ApplicationNo;
        ApplicPhd.MastersType := MastersTypez;
        ApplicPhd."Masters thesis Title" := MasterthesisTitle;
        ApplicPhd."Masters Project Title" := MasterProjectTitle;
        ApplicPhd.INSERT(TRUE);
    end;


    procedure SubmitReferees(ApplicationNoz: Text; Namez: Text; Titlez: Text; Addressz: Text; PhoneNo: Text; Faxz: Text; Emailz: Text)
    begin
        ApplicPostReferee.INIT;
        ApplicPostReferee.ApplicationNo := ApplicationNoz;
        ApplicPostReferee.Name := Namez;
        ApplicPostReferee.Title := Titlez;
        ApplicPostReferee.Address := Addressz;
        ApplicPostReferee."Phone No" := PhoneNo;
        ApplicPostReferee.Fax := Faxz;
        ApplicPostReferee.Email := Emailz;
        ApplicPostReferee.INSERT(TRUE);
    end;


    procedure GetPersonaldata(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw.Index + '::' + KUCCPSRaw.Admin + '::' + FORMAT(KUCCPSRaw.Prog) + '::' + KUCCPSRaw.Names + '::' + FORMAT(KUCCPSRaw.Gender) + '::' +
            KUCCPSRaw.Phone + '::' + KUCCPSRaw.Box + '::' + KUCCPSRaw.Codes + '::' + KUCCPSRaw.Town + '::' + KUCCPSRaw.Email + '::' + KUCCPSRaw."ID Number/BirthCert" + '::' +
            FORMAT(KUCCPSRaw."Date of Birth") + '::' + FORMAT(KUCCPSRaw.County) + '::' + FORMAT(KUCCPSRaw.Nationality) + '::' + FORMAT(KUCCPSRaw."Ethnic Background") + '::' +
            FORMAT(KUCCPSRaw."Disability Status") + '::' + KUCCPSRaw."Disability Description";
        END
    end;


    procedure KuccpsProfileUpdated(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := FORMAT(KUCCPSRaw.Updated);
        END
    end;


    procedure GetReadyLetter(username: Text) Message: Text
    begin
        AplicFormHeader.RESET;
        AplicFormHeader.SETRANGE(AplicFormHeader.Email, username);
        AplicFormHeader.SETRANGE(AplicFormHeader.Status, AplicFormHeader.Status::"Admission Letter");

        IF AplicFormHeader.FIND('-') THEN BEGIN
            Message := FORMAT(AplicFormHeader.Status);

        END
    end;


    procedure IsStudentKuccpsRegistered(StudentNo: Text; Stage: Text) Message: Text
    var
        TXTNotRegistered: Label 'Not registered';
        TXTRegistered: Label 'Registered';
    begin
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Stage, Stage);
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);
        IF CourseRegistration.FIND('-') THEN BEGIN
            Message := TXTRegistered + '::';
        END ELSE BEGIN
            Message := TXTNotRegistered + '::';
        END
    end;


    procedure HasKuccpsFinances(StudentNo: Text) Message: Text
    var
        TXTNotRegistered: Label 'No';
        TXTRegistered: Label 'Yes';
    begin
        ImportsBuffer.RESET;
        ImportsBuffer.SETRANGE(ImportsBuffer."Student No.", StudentNo);
        IF ImportsBuffer.FIND('-') THEN BEGIN
            Message := TXTRegistered + '::';
        END ELSE BEGIN
            Message := TXTNotRegistered + '::';
        END
    end;


    procedure TransferToAdmission(AdmissionNumber: Code[20])
    var
        AdminSetup: Record "KUCCPS Imports";
        NewAdminCode: Code[20];
    begin
        /*This function transfers the fieldsin the application to the fields in the admissions table*/
        /*Get the new admission code for the selected application*/

        AdminSetup.RESET;
        AdminSetup.SETRANGE(AdminSetup.Admin, AdmissionNumber);
        IF AdminSetup.FIND('-') THEN BEGIN
            Customer.INIT;
            Customer."No." := AdminSetup.Admin;
            Customer.Name := COPYSTR(AdminSetup.Names, 1, 80);
            Customer."Search Name" := UPPERCASE(COPYSTR(AdminSetup.Names, 1, 80));
            Customer.Address := AdminSetup.Box;
            IF AdminSetup.Box <> '' THEN
                Customer."Address 2" := COPYSTR(AdminSetup.Box + ',' + AdminSetup.Codes, 1, 30);
            IF AdminSetup.Phone <> '' THEN
                Customer."Phone No." := AdminSetup.Phone + ',' + AdminSetup."Alt. Phone";
            //  Customer."Telex No.":=Rec."Fax No.";
            Customer."E-Mail" := AdminSetup.Email;
            Customer.Gender := AdminSetup.Gender;
            Customer."Date Of Birth" := AdminSetup."Date of Birth";
            Customer."Date Registered" := TODAY;
            Customer."Customer Type" := Customer."Customer Type"::Student;
            //Customer."Student Type":=FORMAT(Enrollment."Student Type");
            Customer."Date Of Birth" := AdminSetup."Date of Birth";
            Customer."ID No" := AdminSetup."ID Number/BirthCert";
            Customer."Application No." := AdminSetup.Admin;
            //Customer."Marital Status":=AdminSetup."Marital Status";
            Customer.Citizenship := FORMAT(AdminSetup.Nationality);
            Customer."Current Programme" := AdminSetup.Prog;
            Customer."Current Semester" := 'SEM1 22/23';
            Customer."Current Stage" := 'Y1S1';
            //Customer.Religion:=FORMAT(AdminSetup.Religion);
            Customer."Application Method" := Customer."Application Method"::"Apply to Oldest";
            Customer."Customer Posting Group" := 'STUDENT';
            Customer.VALIDATE(Customer."Customer Posting Group");
            Customer."Global Dimension 1 Code" := 'MAIN';
            Customer.County := AdminSetup.County;
            Customer.INSERT();

            ////////////////////////////////////////////////////////////////////////////////////////


            Customer.RESET;
            Customer.SETRANGE("No.", AdminSetup.Admin);
            //Customer.SETFILTER("Date Registered",'=%1',TODAY);
            IF Customer.FIND('-') THEN BEGIN
                IF AdminSetup.Gender = AdminSetup.Gender::Female THEN BEGIN
                    Customer.Gender := Customer.Gender::Female;
                END ELSE BEGIN
                    Customer.Gender := Customer.Gender::Male;
                END;
                Customer.MODIFY;
            END;

            Customer.RESET;
            Customer.SETRANGE("No.", AdminSetup.Admin);
            Customer.SETFILTER("Date Registered", '=%1', TODAY);
            IF Customer.FIND('-') THEN BEGIN
                CourseRegistration.RESET;
                CourseRegistration.SETRANGE("Student No.", AdminSetup.Admin);
                CourseRegistration.SETRANGE("Settlement Type", 'JAB');
                CourseRegistration.SETRANGE(Programmes, AdminSetup.Prog);
                CourseRegistration.SETRANGE(Semester, 'SEM1 22/23');
                IF NOT CourseRegistration.FIND('-') THEN BEGIN
                    CourseRegistration.INIT;
                    CourseRegistration."Reg. Transacton ID" := '';
                    CourseRegistration.VALIDATE(CourseRegistration."Reg. Transacton ID");
                    CourseRegistration."Student No." := AdminSetup.Admin;
                    CourseRegistration.Programmes := AdminSetup.Prog;
                    CourseRegistration.Semester := 'SEM1 22/23';
                    CourseRegistration.Stage := 'Y1S1';
                    CourseRegistration."Student Type" := CourseRegistration."Student Type"::"Full Time";
                    CourseRegistration."Registration Date" := TODAY;
                    CourseRegistration."Settlement Type" := 'JAB';
                    CourseRegistration."Academic Year" := '2022/2023';

                    //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                    CourseRegistration.INSERT;
                    CourseRegistration.RESET;
                    CourseRegistration.SETRANGE("Student No.", AdminSetup.Admin);
                    CourseRegistration.SETRANGE("Settlement Type", 'JAB');
                    CourseRegistration.SETRANGE(Programmes, AdminSetup.Prog);
                    CourseRegistration.SETRANGE(Semester, 'SEM1 22/23');
                    IF CourseRegistration.FIND('-') THEN BEGIN
                        CourseRegistration."Settlement Type" := 'JAB';
                        CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                        CourseRegistration."Academic Year" := '2022/2023';
                        CourseRegistration."Registration Date" := TODAY;
                        CourseRegistration.VALIDATE(CourseRegistration."Registration Date");
                        CourseRegistration.MODIFY;

                    END;
                END ELSE BEGIN
                    CourseRegistration.RESET;
                    CourseRegistration.SETRANGE("Student No.", AdminSetup.Admin);
                    CourseRegistration.SETRANGE("Settlement Type", 'JAB');
                    CourseRegistration.SETRANGE(Programmes, AdminSetup.Prog);
                    CourseRegistration.SETRANGE(Semester, 'SEM1 22/23');
                    CourseRegistration.SETFILTER(Posted, '=%1', FALSE);
                    IF CourseRegistration.FIND('-') THEN BEGIN
                        CourseRegistration."Settlement Type" := 'JAB';
                        CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                        CourseRegistration."Academic Year" := '2022/2023';
                        CourseRegistration."Registration Date" := TODAY;
                        CourseRegistration.VALIDATE(CourseRegistration."Registration Date");
                        CourseRegistration.MODIFY;

                    END;
                END;
            END;


            /*Get the record and transfer the details to the admissions database*/
            //ERROR('TEST- '+NewAdminCode);
            /*Transfer the details into the admission database table*/
            Admissions.INIT;
            Admissions."Admission No" := AdminSetup.Admin;
            Admissions.VALIDATE("Admission No");
            Admissions.Date := TODAY;
            Admissions."Application No." := AdminSetup.Index;
            Admissions."Settlement Type" := 'JAB';
            Admissions."Academic Year" := '2022/2023';
            Admissions.Surname := AdminSetup.Names;
            Admissions."Other Names" := AdminSetup.Names;
            Admissions.Status := Admissions.Status::Approved;
            Admissions."Admitted Degree" := AdminSetup.Prog;
            Admissions.VALIDATE("Admitted Degree");
            Admissions."Date Of Birth" := AdminSetup."Date of Birth";
            Admissions.Gender := AdminSetup.Gender + 1;
            //Admissions."Marital Status":=AdminSetup."Marital Status";
            Admissions.County := AdminSetup.County;
            Admissions.Campus := 'MAIN';
            Admissions.Nationality := AdminSetup.Nationality;
            Admissions."Address for Correspondence1" := AdminSetup.Box;
            Admissions."Address for Correspondence2" := AdminSetup.Codes;
            Admissions."Address for Correspondence3" := AdminSetup.Town;
            Admissions."Telephone No. 1" := AdminSetup.Phone;
            Admissions."Telephone No. 2" := AdminSetup."Alt. Phone";
            //Admissions."Former School Code":=AdminSetup."Former School Code";
            Admissions."Index Number" := AdminSetup.Index;
            Admissions."Admitted To Stage" := 'Y1S1';
            Admissions."Admitted Semester" := 'SEM1 22/23';
            Admissions."Settlement Type" := 'KUCCPS';
            Admissions."Intake Code" := AdminSetup."Intake Code";
            Admissions."ID Number" := AdminSetup."ID Number/BirthCert";
            Admissions.Email := AdminSetup.Email;
            // Admissions."Telephone No. 1":=AdminSetup."Telephone No. 1";
            // Admissions."Telephone No. 2":=AdminSetup."Telephone No. 1";
            Admissions.INSERT();
            AdminSetup.Admin := NewAdminCode;
            /*Get the subject details and transfer the  same to the admissions subject*/
            ApplicationSubject.RESET;
            ApplicationSubject.SETRANGE(ApplicationSubject."Application No.", AdminSetup.Admin);
            IF ApplicationSubject.FIND('-') THEN BEGIN
                /*Get the last number in the admissions table*/
                AdmissionSubject.RESET;
                IF AdmissionSubject.FIND('+') THEN BEGIN
                    // LineNo := AdmissionSubject."Line No." + 1;
                END
                ELSE BEGIN
                    LineNo := 1;
                END;

                /*Insert the new records into the database table*/
                REPEAT
                    // INIT;
                    // "Line No." := LineNo + 1;
                    // "Admission No." := NewAdminCode;
                    // "Subject Code" := ApplicationSubject."Subject Code";
                    // Grade := Grade;
                    // INSERT();
                    LineNo := LineNo + 1;
                UNTIL ApplicationSubject.NEXT = 0;
            END;
            /*Insert the medical conditions into the admission database table containing the medical condition*/
            MedicalCondition.RESET;
            MedicalCondition.SETRANGE(MedicalCondition.Mandatory, TRUE);
            IF MedicalCondition.FIND('-') THEN BEGIN
                /*Get the last line number from the medical condition table for the admissions module*/
                AdmissionMedical.RESET;
                IF AdmissionMedical.FIND('+') THEN BEGIN
                    LineNo := AdmissionMedical."Line No." + 1;
                END
                ELSE BEGIN
                    LineNo := 1;
                END;
                AdmissionMedical.RESET;
                /*Loop thru the medical conditions*/
                REPEAT
                    AdmissionMedical.INIT;
                    AdmissionMedical."Line No." := LineNo + 1;
                    AdmissionMedical."Admission No." := NewAdminCode;
                    AdmissionMedical."Medical Condition Code" := MedicalCondition.Code;
                    AdmissionMedical.INSERT();
                    LineNo := LineNo + 1;
                UNTIL MedicalCondition.NEXT = 0;
            END;
            /*Insert the details into the family table*/
            MedicalCondition.RESET;
            MedicalCondition.SETRANGE(MedicalCondition.Mandatory, TRUE);
            MedicalCondition.SETRANGE(MedicalCondition.Family, TRUE);
            IF MedicalCondition.FIND('-') THEN BEGIN
                /*Get the last number in the family table*/
                AdmissionFamily.RESET;
                IF AdmissionFamily.FIND('+') THEN BEGIN
                    LineNo := AdmissionFamily."Line No.";
                END
                ELSE BEGIN
                    LineNo := 0;
                END;
                REPEAT
                    AdmissionFamily.INIT;
                    AdmissionFamily."Line No." := LineNo + 1;
                    AdmissionFamily."Medical Condition Code" := MedicalCondition.Code;
                    AdmissionFamily."Admission No." := NewAdminCode;
                    AdmissionFamily.INSERT();
                    LineNo := LineNo + 1;
                UNTIL MedicalCondition.NEXT = 0;
            END;

            /*Insert the immunization details into the database*/
            Immunization.RESET;
            //Immunization.SETRANGE(Immunization.Mandatory,TRUE);
            IF Immunization.FIND('-') THEN BEGIN
                /*Get the last line number from the database*/
                AdmissionImmunization.RESET;
                IF AdmissionImmunization.FIND('+') THEN BEGIN
                    LineNo := AdmissionImmunization."Line No." + 1;
                END
                ELSE BEGIN
                    LineNo := 1;
                END;
                /*loop thru the immunizations table adding the details into the admissions table for immunizations*/
                REPEAT
                    AdmissionImmunization.INIT;
                    AdmissionImmunization."Line No." := LineNo + 1;
                    AdmissionImmunization."Admission No." := NewAdminCode;
                    AdmissionImmunization."Immunization Code" := Immunization.Code;
                    AdmissionImmunization.INSERT();
                UNTIL Immunization.NEXT = 0;
            END;

            TakeStudentToRegistration(NewAdminCode);
        END;

    end;


    procedure TakeStudentToRegistration(var AdmissNo: Code[20])
    begin
        Admissions.RESET;
        Admissions.SETRANGE("Admission No", AdmissNo);
        IF Admissions.FIND('-') THEN BEGIN

            //insert the details related to the next of kin of the student into the database
            AdminKin.RESET;
            AdminKin.SETRANGE(AdminKin."Admission No.", Admissions."Admission No");
            IF AdminKin.FIND('-') THEN BEGIN
                REPEAT
                    StudentKin.RESET;
                    StudentKin.INIT;
                    StudentKin."Student No" := Admissions."Admission No";
                    StudentKin.Relationship := AdminKin.Relationship;
                    StudentKin.Name := AdminKin."Full Name";
                    //StudentKin."Other Names":=EnrollmentNextofKin."Other Names";
                    //StudentKin."ID No/Passport No":=EnrollmentNextofKin."ID No/Passport No";
                    //StudentKin."Date Of Birth":=EnrollmentNextofKin."Date Of Birth";
                    //StudentKin.Occupation:=EnrollmentNextofKin.Occupation;
                    StudentKin."Office Tel No" := AdminKin."Telephone No. 1";
                    StudentKin."Home Tel No" := AdminKin."Telephone No. 2";
                    //StudentKin.Remarks:=EnrollmentNextofKin.Remarks;
                    StudentKin.INSERT;
                UNTIL AdminKin.NEXT = 0;
            END;

            //insert the details in relation to the guardian/sponsor into the database in relation to the current student
            // IF Admissions."Mother Alive Or Dead" = Admissions."Mother Alive Or Dead"::Alive THEN BEGIN
            //     IF Admissions."Mother Full Name" <> '' THEN BEGIN
            //         StudentGuardian.RESET;
            //         StudentGuardian.INIT;
            //         StudentGuardian."Student No." := Admissions."Admission No.";
            //         StudentGuardian.Names := Admissions."Mother Full Name";
            //         StudentGuardian.INSERT;
            //     END;
            // END;
            // IF Admissions."Father Alive Or Dead" = Admissions."Father Alive Or Dead"::Alive THEN BEGIN
            //     IF Admissions."Father Full Name" <> '' THEN BEGIN
            //         StudentGuardian.RESET;
            //         StudentGuardian.INIT;
            //         StudentGuardian."Student No." := Admissions."Admission No.";
            //         StudentGuardian.Names := Admissions."Father Full Name";
            //         StudentGuardian.INSERT;
            //     END;
            // END;
            // IF Admissions."Guardian Full Name" <> '' THEN BEGIN
            //     IF Admissions."Guardian Full Name" <> '' THEN BEGIN
            //         StudentGuardian.RESET;
            //         StudentGuardian.INIT;
            //         StudentGuardian."Student No." := Admissions."Admission No.";
            //         StudentGuardian.Names := Admissions."Guardian Full Name";
            //         StudentGuardian.INSERT;
            //     END;
            // END;
        END;
    end;


    procedure SubmitReferral(Username: Text; Reason: Text)
    begin
        /*This function transfers the fieldsin the application to the fields in the admissions table*/
        /*Get the new admission code for the selected application*/
        /*NextLeaveApplicationNo:=NoSeriesMgt.GetNextNo('HOSPAPP',0D,TRUE);
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.",Username);
        IF EmployeeCard.FIND('-') THEN
          BEGIN
           Referrralll.INIT;
                Referrralll."Treatment no.":=NextLeaveApplicationNo;
                Referrralll."Date Referred":=TODAY;
                Referrralll."Referral Reason":=Reason;
                Referrralll.Status:=Referrralll.Status::"0";
                Referrralll.Surname:=EmployeeCard."Last Name";
                Referrralll."Middle Name":=EmployeeCard."Middle Name";
                Referrralll."Last Name":=EmployeeCard."First Name";
                Referrralll."ID Number":=EmployeeCard."First Name";
                Referrralll."Correspondence Address 1":=EmployeeCard."Postal Address";
                Referrralll."Telephone No. 1":=EmployeeCard."Cellular Phone Number";
                Referrralll.Email:=EmployeeCard."Company E-Mail";
                //Referrralll."Staff No":=Username;
                //Referrralll."No. Series":='HOSPAPP';
                Referrralll.INSERT();
                END;*/

    end;


    procedure GetMyApprovals_LeaveTotal(ApproverID: Text) Message: Text
    begin
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", ApproverID);
        ApprovalEntry.SETRANGE(ApprovalEntry."Approval Code", 'LEAVE');
        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := FORMAT(ApprovalEntry.COUNT);
        END
    end;


    procedure GetPRNHeaderDetails(PurchaseNo: Text) Message: Text
    begin
        PurchaseRN.RESET;
        PurchaseRN.SETRANGE(PurchaseRN."No.", PurchaseNo);
        IF PurchaseRN.FIND('-') THEN BEGIN
            Message := FORMAT(PurchaseRN."Expected Receipt Date");
        END
    end;

    procedure GetApprovalStatus(DocumentNo: Text) Message: Text
    begin
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
        IF ApprovalEntry.FIND('-') THEN BEGIN
            Message := FORMAT(ApprovalEntry.Status);
        END
    end;



    procedure CancelApprovalRequest(ReqNo: Text)
    begin
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", ReqNo);
        IF ApprovalEntry.FIND('-') THEN BEGIN
            ApprovalEntry.DELETE;
            PurchaseRN.RESET;
            PurchaseRN.SETRANGE(PurchaseRN."No.", ReqNo);
            IF PurchaseRN.FIND('-') THEN BEGIN
                PurchaseRN.Status := PurchaseRN.Status::Open;
                PurchaseRN.MODIFY;
            END;
        END;
    end;



    procedure GetTotalStoresReq(UserID: Text) Message: Text
    begin
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", UserID);
        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", UserID);
        ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", UserID);
        IF ApprovalEntry.FIND('+') THEN BEGIN
            Message := ApprovalEntry."Approver ID";
        END
    end;


    procedure StudentProfileUpdated(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := FORMAT(Customer."Updated Profile");
        END
    end;


    procedure GetStudentPersonaldata(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := Customer.Name + '::' + FORMAT(Customer.Gender) + '::' + Customer."ID No" + '::' + FORMAT(Customer."Date Of Birth") + '::' +
            Customer."Phone No." + '::' + FORMAT(Customer."Disability Status") + '::' + FORMAT(Customer.Tribe) + '::' + FORMAT(Customer.Nationality)
            + '::' + FORMAT(Customer.County) + '::' +
            Customer.Address + '::' + Customer."Post Code" + '::' + Customer."Address 2" + '::' + Customer."Disability Description" + '::' +
            Customer."E-Mail";
        END
    end;


    procedure UpdateContStudentProfile(username: Text; Genderz: Integer; Phonez: Code[20]; Boxz: Code[50]; Codesz: Code[20]; Townz: Code[40]; Emailz: Text; Countyz: Code[50]; DateofBirth: Date; IDNumber: Text; PhysicalImpairments: Integer; PhysicalImpairmentsDetails: Text; Ethnic: Code[50]; Nationalityz: Code[50])
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Customer.Gender := Genderz;
            Customer."ID No" := IDNumber;
            Customer."Date Of Birth" := DateofBirth;
            Customer."Phone No." := Phonez;
            Customer."Disability Status" := PhysicalImpairments;
            Customer.Tribe := Ethnic;
            Customer.Nationality := Nationalityz;
            Customer.County := Countyz;
            Customer.Address := Boxz;
            Customer."Post Code" := Codesz;
            Customer."Address 2" := Townz;
            Customer."Disability Description" := PhysicalImpairmentsDetails;
            Customer."E-Mail" := Emailz;
            Customer."Updated Profile" := TRUE;
            Customer.MODIFY;
            //MESSAGE('Meal Item Updated Successfully');
        END;
    end;


    procedure GetUniversityMailPass(username: Text) Message: Text
    begin
        StudentCard.RESET;
        StudentCard.SETRANGE(StudentCard."No.", username);
        IF StudentCard.FIND('-') THEN BEGIN
            Message := StudentCard."University Email" + '::' + StudentCard."Email Password" + '::' + StudentCard."Phone No.";

        END
    end;


    procedure SubmitSupUnitsBaskets(studentNo: Text; AcademicYear: Text; Sem: Text; myStage: Text; Programmez: Text; UnitCode: Text; Categoryz: Integer; UnitDesc: Text)
    begin
        SupUnitsBasket.RESET;
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Academic Year", AcademicYear);
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Student No.", studentNo);
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Unit Code", UnitCode);
        SupUnitsBasket.SETRANGE(SupUnitsBasket.Stage, myStage);
        SupUnitsBasket.SETRANGE(SupUnitsBasket.Semester, Sem);

        IF NOT SupUnitsBasket.FIND('-') THEN BEGIN
            SupUnitsBasket.INIT;
            SupUnitsBasket."Academic Year" := AcademicYear;
            SupUnitsBasket.Semester := Sem;
            SupUnitsBasket."Student No." := studentNo;
            SupUnitsBasket.Stage := myStage;
            SupUnitsBasket.Programme := Programmez;
            SupUnitsBasket."Unit Code" := UnitCode;
            SupUnitsBasket."Unit Description" := UnitDesc;
            SupUnitsBasket.Status := SupUnitsBasket.Status::New;
            SupUnitsBasket.Category := Categoryz;
            SupUnitsBasket.INSERT(TRUE);
        END ELSE BEGIN
            SupUnitsBasket.MODIFY;
        END;
    end;

    procedure GetRegSupUnits(studentNo: Text; AcademicYear: Text; Sem: Text; myStage: Text; Categoryz: Integer) msg: Text
    begin
        SupUnits.RESET;
        SupUnits.SETRANGE(SupUnits."Student No.", studentNo);
        SupUnits.SETRANGE(SupUnits.Stage, myStage);
        SupUnits.SETRANGE(SupUnits.Semester, Sem);
        SupUnits.SETRANGE(SupUnits."Academic Year", AcademicYear);
        //SupUnits.SETRANGE(SupUnits.Category, Categoryz);
        IF SupUnits.FIND('-') THEN BEGIN
            REPEAT
                msg += SupUnits."Unit Code" + '::' + SupUnits."Unit Description" + ':::';
            UNTIL SupUnits.Next = 0;
        END;
    end;

    procedure SubmitSupUnits(studentNo: Text; AcademicYear: Text; Sem: Text; myStage: Text; Programmez: Text; UnitCode: Text; Categoryz: Integer; UnitDesc: Text; ThisemacYear: Text; CurrentSem: Text)
    begin
        SupUnits.RESET;
        SupUnits.SETRANGE(SupUnits."Student No.", studentNo);
        SupUnits.SETRANGE(SupUnits."Unit Code", UnitCode);
        SupUnits.SETRANGE(SupUnits.Stage, myStage);
        SupUnits.SETRANGE(SupUnits.Semester, Sem);
        SupUnits.SETRANGE(SupUnits."Academic Year", AcademicYear);
        IF NOT SupUnits.FIND('-') THEN BEGIN
            SupUnits.INIT;
            SupUnits."Academic Year" := AcademicYear;
            SupUnits.Semester := Sem;
            SupUnits."Student No." := studentNo;
            SupUnits.Stage := myStage;
            SupUnits.Programme := Programmez;
            SupUnits."Unit Code" := UnitCode;
            SupUnits."Unit Description" := UnitDesc;
            SupUnits.Status := SupUnits.Status::New;
            SupUnits.Category := Categoryz;
            SupUnits."Current Academic Year" := ThisemacYear;
            SupUnits."Current Semester" := CurrentSem;
            SupUnits.INSERT(TRUE);
            SupUnits.VALIDATE("Unit Code");
            SupUnitsBasket.RESET;
            SupUnitsBasket.SETRANGE(SupUnitsBasket."Student No.", studentNo);
            SupUnitsBasket.SETRANGE(SupUnitsBasket."Unit Code", UnitCode);
            SupUnitsBasket.SETRANGE(SupUnitsBasket.Semester, Sem);
            SupUnitsBasket.SETRANGE(SupUnitsBasket."Academic Year", AcademicYear);
            IF SupUnitsBasket.FIND('-') THEN BEGIN
                SupUnitsBasket.DELETE;
            END;
        END;
    end;


    procedure DeleteSupBasket(username: Text; Stagez: Text; Sem: Text; AcademicYear: Text; UnitCode: Text)
    begin
        SupUnitsBasket.RESET;
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Student No.", username);
        SupUnitsBasket.SETRANGE(SupUnitsBasket.Stage, Stagez);
        SupUnitsBasket.SETRANGE(SupUnitsBasket.Semester, Sem);
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Academic Year", AcademicYear);
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Unit Code", UnitCode);
        IF SupUnitsBasket.FIND('-') THEN BEGIN
            SupUnitsBasket.DELETE;
        END;
    end;


    procedure DeleteeSubmittedSup(username: Text; Stagez: Text; Sem: Text; AcademicYear: Text; UnitCode: Text)
    begin
        SupUnits.RESET;
        SupUnits.SETRANGE(SupUnits."Student No.", username);
        SupUnits.SETRANGE(SupUnits.Stage, Stagez);
        SupUnits.SETRANGE(SupUnits.Semester, Sem);
        SupUnits.SETRANGE(SupUnits."Academic Year", AcademicYear);
        SupUnits.SETRANGE(SupUnits."Unit Code", UnitCode);
        IF SupUnits.FIND('-') THEN BEGIN
            SupUnits.DELETE;
        END;
    end;



    procedure GetStudentCampus(username: Text) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Message := Customer."Global Dimension 1 Code";

        END
    end;


    procedure UpdateCampusCode(username: Text; CampusCode: Code[30]) Message: Text
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", username);
        IF Customer.FIND('-') THEN BEGIN
            Customer."Global Dimension 1 Code" := CampusCode;
            Customer.MODIFY;
            Message := 'Campus updated Successfully';
        END;
    end;


    procedure GetSupUnitTaken(UnitID: Text; StudentNo: Text; Stage: Text) Message: Text
    var
        TXTtaken: Label 'Taken';
        TXTNotTaken: Label 'Not Taken';
    begin
        SupUnits.RESET;
        SupUnits.SETRANGE(SupUnits."Unit Code", UnitID);
        SupUnits.SETRANGE(SupUnits."Student No.", StudentNo);
        SupUnits.SETRANGE(SupUnits.Stage, Stage);
        IF SupUnits.FIND('-') THEN BEGIN
            Message := TXTtaken + '::';
        END ELSE BEGIN
            Message := TXTNotTaken + '::';
        END
    end;


    procedure GetSupUnitSelected(UnitID: Text; StudentNo: Text; Stage: Text) Message: Text
    var
        TXTtaken: Label 'Taken';
        TXTNotTaken: Label 'Not Taken';
    begin
        SupUnitsBasket.RESET;
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Unit Code", UnitID);
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Student No.", StudentNo);
        SupUnitsBasket.SETRANGE(SupUnitsBasket.Stage, Stage);
        IF SupUnitsBasket.FIND('-') THEN BEGIN
            Message := TXTtaken + '::';
        END ELSE BEGIN
            Message := TXTNotTaken + '::';
        END
    end;


    procedure DeleteSelectedSupUnit(studentNo: Text; UnitID: Text)
    begin
        SupUnitsBasket.RESET;
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Student No.", studentNo);
        SupUnitsBasket.SETRANGE(SupUnitsBasket."Unit Code", UnitID);
        IF SupUnitsBasket.FIND('-') THEN BEGIN
            SupUnitsBasket.DELETE;
            MESSAGE('Deleted Successfully');
        END;
    end;


    procedure GetAllowedHostelBookingGroup(username: Text) Message: Text
    begin
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", username);
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);
        CourseRegistration.SETCURRENTKEY(Stage);
        IF CourseRegistration.FIND('+') THEN BEGIN
            Message := CourseRegistration.Stage + '::' + CourseRegistration.Semester;
        END;
    end;


    procedure GetHostelGenSetups() Message: Text
    begin
        GenSetup.RESET;
        IF GenSetup.FIND('-') THEN BEGIN
            Message := GenSetup."Default Year" + '::' + GenSetup."Default Semester";

        END
    end;


    procedure SubmitForClearance(username: Text; Programmm: Text) Message: Text
    begin
        IF Customer.GET(username) THEN BEGIN
            Customer.CALCFIELDS(Balance);
            IF Customer.Balance > 0 THEN BEGIN
                Message := 'Clearance application not successful! Your Balance is greater than zero!';
            END;
        END;
        IF NOT (Customer.Balance > 0) THEN BEGIN
            NextJobapplicationNo := NoSeriesMgt.GetNextNo('CLRE', 0D, TRUE);
            ClearanceHeader.RESET;
            ClearanceHeader.SETRANGE(ClearanceHeader."Student No.", username);
            IF NOT ClearanceHeader.FIND('-') THEN BEGIN
                ClearanceHeader.INIT;
                ClearanceHeader."No." := NextJobapplicationNo;
                ClearanceHeader.Date := TODAY;
                ClearanceHeader."Student No." := username;
                ClearanceHeader.Programme := Programmm;
                ClearanceHeader.Status := ClearanceHeader.Status::New;
                ClearanceHeader."No. Series" := 'CLRE';
                ClearanceHeader.INSERT;
                IF ClearanceHeader.INSERT THEN;
                Customer.RESET;
                Customer.SETRANGE(Customer."No.", username);
                IF Customer.FIND('-') THEN BEGIN
                    Customer."Applied for Clearance" := TRUE;
                    Customer."Clearance Initiated by" := username;
                    Customer."Clearance Initiated Date" := TODAY;
                    Customer."Clearance Initiated Time" := TIME;
                    Customer."Clearance Reason" := Customer."Clearance Reason"::Graduation;
                    Customer.MODIFY;
                END;
                Message := 'Clearance request successfully initiated';
            END ELSE BEGIN
                Message := 'You already initiated your clearance process.';
            END;
        END;
    end;


    procedure IsStageFinal(Stage: Text; programm: Text) Message: Text
    begin
        Stages.RESET;
        Stages.SETRANGE(Stages."Programme Code", programm);
        Stages.SETRANGE(Stages.Code, Stage);
        IF Stages.FIND('-') THEN BEGIN
            Message := FORMAT(Stages."Final Stage");

        END
    end;


    procedure HasAppliedClearance(username: Text) Message: Text
    var
        TXTApplied: Label 'Yes';
        TXTNotApplied: Label 'Not Applied';
    begin
        ClearanceHeader.RESET;
        ClearanceHeader.SETRANGE(ClearanceHeader."Student No.", username);
        IF ClearanceHeader.FIND('-') THEN BEGIN
            Message := TXTApplied + '::';
        END ELSE BEGIN
            Message := TXTNotApplied + '::';
        END
    end;


    procedure GenerateClearanceForm(StudentNo: Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        ClearanceHeader.RESET;
        ClearanceHeader.SETRANGE(ClearanceHeader."Student No.", StudentNo);

        IF ClearanceHeader.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Students Clearance", filename, ClearanceHeader);
        END;
    end;

    procedure GenerateStudentResitExamCard(StudentNo: Text; Sem: Text; filenameFromApp: Text): Text
    var
        filename: Text;
        cusz: Record Customer;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        cusz.RESET;
        cusz.SETRANGE("No.", StudentNo);
        IF cusz.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(Report::"Resit Exam  Card Final", filename, cusz);
        END;
    end;

    procedure GenerateBS64ResitExamCard(StudentNo: Text; Sem: Text; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
    var
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        recRef: RecordRef;
        filename: Text;
        cusz: Record Customer;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        cusz.RESET;
        cusz.SETRANGE("No.", StudentNo);
        IF cusz.FIND('-') THEN BEGIN
            recRef.GetTable(cusz);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(52157, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END;
        EXIT(filename);
    end;

    procedure EraseStudentGeneratedFile(filenameFromApp: Text) filename: Text
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
    end;

    procedure DeleteRegisteredUnit(Unit: Code[20]; Sem: Code[20]; StudNo: Code[20]) rtnMsg: Text
    begin
        studetUnits.RESET;
        studetUnits.SETRANGE(studetUnits."Student No.", StudNo);
        studetUnits.SETRANGE(studetUnits.Semester, Sem);
        studetUnits.SETRANGE(studetUnits.Unit, Unit);
        IF studetUnits.FIND('-') THEN BEGIN
            studetUnits.CALCFIELDS("CATs Marks Exists", "EXAMs Marks Exists");
            IF ((studetUnits."CATs Marks Exists") OR (studetUnits."EXAMs Marks Exists")) THEN
                rtnMsg := 'Marks Exist you cannot Delete!';
            IF (rtnMsg = '') THEN BEGIN
                studetUnits.DELETE;
                rtnMsg := 'SUCCESS: You have deleted ' + Unit;
            END;
        END;
    end;

    procedure ChechPostedSemReg(StudNo: Code[30]; Sem: Code[30]) Message: Text
    begin
        CourseReg.RESET;
        CourseReg.SETRANGE(CourseReg."Student No.", StudNo);
        CourseReg.SETRANGE(CourseReg.Semester, Sem);
        IF CourseReg.FIND('-') THEN BEGIN
            IF CourseReg.Posted = TRUE THEN BEGIN
                Message := 'YES' + '::';
            END
            ELSE BEGIN
                Message := 'NO' + '::';
            END
        END;
    end;

    procedure GenerateSudTransferLetter(AdmNo: Text; filenameFromApp: Text)
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        StudentsTransfer.RESET;
        StudentsTransfer.SETRANGE(StudentsTransfer."New Student No", AdmNo);

        IF StudentsTransfer.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(61612, filename, StudentsTransfer);
        END;
    end;

    procedure DeleteRegisteredSupp(Unit: Code[20]; Sem: Code[20]; StudNo: Code[20]) rtnMsg: Text
    begin
        AcaSpecialExamsDetailss.RESET;
        AcaSpecialExamsDetailss.SETRANGE(AcaSpecialExamsDetailss."Student No.", StudNo);
        AcaSpecialExamsDetailss.SETRANGE(AcaSpecialExamsDetailss.Semester, Sem);
        AcaSpecialExamsDetailss.SETRANGE(AcaSpecialExamsDetailss."Unit Code", Unit);
        IF AcaSpecialExamsDetailss.FIND('-') THEN BEGIN
            IF ((AcaSpecialExamsDetailss."Exam Marks" <> 0)) THEN
                rtnMsg := 'Marks Exist you cannot Delete!';
            IF (rtnMsg = '') THEN BEGIN
                AcaSpecialExamsDetailss.DELETE;
                rtnMsg := 'SUCCESS: You have deleted ' + Unit;
            END;
        END;
    end;

    procedure InterSchoolTransferApprovalRequest(StudNumber: Code[30]; DepartmentCode: Code[30])
    begin
        InterSchoolTransfer.RESET;
        InterSchoolTransfer.SETRANGE("Student No", StudNumber);
        IF InterSchoolTransfer.FIND('-') THEN BEGIN
            State := State::Open;
            IF InterSchoolTransfer.Status <> InterSchoolTransfer.Status::"Pending approval" THEN State := State::Open;
            //DocType := DocType::"School Transfer";
            CLEAR(tableNo);
            tableNo := 61612;
            //IF AppMgt.SendApproval(tableNo, StudNumber, DocType, State, DepartmentCode, 0) THEN;
        END;
    end;

    procedure SubmitInterSchoolTransferRequest(AdmNo: Text; Department: Text; CurrentProg: Text; NewProg: Text; Reason: Text; KCSEAggregate: Text; KCSEResultSlip: Text; Semester: Code[30]) Message: Text
    begin
        InterSchoolTransfer.RESET;
        InterSchoolTransfer.INIT;
        InterSchoolTransfer.SETRANGE("Student No", AdmNo);
        InterSchoolTransfer.SETRANGE(Status, 1);
        IF InterSchoolTransfer.FIND('-') THEN BEGIN
            Message := 'You already have an application with pending approval.' + '::';
        END
        ELSE BEGIN
            InterSchoolTransfer."Student No" := AdmNo;
            InterSchoolTransfer."Responsibility Centre" := Department;
            InterSchoolTransfer."Current Programme" := CurrentProg;
            InterSchoolTransfer."New Programme" := NewProg;
            InterSchoolTransfer."Reason for Transfer" := Reason;
            InterSchoolTransfer."Agregate Points" := KCSEAggregate;
            InterSchoolTransfer."Result Slip" := KCSEResultSlip;
            InterSchoolTransfer.Status := 1;
            InterSchoolTransfer.Semester := Semester;
            InterSchoolTransfer.INSERT(TRUE);
            Message := 'Application for inter-school transfer submitted successfully!' + '::';
        END;
    end;

    procedure IsProgOptionsAllowed(Prog: Code[20]; Stage: Code[20]) Message: Text
    begin
        ProgStages.RESET;
        ProgStages.SETRANGE(ProgStages.Code, Stage);
        ProgStages.SETRANGE(ProgStages."Programme Code", Prog);
        ProgStages.SETRANGE(ProgStages."Allow Programme Options", TRUE);
        IF ProgStages.FIND('-') THEN BEGIN
            Message := 'Yes' + '::';
        END ELSE BEGIN
            Message := 'No' + '::';
        END;
    end;

    procedure CheckGraduationStatus(AdmNo: Code[30]) Message: Text
    var
        Success: Label 'Graduated';
        Fail: Label 'Not Graduated';
        NotFound: Label 'Not Found';
    begin
        ClassifiactionStudents.RESET;
        ClassifiactionStudents.INIT;
        ClassifiactionStudents.SETRANGE("Student Number", AdmNo);
        IF ClassifiactionStudents.FIND('-') THEN BEGIN
            IF ClassifiactionStudents.Graduating = TRUE THEN BEGIN
                Message := Success + '::';
            END
            ELSE
                Message := Fail + '::';
        END
        ELSE BEGIN
            Message := NotFound + '::';
        END
    end;

    procedure CheckSemLecturerEvaluation(Semester: Code[30]) Message: Text
    var
        Semesters: Record "ACA-Semesters";
        Success: Label 'Success';
        Fail: Label 'Fail';
    begin
        Semesters.RESET;
        Semesters.INIT;
        Semesters.SETRANGE(Code, Semester);
        IF Semesters.FIND('-') THEN BEGIN
            IF Semesters."Evaluate Lecture" = TRUE THEN BEGIN
                Message := Success + '::';
            END
            ELSE
                Message := Fail + '::';
        END
    end;

    procedure CheckOnlineAccountStatus(username: Text) Message: Text
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := FORMAT(OnlineUsersz.Confirmed);
        END
    end;

    procedure CheckOnlineLogin(username: Text; passrd: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'Incorrect Username or Password';
        TXTCorrectDetails: Label 'Login';
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        OnlineUsersz.SETRANGE(OnlineUsersz.Password, passrd);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            FullNames := OnlineUsersz."First Name" + ' ' + OnlineUsersz."Middle Name" + ' ' + OnlineUsersz."Last Name";
            Message := TXTCorrectDetails + '::' + OnlineUsersz."Email Address" + '::' + OnlineUsersz."ID No" + '::' + FullNames;
        END ELSE BEGIN
            Message := TXTIncorrectDetails + '::';
        END
    end;

    procedure RegisterOnlineAccount(EmailAddress: Text; IDNo: Text; Genderz: Integer; PhoneNo: Text; Passwordz: Text; FirstName: Text; MiddleName: Text; LastName: Text; SessionIDz: Text; DoBz: Date; Countyz: Code[50]; MaritalStatus: Integer; Nationalityz: Code[50]; PostalAddress: Text)
    begin
        OnlineUsersz.INIT;
        OnlineUsersz."Email Address" := EmailAddress;
        OnlineUsersz."ID No" := IDNo;
        OnlineUsersz.Gender := Genderz;
        OnlineUsersz."Phone No" := PhoneNo;
        OnlineUsersz.Password := Passwordz;
        OnlineUsersz."First Name" := FirstName;
        OnlineUsersz."Middle Name" := MiddleName;
        OnlineUsersz."Last Name" := LastName;
        OnlineUsersz.SessionID := SessionIDz;
        OnlineUsersz.Confirmed := false;
        OnlineUsersz.DoB := DoBz;
        OnlineUsersz.County := Countyz;
        OnlineUsersz."Marital Status" := MaritalStatus;
        OnlineUsersz.Nationality := Nationalityz;
        OnlineUsersz."Postal Address" := PostalAddress;
        OnlineUsersz.INSERT(TRUE);
    end;

    procedure GetOnlineSessionID(sessionIDz: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'No';
        TXTCorrectDetails: Label 'Yes';
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz.SessionID, sessionIDz);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := TXTCorrectDetails;
        END ELSE BEGIN
            Message := TXTIncorrectDetails;
        END
    end;

    procedure ActivateOnlineUserAccount(sessionIDz: Text) Message: Text
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz.SessionID, sessionIDz);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := FORMAT(OnlineUsersz.Confirmed);
            OnlineUsersz.Confirmed := TRUE;
            OnlineUsersz.MODIFY;
        END
    end;

    procedure GetOnlineUserDetails(username: Text) Message: Text
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        //OnlineUsersz.SETRANGE(OnlineUsersz.Password,passrd);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := OnlineUsersz."Email Address" + '::' + OnlineUsersz."Phone No" + '::' + FORMAT(OnlineUsersz.Gender) + '::' + OnlineUsersz."First Name" + '::' + OnlineUsersz."Middle Name" + '::' + OnlineUsersz."Last Name" + '::' + OnlineUsersz."Postal Address";
        END
    end;

    procedure GetOnlineEmailExists(emailaddress: Text) Message: Text
    var
        TXTIncorrectDetails: Label 'No';
        TXTCorrectDetails: Label 'Yes';
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", emailaddress);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := TXTCorrectDetails;
        END ELSE BEGIN
            Message := TXTIncorrectDetails;
        END
    end;

    procedure GetOnlineUserDetailsMore(username: Text) Message: Text
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        //OnlineUsersz.SETRANGE(OnlineUsersz.Password,passrd);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := FORMAT(OnlineUsersz."Marital Status") + '::' + FORMAT(OnlineUsersz.County) + '::' + FORMAT(OnlineUsersz.Nationality) + '::' + FORMAT(OnlineUsersz.DoB);
        END
    end;

    procedure GetKuccpsFamilydata(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw."Full Name of Father" + '::' + FORMAT(KUCCPSRaw."Father Status") + '::' + KUCCPSRaw."Father Occupation" + '::' + FORMAT(KUCCPSRaw."Father Date of Birth") + '::' + KUCCPSRaw."Name of Mother" + '::' +
            FORMAT(KUCCPSRaw."Mother Status") + '::' + KUCCPSRaw."Mother Occupation" + '::' + FORMAT(KUCCPSRaw."Mother Date of Birth") + '::' + KUCCPSRaw."Number of brothers and sisters" + '::' + KUCCPSRaw."Father Telephone" + '::' + KUCCPSRaw."Mother Telephone";
        END
    end;

    procedure GetKuccpsResidencedata(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw."Place of Birth" + '::' + KUCCPSRaw."Permanent Residence" + '::' + KUCCPSRaw."Nearest Town" + '::' + KUCCPSRaw.Location + '::' + KUCCPSRaw."Name of Chief" + '::' +
            FORMAT(KUCCPSRaw.County) + '::' + KUCCPSRaw."Sub-County" + '::' + KUCCPSRaw.Constituency + '::' + KUCCPSRaw."Nearest Police Station";
        END
    end;

    procedure GetKuccpsEmmergencydata(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw."Emergency Name1" + '::' + KUCCPSRaw."Emergency Relationship1" + '::' + KUCCPSRaw."Emergency P.O. Box1" + '::' + KUCCPSRaw."Emergency Phone No1" + '::' + KUCCPSRaw."Emergency Email1" + '::' +
            KUCCPSRaw."Emergency Name2" + '::' + KUCCPSRaw."Emergency Relationship2" + '::' + KUCCPSRaw."Emergency P.O. Box2" + '::' + KUCCPSRaw."Emergency Phone No2" + '::' + KUCCPSRaw."Emergency Email2";

        END
    end;

    procedure GetUnitSubjects(progcode: Text; stagecode: Text; option: Code[20]) Message: Text
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects."Programme Code", progcode);
        UnitSubjects.SETRANGE(UnitSubjects."Stage Code", stagecode);
        UnitSubjects.SETFILTER(UnitSubjects."Programme Option", '%1|%2', option, '');
        UnitSubjects.SETRANGE(UnitSubjects."Time Table", True);
        UnitSubjects.SETRANGE(UnitSubjects."Old Unit", False);
        IF UnitSubjects.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + UnitSubjects.Code + ' ::' + UnitSubjects.Desription + ' :::';
            UNTIL UnitSubjects.Next = 0;
        END
    end;

    procedure GetSupUnits(studno: Text; progcode: Text; stagecode: Text; sem: Text) Message: Text
    var
        stdUnits2: Record "ACA-Student Units";
    begin
        StudentUnits.RESET;
        StudentUnits.SETRANGE(StudentUnits."Student No.", studno);
        StudentUnits.SETRANGE(StudentUnits.Programme, progcode);
        StudentUnits.SETRANGE(StudentUnits.Stage, stagecode);
        StudentUnits.SETRANGE(StudentUnits.Semester, sem);
        StudentUnits.SETRANGE(StudentUnits."Marks Exists", TRUE);
        if StudentUnits.Find('-') then begin
            StudentUnits.CalcFields("Total Score");
            StudentUnits.SETFILTER(StudentUnits."Total Score", '<%1', 40);
            if StudentUnits.Find('-') then begin
                REPEAT
                    UnitSubjects.RESET;
                    UnitSubjects.SETRANGE(UnitSubjects.Code, StudentUnits.Unit);
                    UnitSubjects.SETRANGE(UnitSubjects."Programme Code", progcode);
                    UnitSubjects.SETRANGE(UnitSubjects."Stage Code", stagecode);
                    IF UnitSubjects.FIND('-') THEN BEGIN
                        Message := Message + UnitSubjects.Code + ' ::' + UnitSubjects.Desription + ' :::';
                    END;
                UNTIL StudentUnits.Next = 0;
            end;
        end;
    end;

    procedure GetKuccpsAcademicdata(username: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw."OLevel School" + '::' + KUCCPSRaw.Index + '::' + KUCCPSRaw."OLevel Year Completed" + '::' + KUCCPSRaw."Primary School" + '::' + KUCCPSRaw."Primary Index no" + '::' +
            KUCCPSRaw."Primary Year Completed" + '::' + KUCCPSRaw."K.C.P.E. Results" + '::' + KUCCPSRaw."Any Other Institution Attended";

        END
    end;

    procedure UpdateKUCCPSProfile3(username: Text; Genderz: Integer; Phonez: Code[20]; Boxz: Code[50]; Codesz: Code[20]; Townz: Code[40]; Emailz: Text; Countyz: Code[50]; DateofBirth: Date; IDNumber: Text; NIIMSNo: Text; PhysicalImpairments: Integer; PhysicalImpairmentsDetails: Text)
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            KUCCPSRaw.Gender := Genderz;
            KUCCPSRaw.Phone := Phonez;
            KUCCPSRaw.Box := Boxz;
            KUCCPSRaw.Codes := Codesz;
            KUCCPSRaw.Town := Townz;
            KUCCPSRaw.Email := Emailz;
            KUCCPSRaw.County := Countyz;
            KUCCPSRaw."Date of Birth" := DateofBirth;
            KUCCPSRaw."ID Number/BirthCert" := IDNumber;
            KUCCPSRaw."NIIMS No" := NIIMSNo;
            KUCCPSRaw."Disability Status" := PhysicalImpairments;
            KUCCPSRaw."Disability Description" := PhysicalImpairmentsDetails;

            KUCCPSRaw.Updated := TRUE;
            KUCCPSRaw.MODIFY;
        END
    end;

    procedure UpdateKUCCPSProfile2(username: Text; NHIFNo: Text; Religionz: Code[20]; Tribez: Text; Nationalityz: Code[50]; CountyOriginz: Text; MaritalStatus: Integer; NameOfSpouse: Text; OccupationOfSpouse: Text; SpousePhoneNo: Code[30]; NumberOfChildren: Text; FullNameofFather: Text; FatherStatus: Integer; FatherOccupation: Text; FatherDateOfBirth: Date; NameOfMother: Text; MotherStatus: Integer; MotherOccupation: Text; MotherDateOfBirth: Date; NumberOfbrothersandsisters: Code[20]; PlaceOfBirth: Text; PermanentResidence: Text; NearestTown: Text; Locationz: Text; NameOfChief: Text; SubCounty: Text; Constituencyz: Text; NearestPoliceStation: Text)
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN

            KUCCPSRaw."Marital Status" := MaritalStatus;
            KUCCPSRaw."Name of Spouse" := Religionz;
            KUCCPSRaw."Ethnic Background" := Tribez;
            KUCCPSRaw.Nationality := Nationalityz;
            KUCCPSRaw.County := CountyOriginz;
            KUCCPSRaw."Occupation of Spouse" := OccupationOfSpouse;
            KUCCPSRaw."Name of Spouse" := NameOfSpouse;
            KUCCPSRaw."Occupation of Spouse" := OccupationOfSpouse;
            KUCCPSRaw."Spouse Phone No" := SpousePhoneNo;
            KUCCPSRaw."Number of Children" := NumberOfChildren;
            KUCCPSRaw."Full Name of Father" := FullNameofFather;
            KUCCPSRaw."Father Status" := FatherStatus;
            // KUCCPSRaw."Father Phone" := FatherPhone;
            KUCCPSRaw."Father Occupation" := FatherOccupation;
            KUCCPSRaw."Father Date of Birth" := FatherDateOfBirth;
            KUCCPSRaw."Name of Mother" := NameOfMother;
            KUCCPSRaw."Mother Status" := MotherStatus;
            // KUCCPSRaw."Mother Phone" := MotherPhone;
            KUCCPSRaw."Mother Occupation" := MotherOccupation;
            KUCCPSRaw."Mother Date of Birth" := MotherDateOfBirth;
            KUCCPSRaw."Number of brothers and sisters" := NumberOfbrothersandsisters;
            KUCCPSRaw."Place of Birth" := PlaceOfBirth;
            KUCCPSRaw."Permanent Residence" := PermanentResidence;
            KUCCPSRaw."Nearest Town" := NearestTown;
            KUCCPSRaw.Location := Locationz;
            KUCCPSRaw."Name of Chief" := NameOfChief;
            KUCCPSRaw."Sub-County" := SubCounty;
            KUCCPSRaw.Constituency := Constituencyz;
            KUCCPSRaw."Nearest Police Station" := NearestPoliceStation;
            KUCCPSRaw.Updated := TRUE;
            KUCCPSRaw.MODIFY;
        END
    end;

    procedure UpdateKUCCPSProfileMore(username: Text; EmergencyName1: Text; EmergencyRelationship1: Text; EmergencyBox1: Text; EmergencyPhoneNo1: Code[30]; EmergencyEmail1: Text; EmergencyName2: Text; EmergencyRelationship2: Text; EmergencyBox2: Text; EmergencyPhoneNo2: Code[30]; EmergencyEmail2: Text; OLevelSchool: Text; OLevelYearCompleted: Code[20]; PrimarySchool: Text; PrimaryIndexNo: Text; PrimaryYearCompleted: Code[20]; KCPEResults: Text; AnyOtherInstitutionAttended: Text)
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, username);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            KUCCPSRaw."Emergency Name1" := EmergencyName1;
            KUCCPSRaw."Emergency Relationship1" := EmergencyRelationship1;
            KUCCPSRaw."Emergency P.O. Box1" := EmergencyBox1;
            KUCCPSRaw."Emergency Phone No1" := EmergencyPhoneNo1;
            KUCCPSRaw."Emergency Email1" := EmergencyEmail1;
            KUCCPSRaw."Emergency Name2" := EmergencyName2;
            KUCCPSRaw."Emergency P.O. Box2" := EmergencyBox2;
            KUCCPSRaw."Emergency Phone No2" := EmergencyPhoneNo2;
            KUCCPSRaw."Emergency Email2" := EmergencyEmail2;
            KUCCPSRaw."OLevel School" := OLevelSchool;
            KUCCPSRaw."OLevel Year Completed" := OLevelYearCompleted;
            KUCCPSRaw."Primary School" := PrimarySchool;
            KUCCPSRaw."Primary Index no" := PrimaryIndexNo;
            KUCCPSRaw."Primary Year Completed" := PrimaryYearCompleted;
            KUCCPSRaw."K.C.P.E. Results" := KCPEResults;
            KUCCPSRaw."Any Other Institution Attended" := AnyOtherInstitutionAttended;
            KUCCPSRaw.Updated := TRUE;
            KUCCPSRaw.MODIFY;
            //MESSAGE('Meal Item Updated Successfully');
        END
    end;
    //New Admissions Portal Procedures
    procedure GetSSDetails(username: text) Message: Text
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := OnlineUsersz."First Name" + ' ::' + OnlineUsersz."Middle Name" + ' ::' + OnlineUsersz."Last Name" + ' ::' + OnlineUsersz."Phone No" + ' ::' + FORMAT(OnlineUsersz.Gender) + ' ::';
        END;
    end;

    procedure SendPasswordResetCode(username: Text; resetcode: Text) Message: Boolean
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            OnlineUsersz.SessionID := resetcode;
            OnlineUsersz.MODIFY;
            Message := TRUE;
        END
    end;

    procedure GetMyApplications(username: Text) apps: Text
    var
        progname: Text;
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist.Email, username);
        IF fablist.FIND('-') THEN BEGIN
            REPEAT
                programs.RESET;
                programs.SETRANGE(programs.Code, fablist."First Degree Choice");
                IF programs.FIND('-') THEN BEGIN
                    progname := programs.Description;
                END;
                apps := apps + fablist."Application No." + ' ::' + progname + ' ::' + FORMAT(fablist."Application Date") + ' ::' + FORMAT(fablist.Status) + ' ::' + FORMAT(fablist."Process Application") + ' :::';
            UNTIL fablist.Next = 0;
        END;
    end;

    procedure GetProgramCode(index: Text) Message: Text
    begin
        KUCCPSRaw.RESET;
        KUCCPSRaw.SETRANGE(Index, index);
        IF KUCCPSRaw.FIND('-') THEN BEGIN
            Message := KUCCPSRaw.prog;

        END
    end;

    procedure GenerateAppFeeStructure(Programz: Code[20]; SettlementType: Code[20]; filenameFromApp: Text) filename: Text
    begin
        filename := FILESPATH_APP + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        //MESSAGE('OK');
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, Programz);
        Programme.SETFILTER(Programme."Settlement Type Filter", '%1', SettlementType);

        IF Programme.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"Fee Structure Summary Report", filename, Programme);   //52017726
        END;
        EXIT(filename);
    end;

    procedure GenerateAdmnNo(username: Text) admNo: Text
    var
        progname: Text;
        settlementPrefix: Text;
        degCode: Text;
        NewAdminCode: Text;
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Index Number", username);
        IF fablist.FIND('-') THEN BEGIN
            IF (fablist."Admission No" <> '') THEN ERROR('Admission Number axists: ' + fablist."Admission No");
            CLEAR(settlementPrefix);
            degCode := '';
            IF fablist."Admitted Degree" = '' THEN BEGIN
                IF fablist."First Degree Choice" <> '' THEN BEGIN
                    fablist."Admitted Degree" := fablist."First Degree Choice";
                    fablist.MODIFY;
                END;
            END;
            AdminSetup.RESET;
            AdminSetup.SETRANGE(AdminSetup.Degree, fablist."First Degree Choice"); //AdminSetup.SETRANGE(AdminSetup.Degree, Rec."Admitted Degree");
            IF AdminSetup.FIND('-') THEN BEGIN
                IF ((fablist."Settlement Type" = 'GSS') OR (fablist."Settlement Type" = 'KUCCPS') OR (fablist."Settlement Type" = 'JAB')) THEN
                    settlementPrefix := AdminSetup."JAB Prefix"
                ELSE
                    IF ((fablist."Settlement Type" = 'SSS') OR (fablist."Settlement Type" = 'SSP') OR (fablist."Settlement Type" = 'SELFSPONSORED')) THEN
                        settlementPrefix := AdminSetup."SSP Prefix";
                CLEAR(NewAdminCode);
                BEGIN
                    NewAdminCode := NoSeriesMgt.GetNextNo(AdminSetup."No. Series", TODAY, TRUE);
                    fablist."Admission No" := AdminSetup."Programme Prefix" + '/' + NewAdminCode + '/' + AdminSetup.Year;
                    fabList."Student E-mail" := NewAdminCode + '@student.embuni.ac.ke';
                    fablist.MODIFY;

                    KUCCPSRaw.Reset();
                    KUCCPSRaw.SETRANGE(Index, username);
                    IF KUCCPSRaw.FIND('-') THEN BEGIN
                        KUCCPSRaw.Admin := AdminSetup."Programme Prefix" + '/' + NewAdminCode + '/' + AdminSetup.Year;
                        KUCCPSRaw.MODIFY;
                    END;
                END;
            END ELSE BEGIN
                ERROR('The Admission Number Setup For Programme ' + FORMAT(fablist."Admitted Degree") + ' Does Not Exist');
            END;
            MESSAGE('Admission number generated successfully!');
            admNo := AdminSetup."Programme Prefix" + '/' + NewAdminCode + '/' + AdminSetup.Year;
        end;
    END;

    procedure ResetPassword(username: Text; resetcode: Text; newpassword: Text) Message: Boolean
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        OnlineUsersz.SETRANGE(OnlineUsersz.SessionID, resetcode);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            OnlineUsersz.Password := newpassword;
            OnlineUsersz.MODIFY;
            Message := TRUE;
        END
    end;

    procedure CheckValidOnlineAccount(username: Text) Message: Boolean
    begin
        OnlineUsersz.RESET;
        OnlineUsersz.SETRANGE(OnlineUsersz."Email Address", username);
        IF OnlineUsersz.FIND('-') THEN BEGIN
            Message := true;
        END
    end;

    procedure UpdateKUCCPSProfile(index: code[20]; fname: text; mmname: text; lname: text; fullname: Text; gender: option; dob: Date; nationality: text; county: text; idNo: code[20]; passPort: code[20];
   idDoc: Option; religion: text; otherreligion: Text; maritalStat: Option;
   disability: option; disTyp: Option; knewThru: Text; ethnic: Text; phoneNo: Text; altPhoneNo: text; email: Text;
   postAddress: Text; town: text; kinName: Text; kinEmail: Text; kinPhoneNo: Text; kinrel: Text; fpName: Text; fpEmail: Text; fpPhoneNo: Text; fpRel: Text; highSchool: Text; hschF: Code[20]; hschT: Code[20]) Message: Text
    var
        appNo: Code[20];
    begin
        fablist.Reset;
        fablist.SetRange("Index Number", Index);
        if not fablist.find('-') then begin
            appNo := NoSeriesMgt.GetNextNo('APPLIC-NO', 0D, TRUE);
            fablist.Init;
            fabList."Application No." := appNo;
            fabList.firstName := fname;
            fablist."Other Names" := mmname;
            fablist.Surname := lname;
            fablist."Full Names" := fullname;
            fabList."Index Number" := index;
            fabList.Gender := gender;
            fabList."Date Of Birth" := dob;
            fabList.Nationality := Nationality;
            fabList.County := county;
            fabList."ID Number" := idNo;
            fabList."Passport Number" := passPort;
            fabList."Identification Documemnt" := idDoc;
            fabList.Religion := religion;
            fablist."Other Religion Description" := otherreligion;
            /*fabList.Denomination := denomination;
            fabList.Congregation := congregation;
            fabList.Diocese := diocese;
            fablist."Order/Instutute" := inst;
            fablist."Protestant Congregation" := protCongregation;*/
            fabList."Marital Status" := maritalStat;
            fabList.Disability := disability;
            fablist."Nature of Disability" := disTyp;
            fabList."Knew College Thru" := knewThru;
            fablist.Ethicity := ethnic;
            fabList."Telephone No. 1" := phoneNo;
            fablist."Telephone No. 2" := altPhoneNo;
            fabList.Email := email;
            fabList."Address for Correspondence1" := postAddress;
            fablist."Address for Correspondence3" := town;
            fablist."Next of kin Name" := kinName;
            fabList."Next Of Kin Email" := kinEmail;
            fablist."Next of kin Mobile" := kinPhoneNo;
            fablist."Next of Kin R/Ship" := kinRel;
            fabList."Emergency Contact Name" := fpName;
            fablist."Emergency Contact Telephone" := fpPhoneNo;
            fabList."Emergency Contact Email" := fpEmail;
            fabList."Fee payer R/Ship" := fpRel;
            fablist."Former School Code" := highSchool;
            fabList."High School From Year" := hschF;
            fabList."High School To Year" := hschT;
            fablist."Settlement Type" := 'GSS';
            fabList."Application Date" := Today;
            KUCCPSRaw.RESET;
            KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, index);
            IF KUCCPSRaw.FIND('-') THEN BEGIN
                //fabList."Year of Examination" := KUCCPSRaw."OLevel Year Completed";
                programs.RESET;
                programs.SETRANGE(programs.Code, KUCCPSRaw.Prog);
                IF programs.FIND('-') THEN BEGIN
                    fablist."First Degree Choice" := programs.Code;
                    fablist."Programme Faculty" := programs.Faculty;
                    fablist.programName := programs.Description;
                    fablist."Admitted Department" := programs."Department Code";
                end;
            end;
            fablist.Status := fablist.Status::Admitted;
            fabList.Insert;
            KUCCPSRaw.RESET;
            KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, index);
            IF KUCCPSRaw.FIND('-') THEN BEGIN
                KUCCPSRaw.Updated := TRUE;
                KUCCPSRaw.MODIFY;
            end;
            Message := appNo;
        end;
    end;

    procedure Returned(appNo: Code[20]) msg: Boolean
    begin
        fablist.Reset;
        fablist.SetRange("Application No.", appNo);
        if fablist.Find('-') then begin
            msg := fablist.returned;
        end;
    end;

    procedure DocsReattached(appNo: Code[20]) msg: Boolean
    begin
        fablist.Reset;
        fablist.SetRange("Application No.", appNo);
        if fablist.Find('-') then begin
            fablist.returned := false;
            fablist.modify;
            msg := true;
        end;
    end;

    procedure DeleteKUCCPSProfile(index: code[20]) Message: Boolean
    var
        appNo: Code[20];
    begin
        fablist.Reset;
        fablist.SetRange("Index Number", Index);
        if fablist.find('-') then begin
            KUCCPSRaw.RESET;
            KUCCPSRaw.SETRANGE(KUCCPSRaw.Index, index);
            IF KUCCPSRaw.FIND('-') THEN BEGIN
                KUCCPSRaw.Updated := False;
                KUCCPSRaw.MODIFY;
            end;
            fablist.DeleteAll;
            Message := true;
        end;
    end;

    procedure UploadPassportPhoto(appNo: Code[20]; bs64: Text) uploaded: boolean
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        RecordRef: RecordRef;
        OutStream: OutStream;
        Instream: Instream;
        Bytes: DotNet Array;
        MemoryStream: dotnet MemoryStream;
    begin
        fablist.Reset;
        fablist.SetRange("Application No.", appNo);
        if fablist.Find('-') then begin
            Clear(fablist."Passport Photo");
            Bytes := Convert.FromBase64String(bs64);
            MemoryStream := MemoryStream.MemoryStream(Bytes);
            fablist."Passport Photo".CreateOutStream(OutStream);
            MemoryStream.WriteTo(OutStream);
            fablist.Modify;
        end;
        uploaded := true;
    end;

    procedure GetIndexNo(appNo: Code[20]) msg: Text
    begin
        fablist.Reset;
        fablist.SetRange("Application No.", appNo);
        if fablist.Find('-') then begin
            msg := fabList."Index Number";
        end;
    end;

    procedure GetStdsWithoutProfiles() msg: Text
    begin
        fablist.Reset;
        if fablist.Find('-') then begin
            REPEAT
                if not fablist."Passport Photo".HasValue then begin
                    msg += fabList."Application No." + '::' + fablist."Index Number" + ' :::';
                end;
            UNTIL fablist.Next = 0;
        end;
    end;

    procedure UpdateMedicalDetails(appno: Code[20]; anymedicalcondition: Boolean; medicalcondition: Text; vaccinated: Boolean; anyfoodallergy: Boolean; foodallergy: Text) updated: Boolean
    begin
        fabList.Reset;
        fabList.SetRange("Application No.", appno);
        if fabList.Find('-') then begin
            fabList."Medical Condition" := anymedicalcondition;
            fabList."Medical Condition Description" := medicalcondition;
            fabList."Childhood Vaccines" := vaccinated;
            fabList."Food Alergies" := anyfoodallergy;
            fabList."Food allergies Description" := foodallergy;
            fabList."Medical Form Updated" := True;
            fabList.Modify;
            updated := true;
        end;
    end;

    procedure MedicalDetailsUpdated(appno: Code[20]) updated: Boolean
    begin
        fabList.Reset;
        fabList.SetRange("Application No.", appno);
        if fabList.Find('-') then begin
            updated := fabList."Medical Form Updated";
        end;
    end;

    procedure AgreeToRulesAndRegulations(appno: Code[20]) msg: Boolean
    begin
        fabList.Reset;
        fabList.SetRange("Application No.", appno);
        if fabList.Find('-') then begin
            fabList."Rules and Regulations Agreed" := True;
            fabList.Modify;
            msg := true;
        end
    end;

    procedure AgreedToRulesAndRegulations(appno: Code[20]) updated: Boolean
    begin
        fabList.Reset;
        fabList.SetRange("Application No.", appno);
        if fabList.Find('-') then begin
            updated := fabList."Rules and Regulations Agreed";
        end;
    end;

    procedure MedicalFormRequired(appno: Code[20]) required: Boolean
    begin
        fabList.Reset;
        fabList.SetRange("Application No.", appno);
        if fabList.Find('-') then begin
            if (fablist."Programme Level" = fablist."Programme Level"::Undergraduate) or (fablist."Programme Level" = fablist."Programme Level"::Certificate) or (fablist."Programme Level" = fablist."Programme Level"::Diploma) then begin
                required := true;
            end;
        end;
    end;

    procedure SSApplication(index: code[20]; fname: text; mmname: text; lname: text; gender: option; dob: Date; nationality: text; county: text; ethinicity: Text; idNo: code[20]; passPort: code[20];
            idDoc: option; religion: text; maritalStat: Option;
            disability: option; disTyp: Option; knewThru: Text; formerStud: boolean; formerregno: text; prevedlvl: option; phoneNo: Text; altPhoneNo: text; email: Text;
            postAddress: Text; town: text; kinName: Text; kinPhoneNo: Text; kinEmail: Text; kinRel: Text; ecName: Text; ecPhoneNo: Text; ecEmail: Text; ecRel: Text; programlevel: option;
            intakecode: text; appliedprogram: text; secondprogram: Text; campus: code[20]; modeofstudy: text; highSchool: Text; hschF: Code[20]; hschT: Code[20]; meangrade: text; bachelorsProg: text; bachelorsInst: text; bachelorsYrFrom: Code[20]; bachelorsYrTo: Code[20]; bachelorsGrade: Text; mastersProg: text; mastersInst: text; mastersYrFrom: Code[20]; mastersYrTo: Code[20]; mastersGrade: Text; diplomaProg: text; diplomaInst: text; diplomaYrFrom: Code[20]; diplomaYrTo: Code[20]; certificateProg: text; certificateInst: text; certificateYrFrom: Code[20]; certificateYrTo: Code[20]; highschcertatt: Boolean; rsltslipatt: Boolean; transfercaseatt: Boolean; transferletteratt: Boolean;
            highschcertpath: Text; rsltslippath: Text; undegradcertpath: Text; mststrascrptspath: Text) Message: Text
    var
        programs: Record "ACA-Programme";
        colfrom: Date;
        colto: Date;
        appno: Text;
    begin
        CLEAR(appno);
        appno := NoSeriesMgt.GetNextNo('APPLIC-NO', 0D, TRUE);
        fablist.Init;
        fabList."Application No." := appno;
        fabList.firstName := fname;
        fablist."Other Names" := mmname;
        fablist.Surname := lname;
        fabList."Index Number" := index;
        fabList.Gender := gender;
        fabList."Date Of Birth" := dob;
        fabList.Nationality := Nationality;
        fabList.County := county;
        fablist.Ethicity := ethinicity;
        fabList."ID Number" := idNo;
        fabList."Passport Number" := passPort;
        fabList."Identification Documemnt" := idDoc;
        fabList.Religion := religion;
        /*fabList.Congregation := congregation;
        fabList.Diocese := diocese;
        fablist."Order/Instutute" := inst;
        fablist."Protestant Congregation" := protCongregation;*/
        fabList."Marital Status" := maritalStat;
        fabList.Disability := disability;
        fablist."Nature of Disability" := disTyp;
        fabList."Knew College Thru" := knewThru;
        fabList."Telephone No. 1" := phoneNo;
        fablist."Telephone No. 2" := altPhoneNo;
        fabList.Email := email;
        fabList."Address for Correspondence1" := postAddress;
        fablist."Address for Correspondence3" := town;
        fablist."Next of kin Name" := kinName;
        fabList."Next Of Kin Email" := kinEmail;
        fablist."Next of kin Mobile" := kinPhoneNo;
        fablist."Next of Kin R/Ship" := kinRel;
        fabList."Emergency Contact Name" := ecName;
        fablist."Emergency Contact Telephone" := ecPhoneNo;
        fabList."Emergency Email" := ecEmail;
        fabList."Emergency Relationship" := ecRel;
        fablist."Former School Code" := highSchool;
        fabList."High School From Year" := hschF;
        fabList."High School To Year" := hschT;
        fablist."Mean Grade Acquired" := meangrade;
        fablist."Country of Origin" := nationality;
        fablist."Settlement Type" := 'SSS';
        fabList."Application Date" := Today;
        fablist."Previous Education Level" := prevedlvl;
        //fabList."Admitted Semester" := startingsem;
        fablist."Intake Code" := intakecode;
        fablist."Bachelor Programme" := bachelorsProg;
        fablist."Bachelor Institution" := bachelorsInst;
        fablist."Bachelor Grade Attained" := bachelorsGrade;
        fablist."Bachelor Year of Adm" := bachelorsYrFrom;
        fablist."Bachelor Year of Comp" := bachelorsYrTo;
        fablist."Masters Programme" := mastersProg;
        fablist."Masters Institution" := mastersInst;
        fablist."Masters Grade Attained" := mastersGrade;
        fablist."Masters Year of Adm" := mastersYrFrom;
        fablist."Masters Year of Comp" := mastersYrTo;
        fablist."Certificate Programme" := certificateProg;
        fablist."Certificate Institution" := certificateInst;
        fablist."Certificate Year of Adm" := certificateYrFrom;
        fablist."Certificate Year of Comp" := certificateYrTo;
        fablist."Diploma Programme" := diplomaProg;
        fablist."Diploma Institution" := diplomaInst;
        fablist."Diploma Year of Adm" := diplomaYrFrom;
        fablist."Diploma Year of Comp" := diplomaYrTo;
        fabList."Programme Level" := programlevel;
        fablist."Mode of Study" := modeofstudy;
        fablist."First Degree Choice" := appliedprogram;
        fablist."Second Degree Choice" := secondprogram;
        fablist.Campus := campus;
        //fablist."First Choice Stage" := firststage;
        //fablist."First Choice Semester" := startingsem;
        fablist."High Sch. Cert attched" := highschcertatt;
        fablist."High Sch. Rslt Slip Attached" := rsltslipatt;
        /*fablist."Undergrad Cert attached" := undegradcertatt;
        fablist."Master Transcript attached" := mststrascrptsatt;*/
        fablist."Transfer Case" := transfercaseatt;
        fablist."Transfer Letter Attached" := transferletteratt;
        /*fabList."High School Certificate" := highschcertpath;
        fablist."High School Result slip" := rsltslippath;
        fablist."Under Graduate Certificate" := undegradcertpath;
        fablist."Masters Transcript" := mststrascrptspath;*/
        programs.RESET;
        programs.SETRANGE(programs.Code, appliedprogram);
        IF programs.FIND('-') THEN BEGIN
            fablist."Programme Faculty" := programs.Faculty;
            fablist.programName := programs.Description;
            fablist."Admitted Department" := programs."Department Code";
        end;
        fablist.Status := fablist.Status::"Pending Payment";
        fabList.Insert;
        Message := appno;//'Application submitted successfully.';
    end;

    procedure SubmitRequiredSubjects(applicNo: Code[20]; subject: Code[20]; score: Code[20]) submitted: Boolean
    var
        preq: Record "Prerequsite Requirements";
    begin
        preq.Init;
        preq."Application No" := applicNo;
        preq."Prerequisite Code" := subject;
        preq."Prerequisite Score" := score;
        preq.Insert;
        submitted := true;
    end;

    procedure SubmitProfQual(applicNo: Code[20]; qual: Text; inst: Text; dateFrom: Date; dateTo: Date) submitted: Boolean
    var
        profQual: Record "ACA-Applic Acad Qualification";
    begin
        profQual.Init;
        profQual."Application No." := applicNo;
        profQual."Where Obtained" := inst;
        profQual."From Date" := dateFrom;
        profQual."To Date" := dateTo;
        profQual.Insert;
        submitted := true;
    end;

    procedure SubmitWorkExperience(applicNo: Code[20]; inst: Text; position: Text; dateFrom: Date; dateTo: Date) submitted: Boolean
    var
        workExp: Record "ACA-Applic. Form Qualification";
    begin
        workExp.Init;
        workExp."Application No." := applicNo;
        workExp."Employer Name" := inst;
        workExp."Position(Role)" := position;
        workExp."From Date" := dateFrom;
        workExp."To Date" := dateTo;
        workExp.Insert;
        submitted := true;
    end;

    procedure SubmitAcademicReferee(applicNo: Code[20]; name: Text; inst: Text; position: Text; phoneNo: Code[20]) submitted: Boolean
    var
        acaRef: Record "ACA-Academic Referees";
    begin
        acaRef.Init;
        acaRef.ApplicationNo := applicNo;
        acaRef.Names := name;
        acaRef.Institution := inst;
        acaRef.Designition := position;
        acaRef."Mobile No" := phoneNo;
        acaRef.Insert;
        submitted := true;
    end;

    procedure FnApplicationAttachement(retNo: Code[50]; fileName: Text; attachment: BigText; tableId: Integer) return_value: Boolean
    var
        DocAttachment: Record "Document Attachment";
        DocAttachment1: Record "Document Attachment";
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
        tableFound: Boolean;
        ObjAppliRec: Record "ACA-Applic. Form Header";

    begin

        tableFound := false;
        return_value := false;
        if TableID = Database::"ACA-Applic. Form Header" then begin
            ObjAppliRec.RESET;
            ObjAppliRec.SETRANGE(ObjAppliRec."Application No.", retNo);
            if ObjAppliRec.FIND('-') then begin
                FromRecRef.GETTABLE(ObjAppliRec);
            end;
            tableFound := true;
        end;

        if tableFound = true then begin
            if FileName <> '' then begin
                DocAttachment1.Reset();
                DocAttachment1.SetRange("No.", retNo);
                DocAttachment1.SetRange("Table ID", FromRecRef.Number);
                DocAttachment1.SetRange("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(FileName)));
                if DocAttachment1.Find('-') then begin
                    DocAttachment1.DeleteAll;
                end;
                Clear(DocAttachment);
                DocAttachment.Init();
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("No.", retNo);
                DocAttachment.Validate("File Extension", FileManagement.GetExtension(FileName));
                DocAttachment.Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(FileName)));
                Bytes := Convert.FromBase64String(Attachment);
                MemoryStream := MemoryStream.MemoryStream(Bytes);
                DocAttachment."Document Reference ID".ImportStream(MemoryStream, '', FileName);
                DocAttachment.Insert(true);
                return_value := true;

            end else
                Error('No file to upload');
        end else
            Error('File not uploaded. No table filter found');
    end;

    procedure GenerateBS64AdmissionLetter(appNo: Code[20]; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
    var
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        recRef: RecordRef;
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        fablist.RESET;
        fablist.SETRANGE(fabList."Application No.", appNo);
        fablist.SETRANGE(fabList.Status, fablist.Status::"Provisional Admission");
        IF fablist.FIND('-') THEN BEGIN
            recRef.GetTable(fablist);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(51968, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END;
        EXIT(filename);
    end;

    procedure GetPrograms(progcode: Option) Message: Text
    begin
        programs.RESET;
        programs.SETRANGE(programs.Levels, progcode);
        //programs.SETRANGE(programs."Program Status", programs."Program Status"::Active);
        IF programs.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + programs.Code + ' ::' + programs.Description + ' :::';
            UNTIL programs.NEXT = 0;
        END;
    end;

    procedure GetAppliedLevelPrograms(appno: Code[50]) Message: Text
    begin
        fablist.reset;
        fablist.SetRange("Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            programs.RESET;
            //programs.SETRANGE(programs.Levels, fablist."Programme Level");
            //programs.SETRANGE(programs."Program Status", programs."Program Status"::Active);
            IF programs.FIND('-') THEN BEGIN
                REPEAT
                    Message := Message + programs.Code + ' ::' + programs.Description + ' :::';
                UNTIL programs.NEXT = 0;
            END;
        END;
    end;

    procedure GetProgramStages(progcode: Code[20]) Message: Text
    begin
        programstages.RESET;
        programstages.SETRANGE(programstages."Programme Code", progcode);
        IF programstages.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + programstages.Code + ' ::' + programstages.Description + ' :::';
            UNTIL programstages.NEXT = 0;
        END;
    end;

    procedure GetProgramSemesters(progcode: Text) Message: Text
    begin
        semesters.RESET;
        semesters.SETRANGE(semesters."Programme Code", progcode);
        IF semesters.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + semesters.Semester + ' :::';
            UNTIL semesters.NEXT = 0;
        END;
    end;

    procedure GetIntakes(prog: Code[20]) Message: Text
    begin
        programs.RESET;
        programs.SETRANGE(programs.Code, prog);
        IF programs.FIND('-') THEN BEGIN
            intakes.RESET;
            intakes.SetRange(Current, true);
            intakes.SetRange(Faculty, programs.Faculty);
            IF intakes.FIND('-') THEN BEGIN
                REPEAT
                    Message := Message + intakes.Code + ' ::' + intakes.Description + ' :::';
                UNTIL intakes.NEXT = 0;
            END;
        end;
    end;

    procedure GetNationalities() Message: Text
    begin
        centralsetup.RESET;
        centralsetup.SetCurrentKey(Description);
        centralsetup.SETRANGE(centralsetup.Category, centralsetup.Category::Nationality);
        IF centralsetup.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + centralsetup."Title Code" + ' ::' + centralsetup.Description + ' :::';
            UNTIL centralsetup.NEXT = 0;
        END;
    end;

    procedure GetCountryCode(titlecode: Code[20]) Message: Text
    begin
        centralsetup.RESET;
        centralsetup.SetCurrentKey(Description);
        centralsetup.SETRANGE(centralsetup.Category, centralsetup.Category::Nationality);
        centralsetup.SETRANGE(centralsetup."Title Code", titlecode);
        IF centralsetup.FIND('-') THEN BEGIN
            REPEAT
                Message := centralsetup."Country Code";
            UNTIL centralsetup.NEXT = 0;
        END;
    end;

    procedure GetCountries() Message: Text
    begin
        countries.RESET;
        countries.SetCurrentKey(Name);
        IF countries.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + countries.Code + ' ::' + countries.Name + ' :::';
            UNTIL countries.NEXT = 0;
        END;
    end;

    procedure GetCounties() Message: Text
    begin
        /*counties.RESET;
        counties.SetCurrentKey(Name);
        IF counties.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + counties.Code + ' ::' + counties.Name + ' :::';
            UNTIL counties.NEXT = 0;
        END;*/
        centralsetup.RESET;
        centralsetup.SETRANGE(centralsetup.Category, centralsetup.Category::Counties);
        IF centralsetup.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + centralsetup."Title Code" + ' ::' + centralsetup.Description + ' :::';
            UNTIL centralsetup.NEXT = 0;
        END;
    end;

    procedure GetDenomination() Message: Text
    begin
        centralsetup.RESET;
        centralsetup.SETRANGE(centralsetup.Category, centralsetup.Category::Denominations);
        IF centralsetup.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + centralsetup."Title Code" + ' ::' + centralsetup.Description + ' :::';
            UNTIL centralsetup.NEXT = 0;
        END;
    end;

    procedure GetRelationships() Message: Text
    begin
        relationships.RESET;
        IF relationships.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + relationships.Code + ' ::' + relationships.Description + ' :::';
            UNTIL relationships.NEXT = 0;
        END;
    end;

    procedure GetCampus() Message: Text
    begin
        campus.RESET;
        campus.SetRange("Dimension Code", 'CAMPUS');
        campus.SetRange(Blocked, false);
        campus.SetCurrentKey(Name);
        IF campus.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + campus.Code + ' ::' + campus.Name + ' :::';
            UNTIL campus.NEXT = 0;
        END;
    end;

    procedure GetModeofStudy() Message: Text
    begin
        studymodes.RESET;
        IF studymodes.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + studymodes.Code + ' ::' + studymodes.Description + ' :::';
            UNTIL studymodes.NEXT = 0;
        END;
    end;

    procedure GetEthnicity() Message: Text
    begin
        centralsetup.RESET;
        centralsetup.SETRANGE(centralsetup.Category, centralsetup.Category::Ethnicity);
        IF centralsetup.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + centralsetup."Title Code" + ' ::' + centralsetup.Description + ' :::';
            UNTIL centralsetup.NEXT = 0;
        END;
    end;

    procedure GetMarketingStrategies() Message: Text
    begin
        marketingstrategies.RESET;
        marketingstrategies.SetCurrentKey(Description);
        IF marketingstrategies.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + marketingstrategies.Code + '::' + marketingstrategies.Description + ' :::';
            UNTIL marketingstrategies.NEXT = 0;
        END;
    end;

    procedure GetReligions() Message: Text
    begin
        centralsetup.RESET;
        centralsetup.SETRANGE(centralsetup.Category, centralsetup.Category::Religions);
        IF centralsetup.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + centralsetup."Title Code" + ' :::';
            UNTIL centralsetup.NEXT = 0;
        END;
    end;

    procedure GenerateAdmnLetter(index: Text; filenameFromApp: Text) filename: Text
    var
        admlt: Report "ADM Admission Letter";
    begin
        filename := FILESPATH_APP + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        //MESSAGE('OK');
        fablist.RESET;
        fablist.SETRANGE("Index Number", index);
        IF fablist.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(51968, filename, fablist);
        END;
        EXIT(filename);
    end;

    procedure GetAdmnNo(IndexNo: Code[20]) admnNo: Text
    begin
        fablist.RESET;
        fablist.SETRANGE("Index Number", IndexNo);
        IF fablist.FIND('-') THEN BEGIN
            admnNo := fablist."Admission No";
        END;
    end;

    procedure GetAppNo(Index: Code[20]) appno: Text
    begin
        fablist.RESET;
        fablist.SETRANGE("Index Number", index);
        IF fablist.FIND('-') THEN BEGIN
            appno := fablist."Application No.";
        END;
    end;

    procedure SavePesaFlowInvoice(refno: Code[20]; invoiceno: Code[20]; custno: Code[20]; custname: Text[100]; invoiceamt: Decimal; serviceid: Code[20]; desc: Text[50]; token: Text[100]; link: Text[150]) inserted: Boolean
    var
        PesaFlowInvoices: Record "PesaFlow Invoices";
    begin
        PesaFlowInvoices.RESET;
        PesaFlowInvoices.SETRANGE(BillRefNo, refno);
        IF NOT PesaFlowInvoices.FIND('-') THEN BEGIN
            PesaFlowInvoices.INIT;
            PesaFlowInvoices.BillRefNo := refno;
            PesaFlowInvoices.CustomerRefNo := custno;
            PesaFlowInvoices.InvoiceNo := invoiceno;
            PesaFlowInvoices.CustomerName := custname;
            PesaFlowInvoices.InvoiceAmount := invoiceamt;
            PesaFlowInvoices.ServiceID := serviceid;
            PesaFlowInvoices.Description := desc;
            PesaFlowInvoices.TokenHash := token;
            PesaFlowInvoices.InvoiceLink := link;
            PesaFlowInvoices.INSERT;
            inserted := TRUE;
        END;
    end;

    procedure GenerateBillRefNo() msg: Text
    begin
        msg := NoSeriesMgt.GetNextNo('PSINV', 0D, true);
    end;

    procedure GetApplicationFee(appno: Code[20]) appfee: Decimal
    begin
        fablist.reset;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fabList.FIND('-') THEN begin
            Programme.Reset;
            Programme.SetRange(Programme.Code, fablist."First Degree Choice");
            IF Programme.FIND('-') THEN begin
                appfee := ROUND(Programme.ApplicationFee, 0.01, '>');
            end;
        end;
    end;

    procedure GetHostelRoomSpaces(hostelNo: Code[20]) msg: Text
    begin
        BlockRooms.RESET;
        BlockRooms.SETRANGE("Hostel Code", hostelNo);
        IF BlockRooms.FIND('-') THEN BEGIN
            RoomSpaces.RESET;
            RoomSpaces.SETRANGE("Hostel Code", BlockRooms."Hostel Code");
            RoomSpaces.SETRANGE(Booked, FALSE);
            RoomSpaces.SETRANGE(Status, RoomSpaces.Status::Vaccant);
            IF RoomSpaces.FIND('-') THEN BEGIN
                REPEAT
                    StudentHostelRooms.RESET;
                    StudentHostelRooms.SETRANGE("Space No", RoomSpaces."Space Code");
                    StudentHostelRooms.SETRANGE(Semester, GetCurrentSemester());
                    IF NOT StudentHostelRooms.FIND('-') THEN BEGIN
                        accommodationBooking.Reset;
                        accommodationBooking.SetRange(Semester, GetCurrentSemester());
                        accommodationBooking.SetRange(SpaceNo, RoomSpaces."Space Code");
                        if not accommodationBooking.find('-') then begin
                            msg += RoomSpaces."Space Code" + ' ::' + RoomSpaces."Room Code" + ' ::' + FORMAT(BlockRooms."JAB Fees") + ' ::' + FORMAT(BlockRooms."SSP Fees") + ' ::' + FORMAT(BlockRooms."Room Cost") + ' :::';
                        end;
                    END;
                UNTIL RoomSpaces.NEXT = 0;
            END;
        END
    end;

    procedure GetHostels(gender: option) msg: Text
    begin
        HostelCard.RESET;
        HostelCard.SETRANGE(HostelCard.Gender, gender);
        HostelCard.SETRANGE(HostelCard."View Online", TRUE);
        IF HostelCard.FIND('-') THEN BEGIN
            REPEAT
                msg += HostelCard."Asset No" + ' ::' + HostelCard.Description + ' :::';
            UNTIL HostelCard.NEXT = 0;
        END
    end;

    procedure SubmitStudentRequest(stdNo: Code[20]; type: option; reason: option; otherreason: text) submitted: Boolean
    begin
        DefferedStudents.Reset;
        DefferedStudents.SetRange(studentNo, stdNo);
        DefferedStudents.SetRange(Semeter, GetCurrentSemester());
        DefferedStudents.SetRange("Request Type", type);
        if not DefferedStudents.Find('-') then begin
            DefferedStudents.Init;
            DefferedStudents.StudentNo := stdNo;
            DefferedStudents.Validate(StudentNo);
            DefferedStudents.Validate(Programme);
            DefferedStudents.Semeter := GetCurrentSemester();
            DefferedStudents.Validate(Semeter);
            DefferedStudents."Request Type" := type;
            DefferedStudents."Reason for Calling off" := reason;
            DefferedStudents.deffermentReason := otherreason;
            DefferedStudents.Insert;
            submitted := true;
        end else begin
            error('You have already submitted this request for the current semester');
        end;
    end;

    procedure GetMyRequests(stdNo: Code[20]) msg: Text
    begin
        DefferedStudents.Reset;
        DefferedStudents.SetRange(studentNo, stdNo);
        if DefferedStudents.Find('-') then begin
            repeat
                msg += Format(DefferedStudents."Request Type") + '::' + Format(DefferedStudents."Reason for Calling off") + '::' + Format(DefferedStudents.Status) + ':::';
            until DefferedStudents.Next = 0;
        end
    end;
}

