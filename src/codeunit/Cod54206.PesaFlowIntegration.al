codeunit 54206 "PesaFlow Integration"
{
    var
        PesaflowIntegration: Record "PesaFlow Integration";
        PesaFlowInvoices: Record "PesaFlow Invoices";
        Cust: Record Customer;
        KUCCPSRaw: Record "KUCCPS Imports";
        licenseapplic: Record "License Applications";


    procedure ApplicationIDExists(applicid: Code[20]) msg: Boolean
    begin
        licenseapplic.RESET;
        licenseapplic.SETRANGE("Application ID", applicid);
        IF licenseapplic.FIND('-') THEN BEGIN
            msg := TRUE;
        END;
    end;

    procedure InsertLicenseApplication(applicid: Code[20]; name: Text; amt: Decimal) msg: Boolean
    begin
        licenseapplic.RESET;
        licenseapplic.SETRANGE("Application ID", applicid);
        IF NOT licenseapplic.FIND('-') THEN BEGIN
            licenseapplic.Init;
            licenseapplic."Application ID" := applicid;
            licenseapplic."Applicant Name" := name;
            licenseapplic.Amount := amt;
            licenseapplic."Application Date" := Today;
            licenseapplic.Insert;
            msg := TRUE;
        END;
    end;

    procedure PesaFlowTransExists(refid: Code[20]) msg: Boolean
    begin
        PesaFlowIntegration.RESET;
        PesaFlowIntegration.SETRANGE(PaymentRefID, refid);
        IF PesaFlowIntegration.FIND('-') THEN BEGIN
            msg := TRUE;
        END;
    end;

    procedure PostPesaFlowTrans(paymentrefid: Code[50]; customerrefno: Code[20]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; paymentchannel: Text; paymentdate: Text; status: Text) inserted: Boolean
    begin
        PesaFlowInvoices.RESET;
        PesaFlowInvoices.SETRANGE(BillRefNo, customerrefno);
        IF PesaFlowInvoices.FIND('-') THEN BEGIN
            PesaFlowIntegration.RESET;
            PesaFlowIntegration.SETRANGE(PaymentRefID, paymentrefid);
            IF NOT PesaFlowIntegration.FIND('-') THEN BEGIN
                PesaFlowIntegration.INIT;
                PesaFlowIntegration.PaymentRefID := paymentrefid;
                PesaFlowIntegration.CustomerRefNo := PesaFlowInvoices.CustomerRefNo;
                PesaFlowIntegration."Customer Name" := PesaFlowInvoices.CustomerName;
                PesaFlowIntegration.InvoiceNo := invoiceno;
                PesaFlowIntegration.InvoiceAmount := invoiceamt;
                PesaFlowIntegration.PaidAmount := paidamt;
                PesaFlowIntegration.ServiceID := PesaFlowInvoices.ServiceID;
                PesaFlowIntegration.Description := PesaFlowInvoices.Description;
                PesaFlowIntegration.PaymentChannel := paymentchannel;
                PesaFlowIntegration.PaymentDate := paymentdate;
                PesaFlowIntegration.Status := status;
                PesaFlowIntegration."Date Received" := TODAY;
                PesaFlowIntegration.INSERT;
                inserted := TRUE;
                Cust.Reset();
                Cust.SetRange("No.", PesaFlowInvoices.CustomerRefNo);
                if Cust.Find('-') then begin
                    PostPesaFlow(PesaFlowIntegration);
                end else begin
                    KUCCPSRaw.Reset;
                    KUCCPSRaw.SetRange(Admin, PesaFlowInvoices.CustomerRefNo);
                    if KUCCPSRaw.Find('-') then begin
                        //Admit the student and post the payment....
                        //TransferToAdmission(PesaFlowInvoices.CustomerRefNo);
                        //Post to students Ledger
                        PostPesaFlow(PesaFlowIntegration);
                    end;
                end;
            END ELSE BEGIN
                ERROR('invalid transaction id');
            END;
        END ELSE BEGIN
            ERROR('invalid invoice');

        END
    end;

    procedure InsertAccommodationFee(paymentrefid: Code[50]; customerrefno: Code[20]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; paymentchannel: Text; paymentdate: Text; status: Text) inserted: Boolean
    var
        accommodationBooking: Record "Accomodation and Booking";
    begin
        accommodationBooking.RESET;
        accommodationBooking.SETRANGE(BillRefNo, customerrefno);
        IF accommodationBooking.FIND('-') THEN BEGIN
            PesaFlowIntegration.RESET;
            PesaFlowIntegration.SETRANGE(PaymentRefID, paymentrefid);
            IF NOT PesaFlowIntegration.FIND('-') THEN BEGIN
                PesaFlowIntegration.INIT;
                PesaFlowIntegration.PaymentRefID := paymentrefid;
                PesaFlowIntegration.CustomerRefNo := accommodationBooking.StudentNo;
                PesaFlowIntegration."Customer Name" := accommodationBooking.StudentName;
                PesaFlowIntegration.InvoiceNo := invoiceno;
                PesaFlowIntegration.InvoiceAmount := invoiceamt;
                PesaFlowIntegration.PaidAmount := paidamt;
                PesaFlowIntegration.ServiceID := accommodationBooking.ServiceCode;
                PesaFlowIntegration.Description := accommodationBooking.Description;
                PesaFlowIntegration.PaymentChannel := paymentchannel;
                PesaFlowIntegration.PaymentDate := paymentdate;
                PesaFlowIntegration.Status := status;
                PesaFlowIntegration."Date Received" := TODAY;
                PesaFlowIntegration.INSERT;
                if paidamt = accommodationBooking.SpaceCost then begin
                    BookHostel(accommodationBooking.StudentNo, accommodationBooking.HostelNo, accommodationBooking.Semester, accommodationBooking.RoomNo, accommodationBooking.SpaceCost, accommodationBooking.SpaceNo, accommodationBooking.SpaceCost);
                end;
                inserted := TRUE;
            END ELSE BEGIN
                ERROR('invalid transaction id');
            END;
        END ELSE BEGIN
            ERROR('invalid invoice');

        END
    end;

    procedure BookHostel(studentNo: Text; MyHostelNo: Text; MySemester: Text; myRoomNo: Text; MyAccomFee: Decimal; mySpaceNo: Text; MyspaceCost: Decimal) ReturnMessage: Text
    var
        HostelRooms: Record "ACA-Students Hostel Rooms";
        RoomSpaces: Record "ACA-Room Spaces";
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



    procedure PostPesaFlowPayBillTrans(paymentrefid: Code[50]; customerrefno: Code[20]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; paymentchannel: Text; paymentdate: Text; status: Text) inserted: Boolean
    begin
        PesaFlowIntegration.RESET;
        PesaFlowIntegration.SETRANGE(PaymentRefID, paymentrefid);
        IF NOT PesaFlowIntegration.FIND('-') THEN BEGIN
            PesaFlowIntegration.INIT;
            PesaFlowIntegration.PaymentRefID := paymentrefid;
            PesaFlowIntegration.CustomerRefNo := customerrefno;
            PesaFlowIntegration.InvoiceNo := invoiceno;
            PesaFlowIntegration.InvoiceAmount := invoiceamt;
            PesaFlowIntegration.PaidAmount := paidamt;
            PesaFlowIntegration.PaymentChannel := paymentchannel;
            PesaFlowIntegration.PaymentDate := paymentdate;
            PesaFlowIntegration.Status := status;
            PesaFlowIntegration."Date Received" := TODAY;
            PesaFlowIntegration.INSERT;
            inserted := TRUE;
            //Post
        END ELSE BEGIN
            ERROR('invalid transaction id');
        END;
    end;

    Procedure PostPesaFlow(ecitizen: Record "PesaFlow Integration")
    var
        pflow: Record "PesaFlow Integration";
        bsetup: Record "E-Citizen Services";
        StudPay: Record "ACA-Std Payments";
    begin
        pflow.RESET;
        pflow.SETRANGE(Posted, FALSE);
        pflow.SETRANGE(PaymentRefID, ecitizen.PaymentRefID);
        IF pflow.FIND('-') THEN BEGIN
            //REPEAT

            StudPay.RESET;
            StudPay.SETRANGE(StudPay."Student No.", pflow.CustomerRefNo);
            IF StudPay.FIND('-') THEN
                StudPay.DELETEALL;

            StudPay.INIT;
            StudPay."Student No." := pflow.CustomerRefNo;
            StudPay."User ID" := USERID;
            StudPay."Payment Mode" := StudPay."Payment Mode"::"Direct Bank Deposit";
            StudPay."Cheque No" := pflow.PaymentRefID;
            StudPay."Drawer Name" := pflow."Customer Name";
            StudPay."Payment By" := pflow."Customer Name";
            bsetup.RESET;
            bsetup.SETRANGE("Service Code", pflow.ServiceID);
            IF bsetup.FIND('-') THEN
                StudPay."Bank No." := bsetup."Bank Code"
            ELSE
                ERROR('%1%2%3', 'Service ID ', pflow.ServiceID, ' has not been setup with an associated bank');
            StudPay."Amount to pay" := pflow.PaidAmount;
            StudPay.VALIDATE(StudPay."Amount to pay");
            StudPay."Transaction Date" := pflow."Date Received";
            StudPay.VALIDATE(StudPay."Auto Post PesaFlow");
            StudPay.INSERT;
            pflow.Posted := TRUE;
            pflow.MODIFY;
        end;
    end;


    Procedure PostBatchPesaFlow()
    var
        pflow: Record "PesaFlow Integration";
        bsetup: Record "E-Citizen Services";
        StudPay: Record "ACA-Std Payments";
    begin

        if UserId <> 'FRANKIE' then Error('');

        pflow.RESET;
        pflow.SETRANGE(Posted, FALSE);
        IF pflow.FIND('-') THEN BEGIN
            REPEAT

                StudPay.RESET;
                StudPay.SETRANGE(StudPay."Student No.", pflow.CustomerRefNo);
                IF StudPay.FIND('-') THEN
                    StudPay.DELETEALL;

                StudPay.INIT;
                StudPay."Student No." := pflow.CustomerRefNo;
                StudPay."User ID" := USERID;
                StudPay."Payment Mode" := StudPay."Payment Mode"::"Direct Bank Deposit";
                StudPay."Cheque No" := pflow.PaymentRefID;
                StudPay."Drawer Name" := pflow."Customer Name";
                StudPay."Payment By" := pflow."Customer Name";
                bsetup.RESET;
                bsetup.SETRANGE("Service Code", pflow.ServiceID);
                IF bsetup.FIND('-') THEN
                    StudPay."Bank No." := bsetup."Bank Code"
                ELSE
                    ERROR('%1%2%3', 'Service ID ', pflow.ServiceID, ' has not been setup with an associated bank');
                if pflow.PaidAmount > 50 then
                    StudPay."Amount to pay" := pflow.PaidAmount - 50
                else
                    StudPay."Amount to pay" := pflow.PaidAmount;
                StudPay.VALIDATE(StudPay."Amount to pay");
                StudPay."Transaction Date" := pflow."Date Received";
                StudPay.VALIDATE(StudPay."Auto Post PesaFlow");
                StudPay.INSERT;
                pflow.Posted := TRUE;
                pflow.MODIFY;
            until pflow.Next() = 0;
        end;

        Message('Complete');
    end;

    // procedure TransferToAdmission(AdmissionNumber: Code[20])
    // var
    //     AdminSetup: Record "KUCCPS Imports";
    //     NewAdminCode: Code[20];
    //     Customer: Record Customer;
    //     CourseRegistration: Record "ACA-Course Registration";
    //     Admissions: Record "ACA-Adm. Form Header";
    //     ApplicationSubject: Record "ACA-Applic. Form Academic";
    //     ACAApplicSetupCounty: Record "ACA-Applic. Setup County";
    //     AdmissionSubject: Record "ACA-Adm. Form Academic";
    //     LineNo: Integer;
    //     MedicalCondition: Record "ACA-Medical Condition";
    //     AdmissionMedical: Record "ACA-Adm. Form Medical Form";
    //     AdmissionFamily: Record "ACA-Adm. Form Family Medical";
    //     Immunization: Record "ACA-Immunization";
    //     AdmissionImmunization: Record "ACA-Adm. Form Immunization";
    // begin
    //     /*This function transfers the fieldsin the application to the fields in the admissions table*/
    //     /*Get the new admission code for the selected application*/

    //     AdminSetup.Reset;
    //     AdminSetup.SetRange(AdminSetup.Admin, AdmissionNumber);
    //     if AdminSetup.Find('-') then begin
    //         Customer.Init;
    //         Customer."No." := AdminSetup.Admin;
    //         Customer.Name := CopyStr(AdminSetup.Names, 1, 80);
    //         Customer."Search Name" := UpperCase(CopyStr(AdminSetup.Names, 1, 80));
    //         Customer.Address := AdminSetup.Admin;
    //         if AdminSetup.Admin <> '' then
    //             Customer."Address 2" := CopyStr(AdminSetup."Permanent Residence", 1, 30);

    //         Customer.Gender := AdminSetup.Gender;
    //         Customer."E-Mail" := AdminSetup.Email;
    //         Customer."ID No" := AdminSetup."ID Number/Birth Certificate";

    //         Customer."Date Registered" := Today;
    //         Customer."Customer Type" := Customer."Customer Type"::Student;
    //         //Customer."Student Type":=FORMAT(Enrollment."Student Type");
    //         Customer."Date Of Birth" := AdminSetup."Date of Birth";
    //         // Customer."ID No":=AdminSetup."ID Number/Birth Certificate";
    //         Customer."Application No." := AdminSetup.Admin;
    //         //Customer."Marital Status":=AdminSetup."Marital Status";
    //         //Customer.Citizenship:=FORMAT(AdminSetup.Nationality);
    //         Customer."Current Programme" := AdminSetup.Prog;
    //         Customer."Current Program" := AdminSetup.Prog;
    //         Customer."Current Semester" := AdminSetup.Semester;
    //         Customer."Current Stage" := 'Y1S1';
    //         //Customer.Religion:=FORMAT(AdminSetup.Religion);
    //         Customer."Application Method" := Customer."Application Method"::"Apply to Oldest";
    //         Customer."Customer Posting Group" := 'STUDENT';
    //         Customer.Validate(Customer."Customer Posting Group");
    //         Customer."Global Dimension 1 Code" := 'MAIN';
    //         //Customer.County:=AdminSetup.County;
    //         Customer.Insert();

    //         ////////////////////////////////////////////////////////////////////////////////////////


    //         Customer.Reset;
    //         Customer.SetRange("No.", AdminSetup.Admin);
    //         //Customer.SETFILTER("Date Registered",'=%1',TODAY);
    //         if Customer.Find('-') then begin
    //             if AdminSetup.Gender = AdminSetup.Gender::Female then begin
    //                 Customer.Gender := Customer.Gender::Female;
    //             end else begin
    //                 Customer.Gender := Customer.Gender::Male;
    //             end;
    //             Customer.Modify;
    //         end;

    //         Customer.Reset;
    //         Customer.SetRange("No.", AdminSetup.Admin);
    //         Customer.SetFilter("Date Registered", '=%1', Today);
    //         if Customer.Find('-') then begin
    //             CourseRegistration.Reset;
    //             CourseRegistration.SetRange("Student No.", AdminSetup.Admin);
    //             CourseRegistration.SetRange("Settlement Type", AdminSetup."Settlement Type");
    //             CourseRegistration.SetRange(Programmes, AdminSetup.Prog);
    //             CourseRegistration.SetRange(Semester, AdminSetup.Semester);
    //             if not CourseRegistration.Find('-') then begin
    //                 CourseRegistration.Init;
    //                 CourseRegistration."Reg. Transacton ID" := '';
    //                 CourseRegistration.Validate(CourseRegistration."Reg. Transacton ID");
    //                 CourseRegistration."Student No." := AdminSetup.Admin;
    //                 CourseRegistration.Programmes := AdminSetup.Prog;
    //                 CourseRegistration.Semester := AdminSetup.Semester;
    //                 CourseRegistration.Stage := 'Y1S1';
    //                 CourseRegistration."Student Type" := CourseRegistration."Student Type"::"Full Time";
    //                 CourseRegistration."Registration Date" := Today;
    //                 CourseRegistration."Settlement Type" := AdminSetup."Settlement Type";
    //                 CourseRegistration."Academic Year" := AdminSetup."Academic Year";


    //                 //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
    //                 CourseRegistration.Insert;
    //                 CourseRegistration.Reset;
    //                 CourseRegistration.SetRange("Student No.", AdminSetup.Admin);
    //                 CourseRegistration.SetRange("Settlement Type", AdminSetup."Settlement Type");
    //                 CourseRegistration.SetRange(Programmes, AdminSetup.Prog);
    //                 CourseRegistration.SetRange(Semester, AdminSetup.Semester);
    //                 if CourseRegistration.Find('-') then begin
    //                     CourseRegistration."Settlement Type" := AdminSetup."Settlement Type";
    //                     CourseRegistration.Validate(CourseRegistration."Settlement Type");
    //                     CourseRegistration."Academic Year" := AdminSetup."Academic Year";
    //                     CourseRegistration."Registration Date" := Today;
    //                     CourseRegistration.Validate(CourseRegistration."Registration Date");
    //                     CourseRegistration."Year Of Study" := 1;
    //                     CourseRegistration.Validate("Year Of Study");
    //                     CourseRegistration.Modify;

    //                 end;
    //             end else begin
    //                 CourseRegistration.Reset;
    //                 CourseRegistration.SetRange("Student No.", AdminSetup.Admin);
    //                 CourseRegistration.SetRange("Settlement Type", AdminSetup."Settlement Type");
    //                 CourseRegistration.SetRange(Programmes, AdminSetup.Prog);
    //                 CourseRegistration.SetRange(Semester, AdminSetup.Semester);
    //                 CourseRegistration.SetFilter(Posted, '=%1', false);
    //                 if CourseRegistration.Find('-') then begin
    //                     CourseRegistration."Settlement Type" := AdminSetup."Settlement Type";
    //                     CourseRegistration.Validate(CourseRegistration."Settlement Type");
    //                     CourseRegistration."Academic Year" := AdminSetup."Academic Year";
    //                     CourseRegistration."Registration Date" := Today;
    //                     CourseRegistration.Validate(CourseRegistration."Registration Date");
    //                     CourseRegistration."Year Of Study" := 1;
    //                     CourseRegistration.Validate("Year Of Study");
    //                     CourseRegistration.Modify;
    //                 end;
    //             end;
    //         end;
    //         /*Get the record and transfer the details to the admissions database*/
    //         //ERROR('TEST- '+NewAdminCode);
    //         /*Transfer the details into the admission database table*/
    //         NewAdminCode := AdmissionNumber;
    //         Admissions.Init;
    //         Admissions."Admission No." := NewAdminCode;
    //         Admissions.Validate("Admission No.");
    //         Admissions.Date := Today;
    //         Admissions."Application No." := Format(AdminSetup.ser);
    //         Admissions."Admission Type" := AdminSetup."Settlement Type";
    //         Admissions."Academic Year" := AdminSetup."Academic Year";
    //         Admissions.Surname := AdminSetup.Index;
    //         // Admissions."Other Names":=AdminSetup.Names;
    //         Admissions.Status := Admissions.Status::Admitted;
    //         Admissions."Degree Admitted To" := AdminSetup.Prog;
    //         Admissions.Validate("Degree Admitted To");

    //         Admissions.Gender := AdminSetup.Gender;
    //         Admissions.Campus := 'MAIN';
    //         Admissions."Correspondence Address 1" := AdminSetup.Admin;
    //         Admissions."Telephone No. 1" := AdminSetup.Phone;
    //         Admissions."Telephone No. 2" := AdminSetup.Phone;
    //         Admissions."Index Number" := AdminSetup.Admin;
    //         Admissions."Stage Admitted To" := 'Y1S1';
    //         Admissions."Semester Admitted To" := AdminSetup.Semester;
    //         Admissions."Settlement Type" := AdminSetup."Settlement Type";

    //         Admissions."E-Mail" := AdminSetup.Names;
    //         Admissions.Insert();
    //         AdminSetup.Admin := NewAdminCode;
    //         /*Get the subject details and transfer the  same to the admissions subject*/
    //         ApplicationSubject.Reset;
    //         ApplicationSubject.SetRange(ApplicationSubject."Application No.", AdminSetup.Admin);
    //         if ApplicationSubject.Find('-') then begin
    //             /*Get the last number in the admissions table*/
    //             AdmissionSubject.Reset;
    //             if AdmissionSubject.Find('+') then begin
    //                 LineNo := AdmissionSubject."Line No." + 1;
    //             end
    //             else begin
    //                 LineNo := 1;
    //             end;

    //             /*Insert the new records into the database table*/
    //             repeat
    //                 AdmissionSubject.Init;
    //                 AdmissionSubject."Line No." := LineNo + 1;
    //                 AdmissionSubject."Admission No." := NewAdminCode;
    //                 AdmissionSubject."Subject Code" := ApplicationSubject."Subject Code";
    //                 AdmissionSubject.Grade := AdmissionSubject.Grade;
    //                 AdmissionSubject.Insert();
    //                 LineNo := LineNo + 1;
    //             until ApplicationSubject.Next = 0;
    //         end;
    //         /*Insert the medical conditions into the admission database table containing the medical condition*/
    //         MedicalCondition.Reset;
    //         MedicalCondition.SetRange(MedicalCondition.Mandatory, true);
    //         if MedicalCondition.Find('-') then begin
    //             /*Get the last line number from the medical condition table for the admissions module*/
    //             AdmissionMedical.Reset;
    //             if AdmissionMedical.Find('+') then begin
    //                 LineNo := AdmissionMedical."Line No." + 1;
    //             end
    //             else begin
    //                 LineNo := 1;
    //             end;
    //             AdmissionMedical.Reset;
    //             /*Loop thru the medical conditions*/
    //             repeat
    //                 AdmissionMedical.Init;
    //                 AdmissionMedical."Line No." := LineNo + 1;
    //                 AdmissionMedical."Admission No." := NewAdminCode;
    //                 AdmissionMedical."Medical Condition Code" := MedicalCondition.Code;
    //                 AdmissionMedical.Insert();
    //                 LineNo := LineNo + 1;
    //             until MedicalCondition.Next = 0;
    //         end;
    //         /*Insert the details into the family table*/
    //         MedicalCondition.Reset;
    //         MedicalCondition.SetRange(MedicalCondition.Mandatory, true);
    //         MedicalCondition.SetRange(MedicalCondition.Family, true);
    //         if MedicalCondition.Find('-') then begin
    //             /*Get the last number in the family table*/
    //             AdmissionFamily.Reset;
    //             if AdmissionFamily.Find('+') then begin
    //                 LineNo := AdmissionFamily."Line No.";
    //             end
    //             else begin
    //                 LineNo := 0;
    //             end;
    //             repeat
    //                 AdmissionFamily.Init;
    //                 AdmissionFamily."Line No." := LineNo + 1;
    //                 AdmissionFamily."Medical Condition Code" := MedicalCondition.Code;
    //                 AdmissionFamily."Admission No." := NewAdminCode;
    //                 AdmissionFamily.Insert();
    //                 LineNo := LineNo + 1;
    //             until MedicalCondition.Next = 0;
    //         end;

    //         /*Insert the immunization details into the database*/
    //         Immunization.Reset;
    //         //Immunization.SETRANGE(Immunization.Mandatory,TRUE);
    //         if Immunization.Find('-') then begin
    //             /*Get the last line number from the database*/
    //             AdmissionImmunization.Reset;
    //             if AdmissionImmunization.Find('+') then begin
    //                 LineNo := AdmissionImmunization."Line No." + 1;
    //             end
    //             else begin
    //                 LineNo := 1;
    //             end;
    //             /*loop thru the immunizations table adding the details into the admissions table for immunizations*/
    //             repeat
    //                 AdmissionImmunization.Init;
    //                 AdmissionImmunization."Line No." := LineNo + 1;
    //                 AdmissionImmunization."Admission No." := NewAdminCode;
    //                 AdmissionImmunization."Immunization Code" := Immunization.Code;
    //                 AdmissionImmunization.Insert();
    //             until Immunization.Next = 0;
    //         end;

    //         TakeStudentToRegistration(NewAdminCode);
    //     end;

    // end;

    procedure TakeStudentToRegistration(AdmissNo: Code[20])
    var
        Admissions: Record "ACA-Adm. Form Header";
        AdminKin: Record "ACA-Adm. Form Next of Kin";
        StudentKin: Record "ACA-Student Kin";
        StudentGuardian: Record "ACA-Student Sponsors Details";
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
                    StudentKin."Office Tel No" := AdminKin."Telephone No. 1";
                    StudentKin."Home Tel No" := AdminKin."Telephone No. 2";
                    StudentKin.Insert;
                until AdminKin.Next = 0;
            end;

            //insert the details in relation to the guardian/sponsor into the database in relation to the current student
            if Admissions."Mother Alive Or Dead" = Admissions."Mother Alive Or Dead"::Alive then begin
                if Admissions."Mother Full Name" <> '' then begin
                    StudentGuardian.Reset;
                    StudentGuardian.Init;
                    StudentGuardian."Student No." := Admissions."Admission No.";
                    StudentGuardian.Names := Admissions."Mother Full Name";
                    StudentGuardian.Insert;
                end;
            end;
            if Admissions."Father Alive Or Dead" = Admissions."Father Alive Or Dead"::Alive then begin
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



}
