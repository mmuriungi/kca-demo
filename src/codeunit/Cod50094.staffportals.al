codeunit 50094 staffportals
{
    trigger OnRun()
    begin
        SendLeaveForApproval('LV000599');
    end;

    var
        examResultsBuffer: Record "ACA-Exam Results Buffer 2";
        EmployeeCard: Record "HRM-Employee C";
        LeaveLE: Record "HRM-Leave Ledger";
        LeaveT: Record "HRM-Leave Requisition";
        HRLeave: Record "HRM-Leave Requisition";
        ltype: Record "HRM-Leave Types";
        HRSetup: Record "HRM-Setup";
        HRMEmployeeD: Record "HRM-Employee C";
        SupervisorCard: Record "User Setup";
        ApprovalMgmtExt: Codeunit "Approvals Mgmt.";
        ApprovalMgmtHr: Codeunit Intcodeunit;
        PurchaseRN: Record "Purchase Header";
        PurchaseLines: Record "Purchase Line";
        ClaimRequisition: Record "FIN-Staff Claims Header";
        PRLPeriodTransactions: Record "PRL-Period Transactions";
        StoreRequisition: Record "PROC-Store Requistion Header";
        StoreReqLines: Record "PROC-Store Requistion Lines";
        ImprestRequisition: Record "FIN-Imprest Header";
        ApproverComments: Record "Approval Comment Line";
        ImprestReqLines: Record "FIN-Imprest Lines";
        ClaimReqLines: Record "FIN-Staff Claim Lines";
        P9: Record "PRL-Employee P9 Info";
        RecAccountusers: Record "Online Recruitment users";
        JobApplications: Record "HRM-Job Applications (B)";
        ApplicantQualifications: Record "HRM-Applicant Qualifications";
        NextJobapplicationNo: Code[20];
        dates: Record Date;
        SDate: Date;
        EndLeave: Boolean;
        varDaysApplied: Decimal;
        fReturnDate: Date;
        DayCount: Integer;
        tableNo: Integer;
        State: Option Open,Pending,Approval,Cancelled,Approved,"Pending Approval";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        BaseCalendar: Record "Base Calendar Change";
        ApprovalEntry: Record "Approval Entry";
        ApprovalEntry_2: Record "Approval Entry";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Approvals: Codeunit "Approval Workflow Setup Mgt.";
        TXTCorrectDetails: Label 'Login';
        TXTIncorrectDetails: Label 'Incorrect Username or Password';
        FILESPATH_S: Label 'C:\inetpub\wwwroot\StaffPortal\Downloads\';
        FILESPATH_EPROC: Label 'C:\inetpub\wwwroot\SuppliersPortalLive\Downloads\';
        Text004: Label 'Approval Setup not found.';
        TblCustomer: Record Customer;
        daysInteger: Integer;
        NextLeaveApplicationNo: Text;
        NextClaimapplicationNo: text;
        NextImprestapplicationNo: Text;
        NextStoreqNo: Text;
        NextVenueBookingNo: Text;
        LastNum: Text;
        SupervisorId: Text;
        EmployeeUserId: Text;
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
        Eorigin: Option;
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
        filename: Text;
        IStream: InStream;
        Bytes: DotNet Bytes;
        Convert: DotNet Convert;
        MemStream: DotNet MemoryStream;
        ExamResults: Record "ACA-Exam Results";
        ExamsSetup: Record "ACA-Exams Setup";
        UnitSubjects: Record "ACA-Units/Subjects";
        Programme: Record "ACA-Programme";
        programstages: Record "ACA-Programme Stages";
        semesters: Record "ACA-Programme Semesters";
        AcademicYr: Record "ACA-Academic Year";
        DimensionValue: Record "Dimension Value";
        CurrentSem: Record "ACA-Semesters";
        StudentUnitBaskets: Record "ACA-Student Units Reservour";
        StudentUnits: Record "ACA-Student Units";
        CourseRegistration: Record "ACA-Course Registration";
        ACALecturersUnits: Record "ACA-Lecturers Units";
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        // AcaSpecialExamsResults: Record "Aca-Special Exams Results";
        ACAExamResults: Record "ACA-Exam Results";
        tblTenders: Record "Tender Header";
        tblBidder: Record "Tender Applicants Registration";
        tblTenderBids: Record "Tender Submission Header";
        tblTenderBidFinReq: Record "Tender Bidder Fin Reqs";
        Vendors: Record Vendor;
        tblTenderLines: Record "Tender Lines";

        PartTimeClaimHd: Record "Parttime Claim Header";
        PartTimeClaimLn: Record "Parttime Claim Lines";
        AcaSpecialExamsResults: Record "Aca-Special Exams Results";
        MeetingsInfo: Record MeetingsInfo;
        MeetingAttendees: Record MeetingAtendees;
        MeetingAgendas: Record MeeingAgenda;
        fleetRequisition: Record "FLT-Transport Requisition";
        stdClearance: Record "Student Clerance";
    // Staff Portal Functions
    procedure GetDepartmentGraduationClearance(hod: Code[20]) msg: Text
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange("No.", hod);
        if EmployeeCard.Find('-') then begin
            stdClearance.Reset;
            stdClearance.SetRange("Department Code", EmployeeCard."Department Code");
            stdClearance.SetRange("Department Cleared", false);
            stdClearance.SetCurrentKey("Student No");
            if stdClearance.Find('-') then begin
                repeat
                    stdClearance.SETRANGE("Student No", stdClearance."Student No");
                    stdClearance.FIND('+');
                    stdClearance.SETRANGE("Student No");
                    msg += stdClearance."Clearance No" + '::' + stdClearance."Student No" + '::' + stdClearance."Student Name " + ':::';
                until stdClearance.Next = 0;
            end;
        end;
    end;

    procedure GetSchoolGraduationClearance(hod: Code[20]) msg: Text
    begin
        EmployeeCard.Reset;
        EmployeeCard.SetRange("No.", hod);
        if EmployeeCard.Find('-') then begin
            stdClearance.Reset;
            stdClearance.SetRange(School, EmployeeCard."Faculty Code");
            stdClearance.SetRange("School Cleared", false);
            stdClearance.SetCurrentKey("Student No");
            if stdClearance.Find('-') then begin
                repeat
                    stdClearance.SETRANGE("Student No", stdClearance."Student No");
                    stdClearance.FIND('+');
                    stdClearance.SETRANGE("Student No");
                    msg += stdClearance."Clearance No" + '::' + stdClearance."Student No" + '::' + stdClearance."Student Name " + ':::';
                until stdClearance.Next = 0;
            end;
        end;
    end;

    procedure ClearDepartmentGraduation(clrNo: Code[20]; staffno: code[20]) cleared: Boolean
    begin
        stdClearance.Reset;
        stdClearance.SetRange("Clearance No", clrNo);
        if stdClearance.Find('-') then begin
            stdClearance."Department Cleared" := true;
            stdClearance."Department Cleared Name" := GetFullNames(staffno);
            stdClearance.Modify;
            cleared := true;
        end;
    end;

    procedure ClearSchoolGraduation(clrNo: Code[20]; staffno: code[20]) cleared: Boolean
    begin
        stdClearance.Reset;
        stdClearance.SetRange("Clearance No", clrNo);
        if stdClearance.Find('-') then begin
            stdClearance."School Cleared" := true;
            stdClearance."School Cleared Name" := GetFullNames(staffno);
            stdClearance.Modify;
            cleared := true;
        end;
    end;

    procedure TransportRequisition(empNo: Code[20]; destination: Text; tripdate: Date; timeout: Time; duration: Text; passengers: Integer; purpose: Text) msg: Text
    var
        NxtReqNo: Code[20];
    begin
        NxtReqNo := NoSeriesMgt.GetNextNo('TRANSP', 0D, TRUE);
        EmployeeCard.Reset;
        EmployeeCard.SetRange("No.", empNo);
        if EmployeeCard.Find('-') then begin
            fleetRequisition.Init;
            fleetRequisition."Transport Requisition No" := NxtReqNo;
            fleetRequisition."Emp No" := empNo;
            fleetRequisition."Department Code" := EmployeeCard."Department Code";
            fleetRequisition.Designation := EmployeeCard."Job Title";
            fleetRequisition."Requested By" := UserID;
            fleetRequisition.Status := fleetRequisition.Status::"Pending Approval";
            fleetRequisition."Approval Stage" := fleetRequisition."Approval Stage"::"Head of Department";
            fleetRequisition."Date of Request" := Today;
            fleetRequisition."Date of Trip" := tripdate;
            fleetRequisition.Destination := destination;
            fleetRequisition."Time Out" := timeout;
            fleetRequisition."Duration to be Away" := duration;
            fleetRequisition."No Of Passangers" := passengers;
            fleetRequisition."Purpose of Trip" := purpose;
            fleetRequisition.Insert;
            msg := NxtReqNo;
        end;
    end;

    procedure GetMyTripRequisitions(empNo: Code[20]) msg: Text
    begin
        fleetRequisition.Reset;
        fleetRequisition.SetRange("Emp No", empNo);
        if fleetRequisition.Find('-') then begin
            repeat
                msg += fleetRequisition."Transport Requisition No" + '::' + fleetRequisition."Purpose of Trip" + '::' + fleetRequisition.Destination + '::' + format(fleetRequisition."No Of Passangers") + '::' + format(fleetRequisition."Date of Request") + '::' + format(fleetRequisition."Date of Trip") + '::' + format(fleetRequisition."Status") + '::' + format(fleetRequisition."Approval Stage") + ':::';
            until fleetRequisition.Next = 0;
        end;
    end;

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

    procedure CheckStaffLogin(username: Code[20]; userpassword: Text[50]) ReturnMsg: Text[200];
    begin
        EmployeeCard.Reset();
        EmployeeCard.SetRange(EmployeeCard."No.", username);
        if (EmployeeCard.Find('-')) then begin
            FullNames := GetFullName(EmployeeCard."No.");//EmployeeCard."First Name" + ' ' + EmployeeCard."Middle Name" + ' ' + EmployeeCard."Last Name";
            if (EmployeeCard.Status = 0) then begin
                if (EmployeeCard."Changed Password" = true) then begin
                    if (EmployeeCard."Portal Password" = userpassword) then begin
                        ReturnMsg := 'SUCCESS' + '::' + Format(EmployeeCard."Changed Password") + '::' + EmployeeCard."No." + '::' + FullNames;
                    end else begin
                        ReturnMsg := 'Invalid Password' + '::' + Format(EmployeeCard."Changed Password") + '::' + EmployeeCard."No." + '::' + FullNames;
                    end
                end else begin
                    if (EmployeeCard."Portal Password" = userpassword) then begin
                        ReturnMsg := 'SUCCESS' + '::' + Format(EmployeeCard."Changed Password") + '::' + EmployeeCard."No." + '::' + FullNames;
                    end else begin
                        ReturnMsg := 'Invalid Password' + '::' + Format(EmployeeCard."Changed Password");
                    end
                end
            end else begin
                ReturnMsg := 'Your Account Status Is Inactive. Please Contact Administrator.' + '::';
            end
        end else begin
            ReturnMsg := 'Invalid Staff Number' + '::';
        end

    end;

    procedure CheckStaffLoginForUnchangedPass(Username: Code[20]; password: Text[50]) ReturnMsg: Text[200];
    begin
        EmployeeCard.Reset();

        EmployeeCard.SetRange(EmployeeCard."No.", Username);
        //EmployeeCard.SetRange(EmployeeCard."Portal Password", password);
        if (EmployeeCard.Find('-')) then begin
            if (EmployeeCard.Status = 0) then begin
                ReturnMsg := 'SUCCESS' + '::' + EmployeeCard."No." + '::' + EmployeeCard."Company E-Mail";
            end else begin
                ReturnMsg := 'Your Account Status Is Inactive. Please Contact Administrator.' + '::';
            end

        end
        else begin
            ReturnMsg := 'Invalid Password' + '::'
        end

    end;

    procedure UpdateStaffPass(username: Code[30]; genpass: Text) ReturnMsg: Text[200];
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            EmployeeCard."Portal Password" := genpass;
            EmployeeCard."Changed Password" := TRUE;
            EmployeeCard.Modify();
            ReturnMsg := 'SUCCESS' + '::';
        END
    end;

    procedure VerifyCurrentPassword(username: Code[20]; oldpass: Text[100]) ReturnMsg: Text[200];
    begin
        EmployeeCard.Reset();
        EmployeeCard.SetRange(EmployeeCard."No.", username);
        EmployeeCard.SetRange(EmployeeCard."Portal Password", oldpass);

        if (EmployeeCard.Find('-')) then begin
            ReturnMsg := 'SUCCESS' + '::';
        end
    end;

    procedure ChangeStaffPassword(username: Code[30]; password: Text) ReturnMsg: Text[200];
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            EmployeeCard."Portal Password" := password;
            EmployeeCard."Changed Password" := TRUE;
            EmployeeCard.Modify();
            ReturnMsg := 'SUCCESS' + '::';
        END;
    end;

    procedure CheckStaffPasswordChanged(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            IF (EmployeeCard."Changed Password" = TRUE) THEN BEGIN
                Message := 'SUCCESS' + '::' + FORMAT(EmployeeCard."Changed Password");
            END ELSE BEGIN
                Message := 'FAILED' + '::' + FORMAT(EmployeeCard."Changed Password");
            END
        END ELSE BEGIN
            Message := 'FAILED' + '::';
        END
    end;

    procedure CheckValidStaffNo(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := 'SUCCESS' + '::';
        END ELSE BEGIN
            Message := 'FAILED' + '::';
        END
    end;

    procedure GetStaffProfileDetails(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."ID Number" + '::' + EmployeeCard.Citizenship + '::' + EmployeeCard."Postal Address" + '::' +
  EmployeeCard."Job Title" + '::' + EmployeeCard."Company E-Mail" + '::' + FORMAT(EmployeeCard.Title) + '::' + FORMAT(EmployeeCard."Date Of Birth") + '::' + FORMAT(EmployeeCard.Gender) + '::' + EmployeeCard."Cellular Phone Number" + '::' + FORMAT(EmployeeCard.Title);

        END
    end;

    procedure GetSemesters() Message: Text
    begin
        CurrentSem.Reset();
        IF CurrentSem.FIND('-') THEN BEGIN
            REPEAT
                Message += CurrentSem.Code + '::';
            UNTIL CurrentSem.NEXT = 0;
        END
    end;

    procedure GetPartTimeClaims(username: Code[30]) Message: Text
    begin
        PartTimeClaimHd.Reset();
        PartTimeClaimHd.SETRANGE(PartTimeClaimHd."Account No.", username);
        IF PartTimeClaimHd.FIND('-') THEN BEGIN
            REPEAT
                Message += PartTimeClaimHd."No." + '::' + PartTimeClaimHd.Semester + '::' + PartTimeClaimHd.Purpose + '::' + FORMAT(PartTimeClaimHd.Status) + ':::';
            UNTIL PartTimeClaimHd.NEXT = 0;
        END
    end;

    procedure AddPartTimeClaimLine(claimno: code[20]; progcode: code[20]; unitcode: code[20]; invigilationdone: Boolean) added: Boolean
    var
        lineNo: integer;
    begin
        PartTimeClaimLn.reset();
        IF PartTimeClaimLn.FIND('+') THEN
            lineNo := PartTimeClaimLn."Line No." + 1
        ELSE
            lineNo := 1;
        PartTimeClaimLn.Init();
        PartTimeClaimHd.Reset();
        PartTimeClaimHd.SETRANGE(PartTimeClaimHd."No.", claimno);
        IF PartTimeClaimHd.FIND('-') THEN BEGIN
            PartTimeClaimLn."Line No." := lineNo;
            PartTimeClaimLn."Document No." := PartTimeClaimHd."No.";
            PartTimeClaimLn.Semester := PartTimeClaimHd.Semester;
            PartTimeClaimLn."Academic Year" := PartTimeClaimHd."Academic Year";
            PartTimeClaimLn."Lecture No." := PartTimeClaimHd."Account No.";
            Programme.Reset();
            Programme.SetRange(Programme.Code, progcode);
            if Programme.find('-') then begin
                PartTimeClaimLn.Programme := Programme.Code;
                PartTimeClaimLn."Programme Description" := Programme.Description;
            end;
            ACALecturersUnits.Reset();
            ACALecturersUnits.SetRange(ACALecturersUnits.Unit, unitcode);
            if ACALecturersUnits.find('-') then begin
                PartTimeClaimLn.Unit := ACALecturersUnits.Unit;
                PartTimeClaimLn."Unit Description" := ACALecturersUnits.Description;
            end;
            PartTimeClaimLn."Invigillation Done" := invigilationdone;
            PartTimeClaimLn.Validate(Programme);
            PartTimeClaimLn.Validate(Unit);
            PartTimeClaimLn.Validate("Invigillation Done");
            PartTimeClaimLn.Insert();
            added := TRUE;
        END;
    END;

    procedure GetPartTimeClaimLines(claimno: code[20]) Message: Text
    begin
        PartTimeClaimLn.reset();
        PartTimeClaimLn.SETRANGE(PartTimeClaimLn."Document No.", claimno);
        IF PartTimeClaimLn.FIND('-') THEN begin
            repeat
                Message += FORMAT(PartTimeClaimLn."Line No.") + '::' + PartTimeClaimLn.Semester + '::' + PartTimeClaimLn."Academic Year" + '::' + PartTimeClaimLn."Programme Description" + '::' + PartTimeClaimLn."Unit Description" + '::' + FORMAT(PartTimeClaimLn."Hours Done") + '::' + FORMAT(PartTimeClaimLn.Amount) + ':::';
            UNTIL PartTimeClaimLn.Next = 0;
        end;
    END;

    procedure DeletePartTimeClaimLine(claimno: code[20]; lineno: integer) deleted: boolean
    begin
        PartTimeClaimLn.reset();
        PartTimeClaimLn.SETRANGE(PartTimeClaimLn."Document No.", claimno);
        PartTimeClaimLn.SETRANGE(PartTimeClaimLn."Line No.", lineno);
        IF PartTimeClaimLn.FIND('-') THEN begin
            PartTimeClaimLn.Delete();
            DELETED := true;
        end;
    END;

    procedure GetLecturerUnits(lectno: code[20]; progcode: code[20]; sem: code[20]) Message: Text
    begin
        ACALecturersUnits.Reset();
        ACALecturersUnits.SetRange(ACALecturersUnits.Lecturer, lectno);
        ACALecturersUnits.SetRange(ACALecturersUnits.Programme, progcode);
        ACALecturersUnits.SetRange(ACALecturersUnits.Semester, sem);
        if ACALecturersUnits.find('-') then begin
            repeat
                Message += ACALecturersUnits.Unit + '::' + ACALecturersUnits.Description + ':::';
            until ACALecturersUnits.next = 0;
        end;
    END;

    procedure CreatePartTimeClaim(username: Code[30]; sem: Code[20]; rCenter: code[20]; payMode: option; purpose: Text; releaseDate: Date) Message: Text
    Var
        ClaimNo: Text;
    begin
        ClaimNo := NoSeriesMgt.GetNextNo('PRTCM', 0D, TRUE);
        PartTimeClaimHd.Init();
        EmployeeCard.SETRANGE("No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            PartTimeClaimHd."No." := ClaimNo;
            PartTimeClaimHd."Account No." := EmployeeCard."No.";
            PartTimeClaimHd."Global Dimension 1 Code" := 'MAIN';
            PartTimeClaimHd."Global Dimension 2 Code" := EmployeeCard."Department Code";
            PartTimeClaimHd.payee := EmployeeCard."Full Name";
            PartTimeClaimHd.Date := Today;
            PartTimeClaimHd.Semester := sem;
            PartTimeClaimHd."Responsibility Center" := rCenter;
            PartTimeClaimHd."Pay Mode" := payMode;
            PartTimeClaimHd.Purpose := purpose;
            PartTimeClaimHd."Payment Release Date" := releaseDate;
            CurrentSem.Reset();
            CurrentSem.SETRANGE(CurrentSem.Code, sem);
            IF CurrentSem.FIND('-') THEN BEGIN
                PartTimeClaimHd."Academic Year" := CurrentSem."Academic Year";
                PartTimeClaimHd."Semester Start Date" := CurrentSem.From;
                PartTimeClaimHd."Semester End Date" := CurrentSem."To";
            END;
            PartTimeClaimHd.Insert();
            message := ClaimNo;
        END
    end;

    procedure CancelLeaveApplication(appno: Text) cancelled: Boolean
    begin
        LeaveT.Reset();
        LeaveT.SETRANGE(LeaveT."No.", appno);
        IF LeaveT.FIND('-') THEN BEGIN
            LeaveT.Status := LeaveT.Status::Cancelled;
            LeaveT.Modify;
            cancelled := true;
        END
    end;

    procedure GetStaffMail(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."Company E-Mail" + '::';
        END
    end;

    procedure GetProfilePicture(StaffNo: Text) BaseImage: Text
    var
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", StaffNo);

        IF EmployeeCard.FIND('-') THEN BEGIN
            IF EmployeeCard.Picture.HASVALUE THEN BEGIN
                EmployeeCard.CALCFIELDS(Picture);
                EmployeeCard.Picture.CREATEINSTREAM(InStr);
                BaseImage := cnv64.ToBase64(InStr, true);
            END;
        END;
    end;

    procedure GetCurrentPassword(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."Portal Password" + '::';
        END
    end;

    procedure GenerateLeaveStatement(StaffNo: Text; filenameFromApp: Text)
    begin
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", StaffNo);

        IF EmployeeCard.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(51176, filename, EmployeeCard);
        END
    end;

    procedure GetStaffDetails(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."ID Number" + '::' + EmployeeCard.Citizenship + '::' + EmployeeCard."Postal Address" + '::' +
  EmployeeCard."Job Title" + '::' + EmployeeCard."Company E-Mail" + '::' + FORMAT(EmployeeCard.Title) + '::' + FORMAT(EmployeeCard."Date Of Birth");

        END
    end;

    procedure GetStaffGender(username: Code[30]) Message: Text
    begin
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := FORMAT(EmployeeCard.Gender) + '::' + EmployeeCard."Cellular Phone Number";

        END
    end;

    procedure GeneratePaySlipReport(EmployeeNo: Text; Period: Date; filenameFromApp: Text) filename: Text[100]
    var
        PRLSalaryCard: Record "PRL-Salary Card";
    begin
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        /*PRLSalaryCard.RESET;
        PRLSalaryCard.SETRANGE(PRLSalaryCard."Employee Code", EmployeeNo);
        PRLSalaryCard.SETRANGE(PRLSalaryCard."Payroll Period", Period);

        IF PRLSalaryCard.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(Report::"Individual Payslips 2", filename, PRLSalaryCard);
        END;*/
        HRMEmployeeD.Reset();
        HRMEmployeeD.SETRANGE(HRMEmployeeD."No.", EmployeeNo);
        HRMEmployeeD.SetRange(HRMEmployeeD."Period Filter2", Period);
        IF HRMEmployeeD.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(Report::PayslipTest, filename, HRMEmployeeD);
        END;
        EXIT(filename);
    end;

    procedure Generatep9Report(SelectedPeriod: Integer; EmployeeNo: Text; filenameFromApp: Text) filename: Text[100]
    var
        Dfilter: Text;
    begin
        //Dfilter := '0101' + FORMAT(SelectedPeriod) + '..' + '1231' + FORMAT(SelectedPeriod);
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        //MESSAGE('OK');
        HRMEmployeeD.Reset();
        HRMEmployeeD.SETRANGE(HRMEmployeeD."P9 Period", SelectedPeriod);
        HRMEmployeeD.SETRANGE(HRMEmployeeD."No.", EmployeeNo);

        IF HRMEmployeeD.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(Report::"P9 Report (Final)", filename, HRMEmployeeD);
        END;
        EXIT(filename);
    end;

    procedure Generatep9ReportNew(SelectedPeriod: Integer; EmployeeNo: Text; filenameFromApp: Text) filename: Text[100]
    begin
        filename := FILESPATH_S + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        //MESSAGE('OK');
        P9.Reset();
        P9.SETRANGE(P9."Period Year", SelectedPeriod);
        P9.SETRANGE(P9."Employee Code", EmployeeNo);
        IF P9.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(report::"P9 Report (Final)", filename, P9);
        END;
        EXIT(filename);
    end;

    procedure ApproveDocument(DocumentNo: Text; DocumentType: Text)
    var
        //Doc Type = LEAVE, IMPREST, STORE, CLAIM, PRN

        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        leaveR: Record "HRM-Leave Requisition";
        imprestH: Record "FIN-Imprest Header";
        storeH: Record "PROC-Store Requistion Header";
        claimH: Record "FIN-Staff Claims Header";
        prnH: Record "Purchase Header";
    begin
        CASE DocumentType of
            'LEAVE':
                begin
                    leaveR.Reset();
                    leaveR.SetRange("No.", DocumentNo);
                    if leaveR.FindFirst() then
                        ApprovalsMgmt.ApproveRecordApprovalRequest(leaveR.RecordId);
                end;
            'IMPREST':
                begin
                    imprestH.Reset();
                    imprestH.SetRange("No.", DocumentNo);
                    if imprestH.FindFirst() then
                        ApprovalsMgmt.ApproveRecordApprovalRequest(imprestH.RecordId);
                end;
            'STORE':
                begin
                    storeH.Reset();
                    storeH.SetRange("No.", DocumentNo);
                    if storeH.FindFirst() then
                        ApprovalsMgmt.ApproveRecordApprovalRequest(storeH.RecordId);
                end;
            'CLAIM':
                begin
                    claimH.Reset();
                    claimH.SetRange("No.", DocumentNo);
                    if claimH.FindFirst() then
                        ApprovalsMgmt.ApproveRecordApprovalRequest(claimH.RecordId);
                end;
            'PRN':
                begin
                    prnH.Reset();
                    prnH.SetRange("No.", DocumentNo);
                    if prnH.FindFirst() then
                        ApprovalsMgmt.ApproveRecordApprovalRequest(prnH.RecordId);
                end;
        END;
    end;


    procedure RejectDocument(DocumentNo: Text; ApproverID: Text)
    var
    // ApprovalEntryProc: Record "Approval Entry-proc";
    begin
        // ApprovalEntryProc.SETRANGE(ApprovalEntryProc."Document No.", DocumentNo);
        // ApprovalEntryProc.SETRANGE(ApprovalEntryProc."Approver ID", ApproverID);

        // IF ApprovalEntryProc.FIND('-') THEN
        //     REPEAT
        //         IF NOT ApprovalSetup.GET THEN
        //             ERROR(Text004);

        //         AppMgt.RejectApprovalRequest(ApprovalEntryProc);

        //     UNTIL ApprovalEntryProc.NEXT = 0;
    end;

    procedure CancelDocument(DocumentNo: Text; SenderID: Text)
    begin
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
        ApprovalEntry.SETRANGE(ApprovalEntry."Sender ID", SenderID);

        IF ApprovalEntry.FIND('-') THEN
            REPEAT
            //AppMgt.CancelApproval(ApprovalEntry);
            UNTIL ApprovalEntry.NEXT = 0;
    end;

    procedure CancelApprovalRequest(ReqNo: Text)
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", ReqNo);
        IF ApprovalEntry.FIND('-') THEN BEGIN
            ApprovalEntry.DELETE;
            PurchaseRN.Reset();
            PurchaseRN.SETRANGE(PurchaseRN."No.", ReqNo);
            IF PurchaseRN.FIND('-') THEN BEGIN
                PurchaseRN.Status := PurchaseRN.Status::Open;
                PurchaseRN.Modify();
            END;
        END;
    end;

    procedure AvailableLeaveDays(EmployeeNo: Text; LeaveType: Text) availabledays: Text
    begin
        CLEAR(availabledays);
        CLEAR(daysInteger);
        LeaveLE.Reset();
        LeaveLE.SETRANGE(LeaveLE."Employee No", EmployeeNo);
        LeaveLE.SETRANGE(LeaveLE."Leave Type", LeaveType);
        //LeaveLE.SETRANGE(LeaveLE."Leave Period",Year);
        IF LeaveLE.FIND('-') THEN
            REPEAT
            BEGIN
                daysInteger := daysInteger + LeaveLE."No. of Days"
                // availabledays:=FORMAT(LeaveLE."No. of Days");
            END;
            UNTIL LeaveLE.NEXT = 0;
        availabledays := FORMAT(daysInteger);
    end;

    procedure HRLeaveApplication(EmployeeNo: Text; LeaveType: Text; AppliedDays: Decimal; StartDate: Date; EndDate: Date; ReturnDate: Date; SenderComments: Text; Reliever: Text; RelieverName: Text) successMessage: Text
    begin
        LeaveT.INIT;
        HRSetup.GET;
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('LEAVE', 0D, TRUE);
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", EmployeeNo);

        IF EmployeeCard.FIND('-')
        THEN BEGIN
            LeaveT."User ID" := EmployeeCard."User ID";
            EmployeeUserId := EmployeeCard."User ID";
            LeaveT."Employee No" := EmployeeNo;
            LeaveT."Employee Name" := EmployeeCard.FullName;
            LeaveT."Department Code" := EmployeeCard."Department Code";
            LeaveT."Responsibility Center" := EmployeeCard."Responsibility Center";
            SupervisorCard.Reset();
            SupervisorCard.SETRANGE(SupervisorCard."User ID", EmployeeCard."User ID");
            IF SupervisorCard.FIND('-')
            THEN BEGIN
                SupervisorId := SupervisorCard."Approver ID";
            END;
        END;
        LeaveT."Reliever No." := Reliever;
        LeaveT."Reliever Name" := RelieverName;
        LeaveT."No." := NextLeaveApplicationNo;
        LeaveT."Leave Type" := LeaveType;
        LeaveT.VALIDATE("Leave Type");
        LeaveT."Applied Days" := AppliedDays;
        LeaveT.Date := TODAY;
        LeaveT."Starting Date" := StartDate;
        LeaveT."End Date" := EndDate;
        LeaveT."Return Date" := ReturnDate;
        LeaveT.Purpose := SenderComments;
        LeaveT."No. Series" := 'LEAVE';
        LeaveT.Status := HRLeave.Status::Open;
        LeaveT.INSERT;
        //send request for approval
        LeaveT.Reset();
        LeaveT.SETRANGE(LeaveT."No.", NextLeaveApplicationNo);
        IF LeaveT.FIND('-')
        THEN BEGIN
            ApprovalMgmtHr.IsLeaveEnabled(LeaveT);
            ApprovalMgmtHr.OnSendLeavesforApproval(LeaveT);
        end
    end;

    procedure SendLeaveForApproval(LeaveApplicationNo: Text) send: boolean;
    begin
        LeaveT.Reset();
        LeaveT.SETRANGE(LeaveT."No.", NextLeaveApplicationNo);
        IF LeaveT.FIND('-')
        THEN BEGIN
            if (ApprovalMgmtHr.IsLeaveEnabled(LeaveT) = true) THEN begin
                ApprovalMgmtHr.OnSendLeavesforApproval(LeaveT);
                send := true;
            end;
        end
    end;

    procedure HRCancelLeaveApplication(LeaveApplicationNo: Text)
    begin
        LeaveT.Reset();
        LeaveT.SETRANGE(LeaveT."No.", LeaveApplicationNo);

        IF LeaveT.FIND('-') THEN BEGIN
            //ApprovalMgmtHr.OnCancelLeaveApplicationForApproval(LeaveT);
        END;


        ApprovalEntry.Reset();
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", LeaveApplicationNo);

        IF ApprovalEntry.FIND('-') THEN BEGIN
            REPEAT
                ApprovalEntry.Status := ApprovalEntry_2.Status::Canceled;
                ApprovalEntry.Modify();
            UNTIL ApprovalEntry.NEXT = 0
        END;
    end;

    procedure CalcReturnDate(EndDate: Date; "Leave Type": Text) RDate: Date
    begin
        IF ltype.GET("Leave Type") THEN BEGIN
        END;
        RDate := EndDate + 1;
        WHILE DetermineIfIsNonWorking(RDate, "Leave Type") = TRUE DO BEGIN
            RDate := RDate + 1;
        END;
    end;

    procedure ValidateStartDate("Starting Date": Date)
    begin
        dates.Reset();
        dates.SETRANGE(dates."Period Start", "Starting Date");
        dates.SETFILTER(dates."Period Type", '=%1', dates."Period Type"::Date);
        IF dates.FIND('-') THEN
            IF ((dates."Period Name" = 'Sunday') OR (dates."Period Name" = 'Saturday')) THEN BEGIN
                IF (dates."Period Name" = 'Sunday') THEN
                    ERROR('You can not start your leave on a Sunday')
                ELSE
                    IF (dates."Period Name" = 'Saturday') THEN ERROR('You can not start your leave on a Saturday')
            END;

        BaseCalendar.Reset();
        BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendar.SETRANGE(BaseCalendar.Date, "Starting Date");
        IF BaseCalendar.FIND('-') THEN BEGIN
            REPEAT
                IF BaseCalendar.Nonworking = TRUE THEN BEGIN
                    IF BaseCalendar.Description <> '' THEN
                        ERROR('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                    ELSE
                        ERROR('You can not start your Leave on a Holiday');
                END;
            UNTIL BaseCalendar.NEXT = 0;
        END;

        // For Annual Holidays
        BaseCalendar.Reset();
        BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendar.SETRANGE(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
        IF BaseCalendar.FIND('-') THEN BEGIN
            REPEAT
                IF ((DATE2DMY("Starting Date", 1) = BaseCalendar."Date Day") AND (DATE2DMY("Starting Date", 2) = BaseCalendar."Date Month")) THEN BEGIN
                    IF BaseCalendar.Nonworking = TRUE THEN BEGIN
                        IF BaseCalendar.Description <> '' THEN
                            ERROR('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                        ELSE
                            ERROR('You can not start your Leave on a Holiday');
                    END;
                END;
            UNTIL BaseCalendar.NEXT = 0;
        END;
    end;

    procedure CalcEndDate(SDate: Date; LDays: Integer; "Leave Type": Text) LEndDate: Date
    begin
        SDate := SDate;
        EndLeave := FALSE;
        DayCount := 1;
        WHILE EndLeave = FALSE DO BEGIN
            IF NOT DetermineIfIsNonWorking(SDate, "Leave Type") THEN
                DayCount := DayCount + 1;
            SDate := SDate + 1;
            IF DayCount > LDays THEN
                EndLeave := TRUE;
        END;
        LEndDate := SDate - 1;

        WHILE DetermineIfIsNonWorking(LEndDate, "Leave Type") = TRUE DO BEGIN
            LEndDate := LEndDate + 1;
        END;
    end;

    procedure DetermineIfIsNonWorking(VAR bcDate: Date; VAR "Leave Type": Text) ItsNonWorking: Boolean
    begin
        CLEAR(ItsNonWorking);
        HRSetup.FIND('-');
        //One off Hollidays like Good Friday
        BaseCalendar.Reset();
        BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendar.SETRANGE(BaseCalendar.Date, bcDate);
        IF BaseCalendar.FIND('-') THEN BEGIN
            IF BaseCalendar.Nonworking = TRUE THEN
                ItsNonWorking := TRUE;
        END;

        // For Annual Holidays
        BaseCalendar.Reset();
        BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendar.SETRANGE(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
        IF BaseCalendar.FIND('-') THEN BEGIN
            REPEAT
                IF ((DATE2DMY(bcDate, 1) = BaseCalendar."Date Day") AND (DATE2DMY(bcDate, 2) = BaseCalendar."Date Month")) THEN BEGIN
                    IF BaseCalendar.Nonworking = TRUE THEN
                        ItsNonWorking := TRUE;
                END;
            UNTIL BaseCalendar.NEXT = 0;
        END;
        IF ItsNonWorking = FALSE THEN BEGIN
            // Check if its a weekend
            dates.Reset();
            dates.SETRANGE(dates."Period Type", dates."Period Type"::Date);
            dates.SETRANGE(dates."Period Start", bcDate);
            IF dates.FIND('-') THEN BEGIN
                //if date is a sunday
                IF dates."Period Name" = 'Sunday' THEN BEGIN
                    //check if Leave includes sunday
                    ltype.Reset();
                    ltype.SETRANGE(ltype.Code, "Leave Type");
                    IF ltype.FIND('-') THEN BEGIN
                        IF ltype."Inclusive of Sunday" = FALSE THEN ItsNonWorking := TRUE;
                    END;
                END ELSE
                    IF dates."Period Name" = 'Saturday' THEN BEGIN
                        //check if Leave includes sato
                        ltype.Reset();
                        ltype.SETRANGE(ltype.Code, "Leave Type");
                        IF ltype.FIND('-') THEN BEGIN
                            IF ltype."Inclusive of Saturday" = FALSE THEN ItsNonWorking := TRUE;
                        END;
                    END;

            END;
        END;
    end;

    procedure DetermineLeaveReturnDate(fBeginDate: Date; fDays: Decimal; "Leave Type": Text) fReturnDate: Date
    begin
        ltype.Reset();
        IF ltype.GET("Leave Type") THEN BEGIN
        END;
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        REPEAT
            IF DetermineIfIncludesNonWorking("Leave Type") = FALSE THEN BEGIN
                fReturnDate := CALCDATE('1D', fReturnDate);
                IF DetermineIfIsNonWorking(fReturnDate, "Leave Type") THEN BEGIN
                    varDaysApplied := varDaysApplied + 1;
                END ELSE
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied + 1
            END
            ELSE BEGIN
                fReturnDate := CALCDATE('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            END;
        UNTIL varDaysApplied = 0;
        EXIT(fReturnDate);
    end;

    procedure DetermineIfIncludesNonWorking(VAR fLeaveCode: Text): Boolean
    begin
        IF ltype.GET(fLeaveCode) THEN BEGIN
            IF ltype."Inclusive of Non Working Days" = TRUE THEN
                EXIT(TRUE);
        END;
    end;

    procedure GetApprovalStatus(DocumentNo: Text) Message: Text
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
        IF ApprovalEntry.FIND('-') THEN BEGIN
            Message := FORMAT(ApprovalEntry.Status);
        END
    end;

    procedure PurchaseHeaderCreate(BusinessCode: Code[50]; DepartmentCode: Code[50]; ResponsibilityCentre: Code[50]; UserID: Text; Purpose: Text) prnno: Text;
    begin
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('PRN', 0D, TRUE);
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
        PurchaseRN."No. Series" := 'PRN';
        PurchaseRN."Order Date" := TODAY;
        PurchaseRN."Due Date" := TODAY;
        PurchaseRN."Expected Receipt Date" := TODAY;
        PurchaseRN."Posting Description" := Purpose;
        PurchaseRN.INSERT;
        prnno := NextLeaveApplicationNo;
    end;

    procedure GetNextPRNNo() no: Text
    begin
        no := NoSeriesMgt.GetNextNo('PRN', 0D, FALSE);
    end;

    procedure GetNextImpReqNo() no: Text
    begin
        no := NoSeriesMgt.GetNextNo('IMPREQ', 0D, FALSE);
    end;

    procedure SubmitPurchaseLine(DocumentType: Integer; DocumentNo: Text; FunctionNo: Code[50]; LocationID: Text; ExpectedDate: Date; FunctionDesc: Text; UnitsOfMeasure: Text; Quantityz: Decimal)
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
        PurchaseLines.INSERT;
    end;

    procedure GetLastPRNNo(username: Code[30]) Message: Text
    begin
        PurchaseRN.Reset();
        PurchaseRN.SETRANGE(PurchaseRN."Assigned User ID", username);
        IF PurchaseRN.FIND('+') THEN BEGIN
            Message := PurchaseRN."No.";
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
    begin
        PurchaseRN.Reset();
        PurchaseRN.SETRANGE(PurchaseRN."No.", ReqNo);
        IF PurchaseRN.FIND('-')
        THEN BEGIN
            // ApprovalMgmtExt.CheckPurchaseRequisitionApprovalPossible(PurchaseRN);
            ApprovalMgmtExt.OnSendPurchaseDocForApproval(PurchaseRN);
        END;
    end;

    procedure CancelPrnApprovalRequest(ReqNo: Text)
    begin
        PurchaseRN.Reset();
        PurchaseRN.SETRANGE(PurchaseRN."No.", ReqNo);
        IF PurchaseRN.FIND('-')
        THEN BEGIN
            ApprovalMgmtExt.OnCancelPurchaseApprovalRequest(PurchaseRN);
        END;
    end;

    procedure RemoveStoreReqLine(ReqNo: Code[20]; ItemNo: Code[20])
    begin
        StoreReqLines.Reset();
        StoreReqLines.SETRANGE("Requistion No", ReqNo);
        StoreReqLines.SETRANGE("No.", ItemNo);
        IF StoreReqLines.FIND('-') THEN BEGIN
            StoreReqLines.DELETE;
            MESSAGE('Line Deleted Successfully');
        END;
    end;

    procedure RemoveImprestReqLine(ReqNo: Code[20]; AdvanceType: Code[20])
    begin
        ImprestReqLines.Reset();
        ImprestReqLines.SETRANGE(ImprestReqLines.No, ReqNo);
        ImprestReqLines.SETRANGE(ImprestReqLines."Advance Type", AdvanceType);
        IF ImprestReqLines.FIND('-') THEN BEGIN
            ImprestReqLines.DELETE;
            MESSAGE('Line Deleted Successfully');
        END;
    end;

    procedure RemoveClaimReqLine(ReqNo: Code[20]; AdvanceType: Code[20])
    begin
        ClaimReqLines.Reset();
        ClaimReqLines.SETRANGE(ClaimReqLines.No, ReqNo);
        ClaimReqLines.SETRANGE(ClaimReqLines."Advance Type", AdvanceType);
        IF ClaimReqLines.FIND('-') THEN BEGIN
            ClaimReqLines.DELETE;
            MESSAGE('Line Deleted Successfully');
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

    procedure ClaimRequisitionCreate(Campusz: Code[30]; Departmentz: Code[30]; CampusName: Text; DeptName: Text; Rcentre: Code[30]; username: Code[30]; Reason: Text) LastNum: Text
    begin
        ClaimRequisition.INIT;
        NextClaimapplicationNo := NoSeriesMgt.GetNextNo('CLAIM', 0D, TRUE);
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);

        IF EmployeeCard.FIND('-')
        THEN BEGIN
            ClaimRequisition."No." := NextClaimapplicationNo;
            ClaimRequisition.Date := TODAY;
            ClaimRequisition.Payee := EmployeeCard.Names;
            ClaimRequisition."On Behalf Of" := EmployeeCard.Names;
            ClaimRequisition.Posted := FALSE;
            ClaimRequisition."Global Dimension 1 Code" := Campusz;
            ClaimRequisition.Status := ClaimRequisition.Status::Pending;
            ClaimRequisition."Payment Type" := ClaimRequisition."Payment Type"::Imprest;
            ClaimRequisition."Shortcut Dimension 2 Code" := Departmentz;
            ClaimRequisition."Function Name" := CampusName;
            ClaimRequisition."Budget Center Name" := DeptName;
            ClaimRequisition."No. Series" := 'CLAIM';
            ClaimRequisition."Responsibility Center" := Rcentre;
            ClaimRequisition."Account No." := username;
            ClaimRequisition.Purpose := Reason;
            ClaimRequisition.Cashier := username;
            ClaimRequisition.INSERT;
            LastNum := NextClaimapplicationNo;
        END;
    end;

    procedure ClaimRequisitionApprovalRequest(ReqNo: Text)
    begin
        ClaimRequisition.Reset();
        ClaimRequisition.SETRANGE(ClaimRequisition."No.", ReqNo);
        IF ClaimRequisition.FIND('-')
        THEN BEGIN
            //ApprovalMgmtExt.CheckStaffClaimApprovalPossible(ClaimRequisition);
            //ApprovalMgmtExt.OnSendStaffClaimForApproval(ClaimRequisition);
        END;
    end;

    procedure CancelClaimRequisition(ReqNo: Text)
    begin
        ClaimRequisition.Reset();
        ClaimRequisition.SETRANGE(ClaimRequisition."No.", ReqNo);
        IF ClaimRequisition.FIND('-')
        THEN BEGIN
            //ApprovalMgmtExt.OnCancelStaffClaimForApproval(ClaimRequisition);
        END;
    end;

    procedure StoreRequisitionApprovalRequest(ReqNo: Text)
    var
        InitCode: Codeunit "Init Code";
    begin
        StoreRequisition.Reset();
        StoreRequisition.SETRANGE(StoreRequisition."No.", ReqNo);
        IF StoreRequisition.FIND('-')
        THEN BEGIN
            InitCode.OnSendSRNforApproval(StoreRequisition);
        END;
    end;

    procedure CancelStoreRequisition(ReqNo: Text)
    begin
        StoreRequisition.Reset();
        StoreRequisition.SETRANGE(StoreRequisition."No.", ReqNo);
        IF StoreRequisition.FIND('-')
        THEN BEGIN
            //ApprovalMgmtExt.OnCancelStoreRequisitionForApproval(StoreRequisition);
        END;
    end;

    procedure StoresRequisitionCreate(EmployeeNo: Text; UserID: Text; RequiredDate: Date; Purpose: Text; Department: Code[20]; Campus: Code[20]; DepartmentName: Text[250]; CampusName: Text[250]; ReqType: Option; ResponsibilityCentre: Code[10]) LastNum: Text
    begin
        StoreRequisition.INIT;
        NextStoreqNo := NoSeriesMgt.GetNextNo('SRN', TODAY, TRUE);
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", EmployeeNo);

        IF EmployeeCard.FIND('-')
        THEN BEGIN
            StoreRequisition."Requester ID" := UserID;
            SupervisorCard.Reset();
            SupervisorCard.SETRANGE(SupervisorCard."User ID", UserID);
            IF SupervisorCard.FIND('-')
            THEN BEGIN
                SupervisorId := SupervisorCard."Approver ID";
            END;
            //StoreRequisition.INIT;
            //StoreRequisition."Staff No." := EmployeeNo;
            StoreRequisition."No." := NextStoreqNo;
            StoreRequisition."Request date" := TODAY;
            StoreRequisition."Required Date" := RequiredDate;
            StoreRequisition."User ID" := UserID;
            StoreRequisition."Staff No." := UserID;
            StoreRequisition."Requester ID" := UserID;
            StoreRequisition."Request date" := TODAY;
            StoreRequisition."Request Description" := Purpose;
            StoreRequisition."No. Series" := 'STREQ';
            StoreRequisition.Status := StoreRequisition.Status::Open;
            StoreRequisition."Global Dimension 1 Code" := Campus;
            StoreRequisition."Shortcut Dimension 2 Code" := Department;
            StoreRequisition."Function Name" := CampusName;
            StoreRequisition."Budget Center Name" := DepartmentName;
            StoreRequisition."Responsibility Center" := ResponsibilityCentre;
            // StoreRequisition."Issuing Store" := IssueStore;
            StoreRequisition."Store Requisition Type" := ReqType;

            StoreRequisition.INSERT;
            LastNum := NextStoreqNo;
        end
    end;

    procedure ImprestRequisitionApprovalRequest(ReqNo: Text)
    var
        ApprovalMgt2: Codeunit "Init Code";
    begin
        ImprestRequisition.Reset();
        ImprestRequisition.SETRANGE(ImprestRequisition."No.", ReqNo);
        IF ImprestRequisition.FIND('-')
        THEN BEGIN
            ApprovalMgt2.OnSendImprestForApproval(ImprestRequisition);

        END;
    end;

    procedure CancelImprestRequisition(ReqNo: Text)
    var
        ApprovalMgt2: Codeunit "Init Code";
    begin
        ImprestRequisition.Reset();
        ImprestRequisition.SETRANGE(ImprestRequisition."No.", ReqNo);
        IF ImprestRequisition.FIND('-')
        THEN BEGIN
            ApprovalMgt2.OnCancelImprestForApproval(ImprestRequisition);
        END;
    end;

    procedure ImprestRequisitionCreate(Campusz: Code[30]; Departmentz: Code[30]; CampusName: Text; DeptName: Text; RCentre: Code[20]; AccType: Integer; username: Code[30]; Reason: Text) LastNum: Text
    begin
        ImprestRequisition.INIT;
        NextImprestapplicationNo := NoSeriesMgt.GetNextNo('IMPREQ', 0D, TRUE);
        EmployeeCard.Reset();
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);

        IF EmployeeCard.FIND('-')
        THEN BEGIN
            ImprestRequisition."No." := NextImprestapplicationNo;
            ImprestRequisition.Date := TODAY;
            ImprestRequisition.Payee := EmployeeCard.Names;
            ImprestRequisition."On Behalf Of" := EmployeeCard.Names;
            ImprestRequisition.Posted := FALSE;
            ImprestRequisition."Global Dimension 1 Code" := Campusz;
            ImprestRequisition.Status := ImprestRequisition.Status::Pending;
            ImprestRequisition."Payment Type" := ImprestRequisition."Payment Type"::Imprest;
            ImprestRequisition."Shortcut Dimension 2 Code" := Departmentz;
            ImprestRequisition."Function Name" := CampusName;
            ImprestRequisition."Budget Center Name" := DeptName;
            ImprestRequisition."No. Series" := 'IMP';
            ImprestRequisition."Responsibility Center" := RCentre;
            //ImprestRequisition."Account Type" := AccType;
            ImprestRequisition."Account No." := EmployeeCard."No.";
            ImprestRequisition.Purpose := Reason;
            ImprestRequisition.Cashier := username;
            ImprestRequisition."Requested By" := username;
            ImprestRequisition.INSERT;
            LastNum := NextImprestapplicationNo;
        END;
    end;

    procedure InsertApproverComments(DocumentNo: Code[50]; ApproverID: Code[100]; Comments: Text[250])
    begin
        ApproverComments.Reset();

        ApproverComments."Document No." := DocumentNo;
        ApproverComments."User ID" := ApproverID;
        ApproverComments.Comment := Comments;
        ApproverComments."Date and Time" := CURRENTDATETIME;

        ApproverComments.Insert();
    end;

    procedure InsertStoreRequisitionLines(ReqNo: Code[30]; ItemNo: Code[30]; AType: Integer; ItemDesc: Text; Amount: Decimal; LineAmount: Decimal; Qty: Decimal; UnitOfMsre: Code[10]; IStore: Code[30]) rtnMsg: Text
    var
        item: Record Item;
    begin
        item.Reset;
        item.SetRange("No.", ItemNo);
        if item.Find('-') then begin
            item.CalcFields(Inventory);
            if Qty > item.Inventory then
                Error('Requested quantity is greater than the quantity available in store!');
            StoreReqLines.Init;
            StoreReqLines."Requistion No" := ReqNo;
            StoreReqLines.Validate("Requistion No");
            StoreReqLines."No." := ItemNo;
            StoreReqLines.Type := AType;
            StoreReqLines.Description := ItemDesc;
            StoreReqLines."Unit Cost" := Amount;
            StoreReqLines."Line Amount" := LineAmount;
            StoreReqLines.Quantity := Qty;
            StoreReqLines."Qty in store" := item.Inventory;
            StoreReqLines."Unit of Measure" := UnitOfMsre;
            StoreReqLines."Issuing Store" := IStore;
            StoreReqLines.Insert();

            rtnMsg := 'SUCCESS' + '::';
        end;
    end;

    procedure InsertImprestRequisitionLines(ReqNo: Code[20]; Atypes: Code[50]; AccNo: Code[50]; AccName: Code[50]; Amount: Decimal; UserId: Code[50]) rtnMsg: Text
    begin
        ImprestRequisition.Reset();
        ImprestRequisition.SetRange("No.", ReqNo);

        if ImprestRequisition.Find('-') then begin
            ImprestReqLines.Init();
            ImprestReqLines.No := ReqNo;
            ImprestReqLines."Advance Type" := Atypes;
            ImprestReqLines."Shortcut Dimension 2 Code" := ImprestRequisition."Shortcut Dimension 2 Code";
            ImprestReqLines."Account No:" := AccNo;
            ImprestReqLines."Account Name" := AccName;
            ImprestReqLines.Amount := Amount;
            ImprestReqLines."Due Date" := ImprestRequisition.Date;
            ImprestReqLines."Imprest Holder" := UserId;
            ImprestReqLines."Global Dimension 1 Code" := ImprestRequisition."Global Dimension 1 Code";
            ImprestReqLines.Purpose := ImprestRequisition.Purpose;
            ImprestReqLines."Amount LCY" := Amount;

            ImprestReqLines.Insert();

            rtnMsg := 'SUCCESS' + '::';
        end;

    end;

    procedure InsertClaimRequisitionLines(ReqNo: Code[20]; Atypes: Code[50]; AccNo: Code[50]; AccName: Code[50]; Amount: Decimal; UserId: Code[50]) rtnMsg: Text
    begin
        ClaimRequisition.Reset();
        ClaimRequisition.SetRange("No.", ReqNo);

        if ClaimRequisition.Find('-') then begin
            ClaimReqLines.Init();
            ClaimReqLines.No := ReqNo;
            ClaimReqLines."Advance Type" := Atypes;
            ClaimReqLines."Shortcut Dimension 2 Code" := ClaimRequisition."Shortcut Dimension 2 Code";
            ClaimReqLines."Account No:" := AccNo;
            ClaimReqLines."Account Name" := AccName;
            ClaimReqLines.Amount := Amount;
            ClaimReqLines."Due Date" := ClaimRequisition.Date;
            ClaimReqLines."Imprest Holder" := UserId;
            ClaimReqLines."Global Dimension 1 Code" := ClaimRequisition."Global Dimension 1 Code";
            ClaimReqLines.Purpose := ClaimRequisition.Purpose;
            ClaimReqLines."Amount LCY" := Amount;

            ClaimReqLines.Insert();

            rtnMsg := 'SUCCESS' + '::';
        end;
    end;

    procedure TransportRequisitionApprovalRequest(ReqNo: Text)
    begin
        // TransportRequisition.Reset();
        // TransportRequisition.SETRANGE(TransportRequisition."Transport Requisition No", ReqNo);
        // IF TransportRequisition.FIND('-')
        // THEN BEGIN
        //     AppMgt.SendTransportApprovalRequest(TransportRequisition, TransportRequisition."Responsibility Center");
        // END;
    end;

    procedure VenueRequisitionCreate(Department: Code[20]; BookingDate: Date; MeetingDescription: Text[150]; RequiredTime: Time; Venue: Code[20]; ContactPerson: Text[50]; ContactNo: Text[50]; ContactMail: Text[30]; RequestedBy: Text; Pax: Integer)
    begin
        // VenueRequisition.INIT;
        // NextVenueBookingNo := NoSeriesMgt.GetNextNo('VENUE', 0D, TRUE);
        // VenueRequisition."Booking Id" := NextVenueBookingNo;
        // VenueRequisition.Department := Department;
        // VenueRequisition."Request Date" := TODAY;
        // VenueRequisition."Booking Date" := BookingDate;
        // VenueRequisition."Meeting Description" := MeetingDescription;
        // VenueRequisition."Required Time" := RequiredTime;
        // VenueRequisition.Venue := Venue;
        // VenueRequisition."Contact Person" := ContactPerson;
        // VenueRequisition."Contact Number" := ContactNo;
        // VenueRequisition."Contact Mail" := ContactMail;
        // VenueRequisition.Pax := Pax;
        // VenueRequisition.Status := VenueRequisition.Status::"Pending Approval";
        // //VenueRequisition."Department Name":=DepartmentName;
        // VenueRequisition."Requested By" := RequestedBy;
        // VenueRequisition."No. Series" := 'VENUE';
        // //VenueRequisition."Booking Time":= ;

        // VenueRequisition.Insert();
    end;

    procedure CreateRecruitmentAccount(Initialsz: Integer; FirstName: Text; MiddleName: Text; LastName: Text; PostalAddress: Text; PostalCode: Text; IDNumber: Code[30]; Genderz: Integer; HomePhoneNumber: Code[30]; Citizenshipz: Text; MaritalStatus: Integer; EthnicOrigin: Text; Disabledz: Option; DesabilityDetails: Text; DoB: Date; KRAPINNumber: Text; ApplicantType: Integer; EmailAddress: Text; Passwordz: Text; PwdNumber: Text[50]) Message: Text
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", EmailAddress);
        IF NOT RecAccountusers.FIND('-') THEN BEGIN
            RecAccountusers.INIT;

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
            //RecAccountusers.County := Countyz;
            RecAccountusers."Marital Status" := MaritalStatus;
            RecAccountusers."Ethnic Group" := EthnicOrigin;
            RecAccountusers.Disabled := Disabledz;
            RecAccountusers."Disability Details" := DesabilityDetails;
            RecAccountusers."PWD Number" := PwdNumber;
            RecAccountusers."Date of Birth" := DoB;
            //RecAccountusers."Driving License" := DrivingLicense;
            //RecAccountusers."1st Language" := stLanguage;
            //RecAccountusers."2nd Language" := ndLanguage;
            //RecAccountusers."Additional Language" := AdditionalLanguage;
            RecAccountusers."Applicant Type" := ApplicantType;
            RecAccountusers."Email Address" := EmailAddress;
            RecAccountusers.Password := Passwordz;
            RecAccountusers."Created Date" := TODAY;
            RecAccountusers.INSERT;
            IF RecAccountusers.INSERT THEN;
            Message := 'Account Created successfully' + '::' + RecAccountusers.Password;
        END ELSE BEGIN
            Message := 'Warning! We already have account created with the Email address provided.' + '::' + RecAccountusers.Password;
        END
    end;

    procedure ValidRecruitmentEmailAddress(username: Text) Message: Text
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            Message := 'Yes' + '::';
        END ELSE BEGIN
            Message := 'No' + '::';
        END
    end;

    procedure GetRecruitmentEmailAddress(username: Text) Message: Text
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            Message := RecAccountusers."Email Address" + '::';
        END
    end;

    procedure GetCurrentRecruitmentPassword(Username: Text) Message: Text
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", Username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            Message := RecAccountusers.Password + '::';
        END
    end;

    procedure CheckRecruitmentApplicantLogin(username: Text; userpassword: Text) Message: Text
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            IF (RecAccountusers.Password = userpassword) THEN BEGIN
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
                Eorigin := RecAccountusers."Ethnic Origin";
                Disabled := Format(RecAccountusers.Disabled);
                dDetails := RecAccountusers."Disability Details";
                DOB := RecAccountusers."Date of Birth";
                // //          Dlicense:=RecAccountusers."Driving License";		
                KRA := RecAccountusers."KRA PIN Number";
                // //          firstLang	:= RecAccountusers."1st Language";		
                // //          secondLang:=RecAccountusers."2nd Language";			
                // //          AdditionalLang:=RecAccountusers."Additional Language";	 
                ApplicantType := RecAccountusers."Applicant Type";

                Message := TXTCorrectDetails + '::' + RecAccountusers."Email Address" + '::' + RecAccountusers."First Name" + '::' + RecAccountusers."Middle Name" + '::' + RecAccountusers."Last Name" + '::' + FORMAT(RecAccountusers.Initials) + '::' + pAddress + '::' + pCode + '::' + IDNum
                + '::' + FORMAT(RecAccountusers.Gender) + '::' + Phone + '::' + rAddress + '::' + Citizenship + '::' + County + '::' + FORMAT(RecAccountusers."Marital Status") + '::' + FORMAT(RecAccountusers."Ethnic Origin") + '::' + FORMAT(RecAccountusers.Disabled) + '::' + dDetails + '::' + FORMAT(DOB) + '::' + Dlicense
                + '::' + KRA + '::' + firstLang + '::' + secondLang + '::' + AdditionalLang + '::' + FORMAT(RecAccountusers."Applicant Type");
            END ELSE BEGIN
                FullNames := RecAccountusers."First Name" + ' ' + RecAccountusers."Middle Name" + ' ' + RecAccountusers."Last Name";
                Message := TXTIncorrectDetails + '::' + RecAccountusers."Email Address" + '::' + FullNames;
            END
        END
    end;

    procedure SubmitJobApplication(EMail: Text; FirstName: Text; MiddletName: Text; LastName: Text; JobID: Text; JobDescription: Text; RefNo: Text) Message: Text
    begin

        JobApplications.RESET;

        JobApplications.SETRANGE(JobApplications."E-Mail", EMail);
        JobApplications.SETRANGE(JobApplications."Job Applied For", JobID);
        IF NOT JobApplications.FIND('-') THEN BEGIN
            NextJobapplicationNo := NoSeriesMgt.GetNextNo('JOB', 0D, TRUE);

            RecAccountusers.RESET;
            RecAccountusers.SETRANGE(RecAccountusers."Email Address", EMail);
            IF RecAccountusers.FIND('-') THEN BEGIN
                JobApplications.INIT;

                JobApplications."Application No" := NextJobapplicationNo;
                JobApplications."Employee Requisition No" := RefNo;
                JobApplications."Applicant Type" := RecAccountusers."Applicant Type";
                JobApplications.Initials := FORMAT(RecAccountusers.Initials);
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
                JobApplications."Ethnic Origin" := RecAccountusers."Ethnic Origin";
                JobApplications."First Language (R/W/S)" := RecAccountusers."1st Language";
                JobApplications."Driving Licence" := RecAccountusers."Driving License";
                JobApplications.Disabled := RecAccountusers.Disabled;
                JobApplications."Date Of Birth" := RecAccountusers."Date of Birth";
                JobApplications."Second Language (R/W/S)" := RecAccountusers."2nd Language";
                JobApplications."Additional Language" := RecAccountusers."Additional Language";
                JobApplications.Citizenship := RecAccountusers.Citizenship;
                JobApplications."Disabling Details" := RecAccountusers."Disability Details";
                JobApplications."Passport Number" := RecAccountusers."ID Number";
                JobApplications."PIN Number" := RecAccountusers."KRA PIN Number";
                JobApplications."Job Applied For" := JobID;
                JobApplications."Job Applied for Description" := JobDescription;
                JobApplications.Status := JobApplications.Status::"Under Review";
                JobApplications."Date Applied" := TODAY;
                JobApplications."No. Series" := 'JOB';
                //JobApplications.CVPath := MyCVPath;
                //JobApplications."Good Conduct Cert Path" := GoodConductPath;
                JobApplications.INSERT;
                IF JobApplications.INSERT THEN;
                Message := 'SUCCESS' + '::' + JobApplications."Application No";
            END

        END ELSE begin
            Message := 'FAILED' + '::' + JobApplications."Application No";
        end;

    end;

    procedure InsertJobApplicantQualifications(AppNo: Code[30]; QualType: Code[30]; QualCode: Code[30]; Institution: Code[50]; FromDate: Date; ToDate: Date) rtnMsg: Text
    begin
        ApplicantQualifications.Reset();

        ApplicantQualifications.SetRange("Application No", AppNo);
        ApplicantQualifications.SetRange("Qualification Type", QualType);
        ApplicantQualifications.SetRange("Qualification Code", QualCode);

        if not ApplicantQualifications.Find('-') then begin
            ApplicantQualifications.Init();

            ApplicantQualifications."Application No" := AppNo;
            ApplicantQualifications."Qualification Type" := QualType;
            ApplicantQualifications."Qualification Code" := QualCode;
            ApplicantQualifications.Validate("Qualification Code");
            ApplicantQualifications."Institution/Company" := Institution;
            ApplicantQualifications."From Date" := FromDate;
            ApplicantQualifications."To Date" := ToDate;

            ApplicantQualifications.Insert();

            rtnMsg := 'SUCCESS' + '::';
        end else begin
            rtnMsg := 'FAILED' + '::';
        end;
    end;

    procedure SubmitJobApplicationAttachments(AppNo: Code[30]; CvPath: Text; CoverLetterPath: Text) Message: Text
    begin

        JobApplications.RESET;

        JobApplications.SETRANGE(JobApplications."Application No", AppNo);
        IF JobApplications.FIND('-') THEN BEGIN

            // if (JobApplications.Submitted = false) then begin
            //     JobApplications."CV Path" := CvPath;
            //     JobApplications."Cover Letter Path" := CoverLetterPath;
            //     JobApplications.Submitted := true;
            //     JobApplications.Modify();
            //     IF JobApplications.Modify() THEN;
            //     Message := 'SUCCESS' + '::';
            // end else begin
            //     Message := 'FAIL 1' + '::';
            // end



        END ELSE begin
            Message := 'FAIL 2' + '::';
        end
    end;

    procedure RemoveJobQualiReqLine(QualCode: Code[20]; AppNo: Code[20]) rtnMsg: Text
    begin
        ApplicantQualifications.Reset();

        ApplicantQualifications.SetRange("Application No", AppNo);
        ApplicantQualifications.SetRange("Qualification Code", QualCode);

        if ApplicantQualifications.Find('-') then begin
            ApplicantQualifications.DELETE;
            rtnMsg := 'Qualification Deleted Successfully';
        END;
    end;

    procedure LoadAssignedScores(studentNo: Text; unitz: Text; ExamTypez: Text; Semz: Text) Message: Text
    begin
        IF ExamTypez = 'CAT' THEN begin
            ExamResults.RESET;
            ExamResults.SETRANGE(ExamResults."Student No.", studentNo);
            ExamResults.SETRANGE(ExamResults.Unit, unitz);
            ExamResults.SETRANGE(ExamResults.ExamType, ExamTypez);
            ExamResults.SETRANGE(ExamResults.Semester, Semz);
            IF ExamResults.FIND('-') THEN BEGIN
                Message := FORMAT(ExamResults.Score) + '::' + FORMAT(ExamResults."Edit Count");

            END
        END ELSE begin
            ExamResults.RESET;
            ExamResults.SETRANGE(ExamResults."Student No.", studentNo);
            ExamResults.SETRANGE(ExamResults.Unit, unitz);
            //ExamResults.SETRANGE(ExamResults.ExamType, ExamTypez);
            ExamResults.SETRANGE(ExamResults.Semester, Semz);
            IF ExamResults.FIND('-') THEN BEGIN
                ExamResults.SETFILTER(ExamResults.ExamType, '<>%1', 'CAT');
                IF ExamResults.FIND('-') THEN BEGIN
                    Message := FORMAT(ExamResults.Score) + '::' + FORMAT(ExamResults."Edit Count");
                END
            END
        end;
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

    procedure GetResitSemester(prog: Code[30]; stdno: Code[30]; unitcode: Code[30]; academicyr: Code[30]) Message: Text
    begin
        StudentUnits.RESET;
        StudentUnits.SETRANGE(StudentUnits.Programme, prog);
        StudentUnits.SETRANGE(StudentUnits."Student No.", stdno);
        StudentUnits.SETRANGE(StudentUnits.Unit, unitcode);
        StudentUnits.SETRANGE(StudentUnits."Academic Year", academicyr);
        IF StudentUnits.FIND('-') THEN BEGIN
            Message := StudentUnits.Semester;
        END
    end;

    procedure GetResitStage(prog: Code[30]; stdno: Code[30]; unitcode: Code[30]; academicyr: Code[30]) Message: Text
    begin
        StudentUnits.RESET;
        StudentUnits.SETRANGE(StudentUnits.Programme, prog);
        StudentUnits.SETRANGE(StudentUnits."Student No.", stdno);
        StudentUnits.SETRANGE(StudentUnits.Unit, unitcode);
        StudentUnits.SETRANGE(StudentUnits."Academic Year", academicyr);
        IF StudentUnits.FIND('-') THEN BEGIN
            Message := StudentUnits.Stage;
        END
    end;

    procedure SubmitCATMarks(prog: Text; stage: Text; sem: Text; units: Text; StudentNo: Text; CatMark: Decimal; Reg_TransactonID: Text; AcademicYear: Text; username: Text; LectName: Text)
    begin
        ExamResults.RESET;
        ExamResults.SETRANGE(Programmes, prog);
        ExamResults.SETRANGE(Stage, stage);
        ExamResults.SETRANGE(Semester, sem);
        ExamResults.SETRANGE(Unit, units);
        ExamResults.SETRANGE("Student No.", StudentNo);
        ExamResults.SETRANGE(ExamType, 'CAT');
        //ExamResults.SETRANGE("Reg. Transaction ID",Reg_TransactonID);
        IF NOT ExamResults.FIND('-') THEN BEGIN
            ExamResults.INIT;
            ExamResults.Programmes := prog;
            ExamResults.Stage := stage;
            ExamResults.Semester := sem;
            ExamResults.Unit := units;
            ExamResults."Student No." := StudentNo;
            ExamResults.Score := CatMark;
            ExamResults.ExamType := 'CAT';
            ExamResults."Submitted On" := TODAY;
            ExamResults."Last Edited On" := TODAY;
            ExamResults.Exam := 'CAT';
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

    procedure SubmitExamMarks(prog: Text; stage: Text; sem: Text; units: Text; StudentNo: Text; CatMark: Decimal; Reg_TransactonID: Text; AcademicYear: Text; username: Text; LectName: Text)
    begin
        ExamResults.RESET;
        ExamResults.SETRANGE(Programmes, prog);
        ExamResults.SETRANGE(Stage, stage);
        ExamResults.SETRANGE(Semester, sem);
        ExamResults.SETRANGE(Unit, units);
        ExamResults.SETRANGE("Student No.", StudentNo);
        ExamResults.SETRANGE(ExamType, 'EXAM');
        IF ExamResults.FIND('-') THEN BEGIN
            ExamResults.Score := CatMark;
            ExamResults."User Name" := username;
            ExamResults."Lecturer Names" := LectName;
            ExamResults.MODIFY;
        END ELSE BEGIN
            ExamResults.RESET;
            ExamResults.SETRANGE(Programmes, prog);
            ExamResults.SETRANGE(Stage, stage);
            ExamResults.SETRANGE(Semester, sem);
            ExamResults.SETRANGE(Unit, units);
            ExamResults.SETRANGE("Student No.", StudentNo);
            ExamResults.SETRANGE(ExamType, 'FINAL EXAM');
            IF ExamResults.FIND('-') THEN BEGIN
                ExamResults.Score := CatMark;
                ExamResults."User Name" := username;
                ExamResults."Lecturer Names" := LectName;
                ExamResults.MODIFY;
            END ELSE BEGIN
                ExamResults.INIT;
                ExamResults.Programmes := prog;
                ExamResults.Stage := stage;
                ExamResults.Semester := sem;
                ExamResults.Unit := units;
                ExamResults."Student No." := StudentNo;
                ExamResults.Score := CatMark;
                ExamResults.ExamType := 'EXAM';
                ExamResults."Submitted On" := TODAY;
                ExamResults."Last Edited On" := TODAY;
                ExamResults.Exam := 'EXAM';
                ExamResults."Reg. Transaction ID" := Reg_TransactonID;
                ExamResults."User Name" := username;
                ExamResults."Lecturer Names" := LectName;
                IF ExamResults.INSERT THEN;
            END
        END;
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

    procedure GetAcademicYr() Message: Text
    begin
        AcademicYr.RESET;
        AcademicYr.SETRANGE(AcademicYr.Current, TRUE);
        IF AcademicYr.FIND('-') THEN BEGIN
            Message := AcademicYr.Code + '::' + AcademicYr.Description;
        END
    end;

    procedure GetSchool(Prog: Code[20]) SchoolName: Text
    begin
        CLEAR(SchoolName);
        IF Programme.GET(Prog) THEN BEGIN
            DimensionValue.RESET;
            DimensionValue.SETRANGE("Dimension Code", 'FACULTY');
            DimensionValue.SETRANGE(Code, Programme."School Code");
            IF DimensionValue.FIND('-') THEN SchoolName := DimensionValue.Name;
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

    procedure LecturerSpecificTimetables(Semesters: Code[20]; LecturerNo: Code[20]; TimetableType: Text[20]; filenameFromApp: Text[150]) TimetableReturn: Text
    var
        UnitFilterString: Text[1024];
        NoOfLoops: Integer;
        EXTTimetableFInalCollector: Record "ACA-Time Table";
        TTTimetableFInalCollector: Record "ACA-Time Table";
        ACALecturersUnits: Record "ACA-Lecturers Units";
        filename: Text;
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
                    filename := FILESPATH_S + filenameFromApp;
                    IF EXISTS(filename) THEN
                        ERASE(filename);
                    REPORT.SAVEASPDF(74501, filename, TTTimetableFInalCollector);
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
                        filename := FILESPATH_S + filenameFromApp;
                        IF EXISTS(filename) THEN
                            ERASE(filename);
                        REPORT.SAVEASPDF(74551, filename, EXTTimetableFInalCollector);
                    END;
                END;
        END;
    end;

    procedure SubmitSpecialAndSupplementary(StudNo: Code[20]; LectNo: Code[20]; Marks: Decimal; AcademicYear: Code[20]; UnitCode: Code[20]) ReturnMessage: Text[250]
    begin
        CLEAR(ReturnMessage);
        AcaSpecialExamsDetails.RESET;
        AcaSpecialExamsDetails.SETRANGE("Current Academic Year", AcademicYear);
        AcaSpecialExamsDetails.SETRANGE("Student No.", StudNo);
        AcaSpecialExamsDetails.SETRANGE("Unit Code", UnitCode);
        IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
            AcaSpecialExamsResults.RESET;
            AcaSpecialExamsResults.SETRANGE("Current Academic Year", AcademicYear);
            AcaSpecialExamsResults.SETRANGE("Student No.", StudNo);
            AcaSpecialExamsResults.SETRANGE(Unit, UnitCode);
            IF AcaSpecialExamsResults.FIND('-') THEN BEGIN
                AcaSpecialExamsResults.VALIDATE(Score, Marks);
                AcaSpecialExamsResults.UserID := LectNo;
                AcaSpecialExamsResults."Modified Date" := TODAY;
                AcaSpecialExamsResults.category := AcaSpecialExamsDetails.category;
                AcaSpecialExamsResults.MODIFY;
                ReturnMessage := '1'
            END ELSE BEGIN
                AcaSpecialExamsResults.INIT;
                AcaSpecialExamsResults.Programmes := AcaSpecialExamsDetails.Programme;
                AcaSpecialExamsResults.Stage := AcaSpecialExamsDetails.Stage;
                AcaSpecialExamsResults.Unit := UnitCode;
                AcaSpecialExamsResults.Semester := AcaSpecialExamsDetails.Semester;
                AcaSpecialExamsResults."Student No." := AcaSpecialExamsDetails."Student No.";
                AcaSpecialExamsResults."Academic Year" := AcaSpecialExamsDetails."Academic Year";
                AcaSpecialExamsResults."Admission No" := StudNo;
                AcaSpecialExamsResults."Current Academic Year" := AcaSpecialExamsDetails."Current Academic Year";
                AcaSpecialExamsResults.UserID := LectNo;
                AcaSpecialExamsResults."Capture Date" := TODAY;
                AcaSpecialExamsResults.category := AcaSpecialExamsDetails.category;
                AcaSpecialExamsResults.VALIDATE(Score, Marks);
                AcaSpecialExamsResults.INSERT;
                AcaSpecialExamsResults.VALIDATE(Unit);
                ReturnMessage := '1';
            END;
        END;
    end;

    procedure ModifySuppCAT(StudNo: Code[30]; Prog: Code[30]; Unitz: Code[30]; ExamTypez: Code[30]; Scorez: Decimal; LecturerNamez: Code[50]; UserNamez: Code[30]) ReturnMessage: Text
    begin
        ACAExamResults.RESET;
        ACAExamResults.SETRANGE("Student No.", StudNo);
        ACAExamResults.SETRANGE(Programmes, Prog);
        ACAExamResults.SETRANGE(Unit, Unitz);
        ACAExamResults.SETRANGE(ExamType, ExamTypez);
        IF ACAExamResults.FIND('-') THEN BEGIN
            ACAExamResults.Score := Scorez;
            ACAExamResults.VALIDATE(Score);
            ACAExamResults."Lecturer Names" := LecturerNamez;
            ACAExamResults."User Name" := UserNamez;
            //ACAExamResults.UserID := UserNamez;
            ACAExamResults."User Code" := UserNamez;
            ACAExamResults.MODIFY;
            ACAExamResults.VALIDATE(ExamType);
            ReturnMessage := 'Marks Saved Successfully!';
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

    procedure Islecturer(username: Text) Message: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := FORMAT(EmployeeCard.Lecturer);
        END
    end;

    procedure GetHODDepartment(username: Text) Message: Text
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard."Department Code";
        END
    end;

    procedure GetDepartmentProgrammes(dept: Code[20]) Message: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Department, dept);
        IF Programme.FIND('-') THEN BEGIN
            REPEAT
                Message += Programme.Code + '::' + Programme.Description + ':::';
            UNTIL Programme.Next = 0;
        END
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

    procedure GetProgramUnits(progcode: Code[20]; Stage: Code[20]) Message: Text
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE("Programme Code", progcode);
        UnitSubjects.SETRANGE("Stage Code", stage);
        IF UnitSubjects.FIND('-') THEN BEGIN
            REPEAT
                Message += UnitSubjects.Code + ' ::' + UnitSubjects.Desription + ' :::';
            UNTIL UnitSubjects.NEXT = 0;
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

    procedure IsLecTeaching(username: Code[20]) Message: Boolean
    begin
        ACALecturersUnits.RESET;
        ACALecturersUnits.SETRANGE(Lecturer, username);
        IF ACALecturersUnits.FIND('-') THEN BEGIN
            Message := true;
            ;
        END
    end;

    procedure IsLec(username: Code[20]) Message: Boolean
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Message := EmployeeCard.Lecturer;
        END
    end;

    procedure IsHOD(username: Text) Msg: Boolean
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        IF EmployeeCard.FIND('-') THEN BEGIN
            Msg := EmployeeCard.HOD;
        END
    end;

    procedure CreateBidderAccount(CompName: Text; PostalAddress: Text; PostalCode: Text; Location: Text; CompPhone: Text; CompEmail: Text; ContactPerson: Text; ContactPersonPhone: Text; ContactPersonEmail: Text; VatPin: Text; CertificateOfIncorporation: Text; VATCertificate: Text; PinRegistrationCertificate: Text; TaxCompliaceCertificate: Text; Password: Text) Message: Text
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE(tblBidder."No.", VatPin);

        IF NOT tblBidder.FIND('-') THEN BEGIN
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
            tblBidder.INSERT;
            Message := 'SUCCESS' + '::';
        END
        ELSE BEGIN
            Message := 'FAIL' + '::';
        END;
    end;

    procedure CheckBidderLogin(username: Text; userpassword: Text) Message: Text
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE("No.", username);
        IF tblBidder.FIND('-') THEN BEGIN
            IF (tblBidder.Password = userpassword) THEN BEGIN
                FullNames := tblBidder.Name;
                Message := 'Login' + '::' + tblBidder."No." + '::' + FullNames;
            END ELSE BEGIN
                Message := 'Invalid Password';
            END
        END ELSE BEGIN
            Message := 'Invalid Username';
        END
    end;

    procedure GenerateTenderAwardLetter(TenderNo: Code[30]; BidNo: Code[30]; filenameFromApp: Text)
    begin
        filename := FILESPATH_EPROC + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        tblTenderBids.RESET;
        tblTenderBids.SETRANGE(tblTenderBids."No.", BidNo);
        tblTenderBids.SetRange(tblTenderBids."Tender No.", TenderNo);

        IF tblTenderBids.FIND('-') THEN BEGIN
            REPORT.SAVEASPDF(52178801, filename, tblTenderBids);
        END
    end;

    procedure CheckBidderPasswordChanged(username: Code[30]) Message: Text
    begin
        tblBidder.Reset();
        tblBidder.SETRANGE("No.", username);
        IF tblBidder.FIND('-') THEN BEGIN
            IF (tblBidder."Changed Password" = TRUE) THEN BEGIN
                Message := 'Yes' + '::' + FORMAT(tblBidder."Changed Password");
            END ELSE BEGIN
                Message := 'No' + '::' + FORMAT(tblBidder."Changed Password");
            END
        END ELSE BEGIN
            Message := 'No' + '::';
        END
    end;

    procedure CheckValidVendorNo(username: Text) Message: Text
    begin
        Vendors.RESET;
        Vendors.SETRANGE(Vendors."No.", username);
        IF Vendors.FIND('-') THEN BEGIN
            Message := 'Yes' + '::';
        END ELSE BEGIN
            Message := 'No' + '::';
        END
    end;

    procedure InsertTenderBid(BidderNo: Code[30]; TenderNo: Code[30]; TechDocPath: Text; FinDocPath: Text) Message: Text
    var
        NextBidApplicationNo: Text;
    begin
        NextBidApplicationNo := NoSeriesMgt.GetNextNo('BID NO', 0D, TRUE);
        tblTenderBids.RESET;
        tblTenderBids.SETRANGE("Bidder No", BidderNo);
        tblTenderBids.SETRANGE("Tender No.", TenderNo);

        IF NOT tblTenderBids.FIND('-') THEN BEGIN
            tblTenderBids."No." := NextBidApplicationNo;
            tblTenderBids."Bidder No" := BidderNo;
            tblTenderBids."Tender No." := TenderNo;
            tblTenderBids."Bid Status" := tblTenderBids."Bid Status"::Submitted;
            tblTenderBids.Status := tblTenderBids.Status::"Pending Approval";
            tblTenderBids."Technical Proposal Path" := TechDocPath;
            tblTenderBids."Financial Proposal Path" := FinDocPath;
            tblTenderBids."No. Series" := 'BID NO';
            tblTenderBids.INSERT;
            Message := 'SUCCESS' + '::' + NextBidApplicationNo;
        END
        ELSE BEGIN
            Message := 'FAILED' + '::' + NextBidApplicationNo;
        END;
    end;

    procedure InsertQuotedAmount(BidderNo: Code[30]; TenderNo: Code[30]; BidNo: Code[30]; LineCode: Code[30]; Desciption: Text; QuotedValue: Decimal) Message: Text
    begin
        tblTenderBidFinReq.RESET;
        tblTenderBidFinReq.SETRANGE("Tender No.", TenderNo);
        tblTenderBidFinReq.SETRANGE("Bid No.", BidNo);
        tblTenderBidFinReq.SETRANGE("Bidder No.", BidderNo);
        tblTenderBidFinReq.SETRANGE(Code, LineCode);

        IF NOT tblTenderBidFinReq.FIND('-') THEN BEGIN
            tblTenderBidFinReq.Init();
            tblTenderBidFinReq."Tender No." := TenderNo;
            tblTenderBidFinReq."Bid No." := BidNo;
            tblTenderBidFinReq."Bidder No." := BidderNo;
            tblTenderBidFinReq.Description := Desciption;
            tblTenderBidFinReq.Code := LineCode;
            tblTenderBidFinReq."Quoted Amount" := QuotedValue;
            tblTenderBidFinReq.Insert();
            Message := 'SUCCESS: Your bid has been submitted successfully!';
        END;
    end;

    /*procedure IsTenderBiddingPeriodOpened(TenderNo: Code[30]) Message: Text
    begin
        tblTenders.RESET;
        tblTenders.SETRANGE(tblTenders."No.", TenderNo);

        IF tblTenders.FIND('-') THEN BEGIN
            if ((Today < tblTenders."Expected Closing Date")) then begin
                Message := 'Yes';
            end
            else begin
                Message := 'No';
            end;
        END
    end;*/

    procedure GetOpenTenders() Message: Text
    begin
        tblTenders.RESET;
        tblTenders.SETRANGE(tblTenders.Status, tblTenders.Status::Open);

        IF tblTenders.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + tblTenders."No." + ' ::' + tblTenders."Posting Description" + ' ::' + FORMAT(tblTenders."Expected Closing Date") + ' ::' + FORMAT(tblTenders."Expected Opening Date") + ' :::';
            UNTIL tblTenders.NEXT = 0;
        END
    end;

    procedure GetTenderLines(docno: Text) Message: Text
    begin
        tblTenderlines.RESET;
        tblTenderLines.SETRANGE(tblTenderLines."Document No.", docno);
        IF tblTenderLines.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + tblTenderLines."No." + ' ::' + tblTenderLines.Description + ' ::' + FORMAT(tblTenderLines."Unit of Measure") + ' ::' + FORMAT(tblTenderLines.Quantity) + ' :::';
            UNTIL tblTenderLines.NEXT = 0;
        END
    end;

    procedure CheckBidderLoginForUnchangedPass(Username: Code[20]; password: Text[50]) ReturnMsg: Text[200];
    begin
        tblBidder.Reset();

        tblBidder.SetRange(tblBidder."No.", Username);

        if (tblBidder.Find('-')) then begin
            if (tblBidder.Password = password) then begin
                ReturnMsg := 'Login' + '::' + tblBidder."No." + '::' + tblBidder."E-Mail";
            end
            else begin
                ReturnMsg := 'Invalid Password' + '::';
            end;
        end
        else begin
            ReturnMsg := 'Invalid Username' + '::';
        end

    end;

    procedure GetVendorProfileDetails(username: Text) Message: Text
    begin
        Vendors.RESET;
        Vendors.SETRANGE(Vendors."No.", username);
        IF Vendors.FIND('-') THEN BEGIN
            Message := Vendors."E-Mail" + '::' + Vendors."Phone No." + '::' + Vendors.Address + '::' + Vendors."Post Code" + '::' + Vendors.City;

        END
    end;

    procedure ChangeBidderPassword(username: Code[30]; password: Text) ReturnMsg: Text[200];
    begin
        tblBidder.Reset();
        tblBidder.SETRANGE(tblBidder."No.", username);
        IF tblBidder.FIND('-') THEN BEGIN
            tblBidder."Password" := password;
            tblBidder."Changed Password" := TRUE;
            tblBidder.Modify();
            ReturnMsg := 'SUCCESS' + '::';
        END;
    end;

    procedure CheckSubmittedApplication(AppNo: Code[30]) Message: Boolean
    begin
        JobApplications.RESET;
        JobApplications.SETRANGE(JobApplications."Application No", AppNo);
        IF JobApplications.FIND('-') THEN BEGIN
            Message := JobApplications.Submitted;
        end;
    end;

    procedure SubmitJobApplicationNew(EMail: Text; JobID: Text; JobDescription: Text; RefNo: Text) Message: Text
    begin

        JobApplications.RESET;

        JobApplications.SETRANGE(JobApplications."E-Mail", EMail);
        JobApplications.SETRANGE(JobApplications."Job Applied For", JobID);
        JobApplications.SETRANGE(JobApplications."Employee Requisition No", RefNo);
        IF NOT JobApplications.FIND('-') THEN BEGIN

            NextJobapplicationNo := NoSeriesMgt.GetNextNo('JOB', 0D, TRUE);

            RecAccountusers.RESET;
            RecAccountusers.SETRANGE(RecAccountusers."Email Address", EMail);
            IF RecAccountusers.FIND('-') THEN BEGIN
                JobApplications.INIT;

                JobApplications."Application No" := NextJobapplicationNo;
                JobApplications."Employee Requisition No" := RefNo;
                JobApplications."Applicant Type" := RecAccountusers."Applicant Type";
                JobApplications.Initials := FORMAT(RecAccountusers.Initials);
                JobApplications."First Name" := RecAccountusers."First Name";
                JobApplications."Middle Name" := RecAccountusers."Middle Name";
                JobApplications."Last Name" := RecAccountusers."Last Name";
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
                JobApplications.Religion := RecAccountusers.Religion;
                JobApplications.Denomination := RecAccountusers.Denomination;
                JobApplications."Ethnic Origin" := RecAccountusers."Ethnic Origin";
                JobApplications."First Language (R/W/S)" := RecAccountusers."1st Language";
                JobApplications."Driving Licence" := RecAccountusers."Driving License";
                JobApplications.Disabled := RecAccountusers.Disabled;
                JobApplications."Date Of Birth" := RecAccountusers."Date of Birth";
                JobApplications."Second Language (R/W/S)" := RecAccountusers."2nd Language";
                JobApplications."Additional Language" := RecAccountusers."Additional Language";
                JobApplications.Citizenship := RecAccountusers.Citizenship;
                JobApplications."Disabling Details" := RecAccountusers."Disability Details";
                JobApplications."Passport Number" := RecAccountusers."ID Number";
                JobApplications."PIN Number" := RecAccountusers."KRA PIN Number";
                JobApplications."Job Applied For" := JobID;
                JobApplications."Job Applied for Description" := JobDescription;
                JobApplications.Status := JobApplications.Status::"Under Review";
                JobApplications."Date Applied" := TODAY;
                JobApplications."No. Series" := 'JOB';
                //JobApplications.CVPath := MyCVPath;
                //JobApplications."Good Conduct Cert Path" := GoodConductPath;
                JobApplications.INSERT;
                IF JobApplications.INSERT THEN;
                Message := 'SUCCESS' + '::' + JobApplications."Application No";
            END

        END ELSE begin
            Message := 'FAILED' + '::' + JobApplications."Application No";
        end;

    end;

    procedure FnApplicationAttachement(retNo: Code[50]; fileName: Text; attachment: BigText; tableId: Integer) return_value: Boolean
    var
        DocAttachment: Record "Document Attachment";
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
        tableFound: Boolean;
        ObjAppliRec: Record "HRM-Job Applications (B)";

    begin

        tableFound := false;
        return_value := false;
        if TableID = Database::"HRM-Job Applications (B)" then begin
            ObjAppliRec.RESET;
            ObjAppliRec.SETRANGE(ObjAppliRec."Application No", retNo);
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

    procedure SubmitApplication(AppNo: Code[30]) Message: Boolean
    begin
        JobApplications.RESET;
        JobApplications.SETRANGE(JobApplications."Application No", AppNo);
        IF JobApplications.FIND('-') THEN BEGIN
            JobApplications.Submitted := TRUE;
            JobApplications.Modify();
            Message := True;
        end;
    end;

    procedure InsertJobApplicantProfQuals(AppNo: Code[30]; professionalqual: Text; awardingbody: Text; year: Code[10]) rtnMsg: Boolean
    begin
        profQuals.Init();
        profQuals."Application No" := AppNo;
        profQuals."Proffesional Qualification" := professionalqual;
        profQuals."Awarding Body" := awardingbody;
        profQuals."Year Awarded" := year;
        profQuals.Insert();
        rtnMsg := TRUE;
    end;

    procedure InsertJobApplicantWorkExp(AppNo: Code[30]; durations: Integer; organization: Text; position: Text) rtnMsg: Boolean
    begin
        WorkExp.Init();
        WorkExp."Application No" := AppNo;
        WorkExp.Duration := durations;
        WorkExp.Organisation := organization;
        WorkExp.Position := position;
        WorkExp.Insert();
        rtnMsg := TRUE;
    end;

    procedure DeleteJobApplicantReferee(AppNo: Code[30]; name: Text) rtnMsg: Boolean
    begin
        Referees.Reset();
        Referees.SetRange("Job Application No", AppNo);
        Referees.SetRange(Names, name);
        if referees.FIND('-') THEN begin
            Referees.Delete();
            rtnMsg := True;
        end;
    end;

    procedure DeleteJobApplicantQualifications(AppNo: Code[30]; QualType: Code[30]; QualCode: Code[80]) rtnMsg: Boolean
    begin
        ApplicantQualifications.Reset();
        ApplicantQualifications.SetRange("Application No", AppNo);
        ApplicantQualifications.SetRange("Qualification Type", QualType);
        ApplicantQualifications.SetRange("Qualification Description", QualCode);
        if ApplicantQualifications.FIND('-') THEN begin
            ApplicantQualifications.Delete();
            rtnMsg := True;
        end;
    end;

    procedure DeleteJobApplicantProfQual(AppNo: Code[30]; profqual: Text) rtnMsg: Boolean
    begin
        profQuals.Reset();
        profQuals.SetRange("Application No", AppNo);
        profQuals.SetRange(profQuals."Proffesional Qualification", profqual);
        if profQuals.FIND('-') THEN begin
            profQuals.Delete();
            rtnMsg := True;
        end;
    end;

    procedure DeleteJobApplicantWorkExp(AppNo: Code[30]; durations: Integer; organization: Code[30]; position: Code[30]) rtnMsg: Boolean
    begin
        WorkExp.Reset();
        WorkExp.SetRange(WorkExp."Application No", AppNo);
        WorkExp.SetRange(WorkExp.Duration, durations);
        WorkExp.SetRange(WorkExp.Organisation, organization);
        WorkExp.SetRange(WorkExp.Position, position);
        if WorkExp.FIND('-') THEN begin
            WorkExp.Delete();
            rtnMsg := true;
        end;
    end;

    procedure InsertJobApplicantReferee(AppNo: Code[30]; Name: Text; designation: Text; institution: Text; address: Text; phone: Text; email: Text) rtnMsg: Boolean
    begin
        Referees.SetRange("Job Application No", AppNo);
        Referees.SetRange(Names, Name);
        if not Referees.Find('-') then begin
            Referees.Init();
            Referees."Job Application No" := AppNo;
            Referees.Names := Name;
            Referees.Designation := designation;
            Referees.Institution := institution;
            Referees.Address := address;
            Referees."Telephone No" := phone;
            Referees."E-Mail" := email;
            Referees.Insert();
            rtnMsg := TRUE;
        end;
    end;

    procedure GetJobApplicantQualifications(AppNo: Code[30]) rtnMsg: Text
    begin
        ApplicantQualifications.Reset();
        ApplicantQualifications.SetRange("Application No", AppNo);
        if ApplicantQualifications.Find('-') then begin
            REPEAT
                rtnMsg += ApplicantQualifications."Qualification Type" + '::' + ApplicantQualifications."Qualification Description" + '::' + ApplicantQualifications."Institution/Company" + '::' + FORMAT(ApplicantQualifications."From Date") + '::' + FORMAT(ApplicantQualifications."To Date") + ':::';
            UNTIL ApplicantQualifications.NEXT = 0;
        end;
    end;

    procedure GetJobApplicantWorkExp(AppNo: Code[30]) rtnMsg: Text
    begin
        WorkExp.Reset();
        WorkExp.SETRANGE("Application No", AppNo);
        if WorkExp.Find('-') then begin
            repeat
                rtnMsg += FORMAT(WorkExp.Duration) + '::' + WorkExp.Organisation + '::' + WorkExp.Position + ':::';
            UNTIL WorkExp.NEXT = 0;
        end;
    end;

    procedure GetJobApplicantReferees(AppNo: Code[30]) rtnMsg: Text
    begin
        Referees.Reset();
        Referees.SetRange("Job Application No", AppNo);
        if Referees.Find('-') then begin
            REPEAT
                rtnMsg += Referees.Names + '::' + Referees.Designation + '::' + Referees.Institution + '::' + Referees.Address + '::' + Referees."Telephone No" + '::' + Referees."E-Mail" + ':::';
            UNTIL Referees.Next = 0;
        end;
    end;

    procedure GetJobApplicantProfQuals(AppNo: Code[30]) rtnMsg: Text
    begin
        profQuals.Reset();
        profQuals.SetRange("Application No", AppNo);
        if profQuals.Find('-') then begin
            REPEAT
                rtnMsg += profQuals."Proffesional Qualification" + '::' + profQuals."Awarding Body" + '::' + profQuals."Year Awarded" + ':::';
            UNTIL profQuals.Next = 0;
        end;
    end;

    procedure JobApplicantQualificationsCount(AppNo: Code[30]) rtnMsg: Integer
    begin
        ApplicantQualifications.Reset();
        ApplicantQualifications.SetRange("Application No", AppNo);
        if ApplicantQualifications.FIND('-') THEN begin
            repeat
                rtnMsg := rtnMsg + 1;
            until ApplicantQualifications.Next = 0;
        end;
    end;

    procedure CreateJobsAccount(FirstName: Text; MiddleName: Text; LastName: Text; EmailAddress: Text; sessionkey: Text) created: Boolean
    begin
        RecAccountusers.INIT;
        RecAccountusers."First Name" := FirstName;
        RecAccountusers."Middle Name" := MiddleName;
        RecAccountusers."Last Name" := LastName;
        RecAccountusers."Email Address" := EmailAddress;
        RecAccountusers.SessionKey := sessionkey;
        RecAccountusers."Created Date" := TODAY;
        RecAccountusers.INSERT;
        created := true;
    end;

    procedure CheckRecruitmentEmailAddress(username: Text) Message: Boolean
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            Message := TRUE;
        END ELSE BEGIN
            Message := FALSE;
        END
    end;

    procedure CheckConfirmedEmailAddress(username: Text) Message: Boolean
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            Message := RecAccountusers."Account Confirmed";
        END
    end;

    procedure ResetPassword(email: Text; password: Text) Message: Boolean
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", email);
        IF RecAccountusers.FIND('-') THEN BEGIN
            RecAccountusers.Password := password;
            RecAccountusers.MODIFY;
            Message := TRUE;
        END
    end;

    procedure CheckUpdateRecDetails(username: Text) Message: Boolean
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            Message := RecAccountusers."Details Updated";
        END
    end;

    procedure UpdateRecruitmentAccount(username: Text; Initialsz: Integer; PostalAddress: Text; PostalCode: Text; IDNumber: Code[30]; Genderz: Option; HomePhoneNumber: Code[30]; Citizenshipz: Text; MaritalStatus: Option; EthnicOrigin: Text; Disabledz: Option; DesabilityDetails: Text; DoB: Date; KRAPINNumber: Text; ApplicantType: option; PwdNumber: Text[50]; PassportNo: Text[30]; Religion: Text[30]; Denomination: Text[30]) Message: Boolean
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", username);
        IF RecAccountusers.FIND('-') THEN BEGIN
            RecAccountusers.Initials := Initialsz;
            RecAccountusers."Postal Address" := PostalAddress;
            RecAccountusers."Postal Code" := PostalCode;
            RecAccountusers."ID Number" := IDNumber;
            RecAccountusers."Passport No" := PassportNo;
            RecAccountusers.Gender := Genderz;
            RecAccountusers."Home Phone Number" := HomePhoneNumber;
            //RecAccountusers."Residential Address" := ResidentialAddress;
            RecAccountusers.Citizenship := Citizenshipz;
            //RecAccountusers.County := Countyz;
            RecAccountusers."Marital Status" := MaritalStatus;
            RecAccountusers."Ethnic Group" := EthnicOrigin;
            RecAccountusers.Disabled := Disabledz;
            RecAccountusers."Disability Details" := DesabilityDetails;
            RecAccountusers."PWD Number" := PwdNumber;
            RecAccountusers."Date of Birth" := DoB;
            RecAccountusers.Religion := Religion;
            RecAccountusers.Denomination := Denomination;
            //RecAccountusers."2nd Language" := ndLanguage;
            //RecAccountusers."Additional Language" := AdditionalLanguage;
            RecAccountusers."Applicant Type" := ApplicantType;
            RecAccountusers."Created Date" := TODAY;
            RecAccountusers."Details Updated" := TRUE;
            RecAccountusers.MODIFY;
            Message := TRUE;
        END;
    end;

    procedure ActivateOnlineUserAccount(email: Text; sessionkey: Text) Message: Boolean
    begin
        RecAccountusers.RESET;
        RecAccountusers.SETRANGE(RecAccountusers."Email Address", email);
        RecAccountusers.SETRANGE(RecAccountusers.SessionKey, sessionkey);
        IF RecAccountusers.FIND('-') THEN BEGIN
            RecAccountusers."Account Confirmed" := TRUE;
            RecAccountusers.MODIFY;
            Message := TRUE;
        END
    end;

    procedure GetReligions() Message: Text
    begin
        Message := 'CHRISTIAN:::MUSLIM:::HINDU:::';
        religions.RESET;
        IF religions.FIND('-') THEN BEGIN
            REPEAT
                Message += religions.Religion + ' :::';
            UNTIL religions.NEXT = 0;
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
            Message := jobPosts."Job ID" + ' ::' + FORMAT(jobPosts."No of Posts") + ' ::' + jobPosts."Position Reporting to" + ' ';
        END
    end;

    procedure SendEmpReq(requestorid: code[20]; replacedemp: code[20]; jobid: Text; reason: Option; contractType: Option; priority: Option; posts: Integer; startDate: Date)
    var
        NextEmpReqNo: Code[20];
        ApprMgmt: Codeunit "Approval Mgmnt. Ext(hr)";
    begin
        EmpReq.INIT;
        NextEmpReqNo := NoSeriesMgt.GetNextNo('EMPREQ', 0D, TRUE);
        jobPosts.Reset();
        jobPosts.SETRANGE(jobPosts."Job ID", jobid);
        IF jobPosts.FIND('-')
        THEN BEGIN
            EmpReq."Job ID" := jobPosts."Job ID";
            EmpReq."Job Description" := jobPosts."Job Description";
            EmpReq."Job Ref No" := jobPosts."Job ID";
            EmpReq."Vacant Positions" := jobPosts."Vacant Positions";
            EmpReq."Reporting To:" := jobPosts."Position Reporting to";
        END;
        HRMEmployeeD.Reset;
        HRMEmployeeD.SetRange("No.", requestorid);
        if HRMEmployeeD.FIND('-') THEN BEGIN
            EmpReq."Requestor Name" := HRMEmployeeD.FullName();
            EmpReq.Department := HRMEmployeeD."Department Code";
        END;
        EmpReq."Requisition No." := NextEmpReqNo;
        EmpReq.Requestor := requestorid;
        EmpReq."Requestor Staff ID" := requestorid;
        EmpReq."Requisition Date" := TODAY;
        EmpReq.Priority := priority;
        EmpReq."Proposed Starting Date" := startDate;
        EmpReq."Required Positions" := posts;
        EmpReq."Reason For Request" := reason;
        if replacedemp <> '' then begin
            HRMEmployeeD.RESET;
            HRMEmployeeD.SetRange("No.", replacedemp);
            if HRMEmployeeD.FIND('-') THEN begin
                EmpReq."Staff Exiting StaffID" := replacedemp;
                EmpReq."Staff Exiting Name" := HRMEmployeeD.FullName();
            end;
        end;
        EmpReq.INSERT;
        EmpReq.Reset();
        EmpReq.SETRANGE(EmpReq."Requisition No.", NextEmpReqNo);
        IF EmpReq.FIND('-')
        THEN BEGIN
            //ApprovalMgmtHr.CheckEmployeeRequisitionApprovalPossible(EmpReq);
            ApprMgmt.OnSendEmployeeRequisitionForApproval(EmpReq);
        end
    end;

    procedure RejectLeave(DocumentNo: Text; UserID: Text)
    begin
        LeaveT.RESET;
        LeaveT.SETRANGE(LeaveT."No.", DocumentNo);
        IF LeaveT.FIND('-')
          THEN BEGIN
            ApprovalEntry.RESET();
            ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
            ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", UserID);
            ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", Database::"HRM-Leave Requisition");
            IF ApprovalEntry.FIND('-') THEN BEGIN
                ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
                ApprovalEntry.MODIFY;
                HRLeave.RESET;
                HRLeave.SETRANGE(HRLeave."No.", DocumentNo);
                IF HRLeave.FIND('-') THEN BEGIN
                    HRLeave.Status := HRLeave.Status::Cancelled;
                    HRLeave.MODIFY;
                END;
            END;

        END;
    end;

    procedure ApproveLeave(DocumentNo: Text; UserID: Text)
    begin
        LeaveT.RESET;
        LeaveT.SETRANGE(LeaveT."No.", DocumentNo);
        IF LeaveT.FIND('-')
          THEN BEGIN
            ApprovalEntry.RESET();
            ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
            ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", UserID);
            ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", Database::"HRM-Leave Requisition");
            IF ApprovalEntry.FIND('-') THEN BEGIN
                //Modify status to approved if there are no other approvers
                ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                ApprovalEntry.MODIFY;

                //Change next doc to open
                ApprovalEntry_2.RESET;
                ApprovalEntry_2.SETRANGE(ApprovalEntry_2."Document No.", DocumentNo);
                ApprovalEntry_2.SETRANGE(ApprovalEntry_2.Status, ApprovalEntry_2.Status::Created);
                IF ApprovalEntry_2.FIND('-') THEN BEGIN
                    ApprovalEntry_2.Status := ApprovalEntry_2.Status::Open;
                    ApprovalEntry_2."Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
                    ApprovalEntry_2.MODIFY;
                END;

            END;
            ApprovalEntry_2.RESET;
            ApprovalEntry_2.SETRANGE(ApprovalEntry_2."Document No.", DocumentNo);
            IF ApprovalEntry_2.FINDLAST THEN BEGIN
                IF ApprovalEntry_2.Status = ApprovalEntry_2.Status::Approved THEN BEGIN
                    HRLeave.RESET;
                    HRLeave.SETRANGE(HRLeave."No.", DocumentNo);
                    IF HRLeave.FIND('-') THEN BEGIN
                        HRLeave.Status := HRLeave.Status::Released;
                        HRLeave.MODIFY;
                    END;
                END;
            END;

        END;
    end;

    procedure CheckPartTimeLine(appno: Code[20]) exists: Boolean
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

    procedure GetPartTimeLecturerUnits(lectno: code[20]; progcode: code[20]; sem: code[20]) Message: Text
    begin
        ACALecturersUnits.Reset();
        ACALecturersUnits.SetRange(ACALecturersUnits.Lecturer, lectno);
        ACALecturersUnits.SetRange(ACALecturersUnits.Programme, progcode);
        ACALecturersUnits.SetRange(ACALecturersUnits.Semester, sem);
        if ACALecturersUnits.find('-') then begin
            repeat
                PartTimeClaimLn.Reset;
                PartTimeClaimLn.SetRange("Lecture No.", ACALecturersUnits.Lecturer);
                PartTimeClaimLn.SetRange(Unit, ACALecturersUnits.Unit);
                PartTimeClaimLn.SetRange(Programme, ACALecturersUnits.Programme);
                PartTimeClaimLn.SetRange(Semester, ACALecturersUnits.Semester);
                if NOT PartTimeClaimLn.FIND('-') Then begin
                    Message += ACALecturersUnits.Unit + '::' + ACALecturersUnits.Description + ':::';
                end;
            until ACALecturersUnits.next = 0;
        end;
    END;

    procedure PartTimeApprovalRequest(ReqNo: Code[20])
    var
        Approvalmgt: codeunit "Workflow Initialization";

    begin
        PartTimeClaimHd.Reset();
        PartTimeClaimHd.SETRANGE("No.", ReqNo);
        IF PartTimeClaimHd.FIND('-')
        THEN BEGIN
            if Approvalmgt.IsParttimeClaimEnabled(PartTimeClaimHd) = true then begin
                PartTimeClaimHd.CommitBudget();
                Approvalmgt.OnSendParttimeClaimforApproval(PartTimeClaimHd);
            end
        END;
    end;

    procedure GetProgFaculty(Prog: Code[20]) FactName: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, Prog);
        IF Programme.FIND('-') THEN BEGIN
            FactName := Programme."Faculty Name";
        END
    end;

    procedure GetProgDeptCode(progcode: code[10]) deptcode: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, progcode);
        IF Programme.FIND('-') THEN BEGIN
            deptcode := Programme."Department Code";
        END;
    end;

    procedure GetProgDept(Prog: Code[20]) DeptName: Text
    begin
        Programme.RESET;
        Programme.SETRANGE(Programme.Code, Prog);
        IF Programme.FIND('-') THEN BEGIN
            DeptName := Programme."Department Name";
        END
    end;

    procedure GetScore(StudentNo: Code[20]; prog: Code[20]; unitz: Code[20]; ExmaType: Code[20]; sem: code[20]) Message: Text
    begin
        ExamResults.RESET;
        ExamResults.SETRANGE(ExamResults."Student No.", StudentNo);
        ExamResults.SETRANGE(ExamResults.Unit, unitz);
        ExamResults.SETRANGE(ExamResults.ExamType, ExmaType);
        ExamResults.SETRANGE(ExamResults.Programmes, prog);
        ExamResults.SETRANGE(ExamResults.Semester, sem);
        IF ExamResults.FIND('-') THEN BEGIN
            Message := FORMAT(ExamResults.Score);

        END
    end;

    procedure GetGrade(StudentNo: Code[20]; prog: Code[20]; unitz: Code[20]; sem: code[20]; markstatus: option; totalscore: Decimal) Message: Text
    var
        examcategory: Code[20];
    begin
        StudentUnits.reset;
        StudentUnits.SetRange("Student No.", StudentNo);
        StudentUnits.SetRange(Unit, unitz);
        StudentUnits.SetRange(Programme, prog);
        StudentUnits.SetRange(Semester, sem);
        if StudentUnits.FIND('-') then begin
            Clear(examcategory);
            examcategory := GetUnitExamCategory(unitz, prog);
            ExamGradingSourse.Reset;
            ExamGradingSourse.SetRange("Exam Catregory", examcategory);
            ExamGradingSourse.SetRange("Results Exists Status", markstatus);
            ExamGradingSourse.SetRange("Total Score", totalscore);
            if ExamGradingSourse.find('-') then begin
                message := ExamGradingSourse.Grade + '::' + ExamGradingSourse.Remarks;
            end;
        end;
    end;

    procedure GetUnitExamCategory(unit: Code[20]; prog: Code[20]) Message: Text
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects.Code, unit);
        IF UnitSubjects.FIND('-') THEN BEGIN
            if UnitSubjects."Exam Category" <> '' then begin
                Message := UnitSubjects."Exam Category";
            end else begin
                Message := GetProgramCategory(prog);
            end;
        END
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

    procedure GetCurrentSem() Msg: Text
    begin
        CurrentSem.reset;
        CurrentSem.SETRANGE(CurrentSem."Current Semester", true);
        IF CurrentSem.FIND('-') THEN begin
            Msg := CurrentSem.Code;
        end;
    end;

    procedure GenerateBS64ClassRegister(unitcode: Code[20]; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
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
        StudentUnits.SETRANGE(StudentUnits.Semester, GetCurrentSem());
        IF StudentUnits.FIND('-') THEN BEGIN
            recRef.GetTable(StudentUnits);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(52301, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END ELSE BEGIN
            Error('No class list for the details provided!');
        END;
        EXIT(filename);
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
            HRMEmployeeD.GET(ImprestRequisition.Cashier);
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
            HRMEmployeeD.GET(ImprestRequisition.Cashier);
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
    begin
        ImprestSurrHeader.Reset;
        ImprestSurrHeader.SETRANGE(ImprestSurrHeader.No, docNo);
        IF ImprestSurrHeader.FIND('-') THEN BEGIN
            ApprovalMgmt.OnSendImprestAccForApproval(ImprestSurrHeader);
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

    procedure GetModeofStudy() Message: Text
    begin
        studymodes.RESET;
        IF studymodes.FIND('-') THEN BEGIN
            REPEAT
                Message := Message + studymodes.Code + ' ::' + studymodes.Description + ' :::';
            UNTIL studymodes.NEXT = 0;
        END;
    end;

    procedure GetUnitsToOffer(progcode: code[20]; stage: Code[20]; studymode: Code[20]) Details: Text
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
                if not offeredunits.Find('-') then begin
                    Details += UnitSubjects.Code + ' ::' + UnitSubjects.Desription + ' :::';
                end;
            until UnitSubjects.Next = 0;
        END;
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

    procedure RemoveSemUnit(hodno: Code[20]; unitcode: code[20]; progcode: code[20]; studymode: code[20]; stage: Code[20]) Details: Boolean
    begin
        //delete base unit
        offeredunits.RESET;
        offeredunits.SETRANGE("Unit Base Code", unitcode);
        offeredunits.SETRANGE(Programs, progcode);
        offeredunits.SETRANGE(ModeofStudy, studymode);
        offeredunits.SETRANGE(Stage, stage);
        offeredunits.SETRANGE(Semester, GetCurrentSemester());
        offeredunits.SetRange(Campus, GetHODCampus(hodno));
        IF offeredunits.FIND('-') THEN BEGIN
            //delete base unit registered students
            studentUnits.RESET;
            studentUnits.SETRANGE(Semester, GetCurrentSemester());
            studentUnits.SETRANGE(Unit, unitcode);
            StudentUnits.SetRange("Campus Code", GetHODCampus(hodno));
            studentUnits.SETRANGE(Stage, stage);
            studentUnits.SETRANGE(Programme, progcode);
            studentUnits.SETRANGE(ModeOfStudy, studymode);
            if studentUnits.FIND('-') then begin
                repeat
                    studentUnits.CALCFIELDS("CATs Marks Exists", "EXAMs Marks Exists");
                    if ((studentUnits."CATs Marks Exists") OR (studentUnits."EXAMs Marks Exists")) then begin
                        Error('Marks Exist you cannot Delete!');
                    end else begin
                        studentUnits.DELETE;
                    end;
                until StudentUnits.next = 0;
            end;
            offeredunits.Delete();
            //delete allocated lecturers
            lecturers.Reset;
            lecturers.SetRange(Lecturer, offeredunits.Lecturer);
            lecturers.SetRange(Unit, offeredunits."Unit Base Code");
            lecturers.SetRange(ModeOfStudy, offeredunits.ModeofStudy);
            lecturers.SetRange(Stage, offeredunits.Stage);
            lecturers.SetRange(Semester, offeredunits.Semester);
            lecturers.SetRange("Campus Code", GetHODCampus(hodno));
            lecturers.SetRange(Day, offeredunits.Day);
            lecturers.SetRange(TimeSlot, offeredunits.TimeSlot);
            if lecturers.Find('-') then begin
                lecturers.Delete;
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

    procedure GetStudentSelectedUnits(stdNo: Code[20]) msg: Text
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE("Student No.", stdNo);
        StudentUnitBaskets.SETRANGE(Semester, GetCurrentSem());
        IF StudentUnitBaskets.FIND('-') THEN begin
            repeat
                msg += StudentUnitBaskets.Unit + '::' + StudentUnitBaskets.Description + ':::';
            until StudentUnitBaskets.Next = 0;
        end;
    end;

    procedure GetStudentIndexNo(stdNo: Code[20]) msg: Text
    var
        cust: Record "Customer";
    begin
        fablist.Reset;
        fablist.SetRange("Admission No", stdNo);
        if fablist.Find('-') then begin
            msg := fablist."Index Number";
        end;
    end;

    procedure GetUnitRegApprovalEntries(staffNo: Code[20]) msg: Text
    var
        cust: Record "Customer";
    begin
        unitregapprovals.Reset;
        unitregapprovals.SetRange(Semester, GetCurrentSem());
        if unitregapprovals.Find('-') then begin
            repeat
                Programme.RESET;
                Programme.SETRANGE(Code, unitregapprovals.Programe);
                Programme.SETRANGE("Department Code", GetHODDepartment(staffNo));
                if Programme.Find('-') then begin
                    if (unitregapprovals."Approval Status" = unitregapprovals."Approval Status"::Submitted) OR (unitregapprovals."Approval Status" = unitregapprovals."Approval Status"::Resubmitted)
                    then begin
                        cust.Reset;
                        cust.SetRange("No.", unitregapprovals.StudNo);
                        if cust.Find('-') then begin
                            StudentUnitBaskets.Reset;
                            StudentUnitBaskets.SetRange("Student No.", unitregapprovals.StudNo);
                            StudentUnitBaskets.SetRange(Semester, GetCurrentSem());
                            if StudentUnitBaskets.Find('-') then begin
                                msg += unitregapprovals.studNo + '::' + cust.Name + '::' + unitregapprovals."Programme Description" + '::' + unitregapprovals.Stage + ':::';
                            end;
                        end;
                    end;
                end;
            until unitregapprovals.Next = 0;
        end;
    end;

    procedure ApproveSemUnitsReg(studentNo: Code[20]) ReturnMessage: boolean
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE("Student No.", studentNo);
        StudentUnitBaskets.SETRANGE(Semester, GetCurrentSem());
        IF StudentUnitBaskets.FIND('-') THEN begin
            repeat
                StudentUnits.INIT;
                StudentUnits."Student No." := studentNo;
                StudentUnits.Unit := StudentUnitBaskets.Unit;
                StudentUnits.Programme := StudentUnitBaskets.Programme;
                StudentUnits.Stage := StudentUnitBaskets.Stage;
                StudentUnits.Semester := StudentUnitBaskets.Semester;
                StudentUnits.Taken := TRUE;
                StudentUnits."Reg. Transacton ID" := StudentUnitBaskets."Reg. Transacton ID";
                StudentUnits."Unit Description" := StudentUnitBaskets."Unit Description";
                StudentUnits."Academic Year" := StudentUnitBaskets."Academic Year";
                StudentUnits.INSERT(TRUE);
            until StudentUnitBaskets.Next = 0;
            StudentUnitBaskets.DeleteAll();
            unitregapprovals.Reset;
            unitregapprovals.SetRange(studNo, studentNo);
            unitregapprovals.SetRange(Semester, GetCurrentSem());
            if unitregapprovals.Find('-') then begin
                unitregapprovals."Approval Status" := unitregapprovals."Approval Status"::Approved;
                unitregapprovals.Modify;
            end;
            ReturnMessage := true;
        end;
    end;

    procedure RejectSemUnitsReg(studentNo: Code[20]; reason: Text) ReturnMessage: boolean
    var
        Customer: Record "Customer";
    begin
        StudentUnitBaskets.RESET;
        StudentUnitBaskets.SETRANGE("Student No.", studentNo);
        StudentUnitBaskets.SETRANGE(Semester, GetCurrentSem());
        IF StudentUnitBaskets.FIND('-') THEN begin
            StudentUnitBaskets.DeleteAll();
            unitregapprovals.Reset;
            unitregapprovals.SetRange(studNo, studentNo);
            unitregapprovals.SetRange(Semester, GetCurrentSem());
            if unitregapprovals.Find('-') then begin
                unitregapprovals."Approval Status" := unitregapprovals."Approval Status"::Rejected;
                unitregapprovals."Rejection Reason" := reason;
                unitregapprovals.Modify;
                CourseRegistration.RESET;
                CourseRegistration.SETRANGE(CourseRegistration."Student No.", StudentNo);
                CourseRegistration.SETRANGE(CourseRegistration.Reversed, FALSE);
                CourseRegistration.SETCURRENTKEY(Stage);
                IF CourseRegistration.FIND('+') THEN BEGIN
                    CourseRegistration.Options := '';
                    CourseRegistration.Modify;
                END;
            end;
            ReturnMessage := true;
        end;
    end;

    procedure OfferUnit(hodno: Code[20]; progcode: Code[20]; stage: code[20]; unitcode: Code[20]; studymode: Code[20]; lecturer: Code[20]; lecturehall: Code[20]; day: Code[20]; timeslot: Code[20]) rtnMsg: Boolean
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

    procedure GetHODCampus(hod: Code[20]) campus: Text
    begin
        HRMEmployeeD.RESET;
        HRMEmployeeD.SETRANGE("No.", hod);
        IF HRMEmployeeD.FIND('-') THEN BEGIN
            campus := HRMEmployeeD.Campus;
        END
    end;

    procedure GetCurrentSemester() Message: Text
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE("Current Semester", TRUE);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem.Code;
        END;
    end;

    procedure GetCurrentAcademicYear() Message: Text
    begin
        AcademicYr.RESET;
        AcademicYr.SETRANGE(Current, TRUE);
        IF AcademicYr.FIND('-') THEN BEGIN
            Message := AcademicYr.Code;
        END;
    end;

    procedure GetUnitDescription(UnitID: Code[20]) Message: Text
    begin
        UnitSubjects.RESET;
        UnitSubjects.SETRANGE(UnitSubjects.Code, UnitID);
        IF UnitSubjects.FIND('-') THEN BEGIN
            Message := UnitSubjects.Desription;
        END
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

    procedure checkDean(username: code[10]) ishod: Boolean
    begin
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", username);
        EmployeeCard.SETRANGE(EmployeeCard.isDean, TRUE);
        IF EmployeeCard.FIND('-') THEN BEGIN
            ishod := TRUE;
        END;
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
            fablist.SETRANGE(fablist."Programme Faculty", EmployeeCard."Faculty Code");
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

    procedure GenerateBS64FacultyAppSummary(hod: code[20]; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
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
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", hod);
        IF EmployeeCard.FIND('-') THEN BEGIN
            fablist.RESET;
            fablist.SETRANGE(fablist."Programme Faculty", EmployeeCard."Faculty Code");
            IF fablist.FIND('-') THEN BEGIN
                recRef.GetTable(fablist);
                tmpBlob.CreateOutStream(OutStr);
                Report.SaveAs(51862, '', format::Pdf, OutStr, recRef);
                tmpBlob.CreateInStream(InStr);
                txtB64 := cnv64.ToBase64(InStr, true);
                bigtext.AddText(txtB64);
            END;
        END;
        EXIT(filename);
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
            Report.SaveAs(51862, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END;
        EXIT(filename);
    end;

    procedure GenerateBS64DepartmentAppSummary(hod: code[20]; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
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
        EmployeeCard.RESET;
        EmployeeCard.SETRANGE(EmployeeCard."No.", hod);
        IF EmployeeCard.FIND('-') THEN BEGIN
            fablist.RESET;
            fablist.SETRANGE(fablist."Admitted Department", EmployeeCard."Department Code");
            IF fablist.FIND('-') THEN BEGIN
                recRef.GetTable(fablist);
                tmpBlob.CreateOutStream(OutStr);
                Report.SaveAs(51862, '', format::Pdf, OutStr, recRef);
                tmpBlob.CreateInStream(InStr);
                txtB64 := cnv64.ToBase64(InStr, true);
                bigtext.AddText(txtB64);
            END;
        END;
        EXIT(filename);
    end;

    procedure GetApplicantEmail(appno: code[50]) email: Text
    begin
        fablist.RESET;
        fablist.SETRANGE(fablist."Application No.", appno);
        IF fablist.FIND('-') THEN BEGIN
            email := fabList.Email;
        END;
    end;

    procedure GetLecUnits(lecno: Code[20]) msg: Text
    begin
        lecturers.Reset;
        lecturers.SetRange(Lecturer, lecno);
        lecturers.SetRange(Semester, GetCurrentSemester());
        if lecturers.Find('-') then begin
            repeat
                msg += lecturers.Unit + ' ::' + GetUnitDescription(Lecturers.Unit) + ' ::' + lecturers.ModeOfStudy + ' ::' + lecturers.Stream + ' ::' + lecturers.Day + ' ::' + lecturers.TimeSlot + ' ::' + GetAllocatedLectureHall(lecturers.Lecturer, lecturers.Unit, lecturers.stream, lecturers."Campus Code", lecturers.ModeOfStudy) + ' :::';
            until lecturers.Next = 0;
        end;
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

    procedure ClassAttendanceHeader(lectno: code[20]; unit: text; classtime: Code[20])
    begin
        AttendanceHeader.INIT;
        AttendanceHeader."Attendance Date" := Today;
        AttendanceHeader."Lecturer Code" := lectno;
        AttendanceHeader.Semester := GetCurrentSem();
        AttendanceHeader."Unit Code" := unit;
        AttendanceHeader."Class Type" := AttendanceHeader."Class Type"::"Normal Single";
        //AttendanceHeader.Time := classtime;
        AttendanceHeader.INSERT;
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

    procedure GenerateBS64ClassRegisterNew(lecturer: Code[20]; unitcode: Code[20]; mode: Code[20]; stream: Text; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
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
        StudentUnits.SETRANGE(StudentUnits.ModeOfStudy, mode);
        StudentUnits.SETRANGE(StudentUnits.Stream, stream);
        StudentUnits.SETRANGE(StudentUnits.Semester, GetCurrentSem());
        StudentUnits.SETRANGE(StudentUnits."Campus Code", GetHODCampus(lecturer));
        IF StudentUnits.FIND('-') THEN BEGIN
            recRef.GetTable(StudentUnits);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(51864, '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END ELSE BEGIN
            Error('No class list for the details provided!');
        END;
        EXIT(filename);
    end;

    procedure BufferExamResults(stdNo: Code[20]; unitCode: Code[20]; unitName: Text; prog: Code[20]; acayear: Code[20]; stage: Code[20]; semester: Code[20]; catmarks: Decimal; exammarks: Decimal; username: Code[20]) inserted: Boolean
    begin
        examResultsBuffer.Reset;
        examResultsBuffer.SetRange("Student No.", stdNo);
        examResultsBuffer.SetRange("Academic Year", acayear);
        examResultsBuffer.SetRange(Semester, semester);
        examResultsBuffer.SetRange(Programme, prog);
        examResultsBuffer.SetRange("Unit Code", unitCode);
        examResultsBuffer.SetRange(Stage, stage);
        if not examResultsBuffer.Find('-') then begin
            examResultsBuffer.Init;
            examResultsBuffer."Student No." := stdNo;
            examResultsBuffer."Unit Code" := unitCode;
            //examResultsBuffer."Unit Name" := unitName;
            examResultsBuffer.Programme := prog;
            examResultsBuffer."Academic Year" := acayear;
            examResultsBuffer.Stage := stage;
            examResultsBuffer.Semester := semester;
            examResultsBuffer."CAT Score" := catmarks;
            examResultsBuffer."Exam Score" := exammarks;
            examResultsBuffer."User Name" := username;
            examResultsBuffer.Insert;
            inserted := true;
        end
    end;

    procedure GetBase64ResultSlip(stdNo: Code[20]) msg: Text
    var
        DocAttachment1: Record "Document Attachment";
    begin
        fablist.Reset;
        fablist.SetRange("Admission No", stdNo);
        if fablist.Find('-') then begin
            DocAttachment1.Reset();
            DocAttachment1.SetRange("No.", fablist."Application No.");
            DocAttachment1.SetRange("Table ID", 51833);
            DocAttachment1.SetRange("File Name", 'High School Certificate');
            if DocAttachment1.Find('-') then begin
                msg := fnGetAttachmentBase64(DocAttachment1);
            end;
        end;
    end;

    procedure GetStudentEmail(stdNo: Code[20]) msg: Text
    var
        cust: Record Customer;
    begin
        cust.Reset;
        cust.SetRange("No.", stdNo);
        if cust.Find('-') then begin
            msg := cust."E-Mail";
        end;
    end;

    procedure fnGetAttachmentBase64(DocAttach: Record "Document Attachment"): Text
    Var
        Templob: Codeunit "Temp Blob";
        DocInstream: InStream;
        Base64: Codeunit "Base64 Convert";
        DocOutStream: OutStream;
    begin
        Templob.CreateOutStream(DocOutStream);
        if DocAttach."Document Reference ID".HasValue then begin
            DocAttach."Document Reference ID".ExportStream(DocOutStream);
            Templob.CreateInStream(DocInstream);
            exit(Base64.ToBase64(DocInstream));
        end;
    end;

    procedure LeaveAttachement(retNo: Code[50]; fileName: Text; attachment: BigText; tableId: Integer) return_value: Boolean
    var
        DocAttachment: Record "Document Attachment";
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
        tableFound: Boolean;
        ObjAppliRec: Record "HRM-Leave Requisition";

    begin

        tableFound := false;
        return_value := false;
        if TableID = Database::"HRM-Leave Requisition" then begin
            ObjAppliRec.RESET;
            ObjAppliRec.SETRANGE(ObjAppliRec."No.", retNo);
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

    var
        days: Record "TT-Days";
        timeslots: Record "TT-Daily Lessons";
        lecturehalls: Record "ACA-Lecturer Halls Setup";
        studymodes: Record "ACA-Student Types";
        stdapp: Report "Student Applications Report";
        settlementtypes: Record "ACA-Settlement Type";
        fabList: Record "ACA-Applic. Form Header";
        offeredunits: Record "ACA-Units Offered";
        programs: Record "ACA-Programme";
        lecturers: Record "ACA-Lecturers Units";
        unitregapprovals: Record RegProcessApprovalEntry;
        ImprestSurrHeader: Record "FIN-Imprest Surr. Header";
        ImprestSurrDetails: Record "FIN-Imprest Surrender Details";
        ImprestRequisitionLines: Record "FIN-Imprest Lines";
        ApprovalMgmt: Codeunit "Init Code";
        classlistrpt: Report "ACA-Class List";
        AttendanceDetails: Record "Class Attendance Details";
        AttendanceHeader: Record "Class Attendance Header";
        profQuals: Record "HRM-Prof Qualification";
        WorkExp: Record "HRM-Work eXP";
        Referees: Record "HRM-Applicant Referees";
        religions: Record "ACA-Religions";
        centralsetup: Record "ACA-Academics Central Setups";
        jobPosts: Record "HRM-Jobs";
        EmpReq: Record "HRM-Employee Requisitions";
        ExamGradingSourse: Record "ACA-Exam Grading Source";
}

