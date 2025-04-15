#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 61106 webportals
{

    trigger OnRun()
    var
        Cust: Record Customer;
        RptFileName: Text;
        MailBody: Text;
    begin
        MarkKUCCPSDetailsUpdated('A100/00111G/24');
    end;

    var
        FILESPATH: label 'C:\inetpub\wwwroot\Downloads\';
        ProgramUnits: Record "ACA-Semester";
        "Employee Card": Record "HRM-Employee C";
        "HR Leave Application": Record "HRM-Leave Requisition";
        "Supervisor Card": Record "User Setup";
        HRLeaveTypes: Record "HRM-Leave Types";
        ApprovalEntry: Record "Approval Entry";
        ApprovalEntry_2: Record "Approval Entry";
        LeaveT: Record "HRM-Leave Requisition";
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextLeaveApplicationNo: Code[20];
        EmployeeUserId: Text;
        SupervisorId: Text;
        PeriodTrans: Record "PRL-Period Transactions";
        "Supervisor ID": Text;
        HRLeave: Record "HRM-Leave Requisition";
        BaseCalendar: Record "Base Calendar Change";
        test: Boolean;
        testDate: Date;
        GeneralOptions: Record "HRM-Setup";
        TransportRequisition: Record "FLT-Transport Requisition";
        HRTravellingStaff: Record "FLT-Travel Requisition Staff";
        ltype: Record "HRM-Leave Types";
        dates: Record Date;
        LeaveTypes: Record "HRM-Leave Types";
        varDaysApplied: Decimal;
        TransportRequisition_2: Record "FLT-Transport Requisition";
        SalaryCard: Record "PRL-Salary Card";
        Customer: Record Customer;
        "Fee By Stage": Record "ACA-Fee By Stage";
        CourseRegistration: Record "ACA-Course Registration";
        MealBookingHeader: Record "CAT-Meal Booking Header";
        MealBookingLines: Record "CAT-Meal Booking Lines";
        ApprovalMgt: Codeunit "Approval Workflows V1";
        AppMgt: Codeunit "Approval Workflows V1";
        // ApprovalSetup: Record UnknownRecord452;
        Text004: label 'Approval Setup not found.';
        FILESPATH_S: label 'C:\inetpub\wwwroot\Downloads\';
        RelieverName: Text;
        LeaveLE: Record "HRM-Leave Ledger";
        ExamResults: Record "ACA-Exam Results";
        showmessage: Boolean;
        ManualCancel: Boolean;
        State: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        tableNo: Integer;
        ApproverComments: Record "Approval Comment Line";
        objPeriod: Record "PRL-Payroll Periods";
        P9: Record "PRL-Employee P9 Info";
        StoreRequisition: Record "PROC-Store Requistion Header";
        ImprestRequisition: Record "FIN-Imprest Header";
        CourseReg: Record "ACA-Course Registration";
        GenSetup: Record "ACA-General Set-Up";
        NextStoreqNo: Code[10];
        MealRequisition: Record "CAT-Meal Booking Header";
        NextMtoreqNo: Code[10];
        MealLinesCreate: Record "CAT-Meal Booking Lines";

        VenueRequisition: Record "Gen-Venue Booking";
        Programmezz: Record "ACA-Programme";
        Receiptz: Record "ACA-Receipt";
        StudentCard: Record Customer;
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        CurrentSem: Record "ACA-Semesters";
        StudCharges: Record "ACA-Std Charges";
        AcademicYr: Record "ACA-Academic Year";
        UnitSubjects: Record "ACA-Units/Subjects";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        StudentUnits: Record "ACA-Student Units";
        StudentUnitBaskets: Record "ACA-Student Units Baskets";
        EmployeeCard: Record "HRM-Employee C";
        LedgerEntries: Record "Detailed Cust. Ledg. Entry";
        Stages: Record "ACA-Programme Stages";
        PRLEmployeeP9Info: Record "PRL-Employee P9 Info";
        LecEvaluation: Record "ACA-Lecturers Evaluation";
        VenueBooking: Record "Gen-Venue Booking";
        HelpDesk: Record "HelpDesk Header";
        VoteElection: Record "ELECT Election Result";
        KUCCPSRaw: Record "KUCCPS Imports";
        AdmissionFormHeader: Record "ACA-Adm. Form Header";
        FILESPATH_A: label 'C:\inetpub\wwwroot\Downloads\';
        OnlineUsersz: Record "OnlineUsers";
        AplicFormHeader: Record "ACA-Applic. Form Header";
        ProgEntrySubjects: Record "ACA-Programme Entry Subjects";
        ApplicFormAcademic: Record "ACA-Applic. Form Academic";
        Intake: Record "ACA-Intake";
        ProgramSem: Record "ACA-Programme Semesters";
        filename2: Text[250];
        Dimensions: Record "Dimension";
        EvaluationQuiz: Record "ACA-Evaluation Questions";
        AdmissionFormHeader1: Record "ACA-Applic. Form Header";
        ImportsBuffer: Record "ACA-Imp. Receipts Buffer";
        Admissions: Record "ACA-Adm. Form Header";
        ApplicationSubject: Record "ACA-Applic. Form Academic";
        AdmissionSubject: Record "ACA-Adm. Form Academic";
        LineNo: Integer;
        MedicalCondition: Record "ACA-Medical Condition";
        AdmissionMedical: Record "ACA-Adm. Form Medical Form";
        AdmissionFamily: Record "ACA-Adm. Form Family Medical";
        Immunization: Record "ACA-Immunization";
        AdmissionImmunization: Record "ACA-Adm. Form Immunization";
        AdminKin: Record "ACA-Adm. Form Next of Kin";
        StudentKin: Record "ACA-Student Kin";
        StudentGuardian: Record "ACA-Student Sponsors Details";
        Referrralll: Record "HMS-Referral Header";
        coreg: Record "ACA-Course Registration";
        ElectionHeader: Record "ELECT-Elections Header";
        BallotBuffer: Record "ELECT-Ballot Register Buffer";
        VoteReg: Record "ELECT-Voter Register";
        NextJobapplicationNo: Code[20];
        ClearanceHeader: Record "ACA-Clearance Header";
        userSetup10: Record "User Setup";
        HostelLedger: Record "ACA-Hostel Ledger";
        HostelRooms: Record "ACA-Students Hostel Rooms";
        HostelCard: Record "ACA-Hostel Card";
        HostelBlockRooms: Record "ACA-Hostel Block Rooms";
        RoomSpaces: Record "ACA-Room Spaces";
        HrEmployeeC: Record "HRM-Employee C";
        ProgrammeSemesters: Record "ACA-Programme Semesters";
        RecAccountusers: Record "Online Recruitment users";
        ApplicantQualifications: Record "HRM-Applicant Qualifications";
        JobApplications: Record "HRM-Job Applications (B)";
        ProgStages: Record "ACA-Programme Stages";
        ACASetupRec: Integer;
        Counties: Text[1000];
        PurchSetup: Record "Purchases & Payables Setup";
        tblBidder: Record "Tender Applicants Registration";
        SupUnits: Record "Aca-Special Exams Details";
        DocSetup: Record "ACA-New Stud. Doc. Setup";
        StudentDocs: Record "ACA-New Stud. Documents";
        GradesTable: Record "ACA-Applic. Setup Grade";
        PostGradHandler: Codeunit "PostGraduate Handler";
        acacentalsetup: Record "ACA-Academics Central Setups";
        fablist: Record "ACA-Applic. Form Header";
        programs: Record "ACA-Programme";
        programstages: Record "ACA-Programme Stages";
        studymodes: Record "ACA-Student Types";
        offeredunits: Record "ACA-Units Offered";
        HRMEmployeeD: Record "HRM-Employee C";
        lecturers: Record "ACA-Lecturers Units";
        lecturehalls: Record "ACA-Lecturer Halls Setup";
        days: Record "TT-Days";
        timeslots: Record "TT-Daily Lessons";
        AttendanceHeader: Record "Class Attendance Header";
        AttendanceDetails: Record "Class Attendance Details";
        ImprestSurrHeader: Record "FIN-Imprest Surr. Header";
        ImprestSurrDetails: Record "FIN-Imprest Surrender Details";
        ImprestRequisitionLines: Record "FIN-Imprest Lines";
        ApprovalMgmt: Codeunit "Init Code";
        EmpReq: Record "HRM-Employee Requisitions";
        jobPosts: Record "HRM-Jobs";
        GLsetup: Record "General Ledger Setup";

        PurchaseRN: Record "Purchase Header";
        PurchaseLines: Record "Purchase Line";
        Items: Record Item;
        GLAccounts: Record "G/L Account";
        StoreReqLines: Record "PROC-Store Requistion Lines";

    procedure CreateStudentDefermentRequest(StudentNo: Code[20]; StartDate: Date; EndDate: Date; AcademicYear: Code[20]; Semester: Code[20]; ProgrammeCode: Code[20]; Stage: Code[20]; Reason: Text[250]) Result: Text
    var
        StudentDefWithdrawalPortal: Codeunit "Student Def_Withdrawal Portal";
    begin
        Result := StudentDefWithdrawalPortal.CreateDefermentWithdrawalRequest(StudentNo, 0, StartDate, EndDate, AcademicYear, Semester, ProgrammeCode, Stage, Reason);
    end;

    procedure CreateStudentWithdrawalRequest(StudentNo: Code[20]; StartDate: Date; AcademicYear: Code[20]; Semester: Code[20]; ProgrammeCode: Code[20]; Stage: Code[20]; Reason: Text[250]) Result: Text
    var
        StudentDefWithdrawalPortal: Codeunit "Student Def_Withdrawal Portal";
    begin
        Result := StudentDefWithdrawalPortal.CreateDefermentWithdrawalRequest(StudentNo, 1, StartDate, 0D, AcademicYear, Semester, ProgrammeCode, Stage, Reason);
    end;

    procedure GetStudentDefermentWithdrawalRequests(StudentNo: Code[20]) Result: Text
    var
        StudentDefWithdrawalPortal: Codeunit "Student Def_Withdrawal Portal";
    begin
        Result := StudentDefWithdrawalPortal.GetStudentDefermentWithdrawalRequests(StudentNo);
    end;

    procedure GetDefermentWithdrawalRequestDetails(RequestNo: Code[20]) Result: Text
    var
        StudentDefWithdrawalPortal: Codeunit "Student Def_Withdrawal Portal";
    begin
        Result := StudentDefWithdrawalPortal.GetDefermentWithdrawalRequestDetails(RequestNo);
    end;

    procedure CancelDefermentWithdrawalRequest(RequestNo: Code[20]; StudentNo: Code[20]) Result: Text
    var
        StudentDefWithdrawalPortal: Codeunit "Student Def_Withdrawal Portal";
    begin
        Result := StudentDefWithdrawalPortal.CancelDefermentWithdrawalRequest(RequestNo, StudentNo);
    end;

    procedure GetCurrentAcademicYearAndSemester() Result: Text
    var
        StudentDefWithdrawalPortal: Codeunit "Student Def_Withdrawal Portal";
    begin
        Result := StudentDefWithdrawalPortal.GetCurrentAcademicYearAndSemester();
    end;

    procedure GetStudentProgrammeAndStage(StudentNo: Code[20]) Result: Text
    var
        StudentDefWithdrawalPortal: Codeunit "Student Def_Withdrawal Portal";
    begin
        Result := StudentDefWithdrawalPortal.GetStudentProgrammeAndStage(StudentNo);
    end;

    procedure HasPendingDefermentWithdrawalRequests(StudentNo: Code[20]) Result: Boolean
    var
        StudentDefWithdrawalPortal: Codeunit "Student Def_Withdrawal Portal";
    begin
        Result := StudentDefWithdrawalPortal.HasPendingDefermentWithdrawalRequests(StudentNo);
    end;

    procedure GetStudentStatusInfo(StudentNo: Code[20]) Result: Text
    var
        StudentDefWithdrawalPortal: Codeunit "Student Def_Withdrawal Portal";
    begin
        Result := StudentDefWithdrawalPortal.GetStudentStatusInfo(StudentNo);
    end;

    procedure CreateStudentLeaveRequest(StudentNo: Code[20]; LeaveType: Option Regular,Compassionate; StartDate: Date; NoOfDays: Decimal; Reason: Text[250]) Result: Text
    var
        StudentLeavePortal: Codeunit "Student Leave Portal";
    begin
        Result := StudentLeavePortal.CreateStudentLeaveRequest(StudentNo, LeaveType, StartDate, NoOfDays, Reason);
    end;

    procedure GetStudentLeaveRequests(StudentNo: Code[20]) Result: Text
    var
        StudentLeavePortal: Codeunit "Student Leave Portal";
    begin
        Result := StudentLeavePortal.GetStudentLeaveRequests(StudentNo);
    end;

    procedure GetLeaveRequestDetails(LeaveNo: Code[20]) Result: Text
    var
        StudentLeavePortal: Codeunit "Student Leave Portal";
    begin
        Result := StudentLeavePortal.GetLeaveRequestDetails(LeaveNo);
    end;

    procedure CancelLeaveRequest(LeaveNo: Code[20]; StudentNo: Code[20]) Result: Text
    var
        StudentLeavePortal: Codeunit "Student Leave Portal";
    begin
        Result := StudentLeavePortal.CancelLeaveRequest(LeaveNo, StudentNo);
    end;

    procedure HasPendingLeaveRequests(StudentNo: Code[20]) Result: Boolean
    var
        StudentLeavePortal: Codeunit "Student Leave Portal";
    begin
        Result := StudentLeavePortal.HasPendingLeaveRequests(StudentNo);
    end;

    procedure GetAssignedSupervisor(stdNo: code[25]) Result: Text;
    var
        Cust: Record "Customer";
        Employee: record "HRM-Employee C";
        SupervisorApplic: record "Postgrad Supervisor Applic.";
    begin
        Cust.GET(stdNo);
        if cust."Supervisor No." = '' then begin
            SupervisorApplic.Reset();
            SupervisorApplic.SetRange("Student No.", stdNo);
            SupervisorApplic.SetRange(Status, SupervisorApplic.Status::Approved);
            if SupervisorApplic.findlast then begin
                cust."Supervisor No." := SupervisorApplic."Assigned Supervisor Code";
                Cust.Modify();
                Commit();
            end
        end;
        Employee.Get(Cust."Supervisor No.");
        Result := Employee.FullName() + ' ::' + Employee."Company E-Mail" + ' ::' + Employee."Phone Number";
    end;

    procedure SubmitPostgradPaper(stdNo: code[25]; SubmissionType: option "concept Paper",Thesis; Paper: text) Result: Boolean
    var
        Cust: Record "Customer";
        StudentSubmission: Record "Student Submission";
    begin
        StudentSubmission.init;
        StudentSubmission."Student No." := stdNo;
        StudentSubmission.validate("Student No.");
        StudentSubmission."Submission Type" := SubmissionType;
        StudentSubmission."Submission Date" := WorkDate();
        if StudentSubmission.insert(true) then begin
            UploadBase64FileToDocumentAttachment(Paper, stdNo + ' ' + Format(SubmissionType) + '.pdf', Database::"Student Submission", StudentSubmission."No.", 0);
            exit(true);
        end else begin
            exit(false);
        end
    end;

    Procedure GetSubmittedPostGradPaper(stdNo: code[25]; SubmissionType: option "concept Paper",Thesis) Result: Text
    var
        StudentSubmission: Record "Student Submission";
    begin
        StudentSubmission.Reset();
        StudentSubmission.SetRange("Student No.", stdNo);
        StudentSubmission.setrange("Submission Type", SubmissionType);
        if StudentSubmission.FindSet then begin
            repeat
                Result += StudentSubmission."No." + ' ::' + formaT(StudentSubmission.Status) + ' ::' + format(StudentSubmission."Submission Date");
            until StudentSubmission.Next = 0;
        end;
    end;

    Procedure GetPostgradPaperAttachment(DocNo: code[25]): Text
    var

    begin
        exit(GetAttachedDocument(DocNo, Database::"Student Submission", 0));
    end;

    Procedure GetAttachedDocument(DocNo: code[25]; TableId: Integer; LineNo: integer) Attach: Text
    var
        DocAttach: record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
        OutStream: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        DocAttach.Reset();
        DocAttach.SetRange("Table ID", TableId);
        DocAttach.SetRange("No.", DocNo);
        DocAttach.SetRange("Line No.", LineNo);

        if DocAttach.FindFirst() then begin
            TempBlob.CreateOutStream(OutStream);
            DocAttach."Document Reference ID".ExportStream(OutStream);
            TempBlob.CreateInStream(InStream);
            Attach := Base64Convert.ToBase64(InStream);
        end;

        exit(Attach);
    end;

    procedure DownloadPostgradTrackingForm(DocNo: code[25]): Text
    var
        SupervisionTracking: Record "Supervision Tracking";
        Recref: RecordRef;
    begin
        SupervisionTracking.GET(DocNo);
        Recref.GetTable(SupervisionTracking);
        fnGetReportBase64(report::"Postgrad Supervision Form", '', Recref);
    end;

    procedure fnGetReportBase64(reportId: Integer; parameters: text; recRef: RecordRef): Text
    var
        cuTemplob: Codeunit "Temp Blob";
        BcInstream: InStream;
        bcOutStream: OutStream;
        cuBase64: Codeunit "Base64 Convert";
        FileName: Text;
        rpVariant: RecordId;
    begin
        // grpvesel.Reset();
        // grpvesel.SetRange("No.", 'INSG012');
        // grpvesel.SetRange("File Reference No.", 'REF/004/2024');
        // if grpvesel.Find('-') then begin
        //     Clear(recRef);
        //     recRef.GetTable(grpvesel);
        // end;
        cuTemplob.CreateOutStream(BcOutStream);
        Report.SaveAs(reportId, Parameters, ReportFormat::Pdf, bcOutStream, RecRef);
        cuTemplob.CreateInStream(BcInstream);
        exit(cuBase64.ToBase64(BcInstream));
    end;

    procedure GetSupervisionTrackingAttachment(DocNo: code[25]): Text
    var

    begin
        exit(GetAttachedDocument(DocNo, Database::"Supervision Tracking", 0));
    end;

    //Create new Supervision Tracking
    procedure CreateSupervisionTracking(stdNo: code[25]; DateMetWithSupervisor: Date; StageofWork: Text; NatureofFeedback: Text; Remarks: Text) Result: Text
    var
        SupervisionTracking: Record "Supervision Tracking";
        Cust: Record "Customer";
    begin
        Cust.GET(stdNo);
        SupervisionTracking.Init();
        SupervisionTracking."Student No." := stdNo;
        SupervisionTracking.Validate("Student No.");
        SupervisionTracking."Supervisor Code" := Cust."Supervisor No.";
        SupervisionTracking.Validate("Supervisor Code");
        SupervisionTracking."Date Work Submitted" := WorkDate();
        SupervisionTracking."Date Met With Supervisor" := DateMetWithSupervisor;
        SupervisionTracking."Stage of Work" := StageofWork;
        SupervisionTracking."Nature of Feedback" := NatureofFeedback;
        SupervisionTracking.Remarks := Remarks;
        SupervisionTracking.Insert(true);
        Result := SupervisionTracking."Document No.";
    end;

    //Get Supervision Tracking
    procedure GetSupervisionTracking(stdNo: code[25]) Result: Text
    var
        SupervisionTracking: Record "Supervision Tracking";
    begin
        SupervisionTracking.Reset();
        SupervisionTracking.SetRange("Student No.", stdNo);
        if SupervisionTracking.FindSet() then begin
            repeat
                Result += SupervisionTracking."Document No." + ' ::' + format(SupervisionTracking."Date Work Submitted") + ' ::' + SupervisionTracking."Stage of Work" + ' ::' + SupervisionTracking."Nature of Feedback" + ' ::' + SupervisionTracking.Remarks + ' :::';
            until SupervisionTracking.Next() = 0;
        end;
    end;

    //Supervisor

    procedure isStudentPostgraduate(StdNo: code[25]): Boolean
    var
        CourseReg: record "ACA-Course Registration";
    begin
        CourseReg.Reset;
        CourseReg.SetRange("Student No.", StdNo);
        CourseReg.SetAutoCalcFields("Is Postgraduate");
        CourseReg.SetRange("Is Postgraduate", true);
        if CourseReg.FindFirst then
            exit(True)
        else
            exit(False);
    end;

    procedure GetSpecialExamReasons() Msg: Text
    var
        SpecialExmResons: Record "ACA-Special Exams Reason";
    begin
        SpecialExmResons.RESET;
        if SpecialExmResons.FIND('-') then begin
            repeat
                Msg += SpecialExmResons."Reason Code" + ' ::' + SpecialExmResons.Description + ' :::';
            until SpecialExmResons.NEXT = 0;
        end;
    end;

    procedure GetUnitsForSpecialApplication(stdNo: code[25]) Msg: Text
    var
        StudentUnits: Record "ACA-Student Units";
        Sems: Record "ACA-Semesters";
    begin
        StudentUnits.RESET;
        Sems.RESET;
        Sems.SETRANGE("Current Semester", false);
        if Sems.FindSet() then begin
            repeat
                StudentUnits.RESET;
                StudentUnits.SETRANGE("Semester", Sems.Code);
                StudentUnits.SETRANGE("Student No.", stdNo);
                StudentUnits.SetAutoCalcFields("Exam Marks");
                StudentUnits.SetRange("Exam Marks", 0);
                if StudentUnits.FIND('-') then begin
                    repeat
                        Msg += StudentUnits."Unit" + ' ::' + StudentUnits.Description + ' :::';
                    until StudentUnits.NEXT = 0;
                end;
            until Sems.NEXT = 0;
        end;
    end;

    procedure getCurrentSemester() Msg: Text
    var
        Sems: Record "ACA-Semesters";
    begin
        Sems.RESET;
        Sems.SETRANGE("Current Semester", true);
        if Sems.FIND('-') then begin
            Msg := Sems.Code;
        end;
    end;

    procedure SubmitSpecialExamApplication(stdNo: code[25]; unitCode: Code[20]; reasonCode: Code[20]) Msg: Code[25]
    var
        SpecialExams: Record "ACA-Special Exams Details";
        Sems: Record "ACA-Semesters";
        StudentUnits: Record "ACA-Student Units";
        ApprovalMgmt: Codeunit "Approval Workflows V1";
        variant: Variant;
    begin
        SpecialExams.INIT;
        SpecialExams."Student No." := stdNo;
        SpecialExams.Validate("Student No.");
        SpecialExams."Unit Code" := unitCode;
        SpecialExams.Validate("Unit Code");
        SpecialExams."Created Date/Time" := CurrentDateTime;
        SpecialExams."Special Exam Reason" := reasonCode;
        SpecialExams.Validate("Special Exam Reason");
        SpecialExams."Status" := SpecialExams."Status"::New;
        SpecialExams.Category := SpecialExams.Category::Special;
        SpecialExams."Document No." := '';
        if SpecialExams.INSERT(true) then begin
            variant := SpecialExams;
            if ApprovalMgmt.CheckApprovalsWorkflowEnabled(variant) then
                ApprovalMgmt.OnSendDocForApproval(variant);
            exit(SpecialExams."Document No.")
        end
        else
            exit('');
    end;



    procedure GetAppliedSpecialUnits(studentNo: Code[20]) msg: Text
    var
        SpecialExams: Record "ACA-Special Exams Details";
    begin
        SpecialExams.RESET;
        SpecialExams.SETRANGE("Student No.", studentNo);
        SpecialExams.SETRANGE(Category, SpecialExams.Category::Special);
        if SpecialExams.FIND('-') then begin
            repeat
                Msg += SpecialExams."Unit Code" + ' ::' + SpecialExams."Unit Description" + ' ::' + Format(SpecialExams.Status) + ' :::';
            until SpecialExams.NEXT = 0;
        end;
    end;

    procedure createMedicalClaim(staffNo: Code[25]; claimType: Option inpatient,Outpatient; DocumentRef: Code[25]; SchemeNo: Code[25]; PatientType: Option Self,Depedant; Dependant: Text[100]; Facility: code[25]; DateOfService: Date; Amount: Decimal; Currency: Code[20]; Comments: Text): Code[25]
    var
        MedClaim: Record "HRM-Medical Claims";
    begin
        MedClaim.INIT;
        MedClaim."Claim No" := '';
        MedClaim."Member No" := staffNo;
        medclaim.validate("Member No");
        MedClaim."Claim Type" := claimType;
        MedClaim."Document Ref" := DocumentRef;
        MedClaim."Scheme No" := SchemeNo;
        MedClaim.Validate("Scheme No");
        MedClaim."Patient Type" := PatientType;
        MedClaim.Dependants := Dependant;
        MedClaim.Validate("Dependants");
        MedClaim."Facility Attended" := Facility;
        medclaim.validate("Facility Attended");
        MedClaim."Date of Service" := DateOfService;
        MedClaim."Claim Currency Code" := Currency;
        MedClaim."Claim Amount" := Amount;
        MedClaim.Validate("Claim Amount");
        MedClaim.Comments := Comments;
        if MedClaim.INSERT(true) then begin
            if (SendMedicalClaimForApproval(MedClaim."Claim No")) then
                exit(MedClaim."Claim No");
        end else
            exit('');
    end;


    procedure getMedicalSchemes() Msg: Text
    var
        MedSchemes: Record "HRM-Medical Schemes";
    begin
        MedSchemes.RESET;
        if MedSchemes.FIND('-') then begin
            repeat
                Msg += MedSchemes."Scheme No" + ' ::' + MedSchemes."Scheme Name" + ' :::';
            until MedSchemes.NEXT = 0;
        end;
    end;

    procedure getMedicalFacilities() Msg: Text
    var
        MedFacilities: Record "HRM-Medical Facility";
    begin
        MedFacilities.RESET;
        if MedFacilities.FIND('-') then begin
            repeat
                Msg += MedFacilities."Code" + ' ::' + MedFacilities."Facility Name" + ' :::';
            until MedFacilities.NEXT = 0;
        end;
    end;

    procedure getMedicalClaims(staffNo: Code[25]) Msg: Text
    var
        MedClaims: Record "HRM-Medical Claims";
    begin
        MedClaims.RESET;
        MedClaims.SETRANGE("Member No", staffNo);
        if MedClaims.FIND('-') then begin
            repeat
                //display all details
                Msg += MedClaims."Claim No" + ' ::' + Format(MedClaims."Scheme Name") + ' ::' + Format(MedClaims."Claim Type") + ' ::' + Format(MedClaims."Patient Type") + ' ::' + MedClaims."Patient Name" + ' ::' + Format(MedClaims."Facility Name") + ' ::' + FORMAT(MedClaims."Date of Service") + ' ::' + Format(medclaims."Claim Date") + ' ::' + FORMAT(MedClaims."Claim Amount") + ' ::' + Format(MedClaims.Status) + ' :::';
            until MedClaims.NEXT = 0;
        end;
    end;

    procedure getDependants(staffNo: Code[25]) Msg: Text
    var
        Kin: Record "HRM-Employee Kin";
    begin
        Kin.RESET;
        Kin.SETRANGE("Employee Code", staffNo);
        if Kin.FIND('-') then begin
            repeat
                Msg += Kin."Other Names" + ' ::' + Kin.SurName + ' :::';
            until Kin.NEXT = 0;
        end;
    end;

    procedure getCurrencies() Msg: Text
    var
        Currencies: Record "Currency";
    begin
        Currencies.RESET;
        if Currencies.FIND('-') then begin
            repeat
                Msg += Currencies.Code + ' ::' + Currencies.Description + ' :::';
            until Currencies.NEXT = 0;
        end;
    end;

    procedure SendMedicalClaimForApproval(claimNo: Code[20]) msg: Boolean
    var
        ApprovMgmt: Codeunit "Approval Workflows V1";
        variant: Variant;
        MedClaim: Record "HRM-Medical Claims";
    begin
        MedClaim.RESET;
        MedClaim.SETRANGE("Claim No", claimNo);
        IF MedClaim.FIND('-') THEN BEGIN
            variant := MedClaim;
            if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                ApprovMgmt.OnSendDocForApproval(variant);
            msg := true;
        end;
    end;

    Procedure GetStaffRequisitions(staffNo: Code[25]) Msg: Text
    begin
        EmpReq.RESET;
        EmpReq.SETRANGE(EmpReq.Requestor, staffNo);
        if EmpReq.FIND('-') then begin
            repeat
                Msg += EmpReq."Requisition No." + ' ::' + EmpReq."Job Description" + ' ::' + Format(EmpReq."Reason for Request") + ' ::' + Format(EmpReq."Type of Contract Required") + ' ::' + Format(EmpReq."Required Positions") + ' ::' + Format(EmpReq."Requisition Date") + ' ::' + Format(EmpReq."Status") + ':::';
            until EmpReq.NEXT = 0;
        end;
    end;

    procedure SendEmpReq(requestorid: code[20]; replacedemp: code[20]; jobid: Text; reason: Option; contractType: Option; priority: Option; posts: Integer; startDate: Date)
    var
        NextEmpReqNo: Text;
        ApprovalMgmtHr: Codeunit "Approval Workflows V1";
        variant: Variant;
    begin
        EmpReq.INIT;
        NextEmpReqNo := NoSeriesMgt.GetNextNo('EMPREQ', 0D, TRUE);
        jobPosts.Reset();
        jobPosts.SETRANGE(jobPosts."Job ID", jobid);
        IF jobPosts.FIND('-')
        THEN BEGIN
            EmpReq."Job ID" := jobPosts."Job ID";
            EmpReq."Job Description" := jobPosts."Job Title";
            EmpReq."Job Ref No" := jobPosts."Job Reference Number";
            EmpReq."Vacant Positions" := jobPosts."Vacant Positions";
            EmpReq."Reporting To:" := jobPosts."Position Reporting to";
        END;
        "Employee Card".Reset;
        "Employee Card".SetRange("No.", requestorid);
        if "Employee Card".FIND('-') THEN BEGIN
            EmpReq."Requestor Name" := "Employee Card".FullName();
            EmpReq.Department := "Employee Card"."Department Code";
        END;
        EmpReq."Requisition No." := NextEmpReqNo;
        EmpReq.Requestor := requestorid;
        EmpReq."Requestor Staff ID" := requestorid;
        EmpReq."Requisition Date" := TODAY;
        EmpReq.Priority := priority;
        EmpReq."Type of Contract Required" := contractType;
        EmpReq."Proposed Starting Date" := startDate;
        EmpReq."Required Positions" := posts;
        EmpReq."Reason For Request" := reason;
        if replacedemp <> '' then begin
            "Employee Card".RESET;
            "Employee Card".SetRange("No.", replacedemp);
            if "Employee Card".FIND('-') THEN begin
                EmpReq."Staff Exiting StaffID" := replacedemp;
                EmpReq."Staff Exiting Name" := "Employee Card".FullName();
            end;
        end;
        EmpReq.INSERT;
        EmpReq.Reset();
        EmpReq.SETRANGE(EmpReq."Requisition No.", NextEmpReqNo);
        IF EmpReq.FIND('-')
        THEN BEGIN
            variant := EmpReq;
            ApprovalMgmtHr.OnSendDocForApproval(variant);
        end
    end;

    procedure GetJobPosts() Message: Text
    begin
        jobPosts.Reset();
        jobPosts.SETFILTER(jobPosts."Vacant Positions", '>%1', 0);
        IF jobPosts.FIND('-') THEN BEGIN
            repeat
                Message := Message + jobPosts."Job ID" + ' ::' + jobPosts."Job Title" + ' :::';
            until jobPosts.Next = 0;
        END
    end;

    procedure GetJobPostDetails(id: Code[10]) Message: Text
    begin
        jobPosts.Reset();
        jobPosts.SETRANGE(jobPosts."Job ID", id);
        IF jobPosts.FIND('-') THEN BEGIN
            Message := jobPosts."Job Reference Number" + ' ::' + FORMAT(jobPosts."No of Posts") + ' ::' + jobPosts."Position Reporting to" + ' ';
        END
    end;

    procedure FnImpSurrAttachement(retNo: Code[50]; fileName: Text; attachment: BigText; tableId: Integer) return_value: Boolean
    var
        DocAttachment: Record "Document Attachment";
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
        tableFound: Boolean;
        ObjAppliRec: Record "FIN-Imprest Surr. Header";

    begin

        tableFound := false;
        return_value := false;
        if TableID = Database::"FIN-Imprest Surr. Header" then begin
            ObjAppliRec.RESET;
            ObjAppliRec.SETRANGE(ObjAppliRec.No, retNo);
            if ObjAppliRec.FIND('-') then begin
                FromRecRef.GETTABLE(ObjAppliRec);
            end;
            tableFound := true;
        end;

        if tableFound = true then begin
            if FileName <> '' then begin
                Clear(DocAttachment);
                DocAttachment.Init();
                DocAttachment.Validate("File Extension", FileManagement.GetExtension(FileName));
                DocAttachment.Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(FileName)));
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("No.", retNo);
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

    procedure GetProgramOptions(progcode: Code[20]; stagecode: Code[20]) msg: Text
    var
        programOptions: Record "ACA-Programme Options";
    begin
        programOptions.RESET;
        programOptions.SETRANGE(programOptions."Programme Code", progcode);
        //programOptions.SETRANGE(programOptions."Stage Code", stagecode);
        if programOptions.FIND('-') then begin
            repeat
                msg += programOptions.Code + '::' + programOptions."Desription" + ':::';
            until programOptions.NEXT = 0;
        end;
    end;

    procedure SubmitImprestSurrHeader(ImprestNo: Code[20]) Message: Text
    begin
        ImprestSurrHeader.RESET;
        ImprestSurrHeader.SETRANGE(ImprestSurrHeader."Imprest Issue Doc. No", ImprestNo);
        IF NOT ImprestSurrHeader.FIND('-') THEN BEGIN
            NextJobapplicationNo := NoSeriesMgt.GetNextNo('SURR', 0D, TRUE);
            ImprestRequisition.RESET;
            ImprestRequisition.GET(ImprestNo);
            /*Copy the details to the user interface*/
            ImprestSurrHeader.No := NextJobapplicationNo;
            ImprestSurrHeader."Imprest Issue Doc. No" := ImprestNo;
            ImprestSurrHeader."Paying Bank Account" := ImprestRequisition."Paying Bank Account";
            ImprestSurrHeader.Payee := ImprestRequisition.Payee;
            ImprestSurrHeader."Surrender Date" := TODAY;
            ImprestSurrHeader."Account Type" := ImprestSurrHeader."Account Type"::Customer;
            ImprestSurrHeader."Account No." := ImprestRequisition."Account No.";
            HRMEmployeeD.GET(ImprestRequisition."Staff No");
            ImprestSurrHeader."Responsibility Center" := HRMEmployeeD."Responsibility Center";
            ImprestRequisition.CALCFIELDS(ImprestRequisition."Total Net Amount");
            ImprestSurrHeader.Amount := ImprestRequisition."Total Net Amount";
            ImprestSurrHeader."Amount Surrendered LCY" := ImprestRequisition."Total Net Amount LCY";
            //Currencies
            ImprestSurrHeader."Currency Factor" := ImprestRequisition."Currency Factor";
            ImprestSurrHeader."Currency Code" := ImprestRequisition."Currency Code";

            ImprestSurrHeader."Date Posted" := ImprestRequisition."Date Posted";
            ImprestSurrHeader."Global Dimension 1 Code" := ImprestRequisition."Global Dimension 1 Code";
            ImprestSurrHeader."Shortcut Dimension 2 Code" := ImprestRequisition."Shortcut Dimension 2 Code";
            ImprestSurrHeader."Shortcut Dimension 3 Code" := ImprestRequisition."Shortcut Dimension 3 Code";
            ImprestSurrHeader.Dim3 := ImprestRequisition.Dim3;
            ImprestSurrHeader."Shortcut Dimension 4 Code" := ImprestRequisition."Shortcut Dimension 4 Code";
            ImprestSurrHeader.Dim4 := ImprestRequisition.Dim4;
            ImprestSurrHeader."Imprest Issue Date" := ImprestRequisition.Date;
            ImprestSurrHeader.INSERT;
            Message := NextJobapplicationNo;
        END ELSE BEGIN

            //MODIFY
            ImprestRequisition.GET(ImprestNo);
            HRMEmployeeD.GET(ImprestRequisition."Staff No");
            ImprestSurrHeader."Responsibility Center" := HRMEmployeeD."Responsibility Center";
            IF ImprestSurrHeader.Modify() THEN BEGIN
                ImprestSurrDetails.Reset;
                ImprestSurrDetails.SetRange("Surrender Doc No.", ImprestSurrHeader.No);
                if ImprestSurrDetails.Find('-') then BEGIN
                    ImprestSurrDetails.DeleteAll;
                END;
                Message := ImprestSurrHeader.No;
            END;
        END;

    end;

    procedure SubmitImprestSurrDetails(lineNo: Integer; DocumentNo: Text; ActualSpent: Decimal; CashAmount: Decimal; ImprestNo: Text) Message: Text
    begin

        /*Copy the detail lines from the imprest details table in the database*/
        ImprestRequisitionLines.RESET;
        ImprestRequisitionLines.SETRANGE(ImprestRequisitionLines.No, ImprestNo);
        ImprestRequisitionLines.SETRANGE(ImprestRequisitionLines.LineNo, lineNo);
        IF ImprestRequisitionLines.FIND('-') THEN /*Copy the lines to the line table in the database*/
          BEGIN
            ImprestSurrDetails.SetRange("Surrender Doc No.", DocumentNo);
            ImprestSurrDetails.SetRange("LineNo", lineNo);
            if ImprestSurrDetails.Find('-') then BEGIN
                ImprestSurrDetails."Actual Spent" := ActualSpent;
                ImprestSurrDetails."Cash Receipt Amount" := CashAmount;
                ImprestSurrDetails.Modify(true)
            END else BEGIN
                ImprestSurrDetails.INIT;
                ImprestSurrDetails."Surrender Doc No." := DocumentNo;
                ImprestSurrDetails.LineNo := lineNo;
                ImprestSurrDetails."Account No:" := ImprestRequisitionLines."Account No:";
                ImprestSurrDetails."Imprest Type" := ImprestRequisitionLines."Advance Type";
                ImprestSurrDetails.VALIDATE(ImprestSurrDetails."Account No:");
                ImprestSurrDetails."Account Name" := ImprestRequisitionLines."Account Name";
                ImprestSurrDetails.Amount := ImprestRequisitionLines.Amount;
                ImprestSurrDetails."Due Date" := ImprestRequisitionLines."Due Date";
                ImprestSurrDetails."Imprest Holder" := ImprestRequisitionLines."Imprest Holder";
                ImprestSurrDetails."Actual Spent" := ActualSpent;
                ImprestSurrDetails."Cash Surrender Amt" := CashAmount;
                ImprestSurrDetails."Apply to" := ImprestRequisitionLines."Apply to";
                ImprestSurrDetails."Apply to ID" := ImprestRequisitionLines."Apply to ID";
                ImprestSurrDetails."Surrender Date" := ImprestRequisitionLines."Surrender Date";
                ImprestSurrDetails.Surrendered := ImprestRequisitionLines.Surrendered;
                ImprestSurrDetails."Cash Receipt No" := ImprestRequisitionLines."M.R. No";
                ImprestSurrDetails."Date Issued" := ImprestRequisitionLines."Date Issued";
                ImprestSurrDetails."Type of Surrender" := ImprestRequisitionLines."Type of Surrender";
                ImprestSurrDetails."Dept. Vch. No." := ImprestRequisitionLines."Dept. Vch. No.";
                ImprestSurrDetails."Currency Factor" := ImprestRequisitionLines."Currency Factor";
                ImprestSurrDetails."Currency Code" := ImprestRequisitionLines."Currency Code";
                ImprestSurrDetails."Imprest Req Amt LCY" := ImprestRequisitionLines."Amount LCY";
                ImprestSurrDetails."Shortcut Dimension 1 Code" := ImprestRequisitionLines."Global Dimension 1 Code";
                ImprestSurrDetails."Shortcut Dimension 2 Code" := ImprestRequisitionLines."Shortcut Dimension 2 Code";
                ImprestSurrDetails."Shortcut Dimension 3 Code" := ImprestRequisitionLines."Shortcut Dimension 3 Code";
                ImprestSurrDetails."Shortcut Dimension 4 Code" := ImprestRequisitionLines."Shortcut Dimension 4 Code";
                if ImprestSurrDetails.INSERT(true, true) then begin
                    Message := 'Line added successfully';
                end;
            END
        END
    END;

    procedure SendImpSurrAppReq(docNo: Code[20]) msg: Boolean
    var
        ApprovMgmt: Codeunit "Approval Workflows V1";
        variant: Variant;
    begin
        ImprestSurrHeader.Reset;
        ImprestSurrHeader.SETRANGE(ImprestSurrHeader.No, docNo);
        IF ImprestSurrHeader.FIND('-') THEN BEGIN
            variant := ImprestSurrHeader;
            if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                ApprovMgmt.OnSendDocForApproval(variant);
            msg := true;
        end;
    end;

    procedure GetImprestAccountNo(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE("No.", username);
        IF EmployeeCard.FIND('+') THEN BEGIN
            Message := EmployeeCard."Customer Acc";
        END
    end;

    procedure CreateImprestLine(
            ImprestNo: Code[20];
            AdvanceType: Code[20];
            Amount: Decimal;
            Purpose: Text[100]): Boolean
    var
        ImprestLine: Record "FIN-Imprest Lines";
        ImprestHeader: Record "FIN-Imprest Header";
        ReceiptPaymentType: Record "FIN-Receipts and Payment Types";
        GLAccount: Record "G/L Account";
    begin
        // Validate header exists and is in proper state
        if not ImprestHeader.Get(ImprestNo) then
            exit(false);

        if ImprestHeader.Status <> ImprestHeader.Status::Pending then
            Error('Cannot add lines to Imprest that is not in Pending status');

        // Get GL Account from Receipt Payment Type
        ReceiptPaymentType.Reset();
        ReceiptPaymentType.SetRange(Code, AdvanceType);
        ReceiptPaymentType.SetRange(Type, ReceiptPaymentType.Type::Imprest);
        if not ReceiptPaymentType.FindFirst() then
            exit(false);

        ReceiptPaymentType.TestField("G/L Account");

        // Initialize line
        ImprestLine.Init();
        ImprestLine.No := ImprestNo;
        ImprestLine.Validate("Advance Type", AdvanceType);
        ImprestLine.Validate(Amount, Amount);
        ImprestLine.Purpose := Purpose;

        // Set defaults from header
        ImprestLine."Date Taken" := ImprestHeader.Date;
        ImprestLine."Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
        ImprestLine."Shortcut Dimension 2 Code" := ImprestHeader."Shortcut Dimension 2 Code";
        ImprestLine."Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
        ImprestLine."Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
        ImprestLine."Currency Factor" := ImprestHeader."Currency Factor";
        ImprestLine."Currency Code" := ImprestHeader."Currency Code";
        ImprestLine."Due Date" := Today;
        ImprestLine."Date Issued" := Today;

        // Insert the line
        if ImprestLine.INSERT(True) then
            exit(true)
        else
            exit(false);
    end;

    procedure getEmployeeDetails(employeeNo: code[25]) msg: Text
    var
        Emp: record "HRM-Employee C";
        dimensionValue: Record "Dimension Value";
        RespCenter: Record "Responsibility Center";
        CampusCode: Text[130];
        DepartmentCode: Text[130];
        ResponsibilityCenter: Text[150];
    begin
        Emp.Reset();
        Emp.SetRange("No.", employeeNo);
        if emp.FindFirst() then begin
            dimensionValue.Reset();
            dimensionValue.SetRange("Dimension Code", 'CAMPUS');
            dimensionValue.SetRange(Code, Emp.Campus);
            if dimensionValue.Find('-') then
                CampusCode := dimensionValue.name;
            dimensionValue.Reset();
            dimensionValue.SetRange("Dimension Code", 'DEPARTMENT');
            dimensionValue.SetRange(Code, Emp."Department Code");
            if dimensionValue.Find('-') then
                DepartmentCode := dimensionValue.name;
            RespCenter.Reset();
            RespCenter.SetRange(Code, Emp."Responsibility Center");
            if respcenter.findfirst then begin
                ResponsibilityCenter := RespCenter.Name;
            end;
            msg := CampusCode + ' ::' + DepartmentCode + ' :: ' + ResponsibilityCenter;
        end;
    end;

    procedure CreateImprest(PayeeCode: Code[50]; CurrencyCode: Code[10]; Purpose: Text[200]; applicationDate: date): Code[20]
    var
        ImprestHeader: Record "FIN-Imprest Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CashOfficeSetup: Record "Cash Office Setup";
        DimValue: Record "Dimension Value";
        Customer: Record Customer;
        ImprestLine: Record "FIN-Imprest Lines";
        emp: Record "HRM-Employee C";
        staffno: code[25];
        AccNO: Code[25];
        CampusCode: Code[30];
        DepartmentCode: Code[30];
        ResponsibilityCenter: Code[50];
    begin
        staffno := PayeeCode;
        emp.Reset();
        emp.SetRange("No.", PayeeCode);
        if emp.Find('-') then begin
            AccNO := emp."Customer Acc";
            CampusCode := emp.Campus;
            DepartmentCode := emp."Department Code";
            ResponsibilityCenter := emp."Responsibility Center";
        end;
        // Get setup
        CashOfficeSetup.Get();
        CashOfficeSetup.TestField("Imprest Req No");

        // Initialize header
        ImprestHeader.Init();

        // Set No. Series
        NoSeriesMgt.InitSeries(
            CashOfficeSetup."Imprest Req No",
            ImprestHeader."No. Series",
            WorkDate(),
            ImprestHeader."No.",
            ImprestHeader."No. Series"
        );

        // Set basic fields
        ImprestHeader.Date := WorkDate();
        ImprestHeader.Validate("Currency Code", CurrencyCode);
        ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
        ImprestHeader."Account No." := AccNO;
        ImprestHeader.Validate("Account No.");

        // Set dimensions
        ImprestHeader.Validate("Global Dimension 1 Code", CampusCode);
        ImprestHeader.Validate("Shortcut Dimension 2 Code", DepartmentCode);
        ImprestHeader.Validate("Responsibility Center", ResponsibilityCenter);

        // Set payee information
        if Customer.Get(AccNO) then begin
            ImprestHeader.Payee := Customer.Name;
            ImprestHeader."On Behalf Of" := Customer.Name;
        end;

        // Set user information
        ImprestHeader.Cashier := UserId;
        ImprestHeader."Requested By" := UserId;

        // Set purpose
        ImprestHeader.Purpose := Purpose;
        ImprestHeader."Staff No" := staffno;

        // Set default status
        ImprestHeader.Status := ImprestHeader.Status::Pending;
        ImprestHeader.Date := applicationDate;

        // Set surrender dates
        ImprestHeader."Surrender Days" := CashOfficeSetup."Surrender Dates";
        ImprestHeader."Expected Date of Surrender" := CalcDate(
            Format(CashOfficeSetup."Surrender Dates") + 'D',
            WorkDate()
        );

        // Insert record
        if ImprestHeader.Insert(true) then
            exit(ImprestHeader."No.")
        else
            exit('');
    end;

    procedure OfferUnit(hodno: Code[20]; progcode: Code[20]; stage: code[20]; unitcode: Code[20]; studymode: Code[20]; lecturer: Code[20]; lecturehall: Code[20]; day: Code[20]; timeslot: Code[20]; progoption: Code[20]) rtnMsg: Boolean
    begin
        offeredunits.Init;
        programs.Reset;
        programs.SetRange(Code, progcode);
        if programs.Find('-') then begin
            offeredunits.Programs := programs.Code;
            offeredunits."Program Name" := programs.Description;
            offeredunits.Department := programs."Department Code";
        end;
        offeredunits.Campus := GetHODCampus(hodno);
        offeredunits.Semester := GetCurrentSemester();
        offeredunits.ModeofStudy := studymode;
        if progoption = 'ALL' then
            offeredunits."Program Option" := ''
        else
            offeredunits."Program Option" := progoption;
        offeredunits.Stage := stage;
        offeredunits."Unit Base Code" := unitcode;
        offeredunits.Validate("Unit Base Code");
        offeredunits."Academic Year" := GetCurrentAcademicYear();
        offeredunits.Day := day;
        offeredunits.TimeSlot := timeslot;
        offeredunits."Lecture Hall" := lecturehall;
        offeredunits.Lecturer := lecturer;
        offeredunits.Validate(Lecturer);
        offeredunits.Validate("Lecture Hall");
        offeredunits.Insert;
        lecturers.Init;
        lecturers.Lecturer := lecturer;
        lecturers.Programme := progcode;
        lecturers.Stage := stage;
        lecturers."Program Option" := progoption;
        lecturers.Unit := unitcode;
        lecturers.Description := GetUnitDescription(unitcode);
        lecturers.ModeOfStudy := studymode;
        lecturers."Campus Code" := GetHODCampus(lecturer);
        lecturers.Stream := offeredunits.Stream;
        lecturers.Semester := GetCurrentSemester();
        lecturers.Day := day;
        lecturers.TimeSlot := timeslot;
        lecturers.Insert;
        rtnMsg := true;
    end;

    procedure GetUnitDescription(UnitID: Code[20]) Message: Text
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects.Code, UnitID);
        IF UnitSubjects.FIND('-') THEN BEGIN
            Message := UnitSubjects.Desription;
        END
    end;

    procedure GetProgramOfferedUnits(username: Code[20]; progcode: Code[20]; stagecode: Code[20]; studymode: Code[20]) Details: Text
    begin
        offeredunits.RESET;
        offeredunits.SetCurrentKey(SystemCreatedAt);
        offeredunits.Ascending(false);
        offeredunits.SETRANGE(Programs, progcode);
        offeredunits.SETRANGE(Stage, stagecode);
        offeredunits.SETRANGE(ModeofStudy, studymode);
        offeredunits.SETRANGE(Campus, GetHODCampus(username));
        offeredunits.SETRANGE(Semester, GetCurrentSemester());
        IF offeredunits.FIND('-') THEN BEGIN
            repeat
                offeredunits.CalcFields("Sitting Capacity", "Registered Students");
                Details += offeredunits."Unit Base Code" + ' ::' + GetUnitDescription(offeredunits."Unit Base Code") + ' ::' + offeredunits."Program Name" + ' ::' + offeredunits.ModeofStudy + ' ::' + GetFullNames(offeredunits.Lecturer) + ' ::' + GetLectureHallName(offeredunits."Lecture Hall") + ' ::' + offeredunits.Day + ' ::' + offeredunits.TimeSlot + ' ::' + offeredunits.Programs + ' ::' + offeredunits.Stage + ' ::' + FORMAT(offeredunits."Sitting Capacity" - GetRegisteredStds(offeredunits."Unit Base Code", offeredunits.Programs, offeredunits.Stage, GetHODCampus(username), offeredunits.ModeofStudy)) + ' ::' + FORMAT(GetRegisteredStds(offeredunits."Unit Base Code", offeredunits.Programs, offeredunits.Stage, GetHODCampus(username), offeredunits.ModeofStudy)) + ' :::';
            until offeredunits.Next = 0;
        END;
    end;

    procedure GetLectureTimeSlots(day: Code[20]) Message: Text
    begin
        timeslots.Reset;
        timeslots.SetRange("Day Code", day);
        timeslots.SetCurrentKey("Lesson Code");
        IF timeslots.FIND('-') THEN BEGIN
            REPEAT
                Message += timeslots."Lesson Code" + ' :::';
            UNTIL timeslots.NEXT = 0;
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

    procedure GetUnitsToRegister(stdno: Code[20]; progcode: Code[20]; studymode: Code[20]; day: Code[20]; timeslot: Code[20]) Details: Text
    begin
        offeredunits.RESET;
        //offeredunits.SetRange(Campus, GetStdCampus(stdno));
        offeredunits.SetFilter(ModeofStudy, '%1|%2', studymode, 'ODEL');
        offeredunits.SETRANGE(Semester, GetCurrentSemester());
        offeredunits.SETRANGE(Day, day);
        offeredunits.SETRANGE(TimeSlot, timeslot);
        IF offeredunits.FIND('-') then begin
            repeat
                UnitSubjects.Reset;
                UnitSubjects.SetRange("Programme Code", progcode);
                UnitSubjects.SetRange(Code, offeredunits."Unit Base Code");
                UnitSubjects.SetRange("Stage Code", GetStudentCurrentStage(stdno));
                if UnitSubjects.Find('-') then begin
                    /*offeredunits.CalcFields("Sitting Capacity");
                    if offeredunits."Sitting Capacity" > GetRegisteredStds(offeredunits."Unit Base Code", offeredunits.Stream, GetStdCampus(stdno)) then begin
                    StudentUnits.Reset;
                    StudentUnits.CalcFields(Ge);
                    StudentUnits.SetRange("Student No.", stdno);
                    StudentUnits.SetRange(Unit, offeredunits."Unit Base Code");
                    StudentUnits.SetFilter(Grade, '<>%1&<>%2', '', 'Z');
                    If NOT StudentUnits.Find('-') then begin
                        trscripttbl.Reset;
                        trscripttbl.SetRange(StudentID, stdno);
                        trscripttbl.SetRange(UnitCode, offeredunits."Unit Base Code");
                        trscripttbl.SetFilter(MeanGrade, '<>%1&<>%2&<>%3', 'F', 'FF', 'Z');
                        if NOT trscripttbl.Find('-') then begin
                            if NOT UndonePrerequisite(offeredunits."Unit Base Code", stdno) then begin*/
                    Details += offeredunits."Unit Base Code" + ' ::' + GetUnitDescription(offeredunits."Unit Base Code") + ' ::' + GetFullNames(offeredunits.Lecturer) + ' ::' + GetLectureHallName(offeredunits."Lecture Hall") + ' ::' + offeredunits.Stream + ' :::';
                end;
            /*end;
        end;*/
            //end;
            until offeredunits.Next = 0;
        end;
    end;
    /*procedure GetRegisteredUnits(stdno: Code[20]; progcode: Code[20]) Details: Text
    begin
        StudentUnits.Reset;
        StudentUnits.SetRange("Student No.", stdno);
        StudentUnits.SetRange(Programme, progcode);
        StudentUnits.SetRange(Semester, GetCurrentSemester());
        If StudentUnits.Find('-') then begin
            Repeat
                StudentUnits.CalcFields("Unit Description", Lecturer);
                Details += StudentUnits.Unit + ' ::' + StudentUnits."Unit Description" + ' ::' + GetFullNames(StudentUnits.Lecturer) + ' ::' + GetLectureHallName("StudentUnits.Lecture Hall") + ' ::' + StudentUnits.Stream + ' ::' + StudentUnits.Day + ' ::' + StudentUnits.TimeSlot + ' :::';
            Until StudentUnits.Next = 0;
        end;
    end;*/
    procedure GetStudentCurrentStage(StudentNo: Code[20]) Message: Text
    begin
        CourseRegistration.RESET;
        CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SETRANGE(CourseRegistration.Semester, GetCurrentSemester());
        CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);
        IF CourseRegistration.FIND('+') THEN BEGIN
            Message := CourseRegistration.Stage;
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

    procedure GetLectureDays() Message: Text
    begin
        days.RESET;
        days.SetCurrentKey("Day Order");
        IF days.FIND('-') THEN BEGIN
            REPEAT
                Message += days."Day Code" + ' :::';
            UNTIL days.NEXT = 0;
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

    procedure GetLecUnits(lecno: Code[20]) msg: Text
    begin
        lecturers.Reset;
        lecturers.SetRange(Lecturer, lecno);
        lecturers.SetRange(Semester, GetCurrentSemester());
        if lecturers.Find('-') then begin
            repeat
                msg += lecturers.Unit + ' ::' + GetUnitDescription(Lecturers.Unit) + ' ::' + lecturers.Programme + '::' + GetProgramDescription(lecturers.Programme) + '::' + lecturers.Stage + ' :::';
            until lecturers.Next = 0;
        end;
    end;

    procedure GetProgramDescription(progcode: Code[20]) Message: Text
    begin
        programs.RESET;
        programs.SETRANGE(Code, progcode);
        IF programs.FIND('-') THEN BEGIN
            Message := programs.Description;
        END
    end;

    procedure GetAllocatedLectureHall(lecturer: Code[20]; unit: Code[20]; stream: Text; campus: Code[20]; mode: Code[20]) details: Text
    begin
        offeredunits.Reset;
        offeredunits.SetRange("Unit Base Code", unit);
        offeredunits.SetRange(Lecturer, lecturer);
        offeredunits.SetRange(Campus, GetHODCampus(lecturer));
        offeredunits.SetRange(Stream, stream);
        offeredunits.SetRange(Semester, GetCurrentSemester());
        if offeredunits.Find('-') then begin
            details := GetLectureHallName(offeredunits."Lecture Hall") + ' ::' + Format(GetRegisteredStds(unit, stream, GetHODCampus(lecturer), mode));
        end else begin
            details := ' ::';
        end;
    end;

    procedure GetRegisteredStds(unit: Code[20]; stream: Text; campus: Code[20]; mode: Code[20]) stds: Integer
    begin
        StudentUnits.Reset;
        StudentUnits.SetRange("Campus Code", campus);
        StudentUnits.SetRange(Unit, unit);
        StudentUnits.SetRange(ModeofStudy, mode);
        StudentUnits.SetRange(Stream, stream);
        StudentUnits.SetRange(Semester, GetCurrentSemester());
        if StudentUnits.Find('-') then begin
            stds := StudentUnits.Count;
        end;
    end;

    procedure ChangeLectureHall(hodno: Code[20]; unitcode: code[20]; progcode: code[20]; studymode: code[20]; stage: Code[20]; lechall: Code[20]) Details: Boolean
    begin
        offeredunits.RESET;
        offeredunits.SETRANGE("Unit Base Code", unitcode);
        offeredunits.SETRANGE(Programs, progcode);
        offeredunits.SETRANGE(ModeofStudy, studymode);
        offeredunits.SETRANGE(Stage, stage);
        offeredunits.SETRANGE(Semester, GetCurrentSemester());
        offeredunits.SetRange(Campus, GetHODCampus(hodno));
        IF offeredunits.FIND('-') THEN BEGIN
            offeredunits."Lecture Hall" := lechall;
            offeredunits.Modify();
            Details := true;
        END;
    end;

    procedure ChangeLecturer(hodno: Code[20]; unitcode: code[20]; progcode: code[20]; studymode: code[20]; stage: Code[20]; lec: Code[20]) Details: Boolean
    begin
        offeredunits.RESET;
        offeredunits.SETRANGE("Unit Base Code", unitcode);
        offeredunits.SETRANGE(Programs, progcode);
        offeredunits.SETRANGE(ModeofStudy, studymode);
        offeredunits.SETRANGE(Stage, stage);
        offeredunits.SETRANGE(Semester, GetCurrentSemester());
        offeredunits.SetRange(Campus, GetHODCampus(hodno));
        IF offeredunits.FIND('-') THEN BEGIN
            offeredunits.Lecturer := lec;
            offeredunits.Modify();
            //change allocated lecturers
            lecturers.Reset;
            lecturers.SetRange(Unit, offeredunits."Unit Base Code");
            lecturers.SetRange(ModeOfStudy, offeredunits.ModeofStudy);
            lecturers.SetRange(Stage, offeredunits.Stage);
            lecturers.SetRange(Semester, offeredunits.Semester);
            lecturers.SetRange("Campus Code", GetHODCampus(hodno));
            lecturers.SetRange(Day, offeredunits.Day);
            lecturers.SetRange(TimeSlot, offeredunits.TimeSlot);
            if lecturers.Find('-') then begin
                lecturers.Rename(lecturers.Programme, lecturers.Stage, lecturers."Campus Code", lecturers."Group Type", lecturers.Class, lec, lecturers.Unit, lecturers.Semester, Lecturers.Description, lecturers.TimeSlot, lecturers.Day);
            end;
            Details := true;
        END;
    end;

    procedure GetRegisteredStds(unit: Code[20]; prog: Code[20]; stage: Code[20]; campus: Code[20]; mode: Code[20]) stds: Integer
    var
    begin
        StudentUnits.Reset;
        StudentUnits.SetRange("Campus Code", campus);
        StudentUnits.SetRange(Unit, unit);
        StudentUnits.SetRange(ModeofStudy, mode);
        StudentUnits.SetRange(Stage, stage);
        StudentUnits.SetRange(Programme, prog);
        StudentUnits.SetRange(Semester, GetCurrentSemester());
        if StudentUnits.Find('-') then begin
            stds := StudentUnits.Count;
        end;
    end;

    procedure GetLectureHallName(hallcode: Code[20]) hallname: text
    begin
        lecturehalls.Reset;
        lecturehalls.SetRange("Lecture Room Code", hallcode);
        if lecturehalls.Find('-') Then begin
            hallname := lecturehalls."Lecture Room Name";
        end;
    end;

    procedure GetHODDepartment(username: Text) Message: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."Department Code";
        END
    end;

    procedure ClassAttendanceHeader(lectno: code[20]; unit: text; starttime: Time; endtime: Time)
    begin
        AttendanceHeader.INIT;
        AttendanceHeader."Attendance Date" := Today;
        AttendanceHeader."Lecturer Code" := lectno;
        AttendanceHeader.Semester := GetCurrentSem();
        AttendanceHeader."Unit Code" := unit;
        AttendanceHeader."From Time" := starttime;
        AttendanceHeader."To Time" := endtime;
        AttendanceHeader."Class Type" := AttendanceHeader."Class Type"::"Normal Single";
        AttendanceHeader.INSERT;
    end;

    procedure ClassAttendanceDetails(counting: integer; stdno: code[20]; stdname: text; lectno: code[20]; unit: text; present: boolean)
    var
        entryno: integer;
    begin
        AttendanceDetails.INIT;
        AttendanceDetails.Counting := counting;
        AttendanceDetails."Lecturer Code" := lectno;
        AttendanceDetails."Attendance Date" := Today;
        AttendanceDetails."Unit Code" := unit;
        AttendanceDetails."Student No." := stdno;
        AttendanceDetails."Student Name" := stdname;
        AttendanceDetails.Present := present;
        AttendanceDetails.Semester := GetCurrentSem();
        AttendanceDetails.INSERT;
    end;

    procedure GenerateBS64ClassRegisterNew(unitcode: Code[20]; prog: Code[20]; stage: Text; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
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
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        StudentUnits.RESET;
        StudentUnits.SETRANGE(StudentUnits.Unit, unitcode);
        StudentUnits.SETRANGE(StudentUnits.Programme, prog);
        StudentUnits.SETRANGE(StudentUnits.Stage, stage);
        StudentUnits.SETRANGE(StudentUnits.Semester, GetCurrentSem());
        IF StudentUnits.FIND('-') THEN BEGIN
            recRef.GetTable(StudentUnits);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(50324, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END ELSE BEGIN
            Error('No class list for the details provided!');
        END;
        EXIT(filename);
    end;

    procedure GetLectureHalls(hodno: Code[20]; day: Code[20]; timeslot: Code[20]) Message: Text
    begin
        lecturehalls.Reset();
        lecturehalls.SetCurrentKey("Lecture Room Name");
        lecturehalls.SetRange(Campus, GetHODCampus(hodno));
        lecturehalls.SetRange(Department, GetHODDepartment(hodno));
        IF lecturehalls.FIND('-') THEN BEGIN
            repeat
                offeredunits.Reset();
                offeredunits.SetRange("Lecture Hall", lecturehalls."Lecture Room Code");
                offeredunits.SetRange(Day, day);
                offeredunits.SetRange(TimeSlot, timeslot);
                if not offeredunits.find('-') then begin
                    Message += lecturehalls."Lecture Room Code" + ' ::' + lecturehalls."Lecture Room Name" + ' (Capacity ' + FORMAT(lecturehalls."Sitting Capacity") + ') :::';
                end;
            until lecturehalls.Next = 0;
        END
    end;

    procedure GetFullNames(no: Code[20]) fullname: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SetRange("No.", no);
        IF EmployeeCard.FIND('-') THEN begin
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
    end;

    procedure GetHODCampus(hod: Code[20]) campus: Text
    begin
        HRMEmployeeD.RESET;
        HRMEmployeeD.SETRANGE("No.", hod);
        IF HRMEmployeeD.FIND('-') THEN BEGIN
            campus := HRMEmployeeD.Campus;
        END
    end;

    procedure GetLecturers(hodno: Code[20]; day: Code[20]; timeslot: Code[20]) Message: Text
    var
        campus: Code[20];
    begin
        campus := GetHODCampus(hodno);
        HRMEmployeeD.Reset();
        HRMEmployeeD.SetRange(Lecturer, true);
        HRMEmployeeD.SetRange(Campus, campus);
        IF HRMEmployeeD.FIND('-') THEN BEGIN
            repeat
                lecturers.Reset();
                lecturers.SetRange(Lecturer, HRMEmployeeD."No.");
                lecturers.SetRange(Semester, GetCurrentSemester());
                lecturers.SetRange(Day, day);
                lecturers.SetRange(TimeSlot, timeslot);
                if NOT lecturers.FIND('-') then begin
                    Message += HRMEmployeeD."No." + ' ::' + GetFullNames(HRMEmployeeD."No.") + ' :::';
                end;
            until HRMEmployeeD.Next = 0;
        END
    end;

    // procedure GetCurrentSemester() Message: Text
    // begin
    //     CurrentSem.RESET;
    //     CurrentSem.SETRANGE("Current Semester", TRUE);
    //     IF CurrentSem.FIND('-') THEN BEGIN
    //         Message := CurrentSem.Code;
    //     END;
    // end;

    procedure GetUnitsToOffer(progcode: code[20]; stage: Code[20]; studymode: Code[20]; progoption: Code[20]) Details: Text
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects."Programme Code", progcode);
        UnitSubjects.SETRANGE(UnitSubjects."Stage Code", stage);
        IF UnitSubjects.FIND('-') THEN BEGIN
            repeat
                offeredunits.Reset;
                offeredunits.SetRange("Unit Base Code", UnitSubjects.Code);
                offeredunits.SetRange(Programs, progcode);
                offeredunits.SetRange(Stage, stage);
                offeredunits.SetRange(ModeofStudy, studymode);
                offeredunits.SetRange(Semester, GetCurrentSemester());
                offeredunits.SetFilter(offeredunits."Program Option", '%1|%2', '', progoption);
                if not offeredunits.Find('-') then begin
                    Details += UnitSubjects.Code + ' ::' + UnitSubjects.Desription + ' :::';
                end;
            until UnitSubjects.Next = 0;
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

    procedure GetDepartmentalPrograms(username: code[10]) progs: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            programs.RESET;
            programs.SETRANGE(programs."Department Code", EmployeeCard."Department Code");
            IF programs.FIND('-') THEN BEGIN
                REPEAT
                    progs += programs.Code + ' ::' + programs.Description + ' :::';
                UNTIL programs.Next = 0;
            END;
        END;
    end;

    procedure ConfirmSupUnit(StdNo: Code[20]; unit: Code[20]) Message: Text
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        LectLoadBatch: Record "Lect Load Batch Lines";
        Balance: Decimal;
    begin
        begin
            Clear(Balance);

            CurrentSem.Reset;
            //CurrentSem.SETRANGE("Current Semester",TRUE);
            //IF CurrentSem.FIND('-') THEN BEGIN
            // IF CurrentSem."Supp Registration Deadline" < TODAY THEN
            // ERROR('Supplementary registration deadline has passed, kindly contact the admin.');
            SupUnits.Reset;
            SupUnits.SetRange("Student No.", StdNo);
            SupUnits.SetRange("Unit Code", unit);
            SupUnits.SetRange(Category, SupUnits.Category::Supplementary);
            SupUnits.SetRange(Status, SupUnits.Status::New);
            if SupUnits.Find('-') then begin
                StudentCard.Reset;
                StudentCard.SetRange("No.", StdNo);
                if StudentCard.FindFirst then begin
                    GenSetup.Get();
                    StudentCard.CalcFields(Balance);
                    Balance := StudentCard.Balance;
                    if isStudentNFMLegible(StdNo) then
                        Balance := getNfmBalance(StdNo);
                    if (Balance <= 0) /* or (Abs(StudentCard.Balance) >= Abs(GenSetup."Supplimentary Fee")) */ then begin
                        SupUnits.Status := SupUnits.Status::Approved;
                        SupUnits.Validate(Status);
                        SupUnits.Modify;
                        Message := 'SUCCESS: Supplementary successfully confirmed';
                    end else begin
                        Error('Please PAY For your Supplementary');
                    end;
                end else begin
                    Error('Student not found');
                end;
                //end student search
                //END  ELSE Message:='FAILED: Supplementary not confirmed';
            end;
        end;
    end;

    procedure isStudentNFMLegible(StdNo: Code[20]): Boolean
    var
        FundingBands: record "Funding Band Entries";
        NFMStatement: Record "NFM Statement Entry";
        Customer: Record Customer;
    begin
        Customer.RESET;
        Customer.SETRANGE("No.", StdNo);
        IF Customer.FIND('-') THEN BEGIN
            FundingBands.RESET;
            FundingBands.SETRANGE("Student No.", StdNo);
            IF FundingBands.FIND('-') THEN BEGIN
                EXIT(TRUE);
            END
            ELSE BEGIN
                EXIT(FALSE);
            END;
        END
        ELSE BEGIN
            EXIT(FALSE);
        END;
    end;

    procedure getNfmBalance(StdNo: Code[20]): Decimal
    var
        FundingBands: record "Funding Band Entries";
        NFMStatement: Record "NFM Statement Entry";
        Customer: Record Customer;
    begin
        FundingBands.RESET;
        FundingBands.SETRANGE("Student No.", StdNo);
        IF FundingBands.FIND('-') THEN BEGIN
            Customer.RESET;
            Customer.SETRANGE("No.", StdNo);
            IF Customer.FIND('-') THEN BEGIN
                REPORT.RUN(78095, FALSE, FALSE, Customer);
                NFMStatement.RESET;
                NFMStatement.SETRANGE("Student No.", StdNo);
                IF NFMStatement.FINDLAST THEN BEGIN
                    EXIT(NFMStatement."Balance");
                END;
            END;
        END;
    end;


    procedure GetCurrentAcademicYear() Year: Text
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        LectLoadBatch: Record "Lect Load Batch Lines";
    begin
        begin
            AcademicYr.Reset;
            AcademicYr.SetRange(Current, true);
            if AcademicYr.Find('-') then begin
                Year := AcademicYr.Code;
            end;
        end;
    end;


    procedure GetIndexNo(username: Code[20]) Index: Text
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        LectLoadBatch: Record "Lect Load Batch Lines";
    begin
        begin
            KUCCPSRaw.Reset;
            KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
            if KUCCPSRaw.Find('-') then begin
                Index := KUCCPSRaw.Index;
            end;
        end;
    end;


    procedure DeleteAttachments(indexno: Code[20]; doctype: Code[50]) Deleted: Boolean
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        LectLoadBatch: Record "Lect Load Batch Lines";
    begin
        begin
            StudentDocs.Reset;
            StudentDocs.SetRange("Index Number", GetIndexNo(indexno));
            StudentDocs.SetRange("Document Code", doctype);
            if StudentDocs.Find('-') then begin
                StudentDocs.CalcFields(Document_Image);
                if StudentDocs.Document_Image.Hasvalue then begin
                    Clear(StudentDocs.Document_Image);
                    StudentDocs.Modify;
                    Deleted := true;
                end;
            end;
        end;
    end;


    procedure CheckUnattachedDoc(indexno: Code[20]) Msg: Boolean
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        LectLoadBatch: Record "Lect Load Batch Lines";
    begin
        begin
            DocSetup.Reset;
            //DocSetup.SETRANGE("Academic Year",GetCurrentAcademicYear());
            DocSetup.SetRange(Mandatory, true);
            if DocSetup.Find('-') then begin
                repeat
                    StudentDocs.Reset;
                    StudentDocs.SetRange("Index Number", GetIndexNo(indexno));
                    StudentDocs.SetRange("Document Code", DocSetup."Document Code");
                    if StudentDocs.Find('-') then begin
                        StudentDocs.CalcFields(Document_Image);
                        if not StudentDocs.Document_Image.Hasvalue then begin
                            Msg := true;
                        end;
                    end;
                until DocSetup.Next = 0;
            end;
        end;
    end;


    procedure GetGrades() Message: Text
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        LectLoadBatch: Record "Lect Load Batch Lines";
    begin
        begin
            GradesTable.Reset;
            if GradesTable.Find('-') then begin
                repeat

                    Message += Format(GradesTable.Code) + ' ::';
                until GradesTable.Next = 0;
            end;
        end;
    end;


    procedure GetMandatoryAttachments(indexno: Code[20]) Message: Text
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        LectLoadBatch: Record "Lect Load Batch Lines";
    begin
        begin
            DocSetup.Reset;
            DocSetup.SetRange("Academic Year", GetCurrentAcademicYear());
            DocSetup.SetRange(Mandatory, true);
            if DocSetup.Find('-') then begin
                repeat
                    StudentDocs.Reset;
                    StudentDocs.SetRange("Index Number", GetIndexNo(indexno));
                    StudentDocs.SetRange("Document Code", DocSetup."Document Code");
                    if StudentDocs.Find('-') then begin
                        StudentDocs.CalcFields(Document_Image);
                        if not StudentDocs.Document_Image.Hasvalue then begin
                            Message += Format(DocSetup."Document Code") + ' ::';
                        end;
                    end;
                until DocSetup.Next = 0;
            end;
        end;
    end;


    procedure GetConfirmedSupUnits(StdNo: Code[20]) Message: Text
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        LectLoadBatch: Record "Lect Load Batch Lines";
    begin
        begin
            SupUnits.Reset;
            SupUnits.SetRange("Student No.", StdNo);
            SupUnits.SetRange(Category, SupUnits.Category::Supplementary);
            SupUnits.SetRange(Status, SupUnits.Status::Approved);
            SupUnits.SetRange("Charge Posted", true);
            if SupUnits.Find('-') then begin
                repeat
                    SupUnits.CalcFields("Unit Description");
                    Message += SupUnits."Unit Code" + ' ::' + SupUnits."Unit Description" + ' :::';
                until SupUnits.Next = 0;
            end;
        end;
    end;


    procedure GetUnconfirmedSupUnits(StdNo: Code[20]) Message: Text
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        LectLoadBatch: Record "Lect Load Batch Lines";
    begin
        begin
            SupUnits.Reset;
            SupUnits.SetRange("Student No.", StdNo);
            SupUnits.SetRange(Category, SupUnits.Category::Supplementary);
            SupUnits.SetRange(Status, SupUnits.Status::New);
            //SupUnits.SETRANGE("Charge Posted",FALSE);

            if SupUnits.Find('-') then begin
                repeat
                    /*AcademicYr.RESET;
                    AcademicYr.SETRANGE(Code, SupUnits."Academic Year");
                    AcademicYr.SETRANGE("Allow View of Transcripts", TRUE);
                    IF AcademicYr.FIND('-') THEN BEGIN*/
                    SupUnits.CalcFields("Unit Description", "2nd Supp Marks");
                    if not (SupUnits."Charge Posted") and ((SupUnits."Exam Marks" < 40) and (SupUnits."2nd Supp Marks" < 40)) then begin
                        // if not (((SupUnits.Semester = 'SEM1 23/24') and (SupUnits.Stage = 'Y1S1')) or ((SupUnits.Semester = 'SEM2 23/24') and (SupUnits.Stage = 'Y1S2')))
                        // then begin
                        Message += SupUnits."Unit Code" + ' ::' + SupUnits."Unit Description" + ' :::';
                        //end;
                    end;
                //END;
                until SupUnits.Next = 0;
            end;
        end;

    end;


    procedure GetEvalLects("Program": Code[20]; Stage: Code[20]; Unit: Code[20]; Sem: Code[20]) Message: Text
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        LectLoadBatch: Record "Lect Load Batch Lines";
    begin
        begin
            LecturerUnits.Reset;
            LecturerUnits.SetRange(Programme, "Program");
            LecturerUnits.SetRange(Stage, Stage);
            LecturerUnits.SetRange(Unit, Unit);
            LecturerUnits.SetRange(Semester, Sem);
            // LecturerUnits.SETRANGE("Company Name", @Company_Name);

            //LectLoadBatch.SETRANGE("Semester Code", LecturerUnits."Semester");

            if LecturerUnits.FindSet then begin
                Message := '';

                LectLoadBatch.Reset;
                LectLoadBatch.SetRange("Lecturer Code", LecturerUnits.Lecturer);

                repeat
                    repeat
                        if LecturerUnits.Lecturer = LectLoadBatch."Lecturer Code" then begin
                            LecturerUnits.Lecturer := LectLoadBatch."Lecturer Name";

                            Message := Message + LecturerUnits.Lecturer + '--' + LectLoadBatch."Lecturer Name" + '\n';

                            exit;
                        end;

                    until LectLoadBatch.Next = 0;

                until LecturerUnits.Next = 0;

                //LecturerUnits.SETRANGE("Company Name", @Company_Name);
                // LecturerUnits.SETRANGE("Student Name", bkamau);
                // LecturerUnits.SORTFIELDS("Lecturer");
                //LecturerUnits.SETTABLEVIEW("Lecturer Units");
                //EXIT(LecturerUnits);
            end;
        end;
    end;


    procedure LoadSelectedUnits(StudentNo: Code[20]; myStage: Code[10]; MyProg: Code[10]; mySem: Code[10]) Message: Text
    var
        RegisteredUnits: Record "ACA-Student Units";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        ACAUnitsBaskets: Record "ACA-Student Units Baskets";
    begin
        ACAUnitsBaskets.Reset;
        ACAUnitsBaskets.SetRange(Programmes, MyProg);
        ACAUnitsBaskets.SetRange("Student No.", StudentNo);
        ACAUnitsBaskets.SetRange(Stage, myStage);
        ACAUnitsBaskets.SetRange(Semester, mySem);


        if ACAUnitsBaskets.FindSet then begin
            Message := '';
            repeat
                // Message:=ACAUnitsSubjects.Code+'::'+ACAUnitsSubjects.Desription;
                Message := Message + ACAUnitsBaskets.Unit + '::' + ACAUnitsBaskets.Description + '\n';
            //until UnitSubjects.Next = 0;
            until ACAUnitsBaskets.Next = 0;
        end;




        //
        // LoadUnits(ProgCode : Code[20];StageCode : Code[20]) Message : Text
        // ACAUnitsSubjects.RESET;
        // ACAUnitsSubjects.SETRANGE("Programme Code",ProgCode);
        // ACAUnitsSubjects.SETRANGE("Stage Code",StageCode);
        // ACAUnitsSubjects.SETRANGE("Time Table",TRUE);
        // ACAUnitsSubjects.SETRANGE("Old Unit",FALSE);
        // IF ACAUnitsSubjects.FIND('-') THEN BEGIN
        //    Message:=ACAUnitsSubjects.Code+'::'+ACAUnitsSubjects.Desription;
        //  END;
    end;


    procedure LoadSemUnits(ProgCode: Code[20]; StageCode: Code[20]; option: Code[20]) Message: Text
    begin
        begin
            ACAUnitsSubjects.Reset;
            ACAUnitsSubjects.SetRange("Programme Code", ProgCode);
            ACAUnitsSubjects.SetRange("Stage Code", StageCode);
            ACAUnitsSubjects.SetRange("Time Table", true);
            ACAUnitsSubjects.SetRange("Old Unit", false);
            ACAUnitsSubjects.SETFILTER(ACAUnitsSubjects."Programme Option", '%1|%2', option, '');
            if ACAUnitsSubjects.FindSet then begin
                Message := '';
                repeat
                    // Message:=ACAUnitsSubjects.Code+'::'+ACAUnitsSubjects.Desription;
                    Message := Message + ACAUnitsSubjects.Code + '##' + ACAUnitsSubjects.Desription + '\n';
                //until UnitSubjects.Next = 0;
                until ACAUnitsSubjects.Next = 0;
            end;
        end;

        // begin
        //        ProgramUnits.RESET;
        //        ProgramUnits.SETRANGE(ProgramUnits."Programme Code", progcode);
        //        ProgramUnits.SETRANGE(ProgramUnits."Stage Code", stagecode);
        //        ProgramUnits.SETRANGE(ProgramUnits."Mode of Study", studymode);
        //        ProgramUnits.SETRANGE(ProgramUnits.Semester, GetCurrentSem(progcode, stagecode));
        //        IF ProgramUnits.FIND('-') THEN BEGIN
        //            REPEAT
        //                Details := Details + ProgramUnits."Unit Code" + ' ::' + ProgramUnits.Desription + ' :::';
        //
        //            until ProgramUnits.Next = 0;
        //        END;
    end;


    procedure LoadSemesterUnits(ProgCode: Code[20]; StageCode: Code[20]) Message: Text
    begin
        begin
            ACAUnitsSubjects.Reset;
            ACAUnitsSubjects.SetRange("Programme Code", ProgCode);
            ACAUnitsSubjects.SetRange("Stage Code", StageCode);
            ACAUnitsSubjects.SetRange("Time Table", true);
            ACAUnitsSubjects.SetRange("Old Unit", false);

            if ACAUnitsSubjects.FindSet then begin
                Message := '';
                repeat
                    // Message:=ACAUnitsSubjects.Code+'::'+ACAUnitsSubjects.Desription;
                    Message := Message + ACAUnitsSubjects.Code + '--' + ACAUnitsSubjects.Desription + '\n';
                //until UnitSubjects.Next = 0;
                until ACAUnitsSubjects.Next = 0;
            end;
        end;

        // begin
        //        ProgramUnits.RESET;
        //        ProgramUnits.SETRANGE(ProgramUnits."Programme Code", progcode);
        //        ProgramUnits.SETRANGE(ProgramUnits."Stage Code", stagecode);
        //        ProgramUnits.SETRANGE(ProgramUnits."Mode of Study", studymode);
        //        ProgramUnits.SETRANGE(ProgramUnits.Semester, GetCurrentSem(progcode, stagecode));
        //        IF ProgramUnits.FIND('-') THEN BEGIN
        //            REPEAT
        //                Details := Details + ProgramUnits."Unit Code" + ' ::' + ProgramUnits.Desription + ' :::';
        //
        //            until ProgramUnits.Next = 0;
        //        END;
    end;


    procedure LoadRegisteredUnits(StudentNo: Code[20]; myStage: Code[10]; MyProg: Code[10]; mySem: Code[10]) Message: Text
    var
        RegisteredUnits: Record "ACA-Student Units";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
    begin
        RegisteredUnits.Reset;
        RegisteredUnits.SetRange(Programme, MyProg);
        RegisteredUnits.SetRange("Student No.", StudentNo);
        RegisteredUnits.SetRange(Stage, myStage);
        RegisteredUnits.SetRange(Semester, mySem);

        /// loop through the ACAUnitsSubjects record and add the matching units to RegisteredUnits
        // WHILE ACAUnitsSubjects.FIND('-') DO BEGIN
        // RegisteredUnits.RESET;
        // RegisteredUnits.SETRANGE(Unit, ACAUnitsSubjects.Code);
        // RegisteredUnits.SETRANGE(Programme, MyProg);
        // RegisteredUnits.SETRANGE(Stage, myStage);
        // RegisteredUnits.SETRANGE(Semester, mySem);
        // RegisteredUnits.SETRANGE("Student No.", StudentNo);
        // RegisteredUnits.SETRANGE("Register for", 0);

        if RegisteredUnits.FindSet then begin
            Message := '';
            repeat
                // Message:=ACAUnitsSubjects.Code+'::'+ACAUnitsSubjects.Desription;
                Message := Message + RegisteredUnits.Unit + '\n';
            //until UnitSubjects.Next = 0;
            until RegisteredUnits.Next = 0;
        end;




        // Z
        // LoadUnits(ProgCode : Code[20];StageCode : Code[20]) Message : Text
        // ACAUnitsSubjects.RESET;
        // ACAUnitsSubjects.SETRANGE("Programme Code",ProgCode);
        // ACAUnitsSubjects.SETRANGE("Stage Code",StageCode);
        // ACAUnitsSubjects.SETRANGE("Time Table",TRUE);
        // ACAUnitsSubjects.SETRANGE("Old Unit",FALSE);
        // IF ACAUnitsSubjects.FIND('-') THEN BEGIN
        //    Message:=ACAUnitsSubjects.Code+'::'+ACAUnitsSubjects.Desription;
        //  END;
    end;


    procedure GetCurrentRecruitmentPassword(username: Text) Message: Text
    begin
        begin
            RecAccountusers.Reset;
            RecAccountusers.SetRange(RecAccountusers."Email Address", username);
            if RecAccountusers.Find('-') then begin
                Message := RecAccountusers.Password + '::';
            end
        end;
    end;


    procedure RemoveGrantLine(QualCode: Code[20]; AppNo: Code[20]; Grant: Text; Year: Code[10]; Purpose: Text) rtnMsg: Boolean
    begin
        begin
            ApplicantQualifications.Reset();

            ApplicantQualifications.SetRange("Application No", AppNo);
            ApplicantQualifications.SetRange("Qualification Code", QualCode);
            ApplicantQualifications.SetRange(Grant, Grant);
            ApplicantQualifications.SetRange("Grant Year", Year);
            ApplicantQualifications.SetRange("Grant Purpose", Purpose);
            if ApplicantQualifications.Find('-') then begin
                ApplicantQualifications.Delete;
                rtnMsg := true;
            end;
        end;
    end;


    procedure RemoveSupervisionLine(QualCode: Code[20]; AppNo: Code[20]; Inst: Text; Year: Code[10]; Level: Text) rtnMsg: Boolean
    begin
        begin
            ApplicantQualifications.Reset();

            ApplicantQualifications.SetRange("Application No", AppNo);
            ApplicantQualifications.SetRange("Qualification Code", QualCode);
            ApplicantQualifications.SetRange("Institution/Company", Inst);
            ApplicantQualifications.SetRange("Year of Supervision", Year);
            ApplicantQualifications.SetRange("Post Graduate Level", Level);
            if ApplicantQualifications.Find('-') then begin
                ApplicantQualifications.Delete;
                rtnMsg := true;
            end;
        end;
    end;


    procedure RemoveJobQualiReqLine(QualCode: Code[20]; AppNo: Code[20]; Desc: Text) rtnMsg: Text
    begin
        begin
            ApplicantQualifications.Reset();

            ApplicantQualifications.SetRange("Application No", AppNo);
            ApplicantQualifications.SetRange("Qualification Code", QualCode);
            ApplicantQualifications.SetRange(Description, Desc);
            if ApplicantQualifications.Find('-') then begin
                ApplicantQualifications.Delete;
                rtnMsg := 'Qualification Deleted Successfully';
            end;
        end;
    end;


    procedure InsertBookChapter(AppNo: Code[30]; title: Text; ChapterTitle: Text; ISBN: Code[50]; Publisher: Text; PageFrom: Text; PageTo: Text; Filepath: Text; Filename: Text) rtnMsg: Text
    begin
        begin
            ApplicantQualifications.Reset();

            ApplicantQualifications.SetRange("Application No", AppNo);
            ApplicantQualifications.SetRange("Qualification Type", 'BOOK CHAPTERS');
            ApplicantQualifications.SetRange("Qualification Code", 'BKCHAPTERS');
            ApplicantQualifications.SetRange(ISBN, ISBN);
            if not ApplicantQualifications.Find('-') then begin
                ApplicantQualifications.Init();

                ApplicantQualifications."Application No" := AppNo;
                ApplicantQualifications."Qualification Type" := 'BOOK CHAPTERS';
                ApplicantQualifications."Qualification Code" := 'BKCHAPTERS';
                ApplicantQualifications.Validate("Qualification Code");
                ApplicantQualifications.Title := title;
                ApplicantQualifications."Chapter Title" := ChapterTitle;
                ApplicantQualifications.ISBN := ISBN;
                ApplicantQualifications.Description := ISBN;
                ApplicantQualifications.Publisher := Publisher;
                ApplicantQualifications."Page From" := PageFrom;
                ApplicantQualifications."Page To" := PageTo;
                ApplicantQualifications."Attachment Path" := Filepath;
                ApplicantQualifications."File Name" := Filename;
                ApplicantQualifications.Insert();

                rtnMsg := 'SUCCESS' + '::';
            end else begin
                rtnMsg := 'FAILED' + '::';
            end;
        end;
    end;


    procedure InsertGrant(AppNo: Code[30]; Grant: Text; Year: Code[10]; Purpose: Text; Filepath: Text; Filename: Text) rtnMsg: Text
    begin
        begin
            ApplicantQualifications.Reset();

            ApplicantQualifications.SetRange("Application No", AppNo);
            ApplicantQualifications.SetRange("Qualification Type", 'GRANTS');
            ApplicantQualifications.SetRange("Qualification Code", 'GRANTS');
            ApplicantQualifications.SetRange(Grant, Grant);
            ApplicantQualifications.SetRange("Grant Year", Year);
            ApplicantQualifications.SetRange("Grant Purpose", Purpose);
            if not ApplicantQualifications.Find('-') then begin
                ApplicantQualifications.Init();
                ApplicantQualifications."Application No" := AppNo;
                ApplicantQualifications."Qualification Type" := 'GRANTS';
                ApplicantQualifications."Qualification Code" := 'GRANTS';
                ApplicantQualifications.Validate("Qualification Code");
                ApplicantQualifications.Grant := Grant;
                ApplicantQualifications."Grant Year" := Year;
                ApplicantQualifications."Grant Purpose" := Purpose;
                ApplicantQualifications.Description := Purpose;
                ApplicantQualifications."Attachment Path" := Filepath;
                ApplicantQualifications."File Name" := Filename;
                ApplicantQualifications.Insert();

                rtnMsg := 'SUCCESS' + '::';
            end else begin
                rtnMsg := 'FAILED' + '::';
            end;
        end;
    end;


    procedure InsertSupervision(AppNo: Code[30]; Inst: Text; Year: Code[10]; Level: Text; Students: Integer; Filepath: Text; Filename: Text) rtnMsg: Text
    begin
        begin
            ApplicantQualifications.Reset();

            ApplicantQualifications.SetRange("Application No", AppNo);
            ApplicantQualifications.SetRange("Qualification Type", 'SUPERVISIONS');
            ApplicantQualifications.SetRange("Qualification Code", 'SUPERV');
            ApplicantQualifications.SetRange("Institution/Company", Inst);
            ApplicantQualifications.SetRange("Year of Supervision", Year);
            ApplicantQualifications.SetRange("Post Graduate Level", Level);
            if not ApplicantQualifications.Find('-') then begin
                ApplicantQualifications.Init();

                ApplicantQualifications."Application No" := AppNo;
                ApplicantQualifications."Qualification Type" := 'SUPERVISIONS';
                ApplicantQualifications."Qualification Code" := 'SUPERV';
                ApplicantQualifications.Validate("Qualification Code");
                ApplicantQualifications."Institution/Company" := Inst;
                ApplicantQualifications."Year of Supervision" := Year;
                ApplicantQualifications."Post Graduate Level" := Level;
                ApplicantQualifications."No of students" := Students;
                ApplicantQualifications.Description := Inst + ' ' + Year + ' ' + Level;
                ApplicantQualifications."Attachment Path" := Filepath;
                ApplicantQualifications."File Name" := Filename;
                ApplicantQualifications.Insert();

                rtnMsg := 'SUCCESS' + '::';
            end else begin
                rtnMsg := 'FAILED' + '::';
            end;
        end;
    end;


    procedure InsertSeminar(AppNo: Code[30]; Type: Text; Name: Text; Mode: Text; Inst: Text; fDate: Date; tDate: Date; Filepath: Text; Filename: Text) rtnMsg: Text
    begin
        begin
            ApplicantQualifications.Reset();

            ApplicantQualifications.SetRange("Application No", AppNo);
            ApplicantQualifications.SetRange("Qualification Type", 'SEMINARS');
            ApplicantQualifications.SetRange("Qualification Code", 'SEMINARS');
            ApplicantQualifications.SetRange(Title, Name);
            if not ApplicantQualifications.Find('-') then begin
                ApplicantQualifications.Init();

                ApplicantQualifications."Application No" := AppNo;
                ApplicantQualifications."Qualification Type" := 'SEMINARS';
                ApplicantQualifications."Qualification Code" := 'SEMINARS';
                ApplicantQualifications.Validate("Qualification Code");
                ApplicantQualifications.Title := Name;
                ApplicantQualifications."Institution/Company" := Inst;
                ApplicantQualifications."Seminar Type" := Type;
                ApplicantQualifications."Seminar Mode" := Mode;
                ApplicantQualifications."From Date" := fDate;
                ApplicantQualifications."To Date" := tDate;
                ApplicantQualifications.Description := Name;
                ApplicantQualifications."Attachment Path" := Filepath;
                ApplicantQualifications."File Name" := Filename;
                ApplicantQualifications.Insert();

                rtnMsg := 'SUCCESS' + '::';
            end else begin
                rtnMsg := 'FAILED' + '::';
            end;
        end;
    end;


    procedure InsertBook(AppNo: Code[30]; title: Text; ISBN: Code[50]; Publisher: Text; Year: Text; Filepath: Text; Filename: Text) rtnMsg: Text
    begin
        begin
            ApplicantQualifications.Reset();

            ApplicantQualifications.SetRange("Application No", AppNo);
            ApplicantQualifications.SetRange("Qualification Type", 'BOOKS');
            ApplicantQualifications.SetRange("Qualification Code", 'BOOKS');
            ApplicantQualifications.SetRange(ISBN, ISBN);
            if not ApplicantQualifications.Find('-') then begin
                ApplicantQualifications.Init();

                ApplicantQualifications."Application No" := AppNo;
                ApplicantQualifications."Qualification Type" := 'BOOKS';
                ApplicantQualifications."Qualification Code" := 'BOOKS';
                ApplicantQualifications.Validate("Qualification Code");
                ApplicantQualifications.Title := title;
                ApplicantQualifications.ISBN := ISBN;
                ApplicantQualifications.Description := ISBN;
                ApplicantQualifications.Publisher := Publisher;
                ApplicantQualifications."Year of Publication" := Year;
                ApplicantQualifications."Attachment Path" := Filepath;
                ApplicantQualifications."File Name" := Filename;
                ApplicantQualifications.Insert();

                rtnMsg := 'SUCCESS' + '::';
            end else begin
                rtnMsg := 'FAILED' + '::';
            end;
        end;
    end;


    procedure InsertProfBodyMembership(AppNo: Code[30]; Institution: Code[50]; MemberSince: Code[10]; FilePath: Text; Description: Text; filename: Text; Active: Boolean) rtnMsg: Text
    begin
        begin
            ApplicantQualifications.Reset();

            ApplicantQualifications.SetRange("Application No", AppNo);
            ApplicantQualifications.SetRange("Qualification Type", 'MEMBERSHIP');
            ApplicantQualifications.SetRange("Qualification Code", 'MBR');
            ApplicantQualifications.SetRange(Description, Description);
            if not ApplicantQualifications.Find('-') then begin
                ApplicantQualifications.Init();

                ApplicantQualifications."Application No" := AppNo;
                ApplicantQualifications."Qualification Type" := 'MEMBERSHIP';
                ApplicantQualifications."Qualification Code" := 'MBR';
                ApplicantQualifications.Validate("Qualification Code");
                ApplicantQualifications."Institution/Company" := Institution;
                ApplicantQualifications."Member Since" := MemberSince;
                ApplicantQualifications.Active := Active;
                ApplicantQualifications.Description := Description;
                ApplicantQualifications."Attachment Path" := FilePath;
                ApplicantQualifications."File Name" := filename;
                ApplicantQualifications.Insert();

                rtnMsg := 'SUCCESS' + '::';
            end else begin
                rtnMsg := 'FAILED' + '::';
            end;
        end;
    end;


    procedure InsertJobApplicantEducationQualifications(AppNo: Code[30]; QualType: Code[30]; QualCode: Code[30]; Level: Text; Institution: Code[50]; FromDate: Date; ToDate: Date; Description: Text; FilePath: Text; Filename: Text) rtnMsg: Text
    begin
        begin
            ApplicantQualifications.Reset();

            ApplicantQualifications.SetRange("Application No", AppNo);
            ApplicantQualifications.SetRange("Qualification Type", QualType);
            ApplicantQualifications.SetRange("Qualification Code", QualCode);
            ApplicantQualifications.SetRange(Description, Description);
            if not ApplicantQualifications.Find('-') then begin
                ApplicantQualifications.Init();

                ApplicantQualifications."Application No" := AppNo;
                ApplicantQualifications."Qualification Type" := QualType;
                ApplicantQualifications."Qualification Code" := QualCode;
                ApplicantQualifications.Validate("Qualification Code");
                ApplicantQualifications."Institution/Company" := Institution;
                ApplicantQualifications."From Date" := FromDate;
                ApplicantQualifications."To Date" := ToDate;
                ApplicantQualifications."Education Level" := Level;
                ApplicantQualifications.Description := Description;
                ApplicantQualifications."Attachment Path" := FilePath;
                ApplicantQualifications."File Name" := Filename;
                ApplicantQualifications.Insert();

                rtnMsg := 'SUCCESS' + '::';
            end else begin
                rtnMsg := 'FAILED' + '::';
            end;
        end;
    end;


    procedure InsertJobApplicantQualifications(AppNo: Code[30]; QualType: Code[30]; QualCode: Code[30]; Institution: Code[50]; FromDate: Date; ToDate: Date; FilePath: Text; Description: Text; filename: Text) rtnMsg: Text
    begin
        begin
            ApplicantQualifications.Reset();

            ApplicantQualifications.SetRange("Application No", AppNo);
            ApplicantQualifications.SetRange("Qualification Type", QualType);
            ApplicantQualifications.SetRange("Qualification Code", QualCode);
            ApplicantQualifications.SetRange(Description, Description);
            if not ApplicantQualifications.Find('-') then begin
                ApplicantQualifications.Init();

                ApplicantQualifications."Application No" := AppNo;
                ApplicantQualifications."Qualification Type" := QualType;
                ApplicantQualifications."Qualification Code" := QualCode;
                ApplicantQualifications.Validate("Qualification Code");
                ApplicantQualifications."Institution/Company" := Institution;
                ApplicantQualifications."From Date" := FromDate;
                ApplicantQualifications."To Date" := ToDate;
                ApplicantQualifications.Description := Description;
                ApplicantQualifications."Attachment Path" := FilePath;
                ApplicantQualifications."File Name" := filename;
                ApplicantQualifications.Insert();

                rtnMsg := 'SUCCESS' + '::';
            end else begin
                rtnMsg := 'FAILED' + '::';
            end;
        end;
    end;


    procedure ValidRecruitmentEmailAddress(username: Text) Message: Text
    var
        TXTIncorrectDetails: label 'Incorrect Username or Password';
        TXTCorrectDetails: label 'Login';
    begin
        begin
            RecAccountusers.Reset;
            RecAccountusers.SetRange(RecAccountusers."Email Address", username);
            if RecAccountusers.Find('-') then begin
                Message := TXTCorrectDetails + '::';
            end else begin
                Message := TXTIncorrectDetails + '::';
            end
        end;
    end;


    procedure CreateRecruitmentAccount(Initialsz: Integer; FirstName: Text; MiddleName: Text; LastName: Text; PostalAddress: Text; PostalCode: Text; IDNumber: Code[30]; Genderz: Integer; HomePhoneNumber: Code[30]; Citizenshipz: Text; Countyz: Text; MaritalStatus: Integer; EthnicOrigin: Text; Disabledz: Option; DesabilityDetails: Text; PwdNumber: Text[50]; DoB: Date; KRA: Text; ApplicantType: Integer; EmailAddress: Text; Passwordz: Text; ActivationCode: Code[10]) Message: Text
    begin
        RecAccountusers.Reset;
        RecAccountusers.SetRange(RecAccountusers."Email Address", EmailAddress);
        if not RecAccountusers.Find('-') then begin
            RecAccountusers.Init;

            RecAccountusers.Initials := Initialsz;
            RecAccountusers."First Name" := FirstName;
            RecAccountusers."Middle Name" := MiddleName;
            RecAccountusers."Last Name" := LastName;
            RecAccountusers."Postal Address" := PostalAddress;
            RecAccountusers."Postal Code" := PostalCode;
            RecAccountusers."ID Number" := IDNumber;
            RecAccountusers.Gender := Genderz;
            RecAccountusers."Home Phone Number" := HomePhoneNumber;
            //RecAccountusers."Residential Address" := ResidentialAddress;
            RecAccountusers.Citizenship := Citizenshipz;
            RecAccountusers.County := Countyz;
            RecAccountusers."Marital Status" := MaritalStatus;
            RecAccountusers."Ethnic Group" := EthnicOrigin;
            RecAccountusers.Disabled := Disabledz;
            RecAccountusers."Disability Details" := DesabilityDetails;
            RecAccountusers."PWD Number" := PwdNumber;
            RecAccountusers."Date of Birth" := DoB;
            RecAccountusers."KRA PIN Number" := KRA;
            //RecAccountusers."Driving License" := DrivingLicense;
            // RecAccountusers."1st Language" := stLanguage;
            // RecAccountusers."2nd Language" := ndLanguage;
            // RecAccountusers."Additional Language" := AdditionalLanguage;
            RecAccountusers."Applicant Type" := ApplicantType;
            RecAccountusers."Email Address" := EmailAddress;
            RecAccountusers.Password := Passwordz;
            RecAccountusers."SessionKey" := ActivationCode;
            RecAccountusers."Created Date" := Today;
            //RecAccountusers.INSERT;
            if RecAccountusers.Insert then begin
                Message := 'Account Created successfully' + '::' + RecAccountusers.Password;
                // Send Email here
                /*SendEmailEasy(FORMAT(RecAccountusers.Initials),FirstName+' '+MiddleName+' '+LastName,',You have successfully created online Recruitment account at KARU',
                'Your User Name is: '+EmailAddress+', Password: '+Passwordz,'Once again welcome to the Karatina University Recruitment portal.'+
                'Keep your credentials safely.','This is a system generated email. Do not reply.',EmailAddress,COMPANYNAME+' Recruitment portal Account');*/
            end else
                Message := 'Error, not created' + '::' + RecAccountusers.Password;
        end else begin
            Message := 'Warning! We already have account created with the Email address provided.' + '::' + RecAccountusers.Password;
        end

    end;


    procedure SendRecruitmentPassword(EmailAddress: Text) Message: Text
    begin
        RecAccountusers.Reset;
        RecAccountusers.SetRange(RecAccountusers."Email Address", EmailAddress);
        if RecAccountusers.Find('-') then begin
            Message := 'Kindly check your email for the password.';
            // Send Email here
            SendEmailEasy('', '', 'Your KarU recruitment Portal Password is  ' + RecAccountusers.Password,
            'Login to continue with your application.', 'Once again welcome to the Karatina University Recruitment portal.' +
            'Keep your credentials safely.', 'This is a system generated email. Do not reply.', EmailAddress, COMPANYNAME + ' Recruitment portal Account');
        end else
            Message := 'Error';

    end;


    procedure SubmitJobApplication(EMail: Text; FirstName: Text; MiddletName: Text; LastName: Text; JobID: Text; JobDescription: Text; RefNo: Text) Message: Text[100]
    begin
        begin

            JobApplications.Reset;

            JobApplications.SetRange(JobApplications."E-Mail", EMail);
            JobApplications.SetRange(JobApplications."Job Applied For", JobID);
            if not JobApplications.Find('-') then begin
                NextJobapplicationNo := NoSeriesMgt.GetNextNo('JOBAPP', 0D, true);

                RecAccountusers.Reset;
                RecAccountusers.SetRange(RecAccountusers."Email Address", EMail);
                if RecAccountusers.Find('-') then begin
                    JobApplications.Init;

                    JobApplications."Application No" := NextJobapplicationNo;
                    JobApplications."Employee Requisition No" := RefNo;
                    JobApplications."Applicant Type" := RecAccountusers."Applicant Type";
                    JobApplications.Initials := Format(RecAccountusers.Initials);
                    JobApplications."First Name" := FirstName;
                    JobApplications."Middle Name" := MiddletName;
                    JobApplications."Last Name" := LastName;
                    JobApplications."Postal Address" := RecAccountusers."Postal Address";
                    JobApplications."Residential Address" := RecAccountusers."Residential Address";
                    JobApplications."Post Code" := RecAccountusers."Postal Code";
                    JobApplications.County := RecAccountusers.County;
                    JobApplications."Home Phone Number" := RecAccountusers."Home Phone Number";
                    JobApplications."Cell Phone Number" := RecAccountusers."Home Phone Number";
                    JobApplications."Work Phone Number" := RecAccountusers."Home Phone Number";
                    JobApplications."E-Mail" := EMail;
                    JobApplications."ID Number" := RecAccountusers."ID Number";
                    JobApplications.Gender := RecAccountusers.Gender;
                    JobApplications."Country Code" := RecAccountusers.Citizenship;
                    JobApplications."Marital Status" := RecAccountusers."Marital Status";
                    JobApplications."Ethnic Group" := RecAccountusers."Ethnic Group";
                    JobApplications."First Language (R/W/S)" := RecAccountusers."1st Language";
                    JobApplications."Driving Licence" := RecAccountusers."Driving License";
                    JobApplications.Disabled := RecAccountusers.Disabled;
                    JobApplications."Date Of Birth" := RecAccountusers."Date of Birth";
                    JobApplications."Second Language (R/W/S)" := RecAccountusers."2nd Language";
                    JobApplications."Additional Language" := RecAccountusers."Additional Language";
                    JobApplications.Citizenship := RecAccountusers.Citizenship;
                    //JobApplications."Ethnic Origin" := RecAccountusers."Ethnic Origin";
                    JobApplications."Disabling Details" := RecAccountusers."Disability Details";
                    JobApplications."Passport Number" := RecAccountusers."ID Number";
                    JobApplications."PIN Number" := RecAccountusers."KRA PIN Number";
                    JobApplications."Job Applied For" := JobID;
                    JobApplications."Job Applied for Description" := JobDescription;
                    JobApplications.Status := JobApplications.Status::Normal;
                    JobApplications."Date Applied" := Today;
                    JobApplications."No. Series" := 'JOBAPP';
                    //JobApplications."CV Path" := MyCVPath;
                    //JobApplications."Cover Letter Path" := GoodConductPath;
                    JobApplications.Insert;
                    if JobApplications.Insert then;
                    Message := 'SUCCESS' + '::' + JobApplications."Application No";
                end

            end else begin
                Message := 'FAILED' + '::' + JobApplications."Application No";
            end;

        end;








        /*CLEAR(ReturnMessage);
        ReturnMessage:='FAILED';
        IF SuppCategory = 1 THEN BEGIN
        AcaSpecialExamsDetailss.RESET;
        AcaSpecialExamsDetailss.SETRANGE("Academic Year",AcademicYear);
        AcaSpecialExamsDetailss.SETRANGE("Student No.",StudentNo);
        AcaSpecialExamsDetailss.SETRANGE("Unit Code",UnitCode);
        IF AcaSpecialExamsDetailss.FIND('-') THEN BEGIN
          IF AcaSpecialExamsDetailss."Charge Posted" = FALSE THEN ERROR('Supp. Charges for '+UnitCode+'are not posted!');
          AcaSpecialExamsDetailss."Exam Marks":=ExamScore;
          AcaSpecialExamsDetailss.MODIFY;
        ReturnMessage:='SUCCESS';
          END;
          END ELSE IF SuppCategory = 2 THEN BEGIN
        Aca2ndSuppExamsDetails.RESET;
        Aca2ndSuppExamsDetails.SETRANGE("Academic Year",AcademicYear);
        Aca2ndSuppExamsDetails.SETRANGE("Student No.",StudentNo);
        Aca2ndSuppExamsDetails.SETRANGE("Unit Code",UnitCode);
        IF Aca2ndSuppExamsDetails.FIND('-') THEN BEGIN
          IF Aca2ndSuppExamsDetails."Charge Posted" = FALSE THEN ERROR('Supp. Charges for '+UnitCode+'are not posted!');
          Aca2ndSuppExamsDetails."Exam Marks":=ExamScore;
          Aca2ndSuppExamsDetails.MODIFY;
        ReturnMessage:='SUCCESS';
          END;
            END;*/

    end;


    procedure SubmitJobApplicationAttachments(AppNo: Code[30]; CvPath: Text; CoverLetterPath: Text[250]) Message: Text[100]
    begin
        begin

            JobApplications.Reset;

            JobApplications.SetRange(JobApplications."Application No", AppNo);
            if JobApplications.Find('-') then begin

                if (JobApplications.Submitted = false) then begin
                    JobApplications."CV Path" := CvPath;
                    JobApplications."Cover Letter Path" := CoverLetterPath;
                    JobApplications.Submitted := true;
                    JobApplications.Modify();
                    if JobApplications.Modify() then;
                    Message := 'SUCCESS' + '::';
                end else begin
                    Message := 'FAIL 1' + '::';
                end



            end else begin
                Message := 'FAIL 2' + '::';
            end
        end;
    end;


    procedure CheckJobApplicationSubmitted(AppNo: Code[30]) Message: Boolean
    begin
        begin

            JobApplications.Reset;
            JobApplications.SetRange(JobApplications."Application No", AppNo);
            if JobApplications.Find('-') then begin
                Message := JobApplications.Submitted;
            end;
        end;
    end;


    procedure SubmitJobApplicationSpecialization(AppNo: Code[30]; Specialization: Text) Message: Boolean
    begin
        begin
            JobApplications.Reset;
            JobApplications.SetRange(JobApplications."Application No", AppNo);
            if JobApplications.Find('-') then begin
                JobApplications.Specialization := Specialization;
                JobApplications.Modify;
                Message := true;
            end;
        end;
    end;


    procedure SubmitJobApplicationOtherAttachmentsFileName(AppNo: Code[30]; CvFileName: Text) Message: Boolean
    begin
        begin
            JobApplications.Reset;
            JobApplications.SetRange(JobApplications."Application No", AppNo);
            if JobApplications.Find('-') then begin
                JobApplications."Other Attachments FileName" := CvFileName;
                JobApplications.Modify;
                Message := true;
            end;
        end;
    end;


    procedure DeleteJobApplicationOtherAttachments(AppNo: Code[30]) Message: Boolean
    begin
        begin
            JobApplications.Reset;
            JobApplications.SetRange(JobApplications."Application No", AppNo);
            if JobApplications.Find('-') then begin
                JobApplications."Other Attachments FileName" := '';
                JobApplications."Other Attachments Path" := '';
                JobApplications.Modify;
                Message := true;
            end;
        end;
    end;


    procedure SubmitJobApplicationCVFileName(AppNo: Code[30]; CvFileName: Text) Message: Boolean
    begin
        begin
            JobApplications.Reset;
            JobApplications.SetRange(JobApplications."Application No", AppNo);
            if JobApplications.Find('-') then begin
                JobApplications."CV FileName" := CvFileName;
                JobApplications.Modify;
                Message := true;
            end;
        end;
    end;


    procedure SubmitJobApplicationCoverLetterFileName(AppNo: Code[30]; CoverLetterFileName: Text) Message: Boolean
    begin
        begin
            JobApplications.Reset;
            JobApplications.SetRange(JobApplications."Application No", AppNo);
            if JobApplications.Find('-') then begin
                JobApplications."Cover Letter FileName" := CoverLetterFileName;
                JobApplications.Modify;
                Message := true;
            end;
        end;
    end;


    procedure GetJobApplicationOtherAttachmentsFileName(AppNo: Code[30]) Message: Text[100]
    begin
        begin

            JobApplications.Reset;
            JobApplications.SetRange(JobApplications."Application No", AppNo);
            if JobApplications.Find('-') then begin
                Message := JobApplications."Other Attachments FileName";
            end;
        end;
    end;


    procedure GetJobApplicationCoverLetterFileName(AppNo: Code[30]) Message: Text[100]
    begin
        begin

            JobApplications.Reset;
            JobApplications.SetRange(JobApplications."Application No", AppNo);
            if JobApplications.Find('-') then begin
                Message := JobApplications."Cover Letter FileName";
            end;
        end;
    end;


    procedure GetJobApplicationCVFileName(AppNo: Code[30]) Message: Text[100]
    begin
        begin

            JobApplications.Reset;
            JobApplications.SetRange(JobApplications."Application No", AppNo);
            if JobApplications.Find('-') then begin
                Message := JobApplications."CV FileName";
            end;
        end;
    end;


    procedure GetJobApplicationSpecialization(AppNo: Code[30]) Message: Text[250]
    begin
        begin

            JobApplications.Reset;
            JobApplications.SetRange(JobApplications."Application No", AppNo);
            if JobApplications.Find('-') then begin
                Message := JobApplications.Specialization;
            end;
        end;
    end;


    procedure CreateBidderAccount(VatPin: Text; CompName: Text; PostalAddress: Text; PostalCode: Text; Location: Text; CompPhone: Text; CompEmail: Text; ContactPerson: Text; ContactPersonPhone: Text; ContactPersonEmail: Text; VATCertificate: Text[250]; PinRegistrationCertificate: Text[250]; TaxCompliaceCertificate: Text[250]; Password: Text; Country: Text; CertificateOfIncorporation: Text[250]) Message: Text
    begin
        begin
            tblBidder.Reset;
            tblBidder.SetRange(tblBidder."No.", VatPin);

            if not tblBidder.Find('-') then begin
                tblBidder."No." := VatPin;
                tblBidder.Name := CompName;
                tblBidder."E-Mail" := CompEmail;
                tblBidder."Phone No." := CompPhone;
                tblBidder.Address := PostalAddress + '-' + PostalCode;
                //tblBidder."Territory Code" := Country;
                tblBidder."Contact Person" := ContactPerson;
                //tblBidder."Phone No." := ContactPersonPhone;
                tblBidder."Contact Person Email" := ContactPersonEmail;
                tblBidder."VAT Registration No." := VatPin;
                tblBidder."Certificate of Incoporation" := CertificateOfIncorporation;
                tblBidder."VAT Registration Certificate" := VATCertificate;
                tblBidder."Pin Registration Certificate" := PinRegistrationCertificate;
                tblBidder."Tax Compliance Certificate" := TaxCompliaceCertificate;
                tblBidder.Password := Password;
                tblBidder.Insert;
                Message := 'SUCCESS' + '::';
            end
            else begin
                Message := 'FAIL' + '::';
            end;
        end;

    end;


    procedure HRLeaveApplication(EmployeeNo: Text; LeaveType: Text; AppliedDays: Decimal; StartDate: Date; EndDate: Date; ReturnDate: Date; SenderComments: Text; Reliever: Text; RelieverName: Text) successMessage: Text
    var
        ACAApplicFormHeader: Record "ACA-Applic. Form Header";
        ApprovHR: Codeunit IntCodeunit;
    begin
        LeaveT.Init;
        HRSetup.Get;
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('LEAVE', 0D, true);
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", EmployeeNo);

        if "Employee Card".Find('-')
        then begin
            LeaveT."User ID" := "Employee Card"."User ID";
            EmployeeUserId := "Employee Card"."User ID";
            LeaveT."Employee No" := EmployeeNo;
            LeaveT."Employee Name" := "Employee Card".FullName;
            "Supervisor Card".Reset;
            "Supervisor Card".SetRange("Supervisor Card"."User ID", "Employee Card"."User ID");
            if "Supervisor Card".Find('-')
            then begin
                SupervisorId := "Supervisor Card"."Approver ID";
            end;
        end;

        LeaveT."Reliever No." := Reliever;
        LeaveT."Reliever Name" := RelieverName;
        LeaveT."No." := NextLeaveApplicationNo;
        LeaveT."Leave Type" := LeaveType;
        LeaveT.Validate("Leave Type");
        LeaveT."Applied Days" := AppliedDays;
        LeaveT.Date := Today;
        LeaveT."Starting Date" := StartDate;
        LeaveT."End Date" := EndDate;
        LeaveT."Return Date" := ReturnDate;
        LeaveT.Purpose := SenderComments;
        LeaveT."No. Series" := 'LEAVE';
        LeaveT.Status := HRLeave.Status::Open;
        LeaveT."Responsibility Center" := 'KARU';
        LeaveT.Insert;
        //send request for approval
        "HR Leave Application".Reset;
        "HR Leave Application".SetRange("HR Leave Application"."No.", NextLeaveApplicationNo);
        if "HR Leave Application".Find('-')
        then begin

            //State:=State::Open;
            //IF Status<>Status::Open THEN State:=State::"Pending Approval";
            //DocType:=DocType::"Leave Application";
            //CLEAR(tableNo);
            //tableNo:=61125;
            //AppMgt.SendApproval(tableNo,NextLeaveApplicationNo,DocType,State);
            ApprovHR.OnSendLeavesforApproval("HR Leave Application");
        end;
    end;


    procedure HRUpdateLeaveApplication("Document No": Text; "Reliever No": Text; ApprovedDays: Integer; "Supervisor ID param": Text) SuccessMessage: Text
    begin

        LeaveT.Reset;
        LeaveT.SetRange(LeaveT."No.", "Document No");

        if LeaveT.Find('-')
          then begin
            // LeaveT.Reliever:="Reliever No";
            "Employee Card".Reset;
            "Employee Card".SetRange("Employee Card"."No.", "Reliever No");

            if "Employee Card".Find('-')
            then begin

            end;
            LeaveT.Modify;
            "Supervisor ID" := "Supervisor ID param";

            ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Document No");
            ApprovalEntry.SetRange(ApprovalEntry."Approver ID", "Supervisor ID param");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.Find('-') then begin
                //Modify status to approved if there are no other approvers
                ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                ApprovalEntry.Modify;

                //Change next doc to open
                ApprovalEntry_2.Reset;
                ApprovalEntry_2.SetRange(ApprovalEntry_2."Document No.", "Document No");
                ApprovalEntry_2.SetRange(ApprovalEntry_2.Status, ApprovalEntry_2.Status::Created);
                if ApprovalEntry_2.Find('-') then begin
                    ApprovalEntry_2.Status := ApprovalEntry_2.Status::Open;
                    ApprovalEntry_2."Last Date-Time Modified" := CreateDatetime(Today, Time);
                    ApprovalEntry_2."Last Modified By ID" := "Supervisor ID param";
                    ApprovalEntry_2.Modify;
                    SuccessMessage := 'Approval successful.';
                end;

            end;
            ApprovalEntry_2.Reset;
            ApprovalEntry_2.SetRange(ApprovalEntry_2."Document No.", "Document No");
            if ApprovalEntry_2.FindLast then begin
                if ApprovalEntry_2.Status = ApprovalEntry_2.Status::Approved then begin
                    HRLeave.Reset;
                    HRLeave.SetRange(HRLeave."No.", "Document No");
                    if HRLeave.Find('-') then begin
                        HRLeave.Status := "HR Leave Application".Status::Posted;
                        HRLeave.Modify;
                        //  HRLeave.CreateLeaveLedgerEntries;
                        //   IF ApprovalSetup.Approvals THEN
                        //     ApprovalMgtNotification.SendLeaveApprovedMail(HRLeave,ApprovalEntry);

                    end;
                end;
            end;

        end;
    end;


    procedure TransportRequisitionCreate("Employee No": Text; Destination: Text; CommenceFrom: Text; "Date of Trip": Date; Purpose: Text; "No of Days": Integer; "No of Passengers": Integer; "Request Type": Option; "Travel Type": Option; DepatureTime: Time; Department: Code[20]; Campus: Code[20]) LastTransportReqInsert: Text
    var
        NextTransportApplicationNo: Text;
    begin

        TransportRequisition.Init;
        NextTransportApplicationNo := NoSeriesMgt.GetNextNo('TRANS', 0D, true);
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", "Employee No");

        if "Employee Card".Find('-')
        then begin
            TransportRequisition."Requested By" := "Employee Card"."User ID";
            TransportRequisition."Department Code" := "Employee Card"."Department Code";
            TransportRequisition."Employee Name" := "Employee Card".Names;
            TransportRequisition."Emp No" := "Employee No";
            TransportRequisition."Employee Name" := "Employee Card".Names;
            // TransportRequisition."Phone No.":="Employee Card"."Work Phone Number";
            "Supervisor Card".Reset;
            "Supervisor Card".SetRange("Supervisor Card"."User ID", "Employee Card"."User ID");
            if "Supervisor Card".Find('-')
            then begin
                SupervisorId := "Supervisor Card"."Approver ID";
            end;
        end;

        TransportRequisition."Transport Requisition No" := NextTransportApplicationNo;
        TransportRequisition.Commencement := CommenceFrom;
        TransportRequisition.Destination := Destination;
        TransportRequisition."Date of Request" := Today;
        //TransportRequisition."Request Date":=TODAY;
        TransportRequisition."Purpose of Trip" := Purpose;
        TransportRequisition."No. Series" := 'TRANS';
        //TransportRequisition."Date of Trip":="Date of Trip";
        TransportRequisition."No of Days Requested" := "No of Days";
        //TransportRequisition."No of Passengers":="No of Passengers";
        // TransportRequisition."Request type":="Request Type";
        //TransportRequisition."Travel Type":="Travel Type";
        //TransportRequisition."Depature Time" := DepatureTime;
        TransportRequisition."Department Code" := Department;
        // TransportRequisition.Campus := Campus;

        TransportRequisition.Insert;

        TransportRequisition.Reset;
        TransportRequisition.SetRange(TransportRequisition."Transport Requisition No", NextTransportApplicationNo);
        if TransportRequisition.Find('-')
        then begin
            /*ApprovalEntry.INIT;
            ApprovalEntry."Table ID":=39004336;
            ApprovalEntry."Document Type" :=ApprovalEntry."Document Type"::"Staff Claim";
            ApprovalEntry."Document No.":=NextTransportApplicationNo;
            ApprovalEntry."Sequence No.":=1;
            ApprovalEntry."Approval Code":='TRANS';
            ApprovalEntry.Status:=ApprovalEntry_2.Status::Open;
            ApprovalEntry."Sender ID":=EmployeeUserId;
            ApprovalEntry."Approver ID":=SupervisorId;
            ApprovalEntry."Date-Time Sent for Approval":=CURRENTDATETIME;
            ApprovalEntry."Last Date-Time Modified":=CURRENTDATETIME;
            ApprovalEntry."Last Modified By ID":=USERID;
            ApprovalEntry.INSERT;*/
            LastTransportReqInsert := TransportRequisition."Transport Requisition No";
        end;

    end;


    procedure HRTravelRequisitionCreate("Requisition No": Text; "Employee Number": Text)
    begin
        TransportRequisition.Reset;
        TransportRequisition.SetRange(TransportRequisition."Transport Requisition No", "Requisition No");
        TransportRequisition.SetRange(TransportRequisition.Status, TransportRequisition_2.Status::Open);

        if TransportRequisition.Find('-') then begin

            HRTravellingStaff.Reset;
            HRTravellingStaff.SetRange(HRTravellingStaff."Employee No", "Employee Number");
            HRTravellingStaff.SetRange(HRTravellingStaff."Req No", "Requisition No");

            if HRTravellingStaff.FindSet then
                Error('This staff member already exists for this ticket');

            HRTravellingStaff.Reset;
            HRTravellingStaff.Init;
            /*  "Employee Card".SETRANGE("Employee Card"."No.","Employee Number");

                 IF "Employee Card".FIND('-')
                 THEN
                   BEGIN
                      HRTravellingStaff."Employee Name":="Employee Card"."Names";
                      HRTravellingStaff.Position:="Employee Card"."Job Title";
                 END;
           */
            HRTravellingStaff."Req No" := "Requisition No";
            HRTravellingStaff."Employee No" := "Employee Number";
            HRTravellingStaff.Validate(HRTravellingStaff."Employee No");
            HRTravellingStaff.Insert(true);
        end
        else begin
            Error('You can only add staff to an open ticket');
        end;

    end;


    procedure HRTravellingStaffRemove("Entry Number": Integer)
    begin
        HRTravellingStaff.Reset;
        HRTravellingStaff.SetRange(HRTravellingStaff.EntryNo, "Entry Number");
        if HRTravellingStaff.FindSet then
            HRTravellingStaff.Delete;
    end;


    procedure DetermineIfIsNonWorking(var bcDate: Date; var "Leave Type": Text) ItsNonWorking: Boolean
    var
        dates: Record Date;
    begin
        Clear(ItsNonWorking);
        GeneralOptions.Find('-');
        //One off Hollidays like Good Friday
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar.Date, bcDate);
        if BaseCalendar.Find('-') then begin
            if BaseCalendar.Nonworking = true then
                ItsNonWorking := true;
        end;

        // For Annual Holidays
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."recurring system"::"Annual Recurring");
        if BaseCalendar.Find('-') then begin
            repeat
                if ((Date2dmy(bcDate, 1) = BaseCalendar."Date Day") and (Date2dmy(bcDate, 2) = BaseCalendar."Date Month")) then begin
                    if BaseCalendar.Nonworking = true then
                        ItsNonWorking := true;
                end;
            until BaseCalendar.Next = 0;
        end;

        if ItsNonWorking = false then begin
            // Check if its a weekend
            dates.Reset;
            dates.SetRange(dates."Period Type", dates."period type"::Date);
            dates.SetRange(dates."Period Start", bcDate);
            if dates.Find('-') then begin
                //if date is a sunday
                if dates."Period Name" = 'Sunday' then begin
                    //check if Leave includes sunday
                    ltype.Reset;
                    ltype.SetRange(ltype.Code, "Leave Type");
                    if ltype.Find('-') then begin
                        if ltype."Inclusive of Sunday" = false then ItsNonWorking := true;
                    end;
                end else
                    if dates."Period Name" = 'Saturday' then begin
                        //check if Leave includes sato
                        ltype.Reset;
                        ltype.SetRange(ltype.Code, "Leave Type");
                        if ltype.Find('-') then begin
                            if ltype."Inclusive of Saturday" = false then ItsNonWorking := true;
                        end;
                    end;

            end;
        end;
    end;


    procedure DetermineLeaveReturnDate(fBeginDate: Date; fDays: Decimal; "Leave Type": Text) fReturnDate: Date
    var
        ltype: Record "HRM-Leave Types";
    begin
        ltype.Reset;
        if ltype.Get("Leave Type") then begin
        end;
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
            if DetermineIfIncludesNonWorking("Leave Type") = false then begin
                fReturnDate := CalcDate('1D', fReturnDate);
                if DetermineIfIsNonWorking(fReturnDate, "Leave Type") then begin
                    varDaysApplied := varDaysApplied + 1;
                end else
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied + 1
            end
            else begin
                fReturnDate := CalcDate('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            end;
        until varDaysApplied = 0;
        exit(fReturnDate);
    end;


    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Text): Boolean
    begin
        if LeaveTypes.Get(fLeaveCode) then begin
            if LeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
        end;
    end;


    procedure CalcEndDate(SDate: Date; LDays: Integer; "Leave Type": Text) LEndDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        ltype: Record "HRM-Leave Types";
    begin
        /* ltype.RESET;
          IF ltype.GET("Leave Type") THEN BEGIN
          END;
           SDate:=SDate-1;
           EndLeave:=FALSE;
           WHILE EndLeave=FALSE DO BEGIN
           IF NOT DetermineIfIsNonWorking(SDate,"Leave Type") THEN
           DayCount:=DayCount+1;
           SDate:=SDate+1;
           IF DayCount>LDays THEN
           EndLeave:=TRUE;
           END;
           LEndDate:=SDate-1;
        
        WHILE DetermineIfIsNonWorking(LEndDate,"Leave Type")=TRUE DO
        BEGIN
        LEndDate:=LEndDate+1;
        END;*/   //Removed by JK


        SDate := SDate;
        EndLeave := false;
        DayCount := 1;
        while EndLeave = false do begin
            if not DetermineIfIsNonWorking(SDate, "Leave Type") then
                DayCount := DayCount + 1;
            SDate := SDate + 1;
            if DayCount > LDays then
                EndLeave := true;
        end;
        LEndDate := SDate - 1;

        while DetermineIfIsNonWorking(LEndDate, "Leave Type") = true do begin
            LEndDate := LEndDate + 1;
        end;

    end;


    procedure CalcReturnDate(EndDate: Date; "Leave Type": Text) RDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        LEndDate: Date;
        ltype: Record "HRM-Leave Types";
    begin
        if ltype.Get("Leave Type") then begin
        end;
        RDate := EndDate + 1;
        while DetermineIfIsNonWorking(RDate, "Leave Type") = true do begin
            RDate := RDate + 1;
        end;
    end;


    procedure ValidateStartDate("Starting Date": Date)
    begin
        dates.Reset;
        dates.SetRange(dates."Period Start", "Starting Date");
        dates.SetFilter(dates."Period Type", '=%1', dates."period type"::Date);
        if dates.Find('-') then
            if ((dates."Period Name" = 'Sunday') or (dates."Period Name" = 'Saturday')) then begin
                if (dates."Period Name" = 'Sunday') then
                    Error('You can not start your leave on a Sunday')
                else if (dates."Period Name" = 'Saturday') then Error('You can not start your leave on a Saturday')
            end;

        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar.Date, "Starting Date");
        if BaseCalendar.Find('-') then begin
            repeat
                if BaseCalendar.Nonworking = true then begin
                    if BaseCalendar.Description <> '' then
                        Error('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                    else
                        Error('You can not start your Leave on a Holiday');
                end;
            until BaseCalendar.Next = 0;
        end;

        // For Annual Holidays
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."recurring system"::"Annual Recurring");
        if BaseCalendar.Find('-') then begin
            repeat
                if ((Date2dmy("Starting Date", 1) = BaseCalendar."Date Day") and (Date2dmy("Starting Date", 2) = BaseCalendar."Date Month")) then begin
                    if BaseCalendar.Nonworking = true then begin
                        if BaseCalendar.Description <> '' then
                            Error('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                        else
                            Error('You can not start your Leave on a Holiday');
                    end;
                end;
            until BaseCalendar.Next = 0;
        end;
    end;


    procedure HRCancelLeaveApplication(LeaveApplicationNo: Text)
    begin
        "HR Leave Application".Reset;
        "HR Leave Application".SetRange("HR Leave Application"."No.", LeaveApplicationNo);

        if "HR Leave Application".Find('-') then begin
            "HR Leave Application".Status := HRLeave.Status::Cancelled;
            "HR Leave Application".Modify;
        end;


        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", LeaveApplicationNo);

        if ApprovalEntry.Find('-') then begin
            repeat
                ApprovalEntry.Status := ApprovalEntry_2.Status::Canceled;
                ApprovalEntry.Modify;
            until ApprovalEntry.Next = 0
        end;
    end;


    procedure GeneratePaySlipReport(EmployeeNo: Text; Period: Date; filenameFromApp: Text) filename: Text[100]
    var
        "prSalary Card": record "PRL-Salary Card";
        HrmEmployeeC: record "HRM-Employee C";
    begin
        filename := FILESPATH_S + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        //MESSAGE('OK');
        SalaryCard.Reset;
        SalaryCard.SetRange(SalaryCard."Employee Code", EmployeeNo);
        SalaryCard.SetRange(SalaryCard."Payroll Period", Period);
        if SalaryCard.Find('-') then begin
            Report.SaveAsPdf(report::"Individual Payslips 2", filename, SalaryCard);   //52017726
        end;
        exit(filename);
    end;


    procedure Generate13thPaySlipReport(EmployeeNo: Text; Period: Date; filenameFromApp: Text) filename: Text[100]
    var
        "prSalary Card": Record "PRL-Salary Card";
        PRl13thSlipDaysComp: Record "PRl 13thSlip DaysComp";
    begin
        filename := FILESPATH_S + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        //MESSAGE('OK');
        PRl13thSlipDaysComp.Reset;
        PRl13thSlipDaysComp.SetRange(PRl13thSlipDaysComp."Employee Code", EmployeeNo);
        PRl13thSlipDaysComp.SetRange(PRl13thSlipDaysComp."Payroll Period", Period);

        if PRl13thSlipDaysComp.Find('-') then begin
            Report.SaveAsPdf(77710, filename, PRl13thSlipDaysComp);
        end;
        exit(filename);
    end;


    procedure GenerateStudentStatement("Student No": Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        Customer.Reset;
        Customer.SetRange(Customer."No.", "Student No");

        if Customer.Find('-') then begin
            Report.SaveAsPdf(report::"Student Fee Statement 2", filename, Customer);
        end;
    end;


    procedure GenerateStudentProformaInvoice("Programme Code": Text; "Stage Code": Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        "Fee By Stage".Reset;
        "Fee By Stage".SetRange("Fee By Stage"."Programme Code", "Programme Code");
        "Fee By Stage".SetRange("Fee By Stage"."Stage Code", "Stage Code");

        if "Fee By Stage".Find('-') then begin
            Report.SaveAsPdf(Report::"Student Proforma Invoice", filename, "Fee By Stage");
        end;
    end;


    procedure GenerateSpecialExamCard(StudentNo: Text; filenameFromApp: Text): Text
    var
        filename: Text;
        Customer: Record Customer;
        ACACourseRegistrationz1: Record "ACA-Course Registration";
        ACALecturersEvaluation: Record "ACA-Lecturers Evaluation";
        StudUnits: Record "ACA-Student Units";
    begin
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        CourseRegistration.Reset;
        CourseRegistration.SetRange(CourseRegistration."Student No.", StudentNo);
        //CourseRegistration.SETRANGE(CourseRegistration.Semester,Sem);
        CourseRegistration.SetRange(CourseRegistration.Reversed, false);
        //CourseRegistration.SETRANGE(CourseRegistration.Posted,FALSE);
        CourseRegistration.SetCurrentkey(Stage);
        if CourseRegistration.Find('+') then begin
            Report.SaveAsPdf(Report::"Special Exam Card", filename, CourseRegistration);
            // // Report.RUN(Report::"Exam Card Final",TRUE,FALSE,CourseRegistration);TODO
        end;
    end;


    procedure GenerateSuppExamCard(StudentNo: Text; filenameFromApp: Text): Text
    var
        filename: Text;
        Customer: Record Customer;
        ACACourseRegistrationz1: Record "ACA-Course Registration";
        ACALecturersEvaluation: Record "ACA-Lecturers Evaluation";
        StudUnits: Record "ACA-Student Units";
    begin
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        CourseRegistration.Reset;
        CourseRegistration.SetRange(CourseRegistration."Student No.", StudentNo);
        //CourseRegistration.SETRANGE(CourseRegistration.Semester,Sem);
        CourseRegistration.SetRange(CourseRegistration.Reversed, false);
        //CourseRegistration.SETRANGE(CourseRegistration.Posted,FALSE);
        CourseRegistration.SetCurrentkey(Stage);
        if CourseRegistration.FindSet then begin
            Report.SaveAsPdf(Report::"Supp. Exam Card", filename, CourseRegistration);
            // // Report.RUN(Report::"Exam Card Final",TRUE,FALSE,CourseRegistration);TODO
        end;
    end;

    procedure checkClassAttendanceMet(studNO: Code[25]; semester: code[25]; unit: code[25]): Boolean
    var
        ClassAtt: Record "Class Attendance Details";
        MinPerce: Decimal;
        CurrPerc: Decimal;
        TotalClasses: Integer;
        AttendedClasses: Integer;
    begin
        GenSetup.GET;
        MinPerce := GenSetup."Min Class Attendance %";
        ClassAtt.Reset();
        ClassAtt.SETRANGE("Student No.", studNO);
        ClassAtt.SETRANGE("Semester", semester);
        ClassAtt.SetRange("Unit Code", unit);
        if ClassAtt.FindFirst() then begin
            ClassAtt.CalcFields("Total Classes", "Present Counting");
            CurrPerc := (ClassAtt."Present Counting" / ClassAtt."Total Classes") * 100;
            if CurrPerc < MinPerce then exit(false);
        end else
            exit(false);
        exit(true);
    end;

    procedure GenerateStudentExamCard(StudentNo: Text; Sem: Text; filenameFromApp: Text): Text
    var
        filename: Text;
        Customer: Record Customer;
        ACACourseRegistrationz1: Record "ACA-Course Registration";
        ACALecturersEvaluation: Record "ACA-Lecturers Evaluation";
        StudUnits: Record "ACA-Student Units";
        FundingBands: record "Funding Band Entries";
        NFMStatement: Record "NFM Statement Entry";
    begin
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        //Sem:='SEM2 19/20';

        ACACourseRegistrationz1.Reset;
        ACACourseRegistrationz1.SetRange("Student No.", StudentNo);
        ACACourseRegistrationz1.SetRange(Reversed, false);
        ACACourseRegistrationz1.SetRange(Semester, Sem);
        if not ACACourseRegistrationz1.Find('-') then Error('No semester Registration found');
        // ACACourseRegistrationz1.CALCFIELDS("Exists Unevaluated");
        // IF  ACACourseRegistrationz1."Exists Unevaluated" THEN ERROR('Please do your lecturer evaluation before downloading the Card.....1');
        ACACourseRegistrationz1.CalcFields("Total Billed");
        //////////////////
        // Evaluation

        StudUnits.Reset;
        //// STUDUNITS.SETRANGE(STUDUNITS.PROGRAMME,ACACOURSEREGISTRATIONZ1.PROGRAMME);
        StudentUnits.SetRange(Semester, Sem);
        StudentUnits.SetRange("Student No.", StudentNo);
        StudentUnits.SetFilter("Course Evaluated", '%1', false);
        StudentUnits.SetFilter("Exempted in Evaluation", '%1', false);
        StudentUnits.SetFilter(Unit, '<>%1', '');
        if StudentUnits.Find('-') then Error('YOU HAVE NOT EVALUATED ALL COURSES FOR ' + Sem);

        // StudUnits.Reset;
        // StudUnits.SetRange(Semester, Sem);
        // StudUnits.SetRange("Student No.", StudentNo);
        // StudUnits.SetFilter(Unit, '<>%1', '');
        // if StudUnits.Findset then begin
        //     repeat
        //         if not checkClassAttendanceMet(StudentNo, Sem, StudUnits.unit) then error('You did not attend the required number of classes for unit ' + StudUnits.unit)
        //     until StudUnits.next = 0;
        // end;



        ////////////////////

        //ACALecturersEvaluation.Reset;
        //ACALecturersEvaluation.SetRange("Student No", StudentNo);
        //ACALecturersEvaluation.SetRange(Semester, Sem);
        //if not ACALecturersEvaluation.Find('-') then Error('Please do your lecturer evaluation before downloading the Card....2');



        // // // Customer.RESET;
        // // // Customer.SETRANGE("No.",StudentNo);
        // // // IF Customer.FIND('-') THEN BEGIN
        // // //    Customer.CALCFIELDS(Balance);
        // // //   IF (Customer.Balance>ACACourseRegistrationz1."Total Billed") THEN ERROR('Fee Policy not met!');
        // // //      END ELSE ERROR('Invalid Student');
        /////////////////////////////////////////////////////////////
        Customer.Reset;
        Customer.SetRange("No.", StudentNo);
        if Customer.Find('-') then Customer.CalcFields(Balance);
        CourseReg.Reset;
        CourseReg.SetRange("Student No.", StudentNo);
        CourseReg.SetRange(Semester, Sem);
        CourseReg.SetRange(Reversed, false);
        if CourseReg.Find('+') then begin
            CourseReg.CalcFields("Total Billed");
            coreg.Reset;
            coreg.SetRange("Student No.", StudentNo);
            coreg.SetRange(Semester, Sem);
            coreg.SetRange(Reversed, false);
            if coreg.Find('-') then begin
                FundingBands.RESET;
                FundingBands.SETRANGE("Student No.", StudentNo);
                IF FundingBands.FIND('-') THEN BEGIN
                    Customer.RESET;
                    Customer.SETRANGE(Customer."No.", StudentNo);
                    IF Customer.FIND('-') THEN BEGIN
                        REPORT.RUN(78095, FALSE, FALSE, Customer);
                        COMMIT();
                        NFMStatement.RESET;
                        NFMStatement.SETRANGE("Student No.", StudentNo);
                        IF NFMStatement.FINDSET THEN BEGIN
                            NFMStatement.CALCFIELDS(Balance);
                            IF NFMStatement.Balance > 0 THEN ERROR('Fee policy Not met!');
                        END;
                    END;
                END ELSE
                    if Customer.Balance > 0 then Error('Fee policy Not met!');

            end else
                Error('No registration for found');
        end else
            Error('No registration for found');
        /////////////////////////////////////////////////////////////
        CourseRegistration.Reset;
        CourseRegistration.SetRange(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SetRange(CourseRegistration.Semester, Sem);
        CourseRegistration.SetRange(Reversed, false);
        if CourseRegistration.FindFirst then begin
            Report.SaveAsPdf(Report::"Exam Card Final", filename, CourseRegistration);
            // // Report.RUN(Report::"Exam Card Final",TRUE,FALSE,CourseRegistration);TODO
        end;
    end;

    procedure CheckStudentFeePolicyMetForUnitRegistration(StudentNo: code[25]; Semester: code[25]): Boolean
    var
        FundingBands: record "Funding Band Entries";
        NFMStatement: Record "NFM Statement Entry";
        GenSetup: Record "ACA-General Set-Up";
        FeePolicyPerc: Decimal;
        SemFees: Decimal;
        CurrPerc: Decimal;
    begin
        GenSetup.Get();
        FeePolicyPerc := GenSetup."Unit Reg. Fee Policy";
        coreg.Reset;
        coreg.SetRange("Student No.", StudentNo);
        coreg.SetRange(Semester, Semester);
        coreg.SetRange(Reversed, false);
        if coreg.Find('-') then begin
            coreg.CalcFields("Total Billed");
            SemFees := coreg."Total Billed";
            FundingBands.RESET;
            FundingBands.SETRANGE("Student No.", StudentNo);
            IF FundingBands.FIND('-') THEN BEGIN
                Customer.RESET;
                Customer.SETRANGE(Customer."No.", StudentNo);
                IF Customer.FIND('-') THEN BEGIN
                    REPORT.RUN(78095, FALSE, FALSE, Customer);
                    COMMIT();
                    NFMStatement.RESET;
                    NFMStatement.SETRANGE("Student No.", StudentNo);
                    IF NFMStatement.FINDSET THEN BEGIN
                        NFMStatement.CALCFIELDS(Balance);
                        CurrPerc := Round(((NFMStatement.Balance / SemFees) * 100), 0.5, '=');
                        if CurrPerc > FeePolicyPerc then exit(false);
                    END;
                END;
            END ELSE begin
                CurrPerc := Round(((Customer.Balance / SemFees) * 100), 0.5, '=');
                if CurrPerc > FeePolicyPerc then exit(false);
            end;

        end else
            exit(false);
        exit(true);
    end;

    procedure getSemesterFees(StudentNo: code[25]; Semester: code[25]): Decimal
    var

    begin
        coreg.Reset;
        coreg.SetRange("Student No.", StudentNo);
        coreg.SetRange(Semester, Semester);
        coreg.SetRange(Reversed, false);
        if coreg.Find('-') then begin
            coreg.CalcFields("Total Billed");
            exit(coreg."Total Billed");
        end else
            exit(0);
    end;

    procedure GenerateStudentProvisionalResults(StudentNo: Text[20]; filenameFromApp: Text[150]; sem: Text[20]) ReturnMessage: Text[250]
    var
        filename: Text;
        ACASemesters: Record "ACA-Semesters";
    begin
        Clear(ReturnMessage);
        ReturnMessage := CourseRegistration."Student No." + ' - ' + sem;
        ACASemesters.Reset;
        ACASemesters.SetRange(Code, sem);
        if ACASemesters.Find('-') then begin
            if ACASemesters."Released Results" then begin
            end else
                Error('Access Denied!');
        end else
            Error('Invalid Semester');
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        CourseRegistration.Reset;
        CourseRegistration.SetRange(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SetRange(CourseRegistration.Semester, sem);

        if CourseRegistration.Find('-') then begin
            Report.SaveAsPdf(report::"Official University Resultslip", filename, CourseRegistration);
            ///REPORT.RUN(51797,TRUE,FALSE,CourseRegistration);
        end;
    end;


    procedure MealBookingCreate(BookingDate: Date; BookingTime: Time; RequiredTime: Time; MeetingName: Text; Venue: Text; Pax: Decimal; BookingType: Option; "Employee No": Text; BreakFast: Boolean; TenOClockTea: Boolean; NormalLunch: Boolean; Water: Boolean; FourOClockTea: Boolean) LastBookingInsert: Text
    var
        NextMealBookingNo: Text;
        StrBookingDates: Text;
        StrBookingInts: Text;
        StrMealOptions: Text;
        StrDrinks: Text;
    begin
        MealBookingHeader.Init;
        NextMealBookingNo := NoSeriesMgt.GetNextNo('MEAL BOOKI', 0D, true);
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", "Employee No");


        if "Employee Card".Find('-')
        then begin
            MealBookingHeader."Booking Id" := NextMealBookingNo;
            MealBookingHeader.Department := "Employee Card"."Department Code";
            MealBookingHeader."Request Date" := BookingDate;
            MealBookingHeader."Booking Date" := BookingDate;
            MealBookingHeader."Meeting Name" := MeetingName;
            MealBookingHeader."Required Time" := RequiredTime;
            MealBookingHeader.Venue := Venue;
            MealBookingHeader.Pax := Pax;
            //MealBookingHeader."Booking Type":=BookingType;
            MealBookingHeader."Booking Time" := BookingTime;
            MealBookingHeader."No. Series" := 'MEAL BOOKI';

            //MealBookingHeader.BreakFast:=BreakFast;
            //MealBookingHeader."10 Oclock Tea":=TenOClockTea;
            //MealBookingHeader."Normal Lunch":=NormalLunch;
            /* MealBookingHeader."Vegeterian Lunch":=VegeterianLunch; */
            // MealBookingHeader.Water:=Water;
            /* MealBookingHeader.Bolied:= */
            // MealBookingHeader."4 Oclock Tea":=FourOClockTea;

            MealBookingHeader."Requested By" := "Employee Card"."User ID";
            MealBookingHeader.Status := 0;
            MealBookingHeader.Insert;

            MealBookingHeader.Reset;
            MealBookingHeader.SetRange(MealBookingHeader."Requested By", "Employee Card"."User ID");
            if MealBookingHeader.FindLast
            then
                StrBookingDates := Format(MealBookingHeader."Required Time") + '::' + Format(MealBookingHeader."Booking Date") + '::' + Format(MealBookingHeader."Booking Time");
            //StrBookingInts:=FORMAT(MealBookingHeader."Booking Type");
            //StrMealOptions:=FORMAT(MealBookingHeader.BreakFast)+'::'+FORMAT(MealBookingHeader."Normal Lunch");
            //StrDrinks:=FORMAT(MealBookingHeader."10 Oclock Tea")+'::'+FORMAT(MealBookingHeader.Water)+'::'+FORMAT(MealBookingHeader."4 Oclock Tea");

            LastBookingInsert := MealBookingHeader."Booking Id" + '::' + StrBookingInts + '::' + MealBookingHeader."Meeting Name" + '::' + MealBookingHeader.Venue + '::' + StrBookingDates + '::' + Format(MealBookingHeader.Pax) + '::' + StrMealOptions + '::' + StrDrinks;

        end

    end;


    procedure MealBookingLineCreate(MealBookingID: Text; MealCode: Text; Quantity: Decimal; UnitPrice: Decimal; Cost: Decimal)
    begin
        MealBookingLines.Reset;
        MealBookingLines.Init;
        MealBookingLines."Booking Id" := MealBookingID;
        MealBookingLines."Meal Code" := MealCode;
        MealBookingLines.Quantity := Quantity;
        MealBookingLines."Unit Price" := UnitPrice;
        MealBookingLines.Cost := Cost;
        MealBookingLines.Insert;
    end;


    procedure MealBookingLineDelete(LineNo: Integer)
    begin
        MealBookingLines.Reset;
        MealBookingLines.SetRange(MealBookingLines."Line No.", LineNo);
        if MealBookingLines.Find('-') then begin
            MealBookingLines.Delete;
            Message('Meal Item Deleted Successfully');
        end;
    end;


    procedure MealBookingLineUpdate(LineNo: Integer; Quantity: Decimal)
    begin
        MealBookingLines.Reset;
        MealBookingLines.SetRange(MealBookingLines."Line No.", LineNo);
        if MealBookingLines.Find('-') then begin
            //MealBookingLines."Meal Code":=MealCode;
            MealBookingLines.Quantity := Quantity;
            MealBookingLines.Validate(MealBookingLines."Meal Code");
            //MealBookingLines."Unit Price":=UnitPrice;
            //MealBookingLines.Cost:=Cost;
            MealBookingLines.Modify;
            Message('Meal Item Updated Successfully');
        end;
    end;


    procedure MealBookingApprovalRequest(ReqNo: Text)
    var
        ApprovalMgt: Codeunit "Approval Workflows V1";
        showmessage: Boolean;
        ManualCancel: Boolean;
        State: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        tableNo: Integer;
        RespCenter: Text[10];
        variant: Variant;
    begin
        MealBookingHeader.Reset;
        MealBookingHeader.SetRange(MealBookingHeader."Booking Id", ReqNo);
        if MealBookingHeader.Find('-') then begin
            MealBookingHeader.TestField(Department);
            MealBookingHeader.TestField("Request Date");
            MealBookingHeader.TestField("Booking Date");
            MealBookingHeader.TestField("Meeting Name");
            MealBookingHeader.TestField("Required Time");
            MealBookingHeader.TestField(Venue);
            MealBookingHeader.TestField("Contact Person");
            MealBookingHeader.TestField("Contact Number");
            MealBookingHeader.TestField(Pax);

            // IF "Availlable Days"<1 THEN ERROR('Please note that you dont have enough leave balance');

            //Release the Bookingfor Approval
            State := State::Open;
            if MealBookingHeader.Status <> MealBookingHeader.Status::New then State := State::"Pending Approval";
            DocType := Doctype::"Meals Bookings";
            Clear(tableNo);
            tableNo := 61778;
            Clear(RespCenter);
            variant := MealBookingHeader;
            if ApprovalMgt.CheckApprovalsWorkflowEnabled(variant) then
                ApprovalMgt.OnSendDocForApproval(variant);
            //ApprovalMgt.OnSendMealBookingforApproval(MealBookingHeader);
            //  IF ApprovalMgt.SendLeaveApprovalRequest(Rec) THEN;
            //  AppMgt.SendMealsApprovalRequest(MealBookingHeader);
        end;
    end;


    procedure ApproveDocument(DocumentNo: Text; ApproverID: Text)
    var

    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocumentNo);
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", ApproverID);

        if ApprovalEntry.Find('-') then begin

            repeat
            // if not ApprovalSetup.Get then
            //     Error(Text004);

            // AppMgt.ApproveApprovalRequest(ApprovalEntry); TODO

            until ApprovalEntry.Next = 0;
        end;
    end;


    procedure RejectDocument(DocumentNo: Text; ApproverID: Text)
    var
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Farmer Application",Vehicle_Reg,"Medical Claim";
    begin
        Clear(ApprovalEntry);
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocumentNo);
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", ApproverID);

        // IF ApprovalEntry.FIND('-') THEN BEGIN
        //    REPEAT
        //        IF NOT ApprovalSetup.GET THEN
        //          ERROR(Text004);
        //TODO
        //AppMgt.CancelApproval(61125, Doctype::"Leave Application", DocumentNo, true, true);// RejectApprovalRequest(ApprovalEntry);

        // UNTIL ApprovalEntry.NEXT = 0;
    end;


    procedure CancelDocument(DocumentNo: Text; SenderID: Text)
    begin
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocumentNo);
        ApprovalEntry.SetRange(ApprovalEntry."Sender ID", SenderID);
        // //
        // // IF ApprovalEntry.FIND('-') THEN
        // //    REPEAT
        // //      //AppMgt.CancelMealsApprovalRequest(ApprovalEntry);
        // //    UNTIL ApprovalEntry.NEXT = 0;TODO
        //  AppMgt.CancelApproval(61125, Doctype::"Leave Application", DocumentNo, true, true);
    end;


    procedure fxSendLeaveForApproval(LeaveNo: Text)
    var
        WebUser: Text[20];
    begin
        "HR Leave Application".Reset;
        Message(LeaveNo);
        "HR Leave Application".SetRange("HR Leave Application"."No.", LeaveNo);
        if "HR Leave Application".Find('-')
        then begin
            WebUser := "HR Leave Application"."User ID";
            Message(WebUser);
            //AppMgt.SendLeaveApprovalRequest("HR Leave Application");
            Message('OK3');

        end;
    end;


    procedure TransportRequisitionApprovalRequest(ReqNo: Text)
    var
        AppRVMgt: Codeunit "iNIT cODEUNIT";
    begin
        TransportRequisition.Reset;
        TransportRequisition.SetRange(TransportRequisition."Transport Requisition No", ReqNo);
        if TransportRequisition.Find('-')
        then begin
            AppRVMgt.OnSendTransportReqforApproval(TransportRequisition);
        end;
    end;


    procedure AvailableLeaveDays(EmployeeNo: Text; LeaveType: Text) availabledays: Text
    var
        daysInteger: Integer;
    begin
        Clear(availabledays);
        Clear(daysInteger);
        LeaveLE.Reset;
        LeaveLE.SetRange(LeaveLE."Employee No", EmployeeNo);
        //LeaveLE.SETRANGE(LeaveLE."Leave Type",LeaveType);
        //LeaveLE.SETRANGE(LeaveLE."Leave Period",Year);
        if LeaveLE.Find('-') then
            repeat
            begin
                daysInteger := daysInteger + LeaveLE."No. of Days"
                // availabledays:=FORMAT(LeaveLE."No. of Days");
            end;
            until LeaveLE.Next = 0;
        availabledays := Format(daysInteger);
    end;


    procedure SubmitAdmissionAttachment(Indexno: Code[20]; DocCode: Code[50]; Base64Image: BigText) Submitted: Boolean
    var
        ToFile: Text;
        IStream: InStream;
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        OStream: OutStream;
    begin
        StudentDocs.Reset;
        StudentDocs.SetRange("Index Number", GetIndexNo(Indexno));
        StudentDocs.SetRange("Document Code", DocCode);
        if StudentDocs.Find('-') then begin
            Bytes := Convert.FromBase64String(Base64Image);
            MemoryStream := MemoryStream.MemoryStream(Bytes);
            StudentDocs.Document_Image.CreateOutstream(OStream);
            MemoryStream.WriteTo(OStream);
            StudentDocs.Modify;
            Submitted := true;
        end;
    end;


    procedure GetProfilePicture(StaffNo: Text) BaseImage: Text
    var
        ToFile: Text;
        IStream: InStream;
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
    begin
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", StaffNo);

        if "Employee Card".Find('-') then begin
            if "Employee Card".Picture.Hasvalue then begin
                "Employee Card".CalcFields(Picture);
                "Employee Card".Picture.CreateInstream(IStream);
                MemoryStream := MemoryStream.MemoryStream();
                CopyStream(MemoryStream, IStream);
                Bytes := MemoryStream.GetBuffer();
                BaseImage := Convert.ToBase64String(Bytes);
            end;
        end;
    end;


    procedure GetDocAttachment(index: Code[20]; doctype: Code[50]) BaseImage: Text
    var
        ToFile: Text;
        IStream: InStream;
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        bs64img: Text;
    begin
        StudentDocs.Reset;
        StudentDocs.SetRange("Index Number", index);
        StudentDocs.SetRange("Document Code", doctype);
        if StudentDocs.Find('-') then begin
            if StudentDocs.Document_Image.Hasvalue then begin
                StudentDocs.CalcFields(Document_Image);
                StudentDocs.Document_Image.CreateInstream(IStream);
                MemoryStream := MemoryStream.MemoryStream();
                CopyStream(MemoryStream, IStream);
                Bytes := MemoryStream.GetBuffer();
                bs64img := Convert.ToBase64String(Bytes);
                BaseImage := bs64img;
            end;
        end;
    end;





    procedure GetProfilePictureStudent(StudentNo: Text) BaseImage: Text
    var
        ToFile: Text;
        IStream: InStream;
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", StudentNo);

        if Customer.Find('-') then begin
            if Customer.Image.Hasvalue then begin
                //Customer.CalcFields(Picture);
                //Customer.Image.CreateInstream(IStream);TODO
                MemoryStream := MemoryStream.MemoryStream();
                CopyStream(MemoryStream, IStream);
                Bytes := MemoryStream.GetBuffer();
                BaseImage := Convert.ToBase64String(Bytes);
            end;
        end;
    end;


    procedure ExamResultsCreate(StudentNo: Text; Prog: Text; Stage: Text; Sem: Text; Unit: Text; Score: Integer; ExamType: Text; AcademicYear: Text; RegistrationType: Option)
    begin
        ExamResults.Init;
        ExamResults."Student No." := StudentNo;
        ExamResults.Programmes := Prog;
        ExamResults.Stage := Stage;
        ExamResults.Unit := Unit;
        ExamResults.Semester := Sem;
        ExamResults.Score := Score;
        ExamResults.ExamType := ExamType;
        ExamResults."Academic Year" := AcademicYear;
        //ExamResults."Registration Type":=RegistrationType;
        ExamResults.Insert;
    end;


    procedure StaffLogin(Username: Text; UserPassword: Text) Message: Text
    var
        TXTIncorrectDetails: label 'Incorrect Username or Password';
        TXTCorrectDetails: label 'Login';
        FullNames: Text;
    begin
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", Username);
        if "Employee Card".Find('-') then begin
            if ("Employee Card"."Changed Password" = true) then begin
                if ("Employee Card"."Portal Password" = UserPassword) then begin
                    FullNames := "Employee Card"."First Name" + ' ' + "Employee Card"."Middle Name" + ' ' + "Employee Card"."Last Name";
                    Message := TXTCorrectDetails + '::' + Format("Employee Card"."Changed Password") + '::' + "Employee Card"."No." + '::' + "Employee Card"."User ID" + '::' + FullNames;
                end else begin
                    Message := TXTIncorrectDetails + '::' + Format("Employee Card"."Changed Password");
                end
            end else begin
                if ("Employee Card"."ID Number" = UserPassword) then begin
                    Message := TXTCorrectDetails + '::' + Format("Employee Card"."Changed Password") + '::' + "Employee Card"."No." + '::' + "Employee Card"."User ID" + '::' + FullNames;
                end else begin
                    Message := TXTIncorrectDetails + '::' + Format("Employee Card"."Changed Password");
                end
            end
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;

    procedure VerifyOldPassword(username: Text; oldPassword: Text) msg: Boolean
    begin
        "Employee Card".Reset;
        "Employee Card".SetRange("No.", username);
        "Employee Card".SetRange("Portal Password", oldPassword);
        if "Employee Card".Find('-') then begin
            msg := true;
        end;
    end;

    procedure ChangeStaffPassword(username: Text; newPassword: Text) msg: Boolean
    begin
        "Employee Card".Reset;
        "Employee Card".SetRange("No.", username);
        if "Employee Card".Find('-') then begin
            "Employee Card"."Portal Password" := newPassword;
            "Employee Card".Modify;
            msg := true;
        end;
    end;

    procedure GetUserID(EmployeeNo: Code[10]) msg: Text
    begin
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", EmployeeNo);
        if "Employee Card".Find('-')
        then begin
            msg := "Employee Card"."User ID";
        end
    end;


    procedure GetFullName(EmployeeNo: Text)
    begin
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", EmployeeNo);

        if "Employee Card".Find('-')
        then begin
            Message("Employee Card".FullName);
        end
    end;


    procedure InsertApproverComments(DocumentNo: Code[50]; ApproverID: Code[100]; Comments: Text[250])
    begin
        ApproverComments.Reset;

        ApproverComments."Document No." := DocumentNo;
        ApproverComments."User ID" := ApproverID;
        ApproverComments.Comment := Comments;
        ApproverComments."Date and Time" := CurrentDatetime;

        ApproverComments.Insert(true);
    end;


    procedure Generatep9Report(SelectedPeriod: Integer; EmployeeNo: Text; filenameFromApp: Text) filename: Text[100]
    begin
        filename := FILESPATH_S + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Period Year", SelectedPeriod);
        if objPeriod.Find('-') then;

        PRLEmployeeP9Info.Reset;
        PRLEmployeeP9Info.SetRange(PRLEmployeeP9Info."Employee Code", EmployeeNo);
        PRLEmployeeP9Info.SetRange(PRLEmployeeP9Info."Period Year", objPeriod."Period Year");
        if PRLEmployeeP9Info.Find('-') then
            Report.SaveAsPdf(Report::"P9 Report (Final)", filename, PRLEmployeeP9Info);
        //REPORT.SAVEASPDF(51746,filename,P9);   //52017726
        // END;
        exit(filename);
    end;


    procedure StoreRequisitionApprovalRequest(ReqNo: Text)
    var
        ApprovalMngt: Codeunit "Approval Workflows V1";
        variant: Variant;
    begin
        StoreRequisition.Reset;
        StoreRequisition.SetRange(StoreRequisition."No.", ReqNo);
        if StoreRequisition.Find('-')
        then begin
            variant := StoreRequisition;
            if ApprovalMngt.CheckApprovalsWorkflowEnabled(variant) then
                ApprovalMngt.OnSendDocForApproval(variant);
        end;
    end;


    procedure ImprestRequisitionApprovalRequest(ReqNo: Text)
    var
        State: Option;
        DocType: Option;
        tableNo: Integer;
        AppRMgt: codeunit "Init Code";
    begin
        ImprestRequisition.Reset;
        ImprestRequisition.SetRange(ImprestRequisition."No.", ReqNo);
        if ImprestRequisition.Find('-')
        then begin
            AppRMgt.OnSendImprestforApproval(ImprestRequisition);
        end;
    end;


    procedure PreRegisterStudents2(studentNo: Text; stage: Text; semester: Text; Programme: Text; AcademicYear: Text; settlementType: Text; ProgrammeOption: Code[20]) CourseRegId: Code[30]
    var
        Progs: Code[20];
        stagez: Code[20];
        semesterz: Code[20];
    begin
        stagez := stage;
        semesterz := semester;
        GenSetup.Get;
        Clear(Progs);
        Progs := Programme;
        Clear(CourseReg);
        CourseReg.Reset;
        CourseReg.SetRange(CourseReg."Student No.", studentNo);
        CourseReg.SetRange(CourseReg.Programmes, Progs);
        CourseReg.SetRange(CourseReg.Semester, semesterz);
        CourseReg.SetRange(CourseReg.Reversed, false);

        if CourseReg.Find('-') then
            Error('You have already registered for Semester %1, Year %2', semesterz, CourseReg.Stage);
        /*
        //Insert Student Course
        CourseReg.RESET;
        CourseReg.SETRANGE(CourseReg."Student No.",studentNo);
        CourseReg.SETRANGE(CourseReg.Programmes,Progs);
        CourseReg.SETRANGE(CourseReg.Semester,semester);
        CourseReg.SETRANGE(CourseReg.Reversed,FALSE);
        //CourseReg.SETRANGE(CourseReg.Stage,stage);
        //CourseReg.SETRANGE(CourseReg."Settlement Type", settlementType);
        
        IF CourseReg.FIND('-') THEN BEGIN
        
        CourseRegId:=CourseReg."Reg. Transacton ID";
        //CourseReg.Programmes:=Progs;
        CourseReg.VALIDATE(Programme,Progs);
        //CourseReg.Stage:=stage;
        CourseReg.VALIDATE(Stage);
        CourseReg.Semester:=semester;
        CourseReg."Academic Year":=AcademicYear;
        CourseReg."Settlement Type":=settlementType;
        
        CourseReg.MODIFY(TRUE);
        
        END ELSE BEGIN*/
        Clear(CourseReg);
        CourseReg.Reset;
        CourseReg.SetRange(CourseReg."Student No.", studentNo);
        CourseReg.SetRange(CourseReg.Programmes, Progs);
        CourseReg.SetRange(CourseReg.Semester, semesterz);
        CourseReg.SetRange(CourseReg.Reversed, false);

        if not (CourseReg.Find('-')) then begin
            CourseReg.Init;
            CourseRegId := NoSeriesMgt.GetNextNo(GenSetup."Registration Nos.", Today, true);
            CourseReg."Reg. Transacton ID" := CourseRegId;
            CourseReg."Student No." := studentNo;
            CourseReg.Semester := semesterz;
            CourseReg."Academic Year" := AcademicYear;
            CourseReg.Programmes := Progs;
            CourseReg.Options := ProgrammeOption;
            CourseReg.Validate(Programmes);
            //CourseReg.Stage:=stage;
            CourseReg.Validate(Stage, stagez);
            //CourseReg."Date Registered":=TODAY;
            //CourseReg.Semester:=semester;
            //CourseReg."Academic Year":=AcademicYear;
            CourseReg.Validate("Settlement Type", settlementType);
            CourseReg.Insert(true);

            //END;
        end;

    end;


    procedure StoresRequisitionCreate(EmployeeNo: Text; RequiredDate: Date; Purpose: Text; Campus: Code[20]; CampusName: Text[250]; ReqType: Code[50]) LastNum: Text
    begin
        StoreRequisition.INIT;
        NextStoreqNo := NoSeriesMgt.GetNextNo('STREQ', TODAY, TRUE);
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", EmployeeNo);

        IF EmployeeCard.FIND('-')
        THEN BEGIN
            StoreRequisition."Requester ID" := EmployeeCard."User ID";
            StoreRequisition."User ID" := EmployeeCard."User ID";
            StoreRequisition."Responsibility Center" := EmployeeCard."Responsibility Center";
            StoreRequisition."Staff No." := EmployeeCard."No.";
            StoreRequisition."Department Name" := EmployeeCard."Department Name";
            StoreRequisition."Budget Center Name" := EmployeeCard."Department Name";
            StoreRequisition."Shortcut Dimension 2 Code" := EmployeeCard."Department Code";
            StoreRequisition."No." := NextStoreqNo;
            StoreRequisition."Request date" := TODAY;
            StoreRequisition."Required Date" := RequiredDate;
            StoreRequisition."Request date" := TODAY;
            StoreRequisition."Request Description" := Purpose;
            StoreRequisition."No. Series" := 'STREQ';
            StoreRequisition.Status := StoreRequisition.Status::Open;
            StoreRequisition."Global Dimension 1 Code" := Campus;
            StoreRequisition."Function Name" := CampusName;
            StoreRequisition."Inventory Posting Group" := ReqType;
            StoreRequisition.INSERT;
            LastNum := NextStoreqNo;
        end
    end;


    procedure MealRequisitionCreate(EmployeeNo: Text; Department: Code[20]; BookingDate: Date; MeetingName: Text[50]; RequiredTime: Time; Venue: Text[50]; ContactPerson: Text[50]; ContactNo: Text[30]; ContactMail: Text[50]; Pax: Integer; DepartmentName: Text[50]; RequestedBy: Code[20]; BookingTime: Time)
    begin

        MealRequisition.Init;
        NextMtoreqNo := NoSeriesMgt.GetNextNo('MEAL BOOKI', 0D, true);
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", EmployeeNo);

        if "Employee Card".Find('-')
        then begin
            MealRequisition."Requested By" := RequestedBy;
            "Supervisor Card".Reset;
            "Supervisor Card".SetRange("Supervisor Card"."User ID", RequestedBy);
            if "Supervisor Card".Find('-')
            then begin
                SupervisorId := "Supervisor Card"."Approver ID";
            end;
        end;
        //MealRequisition.INIT;
        MealRequisition."Booking Id" := NextMtoreqNo;
        MealRequisition.Department := Department;
        MealRequisition."Request Date" := Today;
        MealRequisition."Booking Date" := BookingDate;
        MealRequisition."Meeting Name" := MeetingName;
        MealRequisition."Required Time" := RequiredTime;
        MealRequisition.Venue := Venue;
        MealRequisition."Contact Person" := ContactPerson;
        MealRequisition."Contact Number" := ContactNo;
        MealRequisition."Contact Mail" := ContactMail;
        MealRequisition.Pax := Pax;
        MealRequisition.Status := MealRequisition.Status::New;
        MealRequisition."Department Name" := DepartmentName;
        MealRequisition."Requested By" := RequestedBy;
        MealRequisition."No. Series" := 'MEAL BOOKI';
        MealRequisition."Booking Time" := BookingTime;

        MealRequisition.Insert;

        MealRequisition.Reset;
        MealRequisition.SetRange(MealRequisition."Booking Id", NextStoreqNo);
        if MealRequisition.Find('-')
        then begin
            /*ApprovalEntry.INIT;
            ApprovalEntry."Table ID":=39004336;
            ApprovalEntry."Document Type" :=ApprovalEntry."Document Type"::"Staff Claim";
            ApprovalEntry."Document No.":=NextTransportApplicationNo;
            ApprovalEntry."Sequence No.":=1;
            ApprovalEntry."Approval Code":='TRANS';
            ApprovalEntry.Status:=ApprovalEntry_2.Status::Open;
            ApprovalEntry."Sender ID":=EmployeeUserId;
            ApprovalEntry."Approver ID":=SupervisorId;
            ApprovalEntry."Date-Time Sent for Approval":=CURRENTDATETIME;
            ApprovalEntry."Last Date-Time Modified":=CURRENTDATETIME;
            ApprovalEntry."Last Modified By ID":=USERID;
            ApprovalEntry.INSERT;
            LastTransportReqInsert:=TransportRequisition."Transport Requisition No";*/
        end;

    end;


    procedure MealReqLines(BookingId: Code[20]; MealCode: Code[20]; MealName: Text[250]; Quantity: Decimal; UnitPrice: Decimal; Cost: Decimal)
    begin

        MealLinesCreate.Init;
        MealLinesCreate."Booking Id" := BookingId;
        MealLinesCreate."Meal Code" := MealCode;
        MealLinesCreate."Meal Name" := MealName;
        MealLinesCreate.Quantity := Quantity;
        MealLinesCreate."Unit Price" := UnitPrice;
        MealLinesCreate.Cost := Cost;

        MealLinesCreate.Insert;

        MealLinesCreate.Reset;
        MealLinesCreate.SetRange(MealLinesCreate."Booking Id", BookingId);
        if MealLinesCreate.Find('-')
        then begin
            /*ApprovalEntry.INIT;
            ApprovalEntry."Table ID":=39004336;
            ApprovalEntry."Document Type" :=ApprovalEntry."Document Type"::"Staff Claim";
            ApprovalEntry."Document No.":=NextTransportApplicationNo;
            ApprovalEntry."Sequence No.":=1;
            ApprovalEntry."Approval Code":='TRANS';
            ApprovalEntry.Status:=ApprovalEntry_2.Status::Open;
            ApprovalEntry."Sender ID":=EmployeeUserId;
            ApprovalEntry."Approver ID":=SupervisorId;
            ApprovalEntry."Date-Time Sent for Approval":=CURRENTDATETIME;
            ApprovalEntry."Last Date-Time Modified":=CURRENTDATETIME;
            ApprovalEntry."Last Modified By ID":=USERID;
            ApprovalEntry.INSERT;
            LastTransportReqInsert:=TransportRequisition."Transport Requisition No";*/
        end;

    end;


    procedure VenueRequisitionCreate(Department: Code[20]; BookingDate: Date; MeetingDescription: Text[150]; RequiredTime: Time; Venue: Code[20]; ContactPerson: Text[50]; ContactNo: Text[50]; ContactMail: Text[30]; RequestedBy: Text; Pax: Integer) Msg: Code[25]
    begin

        VenueRequisition.INIT;
        VenueRequisition."Booking Id" := NextMtoreqNo;
        VenueRequisition.Department := Department;
        VenueRequisition."Request Date" := Today;
        VenueRequisition."Booking Date" := BookingDate;
        VenueRequisition."Meeting Description" := MeetingDescription;
        VenueRequisition."Required Time" := RequiredTime;
        VenueRequisition.Venue := Venue;
        VenueRequisition."Contact Person" := ContactPerson;
        VenueRequisition."Contact Number" := ContactNo;
        VenueRequisition."Contact Mail" := ContactMail;
        VenueRequisition.Pax := Pax;
        VenueRequisition.Status := VenueRequisition.Status::New;
        //VenueRequisition."Department Name":=DepartmentName;
        VenueRequisition."Staff No." := RequestedBy;
        //VenueRequisition."Booking Time":= ;

        if VenueRequisition.Insert(true) then begin
            SendVenueApproval(VenueRequisition."Booking Id");
            Msg := VenueRequisition."Booking Id";
        end;
    end;


    procedure VenueReqApprovalRequest(ReqNo: Text)
    begin
        VenueRequisition.Reset;
        VenueRequisition.SetRange(VenueRequisition."Booking Id", ReqNo);
        if VenueRequisition.Find('-')
        then begin
            // AppMgt.SendVenueApprovalRequest(VenueRequisition); TODO
        end;
    end;


    procedure GenerateFeeStructure(Programz: Code[20]; SettlementType: Code[20]; filenameFromApp: Text) filename: Text
    begin
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        //MESSAGE('OK');
        Programmezz.Reset;
        Programmezz.SetRange(Programmezz.Code, Programz);
        Programmezz.SetFilter(Programmezz."Settlement Type Filter", '%1', SettlementType);

        if Programmezz.Find('-') then begin
            Report.SaveAsPdf(Report::"Fee Structure Summary Report", filename, Programmezz);   //52017726
        end;
        exit(filename);
    end;


    procedure GenerateReceipt(ReceiptNo: Code[20]; filenameFromApp: Text) filename: Text
    begin
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        //MESSAGE('OK');
        Receiptz.Reset;
        Receiptz.SetRange(Receiptz."Receipt No.", ReceiptNo);

        if Receiptz.Find('-') then begin
            Report.SaveAsPdf(Report::"Student Fee Receipts", filename, Receiptz);   //52017726
        end;
        exit(filename);
    end;


    procedure StudentsLogin(Username: Text; UserPassword: Text) Message: Text
    var
        TXTIncorrectDetails: label 'Incorrect Username or Password';
        TXTCorrectDetails: label 'Login';
        FullNames: Text;
    begin
        StudentCard.Reset;
        StudentCard.SetRange(StudentCard."No.", Username);
        StudentCard.SetFilter(StudentCard.Status, '%1|%2|%3', StudentCard.Status::Current, StudentCard.Status::Registration, StudentCard.Status::"New Admission");
        if StudentCard.Find('-') then begin
            if (StudentCard."Changed Password" = true) then begin
                if (StudentCard.Password = UserPassword) then begin
                    FullNames := StudentCard.Name;
                    Message := TXTCorrectDetails + '::' + Format(StudentCard."Changed Password") + '::' + StudentCard."No." + '::' + StudentCard.Name + '::' + Format(StudentCard.Status);
                end else begin
                    Message := TXTIncorrectDetails + '::' + Format(StudentCard."Changed Password");
                end
            end else begin
                if (StudentCard.Password = UserPassword) then begin
                    Message := TXTCorrectDetails + '::' + Format(StudentCard."Changed Password") + '::' + StudentCard."No." + '::' + StudentCard.Name + '::' + Format(StudentCard.Status);
                end else begin
                    Message := TXTIncorrectDetails + '::' + Format(StudentCard."Changed Password");
                end
            end
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;

    procedure GetStudentsDetails(Username: Text) Message: Text
    begin
        StudentCard.Reset;
        StudentCard.SetRange(StudentCard."No.", Username);
        if StudentCard.Find('-') then begin
            Message := StudentCard.Name + '::' + Format(StudentCard.Status);
        end
    end;

    procedure GetStudentFullName(StudentNo: Text) Message: Text
    var
        FullDetails: Integer;
    begin
        StudentCard.Reset;
        StudentCard.SetRange(StudentCard."No.", StudentNo);
        if StudentCard.Find('-') then begin
            Message := StudentCard."No." + '::' + StudentCard.Name + '::' + StudentCard."E-Mail" + '::' + StudentCard."ID No" + '::' + Format(StudentCard.Gender) + '::' + Format(StudentCard."Date Of Birth") + '::' + StudentCard."Post Code" + '::' + StudentCard.Address;

        end
    end;


    procedure IsStudentRegistered(StudentNo: Text; Sem: Text) Message: Text
    var
        TXTNotRegistered: label 'Not registered';
        TXTRegistered: label 'Registered';
    begin
        CourseRegistration.Reset;
        CourseRegistration.SetRange(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SetRange(CourseRegistration.Semester, Sem);
        CourseRegistration.SetRange(CourseRegistration.Reversed, false);

        if CourseRegistration.Find('-') then begin
            Message := TXTRegistered + '::';
        end else begin
            Message := TXTNotRegistered + '::';
        end
    end;


    procedure GetMarksEntryDeadline(prog: Code[20]; sem: Code[20]) Message: Text
    begin
        Programmezz.Reset;
        Programmezz.SetRange(Code, prog);
        if Programmezz.Find('-') then begin
            if Programmezz."Use Program Semesters" = true then begin
                ProgrammeSemesters.Reset;
                ProgrammeSemesters.SetRange("Programme Code", Programmezz.Code);
                ProgrammeSemesters.SetRange(Semester, sem);
                if ProgrammeSemesters.Find('-') then begin
                    Message := Format(ProgrammeSemesters."Marks Entry Deadline");
                end;
            end else begin
                CurrentSem.Reset;
                CurrentSem.SetRange(Code, sem);
                if CurrentSem.Find('-') then begin
                    Message := Format(CurrentSem."Mark entry Dealine");
                end;
            end;
        end;
    end;


    procedure GetCurrentSemData() Message: Text
    begin
        CurrentSem.Reset;
        CurrentSem.SetRange(CurrentSem."Current Semester", true);
        if CurrentSem.Find('-') then begin
            Message := CurrentSem.Code + '::' + CurrentSem.Description + '::' + Format(CurrentSem."Registration Deadline");
        end
    end;


    procedure GetStudentCourseData(StudentNo: Text; Sem: Text) Message: Text
    begin
        // CourseRegistration.RESET;
        // CourseRegistration.SETRANGE(CourseRegistration."Student No.",StudentNo);
        // //CourseRegistration.SETRANGE(CourseRegistration.Semester,Sem);
        // CourseRegistration.SETRANGE(CourseRegistration.Reversed,FALSE);
        // //CourseRegistration.SETRANGE(CourseRegistration.Posted,FALSE);
        // CourseRegistration.SETCURRENTKEY(Stage);
        // IF CourseRegistration.FIND('+') THEN BEGIN
        //          Message := CourseRegistration.Stage+'::'+CourseRegistration.Programmes+'::'+CourseRegistration."Reg. Transacton ID"+'::'+CourseRegistration.Semester+'::'
        //  +CourseRegistration."Settlement Type"+'::'+FORMAT(CourseRegistration.Programmes);
        //      END;
        CourseRegistration.Reset;
        CourseRegistration.SetRange(CourseRegistration."Student No.", StudentNo);
        //CourseRegistration.SETRANGE(CourseRegistration.Semester,Sem);
        CourseRegistration.SetRange(CourseRegistration.Reversed, false);
        //CourseRegistration.SETRANGE(CourseRegistration.Posted,FALSE);
        CourseRegistration.SetCurrentkey(Stage);
        if CourseRegistration.Find('+') then begin
            Message := CourseRegistration.Stage + '::' + CourseRegistration.Programmes + '::' + CourseRegistration."Reg. Transacton ID" + '::' + CourseRegistration.Semester + '::'
    + CourseRegistration."Settlement Type" + '::' + GetProgram(CourseRegistration.Programmes) + '::' + GetSchool(CourseRegistration.Programmes) + '::' + CourseRegistration.Options;
        end;
    end;

    procedure RequireProgramOption(ProgID: Code[20]; stageCode: Code[20]) Message: Boolean
    var
        progstage: Record "ACA-Programme Stages";
    begin
        Progstage.RESET;
        progstage.SETRANGE("Programme Code", ProgID);
        progstage.SETRANGE(Code, stageCode);
        IF progstage.FIND('-') THEN BEGIN
            Message := progstage."Allow Programme Options";
        END
    end;

    procedure GetProgram(ProgID: Text) Message: Text
    begin
        Programmezz.Reset;
        Programmezz.SetRange(Programmezz.Code, ProgID);
        if Programmezz.Find('-') then begin
            Message := Programmezz.Description;
        end
    end;


    procedure GetBilled(StudentNo: Text; Sem: Text) Message: Text
    var
        ACACourseRegistration: Record "ACA-Course Registration";
    begin
        ACACourseRegistration.Reset;
        ACACourseRegistration.SetRange(ACACourseRegistration."Student No.", StudentNo);
        ACACourseRegistration.SetRange(ACACourseRegistration.Semester, Sem);
        ACACourseRegistration.SetRange(ACACourseRegistration.Reversed, false);
        ACACourseRegistration.SetRange(ACACourseRegistration.Posted, true);
        if ACACourseRegistration.Find('-') then begin
            Message := ACACourseRegistration.Semester;
        end;
    end;


    procedure GetAcademicYr() Message: Text
    begin
        AcademicYr.Reset;
        AcademicYr.SetRange(AcademicYr.Current, true);
        if AcademicYr.Find('-') then begin
            Message := AcademicYr.Code + '::' + AcademicYr.Description;
        end
    end;


    procedure UnitDescription(ProgID: Text; UnitID: Text) Message: Text
    begin
        UnitSubjects.Reset;
        UnitSubjects.SetRange(UnitSubjects."Programme Code", ProgID);
        UnitSubjects.SetRange(UnitSubjects.Code, UnitID);
        UnitSubjects.SetRange(UnitSubjects."Time Table", true);
        UnitSubjects.SetRange(UnitSubjects."Old Unit", false);
        if UnitSubjects.Find('-') then begin
            Message := UnitSubjects.Desription;
        end
    end;


    procedure SubmitUnits(studentNo: Text; Unit: Text; Prog: Text; myStage: Text; sem: Text; RegTransID: Text; UnitDescription: Text; AcademicYear: Text) ReturnMessage: Text[150]
    var
        Customer: Record Customer;
    begin
        // if Customer.Get(studentNo) then begin
        //     Customer.CalcFields(Balance);
        //     if Customer.Balance > 0 then begin
        //         ReturnMessage := 'Units not registered! Your Balance is greater than zero!';
        //     end;
        // end;
        // if not (Customer.Balance > 0) then begin
        StudentUnits.Init;
        StudentUnits."Student No." := studentNo;
        StudentUnits.Unit := Unit;
        StudentUnits.Programme := Prog;
        StudentUnits.Stage := myStage;
        StudentUnits.Semester := sem;
        StudentUnits.Taken := true;
        StudentUnits."Reg. Transacton ID" := RegTransID;
        StudentUnits."Unit Description" := UnitDescription;
        StudentUnits."Academic Year" := AcademicYear;
        StudentUnits.Insert(true);
        ReturnMessage := 'Units registered Successfully!'
        //end;
    end;


    procedure GetUnitTaken(UnitID: Text; StudentNo: Text; Stage: Text) Message: Text
    var
        TXTtaken: label 'Taken';
        TXTNotTaken: label 'Not Taken';
    begin
        StudentUnits.Reset;
        StudentUnits.SetRange(StudentUnits.Unit, UnitID);
        StudentUnits.SetRange(StudentUnits."Student No.", StudentNo);
        StudentUnits.SetRange(StudentUnits.Stage, Stage);
        if StudentUnits.Find('-') then begin
            Message := TXTtaken + '::';
        end else begin
            Message := TXTNotTaken + '::';
        end
    end;


    procedure SubmitUnitsBaskets(studentNo: Text; Unit: Text; Prog: Text; myStage: Text; sem: Text; RegTransID: Text; UnitDescription: Text; AcademicYear: Text)
    var
        ACAStudentUnits: Record "ACA-Student Units";
    begin
        ACAStudentUnits.Reset;
        ACAStudentUnits.SetRange("Student No.", studentNo);
        ACAStudentUnits.SetRange(Semester, sem);
        ACAStudentUnits.SetRange(Unit, Unit);
        if ACAStudentUnits.Find('-') then Prog := ACAStudentUnits.Programme;

        StudentUnitBaskets.Reset;
        StudentUnitBaskets.SetRange("Student No.", studentNo);
        StudentUnitBaskets.SetRange(Unit, Unit);
        StudentUnitBaskets.SetRange(Programmes, Prog);
        StudentUnitBaskets.SetRange(Stage, myStage);
        StudentUnitBaskets.SetRange(Semester, sem);
        StudentUnitBaskets.SetRange("Reg. Transacton ID", RegTransID);
        StudentUnitBaskets.SetRange("Academic Year", AcademicYear);
        if not StudentUnitBaskets.Find('-') then begin
            StudentUnitBaskets.Init;
            StudentUnitBaskets."Student No." := studentNo;
            StudentUnitBaskets.Unit := Unit;
            StudentUnitBaskets.Programmes := Prog;
            StudentUnitBaskets.Stage := myStage;
            StudentUnitBaskets.Taken := true;
            StudentUnitBaskets.Semester := sem;
            StudentUnitBaskets."Reg. Transacton ID" := RegTransID;
            StudentUnitBaskets.Description := UnitDescription;
            StudentUnitBaskets."Academic Year" := AcademicYear;
            StudentUnitBaskets.Posted := false;
            StudentUnitBaskets.Insert(true);
        end else begin
            StudentUnitBaskets.Posted := false;
            StudentUnitBaskets.Modify;
        end;
    end;


    procedure GetUnitSelected(UnitID: Text; StudentNo: Text; Stage: Text) Message: Text
    var
        TXTtaken: label 'Taken';
        TXTNotTaken: label 'Not Taken';
    begin
        StudentUnitBaskets.Reset;
        StudentUnitBaskets.SetRange(StudentUnitBaskets.Unit, UnitID);
        StudentUnitBaskets.SetRange(StudentUnitBaskets."Student No.", StudentNo);
        StudentUnitBaskets.SetRange(StudentUnitBaskets.Stage, Stage);
        StudentUnitBaskets.SetRange(StudentUnitBaskets.Posted, false);
        if StudentUnitBaskets.Find('-') then begin
            Message := TXTtaken + '::';
        end else begin
            Message := TXTNotTaken + '::';
        end
    end;


    procedure DeleteSelectedUnit(studentNo: Text; UnitID: Text)
    begin
        StudentUnitBaskets.Reset;
        StudentUnitBaskets.SetRange(StudentUnitBaskets."Student No.", studentNo);
        StudentUnitBaskets.SetRange(StudentUnitBaskets.Unit, UnitID);
        if StudentUnitBaskets.Find('-') then begin
            StudentUnitBaskets.Delete;
            Message('Deleted Successfully');
        end;
    end;


    procedure DeleteSubmittedUnit(studentNo: Text)
    begin
        StudentUnitBaskets.Reset;
        StudentUnitBaskets.SetRange(StudentUnitBaskets."Student No.", studentNo);
        if StudentUnitBaskets.Find('-') then begin
            repeat
                StudentUnitBaskets.Posted := true;
                StudentUnitBaskets.Modify;
                Message('Deleted Successfully');
            until StudentUnitBaskets.Next = 0;
        end;
    end;


    procedure CheckStaffPasswordChanged(username: Text) Message: Text
    var
        TXTIncorrectDetails: label 'No';
        TXTCorrectDetails: label 'Yes';
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", username);
        if EmployeeCard.Find('-') then begin
            if (EmployeeCard."Changed Password" = true) then begin
                Message := TXTCorrectDetails + '::' + Format(EmployeeCard."Changed Password");
            end else begin
                Message := TXTIncorrectDetails + '::' + Format(EmployeeCard."Changed Password");
            end
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;


    procedure CheckStaffLogin(username: Text; userpassword: Text) Message: Text
    var
        TXTIncorrectDetails: label 'Incorrect Username or Password';
        TXTCorrectDetails: label 'Login';
        FullNames: Text;
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", username);
        EmployeeCard.SetRange(EmployeeCard.Status, EmployeeCard.Status::Active);
        if EmployeeCard.Find('-') then begin
            if (EmployeeCard."Changed Password" = true) then begin
                if (EmployeeCard."Portal Password" = userpassword) then begin
                    FullNames := EmployeeCard."First Name" + ' ' + EmployeeCard."Middle Name" + ' ' + EmployeeCard."Last Name";
                    Message := TXTCorrectDetails + '::' + Format(EmployeeCard."Changed Password") + '::' + EmployeeCard."No." + '::' + EmployeeCard."User ID" + '::' + FullNames;
                end else begin
                    Message := TXTIncorrectDetails + '::' + Format(EmployeeCard."Changed Password");
                end
            end else begin
                if (EmployeeCard."Portal Password" = userpassword) then begin
                    Message := TXTCorrectDetails + '::' + Format(EmployeeCard."Changed Password") + '::' + EmployeeCard."No." + '::' + EmployeeCard."User ID" + '::' + FullNames;
                end else begin
                    Message := TXTIncorrectDetails + '::' + Format(EmployeeCard."Changed Password");
                end
            end
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;


    procedure CheckStaffLoginForUnchangedPass(Username: Text; Useremail: Text) Message: Text
    var
        TXTIncorrectDetails: label 'Warning!, login failed! Ensure you login with your email as the password!';
        TXTCorrectDetails: label 'Login';
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", Username);
        EmployeeCard.SetRange(EmployeeCard.Status, EmployeeCard.Status::Active);
        if EmployeeCard.Find('-') then begin
            if (EmployeeCard."Changed Password" = true) then begin
                if (EmployeeCard."Company E-Mail" = Useremail) then begin
                    Message := TXTCorrectDetails + '::' + EmployeeCard."No." + '::' + EmployeeCard."Company E-Mail";
                end else begin
                    Message := TXTIncorrectDetails + '::';
                end
            end else begin
                if (EmployeeCard."Company E-Mail" = Useremail) then begin
                    Message := TXTCorrectDetails + '::' + EmployeeCard."No." + '::' + EmployeeCard."Company E-Mail";
                end else begin
                    Message := TXTIncorrectDetails + '::';
                end
            end
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;


    procedure UpdateStaffPass(username: Text; genpass: Text)
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", username);
        if EmployeeCard.Find('-') then begin
            EmployeeCard."Portal Password" := genpass;
            EmployeeCard."Changed Password" := true;
            EmployeeCard.Modify;
            Message('Meal Item Updated Successfully');
        end;
    end;


    procedure CheckValidStaffNo(username: Text) Message: Text
    var
        TXTIncorrectDetails: label 'Invalid Staff No';
        TXTCorrectDetails: label 'Yes';
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", username);
        if EmployeeCard.Find('-') then begin
            Message := TXTCorrectDetails + '::';
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;


    procedure getStaffMail(username: Text) Message: Text
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", username);
        if EmployeeCard.Find('-') then begin
            Message := EmployeeCard."Company E-Mail" + '::';
        end
    end;


    procedure GetCurrentPassword(username: Text) Message: Text
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", username);
        if EmployeeCard.Find('-') then begin
            Message := EmployeeCard."Portal Password" + '::';
        end
    end;


    procedure GenerateTranscript(StudentNo: Text; filenameFromApp: Text; sem: Text)
    var
        filename: Text;
        AcademicYear: Code[20];
        ACAExamCourseRegistration: Record "ACA-Exam. Course Registration";
    begin
        filename := FILESPATH + filenameFromApp;
        Clear(AcademicYear);
        AcademicYear := sem;
        if Exists(filename) then
            Erase(filename);
        ACAExamCourseRegistration.Reset;
        ACAExamCourseRegistration.SetRange(ACAExamCourseRegistration."Student Number", StudentNo);
        ACAExamCourseRegistration.SetRange(ACAExamCourseRegistration."Academic Year", AcademicYear);
        //ACAExamCourseRegistration.SETRANGE(ACAExamCourseRegistration."Allow View of Results",TRUE);
        if ACAExamCourseRegistration.Find('-') then begin
            Report.SaveAsPdf(Report::"Provisional College Transcrip3", filename, ACAExamCourseRegistration);
        end;
    end;


    procedure GenerateLeaveStatement(StaffNo: Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH_S + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", StaffNo);

        if EmployeeCard.Find('-') then begin
            Report.SaveAsPdf(Report::"Standard Leave Balance Report", filename, EmployeeCard);
        end;
    end;


    procedure GetStaffDetails(username: Text) Message: Text
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", username);
        if EmployeeCard.Find('-') then begin
            Message := EmployeeCard."ID Number" + '::' + EmployeeCard.Citizenship + '::' + EmployeeCard."Postal Address" + '::' +
  EmployeeCard."Job Title" + '::' + EmployeeCard."Company E-Mail" + '::' + Format(EmployeeCard.Title) + '::' + Format(EmployeeCard."Date Of Birth");

        end
    end;


    procedure GetStaffGender(username: Text) Message: Text
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", username);
        if EmployeeCard.Find('-') then begin
            Message := Format(EmployeeCard.Gender) + '::' + EmployeeCard."Cellular Phone Number";

        end
    end;


    procedure HasFinances(StudentNo: Text) Message: Text
    var
        TXTNotRegistered: label 'No';
        TXTRegistered: label 'Yes';
    begin
        LedgerEntries.Reset;
        LedgerEntries.SetRange(LedgerEntries."Customer No.", StudentNo);
        if LedgerEntries.Find('-') then begin
            Message := TXTRegistered + '::';
        end else begin
            Message := TXTNotRegistered + '::';
        end
    end;


    procedure GetCurrentSTageOrder(stage: Text; "Program": Text) Message: Text
    begin
        Stages.Reset;
        Stages.SetRange(Stages.Code, stage);
        Stages.SetRange(Stages."Programme Code", "Program");
        if Stages.Find('-') then begin
            Message := Format(Stages.Order);
        end
    end;


    procedure GetNextSTage(orderd: Integer; Progz: Text) Message: Text
    begin
        Stages.Reset;
        Stages.SetRange(Stages.Order, orderd);
        Stages.SetRange(Stages."Programme Code", Progz);
        if Stages.Find('-') then begin
            Message := Stages.Code;
        end;
    end;


    procedure SubmitSpecialAndSupplementary(StudNo: Code[20]; LectNo: Code[20]; Marks: Decimal; AcademicYear: Code[20]; UnitCode: Code[20]) ReturnMessage: Text[250]
    var
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        AcaSpecialExamsResults: Record "Aca-Special Exams Results";
        emps: Record "HRM-Employee C";
    begin
        Clear(ReturnMessage);
        Clear(emps);
        emps.Reset;
        emps.SetRange("No.", LectNo);
        if emps.Find('-') then;
        AcaSpecialExamsDetails.Reset;
        AcaSpecialExamsDetails.SetRange("Current Academic Year", AcademicYear);
        AcaSpecialExamsDetails.SetRange("Student No.", StudNo);
        AcaSpecialExamsDetails.SetRange("Unit Code", UnitCode);
        if AcaSpecialExamsDetails.Find('-') then begin
            AcaSpecialExamsResults.Reset;
            AcaSpecialExamsResults.SetRange("Current Academic Year", AcademicYear);
            AcaSpecialExamsResults.SetRange("Student No.", StudNo);
            AcaSpecialExamsResults.SetRange(Unit, UnitCode);
            if AcaSpecialExamsResults.Find('-') then begin
                AcaSpecialExamsResults.Validate(Score, Marks);
                AcaSpecialExamsResults.UserID := LectNo;
                AcaSpecialExamsResults."Modified Date" := Today;
                AcaSpecialExamsResults.category := AcaSpecialExamsDetails.Category;
                AcaSpecialExamsResults.Modify;
                ReturnMessage := 'SUCCESS: Marks Modified!'
            end else begin
                AcaSpecialExamsResults.Init;
                AcaSpecialExamsResults.Programmes := AcaSpecialExamsDetails.Programme;
                AcaSpecialExamsResults.Stage := AcaSpecialExamsDetails.Stage;
                AcaSpecialExamsResults.Unit := UnitCode;
                AcaSpecialExamsResults.Semester := AcaSpecialExamsDetails.Semester;
                AcaSpecialExamsResults."Student No." := AcaSpecialExamsDetails."Student No.";
                AcaSpecialExamsResults."Academic Year" := AcademicYear;
                AcaSpecialExamsResults."Admission No" := StudNo;
                AcaSpecialExamsResults."Current Academic Year" := AcademicYear;
                AcaSpecialExamsResults.UserID := LectNo;
                AcaSpecialExamsResults."Capture Date" := Today;
                AcaSpecialExamsResults.category := AcaSpecialExamsDetails.Category;
                AcaSpecialExamsResults."Lecturer Names" := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
                AcaSpecialExamsResults.Validate(Score, Marks);
                AcaSpecialExamsResults.Insert;
                ReturnMessage := 'SUCCESS: Marks Inserted!';
            end;
            AcaSpecialExamsDetails."Exam Marks" := Marks;
            AcaSpecialExamsDetails.Modify;
        end;
    end;


    procedure GetFees(StudentNo: Text) Message: Text
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", StudentNo);
        if Customer.Find('-') then begin
            Customer.CalcFields("Debit Amount", "Credit Amount", Balance);
            Message := Format(Customer."Debit Amount") + '::' + Format(Customer."Credit Amount") + '::' + Format(Customer.Balance);

        end
    end;

    local procedure GetSchool(Prog: Code[20]) SchoolName: Text[150]
    var
        ACAProgramme2: Record "ACA-Programme";
        DimensionValue: Record "Dimension Value";
    begin
        Clear(SchoolName);
        if ACAProgramme2.Get(Prog) then begin
            DimensionValue.Reset;
            DimensionValue.SetRange("Dimension Code", 'SCHOOL');
            DimensionValue.SetRange(Code, ACAProgramme2."School Code");
            if DimensionValue.Find('-') then SchoolName := DimensionValue.Name;
        end;
    end;


    procedure EvaluateLecturer(Programmez: Text; Stagez: Text; Unitz: Text; Semesterz: Text; StudentNoz: Text; LecturerNoz: Text; QuestionNoz: Text; Responsez: Text; SelectedValue: Integer)
    begin
        LecEvaluation.Reset;
        LecEvaluation.SetRange(LecEvaluation.Programme, Programmez);
        LecEvaluation.SetRange(LecEvaluation.Stage, Stagez);
        LecEvaluation.SetRange(LecEvaluation.Unit, Unitz);
        LecEvaluation.SetRange(LecEvaluation.Semester, Semesterz);
        LecEvaluation.SetRange(LecEvaluation."Student No", StudentNoz);
        LecEvaluation.SetRange(LecEvaluation."Lecturer No", LecturerNoz);
        LecEvaluation.SetRange(LecEvaluation."Question No", QuestionNoz);
        if not LecEvaluation.Find('-') then begin
            LecEvaluation.Init;
            LecEvaluation.Programme := Programmez;
            LecEvaluation.Stage := Stagez;
            LecEvaluation.Unit := Unitz;
            LecEvaluation.Semester := Semesterz;
            LecEvaluation."Student No" := StudentNoz;
            LecEvaluation."Lecturer No" := LecturerNoz;
            LecEvaluation."Question No" := QuestionNoz;
            LecEvaluation.Response := Responsez;
            LecEvaluation."Date Time" := CurrentDatetime;
            LecEvaluation.Value := SelectedValue;
            LecEvaluation.Choices := SelectedValue;
            LecEvaluation.Insert(true);
        end else begin
            LecEvaluation.Response := Responsez;
            LecEvaluation.Value := SelectedValue;
            LecEvaluation.Modify;
        end;

        StudentUnits.Reset;
        StudentUnits.SetRange("Student No.", StudentNoz);
        StudentUnits.SetRange(Unit, Unitz);
        StudentUnits.SetRange(Semester, Semesterz);
        StudentUnits.SetRange(Stage, Stagez);
        if StudentUnits.Find('-') then begin
            StudentUnits."Course Evaluated" := true;
            StudentUnits.Modify;
        end;
    end;


    procedure GetEvaluated(Username: Text; "Program": Text; Stage: Text; Unit: Text; Sem: Text) Message: Text
    var
        TXTNotEvaluated: label 'No';
        TXTEvaluated: label 'Yes';
    begin
        LecEvaluation.Reset;
        LecEvaluation.SetRange(LecEvaluation."Student No", Username);
        LecEvaluation.SetRange(LecEvaluation.Programme, "Program");
        LecEvaluation.SetRange(LecEvaluation.Stage, Stage);
        LecEvaluation.SetRange(LecEvaluation.Unit, Unit);
        LecEvaluation.SetRange(LecEvaluation.Semester, Sem);
        if LecEvaluation.Find('-') then begin
            Message := TXTEvaluated + '::';
        end else begin
            Message := TXTNotEvaluated + '::';
        end
    end;


    procedure GetSentForApprovals_Venue(DocNumber: Text) Message: Text
    begin
        VenueBooking.Reset;
        VenueBooking.SetRange(VenueBooking."Booking Id", DocNumber);
        if VenueBooking.Find('-') then begin
            Message := Format(VenueBooking.Status);
        end
    end;


    procedure SendVenueApproval(DocNumber: Code[20]) Msg: Boolean
    var
        variant: Variant;
        ApprovalMgt: Codeunit "Approval Workflows V1";
    begin
        VenueBooking.Reset;
        VenueBooking.SetRange(VenueBooking."Booking Id", DocNumber);
        if VenueBooking.Find('-') then begin
            variant := VenueBooking;
            if ApprovalMgt.CheckApprovalsWorkflowEnabled(variant) then begin
                ApprovalMgt.OnSendDocForApproval(variant);
                Msg := true;
            end;
        end
    end;

    //Cancel Venue Booking
    procedure CancelVenueBookingApproval(DocNumber: Code[20]) Msg: Boolean
    var
        variant: Variant;
        ApprovalMgt: Codeunit "Approval Workflows V1";
    begin
        VenueBooking.Reset;
        VenueBooking.SetRange(VenueBooking."Booking Id", DocNumber);
        if VenueBooking.Find('-') then begin
            variant := VenueBooking;
            if ApprovalMgt.CheckApprovalsWorkflowEnabled(variant) then begin
                ApprovalMgt.OnCancelDocApprovalRequest(variant);
                Msg := true;
            end;
        end
    end;


    procedure SendApprovalRequest(Table_ids: Integer; Doc_Nos: Code[20]; Doc_Types: Integer; Statuss: Integer; ResponsibilityCenters: Code[30]; DocAmounts: Decimal)
    begin
        //AppMgt.SendApproval(Table_ids, Doc_Nos, Doc_Types, Statuss, ResponsibilityCenters, DocAmounts); //TODO
    end;


    procedure CancelApprovalRequest(var Table_Ids: Integer; Doc_Types: Option; var Doc_nos: Code[20]; var ShowMessages: Boolean; var ManualCancels: Boolean)
    begin
        // AppMgt.CancelApproval(Table_Ids, Doc_Types, Doc_nos, ShowMessages, ManualCancels); //TODO
    end;


    procedure SubmitHelpdesk(SenderID: Text; Questions: Text; Categorys: Option; Departments: Code[50]; Names: Text)
    begin
        HelpDesk.Init;
        HelpDesk."Sender ID" := SenderID;
        HelpDesk.Question := Questions;
        HelpDesk.Status := HelpDesk.Status::New;
        HelpDesk."Request Date" := Today;
        HelpDesk.Department := Departments;
        HelpDesk.Category := Categorys;
        HelpDesk.Name := Names;
        HelpDesk.Insert(true);
    end;


    procedure GetStaffDepartment(username: Text) Message: Text
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", username);
        if EmployeeCard.Find('-') then begin
            Message := EmployeeCard."Department Code";

        end
    end;


    procedure GetStaffProfileDetails(username: Text) Message: Text
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", username);
        if EmployeeCard.Find('-') then begin
            Message := EmployeeCard."ID Number" + '::' + EmployeeCard.Citizenship + '::' + EmployeeCard."Postal Address" + '::' +
  EmployeeCard."Job Title" + '::' + EmployeeCard."Company E-Mail" + '::' + Format(EmployeeCard.Title) + '::' + Format(EmployeeCard."Date Of Birth") + '::' + Format(EmployeeCard.Gender) + '::' + EmployeeCard."Cellular Phone Number";

        end
    end;


    procedure GetPendingApplications_Leave(username: Text) Message: Text
    var
        TXTHas: label 'Yes';
        TXTNot: label 'No';
    begin
        LeaveT.Reset;
        LeaveT.SetRange(LeaveT."Employee No", username);
        LeaveT.SetRange(LeaveT.Status, LeaveT.Status::Open);
        //LeaveT.SETFILTER(LeaveT.Status,'%1|%2',LeaveT.Status::Open,LeaveT.Status::"Pending Approval");
        //LeaveT.SETRANGE(LeaveT.Status,LeaveT.Status::"Pending Approval");
        if LeaveT.Find('-') then begin
            //Message:=FORMAT(LeaveT.COUNT);
            Message := TXTHas + '::';
        end else begin
            Message := TXTNot + '::';
        end
    end;


    procedure CheckLeaveStatus(username: Text; LeaveType: Text) Message: Text
    var
        TXTHas: label 'Yes';
        TXTNot: label 'No';
    begin
        LeaveT.Reset;
        LeaveT.SetRange(LeaveT."Employee No", username);
        LeaveT.SetRange(LeaveT.Status, LeaveT.Status::"Pending Approval");
        LeaveT.SetRange(LeaveT."Leave Type", LeaveType);
        if LeaveT.Find('-') then begin
            Message := TXTHas + '::';
        end else begin
            Message := TXTNot + '::';
        end
    end;


    procedure GetSApprovalStatus(ReqNo: Text) Message: Text
    var
        TXTIncorrectDetails: label 'No';
        TXTCorrectDetails: label 'Yes';
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", ReqNo);
        ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Approved, ApprovalEntry.Status::Canceled, ApprovalEntry.Status::Rejected);
        if ApprovalEntry.Find('-') then begin
            Message := TXTCorrectDetails + '::';
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;


    procedure GetSentForApproval(DocNum: Text) Message: Text
    var
        TXTIncorrectDetails: label 'No';
        TXTCorrectDetails: label 'Yes';
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocNum);
        if ApprovalEntry.Find('-') then begin
            Message := TXTCorrectDetails + '::';
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;


    procedure GetApprovedRejected(DocNum: Text) Message: Text
    var
        TXTIncorrectDetails: label 'No';
        TXTCorrectDetails: label 'Yes';
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocNum);
        ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Approved, ApprovalEntry.Status::Rejected, ApprovalEntry.Status::Canceled);
        if ApprovalEntry.Find('-') then begin
            Message := TXTCorrectDetails + '::';
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;


    procedure LecturerSpecificTimetables(Semesters: Code[20]; LecturerNo: Code[20]; TimetableType: Text[20]; filenameFromApp: Text) TimetableReturn: Text
    var
        UnitFilterString: Text[1024];
        NoOfLoops: Integer;
        EXTTimetableFInalCollector: Record "EXT-Timetable FInal Collector";
        TTTimetableFInalCollector: Record "TT-Timetable FInal Collector";
        filename: Text[200];
        ACALecturersUnits: Record "ACA-Lecturers Units";
    begin
        Clear(TimetableReturn);
        ACALecturersUnits.Reset;
        ACALecturersUnits.SetRange(Semester, Semesters);
        ACALecturersUnits.SetRange(Lecturer, LecturerNo);
        if ACALecturersUnits.Find('-') then begin
            Clear(UnitFilterString);
            Clear(NoOfLoops);
            repeat
            begin
                if NoOfLoops > 0 then
                    UnitFilterString := UnitFilterString + '|';
                UnitFilterString := UnitFilterString + ACALecturersUnits.Unit;
                NoOfLoops := NoOfLoops + 1;
            end;
            until ACALecturersUnits.Next = 0;
        end else
            TimetableReturn := 'You''ve not been allocated units in ' + Semesters;
        if UnitFilterString <> '' then begin
            //Render the timetables here
            //**1. Class Timetable
            if TimetableType = 'CLASS' then begin
                TTTimetableFInalCollector.Reset;
                TTTimetableFInalCollector.SetRange(Lecturer, LecturerNo);
                TTTimetableFInalCollector.SetRange(Semester, Semesters);
                TTTimetableFInalCollector.SetFilter(Unit, UnitFilterString);
                if TTTimetableFInalCollector.Find('-') then begin//Pull the Class Timetable Here
                                                                 //    REPORT.RUN(report::"TT-Master Timetable (Final) 2",TRUE,FALSE,TTTimetableFInalCollector);
                                                                 //filename :=FILESPATH_S+LecturerNo+'_ClassTimetable_'+Semesters;
                    TimetableReturn := FILESPATH_S + filenameFromApp;
                    if Exists(TimetableReturn) then
                        Erase(TimetableReturn);
                    Report.SaveAsPdf(report::"TT-Master Timetable (Final) 2", TimetableReturn, TTTimetableFInalCollector);
                end;
            end else if TimetableType = 'EXAM' then begin
                //**2. Exam Timetable
                EXTTimetableFInalCollector.Reset;
                EXTTimetableFInalCollector.SetRange(Semester, Semesters);
                EXTTimetableFInalCollector.SetFilter(Unit, UnitFilterString);
                if EXTTimetableFInalCollector.Find('-') then begin//Pull the Exam Timetable Here
                                                                  //    REPORT.RUN(report::"EXT-Master Timetable (Final) 2",TRUE,FALSE,EXTTimetableFInalCollector);
                                                                  // filename :=FILESPATH_S+LecturerNo+'_ExamTimetable_'+Semesters;
                    TimetableReturn := FILESPATH_S + filenameFromApp;
                    if Exists(TimetableReturn) then
                        Erase(TimetableReturn);
                    Report.SaveAsPdf(Report::"EXT-Master Timetable (Final) 2", TimetableReturn, EXTTimetableFInalCollector);
                end;
            end;
        end;
    end;


    procedure StudentSpecificTimetables(Semesters: Code[20]; StudentNo: Code[20]; TimetableType: Text[20]) TimetableReturn: Text
    var
        ACACourseRegistration: Record "ACA-Course Registration";
        ACAStudentUnits: Record "ACA-Student Units";
        UnitFilterString: Text[1024];
        NoOfLoops: Integer;
        EXTTimetableFInalCollector: Record "EXT-Timetable FInal Collector";
        TTTimetableFInalCollector: Record "TT-Timetable FInal Collector";
        filename: Text[200];
    begin
        Clear(TimetableReturn);
        ACACourseRegistration.Reset;
        ACACourseRegistration.SetRange(Semester, Semesters);
        ACACourseRegistration.SetRange("Student No.", StudentNo);
        if ACACourseRegistration.Find('-') then begin
            ACAStudentUnits.Reset;
            ACAStudentUnits.SetRange(Semester, Semesters);
            ACAStudentUnits.SetRange("Student No.", StudentNo);
            ACAStudentUnits.SetFilter("Reg. Reversed", '=%1', false);
            if ACAStudentUnits.Find('-') then begin
                Clear(UnitFilterString);
                Clear(NoOfLoops);
                repeat
                begin
                    if NoOfLoops > 0 then
                        UnitFilterString := UnitFilterString + '|';
                    UnitFilterString := UnitFilterString + ACAStudentUnits.Unit;
                    NoOfLoops := NoOfLoops + 1;
                end;
                until ACAStudentUnits.Next = 0;
            end else
                TimetableReturn := 'You have not registered for Units in ' + Semesters;
        end else
            TimetableReturn := 'You are not registered in ' + Semesters;
        if UnitFilterString <> '' then begin
            //Render the timetables here
            //**1. Class Timetable
            if TimetableType = 'CLASS' then begin
                TTTimetableFInalCollector.Reset;
                TTTimetableFInalCollector.SetRange(Programme, ACACourseRegistration.Programmes);
                TTTimetableFInalCollector.SetRange(Semester, Semesters);
                TTTimetableFInalCollector.SetFilter(Unit, UnitFilterString);
                if TTTimetableFInalCollector.Find('-') then begin//Pull the Class Timetable Here
                    Report.Run(report::"TT-Master Timetable (Final) 2", true, false, TTTimetableFInalCollector);
                    filename := FILESPATH_S + StudentNo + '_ClassTimetable_' + Semesters;
                    if Exists(filename) then
                        Erase(filename);
                    Report.SaveAsPdf(report::"TT-Master Timetable (Final) 2", filename, TTTimetableFInalCollector);
                end;
            end else if TimetableType = 'EXAM' then begin
                //**2. Exam Timetable
                EXTTimetableFInalCollector.Reset;
                EXTTimetableFInalCollector.SetRange(Programme, ACACourseRegistration.Programmes);
                EXTTimetableFInalCollector.SetRange(Semester, Semesters);
                EXTTimetableFInalCollector.SetFilter(Unit, UnitFilterString);
                if EXTTimetableFInalCollector.Find('-') then begin//Pull the Exam Timetable Here
                                                                  //   REPORT.RUN(report::"EXT-Master Timetable (Final) 2",TRUE,FALSE,EXTTimetableFInalCollector);
                    filename := FILESPATH_S + StudentNo + '_ExamTimetable_' + Semesters;
                    if Exists(filename) then
                        Erase(filename);
                    Report.SaveAsPdf(report::"EXT-Master Timetable (Final) 2", filename, EXTTimetableFInalCollector);
                end;
            end;
        end;

        //EXIT(filename);
    end;


    procedure Vote(Elections: Code[50]; StudentNo: Text; CandidateNo: Text; Positions: Text)
    begin
        VoteElection.Init;
        VoteElection.Election := Elections;
        VoteElection."Student No." := StudentNo;
        VoteElection."Candidate No." := CandidateNo;
        VoteElection."PIN No." := '0';
        VoteElection.Position := Positions;
        VoteElection.Date := Today;
        VoteElection."Date Time" := CurrentDatetime;
        VoteElection.Voted := true;
        VoteElection.Insert(true);
    end;

    procedure KUCCPSLogin(username: Text) Message: Text
    var
        FullNames: Text;
        TXTIncorrectDetails: label 'Incorrect Username or Password';
        TXTCorrectDetails: label 'Login';
        TXTInactive: label 'Your Account is not active';
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        //KUCCPSRaw.SetRange(KUCCPSRaw."Academic Year", '2024/2025');
        if KUCCPSRaw.Find('-') then begin
            FullNames := KUCCPSRaw.Names;
            Message := TXTCorrectDetails + '::' + KUCCPSRaw.Admin + '::' + FullNames;
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;


    procedure GetKUCCPSUserData(username: Text) Message: Text
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            Message := KUCCPSRaw.Admin + '::' + KUCCPSRaw.Names + '::' + Format(KUCCPSRaw.Gender) + '::' +
  KUCCPSRaw.Email + '::' + KUCCPSRaw.Phone + '::' + Format(KUCCPSRaw.Prog) + '::' + GetProgram(KUCCPSRaw.Prog) + '::' + KUCCPSRaw.Prog;

        end
    end;


    procedure GenerateAdmLetter(AdmNo: Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        //filename :=FILESPATH_A+filenameFromApp;
        //IF EXISTS(filename) THEN
        //ERASE(filename);
        //AdmissionFormHeader.RESET;
        //AdmissionFormHeader.SETRANGE(AdmissionFormHeader."Admission No.",AdmNo);

        //IF AdmissionFormHeader.FIND('-') THEN BEGIN
        //REPORT.SAVEASPDF(51338,filename,AdmissionFormHeader);
        //END;
        filename := FILESPATH_A + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, AdmNo);

        if KUCCPSRaw.Find('-') then begin
            Report.SaveAsPdf(Report::"Official Admission LetterJAb", filename, KUCCPSRaw);
        end;
    end;


    procedure RegisterOnlineAccount(EmailAddress: Text; IDNo: Text; Genderz: Integer; PhoneNo: Text; Passwordz: Text; FirstName: Text; MiddleName: Text; LastName: Text; SessionIDz: Text; DoBz: Date; Countyz: Code[50]; MaritalStatus: Integer; Nationalityz: Code[50]; PostalAddress: Text)
    begin
        OnlineUsersz.Init;
        OnlineUsersz."Email Address" := EmailAddress;
        OnlineUsersz."ID No" := IDNo;
        OnlineUsersz.Gender := Genderz;
        OnlineUsersz."Phone No" := PhoneNo;
        OnlineUsersz.Password := Passwordz;
        OnlineUsersz."First Name" := FirstName;
        OnlineUsersz."Middle Name" := MiddleName;
        OnlineUsersz."Last Name" := LastName;
        OnlineUsersz.SessionID := SessionIDz;
        OnlineUsersz.Confirmed := true;
        OnlineUsersz.DoB := DoBz;
        OnlineUsersz.County := Countyz;
        OnlineUsersz."Marital Status" := MaritalStatus;
        OnlineUsersz.Nationality := Nationalityz;
        OnlineUsersz."Postal Address" := PostalAddress;
        OnlineUsersz.Insert(true);
    end;


    procedure CheckOnlineLogin(username: Text; passrd: Text) Message: Text
    var
        FullNames: Text;
        TXTIncorrectDetails: label 'Incorrect Username or Password';
        TXTCorrectDetails: label 'Login';
        TXTInactive: label 'Your Account is not active';
    begin
        OnlineUsersz.Reset;
        OnlineUsersz.SetRange(OnlineUsersz."Email Address", username);
        OnlineUsersz.SetRange(OnlineUsersz.Password, passrd);
        if OnlineUsersz.Find('-') then begin
            FullNames := OnlineUsersz."First Name" + ' ' + OnlineUsersz."Middle Name" + ' ' + OnlineUsersz."Last Name";
            Message := TXTCorrectDetails + '::' + OnlineUsersz."Email Address" + '::' + OnlineUsersz."ID No" + '::' + FullNames;
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;


    procedure CheckOnlineAccountStatus(username: Text) Message: Text
    begin
        OnlineUsersz.Reset;
        OnlineUsersz.SetRange(OnlineUsersz."Email Address", username);
        if OnlineUsersz.Find('-') then begin
            Message := Format(OnlineUsersz.Confirmed);
        end
    end;


    procedure GetAdmissionNo(IdNumber: Text) Message: Text
    begin
        AplicFormHeader.Reset;
        AplicFormHeader.SetRange(AplicFormHeader."ID Number", IdNumber);
        if AplicFormHeader.Find('-') then begin
            Message := AplicFormHeader."Admission No" + '::' + AplicFormHeader."Application No." + '::' + AplicFormHeader."First Degree Choice" + '::' + Format(AplicFormHeader.Gender) + '::' + Format(AplicFormHeader."Academic Year");
        end
    end;


    procedure GetOnlineUserDetails(username: Text) Message: Text
    begin
        OnlineUsersz.Reset;
        OnlineUsersz.SetRange(OnlineUsersz."Email Address", username);
        //OnlineUsersz.SETRANGE(OnlineUsersz.Password,passrd);
        if OnlineUsersz.Find('-') then begin
            Message := OnlineUsersz."Email Address" + '::' + OnlineUsersz."Phone No" + '::' + Format(OnlineUsersz.Gender) + '::' + OnlineUsersz."First Name" + '::' + OnlineUsersz."Middle Name" + '::' + OnlineUsersz."Last Name" + '::' + OnlineUsersz."Postal Address";
        end
    end;


    procedure GetCourseApplicNumber(progz: Text; IDNumber: Text) Message: Text
    begin
        AplicFormHeader.Reset;
        AplicFormHeader.SetRange(AplicFormHeader."First Degree Choice", progz);
        AplicFormHeader.SetRange(AplicFormHeader."ID Number", IDNumber);
        if AplicFormHeader.Find('-') then begin
            Message := AplicFormHeader."Application No." + '::' + Format(AplicFormHeader."Points Acquired") + '::' + AplicFormHeader."Mean Grade Acquired";
        end
    end;

    procedure GeProgrammeMinimumPoints(ProgzCode: Text) Message: Text
    begin
        Programmezz.Reset;
        Programmezz.SetRange(Programmezz.Code, ProgzCode);
        if Programmezz.Find('-') then begin
            Message := Format(Programmezz."Minimum Points") + '::' + Programmezz."Minimum Grade";
        end
    end;

    procedure ValidateSubjectGrade(Programme: Text; SubjectCode: Text) Message: Text
    begin
        ProgEntrySubjects.Reset;
        ProgEntrySubjects.SetRange(ProgEntrySubjects.Programme, Programme);
        ProgEntrySubjects.SetRange(ProgEntrySubjects.Subject, SubjectCode);
        if ProgEntrySubjects.Find('-') then begin
            Message := Format(ProgEntrySubjects."Minimum Points") + '::' + ProgEntrySubjects."Minimum Grade" + '::' + GetAttainedPoints(ProgEntrySubjects."Minimum Grade");
        end
    end;

    procedure GetGradeForSelectedSubject(SubjectCode: Text; ApplicationNo: Text) Message: Text
    begin
        ApplicFormAcademic.Reset;
        ApplicFormAcademic.SetRange(ApplicFormAcademic."Subject Code", SubjectCode);
        ApplicFormAcademic.SetRange(ApplicFormAcademic."Application No.", ApplicationNo);
        if ApplicFormAcademic.Find('-') then begin
            Message := ApplicFormAcademic.Grade;
        end
    end;

    procedure SubmitOnlineCourseApplication(Surnamez: Text; OtherNames: Text; DateOfBirth: Date; Gender: Integer; IDNumber: Text; PermanentHomeAddress: Text; CorrAddress: Text; MobileNo: Text; EmailAddress: Text; programz: Text; CampusCode: Text; ModeOfStudy: Text; HowDid: Text)
    var
        KUCCPSImports: Record "KUCCPS Imports";
    begin
        Clear(KUCCPSRaw);
        AplicFormHeader.Init;
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('APP', 0D, true);
        AplicFormHeader."Application No." := NextLeaveApplicationNo;
        AplicFormHeader.Date := Today;
        AplicFormHeader."Application Date" := Today;
        AplicFormHeader."Date of Receipt" := Today;
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
        AplicFormHeader."No. Series" := 'APP';
        AplicFormHeader."Mode of Study" := ModeOfStudy;
        AplicFormHeader."Knew College Thru" := HowDid;
        AplicFormHeader.OnlineSeq := 1;
        AplicFormHeader.Insert(true);
    end;

    procedure SubmitSujects(ApplicationNo: Text; SubjectCode: Text; MinGrade: Text; Gradez: Text) Message: Text
    begin
        ApplicFormAcademic.Reset;
        ApplicFormAcademic.SetRange(ApplicFormAcademic."Application No.", ApplicationNo);
        ApplicFormAcademic.SetRange(ApplicFormAcademic."Subject Code", SubjectCode);

        if not ApplicFormAcademic.Find('-') then begin
            ApplicFormAcademic.Init;
            ApplicFormAcademic."Application No." := ApplicationNo;
            ApplicFormAcademic."Subject Code" := SubjectCode;
            ApplicFormAcademic."Min Grade" := MinGrade;
            ApplicFormAcademic.Grade := Gradez;
            ApplicFormAcademic.Insert(true);
        end else begin
            ApplicFormAcademic."Min Grade" := MinGrade;
            ApplicFormAcademic.Grade := Gradez;
            ApplicFormAcademic.Modify;
        end;
    end;

    procedure UpdateApplication(gradez: Text; pointz: Integer; ApplicationNo: Text)
    begin
        ApplicFormAcademic.Reset;
        ApplicFormAcademic.SetRange(ApplicFormAcademic."Application No.", ApplicationNo);

        if ApplicFormAcademic.Find('-') then begin
            ApplicFormAcademic.Grade := gradez;
            ApplicFormAcademic.Points := pointz;
            ApplicFormAcademic.Modify;
        end;
    end;

    procedure GetAttainedPoints(AttainedCode: Code[30]) Message: Text
    var
        ACAApplicSetupGrade: Record "ACA-Applic. Setup Grade";
    begin
        Clear(Message);
        if ACAApplicSetupGrade.Get(AttainedCode) then begin
            ACAApplicSetupGrade.Reset;
            if ACAApplicSetupGrade.Find('-') then Message := Format(ACAApplicSetupGrade.Points);
        end;
    end;

    procedure CurrentIntake() Message: Text
    begin
        Intake.Reset;
        Intake.SetRange(Intake.Current, true);
        if Intake.Find('-') then begin
            Message := Intake.Code + '::' + Intake.Description;
        end
    end;

    procedure GetOnlineUserDetailsMore(username: Text) Message: Text
    begin
        OnlineUsersz.Reset;
        OnlineUsersz.SetRange(OnlineUsersz."Email Address", username);
        //OnlineUsersz.SETRANGE(OnlineUsersz.Password,passrd);
        if OnlineUsersz.Find('-') then begin
            Message := Format(OnlineUsersz."Marital Status") + '::' + Format(OnlineUsersz.County) + '::' + Format(OnlineUsersz.Nationality) + '::' + Format(OnlineUsersz.DoB);
        end
    end;

    procedure GetProgramSemesters(Progz: Code[50]) Message: Text
    begin
        ProgramSem.Reset;
        ProgramSem.SetRange(ProgramSem."Programme Code", Progz);
        ProgramSem.SetRange(ProgramSem.Current, true);
        if ProgramSem.Find('-') then begin
            Message := ProgramSem.Semester;

        end
    end;


    procedure UpdateApplicationLevel(ApplicNum: Text; NumSq: Integer)
    begin
        AplicFormHeader.Reset;
        AplicFormHeader.SetRange(AplicFormHeader."Application No.", ApplicNum);

        if AplicFormHeader.Find('-') then begin
            AplicFormHeader.OnlineSeq := NumSq;
            AplicFormHeader.Modify;
        end;
    end;


    procedure UpdateApplicationIntake(AppLicNum: Text; Intake: Text; academicYear: Text)
    begin
        AplicFormHeader.Reset;
        AplicFormHeader.SetRange(AplicFormHeader."Application No.", AppLicNum);

        if AplicFormHeader.Find('-') then begin
            AplicFormHeader."Academic Year" := academicYear;
            AplicFormHeader."Intake Code" := Intake;
            AplicFormHeader.Modify;
        end;
    end;


    procedure UpdateApplicationPayments(ApplicNum: Text; PayMode: Text; TransID: Text)
    begin
        AplicFormHeader.Reset;
        AplicFormHeader.SetRange(AplicFormHeader."Application No.", ApplicNum);

        if AplicFormHeader.Find('-') then begin
            AplicFormHeader."Mode Of Payment" := PayMode;
            AplicFormHeader."Receipt Slip No." := TransID;
            AplicFormHeader.Modify;
        end;
    end;


    procedure GenerateOfferLetter(AdmNo: Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        filename := FILESPATH_A + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, AdmNo);

        if KUCCPSRaw.Find('-') then begin
            Report.SaveAsPdf(Report::"Official Admission LetterJAb", filename, KUCCPSRaw);
        end;

        //filename :=FILESPATH_A+filenameFromApp;
        //IF EXISTS(filename) THEN
        // ERASE(filename);
        //AdmissionFormHeader.RESET;
        //AdmissionFormHeader.SETRANGE(AdmissionFormHeader."Admission No.",AdmNo);

        //IF AdmissionFormHeader.FIND('-') THEN BEGIN
        //  REPORT.SAVEASPDF(51339,filename,AdmissionFormHeader);Report::"Official Admission LetterJAb"
        //END;
    end;


    procedure CloseHelpDeskIssue(IssueId: Integer) ReturnValue: Text[150]
    var
        HelpDeskHeader: Record "HelpDesk Header";
    begin
        ReturnValue := 'FAILED';
        HelpDeskHeader.Reset;
        HelpDeskHeader.SetRange(Code, IssueId);
        if HelpDeskHeader.Find('-') then begin
            HelpDeskHeader.Status := HelpDeskHeader.Status::Closed;
            HelpDeskHeader.Modify;
            ReturnValue := 'SUCCESS'
        end;
    end;


    procedure GetRegTrans(Username: Text) Message: Text
    begin
        CourseReg.Reset;
        CourseReg.SetRange(CourseReg."Student No.", Username);
        CourseReg.SetRange(CourseReg.Reversed, false);
        CourseReg.SetCurrentkey(Stage);
        if CourseReg.Find('+') then begin
            Message := CourseReg."Reg. Transacton ID" + '::' + CourseReg.Programmes + '::' + CourseReg.Semester;
        end
    end;


    procedure GetEvalFaculty("Code": Text) Message: Text
    begin
        Programmezz.Reset;
        Programmezz.SetRange(Programmezz.Code, Code);
        if Programmezz.Find('-') then begin
            Message := Programmezz.Faculty + '::' + Programmezz."Department Code" + '::' + Programmezz.Description;
        end
    end;


    procedure GetStudentGender(Username: Text) Message: Text
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", Username);
        if Customer.Find('-') then begin
            Message := Format(Customer.Gender);
        end
    end;


    procedure GetEvalStage(Username: Text; TransID: Text) Message: Text
    begin
        CourseReg.Reset;
        CourseReg.SetRange(CourseReg."Student No.", Username);
        CourseReg.SetRange(CourseReg."Reg. Transacton ID", TransID);
        CourseReg.SetRange(CourseReg.Reversed, false);
        if CourseReg.Find('-') then begin
            Message := CourseReg.Stage + '::' + CourseReg.Programmes;
        end
    end;


    procedure GetEvalStageDesc("Code": Text) Message: Text
    begin
        Stages.Reset;
        Stages.SetRange(Stages.Code, Code);
        if Stages.Find('-') then begin
            Message := Stages.Description;
        end
    end;


    procedure GetEvalFacultyDesc("Code": Text) Message: Text
    begin
        Dimensions.Reset;
        Dimensions.SetRange(Dimensions.Code, Code);
        Dimensions.SetRange(Dimensions."Dimension Code", 'SCHOOL');
        if Dimensions.Find('-') then begin
            Message := Dimensions.Name;
        end
    end;


    procedure GetTotalEvalQuiz(semester: Text) Message: Text
    begin
        EvaluationQuiz.Reset;
        EvaluationQuiz.SetRange(EvaluationQuiz.Semester, semester);
        if EvaluationQuiz.Find('-') then begin
            Message := Format(EvaluationQuiz.Count);
        end
    end;


    procedure GetTotalEvalRespondedQuiz(username: Text; semesterz: Text; Unitz: Text) Message: Text
    begin
        LecEvaluation.Reset;
        LecEvaluation.SetRange(LecEvaluation."Student No", username);
        LecEvaluation.SetRange(LecEvaluation.Semester, semesterz);
        LecEvaluation.SetRange(LecEvaluation.Unit, Unitz);
        if LecEvaluation.Find('-') then begin
            Message := Format(LecEvaluation.Count);
        end
    end;

    procedure GetOnlineSessionID(sessionIDz: Text) Message: Text
    var
        TXTIncorrectDetails: label 'No';
        TXTCorrectDetails: label 'Yes';
    begin
        OnlineUsersz.Reset;
        OnlineUsersz.SetRange(OnlineUsersz.SessionID, sessionIDz);
        if OnlineUsersz.Find('-') then begin
            Message := TXTCorrectDetails;
        end else begin
            Message := TXTIncorrectDetails;
        end
    end;

    procedure RecruitmentAccountActivated(Email: Text) Message: Boolean
    begin
        RecAccountusers.Reset;
        RecAccountusers.SetRange("Email Address", Email);
        if RecAccountusers.Find('-') then begin
            Message := RecAccountusers."Account Confirmed";
        end;
    end;

    procedure RecruitmentEmailExists(Email: Text) Message: Boolean
    begin
        RecAccountusers.Reset;
        RecAccountusers.SetRange("Email Address", Email);
        if RecAccountusers.Find('-') then begin
            Message := true;
        end;
    end;

    procedure ActivateRecruitmentAccount(Email: Text; ActivationCode: Code[10]) Message: Boolean
    begin
        RecAccountusers.Reset;
        RecAccountusers.SetRange("Email Address", Email);
        RecAccountusers.SetRange("SessionKey", ActivationCode);
        if RecAccountusers.Find('-') then begin
            RecAccountusers."Account Confirmed" := true;
            RecAccountusers.Modify;
            Message := true;
        end;
    end;

    procedure ActivateOnlineUserAccount(sessionIDz: Text) Message: Text
    begin
        OnlineUsersz.Reset;
        OnlineUsersz.SetRange(OnlineUsersz.SessionID, sessionIDz);
        if OnlineUsersz.Find('-') then begin
            Message := Format(OnlineUsersz.Confirmed);
            OnlineUsersz.Confirmed := true;
            OnlineUsersz.Modify;
        end;
    end;

    procedure GetOnlineEmailExists(emailaddress: Text) Message: Text
    var
        TXTIncorrectDetails: label 'No';
        TXTCorrectDetails: label 'Yes';
    begin
        OnlineUsersz.Reset;
        OnlineUsersz.SetRange(OnlineUsersz."Email Address", emailaddress);
        if OnlineUsersz.Find('-') then begin
            Message := TXTCorrectDetails;
        end else begin
            Message := TXTIncorrectDetails;
        end
    end;


    procedure GetKUCCPSUserProfile(username: Text) Message: Text
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            Message := KUCCPSRaw.Names + '::' + KUCCPSRaw."ID Number/BirthCert" + '::' + Format(KUCCPSRaw.Gender) + '::' +
  KUCCPSRaw."Primary Index no" + '::' + KUCCPSRaw."Intake Code" + '::' + KUCCPSRaw.Box + '::' + KUCCPSRaw.Codes + '::' +
  KUCCPSRaw.Town + '::' + Format(KUCCPSRaw."Date of Birth") + '::' + Format(KUCCPSRaw.County) + '::' + KUCCPSRaw.Phone
  + '::' + KUCCPSRaw.Email + '::' + KUCCPSRaw."Full Name of Father" + '::' + KUCCPSRaw."Place of Birth";
        end
    end;


    procedure KuccpsProfileUpdated(username: Text) Message: Text
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            Message := Format(KUCCPSRaw.Updated) + '::' + Format(KUCCPSRaw.Results);
        end
    end;


    procedure GetPersonaldata(username: Text) Message: Text
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            Message := KUCCPSRaw.Names + '::' + KUCCPSRaw."ID Number/BirthCert" + '::' + KUCCPSRaw."NIIMS No" + '::' + Format(KUCCPSRaw."Date of Birth") + '::' + Format(KUCCPSRaw.Gender) + '::' +
            Format(KUCCPSRaw."Physical Impairments") + '::' + KUCCPSRaw."Physical impairments Details" + '::' + KUCCPSRaw."NHIF No" + '::' + Format(KUCCPSRaw.Religion) + '::' +
            Format(KUCCPSRaw.Nationality) + '::' + KUCCPSRaw."Alt. Phone" + '::' + KUCCPSRaw.Box + '::' + KUCCPSRaw.Codes
            + '::' + KUCCPSRaw.Town + '::' + KUCCPSRaw."Slt Mail" + '::' + Format(KUCCPSRaw."Marital Status") + '::' + KUCCPSRaw.Tribe + '::' + KUCCPSRaw."Name of Spouse"
            + '::' + KUCCPSRaw."Occupation of Spouse" + '::' + KUCCPSRaw."Spouse Phone No" + '::' + KUCCPSRaw."Number of Children" + '::';
        end
    end;


    procedure GetKuccpsFamilydata(username: Text) Message: Text
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            Message := KUCCPSRaw."Full Name of Father" + '::' + Format(KUCCPSRaw."Father Status") + '::' + KUCCPSRaw."Father Occupation" + '::' + Format(KUCCPSRaw."Father Date of Birth") + '::' + KUCCPSRaw."Name of Mother" + '::' +
            Format(KUCCPSRaw."Mother Status") + '::' + KUCCPSRaw."Mother Occupation" + '::' + Format(KUCCPSRaw."Mother Date of Birth") + '::' + KUCCPSRaw."Number of brothers and sisters" + '::' + KUCCPSRaw."Father Telephone" + '::' + KUCCPSRaw."Mother Telephone";
        end
    end;


    procedure MarkKUCCPSDetailsUpdated(username: Text) Msg: Boolean
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            KUCCPSRaw.Updated := true;
            KUCCPSRaw.Confirmed := true;
            if KUCCPSRaw.Modify then begin
                KUCCPSRaw.Validate(Confirmed);
                Message('Confirmed!');
            end;
            Msg := true;
        end
    end;


    procedure GetKuccpsAccommodationData(username: Text) Message: Text
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            Message := Format(KUCCPSRaw.Accomodation) + '::' + KUCCPSRaw."Non-Resident Owner" + '::' + KUCCPSRaw."Non-Resident Address" + '::' + KUCCPSRaw."Residential Owner Phone" + '::' + KUCCPSRaw."Assigned Block" + '::' +
            KUCCPSRaw."Assigned Room" + '::' + KUCCPSRaw."Assigned Space";
        end
    end;


    procedure GetKuccpsResidencedata(username: Text) Message: Text
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            Message := KUCCPSRaw."Place of Birth" + '::' + KUCCPSRaw."Permanent Residence" + '::' + KUCCPSRaw."Nearest Town" + '::' + KUCCPSRaw.Location + '::' + KUCCPSRaw."Name of Chief" + '::' +
            Format(KUCCPSRaw.County) + '::' + KUCCPSRaw."Sub-County" + '::' + KUCCPSRaw.Constituency + '::' + KUCCPSRaw."Nearest Police Station";
        end
    end;


    procedure GetKuccpsEmmergencydata(username: Text) Message: Text
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            Message := KUCCPSRaw."Emergency Name1" + '::' + KUCCPSRaw."Emergency Relationship1" + '::' + KUCCPSRaw."Emergency P.O. Box1" + '::' + KUCCPSRaw."Emergency Phone No1" + '::' + KUCCPSRaw."Emergency Email1" + '::' +
            KUCCPSRaw."Emergency Name2" + '::' + KUCCPSRaw."Emergency Relationship2" + '::' + KUCCPSRaw."Emergency P.O. Box2" + '::' + KUCCPSRaw."Emergency Phone No2" + '::' + KUCCPSRaw."Emergency Email2";
        end
    end;


    procedure GetKuccpsAcademicdata(username: Text) Message: Text
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            Message := KUCCPSRaw."OLevel School" + '::' + KUCCPSRaw.Index + '::' + KUCCPSRaw."OLevel Year Completed" + '::' + KUCCPSRaw."Primary School" + '::' + KUCCPSRaw."Primary Index no" + '::' +
            KUCCPSRaw."Primary Year Completed" + '::' + KUCCPSRaw."K.C.P.E. Results" + '::' + KUCCPSRaw."Any Other Institution Attended";
        end
    end;


    procedure UpdateKUCCPSPersonalDetails(username: Text; Namesz: Text; Genderz: Integer; Phonez: Code[20]; Boxz: Code[50]; Codesz: Code[20]; Townz: Code[40]; Tribez: Code[50]; Emailz: Text; DateofBirth: Date; IDNumber: Text; NIIMSNo: Text; PhysicalImpairments: Boolean; PhysicalImpairmentsDetails: Text; NHIFNo: Text; Religionz: Code[50]; Nationalityz: Code[50]; MaritalStatus: Integer; NameOfSpouse: Text; OccupationOfSpouse: Text; SpousePhoneNo: Code[30]; NumberOfChildren: Text)
    var
        Headers: Record "ACA-Applic. Form Header";
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            KUCCPSRaw.Names := Namesz;
            KUCCPSRaw.Gender := Genderz;
            KUCCPSRaw."Alt. Phone" := Phonez;
            KUCCPSRaw.Box := Boxz;
            KUCCPSRaw.Codes := Codesz;
            KUCCPSRaw.Town := Townz;
            KUCCPSRaw.Tribe := Tribez;
            KUCCPSRaw."Slt Mail" := Emailz;
            KUCCPSRaw."Date of Birth" := DateofBirth;
            KUCCPSRaw."ID Number/BirthCert" := IDNumber;
            KUCCPSRaw."NIIMS No" := NIIMSNo;
            KUCCPSRaw."Physical Impairments" := PhysicalImpairments;
            KUCCPSRaw."Physical impairments Details" := PhysicalImpairmentsDetails;
            KUCCPSRaw."NHIF No" := NHIFNo;
            KUCCPSRaw.Religion := Religionz;
            KUCCPSRaw.Nationality := Nationalityz;
            KUCCPSRaw."Marital Status" := MaritalStatus;
            KUCCPSRaw."Name of Spouse" := NameOfSpouse;
            KUCCPSRaw."Occupation of Spouse" := OccupationOfSpouse;
            KUCCPSRaw."Spouse Phone No" := SpousePhoneNo;
            KUCCPSRaw."Number of Children" := NumberOfChildren;
            if KUCCPSRaw.Modify then begin
                Clear(Headers);
                Headers.Reset;
                Headers.SetRange("Admission No", username);
                if Headers.Find('-') then begin
                    repeat
                    begin
                        Headers.Email := KUCCPSRaw.Email;
                        Headers."Emergency Email" := KUCCPSRaw."Slt Mail";
                        Headers."ID Number" := KUCCPSRaw."ID Number/BirthCert";
                        Headers."Date Of Birth" := KUCCPSRaw."Date of Birth";
                        Headers.County := KUCCPSRaw.County;
                        Headers.Phone := KUCCPSRaw.Phone;
                        Headers."Alt. Phone" := KUCCPSRaw."Alt. Phone";
                        Headers.Box := KUCCPSRaw.Box;
                        Headers.Town := KUCCPSRaw.Town;
                        Headers."NHIF No" := KUCCPSRaw."NHIF No";
                        Headers.Location := KUCCPSRaw.Location;
                        Headers."Name of Chief" := KUCCPSRaw."Name of Chief";
                        Headers."Sub-County" := KUCCPSRaw."Sub-County";
                        Headers.Constituency := KUCCPSRaw.Constituency;
                        Headers."OLevel School" := KUCCPSRaw."OLevel School";
                        Headers."OLevel Year Completed" := KUCCPSRaw."OLevel Year Completed";
                        Headers."Telephone No. 1" := KUCCPSRaw.Phone;
                        Headers."Telephone No. 2" := KUCCPSRaw."Emergency Phone No1";
                        Headers."Address for Correspondence1" := KUCCPSRaw.Box;
                        Headers."Address for Correspondence2" := KUCCPSRaw.Codes;
                        Headers."Address for Correspondence3" := KUCCPSRaw.Town;
                        if Headers.Modify(true) then;
                    end;
                    until Headers.Next = 0;
                end;
            end;
        end;
    end;


    procedure UpdateKUCCPSFamilyDetails(username: Text; FullNameofFather: Text; FatherStatus: Integer; FatherOccupation: Text; FatherDateOfBirth: Date; NameOfMother: Text; MotherStatus: Integer; MotherOccupation: Text; MotherDateOfBirth: Date; NumberOfbrothersandsisters: Code[20]; FatherPhone: Code[20]; MotherPhone: Code[20])
    var
        Headers: Record "ACA-Applic. Form Header";
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            KUCCPSRaw."Full Name of Father" := FullNameofFather;
            KUCCPSRaw."Father Status" := FatherStatus;
            KUCCPSRaw."Father Occupation" := FatherOccupation;
            KUCCPSRaw."Father Date of Birth" := FatherDateOfBirth;
            KUCCPSRaw."Father Telephone" := FatherPhone;
            KUCCPSRaw."Mother Telephone" := MotherPhone;
            KUCCPSRaw."Name of Mother" := NameOfMother;
            KUCCPSRaw."Mother Status" := MotherStatus;
            KUCCPSRaw."Mother Occupation" := MotherOccupation;
            KUCCPSRaw."Mother Date of Birth" := MotherDateOfBirth;
            KUCCPSRaw."Number of brothers and sisters" := NumberOfbrothersandsisters;
            if KUCCPSRaw.Modify then begin
                Clear(Headers);
                Headers.Reset;
                Headers.SetRange("Admission No", username);
                if Headers.Find('-') then begin
                    repeat
                    begin
                        Headers.Email := KUCCPSRaw.Email;
                        Headers."Emergency Email" := KUCCPSRaw."Slt Mail";
                        Headers."ID Number" := KUCCPSRaw."ID Number/BirthCert";
                        Headers."Date Of Birth" := KUCCPSRaw."Date of Birth";
                        Headers.County := KUCCPSRaw.County;
                        Headers.Phone := KUCCPSRaw.Phone;
                        Headers."Alt. Phone" := KUCCPSRaw."Alt. Phone";
                        Headers.Box := KUCCPSRaw.Box;
                        Headers.Town := KUCCPSRaw.Town;
                        Headers."NHIF No" := KUCCPSRaw."NHIF No";
                        Headers.Location := KUCCPSRaw.Location;
                        Headers."Name of Chief" := KUCCPSRaw."Name of Chief";
                        Headers."Sub-County" := KUCCPSRaw."Sub-County";
                        Headers.Constituency := KUCCPSRaw.Constituency;
                        Headers."OLevel School" := KUCCPSRaw."OLevel School";
                        Headers."OLevel Year Completed" := KUCCPSRaw."OLevel Year Completed";
                        Headers."Telephone No. 1" := KUCCPSRaw.Phone;
                        Headers."Telephone No. 2" := KUCCPSRaw."Emergency Phone No1";
                        Headers."Address for Correspondence1" := KUCCPSRaw.Box;
                        Headers."Address for Correspondence2" := KUCCPSRaw.Codes;
                        Headers."Address for Correspondence3" := KUCCPSRaw.Town;
                        if Headers.Modify(true) then;
                    end;
                    until Headers.Next = 0;
                end;
            end;
        end;
    end;


    procedure UpdateKUCCPSResidenceDetails(username: Text; PlaceOfBirth: Text; PermanentResidence: Text; NearestTown: Text; Locationz: Text; NameOfChief: Text; Countyz: Code[50]; SubCounty: Text; Constituencyz: Text; NearestPoliceStation: Text)
    var
        Headers: Record "ACA-Applic. Form Header";
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            KUCCPSRaw."Place of Birth" := PlaceOfBirth;
            KUCCPSRaw."Permanent Residence" := PermanentResidence;
            KUCCPSRaw."Nearest Town" := NearestTown;
            KUCCPSRaw.Location := Locationz;
            KUCCPSRaw."Name of Chief" := NameOfChief;
            KUCCPSRaw.County := Countyz;

            KUCCPSRaw."Sub-County" := SubCounty;
            KUCCPSRaw.Constituency := Constituencyz;
            KUCCPSRaw."Nearest Police Station" := NearestPoliceStation;
            if KUCCPSRaw.Modify then begin
                Clear(Headers);
                Headers.Reset;
                Headers.SetRange("Admission No", username);
                if Headers.Find('-') then begin
                    repeat
                    begin
                        Headers.Email := KUCCPSRaw.Email;
                        Headers."Emergency Email" := KUCCPSRaw."Slt Mail";
                        Headers."ID Number" := KUCCPSRaw."ID Number/BirthCert";
                        Headers."Date Of Birth" := KUCCPSRaw."Date of Birth";
                        Headers.County := KUCCPSRaw.County;
                        //Headers.Tr
                        Headers.Phone := KUCCPSRaw.Phone;
                        Headers."Alt. Phone" := KUCCPSRaw."Alt. Phone";
                        Headers.Box := KUCCPSRaw.Box;
                        Headers.Town := KUCCPSRaw.Town;
                        Headers."NHIF No" := KUCCPSRaw."NHIF No";
                        Headers.Location := KUCCPSRaw.Location;
                        Headers."Name of Chief" := KUCCPSRaw."Name of Chief";
                        Headers."Sub-County" := KUCCPSRaw."Sub-County";
                        Headers.Constituency := KUCCPSRaw.Constituency;
                        Headers."OLevel School" := KUCCPSRaw."OLevel School";
                        Headers."OLevel Year Completed" := KUCCPSRaw."OLevel Year Completed";
                        Headers."Telephone No. 1" := KUCCPSRaw.Phone;
                        Headers."Telephone No. 2" := KUCCPSRaw."Emergency Phone No1";
                        Headers."Address for Correspondence1" := KUCCPSRaw.Box;
                        Headers."Address for Correspondence2" := KUCCPSRaw.Codes;
                        Headers."Address for Correspondence3" := KUCCPSRaw.Town;
                        if Headers.Modify(true) then;
                    end;
                    until Headers.Next = 0;
                end;
            end;
        end;
    end;


    procedure UpdateKUCCPSProfile(username: Text; Namesz: Text; Genderz: Integer; Phonez: Code[20]; Boxz: Code[50]; Codesz: Code[20]; Townz: Code[40]; Emailz: Text; Countyz: Code[50]; Tribe: Code[50]; DateofBirth: Date; IDNumber: Text; NIIMSNo: Text; PhysicalImpairments: Boolean; PhysicalImpairmentsDetails: Text; NHIFNo: Text; Religionz: Code[50]; Nationalityz: Code[50]; MaritalStatus: Integer; NameOfSpouse: Text; OccupationOfSpouse: Text; SpousePhoneNo: Code[30]; NumberOfChildren: Text; FullNameofFather: Text; FatherStatus: Integer; FatherOccupation: Text; FatherDateOfBirth: Date; NameOfMother: Text; MotherStatus: Integer; MotherOccupation: Text; MotherDateOfBirth: Date; NumberOfbrothersandsisters: Code[20]; PlaceOfBirth: Text; PermanentResidence: Text; NearestTown: Text; Locationz: Text; NameOfChief: Text; SubCounty: Text; Constituencyz: Text; NearestPoliceStation: Text)
    var
        Headers: Record "ACA-Applic. Form Header";
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            KUCCPSRaw.Names := Namesz;
            KUCCPSRaw.Gender := Genderz;
            KUCCPSRaw.Phone := Phonez;
            KUCCPSRaw.Box := Boxz;
            KUCCPSRaw.Codes := Codesz;
            KUCCPSRaw.Town := Townz;
            KUCCPSRaw.Email := Emailz;
            KUCCPSRaw.County := Countyz;
            KUCCPSRaw.Tribe := Tribe;
            KUCCPSRaw."Date of Birth" := DateofBirth;
            KUCCPSRaw."ID Number/BirthCert" := IDNumber;
            KUCCPSRaw."NIIMS No" := NIIMSNo;
            KUCCPSRaw."Physical Impairments" := PhysicalImpairments;
            KUCCPSRaw."Physical impairments Details" := PhysicalImpairmentsDetails;
            KUCCPSRaw."NHIF No" := NHIFNo;
            KUCCPSRaw.Religion := Religionz;
            KUCCPSRaw.Nationality := Nationalityz;
            KUCCPSRaw."Marital Status" := MaritalStatus;
            KUCCPSRaw."Name of Spouse" := NameOfSpouse;
            KUCCPSRaw."Occupation of Spouse" := OccupationOfSpouse;
            KUCCPSRaw."Spouse Phone No" := SpousePhoneNo;
            KUCCPSRaw."Number of Children" := NumberOfChildren;
            KUCCPSRaw."Full Name of Father" := FullNameofFather;
            KUCCPSRaw."Father Status" := FatherStatus;
            KUCCPSRaw."Father Occupation" := FatherOccupation;
            KUCCPSRaw."Father Date of Birth" := FatherDateOfBirth;
            KUCCPSRaw."Name of Mother" := NameOfMother;
            KUCCPSRaw."Mother Status" := MotherStatus;
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

            KUCCPSRaw.Updated := true;
            if KUCCPSRaw.Modify then begin
                Clear(Headers);
                Headers.Reset;
                Headers.SetRange("Admission No", username);
                if Headers.Find('-') then begin
                    repeat
                    begin
                        Headers.Email := KUCCPSRaw.Email;
                        Headers."Emergency Email" := KUCCPSRaw."Slt Mail";
                        Headers."ID Number" := KUCCPSRaw."ID Number/BirthCert";
                        Headers."Date Of Birth" := KUCCPSRaw."Date of Birth";
                        Headers.County := KUCCPSRaw.County;
                        Headers.Tribe := KUCCPSRaw.Tribe;
                        Headers.Phone := KUCCPSRaw.Phone;
                        Headers."Alt. Phone" := KUCCPSRaw."Alt. Phone";
                        Headers.Box := KUCCPSRaw.Box;
                        Headers.Town := KUCCPSRaw.Town;
                        Headers."NHIF No" := KUCCPSRaw."NHIF No";
                        Headers.Location := KUCCPSRaw.Location;
                        Headers."Name of Chief" := KUCCPSRaw."Name of Chief";
                        Headers."Sub-County" := KUCCPSRaw."Sub-County";
                        Headers.Constituency := KUCCPSRaw.Constituency;
                        Headers."OLevel School" := KUCCPSRaw."OLevel School";
                        Headers."OLevel Year Completed" := KUCCPSRaw."OLevel Year Completed";
                        Headers."Telephone No. 1" := KUCCPSRaw.Phone;
                        Headers."Telephone No. 2" := KUCCPSRaw."Emergency Phone No1";
                        Headers."Address for Correspondence1" := KUCCPSRaw.Box;
                        Headers."Address for Correspondence2" := KUCCPSRaw.Codes;
                        Headers."Address for Correspondence3" := KUCCPSRaw.Town;
                        if Headers.Modify(true) then;
                    end;
                    until Headers.Next = 0;
                end;
            end;
        end;
    end;


    procedure UpdateKUCCPSEmergencyContacts(username: Text; EmergencyName1: Text; EmergencyRelationship1: Text; EmergencyBox1: Text; EmergencyPhoneNo1: Code[30]; EmergencyEmail1: Text; EmergencyName2: Text; EmergencyRelationship2: Text; EmergencyBox2: Text; EmergencyPhoneNo2: Code[30]; EmergencyEmail2: Text)
    var
        ACAApplicFormHeader: Record "ACA-Applic. Form Header";
        Headers: Record "ACA-Applic. Form Header";
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            KUCCPSRaw."Emergency Name1" := EmergencyName1;
            KUCCPSRaw."Emergency Relationship1" := EmergencyRelationship1;
            KUCCPSRaw."Emergency P.O. Box1" := EmergencyBox1;
            KUCCPSRaw."Emergency Phone No1" := EmergencyPhoneNo1;
            KUCCPSRaw."Emergency Email1" := EmergencyEmail1;
            KUCCPSRaw."Emergency Name2" := EmergencyName2;
            KUCCPSRaw."Emergency Relationship2" := EmergencyRelationship2;
            KUCCPSRaw."Emergency P.O. Box2" := EmergencyBox2;
            KUCCPSRaw."Emergency Phone No2" := EmergencyPhoneNo2;
            KUCCPSRaw."Emergency Email2" := EmergencyEmail2;
            if KUCCPSRaw.Modify then begin
                Clear(Headers);
                Headers.Reset;
                Headers.SetRange("Admission No", username);
                if Headers.Find('-') then begin
                    repeat
                    begin
                        Headers.Email := KUCCPSRaw.Email;
                        Headers."Emergency Email" := KUCCPSRaw."Slt Mail";
                        Headers."ID Number" := KUCCPSRaw."ID Number/BirthCert";
                        Headers."Date Of Birth" := KUCCPSRaw."Date of Birth";
                        Headers.County := KUCCPSRaw.County;
                        Headers.Phone := KUCCPSRaw.Phone;
                        Headers."Alt. Phone" := KUCCPSRaw."Alt. Phone";
                        Headers.Box := KUCCPSRaw.Box;
                        Headers.Town := KUCCPSRaw.Town;
                        Headers."NHIF No" := KUCCPSRaw."NHIF No";
                        Headers.Location := KUCCPSRaw.Location;
                        Headers."Name of Chief" := KUCCPSRaw."Name of Chief";
                        Headers."Sub-County" := KUCCPSRaw."Sub-County";
                        Headers.Constituency := KUCCPSRaw.Constituency;
                        Headers."OLevel School" := KUCCPSRaw."OLevel School";
                        Headers."OLevel Year Completed" := KUCCPSRaw."OLevel Year Completed";
                        Headers."Telephone No. 1" := KUCCPSRaw.Phone;
                        Headers."Telephone No. 2" := KUCCPSRaw."Emergency Phone No1";
                        Headers."Address for Correspondence1" := KUCCPSRaw.Box;
                        Headers."Address for Correspondence2" := KUCCPSRaw.Codes;
                        Headers."Address for Correspondence3" := KUCCPSRaw.Town;
                        if Headers.Modify(true) then;
                    end;
                    until Headers.Next = 0;
                end;
            end;
        end;
    end;


    procedure UpdateKUCCPSAcademicDetails(username: Text; OLevelSchool: Text; OLevelYearCompleted: Code[20]; PrimarySchool: Text; PrimaryIndexNo: Text; PrimaryYearCompleted: Code[20]; KCPEResults: Text; AnyOtherInstitutionAttended: Text)
    var
        ACAApplicFormHeader: Record "ACA-Applic. Form Header";
        Headers: Record "ACA-Applic. Form Header";
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            KUCCPSRaw."OLevel School" := OLevelSchool;
            KUCCPSRaw."OLevel Year Completed" := OLevelYearCompleted;
            KUCCPSRaw."Primary School" := PrimarySchool;
            KUCCPSRaw."Primary Index no" := PrimaryIndexNo;
            KUCCPSRaw."Primary Year Completed" := PrimaryYearCompleted;
            KUCCPSRaw."K.C.P.E. Results" := KCPEResults;
            KUCCPSRaw."Any Other Institution Attended" := AnyOtherInstitutionAttended;
            if KUCCPSRaw.Modify then begin
                Clear(Headers);
                Headers.Reset;
                Headers.SetRange("Admission No", username);
                if Headers.Find('-') then begin
                    repeat
                    begin
                        Headers.Email := KUCCPSRaw.Email;
                        Headers."Emergency Email" := KUCCPSRaw."Slt Mail";
                        Headers."ID Number" := KUCCPSRaw."ID Number/BirthCert";
                        Headers."Date Of Birth" := KUCCPSRaw."Date of Birth";
                        Headers.County := KUCCPSRaw.County;
                        Headers.Phone := KUCCPSRaw.Phone;
                        Headers."Alt. Phone" := KUCCPSRaw."Alt. Phone";
                        Headers.Box := KUCCPSRaw.Box;
                        Headers.Town := KUCCPSRaw.Town;
                        Headers."NHIF No" := KUCCPSRaw."NHIF No";
                        Headers.Location := KUCCPSRaw.Location;
                        Headers."Name of Chief" := KUCCPSRaw."Name of Chief";
                        Headers."Sub-County" := KUCCPSRaw."Sub-County";
                        Headers.Constituency := KUCCPSRaw.Constituency;
                        Headers."OLevel School" := KUCCPSRaw."OLevel School";
                        Headers."OLevel Year Completed" := KUCCPSRaw."OLevel Year Completed";
                        Headers."Telephone No. 1" := KUCCPSRaw.Phone;
                        Headers."Telephone No. 2" := KUCCPSRaw."Emergency Phone No1";
                        Headers."Address for Correspondence1" := KUCCPSRaw.Box;
                        Headers."Address for Correspondence2" := KUCCPSRaw.Codes;
                        Headers."Address for Correspondence3" := KUCCPSRaw.Town;
                        if Headers.Modify(true) then;
                    end;
                    until Headers.Next = 0;
                end;
            end;
        end;
    end;


    procedure UpdateKUCCPSAccommodationDetails(username: Text; Accomodation: Option; NonResidentOwner: Text; NonResidentAddress: Text; NonResidentPhone: Text)
    var
        ACAApplicFormHeader: Record "ACA-Applic. Form Header";
        Headers: Record "ACA-Applic. Form Header";
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            KUCCPSRaw.Accomodation := Accomodation;
            KUCCPSRaw."Non-Resident Owner" := NonResidentOwner;
            KUCCPSRaw."Non-Resident Address" := NonResidentAddress;
            KUCCPSRaw."Residential Owner Phone" := NonResidentPhone;
            if KUCCPSRaw.Modify then begin
                Clear(Headers);
                Headers.Reset;
                Headers.SetRange("Admission No", username);
                if Headers.Find('-') then begin
                    repeat
                    begin
                        Headers.Email := KUCCPSRaw.Email;
                        Headers."Emergency Email" := KUCCPSRaw."Slt Mail";
                        Headers."ID Number" := KUCCPSRaw."ID Number/BirthCert";
                        Headers."Date Of Birth" := KUCCPSRaw."Date of Birth";
                        Headers.County := KUCCPSRaw.County;
                        Headers.Phone := KUCCPSRaw.Phone;
                        Headers."Alt. Phone" := KUCCPSRaw."Alt. Phone";
                        Headers.Box := KUCCPSRaw.Box;
                        Headers.Town := KUCCPSRaw.Town;
                        Headers."NHIF No" := KUCCPSRaw."NHIF No";
                        Headers.Location := KUCCPSRaw.Location;
                        Headers."Name of Chief" := KUCCPSRaw."Name of Chief";
                        Headers."Sub-County" := KUCCPSRaw."Sub-County";
                        Headers.Constituency := KUCCPSRaw.Constituency;
                        Headers."OLevel School" := KUCCPSRaw."OLevel School";
                        Headers."OLevel Year Completed" := KUCCPSRaw."OLevel Year Completed";
                        Headers."Telephone No. 1" := KUCCPSRaw.Phone;
                        Headers."Telephone No. 2" := KUCCPSRaw."Emergency Phone No1";
                        Headers."Address for Correspondence1" := KUCCPSRaw.Box;
                        Headers."Address for Correspondence2" := KUCCPSRaw.Codes;
                        Headers."Address for Correspondence3" := KUCCPSRaw.Town;
                        if Headers.Modify(true) then;
                    end;
                    until Headers.Next = 0;
                end;
            end;
        end;
    end;


    procedure UpdateKUCCPSProfileMore(username: Text; EmergencyName1: Text; EmergencyRelationship1: Text; EmergencyBox1: Text; EmergencyPhoneNo1: Code[30]; EmergencyEmail1: Text; EmergencyName2: Text; EmergencyRelationship2: Text; EmergencyBox2: Text; EmergencyPhoneNo2: Code[30]; EmergencyEmail2: Text; OLevelSchool: Text; OLevelYearCompleted: Code[20]; PrimarySchool: Text; PrimaryIndexNo: Text; PrimaryYearCompleted: Code[20]; KCPEResults: Text; AnyOtherInstitutionAttended: Text; Accomodation: Integer; NonResidentOwner: Text; NonResidentAddress: Text; NonResidentPhone: Text)
    var
        ACAApplicFormHeader: Record "ACA-Applic. Form Header";
        Headers: Record "ACA-Applic. Form Header";
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            KUCCPSRaw."Emergency Name1" := EmergencyName1;
            KUCCPSRaw."Emergency Relationship1" := EmergencyRelationship1;
            KUCCPSRaw."Emergency P.O. Box1" := EmergencyBox1;
            KUCCPSRaw."Emergency Phone No1" := EmergencyPhoneNo1;
            KUCCPSRaw."Emergency Email1" := EmergencyEmail1;
            KUCCPSRaw."Emergency Name2" := EmergencyName2;
            KUCCPSRaw."Emergency Relationship2" := EmergencyRelationship2;
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

            KUCCPSRaw.Accomodation := Accomodation;
            KUCCPSRaw."Non-Resident Owner" := NonResidentOwner;
            KUCCPSRaw."Non-Resident Address" := NonResidentAddress;
            KUCCPSRaw."Residential Owner Phone" := NonResidentPhone;

            KUCCPSRaw.Updated := true;
            if KUCCPSRaw.Modify then begin
                Clear(Headers);
                Headers.Reset;
                Headers.SetRange("Admission No", username);
                if Headers.Find('-') then begin
                    repeat
                    begin
                        Headers.Email := KUCCPSRaw.Email;
                        Headers."Emergency Email" := KUCCPSRaw."Slt Mail";
                        Headers."ID Number" := KUCCPSRaw."ID Number/BirthCert";
                        Headers."Date Of Birth" := KUCCPSRaw."Date of Birth";
                        Headers.County := KUCCPSRaw.County;
                        Headers.Phone := KUCCPSRaw.Phone;
                        Headers."Alt. Phone" := KUCCPSRaw."Alt. Phone";
                        Headers.Box := KUCCPSRaw.Box;
                        Headers.Town := KUCCPSRaw.Town;
                        Headers."NHIF No" := KUCCPSRaw."NHIF No";
                        Headers.Location := KUCCPSRaw.Location;
                        Headers."Name of Chief" := KUCCPSRaw."Name of Chief";
                        Headers."Sub-County" := KUCCPSRaw."Sub-County";
                        Headers.Constituency := KUCCPSRaw.Constituency;
                        Headers."OLevel School" := KUCCPSRaw."OLevel School";
                        Headers."OLevel Year Completed" := KUCCPSRaw."OLevel Year Completed";
                        Headers."Telephone No. 1" := KUCCPSRaw.Phone;
                        Headers."Telephone No. 2" := KUCCPSRaw."Emergency Phone No1";
                        Headers."Address for Correspondence1" := KUCCPSRaw.Box;
                        Headers."Address for Correspondence2" := KUCCPSRaw.Codes;
                        Headers."Address for Correspondence3" := KUCCPSRaw.Town;
                        if Headers.Modify(true) then;
                    end;
                    until Headers.Next = 0;
                end;
            end;
        end;
    end;

    procedure SubmitKuccpsSujects(AAdmissionNo: Text; SubjectCode: Text; SubjectName: Text; MinGrade: Text; Pointsz: Integer) Message: Text
    begin
        ApplicFormAcademic.Reset;
        ApplicFormAcademic.SetRange(ApplicFormAcademic."Application No.", AAdmissionNo);
        ApplicFormAcademic.SetRange(ApplicFormAcademic."Subject Code", SubjectCode);

        if not ApplicFormAcademic.Find('-') then begin
            ApplicFormAcademic.Init;
            ApplicFormAcademic."Application No." := AAdmissionNo;
            ApplicFormAcademic."Subject Code" := SubjectCode;
            ApplicFormAcademic.Subject := SubjectName;
            ApplicFormAcademic."Min Grade" := MinGrade;
            ApplicFormAcademic.Grade := MinGrade;
            ApplicFormAcademic.Points := Pointsz;
            ApplicFormAcademic.Insert(true);
        end else begin
            ApplicFormAcademic."Min Grade" := MinGrade;
            ApplicFormAcademic.Grade := MinGrade;
            ApplicFormAcademic.Points := Pointsz;
            ApplicFormAcademic.Modify;

        end;
    end;


    procedure PreRegisterKuccpsStudents(studentNo: Text; stage: Text; semester: Text; Programme: Text; AcademicYear: Text; settlementType: Text) CourseRegId: Code[30]
    var
        Progs: Code[20];
    begin
        GenSetup.Get;
        Clear(Progs);
        if Evaluate(Progs, Programme) then;
        CourseReg.Reset;
        CourseReg.SetRange(CourseReg."Student No.", studentNo);
        CourseReg.SetRange(CourseReg.Programmes, Progs);
        CourseReg.SetRange(CourseReg.Semester, semester);
        CourseReg.SetRange(CourseReg.Reversed, false);

        if CourseReg.Find('-') then
            Error('You have already registered for Semester %1, Year %2', semester, CourseReg.Stage);
        /*
        //Insert Student Course
        CourseReg.RESET;
        CourseReg.SETRANGE(CourseReg."Student No.",studentNo);
        CourseReg.SETRANGE(CourseReg.Programmes,Progs);
        CourseReg.SETRANGE(CourseReg.Semester,semester);
        CourseReg.SETRANGE(CourseReg.Reversed,FALSE);
        //CourseReg.SETRANGE(CourseReg.Stage,stage);
        //CourseReg.SETRANGE(CourseReg."Settlement Type", settlementType);
        
        IF CourseReg.FIND('-') THEN BEGIN
        
        CourseRegId:=CourseReg."Reg. Transacton ID";
        //CourseReg.Programmes:=Progs;
        CourseReg.VALIDATE(Programme,Progs);
        //CourseReg.Stage:=stage;
        CourseReg.VALIDATE(Stage);
        CourseReg.Semester:=semester;
        CourseReg."Academic Year":=AcademicYear;
        CourseReg."Settlement Type":=settlementType;
        
        CourseReg.MODIFY(TRUE);
        
        END ELSE BEGIN*/
        CourseReg.Init;
        CourseRegId := NoSeriesMgt.GetNextNo(GenSetup."Registration Nos.", Today, true);
        CourseReg."Reg. Transacton ID" := CourseRegId;
        CourseReg."Student No." := studentNo;
        CourseReg.Programmes := Progs;
        CourseReg.Validate(Programmes);
        //CourseReg.Stage:=stage;
        CourseReg.Validate(Stage);
        //CourseReg."Date Registered":=TODAY;
        //CourseReg.Semester:=semester;
        //CourseReg."Academic Year":=AcademicYear;
        CourseReg.Validate("Settlement Type", settlementType);
        CourseReg.Insert(true);

        //END;

    end;


    procedure UpdateKCSEResults(username: Text)
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(KUCCPSRaw.Admin, username);
        if KUCCPSRaw.Find('-') then begin
            KUCCPSRaw.Results := true;
            KUCCPSRaw.Modify;
        end;
    end;


    procedure IsStudentKuccpsRegistered(StudentNo: Text; Stage: Text) Message: Text
    var
        TXTNotRegistered: label 'Not registered';
        TXTRegistered: label 'Registered';
    begin
        CourseRegistration.Reset;
        CourseRegistration.SetRange(CourseRegistration."Student No.", StudentNo);
        CourseRegistration.SetRange(CourseRegistration.Stage, Stage);
        CourseRegistration.SetRange(CourseRegistration.Reversed, false);
        if CourseRegistration.Find('-') then begin
            Message := TXTRegistered + '::';
        end else begin
            Message := TXTNotRegistered + '::';
        end
    end;


    procedure HasKuccpsFinances(StudentNo: Text) Message: Text
    var
        TXTNotRegistered: label 'No';
        TXTRegistered: label 'Yes';
    begin
        ImportsBuffer.Reset;
        ImportsBuffer.SetRange(ImportsBuffer."Student No.", StudentNo);
        if ImportsBuffer.Find('-') then begin
            Message := TXTRegistered + '::';
        end else begin
            Message := TXTNotRegistered + '::';
        end
    end;


    procedure TransferToAdmission(AdmissionNumber: Code[20])
    var
        AdminSetup: Record "KUCCPS Imports";
        NewAdminCode: Code[20];
    begin
        /*This function transfers the fieldsin the application to the fields in the admissions table*/
        /*Get the new admission code for the selected application*/

        AdminSetup.Reset;
        AdminSetup.SetRange(AdminSetup.Admin, AdmissionNumber);
        AdminSetup.SetRange(AdminSetup.Results, true);
        if AdminSetup.Find('-') then begin
            Customer.Init;
            Customer."No." := AdminSetup.Admin;
            Customer.Name := CopyStr(AdminSetup.Names, 1, 80);
            Customer."Search Name" := UpperCase(CopyStr(AdminSetup.Names, 1, 80));
            Customer.Address := CopyStr(AdminSetup.Box + ',' + AdminSetup.Codes, 1, 30);
            if AdminSetup.Box <> '' then
                Customer."Address 2" := AdminSetup.Town;
            if AdminSetup.Phone <> '' then
                Customer."Phone No." := AdminSetup.Phone + ',' + AdminSetup."Alt. Phone";
            //  Customer."Telex No.":=Rec."Fax No.";
            Customer."E-Mail" := AdminSetup.Email;
            Customer.Gender := AdminSetup.Gender;
            Customer."Date Of Birth" := AdminSetup."Date of Birth";
            Customer."Date Registered" := Today;
            Customer."Customer Type" := Customer."customer type"::Student;
            //Customer."Student Type":=FORMAT(Enrollment."Student Type");
            Customer."Date Of Birth" := AdminSetup."Date of Birth";
            Customer."ID No" := AdminSetup."ID Number/BirthCert";
            Customer."Application No." := AdminSetup.Admin;
            Customer."Marital Status" := AdminSetup."Marital Status";
            Customer.Citizenship := Format(AdminSetup.Nationality);
            Customer."Current Programme" := AdminSetup.Prog;
            Customer."Current Semester" := 'SEM1 23/24';
            Customer."Current Stage" := 'Y1S1';
            Customer.Religion := Format(AdminSetup.Religion);
            Customer."Application Method" := Customer."application method"::"Apply to Oldest";
            Customer."Customer Posting Group" := 'STUDENT';
            Customer.Validate(Customer."Customer Posting Group");
            Customer."Global Dimension 1 Code" := 'MAIN';
            Customer.County := AdminSetup.County;
            Customer.Status := Customer.Status::"New Admission";
            Customer.Insert();

            ////////////////////////////////////////////////////////////////////////////////////////


            Customer.Reset;
            Customer.SetRange("No.", AdminSetup.Admin);
            //Customer.SETFILTER("Date Registered",'=%1',TODAY);
            if Customer.Find('-') then begin
                if AdminSetup.Gender = AdminSetup.Gender::Female then begin
                    Customer.Gender := Customer.Gender::Female;
                end else begin
                    Customer.Gender := Customer.Gender::Male;
                end;
                Customer.Modify;
            end;

            Customer.Reset;
            Customer.SetRange("No.", AdminSetup.Admin);
            Customer.SetFilter("Date Registered", '=%1', Today);
            if Customer.Find('-') then begin
                CourseRegistration.Reset;
                CourseRegistration.SetRange("Student No.", AdminSetup.Admin);
                CourseRegistration.SetRange("Settlement Type", 'KUCCPS');
                CourseRegistration.SetRange(Programmes, AdminSetup.Prog);
                CourseRegistration.SetRange(Semester, 'SEM1 22/23');
                if not CourseRegistration.Find('-') then begin
                    CourseRegistration.Init;
                    CourseRegistration."Reg. Transacton ID" := '';
                    CourseRegistration.Validate(CourseRegistration."Reg. Transacton ID");
                    CourseRegistration."Student No." := AdminSetup.Admin;
                    CourseRegistration.Programmes := AdminSetup.Prog;
                    CourseRegistration.Semester := 'SEM1 22/23';
                    CourseRegistration.Stage := 'Y1S1';
                    CourseRegistration."Student Type" := CourseRegistration."student type"::"Full Time";
                    CourseRegistration."Registration Date" := Today;
                    CourseRegistration."Settlement Type" := 'KUCCPS';
                    CourseRegistration."Academic Year" := '2022/2023';

                    //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                    CourseRegistration.Insert;
                    CourseRegistration.Reset;
                    CourseRegistration.SetRange("Student No.", AdminSetup.Admin);
                    CourseRegistration.SetRange("Settlement Type", 'KUCCPS');
                    CourseRegistration.SetRange(Programmes, AdminSetup.Prog);
                    CourseRegistration.SetRange(Semester, 'SEM1 22/23');
                    if CourseRegistration.Find('-') then begin
                        CourseRegistration."Settlement Type" := 'KUCCPS';
                        CourseRegistration.Validate(CourseRegistration."Settlement Type");
                        CourseRegistration."Academic Year" := '2022/2023';
                        CourseRegistration."Registration Date" := Today;
                        CourseRegistration.Validate(CourseRegistration."Registration Date");
                        CourseRegistration.Modify;

                    end;
                end else begin
                    CourseRegistration.Reset;
                    CourseRegistration.SetRange("Student No.", AdminSetup.Admin);
                    CourseRegistration.SetRange("Settlement Type", 'KUCCPS');
                    CourseRegistration.SetRange(Programmes, AdminSetup.Prog);
                    CourseRegistration.SetRange(Semester, 'SEM1 22/23');
                    CourseRegistration.SetFilter(Posted, '=%1', false);
                    if CourseRegistration.Find('-') then begin
                        CourseRegistration."Settlement Type" := 'KUCCPS';
                        CourseRegistration.Validate(CourseRegistration."Settlement Type");
                        CourseRegistration."Academic Year" := '2022/2023';
                        CourseRegistration."Registration Date" := Today;
                        CourseRegistration.Validate(CourseRegistration."Registration Date");
                        CourseRegistration.Modify;

                    end;
                end;
            end;


            /*Get the record and transfer the details to the admissions database*/
            //ERROR('TEST- '+NewAdminCode);
            /*Transfer the details into the admission database table*/
            Admissions.Init;
            Admissions."Admission No." := AdminSetup.Admin;
            Admissions.Validate("Admission No.");
            Admissions.Date := Today;
            Admissions."Application No." := AdminSetup.Index;
            Admissions."Admission Type" := 'KUCCPS';
            Admissions."Academic Year" := '2022/2023';
            Admissions.Surname := AdminSetup.Names;
            Admissions."Other Names" := AdminSetup.Names;
            Admissions.Status := Admissions.Status::Admitted;
            Admissions."Degree Admitted To" := AdminSetup.Prog;
            Admissions.Validate("Degree Admitted To");
            Admissions."Date Of Birth" := AdminSetup."Date of Birth";
            Admissions.Gender := AdminSetup.Gender + 1;
            Admissions."Marital Status" := AdminSetup."Marital Status";
            Admissions.County := Customer.County;
            Admissions.Campus := 'MAIN';
            Admissions.Nationality := AdminSetup.Nationality;
            Admissions."Correspondence Address 1" := AdminSetup.Box;
            Admissions."Correspondence Address 2" := AdminSetup.Codes;
            Admissions."Correspondence Address 3" := AdminSetup.Town;
            Admissions."Telephone No. 1" := AdminSetup.Phone;
            Admissions."Telephone No. 2" := AdminSetup."Alt. Phone";
            //Admissions."Former School Code":=AdminSetup."Former School Code";
            Admissions."Index Number" := AdminSetup.Index;
            Admissions."Stage Admitted To" := 'Y1S1';
            Admissions."Semester Admitted To" := 'SEM1 22/23';
            Admissions."Settlement Type" := 'KUCCPS';
            Admissions."Intake Code" := AdminSetup."Intake Code";
            Admissions."ID Number" := AdminSetup."ID Number/BirthCert";
            Admissions."E-Mail" := AdminSetup.Email;
            // Admissions."Telephone No. 1":=AdminSetup."Telephone No. 1";
            // Admissions."Telephone No. 2":=AdminSetup."Telephone No. 1";
            Admissions.Insert();
            AdminSetup.Admin := NewAdminCode;
            /*Get the subject details and transfer the  same to the admissions subject*/
            ApplicationSubject.Reset;
            ApplicationSubject.SetRange(ApplicationSubject."Application No.", AdminSetup.Admin);
            if ApplicationSubject.Find('-') then begin
                /*Get the last number in the admissions table*/
                AdmissionSubject.Reset;
                if AdmissionSubject.Find('+') then begin
                    LineNo := AdmissionSubject."Line No." + 1;
                end
                else begin
                    LineNo := 1;
                end;

                /*Insert the new records into the database table*/
                repeat
                    AdmissionSubject.Init;
                    AdmissionSubject."Line No." := LineNo + 1;
                    AdmissionSubject."Admission No." := NewAdminCode;
                    AdmissionSubject."Subject Code" := ApplicationSubject."Subject Code";
                    AdmissionSubject.Grade := AdmissionSubject.Grade;
                    AdmissionSubject.Insert();
                    LineNo := LineNo + 1;
                until ApplicationSubject.Next = 0;
            end;
            /*Insert the medical conditions into the admission database table containing the medical condition*/
            MedicalCondition.Reset;
            MedicalCondition.SetRange(MedicalCondition.Mandatory, true);
            if MedicalCondition.Find('-') then begin
                /*Get the last line number from the medical condition table for the admissions module*/
                AdmissionMedical.Reset;
                if AdmissionMedical.Find('+') then begin
                    LineNo := AdmissionMedical."Line No." + 1;
                end
                else begin
                    LineNo := 1;
                end;
                AdmissionMedical.Reset;
                /*Loop thru the medical conditions*/
                repeat
                    AdmissionMedical.Init;
                    AdmissionMedical."Line No." := LineNo + 1;
                    AdmissionMedical."Admission No." := NewAdminCode;
                    AdmissionMedical."Medical Condition Code" := MedicalCondition.Code;
                    AdmissionMedical.Insert();
                    LineNo := LineNo + 1;
                until MedicalCondition.Next = 0;
            end;
            /*Insert the details into the family table*/
            MedicalCondition.Reset;
            MedicalCondition.SetRange(MedicalCondition.Mandatory, true);
            MedicalCondition.SetRange(MedicalCondition.Family, true);
            if MedicalCondition.Find('-') then begin
                /*Get the last number in the family table*/
                AdmissionFamily.Reset;
                if AdmissionFamily.Find('+') then begin
                    LineNo := AdmissionFamily."Line No.";
                end
                else begin
                    LineNo := 0;
                end;
                repeat
                    AdmissionFamily.Init;
                    AdmissionFamily."Line No." := LineNo + 1;
                    AdmissionFamily."Medical Condition Code" := MedicalCondition.Code;
                    AdmissionFamily."Admission No." := NewAdminCode;
                    AdmissionFamily.Insert();
                    LineNo := LineNo + 1;
                until MedicalCondition.Next = 0;
            end;

            /*Insert the immunization details into the database*/
            Immunization.Reset;
            //Immunization.SETRANGE(Immunization.Mandatory,TRUE);
            if Immunization.Find('-') then begin
                /*Get the last line number from the database*/
                AdmissionImmunization.Reset;
                if AdmissionImmunization.Find('+') then begin
                    LineNo := AdmissionImmunization."Line No." + 1;
                end
                else begin
                    LineNo := 1;
                end;
                /*loop thru the immunizations table adding the details into the admissions table for immunizations*/
                repeat
                    AdmissionImmunization.Init;
                    AdmissionImmunization."Line No." := LineNo + 1;
                    AdmissionImmunization."Admission No." := NewAdminCode;
                    AdmissionImmunization."Immunization Code" := Immunization.Code;
                    AdmissionImmunization.Insert();
                until Immunization.Next = 0;
            end;

            TakeStudentToRegistration(AdminSetup.Admin);
        end;

    end;


    procedure TakeStudentToRegistration(var AdmissNo: Code[20])
    begin
        Admissions.Reset;
        Admissions.SetRange("Admission No.", AdmissNo);
        if Admissions.Find('-') then begin

            //insert the details related to the next of kin of the student into the database
            AdminKin.Reset;
            AdminKin.SetRange(AdminKin."Admission No.", Admissions."Admission No.");
            if AdminKin.Find('-') then begin
                repeat
                    StudentKin.Reset;
                    StudentKin.Init;
                    StudentKin."Student No" := Admissions."Admission No.";
                    StudentKin.Relationship := AdminKin.Relationship;
                    StudentKin.Name := AdminKin."Full Name";
                    //StudentKin."Other Names":=EnrollmentNextofKin."Other Names";
                    //StudentKin."ID No/Passport No":=EnrollmentNextofKin."ID No/Passport No";
                    //StudentKin."Date Of Birth":=EnrollmentNextofKin."Date Of Birth";
                    //StudentKin.Occupation:=EnrollmentNextofKin.Occupation;
                    StudentKin."Office Tel No" := AdminKin."Telephone No. 1";
                    StudentKin."Home Tel No" := AdminKin."Telephone No. 2";
                    //StudentKin.Remarks:=EnrollmentNextofKin.Remarks;
                    StudentKin.Insert;
                until AdminKin.Next = 0;
            end;

            //insert the details in relation to the guardian/sponsor into the database in relation to the current student
            if Admissions."Mother Alive Or Dead" = Admissions."mother alive or dead"::Alive then begin
                if Admissions."Mother Full Name" <> '' then begin
                    StudentGuardian.Reset;
                    StudentGuardian.Init;
                    StudentGuardian."Student No." := Admissions."Admission No.";
                    StudentGuardian.Names := Admissions."Mother Full Name";
                    StudentGuardian.Insert;
                end;
            end;
            if Admissions."Father Alive Or Dead" = Admissions."father alive or dead"::Alive then begin
                if Admissions."Father Full Name" <> '' then begin
                    StudentGuardian.Reset;
                    StudentGuardian.Init;
                    StudentGuardian."Student No." := Admissions."Admission No.";
                    StudentGuardian.Names := Admissions."Father Full Name";
                    StudentGuardian.Insert;
                end;
            end;
            if Admissions."Guardian Full Name" <> '' then begin
                if Admissions."Guardian Full Name" <> '' then begin
                    StudentGuardian.Reset;
                    StudentGuardian.Init;
                    StudentGuardian."Student No." := Admissions."Admission No.";
                    StudentGuardian.Names := Admissions."Guardian Full Name";
                    StudentGuardian.Insert;
                end;
            end;
        end;
    end;


    procedure SubmitReferral(Username: Text; Reason: Text)
    begin
        /*This function transfers the fieldsin the application to the fields in the admissions table*/
        /*Get the new admission code for the selected application*/
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('HOSPAPP', 0D, true);
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", Username);
        if EmployeeCard.Find('-') then begin
            Referrralll.Init;
            Referrralll."Treatment no." := NextLeaveApplicationNo;
            Referrralll."Date Referred" := Today;
            Referrralll."Referral Reason" := Reason;
            Referrralll.Status := Referrralll.Status::New;
            Referrralll.Surname := EmployeeCard."Last Name";
            Referrralll."Middle Name" := EmployeeCard."Middle Name";
            Referrralll."Last Name" := EmployeeCard."First Name";
            Referrralll."ID Number" := EmployeeCard."First Name";
            Referrralll."Correspondence Address 1" := EmployeeCard."Postal Address";
            Referrralll."Telephone No. 1" := EmployeeCard."Cellular Phone Number";
            Referrralll.Email := EmployeeCard."Company E-Mail";
            Referrralll."Staff No" := Username;
            Referrralll."No. Series" := 'HOSPAPP';
            Referrralll.Insert();
        end;

    end;


    procedure GenerateReferralReport(EmployeeNo: Text; filenameFromApp: Text) filename: Text[100]
    begin
        filename := FILESPATH_S + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        //MESSAGE('OK');
        Referrralll.Reset;
        Referrralll.SetRange(Referrralll."Treatment no.", EmployeeNo);

        if Referrralll.Find('-') then begin
            Report.SaveAsPdf(51871, filename, Referrralll);   //52017726 todo
        end;
        exit(filename);
    end;


    procedure getActiveElection() Message: Text
    var
        ELECTElectionsSetup: Record "ELECT-Elections Setup";
    begin
        ELECTElectionsSetup.Reset;
        if ELECTElectionsSetup.Find('-') then begin
            Message := Format(true) + '::' + ELECTElectionsSetup."Current Election";
        end else begin
            Message := Format(false);
        end;
    end;


    procedure getActiveElectionDetails() Message: Text
    begin
        ElectionHeader.Reset;
        ElectionHeader.SetRange(ElectionHeader."Is Active", true);
        if ElectionHeader.Find('-') then begin
            Message := ElectionHeader."Election Code" + '::' + Format(ElectionHeader."Voting Allowed");
        end
    end;


    procedure IsAvoter(username: Text; ElectionCode: Text) Message: Text
    var
        TXTNotRegistered: label 'Not';
        TXTRegistered: label 'Yes';
        VoterRegister: Record "ELECT-Voter Register";
    begin
        VoterRegister.Reset;
        VoterRegister.SetRange(VoterRegister."Voter No.", username);
        VoterRegister.SetRange(VoterRegister."Election Code", ElectionCode);
        if VoterRegister.Find('-') then begin
            Message := TXTRegistered + '::';
        end else begin
            Message := TXTNotRegistered + '::';
        end
    end;


    procedure UpdateElection(Elections: Code[50]; StudentNo: Text; CandidateNo: Text; Positions: Text; Operation: Code[10]) VoterBufferVal: Text[100]
    var
        ELECTMyCandidates: Record "ELECT-My Candidates";
        ELECTElectionsHeader: Record "ELECT-Elections Header";
        ELECTElectionsSetup: Record "ELECT-Elections Setup";
        VoterRegister: Record "ELECT-Voter Register";
        ELECTBallotRegisterBuffer: Record "ELECT-Ballot Register Buffer";
        ELECTBallotRegister: Record "ELECT-Ballot Register";
    begin
        ELECTElectionsSetup.Reset;
        if ELECTElectionsSetup.Find('-') then;
        ELECTElectionsSetup.TestField("Current Election");
        ELECTElectionsHeader.Reset;
        ELECTElectionsHeader.SetRange("Election Code", Elections);
        if ELECTElectionsHeader.Find('-') then;
        VoterRegister.Reset;
        VoterRegister.SetRange("Election Code", ELECTElectionsHeader."Election Code");
        VoterRegister.SetRange("Voter No.", StudentNo);
        VoterRegister.SetRange(Voted, false);
        if VoterRegister.Find('-') then begin
            if Operation = 'EDIT' then begin
                ELECTBallotRegisterBuffer.Init;
                ELECTBallotRegisterBuffer."Election Code" := Elections;
                ELECTBallotRegisterBuffer."Ballot ID" := VoterRegister."Ballot ID";
                ELECTBallotRegisterBuffer."Position Code" := Positions;
                ELECTBallotRegisterBuffer."Candidate No." := CandidateNo;
                ELECTBallotRegisterBuffer."Voting Time" := Time;
                ELECTBallotRegisterBuffer."Votting Date" := Today;
                ELECTBallotRegisterBuffer."Department Code" := VoterRegister."Department Code";
                ELECTBallotRegisterBuffer."Electral District" := VoterRegister."Electral District";
                ELECTBallotRegisterBuffer."Campus Code" := VoterRegister."Campus Code";
                ELECTBallotRegisterBuffer."Voter No." := StudentNo;
                ELECTBallotRegisterBuffer.Insert;
            end else if Operation = 'INSERT' then begin// Submit Final Poll
                ELECTBallotRegisterBuffer.Reset;
                ELECTBallotRegisterBuffer.SetRange("Election Code", ELECTElectionsHeader."Election Code");
                ELECTBallotRegisterBuffer.SetRange("Ballot ID", VoterRegister."Ballot ID");
                if ELECTBallotRegisterBuffer.Find('-') then begin
                    repeat
                    begin
                        ELECTBallotRegister.Init;
                        ELECTBallotRegister."Election Code" := ELECTBallotRegisterBuffer."Election Code";
                        ELECTBallotRegister."Ballot ID" := ELECTBallotRegisterBuffer."Ballot ID";
                        ELECTBallotRegister."Position Code" := ELECTBallotRegisterBuffer."Position Code";
                        ELECTBallotRegister."Candidate No." := ELECTBallotRegisterBuffer."Candidate No.";
                        ELECTBallotRegister."Voting Time" := ELECTBallotRegisterBuffer."Voting Time";
                        ELECTBallotRegister."Votting Date" := ELECTBallotRegisterBuffer."Votting Date";
                        ELECTBallotRegister."Department Code" := VoterRegister."Department Code";
                        ELECTBallotRegister."Electral District" := VoterRegister."Electral District";
                        ELECTBallotRegister."Campus Code" := VoterRegister."Campus Code";
                        ELECTBallotRegister.Insert;
                        //Delete Entry from the Buffer on submission of individual Ballot
                        ELECTBallotRegisterBuffer.Delete;
                    end;
                    until ELECTBallotRegisterBuffer.Next = 0;
                end;
                VoterRegister.Voted := true;
                VoterRegister.Modify;
            end;
        end;
    end;


    procedure DeleteVoteSelected(studentNo: Text; CandidateNo: Text)
    begin
        BallotBuffer.Reset;
        BallotBuffer.SetRange(BallotBuffer."Voter No.", studentNo);
        BallotBuffer.SetRange(BallotBuffer."Candidate No.", CandidateNo);
        if BallotBuffer.Find('-') then begin
            BallotBuffer.Delete;
            Message('Deleted Successfully');
        end;
    end;


    procedure GetPositionVoted(PositionCode: Text; Username: Text) Message: Text
    var
        Voted: label 'Yes';
        NotVoted: label 'No';
    begin
        BallotBuffer.Reset;
        BallotBuffer.SetRange(BallotBuffer."Voter No.", Username);
        BallotBuffer.SetRange(BallotBuffer."Position Code", PositionCode);
        if BallotBuffer.Find('-') then begin
            Message := Voted + '::';
        end else begin
            Message := NotVoted + '::';
        end
    end;


    procedure VoteRegisters(ElectionCode: Text; Username: Text) Message: Text
    begin
        VoteReg.Reset;
        VoteReg.SetRange(VoteReg."Election Code", ElectionCode);
        VoteReg.SetRange(VoteReg."Voter No.", Username);
        if VoteReg.Find('-') then begin
            Message := Format(VoteReg.Voted);
        end
    end;


    procedure GetElectionType(ElectionCode: Code[30]) Message: Text
    begin
        ElectionHeader.Reset;
        ElectionHeader.SetRange(ElectionHeader."Election Code", ElectionCode);
        if ElectionHeader.Find('-') then begin
            Message := Format(ElectionHeader."Delegates Election");
        end
    end;

    procedure IsStageFinal(Stage: Text; programm: Text) Message: Text
    begin
        Stages.Reset;
        Stages.SetRange(Stages."Programme Code", programm);
        Stages.SetRange(Stages.Code, Stage);
        if Stages.Find('-') then begin
            Message := Format(Stages."Final Stage");

        end
    end;

    procedure HasAppliedClearance(username: Text) Message: Text
    var
        TXTApplied: label 'Yes';
        TXTNotApplied: label 'Not Applied';
        Customerz: Record Customer;
    begin
        Customerz.Reset;
        Customerz.SetRange(Customerz."No.", username);
        Customerz.SetFilter(Customerz."Clearance Status", '%1|%2', Customerz."clearance status"::Active,
        Customerz."clearance status"::Cleared);
        if Customerz.Find('-') then begin
            Message := TXTApplied + '::';
        end else begin
            Message := TXTNotApplied + '::';
        end
    end;

    procedure GenerateClearanceForm(StudentNo: Text; filenameFromApp: Text)
    var
        filename: Text;
        ACAClearanceApprovalEntries: Record "ACA-Clearance Approval Entries";
        cust: Record Customer;
    begin
        ///// Check if Entires exists. If not, Initiate a Clearance after reversal
        Clear(ACAClearanceApprovalEntries);
        ACAClearanceApprovalEntries.Reset;
        ACAClearanceApprovalEntries.SetRange(ACAClearanceApprovalEntries."Student ID", StudentNo);
        if not (ACAClearanceApprovalEntries.Find('-')) then begin
            if cust.Get(StudentNo) then begin
                cust."Clearance Status" := cust."clearance status"::open;
                cust.Modify;
                // Initiate Clearance Here
                SubmitForClearance(StudentNo, '');
            end;
        end;

        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        Clear(ACAClearanceApprovalEntries);
        ACAClearanceApprovalEntries.Reset;
        ACAClearanceApprovalEntries.SetRange(ACAClearanceApprovalEntries."Student ID", StudentNo);

        if ACAClearanceApprovalEntries.Find('-') then begin
            Report.SaveAsPdf(Report::"ACA-Clean Std Units", filename, ACAClearanceApprovalEntries);
            // REPORT.RUN(51675,FALSE,FALSE,ACAClearanceApprovalEntries);
        end;
    end;


    procedure SendEmailEasy(Salutation: Text[100]; UserFullNames: Text[150]; Paragraph1: Text[963]; Paragraph2: Text[963]; Disclaimer1: Text[369]; Disclaimer2: Text[369]; EmailID: Text[639]; MailSubject: Text[639])
    var
        XmlParameters: Text[1024];
        OStream: OutStream;
        IStream: InStream;
        TempFileName: Text[1024];
        CustTempTable: Record Customer temporary;
        CustomerTable: Record Customer;
        // SMTPMailSetup: Record UnknownRecord409;
        // SMTPMail: Codeunit UnknownCodeunit400;
        CF_FTLCustomerInvoice: Report "Customer Statement";
    begin
        // SMTPMailSetup.Get;
        // SMTPMailSetup.TestField("SMTP Server");
        // SMTPMailSetup.TestField("User ID");
        // SMTPMailSetup.TestField("SMTP Server Port");
        // SMTPMailSetup.TestField("Password Key");

        // Clear(SMTPMail);
        // SMTPMail.CreateMessage(UserFullNames, SMTPMailSetup."User ID", EmailID, MailSubject, '', true);
        // SMTPMail.AppendBody(Salutation + ',' + UserFullNames + ',');

        // SMTPMail.AppendBody('<br>');
        // SMTPMail.AppendBody(Paragraph1);
        // SMTPMail.AppendBody('<br>');
        // SMTPMail.AppendBody(Paragraph2);
        // SMTPMail.AppendBody('<HR>');
        // SMTPMail.AppendBody(Disclaimer1);
        // SMTPMail.AppendBody('<br>');
        // SMTPMail.AppendBody(Disclaimer2);
        // SMTPMail.Send;
    end;


    procedure SendEmailEasy_WithAttachment(Salutation: Text[100]; UserFullNames: Text[150]; Paragraph1: Text[963]; Paragraph2: Text[963]; Disclaimer1: Text[369]; Disclaimer2: Text[369]; EmailID: Text[639]; MailSubject: Text[639]; Filepaths: Text[250]; AttachmentTitle: Code[250])
    var
        XmlParameters: Text[1024];
        OStream: OutStream;
        IStream: InStream;
        TempFileName: Text[1024];
        CustTempTable: Record Customer temporary;
        CustomerTable: Record Customer;
        // SMTPMailSetup: Record UnknownRecord409;
        // SMTPMail: Codeunit UnknownCodeunit400;
        // ClearanceReport: Report UnknownReport51675;
        filename: Text[250];
    begin
        // filename := Filepaths;
        // if not Exists(filename) then
        //     Error('File not found!');


        // SMTPMailSetup.Get;
        // SMTPMailSetup.TestField("SMTP Server");
        // SMTPMailSetup.TestField("User ID");
        // SMTPMailSetup.TestField("SMTP Server Port");
        // SMTPMailSetup.TestField("Password Key");

        // Clear(SMTPMail);
        // SMTPMail.CreateMessage(UserFullNames, SMTPMailSetup."User ID", EmailID, MailSubject, '', true);
        // SMTPMail.AddAttachment(AttachmentTitle, filename);
        // SMTPMail.AppendBody(Salutation + ',' + UserFullNames + ',');

        // SMTPMail.AppendBody('<br>');
        // SMTPMail.AppendBody(Paragraph1);
        // SMTPMail.AppendBody('<br>');
        // SMTPMail.AppendBody(Paragraph2);
        // SMTPMail.AppendBody('<HR>');
        // SMTPMail.AppendBody(Disclaimer1);
        // SMTPMail.AppendBody('<br>');
        // SMTPMail.AppendBody(Disclaimer2);
        // SMTPMail.Send;
    end;


    procedure ApproveStudClearance(StudentNo: Code[20]; User_ID: Code[20]; Clearance_Level_Code: Code[20])
    var
        ACAClearanceApprovalEntries: Record "ACA-Clearance Approval Entries";
        webportals: Codeunit webportals;
        cust: Record Customer;
        ACAClearanceApprovalEntries1: Record "ACA-Clearance Approval Entries";
        counted: Integer;
        stringval: Text[250];
        enties: Record "ACA-Clearance Approval Entries";
        UserSetup: Record "User Setup";
        enties2: Record "ACA-Clearance Approval Entries";
    begin
        ACAClearanceApprovalEntries1.Reset;
        ACAClearanceApprovalEntries1.SetRange("Clear By ID", User_ID);
        ACAClearanceApprovalEntries1.SetRange("Student ID", StudentNo);
        ACAClearanceApprovalEntries1.SetRange("Clearance Level Code", Clearance_Level_Code);
        if ACAClearanceApprovalEntries1.Find('-') then begin
            if ACAClearanceApprovalEntries1."Clearance Level Code" = '' then Error('Nothing to clear!');
            Clear(counted);
            Clear(stringval);
            // // //         conditions.RESET;
            // // //         conditions.SETRANGE(conditions."Clearance Level Code","Clearance Level Code");
            // // //         conditions.SETFILTER(conditions."Condition to Check",'<>%1','');
            // // //         IF conditions.FIND('-') THEN BEGIN
            // // //         stringval:='\-----------------------***** ATTENTION *****------------------------';
            // // //           stringval:=stringval+'\Ensure that the following conditions are met';
            // // //           REPEAT
            // // //           BEGIN
            // // //             stringval:=stringval+'\'+FORMAT(conditions.Sequence)+'). '+conditions."Condition to Check";
            // // //           END;
            // // //           UNTIL conditions.NEXT=0;
            // // //           stringval:=stringval+'\'+'                             CONTINUE?                              ';
            // // //           stringval:=stringval+'\-----------------------*********************------------------------';
            // // //         END ELSE stringval:='Ensure that all the conditions required for clearance are met. Continue?';
            // // //
            // // // IF CONFIRM(stringval,TRUE)=FALSE THEN ERROR('Cancelled!');
            // //         ACAClearanceApprovalEntries1
            // //         enties.RESET;
            // //         enties.SETRANGE(enties."Clearance Level Code","Clearance Level Code");
            // //         enties.SETRANGE(enties."Student ID",StudentNo);
            // //         enties.SETFILTER(enties."Clear By ID",User_ID);
            // //         IF enties.FIND('-') THEN BEGIN
            ACAClearanceApprovalEntries1.Cleared := true;
            ACAClearanceApprovalEntries1."Last Date Modified" := Today;
            ACAClearanceApprovalEntries1."Last Time Modified" := Time;
            ACAClearanceApprovalEntries1.Status := ACAClearanceApprovalEntries1.Status::Cleared;
            ACAClearanceApprovalEntries1.Modify;
            // END;
            enties2.Reset;
            enties2.SetRange(enties2."Clearance Level Code", ACAClearanceApprovalEntries1."Clearance Level Code");
            enties2.SetRange(enties2."Student ID", ACAClearanceApprovalEntries1."Student ID");
            enties2.SetRange(enties2.Sequence, ACAClearanceApprovalEntries1.Sequence);
            if enties2.Find('-') then begin
                repeat
                begin
                    enties2."Last Date Modified" := Today;
                    enties2."Last Time Modified" := Time;
                    enties2.Status := enties.Status::Cleared;
                    enties2.Modify;
                end;
                until enties2.Next = 0;
            end;

            // Approval for the 1st Approval
            if ACAClearanceApprovalEntries1."Priority Level" = ACAClearanceApprovalEntries1."priority level"::"1st Level" then begin
                enties.Reset;
                enties.SetRange(enties."Student ID", ACAClearanceApprovalEntries1."Student ID");
                enties.SetFilter(enties.Status, '=%1', enties.Status::Created);
                enties.SetFilter(enties."Priority Level", '=%1', enties."priority level"::Normal);
                if enties.Find('-') then begin
                    repeat
                    begin
                        enties."Last Date Modified" := Today;
                        enties."Last Time Modified" := Time;
                        enties.Status := enties.Status::Open;
                        enties.Modify;
                        ///////////////////////////////////////////////////////////////////////////////////
                        UserSetup.Reset;
                        UserSetup.SetRange("User ID", enties."Clear By ID");
                        if UserSetup.Find('-') then begin

                            webportals.SendEmailEasy('Hi ', UserSetup.UserName, 'A Student clearance request has been sent to your email for student:' + ACAClearanceApprovalEntries1."Student ID",
                            'Kindly expedite.', 'This is a system generated mail. Kindly do not respond. Unless you want to talk to a Robot!',
                            'In case of Challenges, Kindly Talk to the ICT department', UserSetup."E-Mail", 'STUDENT CLEARANCE APPROVAL');
                        end;
                        ///////////////////////////////////////////////////////////////////////////////////
                    end;
                    until enties.Next = 0;
                end;
            end else if ACAClearanceApprovalEntries1."Priority Level" = ACAClearanceApprovalEntries1."priority level"::Normal then begin
                //Search where Final Level and set to open
                enties.Reset;
                enties.SetRange(enties.Department, ACAClearanceApprovalEntries1.Department);
                enties.SetRange(enties."Student ID", ACAClearanceApprovalEntries1."Student ID");
                enties.SetFilter(enties.Status, '=%1', enties.Status::Open);
                enties.SetFilter(enties."Priority Level", '=%1', enties."priority level"::Normal);
                if not enties.Find('-') then begin
                    // If All other Clearances are done, Open the final Clearance
                    /////////////////////////////////////////////////////////////
                    //enties.SETRANGE(enties."Clearance Level Code","Clearance Level Code");
                    ACAClearanceApprovalEntries.Reset;
                    //    ACAClearanceApprovalEntries.SETRANGE(ACAClearanceApprovalEntries.Department,Department);
                    ACAClearanceApprovalEntries.SetRange(ACAClearanceApprovalEntries."Student ID", ACAClearanceApprovalEntries1."Student ID");
                    ACAClearanceApprovalEntries.SetFilter(ACAClearanceApprovalEntries.Status, '=%1', ACAClearanceApprovalEntries.Status::Created);
                    ACAClearanceApprovalEntries.SetFilter(ACAClearanceApprovalEntries."Priority Level", '=%1',
                             ACAClearanceApprovalEntries."priority level"::Finance);
                    if ACAClearanceApprovalEntries.Find('-') then begin
                        repeat
                        begin
                            ACAClearanceApprovalEntries."Last Date Modified" := Today;
                            ACAClearanceApprovalEntries."Last Time Modified" := Time;
                            ACAClearanceApprovalEntries.Status := ACAClearanceApprovalEntries.Status::Open;
                            ACAClearanceApprovalEntries.Modify;
                            ///////////////////////////////////////////////////////////////////////////////////
                            UserSetup.Reset;
                            UserSetup.SetRange("User ID", ACAClearanceApprovalEntries."Clear By ID");
                            if UserSetup.Find('-') then begin
                                webportals.SendEmailEasy('Hi ', UserSetup.UserName, 'A Student clearance request has been sent to your email for student:' + StudentNo,
                                'Kindly expedite.', 'This is a system generated mail. Kindly do not respond. Unless you want to talk to a Robot!',
                                'In case of Challenges, Kindly Talk to the ICT department', UserSetup."E-Mail", 'STUDENT CLEARANCE APPROVAL');
                            end;
                            ///////////////////////////////////////////////////////////////////////////////////
                        end;
                        until ACAClearanceApprovalEntries.Next = 0;
                    end;

                    /////////////////////////////////////////////////////////////
                end;
            end else if ACAClearanceApprovalEntries1."Priority Level" = ACAClearanceApprovalEntries1."priority level"::Finance then begin
                //Search where Final Level and set to open
                enties.Reset;
                enties.SetRange(enties.Department, ACAClearanceApprovalEntries1.Department);
                enties.SetRange(enties."Student ID", ACAClearanceApprovalEntries1."Student ID");
                enties.SetFilter(enties.Status, '=%1', enties.Status::Open);
                enties.SetFilter(enties."Priority Level", '=%1', enties."priority level"::Finance);
                if not enties.Find('-') then begin
                    // If All other Clearances are done, Open the final Clearance
                    /////////////////////////////////////////////////////////////
                    //enties.SETRANGE(enties."Clearance Level Code","Clearance Level Code");
                    ACAClearanceApprovalEntries.Reset;
                    //    ACAClearanceApprovalEntries.SETRANGE(ACAClearanceApprovalEntries.Department,Department);
                    ACAClearanceApprovalEntries.SetRange(ACAClearanceApprovalEntries."Student ID", ACAClearanceApprovalEntries1."Student ID");
                    ACAClearanceApprovalEntries.SetFilter(ACAClearanceApprovalEntries.Status, '=%1', ACAClearanceApprovalEntries.Status::Created);
                    ACAClearanceApprovalEntries.SetFilter(ACAClearanceApprovalEntries."Priority Level", '=%1',
                             ACAClearanceApprovalEntries."priority level"::"Final level");
                    if ACAClearanceApprovalEntries.Find('-') then begin
                        repeat
                        begin
                            ACAClearanceApprovalEntries."Last Date Modified" := Today;
                            ACAClearanceApprovalEntries."Last Time Modified" := Time;
                            ACAClearanceApprovalEntries.Status := ACAClearanceApprovalEntries.Status::Open;
                            ACAClearanceApprovalEntries.Modify;
                            ///////////////////////////////////////////////////////////////////////////////////
                            UserSetup.Reset;
                            UserSetup.SetRange("User ID", ACAClearanceApprovalEntries."Clear By ID");
                            if UserSetup.Find('-') then begin
                                webportals.SendEmailEasy('Hi ', UserSetup.UserName, 'A Student clearance request has been sent to your email for student:' + StudentNo,
                                'Kindly expedite.', 'This is a system generated mail. Kindly do not respond. Unless you want to talk to a Robot!',
                                'In case of Challenges, Kindly Talk to the ICT department', UserSetup."E-Mail", 'STUDENT CLEARANCE APPROVAL');
                            end;
                            ///////////////////////////////////////////////////////////////////////////////////
                        end;
                        until ACAClearanceApprovalEntries.Next = 0;
                    end;

                    /////////////////////////////////////////////////////////////
                end;
            end else if ACAClearanceApprovalEntries1."Priority Level" = ACAClearanceApprovalEntries1."priority level"::"Final level" then begin
                // Change status of the clearance of the student card
                if cust.Get(ACAClearanceApprovalEntries1."Student ID") then begin
                    cust."Clearance Status" := cust."clearance status"::Cleared;
                    cust.Modify;
                    ///////////////////////////////////////////////////////////////////////////////////
                    if cust."E-Mail" <> '' then begin
                        webportals.SendEmailEasy('Hi ', cust.Name, ' Your application for clearance has been Approved',
                        'Download your signed clearance form from the portal', 'This is a system generated mail. Kindly do not respond. Unless you want to talk to a Robot!',
                        'In case of Challenges, Kindly Talk to your department head', UserSetup."E-Mail", 'STUDENT APPROVED CLEARANCE');
                    end;
                    ///////////////////////////////////////////////////////////////////////////////////
                end;
            end;
            // end with ACAClearanceApprovalEntries1 do

        end;
    end;

    procedure CheckStudentPasswordChanged(username: Text) Message: Text
    var
        TXTIncorrectDetails: label 'No';
        TXTCorrectDetails: label 'Yes';
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", username);
        if Customer.Find('-') then begin
            if (Customer."Changed Password" = true) then begin
                Message := TXTCorrectDetails + '::' + Format(Customer."Changed Password");
            end else begin
                Message := TXTIncorrectDetails + '::' + Format(Customer."Changed Password");
            end
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;

    procedure CheckParentPasswordChanged(username: Text) Msg: Boolean
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", username);
        if Customer.Find('-') then begin
            Msg := Customer."Changed Parent Password";
        end;
    end;

    procedure ChangeParentPassword(username: Text; pass: Text) Msg: Boolean
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", username);
        if Customer.Find('-') then begin
            Customer."Parent Password" := pass;
            Customer."Changed Parent Password" := true;
            Customer.Modify;
            Msg := true;
        end;
    end;

    procedure ParentsLogin(username: Text; pass: Text) Msg: Boolean
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", username);
        Customer.SetRange(Customer."Parent Password", pass);
        Customer.SetFilter(Customer.Status, '%1|%2|%3', Customer.Status::Current, Customer.Status::Registration, Customer.Status::"New Admission");
        if Customer.Find('-') then begin
            Msg := true;
        end;
    end;

    procedure ValidStudentNo(username: Text) Msg: Boolean
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", username);
        if Customer.Find('-') then begin
            Msg := true;
        end;
    end;

    procedure CheckStudentLoginForUnchangedPass(username: Text; Passwordz: Text) Message: Text
    var
        TXTIncorrectDetails: label 'Warning!, login failed! Ensure you login with your Admission Number as both your username as well as password!';
        TXTCorrectDetails: label 'Login';
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", username);
        //Customer.SETRANGE(Customer.Status,Customer.Status::);
        if Customer.Find('-') then begin
            if (Customer."No." = Passwordz) then begin
                Message := TXTCorrectDetails + '::' + Customer."No." + '::' + Customer."E-Mail";
            end else begin
                Message := TXTIncorrectDetails + '::';
            end
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;

    procedure GetSettlementType(username: Text) Message: Text
    begin
        CourseRegistration.Reset;
        CourseRegistration.SetRange(CourseRegistration."Student No.", username);
        if Customer.Find('-') then begin
            Message := Format(CourseRegistration."Settlement Type");

        end
    end;

    procedure GetRoomCostNum(SpaceNo: Text) Message: Text
    begin
        HostelLedger.Reset;
        HostelLedger.SetRange(HostelLedger."Space No", SpaceNo);
        if HostelLedger.Find('-') then begin
            Message := HostelLedger."Room No" + '::' + Format(HostelLedger."Room Cost");

        end
    end;

    procedure GetRoomSpaceCosts(HostelNo: Text) Message: Text
    begin
        HostelBlockRooms.Reset;
        HostelBlockRooms.SetRange(HostelBlockRooms."Hostel Code", HostelNo);
        if HostelRooms.Find('-') then begin
            Message := Format(HostelBlockRooms."Room Cost") + '::' + Format(HostelBlockRooms."JAB Fees") + '::' + Format(HostelBlockRooms."SSP Fees");

        end
    end;

    procedure VerifyOldStudentPassword(username: Text; OldPass: Text) Message: Text
    var
        TXTIncorrectDetails: label 'No';
        TXTCorrectDetails: label 'Yes';
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", username);
        Customer.SetRange(Customer.Password, OldPass);
        if Customer.Find('-') then begin
            Message := TXTCorrectDetails;
        end else begin
            Message := TXTIncorrectDetails + '::';
        end
    end;

    procedure ChangeStudentPassword(username: Text; Pass: Text)
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", username);
        if Customer.Find('-') then begin
            Customer.Password := Pass;
            Customer."Changed Password" := true;
            Customer.Modify;
            Message('Password Updated Successfully');
        end;
    end;

    procedure GetAllowedHostelBookingGroup(username: Text) Message: Text
    begin
        CourseRegistration.Reset;
        CourseRegistration.SetRange(CourseRegistration."Student No.", username);
        CourseRegistration.SetRange(CourseRegistration.Reversed, false);
        CourseRegistration.SetCurrentkey(Stage);
        if CourseRegistration.Find('+') then begin
            Message := CourseRegistration.Stage + '::' + CourseRegistration.Semester;
        end;
    end;

    procedure GetHostelGenSetups() Message: Text
    begin
        GenSetup.Reset;
        if GenSetup.Find('-') then begin
            Message := GenSetup."Default Year" + '::' + GenSetup."Default Semester";

        end;
    end;

    procedure IsHostelBlacklisted(username: Text) Message: Text
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", username);
        if Customer.Find('-') then begin
            Message := Format(Customer."Hostel Black Listed");

        end
    end;

    procedure GetAccomodationFee(username: Text; Sem: Text) Message: Text
    begin
        StudCharges.Reset;
        StudCharges.SetRange(StudCharges."Student No.", username);
        StudCharges.SetRange(StudCharges.Semester, Sem);
        StudCharges.SetRange(StudCharges.accommodation, true);
        if StudCharges.Find('-') then begin
            Message := Format(StudCharges.Amount);
        end;
    end;

    procedure SubmitForClearance(username: Text; Programmm: Text) Message: Text
    var
        Rec: Record Customer;
        ACACourseRegistration: Record "ACA-Course Registration";
        deptemp: Record "ACA-Clearance templates";
        progs: Record "ACA-Programme";
        sems: Record "ACA-Semesters";
        AcadYear: Record "ACA-Academic Year";
        ClearLevela: Record "ACA-Clearance Level Codes";
        ClearEntries: Record "ACA-Clearance Approval Entries";
        UserSetup: Record "User Setup";
        ClearStandardApp: Record "ACA-Clearance Std Approvers";
        webportals: Codeunit webportals;
        ClearTemplates: Record "ACA-Clearance templates";
        ClearDepTemplates: Record "ACA-Clearance Dept. Approvers";
    begin
        /*IF Customer.GET(username) THEN BEGIN
           Customer.CALCFIELDS(Balance);
           IF Customer.Balance>0 THEN BEGIN
              Message:='Clearance application not successful! Your Balance is greater than zero!';
             END;
           END;
           IF NOT (Customer.Balance>0) THEN BEGIN
            NextJobapplicationNo:=NoSeriesMgt.GetNextNo('CLRE',0D,TRUE);
            ClearanceHeader.RESET;
             ClearanceHeader.SETRANGE(ClearanceHeader."Student No.",username);
             IF NOT ClearanceHeader.FIND('-') THEN BEGIN
            ClearanceHeader.INIT;
            ClearanceHeader."No.":=NextJobapplicationNo;
            ClearanceHeader.Date:=TODAY;
            ClearanceHeader."Student No.":=username;
            ClearanceHeader.Programme:=Programmm;
            ClearanceHeader.Status:=ClearanceHeader.Status::New;
            ClearanceHeader."No. Series":='CLRE';
            ClearanceHeader.INSERT;
        
        Customer.RESET;
        Customer.SETRANGE(Customer."No.",username);
        IF Customer.FIND('-') THEN BEGIN
          Customer."Applied for Clearance":=TRUE;
          Customer."Clearance Initiated by":=username;
          Customer."Clearance Status":= Customer."Clearance Status"::Active;
          Customer."Clearance Initiated Date":=TODAY;
          Customer."Clearance Initiated Time":=TIME;
          Customer."Clearance Reason":=Customer."Clearance Reason"::Graduation;
          Customer.MODIFY;
        END;
         Message:='Clearance request successfully initiated';
         END ELSE BEGIN
         Message:='You already initiated your clearance process.';
         END;
         END;
         */
        Rec.Reset;
        Rec.SetRange("No.", username);
        if Rec.Find('-') then begin
            Clear(ACACourseRegistration);
            ACACourseRegistration.Reset;
            ACACourseRegistration.SetRange("Student No.", Rec."No.");
            ACACourseRegistration.SetFilter(Programmes, '<>%1', '');
            ACACourseRegistration.SetFilter(Reversed, '=%1', false);
            if ACACourseRegistration.Find('+') then begin
            end;
            progs.Reset;
            progs.SetRange(Code, ACACourseRegistration.Programmes);
            if progs.Find('-') then;
            Rec."Global Dimension 2 Code" := progs."Department Code";
            sems.Reset;
            sems.SetRange(sems."Current Semester", true);
            if sems.Find('-') then
                if not (sems.Code = '') then;
            Rec."Clearance Semester" := ACACourseRegistration.Semester;
            Rec."Programme End Date" := ACACourseRegistration."Registration Date";
            AcadYear.Reset;
            AcadYear.SetRange(AcadYear.Current, true);
            if AcadYear.Find('-') then
                if not (AcadYear.Code = '') then;
            Rec."Clearance Academic Year" := ACACourseRegistration."Academic Year";
            Rec."Clearance Reason" := Rec."clearance reason"::Graduation;
            Rec.Modify;

            Rec.CalcFields("Balance (LCY)");
            // CALCFIELDS("Refund on PV");
            if (Rec."Balance (LCY)" > 0) then Error('The student''s balance must be zero (0).\The Balance is ' + Format(Rec."Balance (LCY)"));
            //  IF NOT (CONFIRM('Initiate student clearance for '+"No."+': '+Name,FALSE)=TRUE) THEN ERROR('Cancelled!');
            //TESTFIELD("Clearance Reason");
            Rec.TestField("Global Dimension 2 Code");
            //TESTFIELD("Clearance Semester");
            //TESTFIELD("Clearance Academic Year");
            Rec.TestField("Current Programme");
            Rec.TestField("Programme End Date");
            //TESTFIELD("Intake Code");
            deptemp.Reset;
            deptemp.SetRange(deptemp."Clearance Level Code", 'HOD');
            deptemp.SetRange(deptemp.Department, Rec."Global Dimension 2 Code");
            if not (deptemp.Find('-')) then Error('Departmental approver for ''' + Rec."Global Dimension 2 Code" + ''' missing');
            ClearLevela.Reset;
            ClearLevela.SetRange(ClearLevela.Status, ClearLevela.Status::Active);
            ClearLevela.SetFilter(ClearLevela."Priority Level", '=%1', ClearLevela."priority level"::"1st Level");
            if not (ClearLevela.Find('-')) then Error('1st Approval Level is missing!');

            ClearLevela.Reset;
            ClearLevela.SetRange(ClearLevela.Status, ClearLevela.Status::Active);
            ClearLevela.SetFilter(ClearLevela."Priority Level", '=%1', ClearLevela."priority level"::Finance);
            if not (ClearLevela.Find('-')) then Error('Finance Approval Level is missing!');


            ClearLevela.Reset;
            ClearLevela.SetRange(ClearLevela.Status, ClearLevela.Status::Active);
            ClearLevela.SetFilter(ClearLevela."Priority Level", '=%1', ClearLevela."priority level"::"Final level");
            if not (ClearLevela.Find('-')) then Error('Final Approval Level is missing!');



            ClearLevela.Reset;
            ClearLevela.SetRange(ClearLevela.Status, ClearLevela.Status::Active);
            if ClearLevela.Find('-') then begin //5
                repeat
                begin  //4
                    if (ClearLevela.Standard) then begin  //3
                                                          // Pick from the standard Approvals and insert into the Entries table
                        ClearStandardApp.Reset;
                        ClearStandardApp.SetRange(ClearStandardApp."Clearance Level Code", ClearLevela."Clearance Level Code");
                        ClearStandardApp.SetFilter(ClearStandardApp.Active, '=%1', true);
                        if ClearStandardApp.Find('-') then begin //2
                            repeat  // Rep1
                            begin //1
                                ClearEntries.Init;
                                ClearEntries."Clearance Level Code" := ClearStandardApp."Clearance Level Code";
                                ClearEntries.Department := Rec."Global Dimension 2 Code";
                                ClearEntries."Student ID" := Rec."No.";
                                ClearEntries."Clear By ID" := ClearStandardApp."Clear By Id";
                                ClearEntries."Initiated By" := UserId;
                                ClearEntries."Initiated Date" := Today;
                                ClearEntries."Initiated Time" := Time;
                                ClearEntries."Last Date Modified" := Today;
                                ClearEntries."Last Time Modified" := Time;
                                ClearEntries.Cleared := false;
                                ClearEntries."Priority Level" := ClearLevela."Priority Level";
                                ClearEntries."Academic Year" := ACACourseRegistration."Academic Year";
                                ClearEntries.Semester := ACACourseRegistration.Semester;
                                if ClearLevela."Priority Level" = ClearLevela."priority level"::"1st Level" then begin
                                    ClearEntries.Status := ClearEntries.Status::Open;
                                    ClearEntries.Insert;
                                    UserSetup.Reset;
                                    UserSetup.SetRange("User ID", ClearStandardApp."Clear By Id");
                                    if UserSetup.Find('-') then begin

                                        webportals.SendEmailEasy('Hi ', UserSetup.UserName, 'A Student clearance request has been sent to your email for student:' + Rec."No.",
                                        'Kindly expedite.', 'This is a system generated mail. Kindly do not respond. Unless you want to talk to a Robot!',
                                        'In case of Challenges, Kindly Talk to the ICT department', UserSetup."E-Mail", 'STUDENT CLEARANCE APPROVAL');
                                    end;
                                end else begin
                                    ClearEntries.Status := ClearEntries.Status::Created;
                                    ClearEntries.Insert;
                                end;

                            end; //1
                            until ClearStandardApp.Next = 0; //  Rep1
                        end else
                            Error('Setup for Clearance Templates not found;');  // 2
                    end else begin    //3
                                      // Check templates for the related Clearance Approvals
                        ClearTemplates.Reset;
                        ClearTemplates.SetRange(ClearTemplates."Clearance Level Code", ClearLevela."Clearance Level Code");
                        ClearTemplates.SetRange(ClearTemplates.Department, Rec."Global Dimension 2 Code");
                        ClearTemplates.SetFilter(ClearTemplates.Active, '=%1', true);
                        if ClearTemplates.Find('-') then begin  //6
                            ClearDepTemplates.Reset;
                            ClearDepTemplates.SetRange(ClearDepTemplates."Clearance Level Code", ClearLevela."Clearance Level Code");
                            ClearDepTemplates.SetRange(ClearDepTemplates.Department, Rec."Global Dimension 2 Code");
                            ClearDepTemplates.SetFilter(ClearDepTemplates.Active, '=%1', true);
                            if ClearDepTemplates.Find('-') then begin//7
                                repeat
                                begin
                                    ClearEntries.Init;
                                    ClearEntries."Clearance Level Code" := ClearDepTemplates."Clearance Level Code";
                                    ClearEntries.Department := Rec."Global Dimension 2 Code";
                                    ClearEntries."Student ID" := Rec."No.";
                                    ClearEntries."Clear By ID" := ClearDepTemplates."Clear By Id";
                                    ClearEntries."Initiated By" := UserId;
                                    ClearEntries."Initiated Date" := Today;
                                    ClearEntries."Initiated Time" := Time;
                                    ClearEntries."Last Date Modified" := Today;
                                    ClearEntries."Last Time Modified" := Time;
                                    ClearEntries.Cleared := false;
                                    ClearEntries."Priority Level" := ClearLevela."Priority Level";
                                    ClearEntries."Academic Year" := ACACourseRegistration."Academic Year";
                                    ClearEntries.Semester := ACACourseRegistration.Semester;
                                    if ClearLevela."Priority Level" = ClearLevela."priority level"::"1st Level" then begin
                                        ClearEntries.Status := ClearEntries.Status::Open;
                                        ClearEntries.Insert;
                                        UserSetup.Reset;
                                        UserSetup.SetRange("User ID", ClearStandardApp."Clear By Id");
                                        if UserSetup.Find('-') then begin
                                            webportals.SendEmailEasy('Hi ', UserSetup.UserName, 'A Student clearance request has been sent to your email for student:' + Rec."No.",
                                            'Kindly expedite.', 'This is a system generated mail. Kindly do not respond. Unless you want to talk to a Robot!',
                                            'In case of Challenges, Kindly Talk to the ICT department', UserSetup."E-Mail", 'STUDENT CLEARANCE APPROVAL');
                                        end;
                                    end else begin
                                        ClearEntries.Status := ClearEntries.Status::Created;
                                        ClearEntries.Insert;
                                    end;
                                end;
                                until ClearDepTemplates.Next = 0;
                            end;//7
                        end //6
                    end;   //3
                end;  //4
                until ClearLevela.Next = 0;
            end else
                Error('No Clearance levels specified.');  //5
            Message := 'Clearance Initiated successfully.';
            Rec."Clearance Status" := Rec."clearance status"::Active;
            Rec.Modify;
        end;

    end;


    procedure BookHostel(studentNo: Text; MyHostelNo: Text; MySemester: Text; AccademicYear: Text; myRoomNo: Text; MyAccomFee: Decimal; mySpaceNo: Text)
    begin
        HostelRooms.Reset;
        HostelRooms.Init;
        HostelRooms.Student := studentNo;
        HostelRooms."Space No" := mySpaceNo;
        HostelRooms."Room No" := myRoomNo;
        HostelRooms."Hostel No" := MyHostelNo;
        HostelRooms."Accomodation Fee" := MyAccomFee;
        HostelRooms."Allocation Date" := Today;
        HostelRooms.Semester := MySemester;
        HostelRooms."Academic Year" := AccademicYear;
        HostelRooms.Insert;

        RoomSpaces.Reset;
        RoomSpaces.SetRange(RoomSpaces."Space Code", mySpaceNo);
        if RoomSpaces.Find('-') then begin
            RoomSpaces.Booked := true;
            RoomSpaces.Validate(RoomSpaces."Space Code");
            RoomSpaces.Modify;
            Message('Room space Updated Successfully');
        end;
    end;


    procedure GetHasBooked(username: Text; sem: Text) Message: Text
    begin
        HostelRooms.Reset;
        HostelRooms.SetRange(HostelRooms.Student, username);
        HostelRooms.SetRange(HostelRooms.Semester, sem);
        if HostelRooms.Find('-') then begin
            Message := HostelRooms.Student + '::' + HostelRooms."Space No" + '::' + HostelRooms."Room No" + '::' +
  HostelRooms."Hostel No" + '::' + Format(HostelRooms."Accomodation Fee") + '::' + HostelRooms.Semester + '::' + Format(HostelRooms."Allocation Date");

        end;
    end;


    procedure GetHostelDesc(HostelNo: Text) Message: Text
    begin
        HostelCard.Reset;
        HostelCard.SetRange(HostelCard."Asset No", HostelNo);
        if HostelCard.Find('-') then begin
            Message := HostelCard.Description;

        end;
    end;

    procedure UpdateStudentProfile(username: Text; genderz: Integer; DoB: Date; Countyz: Text; Tribes: Text; Disabled: Integer)
    begin
        StudentCard.Reset;
        StudentCard.SetRange(StudentCard."No.", username);
        if StudentCard.Find('-') then begin
            StudentCard.Gender := genderz;
            StudentCard."Date Of Birth" := DoB;
            StudentCard.County := Countyz;
            StudentCard.Tribe := Tribes;
            //StudentCard."Disability Status":=Disabled;
            StudentCard.Modify;
            Message('Updated Successfully');
        end;
    end;

    procedure StudentProfileUpdated(username: Text) Message: Text
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", username);
        if Customer.Find('-') then begin
            Message := Format(Customer."Updated Profile");
        end
    end;

    procedure GetUniversityMailPass(username: Text) Message: Text
    begin
        StudentCard.Reset;
        StudentCard.SetRange(StudentCard."No.", username);
        if StudentCard.Find('-') then begin
            // Message:=StudentCard."University Email"+'::'+StudentCard."Email Password"+'::'+StudentCard."Phone No.";

        end
    end;

    procedure GetStudentPersonaldata(username: Text) Message: Text
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", username);
        if Customer.Find('-') then begin
            Message := Customer.Name + '::' + Format(Customer.Gender) + '::' + Customer."ID No" + '::' + Format(Customer."Date Of Birth") + '::' +
             Customer."Phone No." + '::' + Format(Customer."Disability Status") + '::' + Format(Customer.Tribe) + '::' + Format(Customer.Nationality)
             + '::' + Format(Customer.County) + '::' +
             Customer.Address + '::' + Customer."Post Code" + '::' + Customer."Address 2" + '::' + Customer."Disability Description" + '::' +
             Customer."E-Mail";
        end
    end;

    procedure UpdateContStudentProfile(username: Text; Genderz: Integer; Phonez: Code[20]; Boxz: Code[50]; Codesz: Code[20]; Townz: Code[40]; Emailz: Text; Countyz: Code[50]; DateofBirth: Date; IDNumber: Text; PhysicalImpairments: Integer; PhysicalImpairmentsDetails: Text; Ethnic: Code[50]; Nationalityz: Code[50])
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", username);
        if Customer.Find('-') then begin
            Customer.Gender := Genderz;
            Customer."ID No" := IDNumber;
            Customer."Date Of Birth" := DateofBirth;
            Customer."Phone No." := Phonez;
            // Customer."Disability Status":=FORMATPhysicalImpairments;
            Customer.Tribe := Ethnic;
            Customer.Nationality := Nationalityz;
            Customer.County := Countyz;
            Customer.Address := Boxz;
            Customer."Post Code" := Codesz;
            Customer."Address 2" := Townz;
            Customer."Disability Description" := PhysicalImpairmentsDetails;
            Customer."E-Mail" := Emailz;
            Customer."Updated Profile" := true;
            Customer.Modify;
            //MESSAGE('Meal Item Updated Successfully');
        end;
    end;


    procedure IsLecturer(LectNo: Text) Message: Text
    begin
        HrEmployeeC.Reset;
        HrEmployeeC.SetRange(HrEmployeeC."No.", LectNo);
        HrEmployeeC.SetRange(HrEmployeeC.Lecturer, true);
        if HrEmployeeC.Find('-') then begin
            Message := 'Yes' + '::';
        end;
    end;


    procedure GetProgrammeCurrentSemData(ProgId: Code[30]) Message: Text
    begin
        ProgrammeSemesters.Reset;
        ProgrammeSemesters.SetRange(ProgrammeSemesters.Current, true);
        if ProgrammeSemesters.Find('-') then begin
            Message := ProgrammeSemesters.Semester + '::' + ProgrammeSemesters.Semester + '::' + Format(CurrentSem."Registration Deadline");
        end;
    end;


    procedure CaptureMarksValidation(Programz: Code[20]; Semesterz: Code[20]; Unitz: Code[20]; UserNamez: Code[50]; LecturerNamez: Text[250]) MarksCaptureReturn: Text[250]
    var
        AcaProgram: Record "ACA-Programme";
        HRMEmployeeC: Record "HRM-Employee C";
        ACASemesters: Record "ACA-Semesters";
        LectLoadBatchLines: Record "Lect Load Batch Lines";
        ACALecturersUnits: Record "ACA-Lecturers Units";
        HRMEmployeeC2: Record "HRM-Employee C";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        ACAProgSemesterSchedule: Record "ACA-Prog. Semester Schedule";
        ACAProgStageSemSchedule: Record "ACA-Prog/Stage Sem. Schedule";
        ACAProgStageUnitSemSche: Record "ACA-Prog/Stage/Unit Sem. Sche.";
        ACALectureMarksPermissions: Record "ACA-Lecture Marks Permissions";
        EdittingLocked: Boolean;
    begin
        Clear(MarksCaptureReturn);
        if AcaProgram.Get(Programz) then;

        ACASemesters.Reset;
        ACASemesters.SetRange(ACASemesters.Code, Semesterz);
        if ACASemesters.Find('-') then;
        //Check from Prog, Stage, Unit and Lecturer Units if Capture of Marks is allowed
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        ACAProgSemesterSchedule.Reset;
        ACAProgSemesterSchedule.SetRange(Code, Semesterz);
        ACAProgSemesterSchedule.SetRange("Programme Code", AcaProgram.Code);
        if ACAProgSemesterSchedule.Find('-') then;
        ACAProgStageSemSchedule.Reset;
        ACAProgStageSemSchedule.SetRange(Code, Semesterz);
        ACAProgStageSemSchedule.SetRange("Programme Code", AcaProgram.Code);
        ACAProgStageSemSchedule.SetRange(Code, ACAUnitsSubjects."Stage Code");
        if ACAProgStageSemSchedule.Find('-') then;
        ACAProgStageUnitSemSche.Reset;
        ACAProgStageUnitSemSche.SetRange(Code, Semesterz);
        ACAProgStageUnitSemSche.SetRange("Programme Code", AcaProgram.Code);
        ACAProgStageUnitSemSche.SetRange("Unit Code", ACAUnitsSubjects.Code);
        if ACAProgStageUnitSemSche.Find('-') then;
        ACALectureMarksPermissions.Reset;
        ACALectureMarksPermissions.SetRange(Code, Semesterz);
        ACALectureMarksPermissions.SetRange("Programme Code", AcaProgram.Code);
        ACALectureMarksPermissions.SetRange("Unit Code", ACAUnitsSubjects.Code);
        ACALectureMarksPermissions.SetRange("Lecturer Code", UserNamez);
        if ACALectureMarksPermissions.Find('-') then;
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // Check if Marks exceeds Maximum Defined
        //  (ACALectureMarksPermissions."Lock Exam Editting") AND
        Clear(EdittingLocked);
        if ((ACAProgSemesterSchedule."Lock Exam Editing")
          and (ACAProgStageUnitSemSche."Lock Exam Editting") and
          (ACAProgStageSemSchedule."Lock Exam Editting") and
            (ACASemesters."Lock Exam Editting"))
           //       AND
           //       (ACAProgStageUnitSemSche."Mark entry Dealine"<TODAY)
           //      AND (ACAProgStageSemSchedule."Mark entry Dealine"<TODAY) AND
           //       (ACAProgSemesterSchedule."Mark entry Dealine"<TODAY)
           then
            EdittingLocked := true;

        ACASemesters.Reset;
        ACASemesters.SetRange(ACASemesters.Code, Semesterz);
        //    ACASemesters.SETRANGE(ACASemesters."Programme Code",Programz);
        if ACASemesters.Find('-') then begin
            HRMEmployeeC.Reset;
            HRMEmployeeC.SetRange("No.", UserNamez);
            if HRMEmployeeC.Find('-') then begin
                if ((HRMEmployeeC.Lecturer = false) and ((HRMEmployeeC."Is HOD" = false) and (HRMEmployeeC."Has HOD Rights" = false))) then MarksCaptureReturn := 'Access Denied: Not Lecturer Not HOD';

                if ((ACASemesters."Lock CAT Editting") and ((HRMEmployeeC."Is HOD" = false) and (HRMEmployeeC."Has HOD Rights" = false))) then
                    MarksCaptureReturn := 'CAT Marks editing locked';
                if ((ACASemesters."Lock CAT Editting") and ((HRMEmployeeC."Is HOD" = true) or (HRMEmployeeC."Has HOD Rights" = true)) and (ACASemesters."Evaluate Lecture" = false)) then
                    MarksCaptureReturn := 'CAT Marks editing locked';
                // -------------------------------------------------------------- Exams

                if ((EdittingLocked) and ((HRMEmployeeC."Is HOD" = false) and (HRMEmployeeC."Has HOD Rights" = false))) then
                    MarksCaptureReturn := 'EXAM Marks editing locked';
                if ((EdittingLocked = false) and (HRMEmployeeC.Lecturer = false)) then MarksCaptureReturn := 'Not Lecturer: Access denied!';
                if ((EdittingLocked) and ((HRMEmployeeC."Is HOD" = true) or (HRMEmployeeC."Has HOD Rights" = true)) and (ACASemesters."Evaluate Lecture" = false)) then
                    MarksCaptureReturn := 'EXAM Marks editing locked';
                if ((HRMEmployeeC."Is HOD" = true) and (ACASemesters."Evaluate Lecture" = false) and (HRMEmployeeC.Lecturer = false)) then
                    MarksCaptureReturn := 'HOD editing not allowed';
                ACAUnitsSubjects.Reset;
                ACAUnitsSubjects.SetRange(Code, Unitz);
                ACAUnitsSubjects.SetRange("Programme Code", Programz);
                if ACAUnitsSubjects.Find('-') then
                    if ACAUnitsSubjects."Common Unit" = false then;
                //            IF (((HRMEmployeeC."Is HOD"=TRUE) OR (HRMEmployeeC."Has HOD Rights"=TRUE)) AND (ACASemesters."Evaluate Lecture"=TRUE) AND  (AcaProgram."Department Code"<>HRMEmployeeC."Department Code") ) THEN
                //            MarksCaptureReturn:=AcaProgram."Department Code"+' is not your department!';
            end else
                MarksCaptureReturn := 'Invalid Staff No. ' + Semesterz;
        end else
            MarksCaptureReturn := 'Invalid Semester ' + Semesterz;

        if MarksCaptureReturn = '' then MarksCaptureReturn := 'SUCCESS';
    end;


    procedure IsProgOptionsAllowed(Prog: Code[20]; Stage: Code[20]) Message: Text
    begin
        ProgStages.Reset;
        ProgStages.SetRange(ProgStages.Code, Stage);
        ProgStages.SetRange(ProgStages."Programme Code", Prog);
        ProgStages.SetRange(ProgStages."Allow Programme Options", true);
        if ProgStages.Find('-') then begin
            Message := 'Yes' + '::';
        end else begin
            Message := 'No' + '::';
        end;
    end;


    procedure DeleteRegisteredUnit(Unit: Code[20]; Sem: Code[20]; StudNo: Code[20]) rtnMsg: Text
    var
        studetUnits: Record "ACA-Student Units";
    begin
        studetUnits.Reset;
        studetUnits.SetRange(studetUnits."Student No.", StudNo);
        studetUnits.SetRange(studetUnits.Semester, Sem);
        studetUnits.SetRange(studetUnits.Unit, Unit);
        if studetUnits.Find('-') then begin
            studetUnits.CalcFields("CATs Marks Exists", "EXAMs Marks Exists");
            if ((studetUnits."CATs Marks Exists") or (studetUnits."EXAMs Marks Exists")) then
                rtnMsg := 'Marks Exist you cannot Delete!';
            if (rtnMsg = '') then begin
                studetUnits.Delete;
                rtnMsg := 'SUCCESS: You have deleted ' + Unit;
            end;
        end;
    end;


    procedure RegisterSupp(StudentNo: Code[20]; UnitCode: Code[20]; AcademicYear: Code[20]; Semesterz: Code[20]) RetunMsg: Text[250]
    var
        AcaSpecialExamsDetailss: Record "Aca-Special Exams Details";
        ACAStudentUnits: Record "ACA-Student Units";
        ACAProgramme: Record "ACA-Programme";
        Sequences: Integer;
    begin
        ACAStudentUnits.Reset;
        ACAStudentUnits.SetRange("Student No.", StudentNo);
        ACAStudentUnits.SetRange(Unit, UnitCode);
        if ACAStudentUnits.Find('-') then;
        ACAProgramme.Reset;
        ACAProgramme.SetRange(Code, ACAStudentUnits.Programme);
        if ACAProgramme.Find('-') then;
        AcaSpecialExamsDetailss.Init;
        AcaSpecialExamsDetailss."Academic Year" := ACAStudentUnits."Academic Year";
        AcaSpecialExamsDetailss.Semester := ACAStudentUnits.Semester;
        AcaSpecialExamsDetailss."Student No." := StudentNo;
        AcaSpecialExamsDetailss.Programme := ACAStudentUnits.Programme;
        AcaSpecialExamsDetailss.Stage := ACAStudentUnits.Stage;
        AcaSpecialExamsDetailss.Validate("Unit Code", UnitCode);
        AcaSpecialExamsDetailss."Current Academic Year" := AcademicYear;
        AcaSpecialExamsDetailss."Current Academic Year" := ACAStudentUnits."Academic Year";
        AcaSpecialExamsDetailss.Category := AcaSpecialExamsDetailss.Category::Supplementary;
        if AcaSpecialExamsDetailss.Insert then RetunMsg := 'SUCCESS' else RetunMsg := 'FAILED';

        AcaSpecialExamsDetailss.Reset;
        AcaSpecialExamsDetailss.SetRange("Student No.", StudentNo);
        AcaSpecialExamsDetailss.SetRange("Unit Code", UnitCode);
        AcaSpecialExamsDetailss.SetRange("Academic Year", AcademicYear);
        AcaSpecialExamsDetailss.SetRange(Semester, Semesterz);
        AcaSpecialExamsDetailss.SetRange(Sequence, Sequences);
        if AcaSpecialExamsDetailss.Find('-') then begin
            // Get Special Exam Charges And Post. Then tag the record as Billed
        end;
    end;


    procedure DeleteRegisteredSupp(Unit: Code[20]; Sem: Code[20]; StudNo: Code[20]) rtnMsg: Text
    var
        AcaSpecialExamsDetailss: Record "Aca-Special Exams Details";
        ACAStudentUnits: Record "ACA-Student Units";
        ACAProgramme: Record "ACA-Programme";
    begin
        AcaSpecialExamsDetailss.Reset;
        AcaSpecialExamsDetailss.SetRange(AcaSpecialExamsDetailss."Student No.", StudNo);
        AcaSpecialExamsDetailss.SetRange(AcaSpecialExamsDetailss.Semester, Sem);
        AcaSpecialExamsDetailss.SetRange(AcaSpecialExamsDetailss."Unit Code", Unit);
        if AcaSpecialExamsDetailss.Find('-') then begin
            if ((AcaSpecialExamsDetailss."Exam Marks" <> 0)) then
                rtnMsg := 'Marks Exist you cannot Delete!';
            if (rtnMsg = '') then begin
                AcaSpecialExamsDetailss.Delete;
                rtnMsg := 'SUCCESS: You have deleted ' + Unit;
            end;
        end;
    end;


    procedure IsHoD(LectNo: Text) Message: Text
    begin
        Clear(Message);
        HrEmployeeC.Reset;
        HrEmployeeC.SetRange(HrEmployeeC."No.", LectNo);
        HrEmployeeC.SetRange(HrEmployeeC."HOD", true);
        if HrEmployeeC.Find('-') then begin
            Message := 'Yes' + '::';
        end;
        if Message = '' then begin
            HrEmployeeC.Reset;
            HrEmployeeC.SetRange(HrEmployeeC."No.", LectNo);
            HrEmployeeC.SetRange(HrEmployeeC."Has HOD Rights", true);
            if HrEmployeeC.Find('-') then begin
                Message := 'Yes' + '::';
            end;
        end;
    end;


    procedure GetCurrentProgramSemester(ProgCode: Code[20]; Stagesz: Code[20]) CurrentSemester: Code[20]
    var
        ACAProgramme: Record "ACA-Programme";
        ACAProgrammeStageSemesters: Record "ACA-Programme Stage Semesters";
        ACAProgrammeSemesters: Record "ACA-Programme Semesters";
        semesterz: Record "ACA-Semesters";
    begin
        Clear(CurrentSemester);
        ACAProgramme.Reset;
        ACAProgramme.SetRange(Code, ProgCode);
        if ACAProgramme.Find('-') then
            if ACAProgramme."Use Program Semesters" then begin
                ACAProgrammeStageSemesters.Reset;
                ACAProgrammeStageSemesters.SetRange("Programme Code", ProgCode);
                ACAProgrammeStageSemesters.SetRange(Stage, Stagesz);
                ACAProgrammeStageSemesters.SetRange(Current, true);
                if ACAProgrammeStageSemesters.Find('-') then begin
                    CurrentSemester := ACAProgrammeStageSemesters.Semester;
                end;

                if CurrentSemester = '' then begin
                    //Pick from general Semester
                    ACAProgrammeSemesters.Reset;
                    ACAProgrammeSemesters.SetRange(Current, true);
                    ACAProgrammeSemesters.SetRange("Programme Code", ProgCode);
                    if ACAProgrammeSemesters.Find('-') then begin
                        CurrentSemester := ACAProgrammeSemesters.Semester;

                    end;
                end;
            end;
        if CurrentSemester = '' then begin
            semesterz.Reset;
            semesterz.SetRange("Current Semester", true);
            if semesterz.Find('-') then begin
                CurrentSemester := semesterz.Code;
            end;
        end;
    end;


    procedure ApproveAction(DocumentNo: Code[20]; ApproverID: Code[20]; SequenceNo: Integer; Table_Id: Integer; DocumentType: Integer; ApprovalActions: Text[150]; RejectReason: Text[250])
    var
        ApprovalCommentLine: Record "Approval Comment Line";
        ApprovalCommentLine2: Record "Approval Comment Line";
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocumentNo);
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", ApproverID);
        ApprovalEntry.SetRange(ApprovalEntry."Sequence No.", SequenceNo);
        ApprovalEntry.SetRange(ApprovalEntry."Table ID", Table_Id);
        ApprovalEntry.SetRange(ApprovalEntry."Document Type", DocumentType);
        if ApprovalEntry.Find('-') then begin
            repeat
            // if not ApprovalSetup.Get then
            //     Error(Text004);
            // if ApprovalActions = 'APPROVE' then
            //     AppMgt.ApproveApprovalRequest(ApprovalEntry)
            // else if ApprovalActions = 'REJECT' then begin
            //     AppMgt.RejectApprovalRequest(ApprovalEntry);
            //     if RejectReason <> '' then begin
            //         ApprovalCommentLine2.Reset;
            //         if ApprovalCommentLine2.Find('+') then;
            //         ApprovalCommentLine.Init;
            //         ApprovalCommentLine."Entry No." := ApprovalCommentLine2."Entry No." + 1;
            //         ApprovalCommentLine."Document No." := DocumentNo;
            //         ApprovalCommentLine."Document Type" := DocumentType;
            //         ApprovalCommentLine."Table ID" := Table_Id;
            //         ApprovalCommentLine."User ID" := ApproverID;
            //         ApprovalCommentLine."Date and Time" := CreateDatetime(Today, Time);
            //         ApprovalCommentLine.Comment := RejectReason;
            //         if ApprovalCommentLine.INSERT(True) then;
            //     end;
            // end else if ApprovalActions = 'CANCEL' then begin
            //     AppMgt.CancelApproval(ApprovalEntry."Table ID", ApprovalEntry."Document Type", ApprovalEntry."Document No.", false, false);
            //     if RejectReason <> '' then begin
            //         ApprovalCommentLine2.Reset;
            //         if ApprovalCommentLine2.Find('+') then;
            //         ApprovalCommentLine.Init;
            //         ApprovalCommentLine."Entry No." := ApprovalCommentLine2."Entry No." + 1;
            //         ApprovalCommentLine."Document No." := DocumentNo;
            //         ApprovalCommentLine."Document Type" := DocumentType;
            //         ApprovalCommentLine."Table ID" := Table_Id;
            //         ApprovalCommentLine."User ID" := ApproverID;
            //         ApprovalCommentLine."Date and Time" := CreateDatetime(Today, Time);
            //         ApprovalCommentLine.Comment := RejectReason;
            //         if ApprovalCommentLine.INSERT(True) then;
            //     end;
            // end else if ApprovalActions = 'DELEGATE' then
            //         AppMgt.DelegateApprovalRequest(ApprovalEntry);

            until ApprovalEntry.Next = 0;
        end;
    end;


    procedure ConfirmSupplementary(StudentNo: Code[20]; UnitCode: Code[20]; AcademicYear: Code[20]; Semenster: Code[20]; SuppCategory: Integer) RetunMsg: Text[50]
    var
        Aca2ndSuppExamsDetails: Record "Aca-2nd Supp. Exams Details";
        AcaSpecialExamsDetailss: Record "Aca-Special Exams Details";
        ACAStudentUnits: Record "ACA-Student Units";
        ACAProgramme: Record "ACA-Programme";
        ACACourseRegistration: Record "ACA-Course Registration";
        GenJnl: Record "Gen. Journal Line";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        ACAGeneralSetUp: Record "ACA-General Set-Up";
        ACACharge: Record "ACA-Charge";
        cust: Record Customer;
        BatchNos: Code[20];
    begin
        //Create and delete Journal Template & Batch
        Clear(ACACharge);
        Clear(BatchNos);
        Clear(cust);
        if StrLen(StudentNo) > 10 then
            BatchNos := CopyStr(StudentNo, 1, 10)
        else
            BatchNos := StudentNo;
        cust.Reset;
        cust.SetRange("No.", StudentNo);
        if cust.Find('-') then;
        ACAGeneralSetUp.Get();
        ACAGeneralSetUp.TestField("Supplimentary Fee");
        ACAGeneralSetUp.TestField("Supplimentary Fee Code");
        ACACharge.Reset;
        ACACharge.SetRange(Code, ACAGeneralSetUp."Supplimentary Fee Code");
        if ACACharge.Find('-') then begin
            ACACharge.TestField(Amount);
            ACACharge.TestField("G/L Account");
        end else
            Error('Invalid Charge!');
        Clear(GenJournalTemplate);
        Clear(GenJournalBatch);
        if not (GenJournalTemplate.Get('SUPP')) then begin
            GenJournalTemplate.Init;
            GenJournalTemplate.Name := 'SUPP';
            GenJournalTemplate.Insert(true);
        end;
        GenJournalBatch.Reset;
        GenJournalBatch.SetRange("Journal Template Name", 'SUPP');
        GenJournalBatch.SetRange(Name, BatchNos);
        if not (GenJournalBatch.Find('-')) then begin
            GenJournalBatch.Init;
            GenJournalBatch."Journal Template Name" := 'SUPP';
            GenJournalBatch.Name := BatchNos;
            GenJournalBatch.Insert(true);
        end;

        Clear(RetunMsg);
        RetunMsg := 'FAILED';
        ACAStudentUnits.Reset;
        ACAStudentUnits.SetRange("Student No.", StudentNo);
        ACAStudentUnits.SetRange(Unit, UnitCode);
        ACAStudentUnits.SetRange("Reg Reversed", false);
        if ACAStudentUnits.Find('-') then;
        ACAProgramme.Reset;
        ACAProgramme.SetRange(Code, ACAStudentUnits.Programme);
        if ACAProgramme.Find('-') then;
        if SuppCategory = 1 then begin
            AcaSpecialExamsDetailss.Reset;
            AcaSpecialExamsDetailss.SetRange("Student No.", StudentNo);
            AcaSpecialExamsDetailss.SetRange("Unit Code", UnitCode);
            AcaSpecialExamsDetailss.SetRange("Academic Year", AcademicYear);
            if AcaSpecialExamsDetailss.Find('-') then begin
                // Get Special Exam Charges And Post. Then tag the record as Billed
                AcaSpecialExamsDetailss."Charge Posted" := true;
                AcaSpecialExamsDetailss.Modify;
                RetunMsg := 'FAILED';
                // Post Charge Here
                /////////////////////////////////////////////////////////////////////////////////////
                GenJnl.Reset;
                GenJnl.SetRange("Journal Batch Name", StudentNo);
                GenJnl.SetRange("Journal Template Name", 'SUPP');
                if GenJnl.Find('-') then GenJnl.DeleteAll;
                GenJnl.Init;
                GenJnl."Line No." := 10000;
                GenJnl."Posting Date" := Today;
                GenJnl."Document No." := 'SUPP.' + UnitCode;
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SUPP';
                GenJnl."Journal Batch Name" := BatchNos;
                GenJnl."Account Type" := GenJnl."account type"::Customer;
                GenJnl."Account No." := StudentNo;
                GenJnl.Amount := ACACharge.Amount;
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := '1st Supp. Charges for ' + UnitCode;
                GenJnl."Bal. Account Type" := GenJnl."account type"::"G/L Account";
                GenJnl."Bal. Account No." := ACACharge."G/L Account";
                GenJnl.Validate(GenJnl."Bal. Account No.");
                ACAProgramme.TestField("Department Code");
                GenJnl."Shortcut Dimension 1 Code" := cust."Global Dimension 1 Code";
                GenJnl."Shortcut Dimension 2 Code" := ACAProgramme."Department Code";
                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");

                GenJnl.Insert;

                //Post Charge
                GenJnl.Reset;
                GenJnl.SetRange("Journal Template Name", 'SUPP');
                GenJnl.SetRange("Journal Batch Name", BatchNos);
                if GenJnl.FindSet() then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnl);
                end;
                /////////////////////////////////////////////////////////////////////////////////////

                RetunMsg := 'SUCCESS';
                // Delete The Student Journal from the Batches
                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", 'SUPP');
                GenJournalBatch.SetRange(Name, BatchNos);
                if GenJournalBatch.Find('-') then GenJournalBatch.DeleteAll;
                RetunMsg := 'SUCCESS';
            end;
        end else if SuppCategory = 2 then begin
            Aca2ndSuppExamsDetails.Reset;
            Aca2ndSuppExamsDetails.SetRange("Student No.", StudentNo);
            Aca2ndSuppExamsDetails.SetRange("Unit Code", UnitCode);
            Aca2ndSuppExamsDetails.SetRange("Academic Year", AcademicYear);
            if Aca2ndSuppExamsDetails.Find('-') then begin
                Aca2ndSuppExamsDetails."Charge Posted" := true;
                Aca2ndSuppExamsDetails.Modify;
                RetunMsg := 'FAILED';
                // Post Charge Here
                /////////////////////////////////////////////////////////////////////////////////////
                GenJnl.Reset;
                GenJnl.SetRange("Journal Batch Name", StudentNo);
                GenJnl.SetRange("Journal Template Name", 'SUPP');
                if GenJnl.Find('-') then GenJnl.DeleteAll;
                GenJnl.Init;
                GenJnl."Line No." := 10000;
                GenJnl."Posting Date" := Today;
                GenJnl."Document No." := 'SUPP.' + UnitCode;
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SUPP';
                GenJnl."Journal Batch Name" := BatchNos;
                GenJnl."Account Type" := GenJnl."account type"::Customer;
                GenJnl."Account No." := StudentNo;
                GenJnl.Amount := ACACharge.Amount;
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := '2nd Supp. Charges for ' + UnitCode;
                GenJnl."Bal. Account Type" := GenJnl."account type"::"G/L Account";
                GenJnl."Bal. Account No." := ACACharge."G/L Account";
                GenJnl.Validate(GenJnl."Bal. Account No.");
                ACAProgramme.TestField("Department Code");
                GenJnl."Shortcut Dimension 1 Code" := cust."Global Dimension 1 Code";
                GenJnl."Shortcut Dimension 2 Code" := ACAProgramme."Department Code";
                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");

                GenJnl.Insert;

                //Post Charge
                GenJnl.Reset;
                GenJnl.SetRange("Journal Template Name", 'SUPP');
                GenJnl.SetRange("Journal Batch Name", BatchNos);
                if GenJnl.FindSet() then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnl);
                end;
                /////////////////////////////////////////////////////////////////////////////////////

                RetunMsg := 'SUCCESS';
                // Delete The Student Journal from the Batches
                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", 'SUPP');
                GenJournalBatch.SetRange(Name, BatchNos);
                if GenJournalBatch.Find('-') then GenJournalBatch.DeleteAll;
                RetunMsg := 'SUCCESS';
            end;
        end;
    end;


    procedure SubmitSupplementaryMarks(StudentNo: Code[20]; LectNo: Code[10]; UnitCode: Code[20]; AcademicYear: Code[20]; Semenster: Code[20]; SuppCategory: Integer; ExamScore: Decimal) ReturnMessage: Text[100]
    var
        Aca2ndSuppExamsDetails: Record "Aca-2nd Supp. Exams Details";
        AcaSpecialExamsDetailss: Record "Aca-Special Exams Details";
        ACAStudentUnits: Record "ACA-Student Units";
        ACAProgramme: Record "ACA-Programme";
        ACACourseRegistration: Record "ACA-Course Registration";
        GenJnl: Record "Gen. Journal Line";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        ACAGeneralSetUp: Record "ACA-General Set-Up";
        ACACharge: Record "ACA-Charge";
        cust: Record Customer;
        Aca2ndSuppExamsResults: Record "Aca-2nd Supp. Exams Results";
        emps: Record "HRM-Employee C";
    begin
        Clear(ReturnMessage);
        Clear(emps);
        emps.Reset;
        emps.SetRange("No.", LectNo);
        if emps.Find('-') then;
        Aca2ndSuppExamsDetails.Reset;
        Aca2ndSuppExamsDetails.SetRange("Current Academic Year", AcademicYear);
        Aca2ndSuppExamsDetails.SetRange("Student No.", StudentNo);
        Aca2ndSuppExamsDetails.SetRange("Unit Code", UnitCode);
        if Aca2ndSuppExamsDetails.Find('-') then begin
            Aca2ndSuppExamsResults.Reset;
            Aca2ndSuppExamsResults.SetRange("Current Academic Year", AcademicYear);
            Aca2ndSuppExamsResults.SetRange("Student No.", StudentNo);
            Aca2ndSuppExamsResults.SetRange(Unit, UnitCode);
            if Aca2ndSuppExamsResults.Find('-') then begin
                Aca2ndSuppExamsResults.Validate(Score, ExamScore);
                Aca2ndSuppExamsResults.UserID := LectNo;
                Aca2ndSuppExamsResults."Lecturer Names" := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
                Aca2ndSuppExamsResults."Modified Date" := Today;
                Aca2ndSuppExamsResults.category := Aca2ndSuppExamsDetails.Category;
                Aca2ndSuppExamsResults.Modify;
                ReturnMessage := 'SUCCESS: Marks Modified!'
            end else begin
                Aca2ndSuppExamsResults.Init;
                Aca2ndSuppExamsResults.Programme := Aca2ndSuppExamsDetails.Programme;
                Aca2ndSuppExamsResults.Stage := Aca2ndSuppExamsDetails.Stage;
                Aca2ndSuppExamsResults.Unit := UnitCode;
                Aca2ndSuppExamsResults.Semester := Aca2ndSuppExamsDetails.Semester;
                Aca2ndSuppExamsResults."Student No." := Aca2ndSuppExamsDetails."Student No.";
                Aca2ndSuppExamsResults."Academic Year" := AcademicYear;
                Aca2ndSuppExamsResults."Admission No" := StudentNo;
                Aca2ndSuppExamsResults."Current Academic Year" := AcademicYear;
                Aca2ndSuppExamsResults.UserID := LectNo;
                Aca2ndSuppExamsResults."Capture Date" := Today;
                Aca2ndSuppExamsResults.category := Aca2ndSuppExamsDetails.Category;
                Aca2ndSuppExamsResults."Lecturer Names" := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
                Aca2ndSuppExamsResults.Validate(Score, ExamScore);
                Aca2ndSuppExamsResults.Insert;
                ReturnMessage := 'SUCCESS: Marks Inserted!';
            end;
            Aca2ndSuppExamsDetails."Exam Marks" := ExamScore;
            Aca2ndSuppExamsDetails.Modify;
        end;




        /*CLEAR(ReturnMessage);
        ReturnMessage:='FAILED';
        IF SuppCategory = 1 THEN BEGIN
        AcaSpecialExamsDetailss.RESET;
        AcaSpecialExamsDetailss.SETRANGE("Academic Year",AcademicYear);
        AcaSpecialExamsDetailss.SETRANGE("Student No.",StudentNo);
        AcaSpecialExamsDetailss.SETRANGE("Unit Code",UnitCode);
        IF AcaSpecialExamsDetailss.FIND('-') THEN BEGIN
          IF AcaSpecialExamsDetailss."Charge Posted" = FALSE THEN ERROR('Supp. Charges for '+UnitCode+'are not posted!');
          AcaSpecialExamsDetailss."Exam Marks":=ExamScore;
          AcaSpecialExamsDetailss.MODIFY;
        ReturnMessage:='SUCCESS';
          END;
          END ELSE IF SuppCategory = 2 THEN BEGIN
        Aca2ndSuppExamsDetails.RESET;
        Aca2ndSuppExamsDetails.SETRANGE("Academic Year",AcademicYear);
        Aca2ndSuppExamsDetails.SETRANGE("Student No.",StudentNo);
        Aca2ndSuppExamsDetails.SETRANGE("Unit Code",UnitCode);
        IF Aca2ndSuppExamsDetails.FIND('-') THEN BEGIN
          IF Aca2ndSuppExamsDetails."Charge Posted" = FALSE THEN ERROR('Supp. Charges for '+UnitCode+'are not posted!');
          Aca2ndSuppExamsDetails."Exam Marks":=ExamScore;
          Aca2ndSuppExamsDetails.MODIFY;
        ReturnMessage:='SUCCESS';
          END;
            END;*/

    end;


    procedure GetLectureEmail(LectNo: Code[20]) LectEmail: Text[150]
    var
        HRMEmployeeC: Record "HRM-Employee C";
    begin
        Clear(HRMEmployeeC);
        Clear(LectEmail);
        HRMEmployeeC.Reset;
        HRMEmployeeC.SetRange("No.", LectNo);
        if HRMEmployeeC.Find() then LectEmail := HRMEmployeeC."Company E-Mail";
    end;


    procedure GetRegistrarEmail() RegistrarMail: Text[150]
    var
        ACAGeneralSetUp: Record "ACA-General Set-Up";
    begin
        Clear(RegistrarMail);
        Clear(ACAGeneralSetUp);
        if ACAGeneralSetUp.Find('-') then begin
            RegistrarMail := ACAGeneralSetUp.Registrar_Mail;
        end;
    end;


    procedure GetNationalIdNumber(User_ID: Code[20]) ReturnMessage: Text[150]
    var
        HrEmployees: Record "HRM-Employee C";
    begin
        ReturnMessage := 'FAILED:: Invalid Employee No.';
        Clear(HrEmployees);
        HrEmployees.Reset;
        HrEmployees.SetRange("No.", User_ID);
        if HrEmployees.Find('-') then begin
            if HrEmployees."ID Number" = '' then
                ReturnMessage := 'FAILED:: Missing ID'
            else
                ReturnMessage := HrEmployees."ID Number";
        end;
    end;


    procedure GetCounties(): Text[1000]
    var
        ACASetupRec: Record "ACA-Academics Central Setups";
    begin

        begin
            Counties := '';
            ACASetupRec.SetRange(Category, 5);
            if ACASetupRec.FindSet then begin
                repeat
                    Counties += ACASetupRec."Title Code" + ' - ' + ACASetupRec.Description + ';';
                until ACASetupRec.Next = 0;
            end;
            exit(Counties);
        end;
    end;


    procedure AdmissionDocApprovalRequests(User_Id: Code[20]) ReturnMessage: Text
    var
        KUCCPSImports: Record "KUCCPS Imports";
        AdmissionApprovalEntries: Record "Admission Approval Entries";
    begin
        Clear(AdmissionApprovalEntries);
        AdmissionApprovalEntries.Reset;
        AdmissionApprovalEntries.SetRange("Academic Year", GetCurrentAcademicYear());
        AdmissionApprovalEntries.SetRange(Approver_Id, User_Id);
        AdmissionApprovalEntries.SetRange("Approval Status", AdmissionApprovalEntries."approval status"::Open);
        if AdmissionApprovalEntries.Find('-') then begin
            repeat
                // ReturnMessage += AdmissionApprovalEntries.Index+'::'+FORMAT(AdmissionApprovalEntries."Document Code")+':::';
                ReturnMessage += AdmissionApprovalEntries.Index + '::' +
                Format(AdmissionApprovalEntries."Document Code") + '::' +
                AdmissionApprovalEntries."NHIF No" + '::' +
                AdmissionApprovalEntries."K.C.P.E. Results" + '::' +
                AdmissionApprovalEntries."ID Number/BirthCert" + '::' +
                AdmissionApprovalEntries.Admin + ':::';

            until AdmissionApprovalEntries.Next = 0;
        end;
    end;


    procedure AdmissionDocApproval(User_Id: Code[20]; DocCode: Code[50]; IndexNumber: Code[20]; ApprovalComments: Text[50]) ReturnMessage: Text[250]
    var
        KUCCPSImports: Record "KUCCPS Imports";
        ACANewStudDocuments: Record "ACA-New Stud. Documents";
    begin
        if User_Id = '' then ReturnMessage := 'No user ID Specified.';
        if IndexNumber = '' then ReturnMessage := 'No Index Number Specified.';
        if ReturnMessage = '' then begin
            Clear(ACANewStudDocuments);
            ACANewStudDocuments.Reset;
            ACANewStudDocuments.SetRange("Academic Year", GetCurrentAcademicYear());
            ACANewStudDocuments.SetRange("Index Number", IndexNumber);
            ACANewStudDocuments.SetRange("Document Code", DocCode);
            if ACANewStudDocuments.Find('-') then begin
                ACANewStudDocuments."Approval Comments" := ApprovalComments;
                ACANewStudDocuments."Approval Status" := ACANewStudDocuments."approval status"::Approved;
                ACANewStudDocuments.Modify;
                ReturnMessage := ACANewStudDocuments.ApproveDocument(ACANewStudDocuments, User_Id);
            end;
        end;
    end;


    procedure SignNorminalRole(Student_No: Code[20]) ReturnMessage: Boolean
    var
        ACACourseRegistration: Record "ACA-Course Registration";
        ACASemesters: Record "ACA-Semesters";
    begin
        Clear(ACASemesters);
        ACASemesters.Reset;
        ACASemesters.SetRange("Current Semester", true);
        if ACASemesters.Find('-') then begin
            Clear(ACACourseRegistration);
            ACACourseRegistration.Reset;
            ACACourseRegistration.SetRange("Student No.", Student_No);
            ACACourseRegistration.SetRange(Semester, ACASemesters.Code);
            if not ACACourseRegistration.Find('-') then begin
                Error('FAILED: No Course registration!');
            end else begin
                if ACACourseRegistration."Signed Nominal Role" = false then begin
                    ACACourseRegistration."Signed Nominal Role" := true;
                    if ACACourseRegistration.Modify then ReturnMessage := true;
                end;
            end;
        end else
            Error('FAILED: No defined current Semester!');
    end;


    procedure CheckNorminalRoleStatus(Student_No: Code[20]) ReturnMessage: Boolean
    var
        ACACourseRegistration: Record "ACA-Course Registration";
        ACASemesters: Record "ACA-Semesters";
    begin
        Clear(ACASemesters);
        ACASemesters.Reset;
        ACASemesters.SetRange("Current Semester", true);
        if ACASemesters.Find('-') then begin
            Clear(ACACourseRegistration);
            ACACourseRegistration.Reset;
            ACACourseRegistration.SetRange("Student No.", Student_No);
            ACACourseRegistration.SetRange(Semester, ACASemesters.Code);
            if ACACourseRegistration.Find('-') then begin
                if ACACourseRegistration."Signed Nominal Role" = true then begin
                    ReturnMessage := true;
                    ;
                end;
            end;
        end;
    end;


    procedure GetMyDocumentsApproved(AdmNo: Code[20]) ReturnMessage: Text[1024]
    var
        ACANewStudDocuments: Record "ACA-New Stud. Documents";
        KUCCPSImports: Record "KUCCPS Imports";
    begin
        Clear(ReturnMessage);
        //ReturnMessage := 'Invalid Admission Number';
        Clear(KUCCPSImports);
        KUCCPSImports.Reset;
        KUCCPSImports.SetRange(Admin, AdmNo);
        if KUCCPSImports.Find('-') then begin

            Clear(ACANewStudDocuments);
            ACANewStudDocuments.Reset;
            ACANewStudDocuments.SetRange("Index Number", KUCCPSImports.Index);
            if ACANewStudDocuments.Find('-') then begin
                repeat
                begin
                    ACANewStudDocuments.CalcFields("Approval Sequence");
                    ACANewStudDocuments.Sequence := ACANewStudDocuments."Approval Sequence";
                    ACANewStudDocuments.Modify;
                end;
                until ACANewStudDocuments.Next = 0;
            end;
            Clear(ACANewStudDocuments);
            ACANewStudDocuments.Reset;
            ACANewStudDocuments.SetRange("Index Number", KUCCPSImports.Index);
            ACANewStudDocuments.SetCurrentkey(Sequence);
            if ACANewStudDocuments.Find('-') then begin
                repeat
                begin
                    ReturnMessage +=
                   KUCCPSImports.Admin + '::' +
                   Format(ACANewStudDocuments."Document Code") + '::' +
                   ACANewStudDocuments."Approval Comments" + ':::' +
                   Format(ACANewStudDocuments."Approval Status") + '::'
                    //ACANewStudDocuments."Approved Date/Time"+'::'+
                    //ACANewStudDocuments.Approver_Id
                end;
                until ACANewStudDocuments.Next = 0;
            end;
        end;
    end;


    procedure SavePesaFlowInvoice(refno: Code[20]; invoiceno: Code[20]; custno: Code[20]; custname: Text[100]; invoiceamt: Decimal; serviceid: Code[20]; desc: Text[50]; token: Text[100]; link: Text[150]) inserted: Boolean
    var
        PesaFlowInvoices: Record "PesaFlow Invoices";
    begin
        PesaFlowInvoices.Reset;
        PesaFlowInvoices.SetRange(BillRefNo, refno);
        if not PesaFlowInvoices.Find('-') then begin
            PesaFlowInvoices.Init;
            PesaFlowInvoices.BillRefNo := refno;
            PesaFlowInvoices.Validate(CustomerRefNo, custno);
            PesaFlowInvoices.InvoiceNo := invoiceno;
            PesaFlowInvoices.CustomerName := custname;
            PesaFlowInvoices.InvoiceAmount := invoiceamt;
            PesaFlowInvoices.ServiceID := serviceid;
            PesaFlowInvoices.Description := desc;
            PesaFlowInvoices.TokenHash := token;
            PesaFlowInvoices.InvoiceLink := link;
            if PesaFlowInvoices.Insert then begin
                inserted := true;
            end;
        end else begin
            Error('Bill Reference Number Already Exists!');
        end;
    end;


    procedure CheckAccomodationFeePaid(stdno: Code[10]) Msg: Boolean
    var
        PesaFlowIntegration: Record "PesaFlow Integration";
    begin
        PesaFlowIntegration.Reset;
        PesaFlowIntegration.SetRange(CustomerRefNo, stdno);
        PesaFlowIntegration.SetRange(PaidAmount, 6500);
        if PesaFlowIntegration.Find('-') then begin
            Msg := true;
        end
    end;


    procedure GenerateBillRefNo() Msg: Text
    var
        refNo: Code[20];
    begin
        refNo := NoSeriesMgt.GetNextNo('FPINV', 0D, true);
        Msg := refNo;
    end;


    procedure IsResident(username: Text) Msg: Boolean
    var
        KUCCPSRaw: Record "KUCCPS Imports";
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(Admin, username);
        KUCCPSRaw.SetRange(Accomodation, KUCCPSRaw.Accomodation::Resident);
        if KUCCPSRaw.Find('-') then begin
            Msg := true;
        end;
    end;

    procedure GetApplicationFee(appno: Code[20]) appfee: Decimal
    var
        Programme: Record "ACA-Programme";
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

    procedure GetApplicationCategory(applicationNo: code[25]) msg: Text
    var
        Applic: Record "ACA-Applic. Form Header";
        Programme: Record "ACA-Programme";
    begin
        applic.Reset();
        Applic.SetRange("Application No.", applicationNo);
        if applic.FindFirst() then begin
            Programme.Reset();
            Programme.SetRange(Code, Applic."First Degree Choice");
            if programme.FindFirst() then begin
                msg := Format(Programme.Levels);
            end;
        end;
    end;

    procedure GetApplicantDetails(username: Text) Msg: Text
    var
        KUCCPSRaw: Record "KUCCPS Imports";
    begin
        KUCCPSRaw.Reset;
        KUCCPSRaw.SetRange(Admin, username);
        if KUCCPSRaw.Find('-') then begin
            Msg := KUCCPSRaw.Phone + ' ::' + KUCCPSRaw.Names + ' ::' + KUCCPSRaw."ID Number/BirthCert" + ' ::' + KUCCPSRaw.Email;
        end;
    end;


    procedure VerifyPesaflowPayment(username: Text; amount: Decimal; serviceid: Text) Msg: Text
    var
        PesaFlowIntegration: Record "PesaFlow Integration";
    begin
        PesaFlowIntegration.Reset;
        PesaFlowIntegration.SetRange(CustomerRefNo, username);
        //PesaFlowIntegration.SETRANGE(PaidAmount, amount);
        PesaFlowIntegration.SetRange(ServiceID, serviceid);
        if PesaFlowIntegration.Find('-') then
            Msg := ''
        else
            Msg := 'Not found';
    end;

    procedure Check_Hostel_Availability(Index_No: Code[20]) AvailabilityStatus: Text[50]
    var
        KUCCPSImports: Record "KUCCPS Imports";
    begin
        Clear(AvailabilityStatus);
        AvailabilityStatus := 'FULL';
        Clear(KUCCPSImports);
        KUCCPSImports.Reset;
        KUCCPSImports.SetRange(Index, Index_No);
        if KUCCPSImports.Find('-') then begin

            if KUCCPSImports.Accomodation = KUCCPSImports.Accomodation::Resident then begin
                KUCCPSImports.CalcFields("Total Resident Students", "Available Room Spaces (M)", "Available Room Spaces (F)");
                if KUCCPSImports.Gender = KUCCPSImports.Gender::Male then begin
                    if KUCCPSImports."Total Resident Students" > KUCCPSImports."Available Room Spaces (M)" then begin
                        AvailabilityStatus := 'FULL';
                    end else
                        AvailabilityStatus := 'AVAILABLE';
                end else if KUCCPSImports.Gender = KUCCPSImports.Gender::Female then begin
                    if KUCCPSImports."Total Resident Students" > KUCCPSImports."Available Room Spaces (F)" then begin
                        AvailabilityStatus := 'FULL';
                    end else
                        AvailabilityStatus := 'AVAILABLE';
                end;
            end;
        end else
            Error('Invalid Index.')
    end;


    procedure Send_SMS_Easy(RecPhoneNumber: Code[20]; Message_1: Text[250]; Message_2: Text[250]; Message_3: Text[250])
    var
        Command: Text;
        Result: Text;
        ErrorMsg: Text;
    // SMSTokes: Record "SMS Tokes";
    // SMSHeader: Record UnknownRecord70701;
    begin
        // Clear(SMSTokes);
        // SMSTokes.Init;
        // SMSTokes."SMS Code" := 'AUTO';
        // SMSTokes."Recipient No." := CreateGuid;
        // SMSTokes.Phone := RecPhoneNumber;
        // SMSTokes."Message 1" := Message_1;
        // SMSTokes."Message 2" := Message_2;
        // SMSTokes."Message 3" := Message_3;
        // SMSTokes."Recepient Type" := SMSTokes."recepient type"::" ";
        // SMSTokes."User Code" := UserId;
        // SMSTokes.Insert;

        // Command := 'C:\Users\Public\SendSMS.bat';
        // ExecuteBat := ExecuteBat.ProcessStartInfo('cmd', '/c "' + Command + '"');     //Provide Details of the Process that need to be Executed.

        // ExecuteBat.RedirectStandardError := true;      // In Case of Error the Error Should be Redirected.

        // ExecuteBat.RedirectStandardOutput := true;     // In Case of Sucess the Error Should be Redirected.

        // ExecuteBat.UseShellExecute := false;

        // ExecuteBat.CreateNoWindow := true;             // In case we want to see the window set it to False.

        // Process := Process.Process;                    // Constructor

        // Process.StartInfo(ExecuteBat);

        // Process.Start;
        // Message('SMS is in queue');
    end;


    procedure CheckRecruitmentApplicantLogin(username: Text; userpassword: Text) Message: Text
    var
        FullNames: Text;
        Initials: Option;
        pCode: Code[30];
        IDNum: Text;
        Gender: Option;
        Phone: Code[20];
        rAddress: Text;
        Citizenship: Text;
        County: Text;
        Mstatus: Option;
        Eorigin: Text;
        Disabled: Text;
        dDetails: Text;
        DOB: Date;
        Dlicense: Text;
        KRA: Text;
        firstLang: Code[50];
        secondLang: Code[50];
        AdditionalLang: Code[50];
        ApplicantType: Option;
        pAddress: Text;
        TXTIncorrectDetails: label 'Incorrect Username or Password';
        TXTCorrectDetails: label 'Login';
    begin
        Clear(RecAccountusers);
        RecAccountusers.Reset;
        RecAccountusers.SetRange(RecAccountusers."Email Address", username);
        RecAccountusers.SetRange(RecAccountusers.Password, userpassword);
        if RecAccountusers.Find('-') then begin
            //  IF (RecAccountusers.Password = userpassword) THEN BEGIN
            FullNames := RecAccountusers."First Name" + ' ' + RecAccountusers."Middle Name" + ' ' + RecAccountusers."Last Name";
            Initials := RecAccountusers.Initials;
            pAddress := RecAccountusers."Postal Address";
            pCode := RecAccountusers."Postal Code";
            IDNum := RecAccountusers."ID Number";
            Gender := RecAccountusers.Gender;
            Phone := RecAccountusers."Home Phone Number";
            rAddress := RecAccountusers."Residential Address";
            Citizenship := RecAccountusers.Citizenship;
            County := RecAccountusers.County;
            Mstatus := RecAccountusers."Marital Status";
            Eorigin := RecAccountusers."Ethnic Group";
            Disabled := Format(RecAccountusers.Disabled);
            dDetails := RecAccountusers."Disability Details";
            DOB := RecAccountusers."Date of Birth";
            // //          Dlicense:=RecAccountusers."Driving License";
            KRA := RecAccountusers."KRA PIN Number";
            // //          firstLang:= RecAccountusers."1st Language";
            // //          secondLang:=RecAccountusers."2nd Language";
            // //          AdditionalLang:=RecAccountusers."Additional Language";
            ApplicantType := RecAccountusers."Applicant Type";

            Message := TXTCorrectDetails + ' ::' +
             RecAccountusers."Email Address" + ' ::' +
             RecAccountusers."First Name" + ' ::'
             + RecAccountusers."Middle Name" + ' ::' +
              RecAccountusers."Last Name" + ' ::' +
               Format(Initials) + ' ::' +
                pAddress + ' ::' +
                Format(RecAccountusers.Gender) + ' ::'
                 + Phone + ' ::' +
                  IDNum + ' ::' +
                  Citizenship + ' ::' +
              County + ' ::' +
               Format(RecAccountusers."Marital Status") + ' ::' +
                Format(RecAccountusers."Ethnic Group") + ' ::' +
                 Format(RecAccountusers.Disabled) + ' ::' +
              dDetails + ' ::' +
               Format(DOB) + ' ::' +
                Dlicense + ' ::' +
                 KRA + ' ::' +
                  firstLang + ' ::' +
                   secondLang + ' ::' +
                    AdditionalLang + ' ::' +
                     Format(RecAccountusers."Applicant Type");
        end else begin
            FullNames := RecAccountusers."First Name" + ' ' + RecAccountusers."Middle Name" + ' ' + RecAccountusers."Last Name";
            Message := TXTIncorrectDetails;

        end;
    end;


    procedure InsertExamResults(Programz: Code[20]; StudNoz: Code[20]; Semesterz: Code[20]; Unitz: Code[20]; Scorez: Decimal; ExamTypez: Code[20]; UserNamez: Code[50]; LecturerNamez: Text[250]) MarksCaptureReturn: Text[250]
    var
        ACAExamResults: Record "ACA-Exam Results";
        ACAStudentUnits: Record "ACA-Student Units";
        Customer: Record Customer;
        AcaProgram: Record "ACA-Programme";
        ACAExamsSetup: Record "ACA-Exams Setup";
        HRMEmployeeC: Record "HRM-Employee C";
        ACASemesters: Record "ACA-Semesters";
        LectLoadBatchLines: Record "Lect Load Batch Lines";
        ACALecturersUnits: Record "ACA-Lecturers Units";
        ACACourseRegistration: Record "ACA-Course Registration";
        ACAProgSemesterSchedule: Record "ACA-Prog. Semester Schedule";
        ACAProgStageSemSchedule: Record "ACA-Prog/Stage Sem. Schedule";
        ACAProgStageUnitSemSche: Record "ACA-Prog/Stage/Unit Sem. Sche.";
        ACALectureMarksPermissions: Record "ACA-Lecture Marks Permissions";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        EdittingLocked: Boolean;
        ProgCat: Code[20];
        ACAUnitsSubjects4: Record "ACA-Units/Subjects";
        ACASemesters2: Record "ACA-Semesters";
        // ACAResultsBufferHeader: Record "ACA-Results Buffer Header";
        // ACAResultsBufferDetails: Record "ACA-Results Buffer Details";
        // ACAResultsBufferMarks: Record "ACA-Results Buffer Marks";
        Programmezz: Record "ACA-Programme";
    // ACAResultsBufferUnits: Record "ACA-Results Buffer Units";
    // ACAResultsBufferStudents: Record "ACA-Results Buffer Students";
    // ACAResultsBufferProgStage: Record "ACA-Results Buffer Prog. Stage";
    // ACAResultsBufferSetup: Record "ACA-Results Buffer Setup";
    begin

        Clear(Programmezz);
        Programmezz.Reset;
        Programmezz.SetRange(Code, Programz);
        if Programmezz.Find('-') then begin
            Programmezz.TestField("Exam Category");
        end;
        Clear(Customer);
        Customer.Reset;
        Customer.SetRange("No.", StudNoz);
        if Customer.Find('-') then Customer.CalcFields(Balance);
        Clear(MarksCaptureReturn);
        Clear(ACASemesters);
        ACASemesters.Reset;
        ACASemesters.SetRange(ACASemesters.Code, Semesterz);
        if ACASemesters.Find('-') then;
        if ExamTypez = 'EXAM' then ExamTypez := 'FINAL EXAM';
        if Customer.Get(StudNoz) then begin
            ACACourseRegistration.Reset;
            ACACourseRegistration.SetRange("Student No.", StudNoz);
            ACACourseRegistration.SetRange(Semester, Semesterz);
            ACACourseRegistration.SetRange(Reversed, false);
            if ACACourseRegistration.Find('-') then;
            ACAUnitsSubjects.Reset;
            ACAUnitsSubjects.SetRange("Programme Code", Programz);
            ACAUnitsSubjects.SetRange(Code, Unitz);
            if ACAUnitsSubjects.Find('-') then;
            ACAStudentUnits.Reset;
            ACAStudentUnits.SetRange(Semester, Semesterz);
            ACAStudentUnits.SetRange(Programme, Programz);
            ACAStudentUnits.SetRange("Student No.", StudNoz);
            ACAStudentUnits.SetRange(Unit, Unitz);
            if ACAStudentUnits.Find('-') then begin
                AcaProgram.Reset;
                AcaProgram.SetRange(Code, Programz);
                if AcaProgram.Find('-') then begin
                    AcaProgram.TestField("Exam Category");
                    Clear(ACAExamsSetup);
                    Clear(ProgCat);
                    ProgCat := AcaProgram."Exam Category";
                    Clear(ACAUnitsSubjects4);
                    ACAUnitsSubjects4.Reset;
                    ACAUnitsSubjects4.SetRange(Code, Unitz);
                    ACAUnitsSubjects4.SetRange("Programme Code", Programz);
                    if ACAUnitsSubjects4.Find('-') then
                        if ACAUnitsSubjects4."Default Exam Category" <> '' then ProgCat := ACAUnitsSubjects4."Default Exam Category";
                    ACAExamsSetup.Reset;
                    ACAExamsSetup.SetRange(Category, ProgCat);
                    if ((ExamTypez = 'CAT') or (ExamTypez = 'CATS')) then
                        ACAExamsSetup.SetFilter(Code, '%1|%2', 'CAT', 'CATS')
                    else if ((ExamTypez = 'EXAM') or (ExamTypez = 'MAIN EXAM') or (ExamTypez = 'FINAL EXAM')) then
                        ACAExamsSetup.SetFilter(Code, '%1|%2|%3', 'MAIN EXAM', 'EXAM', 'FINAL EXAM');
                    if ACAExamsSetup.Find('-') then begin
                        //Check from Prog, Stage, Unit and Lecturer Units if Capture of Marks is allowed
                        ///////////////////////////////////////////////////////////////////////////////////////////////////
                        ACAProgSemesterSchedule.Reset;
                        ACAProgSemesterSchedule.SetRange(Code, Semesterz);
                        ACAProgSemesterSchedule.SetRange("Programme Code", AcaProgram.Code);
                        if ACAProgSemesterSchedule.Find('-') then;
                        ACAProgStageSemSchedule.Reset;
                        ACAProgStageSemSchedule.SetRange(Code, Semesterz);
                        ACAProgStageSemSchedule.SetRange("Programme Code", AcaProgram.Code);
                        ACAProgStageSemSchedule.SetRange("Stage Code", ACAUnitsSubjects."Stage Code");
                        if ACAProgStageSemSchedule.Find('-') then;
                        ACAProgStageUnitSemSche.Reset;
                        ACAProgStageUnitSemSche.SetRange(Code, Semesterz);
                        ACAProgStageUnitSemSche.SetRange("Programme Code", AcaProgram.Code);
                        ACAProgStageUnitSemSche.SetRange("Unit Code", ACAUnitsSubjects.Code);
                        if ACAProgStageUnitSemSche.Find('-') then;
                        ACALectureMarksPermissions.Reset;
                        ACALectureMarksPermissions.SetRange(Code, Semesterz);
                        ACALectureMarksPermissions.SetRange("Programme Code", AcaProgram.Code);
                        ACALectureMarksPermissions.SetRange("Unit Code", ACAUnitsSubjects.Code);
                        ACALectureMarksPermissions.SetRange("Lecturer Code", UserNamez);
                        if ACALectureMarksPermissions.Find('-') then;
                        ///////////////////////////////////////////////////////////////////////////////////////////////////
                        // Check if Marks exceeds Maximum Defined
                        // (ACALectureMarksPermissions."Lock Exam Editting") AND
                        Clear(EdittingLocked);
                        if ((ACAProgSemesterSchedule."Lock Exam Editing")
                          and (ACAProgStageUnitSemSche."Lock Exam Editting") and
                          (ACAProgStageSemSchedule."Lock Exam Editting") and
                            (ACASemesters."Lock Exam Editting"))
                           //       AND
                           //       (ACAProgStageUnitSemSche."Mark entry Dealine"<TODAY)
                           //      AND (ACAProgStageSemSchedule."Mark entry Dealine"<TODAY) AND
                           //       (ACAProgSemesterSchedule."Mark entry Dealine"<TODAY)
                           then
                            EdittingLocked := true;
                        if not (Scorez > ACAExamsSetup."Max. Score") then begin
                            ACASemesters.Reset;
                            ACASemesters.SetRange(ACASemesters.Code, Semesterz);
                            //    ACASemesters.SETRANGE(ACASemesters."Programme Code",Programz);
                            if ACASemesters.Find('-') then begin
                                HRMEmployeeC.Reset;
                                HRMEmployeeC.SetRange("No.", UserNamez);
                                if HRMEmployeeC.Find('-') then begin
                                    if ((HRMEmployeeC.Lecturer = false) and ((HRMEmployeeC."Is HOD" = false) and (HRMEmployeeC."Has HOD Rights" = false))) then MarksCaptureReturn := 'Access Denied: Not Lecturer Not HOD';
                                    // IF  ((HRMEmployeeC.Lecturer=FALSE) AND ((HRMEmployeeC."Is HOD"=FALSE) AND (HRMEmployeeC."Has HOD Rights"=FALSE))) THEN MarksCaptureReturn:='Access Denied: Not Lecturer Not HOD';

                                    if ((ExamTypez = 'CAT') or (ExamTypez = 'CATS')) then begin
                                        if ((ACASemesters."Lock CAT Editting") and (HRMEmployeeC."Is HOD" = false)) then
                                            MarksCaptureReturn := 'CAT Marks editing locked';
                                        if ((ACASemesters."Lock CAT Editting") and (HRMEmployeeC."Is HOD" = true) and (ACASemesters."Evaluate Lecture" = false)) then
                                            MarksCaptureReturn := 'CAT Marks editing locked';
                                    end;
                                    // -------------------------------------------------------------- Exams

                                    if ((ExamTypez = 'EXAM') or (ExamTypez = 'MAIN EXAM') or (ExamTypez = 'FINAL EXAM')) then begin
                                        if ((EdittingLocked) and ((HRMEmployeeC."Is HOD" = false) and (HRMEmployeeC."Has HOD Rights" = false))) then
                                            MarksCaptureReturn := 'EXAM Marks editing locked';
                                        if ((EdittingLocked = false) and (HRMEmployeeC.Lecturer = false)) then MarksCaptureReturn := 'Not Lecturer: Access denied!';
                                        if ((EdittingLocked) and ((HRMEmployeeC."Is HOD" = true) or (HRMEmployeeC."Has HOD Rights" = true)) and (ACASemesters."Evaluate Lecture" = false)) then
                                            MarksCaptureReturn := 'EXAM Marks editing locked';
                                    end;
                                    if (((HRMEmployeeC."Is HOD" = true) or (HRMEmployeeC."Has HOD Rights" = true)) and (ACASemesters."Evaluate Lecture" = false) and (HRMEmployeeC.Lecturer = false)) then
                                        MarksCaptureReturn := 'HOD editing not allowed';


                                    if (((HRMEmployeeC."Is HOD" = true) or (HRMEmployeeC."Has HOD Rights" = true)) and (EdittingLocked = true) and
                                      (AcaProgram."Department Code" <> HRMEmployeeC."Department Code")) then
                                        MarksCaptureReturn := AcaProgram."Department Code" + ' is not your department!';



                                    ACALecturersUnits.Reset;
                                    ACALecturersUnits.SetRange(Programme, AcaProgram.Code);
                                    ACALecturersUnits.SetRange(Unit, Unitz);
                                    ACALecturersUnits.SetRange(Semester, Semesterz);
                                    ACALecturersUnits.SetRange(Lecturer, UserNamez);
                                    if not (ACALecturersUnits.Find('-')) then begin
                                        if ((EdittingLocked = true)) then MarksCaptureReturn := 'Access Denied. No allocation done';
                                    end;
                                    //-------------------------------------------------------------------------
                                    // Create Approval Entries for the marks
                                    // -- Create Marks Approval Entries
                                    CreateMarksApprovalEntries(AcaProgram, ACASemesters, UserNamez, ACAStudentUnits);
                                    // Create A single unit Entry for the Approval Units Reference

                                    if MarksCaptureReturn = '' then begin
                                        ////////////////////////////////////////////////////////////////////////////////////////////////
                                        ACAExamResults.Reset;
                                        ACAExamResults.SetRange("Student No.", StudNoz);
                                        ACAExamResults.SetRange(Programmes, Programz);
                                        ACAExamResults.SetRange(Unit, Unitz);
                                        ACAExamResults.SetRange(Semester, Semesterz);
                                        ACAExamResults.SetRange(ExamType, ExamTypez);
                                        if ACAExamResults.Find('-') then begin
                                            ACAExamResults.Score := Scorez;
                                            ACAExamResults.Validate(Score);
                                            ACAExamResults.Modify;
                                            ACAExamResults.Validate(ExamType);
                                            MarksCaptureReturn := 'SUCCESS:: Marks inserted';
                                        end else begin
                                            ACAExamResults.Init;
                                            ACAExamResults."Student No." := StudNoz;
                                            ACAExamResults.Programmes := Programz;
                                            ACAExamResults.Stage := ACAStudentUnits.Stage;
                                            ACAExamResults.Unit := Unitz;
                                            ACAExamResults.Semester := Semesterz;
                                            ACAExamResults.Exam := ExamTypez;
                                            ACAExamResults."Reg. Transaction ID" := ACAStudentUnits."Reg. Transacton ID";
                                            ACAExamResults.ExamType := ExamTypez;
                                            ACAExamResults."Exam Category" := Programmezz."Exam Category";
                                            ACAExamResults."Lecturer Names" := LecturerNamez;
                                            ACAExamResults."User Name" := LecturerNamez;
                                            ACAExamResults.User_ID := UserNamez;
                                            ACAExamResults.Submitted := true;
                                            ACAExamResults."Submitted By" := UserNamez;
                                            ACAExamResults."Submitted On" := Today;
                                            ACAExamResults.Category := Programmezz."Exam Category";
                                            ACAExamResults.Department := Programmezz."Department Code";
                                            ACAExamResults."Admission No" := StudNoz;
                                            ACAExamResults."Academic Year" := ACASemesters."Academic Year";
                                            ACAExamResults.Score := Scorez;
                                            ACAExamResults.Insert;
                                            ACAExamResults.Reset;
                                            ACAExamResults.SetRange("Student No.", StudNoz);
                                            ACAExamResults.SetRange(Programmes, Programz);
                                            ACAExamResults.SetRange(Unit, Unitz);
                                            ACAExamResults.SetRange(Semester, Semesterz);
                                            ACAExamResults.SetRange(ExamType, ExamTypez);
                                            if ACAExamResults.Find('-') then begin
                                                ACAExamResults.Score := Scorez;
                                                ACAExamResults.Validate(Score);
                                                ACAExamResults.Validate(ExamType);
                                                ACAExamResults.Modify;
                                            end;
                                            MarksCaptureReturn := 'SUCCESS:: Marks inserted';
                                        end;
                                        ///////////////////////////////////////////////////////////////////////////////////////////
                                    end;
                                    //------------------------------------------------------------------
                                end else
                                    MarksCaptureReturn := 'Invalid Staff No. ' + Semesterz;
                            end else
                                MarksCaptureReturn := 'Invalid Semester ' + Semesterz;

                        end else
                            MarksCaptureReturn := 'Invalid Marks on ' + Unitz + ' Student: ' + StudNoz + ': ' + Customer.Name + ', Exam type: ' +
                   ExamTypez + '. Not to exceed: ' + Format(ACAExamsSetup."Max. Score");
                    end else begin
                        // Exams Setup Missing
                        MarksCaptureReturn := 'No defined maximum mark values for ' + Unitz + ' Student: ' + StudNoz + ': ' + Customer.Name;
                    end;
                end else begin
                    // Program Missing
                    MarksCaptureReturn := 'Program ' + Programz + ' Missing in Registration for: ' + StudNoz + ': ' + Customer.Name;
                end;
            end else begin
                MarksCaptureReturn := 'Unit ' + Unitz + ' Missing in Registration for: ' + StudNoz + ': ' + Customer.Name;
            end;
        end;
    end;

    procedure InsertSpecialExamResults(Programz: Code[20]; StudNoz: Code[20]; Semesterz: Code[20]; Unitz: Code[20]; Scorez: Decimal; ExamTypez: Code[20]; UserNamez: Code[50]; LecturerNamez: Text[250]) MarksCaptureReturn: Text[250]
    var
        ACAExamResults: Record "ACA-Exam Results";
        ACAStudentUnits: Record "ACA-Student Units";
        Customer: Record Customer;
        AcaProgram: Record "ACA-Programme";
        ACAExamsSetup: Record "ACA-Exams Setup";
        HRMEmployeeC: Record "HRM-Employee C";
        ACASemesters: Record "ACA-Semesters";
        LectLoadBatchLines: Record "Lect Load Batch Lines";
        ACALecturersUnits: Record "ACA-Lecturers Units";
        ACACourseRegistration: Record "ACA-Course Registration";
        ACAProgSemesterSchedule: Record "ACA-Prog. Semester Schedule";
        ACAProgStageSemSchedule: Record "ACA-Prog/Stage Sem. Schedule";
        ACAProgStageUnitSemSche: Record "ACA-Prog/Stage/Unit Sem. Sche.";
        ACALectureMarksPermissions: Record "ACA-Lecture Marks Permissions";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        EdittingLocked: Boolean;
        ProgCat: Code[20];
        ACAUnitsSubjects4: Record "ACA-Units/Subjects";
        ACASemesters2: Record "ACA-Semesters";
        SpecialExams: Record "Aca-Special Exams Details";
        // ACAResultsBufferHeader: Record "ACA-Results Buffer Header";
        // ACAResultsBufferDetails: Record "ACA-Results Buffer Details";
        // ACAResultsBufferMarks: Record "ACA-Results Buffer Marks";
        Programmezz: Record "ACA-Programme";
    // ACAResultsBufferUnits: Record "ACA-Results Buffer Units";
    // ACAResultsBufferStudents: Record "ACA-Results Buffer Students";
    // ACAResultsBufferProgStage: Record "ACA-Results Buffer Prog. Stage";
    // ACAResultsBufferSetup: Record "ACA-Results Buffer Setup";
    begin

        Clear(Programmezz);
        Programmezz.Reset;
        Programmezz.SetRange(Code, Programz);
        if Programmezz.Find('-') then begin
            Programmezz.TestField("Exam Category");
        end;
        Clear(Customer);
        Customer.Reset;
        Customer.SetRange("No.", StudNoz);
        if Customer.Find('-') then Customer.CalcFields(Balance);
        Clear(MarksCaptureReturn);
        Clear(ACASemesters);
        ACASemesters.Reset;
        ACASemesters.SetRange(ACASemesters.Code, Semesterz);
        if ACASemesters.Find('-') then;
        if ExamTypez = 'EXAM' then ExamTypez := 'FINAL EXAM';
        if Customer.Get(StudNoz) then begin
            ACACourseRegistration.Reset;
            ACACourseRegistration.SetRange("Student No.", StudNoz);
            ACACourseRegistration.SetRange(Semester, Semesterz);
            ACACourseRegistration.SetRange(Reversed, false);
            if ACACourseRegistration.Find('-') then;
            ACAUnitsSubjects.Reset;
            ACAUnitsSubjects.SetRange("Programme Code", Programz);
            ACAUnitsSubjects.SetRange(Code, Unitz);
            if ACAUnitsSubjects.Find('-') then;
            ACAStudentUnits.Reset;
            //ACAStudentUnits.SetRange(Semester, Semesterz);
            ACAStudentUnits.SetRange(Programme, Programz);
            ACAStudentUnits.SetRange("Student No.", StudNoz);
            ACAStudentUnits.SetRange(Unit, Unitz);
            if ACAStudentUnits.Find('-') then begin
                SpecialExams.Reset;
                SpecialExams.SetRange("Student No.", ACAStudentUnits."Student No.");
                SpecialExams.SetRange("Unit Code", Unitz);
                SpecialExams.SetRange("Programme", Programz);
                SpecialExams.SetRange("Current Semester", Semesterz);
                SpecialExams.SetRange("Category", SpecialExams.Category::Special);
                SpecialExams.SetRange("Status", SpecialExams.Status::Approved);
                if SpecialExams.Find('-') then;
                AcaProgram.Reset;
                AcaProgram.SetRange(Code, Programz);
                if AcaProgram.Find('-') then begin
                    AcaProgram.TestField("Exam Category");
                    Clear(ACAExamsSetup);
                    Clear(ProgCat);
                    ProgCat := AcaProgram."Exam Category";
                    Clear(ACAUnitsSubjects4);
                    ACAUnitsSubjects4.Reset;
                    ACAUnitsSubjects4.SetRange(Code, Unitz);
                    ACAUnitsSubjects4.SetRange("Programme Code", Programz);
                    if ACAUnitsSubjects4.Find('-') then
                        if ACAUnitsSubjects4."Default Exam Category" <> '' then ProgCat := ACAUnitsSubjects4."Default Exam Category";
                    ACAExamsSetup.Reset;
                    ACAExamsSetup.SetRange(Category, ProgCat);
                    if ((ExamTypez = 'CAT') or (ExamTypez = 'CATS')) then
                        ACAExamsSetup.SetFilter(Code, '%1|%2', 'CAT', 'CATS')
                    else if ((ExamTypez = 'EXAM') or (ExamTypez = 'MAIN EXAM') or (ExamTypez = 'FINAL EXAM')) then
                        ACAExamsSetup.SetFilter(Code, '%1|%2|%3', 'MAIN EXAM', 'EXAM', 'FINAL EXAM');
                    if ACAExamsSetup.Find('-') then begin
                        //Check from Prog, Stage, Unit and Lecturer Units if Capture of Marks is allowed
                        ///////////////////////////////////////////////////////////////////////////////////////////////////
                        ACAProgSemesterSchedule.Reset;
                        ACAProgSemesterSchedule.SetRange(Code, Semesterz);
                        ACAProgSemesterSchedule.SetRange("Programme Code", AcaProgram.Code);
                        if ACAProgSemesterSchedule.Find('-') then;
                        ACAProgStageSemSchedule.Reset;
                        ACAProgStageSemSchedule.SetRange(Code, Semesterz);
                        ACAProgStageSemSchedule.SetRange("Programme Code", AcaProgram.Code);
                        ACAProgStageSemSchedule.SetRange("Stage Code", ACAUnitsSubjects."Stage Code");
                        if ACAProgStageSemSchedule.Find('-') then;
                        ACAProgStageUnitSemSche.Reset;
                        ACAProgStageUnitSemSche.SetRange(Code, Semesterz);
                        ACAProgStageUnitSemSche.SetRange("Programme Code", AcaProgram.Code);
                        ACAProgStageUnitSemSche.SetRange("Unit Code", ACAUnitsSubjects.Code);
                        if ACAProgStageUnitSemSche.Find('-') then;
                        ACALectureMarksPermissions.Reset;
                        ACALectureMarksPermissions.SetRange(Code, Semesterz);
                        ACALectureMarksPermissions.SetRange("Programme Code", AcaProgram.Code);
                        ACALectureMarksPermissions.SetRange("Unit Code", ACAUnitsSubjects.Code);
                        ACALectureMarksPermissions.SetRange("Lecturer Code", UserNamez);
                        if ACALectureMarksPermissions.Find('-') then;
                        ///////////////////////////////////////////////////////////////////////////////////////////////////
                        // Check if Marks exceeds Maximum Defined
                        // (ACALectureMarksPermissions."Lock Exam Editting") AND
                        Clear(EdittingLocked);
                        if ((ACAProgSemesterSchedule."Lock Exam Editing")
                          and (ACAProgStageUnitSemSche."Lock Exam Editting") and
                          (ACAProgStageSemSchedule."Lock Exam Editting") and
                            (ACASemesters."Lock Exam Editting"))
                           //       AND
                           //       (ACAProgStageUnitSemSche."Mark entry Dealine"<TODAY)
                           //      AND (ACAProgStageSemSchedule."Mark entry Dealine"<TODAY) AND
                           //       (ACAProgSemesterSchedule."Mark entry Dealine"<TODAY)
                           then
                            EdittingLocked := true;
                        if not (Scorez > ACAExamsSetup."Max. Score") then begin
                            ACASemesters.Reset;
                            ACASemesters.SetRange(ACASemesters.Code, Semesterz);
                            //    ACASemesters.SETRANGE(ACASemesters."Programme Code",Programz);
                            if ACASemesters.Find('-') then begin
                                HRMEmployeeC.Reset;
                                HRMEmployeeC.SetRange("No.", UserNamez);
                                if HRMEmployeeC.Find('-') then begin
                                    if ((HRMEmployeeC.Lecturer = false) and ((HRMEmployeeC."Is HOD" = false) and (HRMEmployeeC."Has HOD Rights" = false))) then MarksCaptureReturn := 'Access Denied: Not Lecturer Not HOD';
                                    // IF  ((HRMEmployeeC.Lecturer=FALSE) AND ((HRMEmployeeC."Is HOD"=FALSE) AND (HRMEmployeeC."Has HOD Rights"=FALSE))) THEN MarksCaptureReturn:='Access Denied: Not Lecturer Not HOD';

                                    if ((ExamTypez = 'CAT') or (ExamTypez = 'CATS')) then begin
                                        if ((ACASemesters."Lock CAT Editting") and (HRMEmployeeC."Is HOD" = false)) then
                                            MarksCaptureReturn := 'CAT Marks editing locked';
                                        if ((ACASemesters."Lock CAT Editting") and (HRMEmployeeC."Is HOD" = true) and (ACASemesters."Evaluate Lecture" = false)) then
                                            MarksCaptureReturn := 'CAT Marks editing locked';
                                    end;
                                    // -------------------------------------------------------------- Exams

                                    if ((ExamTypez = 'EXAM') or (ExamTypez = 'MAIN EXAM') or (ExamTypez = 'FINAL EXAM')) then begin
                                        if ((EdittingLocked) and ((HRMEmployeeC."Is HOD" = false) and (HRMEmployeeC."Has HOD Rights" = false))) then
                                            MarksCaptureReturn := 'EXAM Marks editing locked';
                                        if ((EdittingLocked = false) and (HRMEmployeeC.Lecturer = false)) then MarksCaptureReturn := 'Not Lecturer: Access denied!';
                                        if ((EdittingLocked) and ((HRMEmployeeC."Is HOD" = true) or (HRMEmployeeC."Has HOD Rights" = true)) and (ACASemesters."Evaluate Lecture" = false)) then
                                            MarksCaptureReturn := 'EXAM Marks editing locked';
                                    end;
                                    if (((HRMEmployeeC."Is HOD" = true) or (HRMEmployeeC."Has HOD Rights" = true)) and (ACASemesters."Evaluate Lecture" = false) and (HRMEmployeeC.Lecturer = false)) then
                                        MarksCaptureReturn := 'HOD editing not allowed';


                                    if (((HRMEmployeeC."Is HOD" = true) or (HRMEmployeeC."Has HOD Rights" = true)) and (EdittingLocked = true) and
                                      (AcaProgram."Department Code" <> HRMEmployeeC."Department Code")) then
                                        MarksCaptureReturn := AcaProgram."Department Code" + ' is not your department!';



                                    ACALecturersUnits.Reset;
                                    ACALecturersUnits.SetRange(Programme, AcaProgram.Code);
                                    ACALecturersUnits.SetRange(Unit, Unitz);
                                    ACALecturersUnits.SetRange(Semester, Semesterz);
                                    ACALecturersUnits.SetRange(Lecturer, UserNamez);
                                    if not (ACALecturersUnits.Find('-')) then begin
                                        if ((EdittingLocked = true)) then MarksCaptureReturn := 'Access Denied. No allocation done';
                                    end;
                                    //-------------------------------------------------------------------------
                                    // Create Approval Entries for the marks
                                    // -- Create Marks Approval Entries
                                    CreateMarksApprovalEntries(AcaProgram, ACASemesters, UserNamez, ACAStudentUnits);
                                    // Create A single unit Entry for the Approval Units Reference

                                    if MarksCaptureReturn = '' then begin
                                        ////////////////////////////////////////////////////////////////////////////////////////////////
                                        ACAExamResults.Reset;
                                        ACAExamResults.SetRange("Student No.", StudNoz);
                                        ACAExamResults.SetRange(Programmes, Programz);
                                        ACAExamResults.SetRange(Unit, Unitz);
                                        ACAExamResults.SetRange(Semester, SpecialExams.Semester);
                                        ACAExamResults.SetRange(ExamType, ExamTypez);
                                        if ACAExamResults.Find('-') then begin
                                            ACAExamResults.Score := Scorez;
                                            ACAExamResults.Validate(Score);
                                            ACAExamResults.Modify;
                                            ACAExamResults.Validate(ExamType);
                                            MarksCaptureReturn := 'SUCCESS:: Marks inserted';
                                        end else begin
                                            ACAExamResults.Init;
                                            ACAExamResults."Student No." := StudNoz;
                                            ACAExamResults.Programmes := Programz;
                                            ACAExamResults.Stage := ACAStudentUnits.Stage;
                                            ACAExamResults.Unit := Unitz;
                                            ACAExamResults.Semester := SpecialExams.Semester;
                                            ACAExamResults.Exam := ExamTypez;
                                            ACAExamResults."Reg. Transaction ID" := ACAStudentUnits."Reg. Transacton ID";
                                            ACAExamResults.ExamType := ExamTypez;
                                            ACAExamResults."Exam Category" := Programmezz."Exam Category";
                                            ACAExamResults."Lecturer Names" := LecturerNamez;
                                            ACAExamResults."User Name" := LecturerNamez;
                                            ACAExamResults.User_ID := UserNamez;
                                            ACAExamResults.Submitted := true;
                                            ACAExamResults."Submitted By" := UserNamez;
                                            ACAExamResults."Submitted On" := Today;
                                            ACAExamResults.Category := Programmezz."Exam Category";
                                            ACAExamResults.Department := Programmezz."Department Code";
                                            ACAExamResults."Admission No" := StudNoz;
                                            ACAExamResults."Academic Year" := SpecialExams."Academic Year";
                                            ACAExamResults.Score := Scorez;
                                            ACAExamResults.Insert;
                                            ACAExamResults.Reset;
                                            ACAExamResults.SetRange("Student No.", StudNoz);
                                            ACAExamResults.SetRange(Programmes, Programz);
                                            ACAExamResults.SetRange(Unit, Unitz);
                                            ACAExamResults.SetRange(Semester, SpecialExams.Semester);
                                            ACAExamResults.SetRange(ExamType, ExamTypez);
                                            if ACAExamResults.Find('-') then begin
                                                ACAExamResults.Score := Scorez;
                                                ACAExamResults.Validate(Score);
                                                ACAExamResults.Validate(ExamType);
                                                ACAExamResults.Modify;
                                            end;
                                            MarksCaptureReturn := 'SUCCESS:: Marks inserted';
                                        end;
                                        ///////////////////////////////////////////////////////////////////////////////////////////
                                    end;
                                    //------------------------------------------------------------------
                                end else
                                    MarksCaptureReturn := 'Invalid Staff No. ' + Semesterz;
                            end else
                                MarksCaptureReturn := 'Invalid Semester ' + Semesterz;

                        end else
                            MarksCaptureReturn := 'Invalid Marks on ' + Unitz + ' Student: ' + StudNoz + ': ' + Customer.Name + ', Exam type: ' +
                   ExamTypez + '. Not to exceed: ' + Format(ACAExamsSetup."Max. Score");
                    end else begin
                        // Exams Setup Missing
                        MarksCaptureReturn := 'No defined maximum mark values for ' + Unitz + ' Student: ' + StudNoz + ': ' + Customer.Name;
                    end;
                end else begin
                    // Program Missing
                    MarksCaptureReturn := 'Program ' + Programz + ' Missing in Registration for: ' + StudNoz + ': ' + Customer.Name;
                end;
            end else begin
                MarksCaptureReturn := 'Unit ' + Unitz + ' Missing in Registration for: ' + StudNoz + ': ' + Customer.Name;
            end;
        end;
    end;


    local procedure CreateMarksApprovalEntries(var AcaProgram: Record "ACA-Programme"; var ACASemesters: Record "ACA-Semesters"; UserNamez: Text[150]; var ACAStudentUnits: Record "ACA-Student Units")
    var
    // ACAResultsWorkflowTemplates: Record "ACA-Results Workflow Templates";
    // ACAResultsWorkflowCodes: Record UnknownRecord78061;
    // ACAResultsWorkflowApprovers: Record UnknownRecord78062;
    // ACAResultsApprovalEntries: Record UnknownRecord78063;
    begin
        // Clear(ACAResultsWorkflowTemplates);
        // ACAResultsWorkflowTemplates.Reset;
        // ACAResultsWorkflowTemplates.SetRange("Department Code", AcaProgram."Department Code");
        // ACAResultsWorkflowTemplates.SetRange("Academic Year", ACASemesters."Academic Year");
        // if ACAResultsWorkflowTemplates.Find('-') then begin
        //     repeat
        //     begin
        //         Clear(ACAResultsWorkflowCodes);
        //         ACAResultsWorkflowCodes.Reset;
        //         ACAResultsWorkflowCodes.SetRange("Academic Year", ACASemesters."Academic Year");
        //         ACAResultsWorkflowCodes.SetRange("Template Name", ACAResultsWorkflowTemplates."Template Name");
        //         if ACAResultsWorkflowCodes.Find('-') then begin
        //             repeat
        //             begin
        //                 Clear(ACAResultsWorkflowApprovers);
        //                 ACAResultsWorkflowApprovers.Reset;
        //                 ACAResultsWorkflowApprovers.SetRange("Academic Year", ACAResultsWorkflowCodes."Academic Year");
        //                 ACAResultsWorkflowApprovers.SetRange("Template Name", ACAResultsWorkflowCodes."Template Name");
        //                 ACAResultsWorkflowApprovers.SetRange(WF_Code, ACAResultsWorkflowCodes.WF_Code);
        //                 ACAResultsWorkflowApprovers.SetRange(Series, ACAResultsWorkflowCodes.Series);
        //                 if ACAResultsWorkflowApprovers.Find('-') then begin
        //                     repeat
        //                     begin
        //                         if ACAResultsWorkflowCodes."Approval Category" = ACAResultsWorkflowCodes."approval category"::"Per Unit" then begin
        //                             // Create Approval entry here
        //                             ACAResultsApprovalEntries.Init;
        //                             ACAResultsApprovalEntries."Academic Year" := ACASemesters."Academic Year";
        //                             ACAResultsApprovalEntries.Semester := ACASemesters.Code;
        //                             ACAResultsApprovalEntries.Programme := AcaProgram.Code;
        //                             ACAResultsApprovalEntries."Unit Code" := ACAStudentUnits.Unit;
        //                             ACAResultsApprovalEntries."Approver ID" := ACAResultsWorkflowApprovers."Approver ID";
        //                             ACAResultsApprovalEntries."Approval Series" := ACAResultsWorkflowApprovers.Series;
        //                             ACAResultsApprovalEntries.Lecturer := UserNamez;
        //                             ACAResultsApprovalEntries."Department Code" := AcaProgram."Department Code";
        //                             ACAResultsApprovalEntries.Stage := ACAStudentUnits.Stage;
        //                             ACAResultsApprovalEntries."Approval Template" := ACAResultsWorkflowApprovers."Template Name";
        //                             ACAResultsApprovalEntries."Workflow Code" := ACAResultsWorkflowApprovers.WF_Code;
        //                             ACAResultsApprovalEntries."Approval Category" := ACAResultsWorkflowCodes."Approval Category";
        //                             if ACAResultsWorkflowCodes.Series = 1 then
        //                                 ACAResultsApprovalEntries.Status := ACAResultsApprovalEntries.Status::open else
        //                                 ACAResultsApprovalEntries.Status := ACAResultsApprovalEntries.Status::" ";
        //                             if ACAResultsApprovalEntries.Insert then;
        //                         end else begin
        //                             // Create a per Program Approval entry
        //                             ACAResultsApprovalEntries.Init;
        //                             ACAResultsApprovalEntries."Academic Year" := ACASemesters."Academic Year";
        //                             ACAResultsApprovalEntries.Semester := ACASemesters.Code;
        //                             ACAResultsApprovalEntries.Programme := AcaProgram.Code;
        //                             ACAResultsApprovalEntries."Approver ID" := ACAResultsWorkflowApprovers."Approver ID";
        //                             ACAResultsApprovalEntries."Approval Series" := ACAResultsWorkflowApprovers.Series;
        //                             ACAResultsApprovalEntries.Lecturer := UserNamez;
        //                             ACAResultsApprovalEntries."Department Code" := AcaProgram."Department Code";
        //                             ACAResultsApprovalEntries.Stage := ACAStudentUnits.Stage;
        //                             ACAResultsApprovalEntries."Approval Template" := ACAResultsWorkflowApprovers."Template Name";
        //                             ACAResultsApprovalEntries."Workflow Code" := ACAResultsWorkflowApprovers.WF_Code;
        //                             ACAResultsApprovalEntries."Approval Category" := ACAResultsWorkflowCodes."Approval Category";
        //                             if ACAResultsWorkflowCodes.Series = 1 then
        //                                 ACAResultsApprovalEntries.Status := ACAResultsApprovalEntries.Status::open else
        //                                 ACAResultsApprovalEntries.Status := ACAResultsApprovalEntries.Status::" ";
        //                             if ACAResultsApprovalEntries.Insert then;
        //                         end;
        //                     end;
        //                     until ACAResultsWorkflowApprovers.Next = 0;
        //                 end;
        //             end;
        //             until ACAResultsWorkflowCodes.Next = 0;
        //         end;
        //     end;
        //     until ACAResultsWorkflowTemplates.Next = 0;
        // end;
    end;


    procedure FnBookSpecialExam(StudentNo: Code[25]; ProgramCode: Code[25]; SemesterCode: Code[25]; Unitcode: Code[25]; Reason: Code[100]): Integer
    var
        StdUnits: Record "ACA-Student Units";
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        ACASems: Record "ACA-Semesters";
    begin
        ACASems.Reset;
        ACASems.SetRange(ACASems.Code, SemesterCode);
        if ACASems.FindFirst then begin
            ACASems.TestField("Special Entry Deadline");
            if ACASems."Special Entry Deadline" < Today then
                Error('Special examination booking is not allowed at this moment.');
        end;

        StdUnits.Reset;
        StdUnits.SetRange(StdUnits."Student No.", StudentNo);
        StdUnits.SetRange(StdUnits.Programme, ProgramCode);
        StdUnits.SetRange(StdUnits.Semester, SemesterCode);
        StdUnits.SetRange(StdUnits.Unit, Unitcode);
        if StdUnits.FindFirst then begin
            StdUnits."Special Exam" := StdUnits."special exam"::Special;
            StdUnits."Reason for Special Exam/Susp." := Reason;
            StdUnits.Validate("Special Exam");
            StdUnits.Modify;
            Commit;
        end;

        AcaSpecialExamsDetails.Reset;
        AcaSpecialExamsDetails.SetRange("Student No.", StudentNo);
        AcaSpecialExamsDetails.SetRange("Unit Code", Unitcode);
        AcaSpecialExamsDetails.SetRange(Programme, ProgramCode);
        AcaSpecialExamsDetails.SetRange(Semester, SemesterCode);
        AcaSpecialExamsDetails.SetRange(AcaSpecialExamsDetails.Category, AcaSpecialExamsDetails.Category::Supplementary);
        if AcaSpecialExamsDetails.FindFirst then
            exit(AcaSpecialExamsDetails.Sequence) else
            exit(0);
    end;


    procedure FnCheckMarksEntryValid(Semester: Code[25]; Programme: Code[25]; Stage: Code[25]): Boolean
    var
        StageSem: Record "ACA-Prog/Stage Sem. Schedule";
    begin
        StageSem.Reset;
        StageSem.SetRange(Code, Semester);
        StageSem.SetRange("Programme Code", Programme);
        StageSem.SetRange("Stage Code", Stage);
        if StageSem.FindFirst then begin
            exit(Today < StageSem."Mark entry Dealine");
        end else
            exit(false);
    end;


    procedure FnCheckSpecialsEntryValid(Semester: Code[25]; Programme: Code[25]; Stage: Code[25]): Boolean
    var
        StageSem: Record "ACA-Prog/Stage Sem. Schedule";
    begin
        StageSem.Reset;
        StageSem.SetRange(Code, Semester);
        StageSem.SetRange("Programme Code", Programme);
        StageSem.SetRange("Stage Code", Stage);
        if StageSem.FindFirst then begin
            exit(Today < StageSem."Special Entry Deadline");
        end else
            exit(false);
    end;


    procedure FnCheckSuppEntryValid(Semester: Code[25]; Programme: Code[25]; Stage: Code[25]): Boolean
    var
        StageSem: Record "ACA-Prog/Stage Sem. Schedule";
    begin
        StageSem.Reset;
        StageSem.SetRange(Code, Semester);
        StageSem.SetRange("Programme Code", Programme);
        StageSem.SetRange("Stage Code", Stage);
        if StageSem.FindFirst then begin
            exit(Today < StageSem."Supplementary Entry Deadline");
        end else
            exit(false);
    end;


    procedure FnCheckCATLocked(Semester: Code[25]; Programme: Code[25]; Stage: Code[25]): Boolean
    var
        StageSem: Record "ACA-Prog/Stage Sem. Schedule";
    begin
        StageSem.Reset;
        StageSem.SetRange(Code, Semester);
        StageSem.SetRange("Programme Code", Programme);
        StageSem.SetRange("Stage Code", Stage);
        if StageSem.FindFirst then begin
            exit(StageSem."Lock CAT Editting");
        end;
    end;


    procedure FnCheckExamLocked(Semester: Code[25]; Programme: Code[25]; Stage: Code[25]): Boolean
    var
        StageSem: Record "ACA-Prog/Stage Sem. Schedule";
    begin
        StageSem.Reset;
        StageSem.SetRange(Code, Semester);
        StageSem.SetRange("Programme Code", Programme);
        StageSem.SetRange("Stage Code", Stage);
        if StageSem.FindFirst then begin
            exit(StageSem."Lock Exam Editting");
        end;
    end;


    procedure FnGetLecturerStudentsWithSearch(unit: Code[20]; prog: Code[20]; sem: Code[20]; stage: Code[20]; searchParam: Text) Msg: Text
    var
        StdUnits: Record "ACA-Student Units";
    begin
        Customer.Reset;
        Customer.SetCurrentkey("No.");
        Customer.SetFilter("No.", '%1', '*' + searchParam + '*');
        if Customer.Find('-') then begin
            repeat
                StdUnits.Reset;
                StdUnits.SetRange("Student No.", Customer."No.");
                StdUnits.SetRange(Unit, unit);
                StdUnits.SetRange(Programme, prog);
                StdUnits.SetRange(Semester, sem);
                StdUnits.SetRange(Stage, stage);
                if StdUnits.Find('-') then begin
                    repeat
                        Msg += Customer."No." + ' ::' + Customer.Name + ' ::' + StdUnits.Unit + ' ::' + StdUnits.Description + ' ::' + StdUnits."Reg. Transacton ID" + ' :::';
                    until StdUnits.Next = 0;
                end;
            until Customer.Next = 0;
        end else begin
            Customer.Reset;
            Customer.SetCurrentkey("No.");
            Customer.SetFilter(Name, '%1', '*' + searchParam + '*');
            if Customer.Find('-') then begin
                repeat
                    StdUnits.Reset;
                    StdUnits.SetRange("Student No.", Customer."No.");
                    StdUnits.SetRange(Unit, unit);
                    StdUnits.SetRange(Programme, prog);
                    StdUnits.SetRange(Semester, sem);
                    StdUnits.SetRange(Stage, stage);
                    if StdUnits.Find('-') then begin
                        repeat
                            Msg += Customer."No." + ' ::' + Customer.Name + ' ::' + StdUnits.Unit + ' ::' + StdUnits.Description + ' ::' + StdUnits."Reg. Transacton ID" + ' :::';
                        until StdUnits.Next = 0;
                    end;
                until Customer.Next = 0;
            end;
        end;
    end;

    procedure FnGetLecturerSpecialStudentsWithSearch(unit: Code[20]; prog: Code[20]; sem: Code[20]; stage: Code[20]; searchParam: Text) Msg: Text
    var
        StdUnits: Record "ACA-Student Units";
        SpecialExams: Record "Aca-Special Exams Details";
    begin
        Customer.Reset;
        Customer.SetCurrentkey("No.");
        Customer.SetFilter("No.", '%1', '*' + searchParam + '*');
        if Customer.Find('-') then begin
            repeat
                StdUnits.Reset;
                StdUnits.SetRange("Student No.", Customer."No.");
                StdUnits.SetRange(Unit, unit);
                StdUnits.SetRange(Programme, prog);
                StdUnits.SetRange(Stage, stage);
                if StdUnits.Find('-') then begin
                    repeat
                        SpecialExams.Reset;
                        SpecialExams.SetRange("Student No.", StdUnits."Student No.");
                        SpecialExams.SetRange("Unit Code", unit);
                        SpecialExams.SetRange("Programme", prog);
                        SpecialExams.SetRange("Current Semester", sem);
                        SpecialExams.SetRange("Stage", stage);
                        SpecialExams.SetRange("Category", SpecialExams.Category::Special);
                        SpecialExams.SetRange("Status", SpecialExams.Status::Approved);
                        if SpecialExams.Find('-') then begin
                            Msg += Customer."No." + ' ::' + Customer.Name + ' ::' + StdUnits.Unit + ' ::' + StdUnits.Description + ' ::' + StdUnits."Reg. Transacton ID" + ' :::';
                        end;
                    until StdUnits.Next = 0;
                end;
            until Customer.Next = 0;
        end else begin
            Customer.Reset;
            Customer.SetCurrentkey("No.");
            Customer.SetFilter(Name, '%1', '*' + searchParam + '*');
            if Customer.Find('-') then begin
                repeat
                    StdUnits.Reset;
                    StdUnits.SetRange("Student No.", Customer."No.");
                    StdUnits.SetRange(Unit, unit);
                    StdUnits.SetRange(Programme, prog);
                    StdUnits.SetRange(Semester, sem);
                    StdUnits.SetRange(Stage, stage);
                    if StdUnits.Find('-') then begin
                        repeat
                            Msg += Customer."No." + ' ::' + Customer.Name + ' ::' + StdUnits.Unit + ' ::' + StdUnits.Description + ' ::' + StdUnits."Reg. Transacton ID" + ' :::';
                        until StdUnits.Next = 0;
                    end;
                until Customer.Next = 0;
            end;
        end;
    end;

    procedure FnGetLecturerStudents(unit: Code[20]; prog: Code[20]; sem: Code[20]; stage: Code[20]) Msg: Text
    var
        StdUnits: Record "ACA-Student Units";
    begin
        StdUnits.Reset;
        StdUnits.SetCurrentkey("Student No.");
        StdUnits.SetRange(Unit, unit);
        StdUnits.SetRange(Programme, prog);
        StdUnits.SetRange(Semester, sem);
        StdUnits.SetRange(Stage, stage);
        if StdUnits.Find('-') then begin
            repeat
                Customer.Reset;
                Customer.SetRange("No.", StdUnits."Student No.");
                if Customer.Find('-') then begin
                    Msg += Customer."No." + ' ::' + Customer.Name + ' ::' + StdUnits.Unit + ' ::' + StdUnits.Description + ' ::' + StdUnits."Reg. Transacton ID" + ' :::';
                end;
            until StdUnits.Next = 0;
        end;
    end;

    procedure FnGetLecturerSpecialStudents(unit: Code[20]; prog: Code[20]; sem: Code[20]; stage: Code[20]) Msg: Text
    var
        StdUnits: Record "ACA-Student Units";
        SpecialExams: Record "Aca-Special Exams Details";
    begin
        StdUnits.Reset;
        StdUnits.SetCurrentkey("Student No.");
        StdUnits.SetRange(Unit, unit);
        StdUnits.SetRange(Programme, prog);
        StdUnits.SetRange(Stage, stage);
        if StdUnits.Find('-') then begin
            repeat
                SpecialExams.Reset;
                SpecialExams.SetRange("Student No.", StdUnits."Student No.");
                SpecialExams.SetRange("Unit Code", unit);
                SpecialExams.SetRange("Programme", prog);
                SpecialExams.SetRange("Current Semester", sem);
                SpecialExams.SetRange("Stage", stage);
                SpecialExams.SetRange("Category", SpecialExams.Category::Special);
                SpecialExams.SetRange("Status", SpecialExams.Status::Approved);
                if SpecialExams.Find('-') then begin
                    Customer.Reset;
                    Customer.SetRange("No.", StdUnits."Student No.");
                    if Customer.Find('-') then begin
                        Msg += Customer."No." + ' ::' + Customer.Name + ' ::' + StdUnits.Unit + ' ::' + StdUnits.Description + ' ::' + StdUnits."Reg. Transacton ID" + ' :::';
                    end;
                end;
            until StdUnits.Next = 0;
        end;
    end;

    procedure FnGetScore(stdNo: Code[20]; unit: Code[20]; sem: Code[20]; examType: Code[20]) Msg: Text
    var
        ExamResults: Record "ACA-Exam Results";
    //ExamResultsBuffer: Record "ACA-Results Buffer Marks";
    begin
        ExamResults.Reset;
        ExamResults.SetRange("Student No.", stdNo);
        ExamResults.SetRange(Unit, unit);
        ExamResults.SetRange(Semester, sem);
        ExamResults.SetRange(ExamType, examType);
        if ExamResults.Find('-') then begin
            Msg := Format(ExamResults.Score) + '::' + Format(ExamResults."Edit Count");
        end;
        /*  else begin
            ExamResultsBuffer.Reset;
            ExamResultsBuffer.SetRange("Student No.", stdNo);
            ExamResultsBuffer.SetRange("Unit Code", unit);
            ExamResultsBuffer.SetRange(Semester, sem);
            ExamResultsBuffer.SetRange("Exam Type", examType);
            if ExamResultsBuffer.Find('-') then begin
                Msg := ExamResultsBuffer."Score (String)" + '::' + Format(ExamResults."Edit Count");
            end;
        end; */
    end;

    procedure GetCurrentSem() Sem: Text
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        LectLoadBatch: Record "Lect Load Batches";
    begin
        CurrentSem.Reset;
        CurrentSem.SetRange("Current Semester", true);
        if CurrentSem.Find('-') then begin
            Sem := CurrentSem.Code;
        end;
    end;


    procedure GetCurrentSuppYear() Year: Text
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        LectLoadBatch: Record "Lect Load Batches";
    begin
        begin
            AcademicYr.Reset;
            AcademicYr.SetRange("Current Supplementary Year", true);
            if AcademicYr.Find('-') then begin
                Year := AcademicYr.Code;
            end;
        end;
    end;

    procedure GetLecturerSuppStages(lec: Code[20]; prog: Code[20]) Msg: Text
    var
        StdUnits: Record "ACA-Student Units";
        ACALecturerUnits: Record "ACA-Lecturers Units";
    begin
        ACALecturerUnits.Reset;
        ACALecturerUnits.SetCurrentkey(Stage);
        ACALecturerUnits.SetRange(Lecturer, lec);
        ACALecturerUnits.SetRange(Programme, prog);
        if ACALecturerUnits.Find('-') then begin
            repeat
                //ACALecturerUnits.SETRANGE(Programme, ACALecturerUnits.Programme);
                //ACALecturerUnits.FIND('+');
                //ACALecturerUnits.SETRANGE(Programme);
                CurrentSem.Reset;
                CurrentSem.SetRange(Code, ACALecturerUnits.Semester);
                CurrentSem.SetRange("Academic Year", GetCurrentSuppYear());
                if CurrentSem.Find('-') then begin
                    Msg += ACALecturerUnits.Stage + ' ::' + ACALecturerUnits.Stage + ' :::';
                end;
            until ACALecturerUnits.Next = 0;
        end;
    end;


    procedure GetLecturerSuppProgrammes(lec: Code[20]) Msg: Text
    var
        StdUnits: Record "ACA-Student Units";
        ACALecturerUnits: Record "ACA-Lecturers Units";
    begin
        ACALecturerUnits.Reset;
        ACALecturerUnits.SetCurrentkey(Programme);
        ACALecturerUnits.SetRange(Lecturer, lec);
        if ACALecturerUnits.Find('-') then begin
            repeat
                //ACALecturerUnits.SETRANGE(Programme, ACALecturerUnits.Programme);
                //ACALecturerUnits.FIND('+');
                //ACALecturerUnits.SETRANGE(Programme);
                CurrentSem.Reset;
                CurrentSem.SetRange(Code, ACALecturerUnits.Semester);
                CurrentSem.SetRange("Academic Year", GetCurrentSuppYear());
                if CurrentSem.Find('-') then begin
                    Programmezz.Reset;
                    Programmezz.SetRange(Code, ACALecturerUnits.Programme);
                    if Programmezz.Find('-') then begin
                        Msg += ACALecturerUnits.Programme + ' ::' + Programmezz.Description + ' :::';
                    end;
                end;
            until ACALecturerUnits.Next = 0;
        end;
    end;


    procedure GetLecturerSuppUnits(lec: Code[20]; prog: Code[20]; stage: Code[20]) Msg: Text
    var
        StdUnits: Record "ACA-Student Units";
        ACALecturerUnits: Record "ACA-Lecturers Units";
    begin
        ACALecturerUnits.Reset;
        ACALecturerUnits.SetRange(Lecturer, lec);
        ACALecturerUnits.SetRange(Programme, prog);
        ACALecturerUnits.SetRange(Stage, stage);
        if ACALecturerUnits.Find('-') then begin
            repeat
                CurrentSem.Reset;
                CurrentSem.SetRange(Code, ACALecturerUnits.Semester);
                CurrentSem.SetRange("Academic Year", GetCurrentSuppYear());
                if CurrentSem.Find('-') then begin
                    Msg += ACALecturerUnits.Unit + ' ::' + ACALecturerUnits.Description + ' :::';
                end;
            until ACALecturerUnits.Next = 0;
        end;
    end;

    procedure FnGetSuppMaxScore(prog: Code[20]; unit: Code[20]; stage: Code[10]) Msg: Decimal
    var
        ExamResults: Record "ACA-Exam Results";
        //ExamResultsBuffer: Record UnknownRecord78055;
        ACAExamCategory: Record "ACA-Exam Category";
        ACASpecialExamResults: Record "ACA-Special Exams Results";
    begin
        UnitSubjects.Reset;
        UnitSubjects.SetRange(Code, unit);
        UnitSubjects.SetRange("Programme Code", prog);
        UnitSubjects.SetRange("Stage Code", stage);
        if UnitSubjects.Find('-') then begin
            ACAExamCategory.Reset;
            ACAExamCategory.SetRange(Code, UnitSubjects."Exam Category");
            if ACAExamCategory.Find('-') then begin
                Msg := ACAExamCategory."Supplementary Max. Score";
            end;
        end;
    end;


    procedure FnGetSpecialScore(stdNo: Code[20]; unit: Code[20]) Msg: Text
    var
        ExamResults: Record "ACA-Exam Results";
        // ExamResultsBuffer: Record UnknownRecord78055;
        ACASpecialExamResults: Record "ACA-Special Exams Results";
    begin
        ACASpecialExamResults.Reset;
        ACASpecialExamResults.SetRange("Student No.", stdNo);
        ACASpecialExamResults.SetRange(Unit, unit);
        ACASpecialExamResults.SetRange(Category, ACASpecialExamResults.Category::Special);
        if ACASpecialExamResults.Find('-') then begin
            Msg := Format(ACASpecialExamResults.Score);
        end;
    end;


    procedure FnGetSuppScore(stdNo: Code[20]; unit: Code[20]) Msg: Text
    var
        ExamResults: Record "ACA-Exam Results";
        // ExamResultsBuffer: Record UnknownRecord78055;
        ACASpecialExamResults: Record "Aca-Special Exams Results";
    begin
        ACASpecialExamResults.Reset;
        ACASpecialExamResults.SetRange("Student No.", stdNo);
        ACASpecialExamResults.SetRange(Unit, unit);
        ACASpecialExamResults.SetRange(Category, ACASpecialExamResults.Category::Supplementary);
        if ACASpecialExamResults.Find('-') then begin
            Msg := Format(ACASpecialExamResults.Score);
        end;
    end;

    procedure FnGetLecturerSpecialStudents(unit: Code[20]; prog: Code[20]; stage: Code[20]) Msg: Text
    var
        StdUnits: Record "ACA-Student Units";
    begin
        SupUnits.Reset;
        SupUnits.SetCurrentkey("Student No.");
        SupUnits.SetRange("Unit Code", unit);
        SupUnits.SetRange(Programme, prog);
        SupUnits.SetRange("Current Academic Year", GetCurrentSuppYear());
        SupUnits.SetRange(Stage, stage);
        SupUnits.SetRange(Category, SupUnits.Category::Special);
        if SupUnits.Find('-') then begin
            repeat
                Customer.Reset;
                Customer.SetRange("No.", SupUnits."Student No.");
                if Customer.Find('-') then begin
                    Msg += Customer."No." + ' ::' + Customer.Name + ' ::' + SupUnits."Unit Code" + ' ::' + SupUnits."Unit Description" + ' :::';
                end;
            until SupUnits.Next = 0;
        end;
    end;

    procedure FnGetLecturerSuppStudents(unit: Code[20]; prog: Code[20]; stage: Code[20]) Msg: Text
    var
        StdUnits: Record "ACA-Student Units";
    begin
        SupUnits.Reset;
        SupUnits.SetCurrentkey("Student No.");
        SupUnits.SetRange("Unit Code", unit);
        SupUnits.SetRange(Programme, prog);
        SupUnits.SetRange("Current Academic Year", GetCurrentSuppYear());
        SupUnits.SetRange(Stage, stage);
        SupUnits.SetRange(Category, SupUnits.Category::Supplementary);
        if SupUnits.Find('-') then begin
            repeat
                Customer.Reset;
                Customer.SetRange("No.", SupUnits."Student No.");
                if Customer.Find('-') then begin
                    Msg += Customer."No." + ' ::' + Customer.Name + ' ::' + SupUnits."Unit Code" + ' ::' + SupUnits."Unit Description" + ' :::';
                end;
            until SupUnits.Next = 0;
        end;
    end;

    procedure SubmitSpecialByLec(StudNo: Code[20]; LectNo: Code[20]; Marks: Decimal; UnitCode: Code[20]; Prog: Code[10]; Stage: Code[10]) ReturnMessage: Text[250]
    var
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        AcaSpecialExamsResults: Record "Aca-Special Exams Results";
        emps: Record "HRM-Employee C";
    begin
        Clear(ReturnMessage);
        Clear(emps);
        emps.Reset;
        emps.SetRange("No.", LectNo);
        if emps.Find('-') then;
        AcaSpecialExamsDetails.Reset;
        AcaSpecialExamsDetails.SetRange("Current Academic Year", GetCurrentSuppYear());
        AcaSpecialExamsDetails.SetRange("Student No.", StudNo);
        AcaSpecialExamsDetails.SetRange("Unit Code", UnitCode);
        AcaSpecialExamsDetails.SetRange(Programme, Prog);
        AcaSpecialExamsDetails.SetRange(Category, AcaSpecialExamsDetails.Category::Special);
        AcaSpecialExamsDetails.SetRange(Stage, Stage);
        if AcaSpecialExamsDetails.Find('-') then begin
            AcaSpecialExamsResults.Reset;
            AcaSpecialExamsResults.SetRange("Student No.", StudNo);
            AcaSpecialExamsResults.SetRange(Unit, UnitCode);
            AcaSpecialExamsResults.SetRange(Category, AcaSpecialExamsResults.Category::Special);
            if not AcaSpecialExamsResults.Find('-') then begin
                AcaSpecialExamsResults.Init;
                AcaSpecialExamsResults.Programmes := AcaSpecialExamsDetails.Programme;
                AcaSpecialExamsResults.Stage := AcaSpecialExamsDetails.Stage;
                AcaSpecialExamsResults.Unit := UnitCode;
                AcaSpecialExamsResults.Semester := AcaSpecialExamsDetails.Semester;
                AcaSpecialExamsResults."Student No." := AcaSpecialExamsDetails."Student No.";
                AcaSpecialExamsResults."Academic Year" := AcaSpecialExamsDetails."Academic Year";
                AcaSpecialExamsResults."Admission No" := StudNo;
                AcaSpecialExamsResults."Current Academic Year" := GetCurrentSuppYear();
                AcaSpecialExamsResults.UserID := LectNo;
                AcaSpecialExamsResults."Capture Date" := Today;
                AcaSpecialExamsResults.Category := AcaSpecialExamsDetails.Category;
                AcaSpecialExamsResults."Lecturer Names" := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
                AcaSpecialExamsResults.Score := Marks;
                AcaSpecialExamsResults.Validate(Score);
                AcaSpecialExamsResults.Insert;
                ReturnMessage := 'SUCCESS: Marks Inserted!';
            end else begin
                AcaSpecialExamsResults."Current Academic Year" := GetCurrentSuppYear();
                AcaSpecialExamsResults."Modified By" := LectNo;
                AcaSpecialExamsResults."Modified Date" := Today;
                AcaSpecialExamsResults."Modified By Name" := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
                AcaSpecialExamsResults.Score := Marks;
                AcaSpecialExamsResults.Validate(Score);
                AcaSpecialExamsResults.Modify;
                ReturnMessage := 'SUCCESS: Marks Modified!';
            end;
            AcaSpecialExamsDetails."Exam Marks" := Marks;
            AcaSpecialExamsDetails.Modify;
        end;
    end;


    procedure SubmitSuppByLec(StudNo: Code[20]; LectNo: Code[20]; Marks: Decimal; UnitCode: Code[20]; Prog: Code[10]; Stage: Code[10]) ReturnMessage: Text[250]
    var
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        AcaSpecialExamsResults: Record "Aca-Special Exams Results";
        emps: Record "HRM-Employee C";
    begin
        Clear(ReturnMessage);
        Clear(emps);
        emps.Reset;
        emps.SetRange("No.", LectNo);
        if emps.Find('-') then;
        AcaSpecialExamsDetails.Reset;
        AcaSpecialExamsDetails.SetRange("Current Academic Year", GetCurrentSuppYear());
        AcaSpecialExamsDetails.SetRange(Category, AcaSpecialExamsDetails.Category::Supplementary);
        AcaSpecialExamsDetails.SetRange("Student No.", StudNo);
        AcaSpecialExamsDetails.SetRange("Unit Code", UnitCode);
        AcaSpecialExamsDetails.SetRange(Programme, Prog);
        AcaSpecialExamsDetails.SetRange(Stage, Stage);
        if AcaSpecialExamsDetails.Find('-') then begin
            AcaSpecialExamsResults.Reset;
            AcaSpecialExamsResults.SetRange("Student No.", StudNo);
            AcaSpecialExamsResults.SetRange(Unit, UnitCode);
            AcaSpecialExamsResults.SetRange(Category, AcaSpecialExamsResults.Category::Supplementary);
            if not AcaSpecialExamsResults.Find('-') then begin
                AcaSpecialExamsResults.Init;
                AcaSpecialExamsResults.Programmes := AcaSpecialExamsDetails.Programme;
                AcaSpecialExamsResults.Stage := AcaSpecialExamsDetails.Stage;
                AcaSpecialExamsResults.Unit := UnitCode;
                AcaSpecialExamsResults.Semester := AcaSpecialExamsDetails.Semester;
                AcaSpecialExamsResults."Student No." := AcaSpecialExamsDetails."Student No.";
                AcaSpecialExamsResults."Academic Year" := AcaSpecialExamsDetails."Academic Year";
                AcaSpecialExamsResults."Admission No" := StudNo;
                AcaSpecialExamsResults."Current Academic Year" := GetCurrentSuppYear();
                AcaSpecialExamsResults.UserID := LectNo;
                AcaSpecialExamsResults."Capture Date" := Today;
                AcaSpecialExamsResults.Category := AcaSpecialExamsDetails.Category;
                AcaSpecialExamsResults."Lecturer Names" := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
                AcaSpecialExamsResults.Score := Marks;
                AcaSpecialExamsResults.Validate(Score);
                AcaSpecialExamsResults.Insert;
                ReturnMessage := 'SUCCESS: Marks Inserted!';
            end else begin
                AcaSpecialExamsResults."Current Academic Year" := GetCurrentSuppYear();
                AcaSpecialExamsResults."Modified By" := LectNo;
                AcaSpecialExamsResults."Modified Date" := Today;
                AcaSpecialExamsResults."Modified By Name" := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
                AcaSpecialExamsResults.Score := Marks;
                AcaSpecialExamsResults.Validate(Score);
                AcaSpecialExamsResults.Modify;
                ReturnMessage := 'SUCCESS: Marks Modified!';
            end;
            AcaSpecialExamsDetails."Exam Marks" := Marks;
            AcaSpecialExamsDetails.Modify;
        end;
    end;
    #Region
    //handle postgraduate submodule
    procedure ApplyForSupervisor(StudentNo: Code[20]) ret_value: Code[20]
    begin
        ret_value := (PostGradHandler.ApplyForSupervisor(StudentNo));
    end;

    procedure SubmitDocument(StudentNo: Code[20]; SubmissionType: Option "Concept Paper",Thesis) ret_value: Code[20]
    begin
        ret_value := (PostGradHandler.SubmitDocument(StudentNo, SubmissionType));
    end;

    procedure LogCommunication(StudentNo: Code[20]; SupervisorCode: Code[20]; Message: Text[2048]; SenderType: Option Student,Supervisor) ret_value: Boolean
    begin
        ret_value := (PostGradHandler.LogCommunication(StudentNo, SupervisorCode, Message, SenderType));
    end;

    procedure UploadBase64FileToDocumentAttachment(base64Content: Text; fileName: Text; tableId: Integer; DocumentNo: Code[25]; LineNo: Integer): Boolean
    var
        TempBlob: Codeunit "Temp Blob";
        DocumentAttachment: Record "Document Attachment";
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
        OutStream: OutStream;
        FileMgmt: Codeunit "File Management";
    begin
        // Convert base64 to binary
        TempBlob.CreateOutStream(OutStream);
        Base64Convert.FromBase64(base64Content, OutStream);
        // Prepare Document Attachment record
        DocumentAttachment.Init();
        DocumentAttachment.Validate("Table ID", tableId);
        DocumentAttachment.Validate("No.", DocumentNo);
        if LineNo <> 0 then
            DocumentAttachment.Validate("Line No.", LineNo);
        DocumentAttachment."File Name" := FileMgmt.GetFileNameWithoutExtension(fileName);
        DocumentAttachment."File Extension" := FileMgmt.GetExtension(fileName);
        DocumentAttachment."Document Reference ID".ImportStream(TempBlob.CreateInStream(), fileName);
        // Insert the record
        if DocumentAttachment.Insert(true) then begin
            exit(true);
        end else begin
            exit(false);
        end;
    end;

    procedure GenerateBS64ApplicationSummary(appNo: Text; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
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
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appNo);
        IF fablist.FIND('-') THEN BEGIN
            recRef.GetTable(fablist);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(Report::"Student Applications Report", '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END;
        EXIT(filename);
    end;

    procedure checkHOD(username: code[10]) ishod: Boolean
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        EmployeeCard.SETRANGE(EmployeeCard.HOD, TRUE);
        IF EmployeeCard.FIND('-') THEN BEGIN
            ishod := TRUE;
        END;
    end;

    procedure checkDean(username: code[10]) ishod: Boolean
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        EmployeeCard.SETRANGE(EmployeeCard.isDean, TRUE);
        IF EmployeeCard.FIND('-') THEN BEGIN
            ishod := TRUE;
        END;
    end;

    procedure GetDepartmentalApps(username: code[10]) apps: Text
    var
        progname: Text;
        faculty: Text;
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            fablist.RESET;
            fablist.SETRANGE(fablist."Admitted Department", EmployeeCard."Department Code");
            fablist.SETRANGE(fablist.Status, fablist.Status::"Pending Approval");
            IF fablist.FIND('-') THEN BEGIN
                REPEAT
                    programs.RESET;
                    programs.SETRANGE(programs.Code, fablist."First Degree Choice");
                    IF programs.FIND('-') THEN BEGIN
                        progname := programs.Description;
                        faculty := programs.Faculty;
                    END;
                    apps := apps + fablist."Application No." + ' ::' + progname + ' ::' + faculty + ' ::' + FORMAT(fablist."Application Date") + ' ::' + fablist.firstName + ' ::' + fablist.Surname + ' ::' + ' :::';
                UNTIL fablist.Next = 0;
            END;
        END;
    end;

    procedure GetFacultyApps(username: code[10]) apps: Text
    var
        progname: Text;
        faculty: Text;
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            fablist.RESET;
            fablist.SETRANGE(fablist.School1, EmployeeCard."Faculty Code");
            fablist.SETFILTER(fablist.Status, '%1|%2', fablist.Status::"Department Approved", fablist.Status::"Department Rejected");
            IF fablist.FIND('-') THEN BEGIN
                REPEAT
                    programs.RESET;
                    programs.SETRANGE(programs.Code, fablist."First Degree Choice");
                    IF programs.FIND('-') THEN BEGIN
                        progname := programs.Description;
                        faculty := programs.Faculty;
                    END;
                    apps := apps + fablist."Application No." + ' ::' + progname + ' ::' + faculty + ' ::' + FORMAT(fablist."Application Date") + ' ::' + fablist.firstName + ' ::' + fablist.Surname + ' ::' + FORMAT(fablist.Status) + ' :::';
                UNTIL fablist.Next = 0;
            END;
        END;
    end;

    procedure RejectDepartmentalApps(appno: code[20]; staffno: code[20]; reason: Text[250]) rejected: Boolean
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            fabList.Status := fablist.Status::"Department Rejected";
            fablist."Rejection Reason" := reason;
            fablist."DAB Staff ID" := staffno;
            fablist.Validate("DAB Staff ID");
            fablist.MODIFY;
            rejected := TRUE;
        END;
    end;

    procedure RejectFacultyApps(appno: code[20]; staffno: code[20]; reason: Text[250]) accepted: Boolean
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            fabList.Status := fablist.Status::"Dean Rejected";
            fablist."Rejection Reason" := reason;
            fablist."FAB Staff ID" := staffno;
            fablist.Validate("FAB Staff ID");
            fablist.MODIFY;
            accepted := TRUE;
        END;
    end;

    procedure AcceptDepartmentalApps(appno: code[20]; staffno: Code[20]) accepted: Boolean
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            fablist.Status := fablist.Status::"Department Approved";
            fablist."DAB Staff ID" := staffno;
            fablist.Validate("DAB Staff ID");
            //fablist."Settlement Type":=stype;
            fablist.MODIFY;
            //SendEmail(fablist."First Degree Choice", fablist."Application No.");
            accepted := TRUE;
        END;
    end;

    procedure AcceptFacultyApps(appno: code[20]; staffno: code[20]) accepted: Boolean
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            fabList.Status := fablist.Status::"Dean Approved";
            fablist."FAB Staff ID" := staffno;
            fablist.Validate("FAB Staff ID");
            fablist.MODIFY;
            accepted := TRUE;
        END;
    end;

    procedure GetApplicantEmail(appno: code[50]) email: Text
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            email := fabList.Email;
        END;
    end;
    #endregion

    procedure CreatePartimerClaim(pfNO: code[25]; Sem: code[25]; Purpose: Text[250]) msg: Code[25]
    var
        HrmEmployeeC: record "HRM-Employee C";
        PartTImer: record "Parttime Claim Header";
        ParttimeLines: record "Parttime Claim Lines";
    begin
        HrmEmployeeC.reset;
        hrmemployeec.setrange("No.", pfNO);
        if HrmEmployeeC.findfirst then begin
            PartTImer.Init();
            PartTImer."No." := '';
            partTimer."Account No." := pfNO;
            PartTImer.Validate("Account No.");
            PartTImer.date := today;
            parttimer."Global Dimension 1 Code" := hrmemployeec.Campus;
            PartTImer."Global Dimension 2 Code" := hrmemployeec."Department Code";
            PartTImer.Validate("Global Dimension 1 Code");
            PartTImer.Validate("Global Dimension 2 Code");
            PartTImer."Responsibility Center" := hrmemployeec."Responsibility Center";
            PartTImer.Validate("Responsibility Center");
            PartTImer."Purpose" := Purpose;
            PartTImer."Semester" := Sem;
            PartTImer.Validate("Semester");
            if PartTImer.Insert(true) then
                msg := PartTImer."No.";
        end;
    end;

    procedure addParttimeClaimLine(ClaimNo: Code[25]; Programme: code[25]; UnitCode: Code[25]) msg: Boolean
    var
        ParttimeLines: record "Parttime Claim Lines";
        AcadYear: Code[25];
        PartTImer: record "Parttime Claim Header";
        Semesters: Record "ACA-Semesters";
    begin
        PartTImer.RESET;
        PartTImer.SetRange("No.", ClaimNo);
        if PartTImer.FindFirst() then begin
            Semesters.Reset();
            Semesters.SetRange(code, PartTImer.Semester);
            if Semesters.FindFirst() then
                AcadYear := semesters."Academic Year";
            ParttimeLines.Init();
            ParttimeLines."Document No." := ClaimNo;
            ParttimeLines."Lecture No." := PartTImer."Account No.";
            ParttimeLines."Academic Year" := acadyear;
            //ParttimeLines.Validate("Academic Year");
            ParttimeLines.Semester := PartTImer.Semester;
            //ParttimeLines.Validate(Semester);
            ParttimeLines.programme := Programme;
            ParttimeLines.Validate("Programme");
            ParttimeLines."Unit" := UnitCode;
            ParttimeLines.Validate("Unit");
            msg := ParttimeLines.Insert(true);
        end;
    end;

    procedure getParttimeclaims(pfNo: Code[25]) msg: Text
    var
        ParttimeClaimHeader: record "Parttime Claim Header";
    begin
        ParttimeClaimHeader.RESET;
        ParttimeClaimHeader.SETRANGE("Account No.", pfNo);
        if ParttimeClaimHeader.Find('-') then begin
            Repeat
                ParttimeClaimHeader.CalcFields("Payment Amount");
                msg := ParttimeClaimHeader."No." + ' ::' + ParttimeClaimHeader."Semester" + ' ::' + ParttimeClaimHeader."Purpose" + ' ::' + Format(ParttimeClaimHeader."Payment Amount") + ' ::' + Format(ParttimeClaimHeader.Status) + ' :::';
            Until ParttimeClaimHeader.NEXT = 0;
        end;
    end;

    procedure getParttimeclaimLines(ClaimNo: Code[25]) msg: Text
    var
        ParttimeClaimLines: record "Parttime Claim Lines";
    begin
        ParttimeClaimLines.RESET;
        ParttimeClaimLines.SETRANGE("Document No.", ClaimNo);
        if ParttimeClaimLines.FIND('-') then begin
            repeat
                msg += Format(ParttimeClaimLines."Line No.") + ' ::' + ParttimeClaimLines.Semester + ' ::' + ParttimeClaimLines."Academic Year" + ' ::' + ParttimeClaimLines.programme + ' ::' + ParttimeClaimLines."Unit" + ' ::' + Format(ParttimeClaimLines."Hours Done") + ' ::' + Format(ParttimeClaimLines.Amount) + ' :::';
            until ParttimeClaimLines.NEXT = 0;
        end;
    end;

    procedure getLecSemesters(lec: Code[20]) msg: Text
    var
        LecUnits: Record "ACA-Lecturers Units";
    begin
        LecUnits.RESET;
        LecUnits.SETRANGE(Lecturer, lec);
        if LecUnits.FIND('-') then begin
            repeat
                msg += LecUnits.Semester + ' ::';
            until LecUnits.NEXT = 0;
        end;
    end;

    procedure getLecProgrammes(lec: Code[20]; Sem: code[25]) msg: Text
    var
        LecUnits: Record "ACA-Lecturers Units";
    begin
        LecUnits.RESET;
        LecUnits.SETRANGE(Lecturer, lec);
        LecUnits.SETRANGE(Semester, Sem);
        if LecUnits.FIND('-') then begin
            repeat
                programs.RESET;
                programs.SETRANGE(Code, LecUnits.Programme);
                if programs.FIND('-') then
                    msg += LecUnits.Programme + ' ::' + programs.Description + ' :::';
            until LecUnits.NEXT = 0;
        end;
    end;

    procedure getLecturerUnits(lec: Code[20]; Sem: code[25]; prog: code[25]) msg: Text
    var
        LecUnits: Record "ACA-Lecturers Units";
        ParttimeLines: record "Parttime Claim Lines";
    begin
        LecUnits.RESET;
        LecUnits.SETRANGE(Lecturer, lec);
        LecUnits.SETRANGE(Semester, Sem);
        LecUnits.SETRANGE(Programme, prog);
        if LecUnits.FIND('-') then begin
            repeat
                ParttimeLines.Reset();
                ParttimeLines.SetRange("Lecture No.", lec);
                ParttimeLines.SetRange(Semester, sem);
                ParttimeLines.SetRange(Programme, prog);
                ParttimeLines.SetRange(Unit, LecUnits.Unit);
                if not ParttimeLines.FindFirst() then
                    msg += LecUnits.Unit + ' ::' + LecUnits.Description + ' :::';
            until LecUnits.NEXT = 0;
        end;
    end;

    procedure CheckPartTimeLine(appno: Code[20]) exists: Boolean
    var
        PartTimeClaimLn: record "Parttime Claim Lines";
    begin
        PartTimeClaimLn.Reset();
        PartTimeClaimLn.SETRANGE("Document No.", appno);
        IF PartTimeClaimLn.FIND('-') THEN BEGIN
            exists := true;
        END
    end;

    procedure CheckPartTimeApproval(appno: Code[20]) exists: Boolean
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SETRANGE("Document No.", appno);
        IF ApprovalEntry.FIND('-') THEN BEGIN
            exists := true;
        END
    end;

    procedure PartTimeApprovalRequest(ReqNo: Code[20])
    var
        ApprovMgmt: Codeunit "Approval Workflows V1";
        PartTimeClaimHd: record "Parttime Claim Header";
        variant: Variant;
    begin
        PartTimeClaimHd.Reset();
        PartTimeClaimHd.SETRANGE("No.", ReqNo);
        IF PartTimeClaimHd.FIND('-')
        THEN BEGIN
            variant := partTimeClaimHd;
            if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                PartTimeClaimHd.CommitBudget();
            ApprovMgmt.OnSendDocForApproval(variant);

        end
    END;

    procedure DeletePartTimeClaimLine(claimno: code[20]; lineno: integer) deleted: boolean
    var
        PartTimeClaimLn: record "Parttime Claim Lines";
    begin
        PartTimeClaimLn.reset();
        PartTimeClaimLn.SETRANGE(PartTimeClaimLn."Document No.", claimno);
        PartTimeClaimLn.SETRANGE(PartTimeClaimLn."Line No.", lineno);
        IF PartTimeClaimLn.FIND('-') THEN begin
            PartTimeClaimLn.Delete();
            DELETED := true;
        end;
    END;
    #region Postgraduate
    procedure GetPostgraduateStudents(pfNo: Code[25]; Sem: code[25]; Programme: code[25]) msg: Text
    var
        PostGradStudents: Record "ACA-Course Registration";
        Emp: Record "HRM-Employee C";
        Customer: Record Customer;
    begin
        emp.RESET;
        emp.SETRANGE(emp."No.", pfNo);
        if emp.FIND('-') then begin
            PostGradStudents.RESET;
            PostGradStudents.SETRANGE(PostGradStudents.Semester, Sem);
            PostGradStudents.SetAutoCalcFields("Is Postgraduate", "Programme Description");
            PostGradStudents.SETRANGE(PostGradStudents."Is Postgraduate", true);
            PostGradStudents.SETRANGE(PostGradStudents.Programmes, Programme);
            if PostGradStudents.FIND('-') then begin
                repeat
                    Customer.RESET;
                    Customer.SETRANGE("No.", PostGradStudents."Student No.");
                    Customer.SetRange("Global Dimension 2 Code", emp."Department Code");
                    if Customer.FIND('-') then begin
                        msg += Customer."No." + ' ::' + Customer.Name + ' ::' + PostGradStudents."Programmes" + ' ::' + PostGradStudents."Programme Description" + ' :::';
                    end;
                until PostGradStudents.NEXT = 0;
            end;
        end;
    end;

    procedure GetPostgraduateProgrammes(pfNo: Code[25]; Sem: code[25]) msg: Text
    var
        Progs: Record "ACA-Programme";
        Emp: Record "HRM-Employee C";
    begin
        emp.RESET;
        emp.SETRANGE(emp."No.", pfNo);
        if emp.FIND('-') then begin
            Progs.RESET;
            Progs.SETRANGE(Progs."Department Code", Emp."Department Code");
            Progs.SETRANGE(Progs.Category, Progs.Category::Postgraduate);
            if Progs.FIND('-') then begin
                repeat
                    msg += Progs.Code + ' ::' + Progs.Description + ' :::';
                until Progs.NEXT = 0;
            end;
        end;
    end;

    procedure getSupervisors(pfNo: Code[25]; Sem: code[25]; Programme: code[25]) msg: Text
    var
        Emp: Record "HRM-Employee C";
        Supervisors: Record "HRM-Employee C";
    begin
        emp.RESET;
        emp.SETRANGE(emp."No.", pfNo);
        if emp.FIND('-') then begin
            Supervisors.RESET;
            Supervisors.SETRANGE(Supervisors."Department Code", Emp."Department Code");
            if Supervisors.FIND('-') then begin
                repeat
                    msg += Supervisors."No." + ' ::' + Supervisors."First Name" + ' ::' + Supervisors."Middle Name" + ' ::' + Supervisors."Last Name" + ' :::';
                until Supervisors.NEXT = 0;
            end;
        end;
    end;

    procedure NewSupervisorApplic(StudentNo: Code[25]) msg: Text
    var
        SuperVisorApplic: Record "Postgrad Supervisor Applic.";
    begin
        SuperVisorApplic.Init();
        SuperVisorApplic."No." := '';
        SuperVisorApplic."Student No." := StudentNo;
        SuperVisorApplic.Validate("Student No.");
        SuperVisorApplic."Application Date" := Today;
        SuperVisorApplic.Status := SuperVisorApplic.Status::open;
        if SuperVisorApplic.Insert(true) then
            msg := SuperVisorApplic."No.";
    end;

    procedure GetSupervisorApplic(StudentNo: Code[25]) msg: Text
    var
        SuperVisorApplic: Record "Postgrad Supervisor Applic.";
    begin
        SuperVisorApplic.Init();
        SuperVisorApplic.SetRange("Student No.", StudentNo);
        if SuperVisorApplic.FIND('-') then begin
            msg := SuperVisorApplic."No." + ' ::' + SuperVisorApplic."Student No." + ' ::' + Format(SuperVisorApplic."Application Date") + ' ::' + Format(SuperVisorApplic.Status) + ' :::';
        end;
    end;

    procedure AssignSupervisor(pfNo: Code[25]; Sem: code[25]; Programme: code[25]; Supervisor: code[25]; StudentNo: Code[25]) msg: Text
    var
        SuperVisorApplic: Record "Postgrad Supervisor Applic.";
    begin
        SuperVisorApplic.Init();
        SuperVisorApplic."No." := '';
        SuperVisorApplic."Student No." := StudentNo;
        SuperVisorApplic.Validate("Student No.");
        SuperVisorApplic."Application Date" := Today;
        SuperVisorApplic.Status := SuperVisorApplic.Status::open;
        SuperVisorApplic."Assigned Supervisor Code" := Supervisor;
        SuperVisorApplic.Validate("Assigned Supervisor Code");
        SuperVisorApplic."Semester" := Sem;
        SuperVisorApplic.Validate("Semester");
        SupervisorApplic."Assigned By" := pfNo;
        SupervisorApplic.Validate("Assigned By");
        if SuperVisorApplic.Insert(true) then
            msg := SuperVisorApplic."No.";
    end;

    procedure GetSupervisorApplications(pfNo: Code[25]; Sem: code[25]; Programme: code[25]) msg: Text
    var
        SuperVisorApplic: Record "Postgrad Supervisor Applic.";
        Emp: Record "HRM-Employee C";
    begin
        emp.RESET;
        emp.SETRANGE(emp."No.", pfNo);
        if emp.FIND('-') then begin
            SuperVisorApplic.RESET;
            SuperVisorApplic.SETRANGE(SuperVisorApplic."Assigned By", pfNo);
            SuperVisorApplic.SETRANGE(SuperVisorApplic."Semester", Sem);
            if SuperVisorApplic.FIND('-') then begin
                repeat
                    msg += SuperVisorApplic."No." + ' ::' + SuperVisorApplic.Semester + ' ::' + SuperVisorApplic."Student No." + SuperVisorApplic."Student Name" + ' ::' + SuperVisorApplic."Assigned Supervisor Code" + ' ::' + SuperVisorApplic."Assigned Supervisor Name" + ' ::' + Format(SuperVisorApplic.Status) + ' :::';
                until SuperVisorApplic.NEXT = 0;
            end;
        end;
    end;

    procedure sendVariantApprovalWorkflow(DocNo: Code[25]; TableId: Integer)
    var
        SuperVisorApplic: Record "Postgrad Supervisor Applic.";
        varVariant: Variant;
        ApprovMgmt: Codeunit "Approval Workflows V1";
    begin
        case
            TableId of
            Database::"Postgrad Supervisor Applic.":
                begin
                    SuperVisorApplic.RESET;
                    SuperVisorApplic.SETRANGE("No.", DocNo);
                    if SuperVisorApplic.FIND('-') then begin
                        varVariant := SuperVisorApplic;
                    end;
                end;
        end;
        if varVariant.IsRecord then begin
            if ApprovMgmt.CheckApprovalsWorkflowEnabled(varVariant) then
                ApprovMgmt.OnSendDocForApproval(varVariant);
        end;
    end;

    procedure GetApprovalStatus(DocumentNo: Text) Message: Text
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
        ApprovalEntry.SetCurrentKey("Sequence No.");
        IF ApprovalEntry.FIND('-') THEN BEGIN
            Message := FORMAT(ApprovalEntry.Status);
        END
    end;

    procedure GetNextStoreReqNo() msg: Text
    begin
        msg := NoSeriesMgt.GetNextNo('STREQ', 0D, FALSE);
    end;

    procedure GetNextPRNNo() msg: Text
    begin
        msg := NoSeriesMgt.GetNextNo('INTREQ', 0D, FALSE);
    end;

    procedure PurchaseHeaderCreate(BusinessCode: Code[50]; UserID: Text; Purpose: Text)
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange(EmployeeCard."No.", UserID);
        if EmployeeCard.find('-') THEN BEGIN
            NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('INTREQ', 0D, TRUE);
            PurchaseRN.INIT;
            PurchaseRN."No." := NextLeaveApplicationNo;
            PurchaseRN."Document Type" := PurchaseRN."Document Type"::Quote;
            //PurchaseRN.Department:=DepartmentCode;
            PurchaseRN."Buy-from Vendor No." := 'DEPART';
            PurchaseRN."Pay-to Vendor No." := 'DEPART';
            PurchaseRN."Invoice Disc. Code" := 'DEPART';
            PurchaseRN."Shortcut Dimension 1 Code" := BusinessCode;
            PurchaseRN."Shortcut Dimension 2 Code" := EmployeeCard."Department Code";
            PurchaseRN."Responsibility Center" := EmployeeCard."Responsibility Center";
            PurchaseRN."Assigned User ID" := UserID;
            PurchaseRN."No. Series" := 'INTREQ';
            PurchaseRN."Order Date" := TODAY;
            PurchaseRN."Due Date" := TODAY;
            PurchaseRN."Expected Receipt Date" := TODAY;
            PurchaseRN."Posting Description" := Purpose;
            PurchaseRN.INSERT;
        END;
    end;

    procedure GetLastPRNNo(username: Code[30]) Message: Text
    begin
        PurchaseRN.Reset();
        PurchaseRN.SETRANGE(PurchaseRN."Assigned User ID", username);
        IF PurchaseRN.FIND('+') THEN BEGIN
            Message := PurchaseRN."No.";
        END
    end;

    procedure SubmitPurchaseLine(DocumentType: integer; DocumentNo: Text; FunctionNo: Code[50]; LocationID: Text; ExpectedDate: Date; FunctionDesc: Text; UnitsOfMeasure: Text; Quantityz: Decimal)
    begin
        PurchaseLines.INIT;
        PurchaseLines.Type := DocumentType;
        PurchaseLines."Document Type" := PurchaseLines."Document Type"::Quote;
        PurchaseLines."Document No." := DocumentNo;
        PurchaseLines."Line No." := PurchaseLines.COUNT + 1;
        PurchaseLines."No." := FunctionNo;
        PurchaseLines."Location Code" := LocationID;
        PurchaseLines."Expected Receipt Date" := ExpectedDate;
        PurchaseLines.Description := FunctionDesc;
        PurchaseLines."Unit of Measure" := UnitsOfMeasure;
        PurchaseLines.Quantity := Quantityz;
        PurchaseLines.Validate("Document No.");
        PurchaseLines.INSERT;
    end;

    procedure GetPRNItems() Message: Text
    begin
        Items.Reset();
        Items.SETFILTER(Items.Description, '<>%1', '');
        IF Items.FIND('-') THEN BEGIN
            repeat
                Message := Message + Items."No." + ' ::' + Items.Description + ' :::';
            until Items.Next = 0;
        END
    end;

    procedure GetGLItems() Message: Text
    begin
        GLAccounts.Reset();
        //GLAccounts.SETRANGE(GLAccounts.IsService, true);
        GLAccounts.SETRANGE(GLAccounts."Account Type", GLAccounts."Account Type"::Posting);
        IF GLAccounts.FIND('-') THEN BEGIN
            repeat
                Message := Message + GLAccounts."No." + ' ::' + GLAccounts.Name + ' :::';
            until GLAccounts.Next = 0;
        END
    end;

    procedure GetPRNHeaderDetails(PurchaseNo: Text) Message: Text
    begin
        PurchaseRN.Reset();
        PurchaseRN.SETRANGE(PurchaseRN."No.", PurchaseNo);
        IF PurchaseRN.FIND('-') THEN BEGIN
            Message := FORMAT(PurchaseRN."Expected Receipt Date");
        END
    end;

    procedure PRNApprovalRequest(ReqNo: Text)
    var
        ApprovalMgmtExt: Codeunit "Approvals Mgmt.";
    begin
        PurchaseRN.Reset();
        PurchaseRN.SETRANGE(PurchaseRN."No.", ReqNo);
        IF PurchaseRN.FIND('-')
        THEN BEGIN
            ApprovalMgmtExt.CheckPurchaseApprovalPossible(PurchaseRN);
            ApprovalMgmtExt.OnSendPurchaseDocForApproval(PurchaseRN);
        END;
    end;

    procedure CancelPrnApprovalRequest(ReqNo: Text)
    var
        ApprovalMgmtExt: Codeunit "Approvals Mgmt.";
    begin
        PurchaseRN.Reset();
        PurchaseRN.SETRANGE(PurchaseRN."No.", ReqNo);
        IF PurchaseRN.FIND('-')
        THEN BEGIN
            ApprovalMgmtExt.OnCancelPurchaseApprovalRequest(PurchaseRN);
        END;
    end;

    procedure RemovePurchaseLine(LineNo: Integer)
    begin
        PurchaseLines.Reset();
        PurchaseLines.SETRANGE(PurchaseLines."Line No.", LineNo);
        IF PurchaseLines.FIND('-') THEN BEGIN
            PurchaseLines.DELETE;
            MESSAGE('Line Deleted Successfully');
        END;
    end;

    procedure RemoveStoreReqLine(LineNo: Integer)
    begin
        StoreReqLines.Reset();
        StoreReqLines.SETRANGE(StoreReqLines."Line No.", LineNo);
        IF StoreReqLines.FIND('-') THEN BEGIN
            StoreReqLines.DELETE;
            MESSAGE('Line Deleted Successfully');
        END;
    end;

    procedure CancelStoreRequisition(ReqNo: Text)
    var
        ApprovalMgmtExt: Codeunit "Approval Workflows V1";
        variant: Variant;
    begin
        StoreRequisition.Reset();
        StoreRequisition.SETRANGE(StoreRequisition."No.", ReqNo);
        IF StoreRequisition.FIND('-')
        THEN BEGIN
            variant := StoreRequisition;
            ApprovalMgmtExt.OnCancelDocApprovalRequest(variant);
        END;
    end;

    procedure GetStoreItems(postinggroup: Code[20]) Message: Text
    begin
        Items.Reset();
        Items.SETRANGE(Items."Inventory Posting Group", postinggroup);
        Items.SETFILTER(Items.Description, '<>%1', '');
        IF Items.FIND('-') THEN BEGIN
            repeat
                Message := Message + Items."No." + ' ::' + Items.Description + ' :::';
            until Items.Next = 0;
        END
    end;

    procedure GetReqPostingGroup(ReqNo: Text) Msg: Text
    begin
        StoreRequisition.Reset();
        StoreRequisition.SETRANGE(StoreRequisition."No.", ReqNo);
        IF StoreRequisition.FIND('-')
        THEN BEGIN
            Msg := StoreRequisition."Inventory Posting Group";
        END;
    end;

    procedure InsertStoreRequisitionLines(ReqNo: Code[30]; ItemNo: Code[30]; ItemDesc: Text; Amount: Decimal; LineAmount: Decimal; Qty: Decimal; UnitOfMsre: Code[10]; IStore: Code[30]) rtnMsg: Text
    var
        seq: Integer;
        lines: Record "PROC-Store Requistion Lines";
    begin
        lines.Reset;
        lines.SetCurrentKey("Line No.");
        if lines.Findlast() then begin
            Seq := lines."Line No." + 1;
        end else begin
            seq := 1;
        end;
        StoreReqLines.Reset();
        StoreReqLines."Requistion No" := ReqNo;
        StoreReqLines."Line No." := Seq;
        StoreReqLines.Validate("Requistion No");
        StoreReqLines.Type := StoreReqLines.Type::Item;
        StoreReqLines."No." := ItemNo;
        StoreReqLines.Description := ItemDesc;
        StoreReqLines."Unit Cost" := Amount;
        StoreReqLines."Line Amount" := LineAmount;
        StoreReqLines.Quantity := Qty;
        StoreReqLines."Unit of Measure" := UnitOfMsre;
        StoreReqLines."Issuing Store" := IStore;
        StoreReqLines.Validate("Requistion No");
        StoreReqLines.Validate(Quantity);
        StoreReqLines.Insert();
        StoreReqLines.Validate(Quantity);

        rtnMsg := 'SUCCESS' + '::';
    end;

    #endregion

    #region Evaluation
    procedure CheckStaffNoInOpening(StaffNo: Code[20]): Text
    var
        Committee: Record "Proc-Committee Membership";
        Header: Record "Proc-Purchase Quote Header";
        JArray: JsonArray;
        JObj: JsonObject;
        JsTxt: Text;
    begin
        Committee.Reset();
        FindCommitteeReleased(StaffNo, Committee);
        Committee.SetRange("Opening Done", Committee."Opening Done"::Initiated);
        Committee.SetRange("Opening Confirmed", false);
        if Committee.FindSet() then begin
            repeat
                FindHeaderReleased(Committee."No.", Header);
                Clear(JObj);
                JObj.Add('ProcurmentMethod', Format(Header."Procurement methods"));
                JObj.Add('No', Header."No.");
                JArray.Add(JObj);
            until Committee.Next() = 0;
        end;
        JArray.WriteTo(JsTxt);
        exit(JsTxt);
    end;

    procedure CheckStaffNoInEvaluation(StaffNo: Code[20]): Text
    var
        Committee: Record "Proc-Committee Membership";
        Header: Record "Proc-Purchase Quote Header";
        JArray: JsonArray;
        JObj: JsonObject;
        JsTxt: Text;
    begin
        FindCommitteeReleased(StaffNo, Committee);
        Committee.SetRange("Opening Done", Committee."Opening Done"::Initiated);
        Committee.SetRange("Opening Confirmed", false);
        if Committee.FindSet() then begin
            repeat
                FindHeaderReleased(Committee."No.", Header);
                //Add Evaluation type and the Tendor type and no
                Clear(JObj);
                JObj.Add('ProcurmentMethod', Format(Header."Procurement methods"));
                JObj.Add('No', Header."No.");
                JArray.Add(JObj);
            until Committee.Next() = 0;
        end;
        JArray.WriteTo(JsTxt);
        exit(JsTxt);
    end;

    procedure GetHeaderDetails(No: Code[20]): Text
    var
        Header: Record "Proc-Purchase Quote Header";
        JObj: JsonObject;
        JsTxt: Text;
    begin
        Header.Reset();
        Header.SETRANGE("No.", No);
        if Header.FindSet() then begin
            repeat
                JObj.Add('No', Header."No.");
                JObj.Add('ProcurementMethod', Format(Header."Procurement methods"));
                JObj.Add('ExpectedOpening Date', Header."Expected Opening Date");
                JObj.Add('ExpectedClosing Date', Header."Expected Closing Date");
                JObj.Add('CategoryDescription', Header."Category Description");
                JObj.Add('HasEvaluation', Format(Header."Has Evaluation"));
            until Header.Next() = 0;
        end;
        JObj.WriteTo(JsTxt);
        exit(JsTxt);
    end;

    procedure GetLineDetails(No: Code[20]): Text
    var
        Line: Record "Proc-Purchase Quote Line";
        JObj: JsonObject;
        JsTxt: Text;
        JArray: JsonArray;
    begin
        Line.Reset();
        Line.SETRANGE(Line."Document No.", No);
        if Line.FindSet() then begin
            repeat
                Clear(JObj);
                JObj.Add('No', Line."No.");
                JObj.Add('Description', Line.Description);
                JObj.Add('Quantity', Line.Quantity);
                JObj.Add('UnitofMeasure', Line."Unit of Measure");
                JObj.Add('UnitCost', Line."Unit Cost");
                JObj.Add('LineAmount', Line."Line Amount");
                JArray.Add(JObj);
            until Line.Next() = 0;
        end;
        JArray.WriteTo(JsTxt);
        exit(JsTxt);
    end;

    procedure SubmitOpening(StaffNo: Code[25]; DocumentNo: Code[20]; Comments: Text): Boolean
    var
        Committee: Record "Proc-Committee Membership";
        Header: Record "Proc-Purchase Quote Header";
    begin
        Committee.Reset();
        Committee.SETRANGE(Committee."Staff No.", StaffNo);
        Committee.SetRange("No.", DocumentNo);
        Committee.SetRange("Committee Type", Committee."Committee Type"::"Opening Commitee");
        Committee.SetRange("Initiate Opening", Committee."Initiate Opening"::"Initiate Opening");
        if Committee.FindSet() then begin
            FindHeaderReleased(DocumentNo, Header);
            if not header.IsEmpty then begin
                Committee."Opening Confirmed" := true;
                Committee.Comments := Comments;
                if Committee.Modify() then
                    exit(true);
            end;
        end;

    end;

    procedure GetSubmittedOpening(StaffNo: Code[25]): Text
    var
        Committee: Record "Proc-Committee Membership";
        Header: Record "Proc-Purchase Quote Header";
        JArray: JsonArray;
        JObj: JsonObject;
        JsTxt: Text;
    begin
        FindCommitteeReleased(StaffNo, Committee);
        Committee.SetRange("Initiate Opening", Committee."Initiate Opening"::"Initiate Opening");
        if Committee.FindSet() then begin
            repeat
                FindHeaderReleased(Committee."No.", Header);
                Clear(JObj);
                JObj.Add('No', Header."No.");
                JObj.Add('ProcurementMethod', Format(Header."Procurement methods"));
                //Comments
                JObj.Add('Comments', Committee.Comments);
                //Date Opened
                JObj.Add('DateOpened', Format(Committee."Date Opened"));
                JArray.Add(JObj);
            until Committee.Next() = 0;
        end;
        JArray.WriteTo(JsTxt);
        exit(JsTxt);
    end;

    procedure FindHeaderReleased(No: Code[20]; var Header: Record "Proc-Purchase Quote Header")
    begin
        Header.Reset();
        Header.SETRANGE("No.", No);
        Header.SETRANGE(Status, Header.Status::Released);
        if Header.FindSet() then;
    end;

    procedure FindCommitteeReleased(StaffNo: Code[20]; var Committee: Record "Proc-Committee Membership")
    begin
        Committee.Reset();
        Committee.SETRANGE(Committee."Staff No.", StaffNo);
        if Committee.FindSet() then;
    end;
    #endregion
    #region Security
    procedure RegisterGuest(name: Text; reason: Text; idno: Code[20]; phoneno: Code[20]; vehicleregno: Code[20]; timein: Time; isStaff: Boolean) msg: boolean
    var
        Guest: Record "Guest Registration";
    begin
        Guest.Init;
        Guest."Visitor Name" := name;
        Guest."Reason for Visit" := reason;
        Guest."Vehicle Plate Number" := vehicleregno;
        Guest."Time In" := timein;
        Guest."Is Staff" := isStaff;
        Guest."ID No" := idno;
        Guest."Date" := Today;
        Guest."Phone No" := phoneno;
        Guest.Insert(true);
        msg := true;
    end;

    procedure RegisterVehicleOutMovement(vehicleno: Code[20]; destination: Text; timeout: Time; mileageout: integer; driver: Text; gateofficer: Text) msg: boolean
    var
        VehicleMovement: Record "Vehicle Daily Movement";
    begin
        VehicleMovement.Init;
        VehicleMovement."Vehicle No." := vehicleno;
        VehicleMovement.Destination := destination;
        VehicleMovement."Time Out" := timeout;
        VehicleMovement."Milage Out" := mileageout;
        VehicleMovement."Drivers Name" := driver;
        VehicleMovement."Gate Officer" := gateofficer;
        VehicleMovement."Date Out" := Today;
        VehicleMovement.Insert(true);
        msg := true;
    end;

    procedure RegisterVehicleInMovement(entryno: integer; datein: Date; timein: Time; milagein: integer) msg: boolean
    var
        VehicleMovement: Record "Vehicle Daily Movement";
    begin
        VehicleMovement.Reset;
        VehicleMovement.SetRange("Entry No.", entryno);
        if VehicleMovement.Find('-') then begin
            VehicleMovement."Date In" := datein;
            VehicleMovement."Time In" := timein;
            VehicleMovement."Milage In" := milagein;
            VehicleMovement.Modify(true);
            msg := true;
        end;
    end;

    procedure GetTodayGuests() msg: Text
    var
        Guest: Record "Guest Registration";
        JObj: JsonObject;
        JsTxt: Text;
        JArray: JsonArray;
    begin
        Guest.Reset();
        Guest.SETRANGE("Date", Today);
        if Guest.FindSet() then begin
            repeat
                Clear(JObj);
                JObj.Add('EntryNo', Guest."Entry No.");
                JObj.Add('Name', Guest."Visitor Name");
                JObj.Add('IDNo', Guest."ID No");
                JObj.Add('PhoneNo', Guest."Phone No");
                JObj.Add('VehicleRegNo', Guest."Vehicle Plate Number");
                JObj.Add('TimeIn', Format(Guest."Time In"));
                if Guest."Time Out" <> 0T then
                    JObj.Add('TimeOut', Format(Guest."Time Out"))
                else
                    JObj.Add('TimeOut', '');
                JObj.Add('Reason', Guest."Reason for Visit");
                JObj.Add('IsStaff', FORMAT(Guest."Is Staff"));
                JArray.Add(JObj);
            until Guest.Next() = 0;
        end;
        JArray.WriteTo(JsTxt);
        msg := JsTxt;
    end;

    procedure GetVehicleMovemengt() msg: Text
    var
        VehicleMovement: Record "Vehicle Daily Movement";
        JObj: JsonObject;
        JsTxt: Text;
        JArray: JsonArray;
    begin
        VehicleMovement.Reset();
        if VehicleMovement.FindSet() then begin
            repeat
                Clear(JObj);
                JObj.Add('EntryNo', VehicleMovement."Entry No.");
                JObj.Add('Driver', VehicleMovement."Drivers Name");
                JObj.Add('Destination', VehicleMovement."Destination");
                JObj.Add('MilageIn', VehicleMovement."Milage In");
                JObj.Add('MilageOut', VehicleMovement."Milage Out");
                JObj.Add('VehicleRegNo', VehicleMovement."Vehicle No.");
                JObj.Add('GateOfficer', VehicleMovement."Gate Officer");
                JObj.Add('TimeOut', Format(VehicleMovement."Time Out"));
                JObj.Add('DateOut', Format(VehicleMovement."Date Out"));
                if VehicleMovement."Time In" <> 0T then
                    JObj.Add('TimeIn', Format(VehicleMovement."Time In"))
                else
                    JObj.Add('TimeIn', '');
                if VehicleMovement."Date In" <> 0D then
                    JObj.Add('DateIn', Format(VehicleMovement."Date In"))
                else
                    JObj.Add('DateIn', '');
                JArray.Add(JObj);
            until VehicleMovement.Next() = 0;
        end;
        JArray.WriteTo(JsTxt);
        msg := JsTxt;
    end;

    procedure MarkGuestTimeOut(entryNo: Integer; timeout: Time) msg: Boolean
    var
        Guest: Record "Guest Registration";
    begin
        Guest.Reset;
        Guest.SetRange("Entry No.", entryNo);
        if Guest.Find('-') then begin
            Guest."Time Out" := timeout;
            Guest.Modify;
            msg := true;
        end;
    end;

    procedure IncidenceReport(accused: Text; accuser: Text; accusedphone: code[20]; accusedId: Code[20]; accusedresidence: Text; natureofcase: Text; category: option; accusedtype: option; forwardedto: option; description: Text) msg: Boolean
    var
        IncidentReport: Record "Incident Report";
    begin
        IncidentReport.Init;
        IncidentReport."Accused Name" := accused;
        IncidentReport."Victim/Reporting Party" := accuser;
        IncidentReport."Accused Phone Number" := accusedphone;
        IncidentReport."Accused ID Number" := accusedId;
        IncidentReport."Accused Residence" := accusedresidence;
        IncidentReport."Nature of Case" := natureofcase;
        IncidentReport.Category := category;
        IncidentReport."Accused Type" := accusedtype;
        IncidentReport."Forwarded To" := forwardedto;
        IncidentReport."Case Summary Desctiption" := description;
        IncidentReport."Date Reported" := Today;
        IncidentReport.Status := IncidentReport.Status::Open;
        IncidentReport.Insert(true);
        msg := true;
    end;

    procedure GetIncidentsReported() msg: Text
    var
        IncidentReport: Record "Incident Report";
        JObj: JsonObject;
        JsTxt: Text;
        JArray: JsonArray;
    begin
        IncidentReport.Reset();
        IncidentReport.SetCurrentKey("Date Reported");
        IncidentReport.Ascending(false);
        if IncidentReport.FindSet() then begin
            repeat
                Clear(JObj);
                JObj.Add('CaseNo', IncidentReport."Case No.");
                JObj.Add('AccusedName', IncidentReport."Accused Name");
                JObj.Add('AccuserName', IncidentReport."Victim/Reporting Party");
                JObj.Add('AccusedPhoneNo', IncidentReport."Accused Phone Number");
                JObj.Add('AccusedIdNo', IncidentReport."Accused ID Number");
                JObj.Add('AccusedResidence', IncidentReport."Accused Residence");
                JObj.Add('NatureofCase', IncidentReport."Nature of Case");
                JObj.Add('Category', Format(IncidentReport.Category));
                JObj.Add('AccusedType', Format(IncidentReport."Accused Type"));
                JObj.Add('ForwardedTo', Format(IncidentReport."Forwarded To"));
                JObj.Add('Description', IncidentReport."Case Summary Desctiption");
                JObj.Add('DateReported', Format(IncidentReport."Date Reported"));
                JObj.Add('Status', Format(IncidentReport.Status));
                JArray.Add(JObj);
            until IncidentReport.Next() = 0;
        end;
        JArray.WriteTo(JsTxt);
        msg := JsTxt;
    end;
    #endregion
    #region Repair And Maintenance
    procedure RequestRepair(staffno: Code[20]; facility: Code[20]; building: Text; email: Text; phoneno: Text; description: Text) msg: Text
    var
        RepairRequest: Record "Repair Request";
        RepairRequestLines: Record "Repair Request Lines";
        RepairTypes: Record "Type of Repair";
        RepairMaintenance: Record "Maintenance Request";
    begin
        RepairRequest.Init;
        RepairRequest."Facility No." := facility;
        RepairRequest.Validate("Facility No.");
        RepairRequest.Requester := staffno;
        RepairRequest.Validate(Requester);
        RepairRequest."E-mail" := email;
        RepairRequest."Phone No." := phoneno;
        RepairRequest.Location := building;
        RepairRequest."Repair Description" := description;
        RepairRequest."Status" := RepairRequest."Status"::Open;
        RepairRequest.Insert(true);
        msg := RepairRequest."No.";
    end;

    procedure GetRepairRequests(staffno: Code[20]) msg: Text
    var
        RepairRequest: Record "Repair Request";
        JObj: JsonObject;
        JsTxt: Text;
        JArray: JsonArray;
    begin
        RepairRequest.Reset();
        RepairRequest.SetRange(RepairRequest.Requester, staffno);
        RepairRequest.SetCurrentKey("Request Date");
        RepairRequest.Ascending(false);
        if RepairRequest.FindSet() then begin
            repeat
                Clear(JObj);
                JObj.Add('RequestNo', RepairRequest."No.");
                JObj.Add('Facility', RepairRequest."Facility Description");
                JObj.Add('Date Requested', Format(RepairRequest."Request Date"));
                JObj.Add('Status', Format(RepairRequest.Status));
                JArray.Add(JObj);
            until RepairRequest.Next() = 0;
        end;
        JArray.WriteTo(JsTxt);
        msg := JsTxt;
    end;

    procedure GetRepairFacilities() msg: Text
    var
        FA: Record "Fixed Asset";
        JObj: JsonObject;
        JsTxt: Text;
        JArray: JsonArray;
    begin
        FA.Reset();
        FA.SetRange("FA Subclass Code", 'BUILDINGS');
        if FA.FindSet() then begin
            repeat
                Clear(JObj);
                JObj.Add('No', FA."No.");
                JObj.Add('Description', FA.Description);
                JArray.Add(JObj);
            until FA.Next() = 0;
        end;
        JArray.WriteTo(JsTxt);
        msg := JsTxt;
    end;

    procedure GetTypeOfRepair() msg: Text
    var
        RepairType: Record "Type of Repair";
        JObj: JsonObject;
        JsTxt: Text;
        JArray: JsonArray;
    begin
        RepairType.Reset();
        if RepairType.FindSet() then begin
            repeat
                Clear(JObj);
                JObj.Add('No', RepairType."No.");
                JObj.Add('Description', RepairType.Description);
                JArray.Add(JObj);
            until RepairType.Next() = 0;
        end;
        JArray.WriteTo(JsTxt);
        msg := JsTxt;
    end;

    procedure AddRepairRepairLine(reqno: Code[20]; type: Code[20]) msg: Boolean
    var
        RepairLines: Record "Repair Request Lines";
    begin
        RepairLines.Init;
        RepairLines."No." := reqno;
        RepairLines."Repair Types" := type;
        RepairLines.Validate("Repair Types");
        RepairLines.Insert(True);
        msg := true;
    end;

    procedure RemoveRepairLines(lino: Integer) msg: boolean
    var
        RepairLines: Record "Repair Request Lines";
    begin
        RepairLines.Reset();
        RepairLines.SetRange(LineNo, lino);
        if RepairLines.Find('-') then begin
            RepairLines.Delete;
            msg := True
        end;
    end;

    procedure GetRepairLines(reqno: Code[20]) msg: Text
    var
        RepairLines: Record "Repair Request Lines";
        JObj: JsonObject;
        JsTxt: Text;
        JArray: JsonArray;
    begin
        RepairLines.Reset();
        RepairLines.SetRange("No.", reqno);
        if RepairLines.FindSet() then begin
            repeat
                Clear(JObj);
                JObj.Add('LineNo', RepairLines.LineNo);
                JObj.Add('RepairType', RepairLines."Repair Types");
                JObj.Add('Description', RepairLines.Description);
                JArray.Add(JObj);
            until RepairLines.Next() = 0;
        end;
        JArray.WriteTo(JsTxt);
        msg := JsTxt;
    end;

    procedure RepairTypeAdded(reqno: Code[20]) msg: Boolean
    var
        RepairLines: Record "Repair Request Lines";
    begin
        RepairLines.Reset;
        RepairLines.SetRange("No.", reqno);
        if RepairLines.Find('-') then begin
            msg := true;
        end;
    end;

    procedure RepairRequestSubmitted(reqno: Code[20]) msg: Boolean
    var
        RepairRequests: Record "Repair Request";
    begin
        RepairRequests.Reset;
        RepairRequests.SetRange("No.", reqno);
        if RepairRequests.Find('-') then begin
            if RepairRequests.Status <> RepairRequests.Status::Open then
                msg := true;
        end;
    end;

    procedure SubmitRepairRequest(reqno: Code[20]) msg: Boolean
    var
        RepairRequest: Record "Repair Request";
    begin
        RepairRequest.Reset;
        RepairRequest.SetRange("No.", reqno);
        if RepairRequest.Find('-') then begin
            RepairRequest.Status := RepairRequest.Status::Pending;
            RepairRequest.Modify;
            msg := true;
        end;
    end;
    #endregion

    #region Survey
    procedure GetStudentInformation(studNo: Code[20]) msg: Text
    var
        JsonObject: JsonObject;
        JsTxt: Text;
        Customer: Record Customer;
    begin
        Customer.Reset;
        Customer.SetRange("No.", studNo);
        if Customer.Find('-') then begin
            Clear(JsonObject);
            JsonObject.Add('name', Customer.Name);
            JsonObject.Add('image', fnGetCustomerImage(studNo));
            JsonObject.Add('email', Customer."E-Mail");
            JsonObject.Add('no', Customer."No.");
            JsonObject.Add('type', 'student');
            JsonObject.Add('year', GetStudentCurrentYearofStudy(studNo));
            JsonObject.WriteTo(JsTxt);
            msg := JsTxt;
        end;
    end;

    procedure GetStudentCurrentYearofStudy(studNo: Code[20]): integer
    var
        CosReg: Record "ACA-Course Registration";
    begin
        CosReg.Reset;
        CosReg.SetRange("Student No.", studNo);
        CosReg.SetCurrentKey(Stage);
        if CosReg.FindLast() then begin
            exit(CosReg."Year of Study");
        end;
    end;

    procedure fnGetCustomerImage(customerNo: Code[20]) res: Text
    var
        Customer: Record Customer;
        Base64: Codeunit "Base64 Convert";
        Intstream: InStream;
        outstream: OutStream;
        templob: Codeunit "Temp Blob";
    begin
        Customer.RESET;
        Customer.SETRANGE("No.", customerNo);
        if Customer.FINDFIRST then begin
            if Customer.Image.HASVALUE then begin
                templob.CreateOutStream(outstream);
                Customer.Image.ExportStream(outstream);
                templob.CreateInStream(Intstream);
                res := Base64.ToBase64(Intstream);
            end;
        end;
        exit(res);
    end;

    procedure GetStaffInformation(staffNo: Code[20]) msg: Text
    var
        JsonObject: JsonObject;
        JsTxt: Text;
        Employee: Record "HRM-Employee C";
    begin
        Employee.Reset;
        Employee.SetRange("No.", staffNo);
        if Employee.Find('-') then begin
            Clear(JsonObject);
            JsonObject.Add('name', Employee."First Name" + ' ' + Employee."Last Name");
            JsonObject.Add('image', fnGetEmployeeImage(staffNo));
            JsonObject.Add('email', Employee."E-Mail");
            JsonObject.Add('no', Employee."No.");
            JsonObject.Add('type', 'staff');
            JsonObject.Add('year', 0);
            JsonObject.WriteTo(JsTxt);
            msg := JsTxt;
        end;
    end;

    procedure fnGetEmployeeImage(employeeNo: Code[20]) res: Text
    var
        Employee: Record "HRM-Employee C";
        Base64: Codeunit "Base64 Convert";
        Intstream: InStream;
        outstream: OutStream;
    begin
        Employee.RESET;
        Employee.SETRANGE("No.", employeeNo);
        if Employee.FINDFIRST then begin
            employee.CalcFields(Picture);
            if Employee.Picture.HASVALUE then begin
                Employee.Picture.CreateOutStream(outstream);
                Employee.Picture.CreateInStream(Intstream);
                res := Base64.ToBase64(Intstream);
            end;
        end;
        exit(res);
    end;

    procedure ShowStaffMonitoring(StaffNo: Code[20]) msg: Boolean
    var
        Employee: Record "HRM-Employee C";
    begin
        Employee.Reset;
        Employee.SetRange("No.", StaffNo);
        if Employee.Find('-') then begin
            exit(true);
        end;
    end;
    #endregion

    #region Retake
    procedure CheckStudentRetakeUnits(StudNo: Code[20]) msg: Text
    var
    begin

    end;

    procedure GetStudentFirstSuppCount(StudNo: Code[20]): integer
    var
        SuppDetails: Record "Aca-Special Exams Details";
    begin
        SuppDetails.Reset;
        SuppDetails.SetRange("Student No.", StudNo);
        SuppDetails.SetRange(Category, SuppDetails.Category::Supplementary);
        exit(SuppDetails.Count);
    end;

    procedure GetStudentSecondSuppCount(StudNo: Code[20]): integer
    var
        SuppDetails: Record "Aca-2nd Supp. Exams Details";
    begin
        SuppDetails.Reset;
        SuppDetails.SetRange("Student No.", StudNo);
        SuppDetails.SetRange(Category, SuppDetails.Category::Supplementary);
        exit(SuppDetails.Count);
    end;

    procedure IsSecondSuppFailed(StudNo: Code[20]; UnitCode: Code[20]): Boolean
    var
        SuppDetails: Record "Aca-2nd Supp. Exams Details";
    begin
        SuppDetails.Reset;
        SuppDetails.SetRange("Student No.", StudNo);
        SuppDetails.SetRange(Category, SuppDetails.Category::Supplementary);
        SuppDetails.SetRange("Unit Code", UnitCode);
        SuppDetails.SetRange("Exam Marks", FnGetSuppMaxScore(GetStudentUnitProgramme(StudNo, UnitCode), UnitCode, GetStudentUnitStage(StudNo, UnitCode)));
        exit(SuppDetails.Count > 0);
    end;

    procedure GetStudentUnitStage(StudNo: Code[20]; UnitCode: Code[20]): Code[20]
    var
        StdUnits: Record "Aca-Student Units";
    begin
        StdUnits.Reset;
        StdUnits.SetRange("Student No.", StudNo);
        StdUnits.SetRange(Unit, UnitCode);
        if StdUnits.Find('-') then begin
            exit(StdUnits.Stage);
        end;
    end;

    procedure GetStudentUnitProgramme(StudNo: Code[20]; UnitCode: Code[20]): Code[20]
    var
        StdUnits: Record "Aca-Student Units";
    begin
        StdUnits.Reset;
        StdUnits.SetRange("Student No.", StudNo);
        StdUnits.SetRange(Unit, UnitCode);
        if StdUnits.Find('-') then begin
            exit(StdUnits.Programme);
        end;
    end;

    procedure GetStudentUnitsForRetake(StudNo: code[25]) msg: text
    var
        SecondSuppDetails: Record "Aca-2nd Supp. Exams Details";
    begin
        SecondSuppDetails.Reset;
        SecondSuppDetails.SetRange("Student No.", StudNo);
        SecondSuppDetails.SetRange(Category, SecondSuppDetails.Category::Supplementary);
        if SecondSuppDetails.FindSet() then begin
            repeat
                if SecondSuppDetails."Exam Marks" < FnGetSuppMaxScore(GetStudentUnitProgramme(StudNo, SecondSuppDetails."Unit Code"), SecondSuppDetails."Unit Code", GetStudentUnitStage(StudNo, SecondSuppDetails."Unit Code")) then begin
                    msg += SecondSuppDetails."Unit Code" + ' :: ' + SecondSuppDetails."Unit Description" + ' :::';
                end;
            until SecondSuppDetails.Next() = 0;
        end;
        exit(msg);
    end;

    procedure SubmitRetakeExamApplication(stdNo: code[25]; unitCode: Code[20]) Msg: Code[25]
    var
        RetakeExams: Record "Aca-Special Exams Details";
        Sems: Record "ACA-Semesters";
        StudentUnits: Record "Aca-Student Units";
        ApprovalMgmt: Codeunit "Approval Workflows V1";
        variant: Variant;
    begin
        RetakeExams.INIT;
        RetakeExams."Student No." := stdNo;
        RetakeExams.Validate("Student No.");
        RetakeExams."Unit Code" := unitCode;
        RetakeExams.Validate("Unit Code");
        RetakeExams."Created Date/Time" := CurrentDateTime;
        RetakeExams."Status" := RetakeExams."Status"::New;
        RetakeExams.Category := RetakeExams.Category::Retake;
        RetakeExams."Document No." := '';
        if RetakeExams.INSERT(true) then begin
            variant := RetakeExams;
            if ApprovalMgmt.CheckApprovalsWorkflowEnabled(variant) then
                ApprovalMgmt.OnSendDocForApproval(variant);
            exit(RetakeExams."Document No.")
        end
        else
            exit('');
    end;

    procedure LoadBookedRetakes(stdNo: code[25]) msg: Text
    var
        RetakeExams: Record "Aca-Special Exams Details";
    begin
        RetakeExams.Reset;
        RetakeExams.SetRange("Student No.", stdNo);
        RetakeExams.SetRange(Category, RetakeExams.Category::Retake);
        if RetakeExams.FindSet() then begin
            repeat
                msg += RetakeExams."Unit Code" + ' :: ' + RetakeExams."Unit Description" + ' :::';
            until RetakeExams.Next() = 0;
        end;
        exit(msg);
    end;
    #endregion

    #region Graduation
    procedure ApplyForCertificate()
    begin

    end;
    #endregion
    #region SecondSupp
    procedure Load2ndSuppUnits(stdNo: Code[20]) msg: Text
    var
        SecondSuppDetails: Record "Aca-2nd Supp. Exams Details";
    begin
        SecondSuppDetails.Reset;
        SecondSuppDetails.SetRange("Student No.", stdNo);
        SecondSuppDetails.SetRange(Category, SecondSuppDetails.Category::Supplementary);
        if SecondSuppDetails.FindSet() then begin
            repeat
                msg += SecondSuppDetails."Unit Code" + ' :: ' + SecondSuppDetails."Unit Description" + ' :::';
            until SecondSuppDetails.Next() = 0;
        end;
        exit(msg);
    end;

    procedure Confirm2ndSupUnit(StdNo: Code[20]; unit: Code[20]) Message: Text
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        LectLoadBatch: Record "Lect Load Batch Lines";
        Balance: Decimal;
        GenSetup: Record "General Ledger Setup";
        StudentCard: Record Customer;
        CurrentSem: Record "ACA-Semesters";
        SecondSuppDetails: Record "Aca-2nd Supp. Exams Details";
    begin
        begin
            Clear(Balance);

            CurrentSem.Reset;
            SecondSuppDetails.Reset;
            SecondSuppDetails.SetRange("Student No.", StdNo);
            SecondSuppDetails.SetRange("Unit Code", unit);
            SecondSuppDetails.SetRange(Category, SecondSuppDetails.Category::Supplementary);
            SecondSuppDetails.SetRange(Status, SecondSuppDetails.Status::New);
            if SecondSuppDetails.Find('-') then begin
                StudentCard.Reset;
                StudentCard.SetRange("No.", StdNo);
                if StudentCard.FindFirst then begin
                    GenSetup.Get();
                    StudentCard.CalcFields(Balance);
                    Balance := StudentCard.Balance;
                    if isStudentNFMLegible(StdNo) then
                        Balance := getNfmBalance(StdNo);
                    if (Balance <= 0) /* or (Abs(StudentCard.Balance) >= Abs(GenSetup."Supplimentary Fee")) */ then begin
                        SecondSuppDetails.Status := SecondSuppDetails.Status::Approved;
                        SecondSuppDetails.Validate(Status);
                        SecondSuppDetails.Modify;
                        Message := 'SUCCESS: Supplementary successfully confirmed';
                    end else begin
                        Error('Please PAY For your Supplementary');
                    end;
                end else begin
                    Error('Student not found');
                end;
                //end student search
                //END  ELSE Message:='FAILED: Supplementary not confirmed';
            end;
        end;
    end;

    Procedure GetConfirm2ndSupUnit(StdNo: Code[20]) Msg: Text
    var
        SecondSuppDetails: Record "Aca-2nd Supp. Exams Details";
    begin
        SecondSuppDetails.Reset;
        SecondSuppDetails.SetRange("Student No.", StdNo);
        SecondSuppDetails.SetRange(Status, SecondSuppDetails.Status::Approved);
        if SecondSuppDetails.Find('-') then begin
            Msg += SecondSuppDetails."Unit Code" + ' :: ' + SecondSuppDetails."Unit Description" + ' :::';
        end;
        exit(Msg);
    end;
    #endregion



}


