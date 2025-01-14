#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51250 "ACA-New Stud. Documents"
{
    //DrillDownPageID = UnknownPage77365;
    //LookupPageID = UnknownPage77365;

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
        }
        field(2; "Index Number"; Code[20])
        {
        }
        field(3; "Document Code"; Code[250])
        {
        }
        field(4; Document_Image; Blob)
        {
            SubType = Bitmap;
        }
        field(107; Approver_Id; Code[20])
        {
        }
        field(109; "Approved Date/Time"; DateTime)
        {
        }
        field(110; "Approval Status"; Option)
        {
            OptionCaption = 'Created,Open,Approved,Rejected,Reject Reason';
            OptionMembers = Created,Open,Approved,Rejected,"Reject Reason";
        }
        field(111; "Reject Reason"; Text[150])
        {
        }
        field(112; "Document Uploaded"; Boolean)
        {
        }
        field(113; "Approval Comments"; Text[50])
        {
        }
        field(114; "Approval Sequence"; Integer)
        {
            CalcFormula = lookup("ACA-New Stud. Doc. Setup".Sequence where("Document Code" = field("Document Code"),
                                                                            "Academic Year" = field("Academic Year")));
            FieldClass = FlowField;
        }
        field(115; Sequence; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Academic Year", "Index Number", "Document Code")
        {
            Clustered = true;
        }
        key(Key2; Sequence)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Approval Comments" := 'Missing Attachment';
    end;

    var
        Mails: Codeunit "Send Mails Easy";
        ACANewStudDocSetup: Record "ACA-New Stud. Doc. Setup";
        AdmissionApprovalEntries: Record "Admission Approval Entries";
        KUCCPSImports: Record "Kuccps Imports";
        ACAAdmissionAccomRooms: Record "ACA-Admission Accom. Rooms";
        ACACharge: Record "ACA-Charge";
        AdmissionsBillableItems: Record "Admissions Billable Items";
        ACAStageCharges: Record "ACA-Stage Charges";
        ACAFeeByStage: Record "ACA-Fee By Stage";
        TuitionFeesAmount: Decimal;
        CategoryFundingSources: Record "Category Funding Sources";
        DegreeName1: Text[200];
        DegreeName2: Text[200];
        FacultyName1: Text[200];
        FacultyName2: Text[200];
        NationalityName: Text[200];
        CountryOfOriginName: Text[200];
        Age: Text[200];
        FormerSchoolName: Text[200];
        CustEntry: Record "Cust. Ledger Entry";
        Apps: Record "ACA-Applic. Form Header";
        recProgramme: Record "ACA-Programme";
        FirstChoiceSemesterName: Text[200];
        FirstChoiceStageName: Text[200];
        SecondChoiceSemesterName: Text[200];
        SecondChoiceStageName: Text[200];
        [InDataSet]
        "Principal PassesVisible": Boolean;
        [InDataSet]
        "Subsidiary PassesVisible": Boolean;
        [InDataSet]
        "Mean Grade AcquiredVisible": Boolean;
        [InDataSet]
        "Points AcquiredVisible": Boolean;
        UserMgt: Codeunit "User Management 2";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,Admission;
        ApprovalEntries: Page "Approval Entries";
        AppSetup: Record "ACA-Applic. Setup";
        SettlmentType: Record "ACA-Settlement Type";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Admissions: Record "ACA-Adm. Form Header";
        ApplicationSubject: Record "ACA-Applic. Form Academic";
        AdmissionSubject: Record "ACA-Adm. Form Academic";
        LineNo: Integer;
        PrintAdmission: Boolean;
        MedicalCondition: Record "ACA-Medical Condition";
        Immunization: Record "ACA-Immunization";
        AdmissionMedical: Record "ACA-Adm. Form Medical Form";
        AdmissionImmunization: Record "ACA-Adm. Form Immunization";
        AdmissionFamily: Record "ACA-Adm. Form Family Medical";
        FacultyName: Text[30];
        DegreeName: Text[200];
        AgeText: Text[100];
        ReligionName: Text[30];
        HasValue: Boolean;
        Cust: Record Customer;
        CourseRegistration: Record "ACA-Course Registration";
        StudentKin: Record "ACA-Student Kin";
        AdminKin: Record "ACA-Adm. Form Next of Kin";
        StudentGuardian: Record "ACA-Student Sponsors Details";
        [InDataSet]
        "Guardian Full NameEnable": Boolean;
        [InDataSet]
        "Guardian OccupationEnable": Boolean;
        [InDataSet]
        "Spouse NameEnable": Boolean;
        [InDataSet]
        "Spouse Address 1Enable": Boolean;
        [InDataSet]
        "Spouse Address 2Enable": Boolean;
        [InDataSet]
        "Spouse Address 3Enable": Boolean;
        [InDataSet]
        "Family ProblemEnable": Boolean;
        [InDataSet]
        "Health ProblemEnable": Boolean;
        [InDataSet]
        "Overseas ScholarshipEnable": Boolean;
        [InDataSet]
        "Course Not PreferenceEnable": Boolean;
        [InDataSet]
        EmploymentEnable: Boolean;
        [InDataSet]
        "Other ReasonEnable": Boolean;
        StudDocApp: Record "ACA-New Stud. Documents";


    procedure ApproveDocument(KuCCPSDocApprovals: Record "ACA-New Stud. Documents"; User_Id: Code[20]) ReturnMessage: Text[50]
    var
        HostelCode: Code[20];
        Customs: Record Customer;
    begin
        Clear(KUCCPSImports);
        KUCCPSImports.Reset;
        KUCCPSImports.SetRange("Academic Year", KuCCPSDocApprovals."Academic Year");
        KUCCPSImports.SetRange(Index, KuCCPSDocApprovals."Index Number");
        if KUCCPSImports.Find('-') then;
        ReturnMessage := 'Failed';
        Clear(ACANewStudDocSetup);
        ACANewStudDocSetup.Reset;
        ACANewStudDocSetup.SetRange("Academic Year", KuCCPSDocApprovals."Academic Year");
        ACANewStudDocSetup.SetRange("Document Code", KuCCPSDocApprovals."Document Code");
        if ACANewStudDocSetup.Find('-') then begin
            if ACANewStudDocSetup."Final Stage" = false then
                ACANewStudDocSetup.TestField("Next Sequence");
            Clear(AdmissionApprovalEntries);
            AdmissionApprovalEntries.Reset;
            AdmissionApprovalEntries.SetRange("Document Code", KuCCPSDocApprovals."Document Code");
            AdmissionApprovalEntries.SetRange(Index, KuCCPSDocApprovals."Index Number");
            AdmissionApprovalEntries.SetRange(Approver_Id, User_Id);
            AdmissionApprovalEntries.SetRange("Academic Year", KuCCPSDocApprovals."Academic Year");
            if AdmissionApprovalEntries.Find('-') then begin
                // The user Approved The document
                AdmissionApprovalEntries."Approved The Document" := true;
                AdmissionApprovalEntries."Approval Status" := AdmissionApprovalEntries."approval status"::Approved;
                AdmissionApprovalEntries."Approved Date/Time" := CreateDatetime(Today, Time);
                AdmissionApprovalEntries.Modify;
            end;
            /////////////////////////////////////////////////
            Clear(AdmissionApprovalEntries);
            AdmissionApprovalEntries.Reset;
            AdmissionApprovalEntries.SetRange("Document Code", KuCCPSDocApprovals."Document Code");
            AdmissionApprovalEntries.SetFilter(Approver_Id, '<>%1', User_Id);
            AdmissionApprovalEntries.SetRange(Index, KuCCPSDocApprovals."Index Number");
            AdmissionApprovalEntries.SetRange("Academic Year", KuCCPSDocApprovals."Academic Year");
            if AdmissionApprovalEntries.Find('-') then begin
                // The user Approved The document
                repeat
                begin
                    AdmissionApprovalEntries."Approval Status" := AdmissionApprovalEntries."approval status"::Approved;
                    AdmissionApprovalEntries."Approved Date/Time" := CreateDatetime(Today, Time);
                    AdmissionApprovalEntries.Modify;
                end;
                until AdmissionApprovalEntries.Next = 0;
            end;
            ////////////////////////////////////////////////////////
            KuCCPSDocApprovals."Approval Status" := KuCCPSDocApprovals."approval status"::Approved;
            KuCCPSDocApprovals."Approved Date/Time" := CreateDatetime(Today, Time);
            KuCCPSDocApprovals.Approver_Id := User_Id;
            if KuCCPSDocApprovals.Modify then begin
                //Set Next Level as ready
                Clear(AdmissionApprovalEntries);
                AdmissionApprovalEntries.Reset;
                AdmissionApprovalEntries.SetRange("Approval Sequence", ACANewStudDocSetup."Next Sequence");
                AdmissionApprovalEntries.SetRange(Index, KuCCPSDocApprovals."Index Number");
                AdmissionApprovalEntries.SetRange("Academic Year", KuCCPSDocApprovals."Academic Year");
                if AdmissionApprovalEntries.Find('-') then begin
                    repeat
                    begin
                        AdmissionApprovalEntries.Validate("Approval Status", AdmissionApprovalEntries."approval status"::Open);
                        AdmissionApprovalEntries.Modify;
                    end;
                    until AdmissionApprovalEntries.Next = 0;
                end;
                // Check if Approval Level is final and perform the hard Functions
                if ACANewStudDocSetup."Final Stage" then begin
                    //- Check if Student has Booked for a room, if yes, check if billing for room is done if room still exists
                    // - If Resident, Check if Payment allow for allocation, pick a room if exists
                    Clear(HostelCode);
                    Clear(ACACharge);
                    ACACharge.Reset;
                    ACACharge.SetRange(Hostel, true);
                    if ACACharge.Find('-') then;// HostelCode := ACACharge.Code;
                    if KUCCPSImports.Accomodation = KUCCPSImports.Accomodation::Resident then begin
                        // Check if Room asigned still exists
                        if KUCCPSImports."Assigned Space" = '' then begin
                            //Student Wanted accomodation but delayted in payment and the routine removed the booking, if rooms still exists, check if fee paid meets the requirement
                            Clear(ACAAdmissionAccomRooms);
                            ACAAdmissionAccomRooms.Reset;
                            ACAAdmissionAccomRooms.SetRange("Allocation Status", ACAAdmissionAccomRooms."allocation status"::Vaccant);
                            ACAAdmissionAccomRooms.SetRange("Academic Year", KUCCPSImports."Academic Year");
                            if ACAAdmissionAccomRooms.Find('-') then begin
                                // A room exists, create a booking for the student
                                KUCCPSImports."Assigned Space" := ACAAdmissionAccomRooms."Space Code";
                                KUCCPSImports."Assigned Block" := ACAAdmissionAccomRooms."Block Code";
                                KUCCPSImports."Assigned Room" := ACAAdmissionAccomRooms."Room Code";
                                if KUCCPSImports.Modify then begin
                                    ACAAdmissionAccomRooms."Allocation Status" := ACAAdmissionAccomRooms."allocation status"::Booked;
                                    ACAAdmissionAccomRooms.Modify;
                                end;
                            end;
                        end;
                    end else begin
                        KUCCPSImports."Assigned Space" := '';
                        KUCCPSImports."Assigned Block" := '';
                        KUCCPSImports."Assigned Room" := '';
                        if KUCCPSImports.Modify then;
                    end;
                    if ((KUCCPSImports."Assigned Space" <> '') and (KUCCPSImports.Accomodation = KUCCPSImports.Accomodation::Resident)) then begin
                        // Create Hostel Charge
                        AdmissionsBillableItems.Init;
                        AdmissionsBillableItems.Index := KUCCPSImports.Index;
                        AdmissionsBillableItems.Admin := KUCCPSImports.Admin;
                        AdmissionsBillableItems."Charge Code" := ACACharge.Code;
                        AdmissionsBillableItems."Charge Amount" := ACACharge.Amount;
                        AdmissionsBillableItems."Charge Description" := 'Accomodation Charges';
                        if AdmissionsBillableItems.Insert then;
                    end else begin
                        // Delete hostel Charge if exists
                        Clear(AdmissionsBillableItems);
                        AdmissionsBillableItems.Reset;
                        AdmissionsBillableItems.SetRange(Index, KUCCPSImports.Index);
                        AdmissionsBillableItems.SetRange(Admin, KUCCPSImports.Admin);
                        AdmissionsBillableItems.SetRange("Charge Code", ACACharge.Code);
                        if AdmissionsBillableItems.Find('-') then begin
                            // The student is not a resident, delete the Accomodation Charge for the student...
                            AdmissionsBillableItems.DeleteAll;
                        end;
                    end;
                    ///  *******************************Populate Non-accomodation charges here*************************************
                    // Delete existing non accomodation Charges
                    Clear(AdmissionsBillableItems);
                    AdmissionsBillableItems.Reset;
                    AdmissionsBillableItems.SetRange(Index, KUCCPSImports.Index);
                    AdmissionsBillableItems.SetRange(Admin, KUCCPSImports.Admin);
                    if ACACharge.Code <> '' then
                        AdmissionsBillableItems.SetFilter("Charge Code", '<>%1', ACACharge.Code);
                    if AdmissionsBillableItems.Find('-') then begin
                        AdmissionsBillableItems.DeleteAll;
                    end;
                    Clear(TuitionFeesAmount);
                    // Tuition Fees
                    KUCCPSImports.TestField("Settlement Type");
                    ACAFeeByStage.Reset;
                    ACAFeeByStage.SetRange(ACAFeeByStage."Programme Code", KUCCPSImports.Prog);
                    ACAFeeByStage.SetRange(ACAFeeByStage."Stage Code", 'Y1S1');
                    ACAFeeByStage.SetRange(ACAFeeByStage."Settlemet Type", KUCCPSImports."Settlement Type");
                    ACAFeeByStage.SetFilter(ACAFeeByStage."Break Down", '<>%1', 0);
                    if not ACAFeeByStage.Find('-') then begin
                        Error('No fees structure defined for the settlement type  - ' + KUCCPSImports.Prog + ' - ' + 'Y1S1');
                    end
                    else begin
                        // Pick Tuition Fees & Update the Charges
                        AdmissionsBillableItems.Init;
                        AdmissionsBillableItems.Index := KUCCPSImports.Index;
                        AdmissionsBillableItems.Admin := KUCCPSImports.Admin;
                        AdmissionsBillableItems."Charge Code" := 'Tuition Fees';
                        AdmissionsBillableItems."Charge Amount" := ACAFeeByStage."Break Down";
                        AdmissionsBillableItems."Charge Description" := 'Tuition Fees';
                        if AdmissionsBillableItems.Insert then;
                        TuitionFeesAmount := ACAFeeByStage."Break Down";
                    end;
                    // Update other Charges
                    ACAStageCharges.Reset;
                    ACAStageCharges.SetRange(ACAStageCharges."Programme Code", KUCCPSImports.Prog);
                    ACAStageCharges.SetRange(ACAStageCharges."Stage Code", 'Y1S1');
                    ACAStageCharges.SetRange(ACAStageCharges."Settlement Type", KUCCPSImports."Settlement Type");
                    ACAStageCharges.SetFilter(ACAStageCharges.Amount, '<>%1', 0);
                    if ACAStageCharges.Find('-') then begin
                        repeat
                        begin
                            // Pick charge& Update the Billable Items Table
                            AdmissionsBillableItems.Init;
                            AdmissionsBillableItems.Index := KUCCPSImports.Index;
                            AdmissionsBillableItems.Admin := KUCCPSImports.Admin;
                            AdmissionsBillableItems."Charge Code" := ACAStageCharges.Code;
                            AdmissionsBillableItems."Charge Amount" := ACAStageCharges.Amount;
                            AdmissionsBillableItems."Charge Description" := ACAStageCharges.Description;
                            if AdmissionsBillableItems.Insert then;
                        end;
                        until ACAStageCharges.Next = 0;
                    end;
                    // According to Student Funding Category, Generate entries of -ve into the Billable Items table
                    Clear(AdmissionsBillableItems);
                    AdmissionsBillableItems.Reset;
                    AdmissionsBillableItems.SetRange(Index, KUCCPSImports.Index);
                    AdmissionsBillableItems.SetRange(Admin, KUCCPSImports.Admin);
                    AdmissionsBillableItems.SetFilter("Charge Amount", '<%1', 0);
                    if AdmissionsBillableItems.Find('-') then begin
                        // Clear the funding entries
                        AdmissionsBillableItems.DeleteAll;
                    end;
                    if KUCCPSImports."Funding Category" <> '' then begin
                        Clear(CategoryFundingSources);
                        CategoryFundingSources.Reset;
                        CategoryFundingSources.SetRange("Category Code", KUCCPSImports."Funding Category");
                        CategoryFundingSources.SetFilter("Funding %", '>0', 0);
                        if CategoryFundingSources.Find('-') then begin
                            repeat
                            begin
                                // Pick funding Parameters and Populate into billable Items with -ve Values
                                if TuitionFeesAmount > 0 then begin
                                    AdmissionsBillableItems.Init;
                                    AdmissionsBillableItems.Index := KUCCPSImports.Index;
                                    AdmissionsBillableItems.Admin := KUCCPSImports.Admin;
                                    AdmissionsBillableItems."Charge Code" := CategoryFundingSources."Category Code" + '-' + CategoryFundingSources."Funding Source Code";
                                    AdmissionsBillableItems."Charge Amount" := -(TuitionFeesAmount * (CategoryFundingSources."Funding %" / 100));
                                    AdmissionsBillableItems."Charge Description" := CategoryFundingSources."Category Code" +
                                    '-' + CategoryFundingSources."Funding Source Code" +
                                    ' (' + Format(CategoryFundingSources."Funding %") + ')';
                                    if AdmissionsBillableItems.Insert then;
                                end;
                            end;
                            until CategoryFundingSources.Next = 0;
                        end;
                    end;
                    // Check if fees is Met and Admit Student
                    KUCCPSImports.CalcFields(Billable_Amount, "Receipt Amount");
                    if KUCCPSImports.Billable_Amount > KUCCPSImports."Receipt Amount" then begin
                        if KUCCPSImports.Accomodation = KUCCPSImports.Accomodation::Resident then begin
                            if KUCCPSImports."Receipt Amount" < 6500 then
                                Error('Fee policy error!');
                        end;
                    end;
                    //Admit Student
                    AdmitStudent(KUCCPSImports);
                    Clear(Customs);
                    Customs.Reset;
                    Customs.SetRange("No.", KUCCPSImports.Admin);
                    if Customs.Find('-') then begin
                        //Post Receipts for the Student if not yet posted
                        PostReceiptsFromBuffer(Customs);
                        //Post Billing for Tuition and other Charges
                        ////////////***************************************************************************************
                        //      PostStudentcharges(Customs);                 Do not post Charges
                        //Allocate a room and post allocation
                        if KUCCPSImports."Assigned Space" <> '' then begin
                            // The student Booked for a space in the halls of residence
                            AllocateStudentHostel(KUCCPSImports);
                        end;
                    end;
                    //Send Login Credentials to the student via SMS and email
                    SendAdmissionMailsHere(KUCCPSImports);
                    "Approval Comments" := 'Approved';
                end;
            end;
        end;

        ReturnMessage := Format(KuCCPSDocApprovals."Document Code") + ' Approved!';
    end;


    procedure RejectDocument(DocCode: Code[50]; AcademicYear: Code[20]; User_Id: Code[20]; IndexNumber: Code[20])
    var
        KuCCPSDocApprovals: Record "ACA-New Stud. Documents";
    begin
        //IF CONFIRM('Reject?',FALSE) = FALSE THEN ERROR('Cancelled!');
        Clear(KuCCPSDocApprovals);
        KuCCPSDocApprovals.Reset;
        KuCCPSDocApprovals.SetRange("Document Code", DocCode);
        KuCCPSDocApprovals.SetRange("Index Number", IndexNumber);
        KuCCPSDocApprovals.SetRange("Academic Year", AcademicYear);
        if KuCCPSDocApprovals.Find('-') then;
        //KuCCPSDocApprovals.RejectDocument(Rec."Document Code",AcademicYear,User_Id,IndexNumber);
    end;

    local procedure AdmitStudent(ACAAdmImportedJABBuffer: Record "Kuccps Imports")
    var
        ACAApplicFormHeader: Record "ACA-Applic. Form Header";
        Applications: Record "ACA-Applic. Form Header";
        SettlementType: Record "ACA-Settlement Type";
        ACASemesters: Record "ACA-Semesters";
        ACAIntake: Record "ACA-Intake";
    begin
        //  REPORT.RUN(51348,FALSE,FALSE,ACAAdmImportedJABBuffer); // Process Admission for Selected Student
        /*This function processes the JAB admission and takes them to the Applications list*/
        Clear(ACASemesters);
        ACASemesters.Reset;
        ACASemesters.SetRange("Current Semester", true);
        if ACASemesters.Find('-') then;
        Clear(ACAIntake);
        ACAIntake.Reset;
        ACAIntake.SetRange(Current, true);
        if ACAIntake.Find('-') then;
        SettlementType.Get(KUCCPSImports."Settlement Type");
        Applications."Application No." := ACAAdmImportedJABBuffer.Index;
        Applications.Date := Today;
        //SplitNames(Names,Applications.Surname,Applications."Other Names");
        Applications.Surname := ACAAdmImportedJABBuffer.Names;
        Applications."Application Date" := Today;
        if ACAAdmImportedJABBuffer.Gender = ACAAdmImportedJABBuffer.Gender::Male then
            Applications.Gender := Applications.Gender::Male
        else if ACAAdmImportedJABBuffer.Gender = ACAAdmImportedJABBuffer.Gender::Female then
            Applications.Gender := Applications.Gender::Female;
        Applications."Marital Status" := Applications."marital status"::Single;
        Applications.Nationality := 'KENYAN';

        Applications."Address for Correspondence1" := ACAAdmImportedJABBuffer.Box;
        Applications."Address for Correspondence2" := ACAAdmImportedJABBuffer.Codes;
        Applications."Address for Correspondence3" := ACAAdmImportedJABBuffer.Town;
        Applications."Telephone No. 1" := ACAAdmImportedJABBuffer.Phone;
        Applications."Telephone No. 2" := ACAAdmImportedJABBuffer."Alt. Phone";
        Applications.Email := ACAAdmImportedJABBuffer.Email;
        Applications."Emergency Email" := ACAAdmImportedJABBuffer."Slt Mail";
        Applications."Country of Origin" := 'KENYA';
        Applications."First Degree Choice" := ACAAdmImportedJABBuffer.Prog;
        Applications."Date of Receipt" := Today;
        Applications."User ID" := UserId;
        Applications."Date of Admission" := Today;
        Applications."Application Form Receipt No." := '';
        Applications."Index Number" := ACAAdmImportedJABBuffer.Index;
        Applications.Status := Applications.Status::"Provisional Admission";
        Applications."Admission Board Recommendation" := 'Admitted Through ' + ACAAdmImportedJABBuffer."Settlement Type";
        Applications."Admission Board Date" := Today;
        Applications."Admission Board Time" := Time;
        Applications."Admitted Degree" := ACAAdmImportedJABBuffer.Prog;
        Applications."Date Of Meeting" := Today;
        Applications."Date Of Receipt Slip" := Today;
        Applications."Receipt Slip No." := '';
        Applications."Academic Year" := ACAAdmImportedJABBuffer."Academic Year";
        Applications."Admission No" := ACAAdmImportedJABBuffer.Admin;
        Applications."Admitted To Stage" := 'Y1S1';
        Applications."Admitted Semester" := ACASemesters.Code;
        Applications."First Choice Stage" := 'Y1S1';
        Applications."First Choice Semester" := ACASemesters.Code;
        Applications."Intake Code" := ACAIntake.Code;
        Applications."Settlement Type" := ACAAdmImportedJABBuffer."Settlement Type";
        Applications."ID Number" := ACAAdmImportedJABBuffer."ID Number/BirthCert";
        Applications."Date Sent for Approval" := Today;
        Applications."Issued Date" := Today;
        Applications.Campus := 'MAIN';
        Applications."Admissable Status" := 'QUALIFY';
        Applications."Mode of Study" := 'FULL TIME';
        Applications."Responsibility Center" := 'MAIN';
        Applications."First Choice Qualify" := true;
        Applications."Programme Level" := Applications."programme level"::Undergraduate;
        Applications."Admission Comments" := 'Admitted through the ' + ACAAdmImportedJABBuffer."Settlement Type";
        Applications."Knew College Thru" := ACAAdmImportedJABBuffer."Settlement Type";
        Applications."First Choice Category" := Applications."first choice category"::Undergraduate;
        Applications."Date Of Birth" := ACAAdmImportedJABBuffer."Date of Birth";
        Applications.County := ACAAdmImportedJABBuffer.County;
        Applications.Phone := ACAAdmImportedJABBuffer.Phone;
        Applications."Alt. Phone" := ACAAdmImportedJABBuffer."Alt. Phone";
        Applications.Box := ACAAdmImportedJABBuffer.Box;
        Applications.Town := ACAAdmImportedJABBuffer.Town;
        Applications."NHIF No" := ACAAdmImportedJABBuffer."NHIF No";
        Applications.Location := ACAAdmImportedJABBuffer.Location;
        Applications."Name of Chief" := ACAAdmImportedJABBuffer."Name of Chief";
        Applications."Sub-County" := ACAAdmImportedJABBuffer."Sub-County";
        Applications.Constituency := ACAAdmImportedJABBuffer.Constituency;
        Applications."OLevel School" := ACAAdmImportedJABBuffer."OLevel School";
        Applications."OLevel Year Completed" := KUCCPSImports."OLevel Year Completed";
        if KUCCPSImports.Gender = KUCCPSImports.Gender::Female then
            Applications.Gender := Applications.Gender::Female
        else if KUCCPSImports.Gender = KUCCPSImports.Gender::Male then
            Applications.Gender := Applications.Gender::Male;
        if Applications.Insert then;
        ACAAdmImportedJABBuffer.Processed := true;
        ACAAdmImportedJABBuffer.Modify;

        //Admit student
        Clear(ACAApplicFormHeader);
        ACAApplicFormHeader.Reset;
        ACAApplicFormHeader.SetRange("Admission No", ACAAdmImportedJABBuffer.Admin);
        if ACAApplicFormHeader.Find('-') then begin

            ACAApplicFormHeader."Documents Verification Remarks" := 'Approved';

            ACAApplicFormHeader.Status := ACAApplicFormHeader.Status::Approved;
            ACAApplicFormHeader.Validate(Status);
            ACAApplicFormHeader."Documents Verified" := true;
            ACAApplicFormHeader."Payments Verified" := true;
            ACAApplicFormHeader.Modify;

            TransferToAdmission(ACAApplicFormHeader."Admission No", ACAApplicFormHeader);

        end;

    end;

    local procedure AllocateStudentHostel(KUCCPSImports12: Record "Kuccps Imports")
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
        VATEntry: Record "Vendor Ledger Entry";
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
        //Check the Policy
        /*semz.RESET;
       semz.SETRANGE(semz."Current Semester",TRUE);
       IF semz.FIND('-') THEN;
        ACAStudentsHostelRooms.INIT;
        ACAStudentsHostelRooms.Student := KUCCPSImports12.Admin;
        ACAStudentsHostelRooms."Space No" := KUCCPSImports12."Assigned Space";
        ACAStudentsHostelRooms."Room No" := KUCCPSImports12."Assigned Room";
        ACAStudentsHostelRooms."Hostel No" := KUCCPSImports12."Assigned Block";
        ACAStudentsHostelRooms."Academic Year"  := semz."Academic Year";
        ACAStudentsHostelRooms.Semester := semz.Code;
        ACAStudentsHostelRooms.INSERT;

       CLEAR(ACAStudentsHostelRooms12);
       ACAStudentsHostelRooms12.RESET;
       ACAStudentsHostelRooms12.SETRANGE(Student,KUCCPSImports12.Admin);
       ACAStudentsHostelRooms12.SETRANGE("Space No",KUCCPSImports12."Assigned Space");
       ACAStudentsHostelRooms12.SETRANGE("Room No",KUCCPSImports12."Assigned Room");
       ACAStudentsHostelRooms12.SETRANGE("Hostel No",KUCCPSImports12."Assigned Block");
       ACAStudentsHostelRooms12.SETRANGE("Academic Year",semz."Academic Year");
       ACAStudentsHostelRooms12.SETRANGE(Semester,semz.Code);
       IF ACAStudentsHostelRooms12.FIND('-') THEN BEGIN
         WITH ACAStudentsHostelRooms12 DO BEGIN
        IF KUCCPSImports12."Assigned Space" = '' THEN EXIT;
        TESTFIELD(Allocated,FALSE);
        IF Cust.GET(Student) THEN BEGIN
           Cust.CALCFIELDS(Cust.Balance);

         CReg.RESET;
         CReg.SETRANGE(CReg."Student No.",Cust."No.");
         IF semz.FIND('-') THEN
         CReg.SETRANGE(CReg.Semester,semz.Code);
         CReg.SETRANGE(CReg.Posted,TRUE);
         IF CReg.FIND('-') THEN BEGIN  //2
         CReg.CALCFIELDS(CReg."Total Billed");
         IF CReg."Total Billed"<>0 THEN BEGIN  // 1
       //  IF Cust.Balance>(CReg."Total Billed"/2) THEN ERROR('Fees payment Accommodation policy error--Balance');
         allocations.RESET;
         allocations.SETRANGE(allocations.Student,Cust."No.");
         allocations.SETRANGE(allocations."Hostel No",Cust."Hostel No.");
         allocations.SETRANGE(allocations."Room No",Cust."Room Code");
         allocations.SETRANGE(allocations."Space No",Cust."Space Booked");
       //allocations.SETRANGE(allocations."Academic Year","Academic Year");
         allocations.SETRANGE(allocations.Semester,Cust.Semester);
        // IF Allocations.FIND('-') THEN
        // REPORT.RUN(52017900,TRUE,FALSE,Allocations);
         END ELSE BEGIN  //1
         ERROR('Fees payment Accommodation policy error --Billing');
         END; //1
         END ELSE BEGIN //2
         ERROR('Fees payment Accommodation policy error --Registration');
         END; //rec.2
        END;

         CLEAR(settlementType);
        Cust.RESET;
        Cust.SETRANGE(Cust."No.",Student);
        IF Cust.FIND ('-') THEN
        IF Cust."Hostel Black Listed"=FALSE THEN
        BEGIN
        // IF CONFIRM('Allocate the Specified Room?', TRUE)=FALSE THEN ERROR('Cancelled by user!');
         Creg1.RESET;
         Creg1.SETRANGE(Creg1."Student No.",Student);
         Creg1.SETRANGE(Creg1.Semester,Semester);
       //  Creg1.SETRANGE(Creg1."Academic Year","Academic Year");
         IF Creg1.FIND('-') THEN BEGIN
           // Check if Prog is Special
           IF prog.GET(Creg1.Programme) THEN BEGIN
             IF prog."Special Programme" THEN
             settlementType:=settlementType::"Special Programme"
             ELSE IF Creg1."Settlement Type"='PSSP' THEN settlementType:=settlementType::SSP
             ELSE settlementType:=settlementType::JAB;
           END;

         END;

           BookRoom(settlementType,ACAStudentsHostelRooms12);
           // Assign Items
           hostcard.RESET;
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
                   studItemInv.INSERT(TRUE);
                 END;
               UNTIL invItems.NEXT=0;
             END;
           END;
        END;
        END;
        END;
        */

    end;

    local procedure PostStudentcharg(custStudent: Record Customer)
    var
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
        VATEntry: Record "Vendor Ledger Entry";
        CReg: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        ChangeLog: Record "Change Log Entry";
        CurrentBal: Decimal;
        Prog: Record "ACA-Programme";
        "Settlement Type": Record "ACA-Settlement Type";
        AccPayment: Boolean;
        SettlementType: Code[20];
        SettlementTypes: Record "ACA-Settlement Type";
    begin
        // // // // // // // // // // // WITH custStudent DO BEGIN
        // // // // // // // // // // //  //BILLING
        // // // // // // // // // // // AccPayment:=FALSE;
        // // // // // // // // // // // CLEAR(StudentCharges);
        // // // // // // // // // // // StudentCharges.RESET;
        // // // // // // // // // // // StudentCharges.SETRANGE(StudentCharges."Student No.","No.");
        // // // // // // // // // // // StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
        // // // // // // // // // // // StudentCharges.SETFILTER(StudentCharges.Code,'<>%1','') ;
        // // // // // // // // // // // IF StudentCharges.FIND('-') THEN BEGIN
        // // // // // // // // // // // //IF NOT CONFIRM('Un-billed charges will be posted. Do you wish to continue?',FALSE) = TRUE THEN
        // // // // // // // // // // // // ERROR('You have selected to Abort Student Billing');
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // SettlementType:='';
        // // // // // // // // // // // CLEAR(CReg);
        // // // // // // // // // // // CReg.RESET;
        // // // // // // // // // // // CReg.SETFILTER(CReg."Settlement Type",'<>%1','');
        // // // // // // // // // // // CReg.SETRANGE(CReg."Student No.","No.");
        // // // // // // // // // // // IF CReg.FIND('-') THEN
        // // // // // // // // // // // SettlementType:=CReg."Settlement Type"
        // // // // // // // // // // // ELSE
        // // // // // // // // // // // ERROR('The Settlement Type Does not Exists in the Course Registration');
        // // // // // // // // // // //
        // // // // // // // // // // // SettlementTypes.GET(SettlementType);
        // // // // // // // // // // // SettlementTypes.TESTFIELD(SettlementTypes."Tuition G/L Account");
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // // MANUAL APPLICATION OF ACCOMODATION FOR PREPAYED STUDENTS BY W-Tripple T...//
        // // // // // // // // // // // IF StudentCharges.COUNT=1 THEN BEGIN
        // // // // // // // // // // // CALCFIELDS(Balance);
        // // // // // // // // // // // IF Balance<0 THEN BEGIN
        // // // // // // // // // // // IF ABS(Balance)>StudentCharges.Amount THEN BEGIN
        // // // // // // // // // // // "Application Method":="Application Method"::Manual;
        // // // // // // // // // // // AccPayment:=TRUE;
        // // // // // // // // // // // MODIFY;
        // // // // // // // // // // // END;
        // // // // // // // // // // // END;
        // // // // // // // // // // // END;
        // // // // // // // // // // //
        // // // // // // // // // // // END;
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // //ERROR('TESTING '+FORMAT("Application Method"));
        // // // // // // // // // // //
        // // // // // // // // // // // IF Cust.GET("No.") THEN;
        // // // // // // // // // // //
        // // // // // // // // // // // GenJnl.RESET;
        // // // // // // // // // // // GenJnl.SETRANGE("Journal Template Name",'SALES');
        // // // // // // // // // // // GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
        // // // // // // // // // // // GenJnl.DELETEALL;
        // // // // // // // // // // //
        // // // // // // // // // // // GenSetUp.GET();
        // // // // // // // // // // // //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
        // // // // // // // // // // //
        // // // // // // // // // // // //Charge Student if not charged
        // // // // // // // // // // // StudentCharges.RESET;
        // // // // // // // // // // // StudentCharges.SETRANGE(StudentCharges."Student No.","No.");
        // // // // // // // // // // // StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
        // // // // // // // // // // // IF StudentCharges.FIND('-') THEN BEGIN
        // // // // // // // // // // //
        // // // // // // // // // // // REPEAT
        // // // // // // // // // // // IF StudentCharges.Amount<>0 THEN BEGIN
        // // // // // // // // // // // DueDate:=StudentCharges.Date;
        // // // // // // // // // // // IF Sems.GET(StudentCharges.Semester) THEN BEGIN
        // // // // // // // // // // // IF Sems.From<>0D THEN BEGIN
        // // // // // // // // // // // IF Sems.From > DueDate THEN
        // // // // // // // // // // // DueDate:=Sems.From;
        // // // // // // // // // // // END;
        // // // // // // // // // // // END;
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // GenJnl.INIT;
        // // // // // // // // // // // GenJnl."Line No." := GenJnl."Line No." + 10000;
        // // // // // // // // // // // GenJnl."Posting Date":=TODAY;
        // // // // // // // // // // // GenJnl."Document No.":=StudentCharges."Transacton ID";
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Document No.");
        // // // // // // // // // // // GenJnl."Journal Template Name":='SALES';
        // // // // // // // // // // // GenJnl."Journal Batch Name":='STUD PAY';
        // // // // // // // // // // // GenJnl."Account Type":=GenJnl."Account Type"::Customer;
        // // // // // // // // // // // //
        // // // // // // // // // // // IF Cust.GET("No.") THEN BEGIN
        // // // // // // // // // // // IF Cust."Bill-to Customer No." <> '' THEN
        // // // // // // // // // // // GenJnl."Account No.":=Cust."Bill-to Customer No."
        // // // // // // // // // // // ELSE
        // // // // // // // // // // // GenJnl."Account No.":="No.";
        // // // // // // // // // // // END;
        // // // // // // // // // // //
        // // // // // // // // // // // GenJnl.Amount:=StudentCharges.Amount;
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Account No.");
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl.Amount);
        // // // // // // // // // // // GenJnl.Description:=COPYSTR(StudentCharges.Description,1,50);
        // // // // // // // // // // // GenJnl."Bal. Account Type":=GenJnl."Account Type"::"G/L Account";
        // // // // // // // // // // //
        // // // // // // // // // // // IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") AND
        // // // // // // // // // // //   (StudentCharges.Charge = FALSE) THEN BEGIN
        // // // // // // // // // // // GenJnl."Bal. Account No.":=SettlementTypes."Tuition G/L Account";
        // // // // // // // // // // //
        // // // // // // // // // // // CReg.RESET;
        // // // // // // // // // // // CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
        // // // // // // // // // // // CReg.SETRANGE(CReg."Reg. Transacton ID",StudentCharges."Reg. Transacton ID");
        // // // // // // // // // // // CReg.SETRANGE(CReg."Student No.",StudentCharges."Student No.");
        // // // // // // // // // // // IF CReg.FIND('-') THEN BEGIN
        // // // // // // // // // // // IF CReg."Register for"=CReg."Register for"::Stage THEN BEGIN
        // // // // // // // // // // // Stages.RESET;
        // // // // // // // // // // // Stages.SETRANGE(Stages."Programme Code",creg.programmes);
        // // // // // // // // // // // Stages.SETRANGE(Stages.Code,CReg.Stage);
        // // // // // // // // // // // IF Stages.FIND('-') THEN BEGIN
        // // // // // // // // // // // IF (Stages."Modules Registration" = TRUE) AND (Stages."Ignore No. Of Units"= FALSE) THEN BEGIN
        // // // // // // // // // // // CReg.CALCFIELDS(CReg."Units Taken");
        // // // // // // // // // // // IF CReg. Modules <> CReg."Units Taken" THEN
        // // // // // // // // // // // ERROR('Units Taken must be equal to the no of modules registered for.');
        // // // // // // // // // // //
        // // // // // // // // // // // END;
        // // // // // // // // // // // END;
        // // // // // // // // // // // END;
        // // // // // // // // // // //
        // // // // // // // // // // // CReg.Posted:=TRUE;
        // // // // // // // // // // // CReg.MODIFY;
        // // // // // // // // // // // END;
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // END ELSE IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") AND
        // // // // // // // // // // //            (StudentCharges.Charge = FALSE) THEN BEGIN
        // // // // // // // // // // // //GenJnl."Bal. Account No.":=GenSetUp."Pre-Payment Account";
        // // // // // // // // // // // StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
        // // // // // // // // // // // GenJnl."Bal. Account No.":=SettlementTypes."Tuition G/L Account";
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // CReg.RESET;
        // // // // // // // // // // // CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
        // // // // // // // // // // // CReg.SETRANGE(CReg."Reg. Transacton ID",StudentCharges."Reg. Transacton ID");
        // // // // // // // // // // // IF CReg.FIND('-') THEN BEGIN
        // // // // // // // // // // // CReg.Posted:=TRUE;
        // // // // // // // // // // // CReg.MODIFY;
        // // // // // // // // // // // END;
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // END ELSE IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" THEN BEGIN
        // // // // // // // // // // // IF ExamsByStage.GET(StudentCharges.Programme,StudentCharges.Stage,StudentCharges.Semester,StudentCharges.Code) THEN
        // // // // // // // // // // // GenJnl."Bal. Account No.":=ExamsByStage."G/L Account";
        // // // // // // // // // // //
        // // // // // // // // // // // END ELSE IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" THEN BEGIN
        // // // // // // // // // // // IF ExamsByUnit.GET(StudentCharges.Programme,StudentCharges.Stage,ExamsByUnit."Unit Code",StudentCharges.Semester,
        // // // // // // // // // // // StudentCharges.Code) THEN
        // // // // // // // // // // // GenJnl."Bal. Account No.":=ExamsByUnit."G/L Account";
        // // // // // // // // // // //
        // // // // // // // // // // // END ELSE IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges) OR
        // // // // // // // // // // //            (StudentCharges.Charge = TRUE) THEN BEGIN
        // // // // // // // // // // // IF Charges.GET(StudentCharges.Code) THEN
        // // // // // // // // // // // GenJnl."Bal. Account No.":=Charges."G/L Account";
        // // // // // // // // // // // END;
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Bal. Account No.");
        // // // // // // // // // // // GenJnl."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
        // // // // // // // // // // // IF Prog.GET(StudentCharges.Programme) THEN BEGIN
        // // // // // // // // // // // Prog.TESTFIELD(Prog."Department Code");
        // // // // // // // // // // // GenJnl."Shortcut Dimension 2 Code":=Prog."Department Code";
        // // // // // // // // // // // END;
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
        // // // // // // // // // // // GenJnl."Due Date":=DueDate;
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Due Date");
        // // // // // // // // // // // IF StudentCharges."Recovery Priority" <> 0 THEN
        // // // // // // // // // // // GenJnl."Recovery Priority":=StudentCharges."Recovery Priority"
        // // // // // // // // // // // ELSE
        // // // // // // // // // // // GenJnl."Recovery Priority":=25;
        // // // // // // // // // // // GenJnl.INSERT;
        // // // // // // // // // // //
        // // // // // // // // // // // //Distribute Money
        // // // // // // // // // // // IF StudentCharges."Tuition Fee" = TRUE THEN BEGIN
        // // // // // // // // // // // IF Stages.GET(StudentCharges.Programme,StudentCharges.Stage) THEN BEGIN
        // // // // // // // // // // // IF (Stages."Distribution Full Time (%)" > 0) OR (Stages."Distribution Part Time (%)" > 0) THEN BEGIN
        // // // // // // // // // // // Stages.TESTFIELD(Stages."Distribution Account");
        // // // // // // // // // // // StudentCharges.TESTFIELD(StudentCharges.Distribution);
        // // // // // // // // // // // IF Cust.GET("No.") THEN BEGIN
        // // // // // // // // // // // CustPostGroup.GET(Cust."Customer Posting Group");
        // // // // // // // // // // //
        // // // // // // // // // // // GenJnl.INIT;
        // // // // // // // // // // // GenJnl."Line No." := GenJnl."Line No." + 10000;
        // // // // // // // // // // // GenJnl."Posting Date":=TODAY;
        // // // // // // // // // // // GenJnl."Document No.":=StudentCharges."Transacton ID";
        // // // // // // // // // // // //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Document No.");
        // // // // // // // // // // // GenJnl."Journal Template Name":='SALES';
        // // // // // // // // // // // GenJnl."Journal Batch Name":='STUD PAY';
        // // // // // // // // // // // GenJnl."Account Type":=GenJnl."Account Type"::"G/L Account";
        // // // // // // // // // // // //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
        // // // // // // // // // // // GenJnl."Account No.":=SettlementTypes."Tuition G/L Account";
        // // // // // // // // // // // GenJnl.Amount:=StudentCharges.Amount * (StudentCharges.Distribution/100);
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Account No.");
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl.Amount);
        // // // // // // // // // // // GenJnl.Description:='Fee Distribution';
        // // // // // // // // // // // GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
        // // // // // // // // // // // //GenJnl."Bal. Account No.":=Stages."Distribution Account";
        // // // // // // // // // // //
        // // // // // // // // // // // StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
        // // // // // // // // // // // SettlementTypes.GET(StudentCharges."Settlement Type");
        // // // // // // // // // // // GenJnl."Bal. Account No.":=SettlementTypes."Tuition G/L Account";
        // // // // // // // // // // //
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Bal. Account No.");
        // // // // // // // // // // // GenJnl."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
        // // // // // // // // // // // IF Prog.GET(StudentCharges.Programme) THEN BEGIN
        // // // // // // // // // // // Prog.TESTFIELD(Prog."Department Code");
        // // // // // // // // // // // GenJnl."Shortcut Dimension 2 Code":=Prog."Department Code";
        // // // // // // // // // // // END;
        // // // // // // // // // // //
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
        // // // // // // // // // // //
        // // // // // // // // // // // GenJnl.INSERT;
        // // // // // // // // // // //
        // // // // // // // // // // // END;
        // // // // // // // // // // // END;
        // // // // // // // // // // // END;
        // // // // // // // // // // // END ELSE BEGIN
        // // // // // // // // // // // //Distribute Charges
        // // // // // // // // // // // IF StudentCharges.Distribution > 0 THEN BEGIN
        // // // // // // // // // // // StudentCharges.TESTFIELD(StudentCharges."Distribution Account");
        // // // // // // // // // // // IF Charges.GET(StudentCharges.Code) THEN BEGIN
        // // // // // // // // // // // Charges.TESTFIELD(Charges."G/L Account");
        // // // // // // // // // // // GenJnl.INIT;
        // // // // // // // // // // // GenJnl."Line No." := GenJnl."Line No." + 10000;
        // // // // // // // // // // // GenJnl."Posting Date":=TODAY;
        // // // // // // // // // // // GenJnl."Document No.":=StudentCharges."Transacton ID";
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Document No.");
        // // // // // // // // // // // GenJnl."Journal Template Name":='SALES';
        // // // // // // // // // // // GenJnl."Journal Batch Name":='STUD PAY';
        // // // // // // // // // // // GenJnl."Account Type":=GenJnl."Account Type"::"G/L Account";
        // // // // // // // // // // // GenJnl."Account No.":=StudentCharges."Distribution Account";
        // // // // // // // // // // // GenJnl.Amount:=StudentCharges.Amount * (StudentCharges.Distribution/100);
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Account No.");
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl.Amount);
        // // // // // // // // // // // GenJnl.Description:='Fee Distribution';
        // // // // // // // // // // // GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
        // // // // // // // // // // // GenJnl."Bal. Account No.":=Charges."G/L Account";
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Bal. Account No.");
        // // // // // // // // // // // GenJnl."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
        // // // // // // // // // // //
        // // // // // // // // // // // IF Prog.GET(StudentCharges.Programme) THEN BEGIN
        // // // // // // // // // // // Prog.TESTFIELD(Prog."Department Code");
        // // // // // // // // // // // GenJnl."Shortcut Dimension 2 Code":=Prog."Department Code";
        // // // // // // // // // // // END;
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
        // // // // // // // // // // // GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
        // // // // // // // // // // // GenJnl.INSERT;
        // // // // // // // // // // //
        // // // // // // // // // // // END;
        // // // // // // // // // // // END;
        // // // // // // // // // // // END;
        // // // // // // // // // // // //End Distribution
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // StudentCharges.Recognized:=TRUE;
        // // // // // // // // // // // StudentCharges.MODIFY;
        // // // // // // // // // // // //.......BY W-Tripple T
        // // // // // // // // // // // StudentCharges.Posted:=TRUE;
        // // // // // // // // // // // StudentCharges.MODIFY;
        // // // // // // // // // // //
        // // // // // // // // // // // CReg.Posted:=TRUE;
        // // // // // // // // // // // CReg.MODIFY;
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // //.....END W-Tripple T
        // // // // // // // // // // // END;
        // // // // // // // // // // // UNTIL StudentCharges.NEXT = 0;
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // //Post New
        // // // // // // // // // // // GenJnl.RESET;
        // // // // // // // // // // // GenJnl.SETRANGE("Journal Template Name",'SALES');
        // // // // // // // // // // // GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
        // // // // // // // // // // // IF GenJnl.FIND('-') THEN BEGIN
        // // // // // // // // // // // CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill",GenJnl);
        // // // // // // // // // // // END;
        // // // // // // // // // // //
        // // // // // // // // // // // //Post New
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // "Application Method":="Application Method"::"Apply to Oldest";
        // // // // // // // // // // // Cust.Status:=Cust.Status::Current;
        // // // // // // // // // // // Cust.MODIFY;
        // // // // // // // // // // //
        // // // // // // // // // // // END;
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // //BILLING
        // // // // // // // // // // //
        // // // // // // // // // // // StudentPayments.RESET;
        // // // // // // // // // // // StudentPayments.SETRANGE(StudentPayments."Student No.","No.");
        // // // // // // // // // // // IF StudentPayments.FIND('-') THEN
        // // // // // // // // // // // StudentPayments.DELETEALL;
        // // // // // // // // // // //
        // // // // // // // // // // //
        // // // // // // // // // // // StudentPayments.RESET;
        // // // // // // // // // // // StudentPayments.SETRANGE(StudentPayments."Student No.","No.");
        // // // // // // // // // // // IF AccPayment=TRUE THEN BEGIN
        // // // // // // // // // // // IF Cust.GET("No.") THEN
        // // // // // // // // // // // Cust."Application Method":=Cust."Application Method"::"Apply to Oldest";
        // // // // // // // // // // // Cust. MODIFY;
        // // // // // // // // // // // END;
        // // // // // // // // // // //  END;
    end;

    local procedure PostReceiptsFromBuffer(CustStudent4Receipting: Record Customer)
    var
        CoreBankingDetails: Record Core_Banking_Details;
        ACAStudentReceipts: Record "ACA-Std Payments";
        ACACourseRegistration: Record "ACA-Course Registration";
        ACAStudentReceipts2: Record "ACA-Std Payments";
    begin
        Clear(ACACourseRegistration);
        ACACourseRegistration.Reset;
        ACACourseRegistration.SetRange("Student No.", CustStudent4Receipting."No.");
        ACACourseRegistration.SetRange(Reversed, false);
        if ACACourseRegistration.Find('-') then;
        Clear(CoreBankingDetails);
        CoreBankingDetails.Reset;
        CoreBankingDetails.SetRange("Student No.", CustStudent4Receipting."No.");
        CoreBankingDetails.SetRange(Posted, false);
        if CoreBankingDetails.Find('-') then begin
            repeat
            begin
                ACAStudentReceipts.Init;
                ACAStudentReceipts."Student No." := CoreBankingDetails."Student No.";
                ACAStudentReceipts."User ID" := UserId;
                ACAStudentReceipts."Cheque No" := CoreBankingDetails."Transaction Number";
                ACAStudentReceipts."Drawer Name" := 'AUTO';
                // ACAStudentReceipts."Drawer Bank" := ACAStudentReceipts."Drawer Bank"::;
                ACAStudentReceipts."Amount to pay" := CoreBankingDetails."Trans. Amount";
                ACAStudentReceipts."Payment Mode" := ACAStudentReceipts."payment mode"::"Bank Slip";
                ACAStudentReceipts.Programme := ACACourseRegistration.Programmes;
                ACAStudentReceipts."Bank No." := CoreBankingDetails.Bank_Code;
                ACAStudentReceipts."Payment By" := CoreBankingDetails."Student No.";
                ACAStudentReceipts."Bank Slip Date" := CoreBankingDetails."Transaction Date";
                ACAStudentReceipts."Transaction Date" := CoreBankingDetails."Transaction Date";
                ACAStudentReceipts."Auto Post" := true;
                ACAStudentReceipts.Semester := ACACourseRegistration.Semester;
                ACAStudentReceipts.Insert;
                Clear(ACAStudentReceipts2);
                ACAStudentReceipts2.Reset;
                ACAStudentReceipts2.SetRange("Student No.", CoreBankingDetails."Student No.");
                ACAStudentReceipts2.SetRange("Cheque No", CoreBankingDetails."Transaction Number");
                ACAStudentReceipts2.SetRange(Semester, ACACourseRegistration.Semester);
                if ACAStudentReceipts2.Find('-') then
                    Post(ACAStudentReceipts2, UserId);
                CoreBankingDetails."Posting Status" := CoreBankingDetails."posting status"::Posted;
                CoreBankingDetails.Validate(Posted, true);
                CoreBankingDetails.Modify;
            end;
            until CoreBankingDetails.Next = 0;
        end;
    end;


    procedure GetCountry(var CountryCode: Code[20]) CountryName: Text[100]
    var
        Country: Record "Country/Region";
    begin
        /*This function gets the country name from the database and returns the resultant string value*/
        Country.Reset;
        if Country.Get(CountryCode) then begin
            CountryName := Country.Name;
        end
        else begin
            CountryName := '';
        end;

    end;


    procedure GetDegree1(var DegreeCode: Code[20]) DegreeName: Text[100]
    var
        Programme: Record "ACA-Programme";
    begin
        /*This function gets the programme name and returns the resultant string*/
        Programme.Reset;
        if Programme.Get(DegreeCode) then begin
            DegreeName := Programme.Description;
        end
        else begin
            DegreeName := '';
        end;

    end;


    procedure GetFaculty(var DegreeCode: Code[20]) FacultyName: Text[100]
    var
        Programme: Record "ACA-Programme";
        DimVal: Record "Dimension Value";
    begin
        /*The function gets and returns the faculty name to the calling client*/
        FacultyName := '';
        Programme.Reset;
        if Programme.Get(DegreeCode) then begin
            DimVal.Reset;
            DimVal.SetRange(DimVal."Dimension Code", 'FACULTY');
            //    DimVal.SETRANGE(DimVal.Code,Programme."Base Date");
            if DimVal.Find('-') then begin
                FacultyName := DimVal.Name;
            end;
        end;

    end;


    procedure GetAge(var StartDate: Date) AgeText: Text[100]
    var
        HrDates: Codeunit "HR Dates";
    begin
        /*This function gets the age of the applicant and returns the resultant age to the calling client*/
        AgeText := '';
        if StartDate = 0D then begin StartDate := Today end;
        AgeText := HrDates.DetermineAge(StartDate, Today);

    end;


    procedure GetFormerSchool(var FormerSchoolCode: Code[20]) FormerSchoolName: Text[30]
    var
        FormerSchool: Record "ACA-Applic. Setup Fmr School";
    begin
        /*This function gets the description of the former school and returns the result to the calling client*/
        FormerSchool.Reset;
        FormerSchoolName := '';
        if FormerSchool.Get(FormerSchoolCode) then begin
            FormerSchoolName := FormerSchool.Description;
        end;

    end;

    local procedure OnAfterGetCurrRecord()
    begin
        // // // // xRec := Rec;
        // // // // Age:=GetAge("Date Of Birth");
        // // // // NationalityName:=GetCountry(Nationality);
        // // // // CountryOfOriginName:=GetCountry("Country of Origin");
        // // // // DegreeName1:=GetDegree1("First Degree Choice");
        // // // // DegreeName2:=GetDegree1("Second Degree Choice");
        // // // // FacultyName1:=GetFaculty("First Degree Choice");
        // // // // FacultyName2:=GetFaculty("Second Degree Choice");
        // // // // FormerSchoolName:=GetFormerSchool("Former School Code");
        // // // // IF (Examination=Examination::KCSE) OR (Examination=Examination::KCE) OR (Examination=Examination::EACE) THEN
        // // // //  BEGIN
        // // // //    "Principal PassesVisible" :=FALSE;
        // // // //    "Subsidiary PassesVisible" :=FALSE;
        // // // //    "Mean Grade AcquiredVisible" :=TRUE;
        // // // //    "Points AcquiredVisible" :=TRUE;
        // // // //  END
        // // // // ELSE
        // // // //  BEGIN
        // // // //    "Principal PassesVisible" :=TRUE;
        // // // //    "Subsidiary PassesVisible" :=TRUE;
        // // // //    "Mean Grade AcquiredVisible" :=FALSE;
        // // // //    "Points AcquiredVisible" :=FALSE;
        // // // //  END;
    end;


    procedure GetStageName(var StageCode: Code[20]) StageName: Text[200]
    var
        Stage: Record "ACA-Programme Stages";
    begin
        Stage.Reset;
        Stage.SetRange(Stage.Code, StageCode);
        if Stage.Find('-') then begin
            StageName := Stage.Description;
        end;
    end;


    procedure GetSemesterName(var SemesterCode: Code[20]) SemesterName: Text[200]
    var
        Semester: Record "ACA-Semesters";
    begin
        Semester.Reset;
        Semester.SetRange(Semester.Code, SemesterCode);
        if Semester.Find('-') then begin
            SemesterName := Semester.Description;
        end;
    end;


    procedure GetCounty(var CountyCode: Code[20]) CountyName: Text[100]
    var
        CountySetup: Record "ACA-Applic. Setup County";
    begin
        /*This function gets the county name from the database and returns the resultant string value*/
        CountySetup.Reset;
        if CountySetup.Get(CountyCode) then begin
            CountyName := CountySetup.Description;
        end
        else begin
            CountyName := '';
        end;

    end;


    procedure TransferToAdmission(var AdmissionNumber: Code[20]; ApplicationFormHeader: Record "ACA-Applic. Form Header")
    begin
        /*This function transfers the fieldsin the application to the fields in the admissions table*/
        /*Get the new admission code for the selected application*/
        ApplicationFormHeader.TestField("Settlement Type");
        SettlmentType.Get(ApplicationFormHeader."Settlement Type");
        //IF AdmissionNumber='' THEN BEGIN
        Cust.Init;
        Cust."No." := ApplicationFormHeader."Admission No";
        Cust.Name := CopyStr(ApplicationFormHeader.Surname + ' ' + ApplicationFormHeader."Other Names", 1, 80);
        Cust."Search Name" := UpperCase(CopyStr(ApplicationFormHeader.Surname + ' ' + ApplicationFormHeader."Other Names", 1, 80));
        Cust.Address := ApplicationFormHeader."Address for Correspondence1";
        if ApplicationFormHeader."Address for Correspondence3" <> '' then
            Cust."Address 2" := CopyStr(ApplicationFormHeader."Address for Correspondence2" + ',' + ApplicationFormHeader."Address for Correspondence3", 1, 30);
        if ApplicationFormHeader."Telephone No. 2" <> '' then
            Cust."Phone No." := ApplicationFormHeader."Telephone No. 1" + ',' + ApplicationFormHeader."Telephone No. 2";
        //  Cust."Telex No.":=ApplicationFormHeader."Fax No.";
        Cust."E-Mail" := ApplicationFormHeader.Email;
        if ApplicationFormHeader.Gender = ApplicationFormHeader.Gender::Female then
            Cust.Gender := Cust.Gender::Female
        else if ApplicationFormHeader.Gender = ApplicationFormHeader.Gender::Male then
            Cust.Gender := Cust.Gender::Male;
        Cust."Date Of Birth" := ApplicationFormHeader."Date Of Birth";
        Cust."Date Registered" := Today;
        Cust."Customer Type" := Cust."customer type"::Student;
        //        Cust."Student Type":=FORMAT(Enrollment."Student Type");
        Cust."Date Of Birth" := ApplicationFormHeader."Date Of Birth";
        // Cust."ID No":=ApplicationFormHeader."ID Number";
        Cust."Application No." := ApplicationFormHeader."Admission No";
        Cust."Marital Status" := ApplicationFormHeader."Marital Status";
        Cust.Citizenship := Format(ApplicationFormHeader.Nationality);
        Cust."Current Programme" := ApplicationFormHeader."Admitted Degree";
        Cust."Current Semester" := ApplicationFormHeader."Admitted Semester";
        Cust."Current Stage" := ApplicationFormHeader."Admitted To Stage";
        // Cust.Religion:=FORMAT(ApplicationFormHeader.Religion);
        Cust."Application Method" := Cust."application method"::"Apply to Oldest";
        Cust."Customer Posting Group" := 'STUDENT';
        Cust.Validate(Cust."Customer Posting Group");
        Cust."ID No" := ApplicationFormHeader."ID Number";
        Cust.Password := ApplicationFormHeader."ID Number";
        Cust."Changed Password" := true;
        Cust."Global Dimension 1 Code" := ApplicationFormHeader.Campus;
        Cust.County := ApplicationFormHeader.County;
        Cust.Status := Cust.Status::Registration;
        Cust.Insert();

        ////////////////////////////////////////////////////////////////////////////////////////


        Cust.Reset;
        Cust.SetRange("No.", ApplicationFormHeader."Admission No");
        //Customer.SETFILTER("Date Registered",'=%1',TODAY);
        if Cust.Find('-') then begin
            Cust.Status := Cust.Status::"New Admission";
            if ApplicationFormHeader.Gender = ApplicationFormHeader.Gender::Female then begin
                Cust.Gender := Cust.Gender::Female;
            end else begin
                Cust.Gender := Cust.Gender::Male;
            end;
            Cust.Modify;
        end;

        Cust.Reset;
        Cust.SetRange("No.", ApplicationFormHeader."Admission No");
        Cust.SetFilter("Date Registered", '=%1', Today);
        if Cust.Find('-') then begin
            CourseRegistration.Reset;
            CourseRegistration.SetRange("Student No.", ApplicationFormHeader."Admission No");
            CourseRegistration.SetRange("Settlement Type", ApplicationFormHeader."Settlement Type");
            CourseRegistration.SetRange(Programmes, ApplicationFormHeader."First Degree Choice");
            CourseRegistration.SetRange(Semester, ApplicationFormHeader."Admitted Semester");
            if not CourseRegistration.Find('-') then begin
                CourseRegistration.Init;
                CourseRegistration."Reg. Transacton ID" := '';
                CourseRegistration.Validate(CourseRegistration."Reg. Transacton ID");
                CourseRegistration."Student No." := ApplicationFormHeader."Admission No";
                CourseRegistration.Programmes := ApplicationFormHeader."Admitted Degree";
                CourseRegistration.Semester := ApplicationFormHeader."Admitted Semester";
                CourseRegistration.Stage := ApplicationFormHeader."Admitted To Stage";
                CourseRegistration."Year Of Study" := 1;
                CourseRegistration."Student Type" := CourseRegistration."student type"::"Full Time";
                CourseRegistration."Registration Date" := Today;
                CourseRegistration."Settlement Type" := ApplicationFormHeader."Settlement Type";
                CourseRegistration."Academic Year" := ApplicationFormHeader.GetCurrYear();
                CourseRegistration.Insert;
                CourseRegistration.Reset;
                CourseRegistration.SetRange("Student No.", ApplicationFormHeader."Admission No");
                CourseRegistration.SetRange("Settlement Type", ApplicationFormHeader."Settlement Type");
                CourseRegistration.SetRange(Programmes, ApplicationFormHeader."First Degree Choice");
                CourseRegistration.SetRange(Semester, ApplicationFormHeader."Admitted Semester");
                if CourseRegistration.Find('-') then begin
                    CourseRegistration."Settlement Type" := ApplicationFormHeader."Settlement Type";
                    CourseRegistration.Validate(CourseRegistration."Settlement Type");
                    CourseRegistration."Academic Year" := ApplicationFormHeader.GetCurrYear();
                    CourseRegistration."Registration Date" := Today;
                    CourseRegistration.Validate(CourseRegistration."Registration Date");
                    CourseRegistration.Modify;
                end;
            end else begin
                CourseRegistration.Reset;
                CourseRegistration.SetRange("Student No.", ApplicationFormHeader."Admission No");
                CourseRegistration.SetRange("Settlement Type", ApplicationFormHeader."Settlement Type");
                CourseRegistration.SetRange(Programmes, ApplicationFormHeader."First Degree Choice");
                CourseRegistration.SetRange(Semester, ApplicationFormHeader."Admitted Semester");
                CourseRegistration.SetFilter(Posted, '=%1', false);
                if CourseRegistration.Find('-') then begin
                    CourseRegistration."Settlement Type" := ApplicationFormHeader."Settlement Type";
                    CourseRegistration.Validate(CourseRegistration."Settlement Type");
                    CourseRegistration."Academic Year" := ApplicationFormHeader.GetCurrYear();
                    CourseRegistration."Registration Date" := Today;
                    CourseRegistration.Validate(CourseRegistration."Registration Date");
                    CourseRegistration.Modify;

                end;
            end;
        end;

        ////////////////////////////////////////////////////////////////////////////////////////

        /*Get the record and transfer the details to the admissions database*/
        //ERROR('TEST- '+NewAdminCode);
        /*Transfer the details into the admission database table*/
        ApplicationFormHeader.Init;
        Admissions."Admission No." := AdmissionNumber;
        Admissions.Validate("Admission No.");
        Admissions.Date := Today;
        Admissions."Application No." := ApplicationFormHeader."Application No.";
        Admissions."Admission Type" := ApplicationFormHeader."Settlement Type";
        Admissions."Academic Year" := ApplicationFormHeader."Academic Year";
        Admissions.Surname := ApplicationFormHeader.Surname;
        Admissions."Other Names" := ApplicationFormHeader."Other Names";
        Admissions.Status := Admissions.Status::Admitted;
        Admissions."Degree Admitted To" := ApplicationFormHeader."Admitted Degree";
        Admissions.Validate("Degree Admitted To");
        Admissions."Date Of Birth" := ApplicationFormHeader."Date Of Birth";
        if ApplicationFormHeader.Gender = ApplicationFormHeader.Gender::Female then
            Admissions.Gender := Admissions.Gender::Female
        else if ApplicationFormHeader.Gender = ApplicationFormHeader.Gender::Male then
            Admissions.Gender := Admissions.Gender::Male;

        Admissions."Marital Status" := ApplicationFormHeader."Marital Status";
        Admissions.County := ApplicationFormHeader.County;
        Admissions.Campus := ApplicationFormHeader.Campus;
        Admissions.Nationality := ApplicationFormHeader.Nationality;
        Admissions."Correspondence Address 1" := ApplicationFormHeader."Address for Correspondence1";
        Admissions."Correspondence Address 2" := ApplicationFormHeader."Address for Correspondence2";
        Admissions."Correspondence Address 3" := ApplicationFormHeader."Address for Correspondence3";
        Admissions."Telephone No. 1" := ApplicationFormHeader."Telephone No. 1";
        Admissions."Telephone No. 2" := ApplicationFormHeader."Telephone No. 2";
        Admissions."Former School Code" := ApplicationFormHeader."Former School Code";
        Admissions."Index Number" := ApplicationFormHeader."Index Number";
        Admissions."Stage Admitted To" := ApplicationFormHeader."Admitted To Stage";
        Admissions."Semester Admitted To" := ApplicationFormHeader."Admitted Semester";
        Admissions."Settlement Type" := ApplicationFormHeader."Settlement Type";
        Admissions."Intake Code" := ApplicationFormHeader."Intake Code";
        Admissions."ID Number" := ApplicationFormHeader."ID Number";
        Admissions."E-Mail" := ApplicationFormHeader.Email;
        // Admissions."Telephone No. 1":=ApplicationFormHeader."Telephone No. 1";
        // Admissions."Telephone No. 2":=ApplicationFormHeader."Telephone No. 1";
        Admissions.Insert();
        ApplicationFormHeader."Admission No" := AdmissionNumber;
        /*Get the subject details and transfer the  same to the admissions subject*/
        ApplicationSubject.Reset;
        ApplicationSubject.SetRange(ApplicationSubject."Application No.", ApplicationFormHeader."Application No.");
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
                AdmissionSubject."Admission No." := AdmissionNumber;
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
                AdmissionMedical."Admission No." := AdmissionNumber;
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
                AdmissionFamily."Admission No." := AdmissionNumber;
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
                AdmissionImmunization."Admission No." := AdmissionNumber;
                AdmissionImmunization."Immunization Code" := Immunization.Code;
                AdmissionImmunization.Insert();
            until Immunization.Next = 0;
        end;

        TakeStudentToRegistration(AdmissionNumber);

    end;


    procedure TakeStudentToRegistration(var AdmissNo: Code[20])
    begin
        Admissions.Reset;
        Admissions.SetRange("Admission No.", AdmissNo);
        if Admissions.Find('-') then begin
            /*  Cust.INIT;
          Cust."No.":=Admissions."Admission No.";
          Cust.Name:=COPYSTR(Admissions.Surname + ' ' + Admissions."Other Names",1,30);
          Cust."Search Name":=UPPERCASE(COPYSTR(Admissions.Surname + ' ' + Admissions."Other Names",1,30));
          Cust.Address:=Admissions."Correspondence Address 1";
          Cust."Address 2":=COPYSTR(Admissions."Correspondence Address 2" + ',' +  Admissions."Correspondence Address 3",1,30);
          Cust."Phone No.":=Admissions."Telephone No. 1" + ',' + Admissions."Telephone No. 2";
          Cust."Telex No.":=Admissions."Fax No.";
          Cust."E-Mail":=Admissions."E-Mail";
          Cust.Gender:=Admissions.Gender;
          Cust."Date Of Birth":=Admissions."Date Of Birth";
          Cust."Date Registered":=TODAY;
          Cust."Customer Type":=Cust."Customer Type"::Student;
  //        Cust."Student Type":=FORMAT(Enrollment."Student Type");
  Cust."Date Of Birth":=Admissions."Date Of Birth";
          Cust."ID No":=ApplicationFormHeader."ID Number";
          Cust."Application No." :=Admissions."Admission No.";
          Cust."Marital Status":=Admissions."Marital Status";
          Cust.Citizenship:=FORMAT(Admissions.Nationality);
          Cust.Religion:=FORMAT(Admissions.Religion);
          Cust."Application Method":=Cust."Application Method"::"Apply to Oldest";
          Cust."Customer Posting Group":='STUDENT';
          Cust.VALIDATE(Cust."Customer Posting Group");
          Cust."ID No":=Admissions."ID Number";
          Cust."Global Dimension 1 Code":=Admissions.Campus;
          Cust.County:=Admissions.County;
          Cust.INSERT();
          */




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

            /*

                    //insert the details in relation to the student history as detailed in the application
                        EnrollmentEducationHistory.RESET;
                        EnrollmentEducationHistory.SETRANGE(EnrollmentEducationHistory."Enquiry No.",Enrollment."Enquiry No.");
                        IF EnrollmentEducationHistory.FIND('-') THEN
                            BEGIN
                                REPEAT
                                    EducationHistory.RESET;
                                    EducationHistory.INIT;
                                        EducationHistory."Student No.":=ApplicationFormHeader."No.";
                                        EducationHistory.From:=EnrollmentEducationHistory.From;
                                        EducationHistory."To":=EnrollmentEducationHistory."To";
                                        EducationHistory.Qualifications:=EnrollmentEducationHistory.Qualifications;
                                        EducationHistory.Instituition:=EnrollmentEducationHistory.Instituition;
                                        EducationHistory.Remarks:=EnrollmentEducationHistory.Remarks;
                                        EducationHistory."Aggregate Result/Award":=EnrollmentEducationHistory."Aggregate Result/Award";
                                    EducationHistory.INSERT;
                                UNTIL EnrollmentEducationHistory.NEXT=0;
                            END;
                    //update the status of the application
                        Enrollment."Registration No":=ApplicationFormHeader."No.";
                        Enrollment.Status:=Enrollment.Status::Admitted;
                        Enrollment.MODIFY;

             */
        end;

    end;


    procedure GetSchoolName(var SchoolCode: Code[20]; var SchoolName: Text[30])
    var
        FormerSchool: Record "ACA-Applic. Setup Fmr School";
    begin
        /*Get the former school name and display the results*/
        FormerSchool.Reset;
        SchoolName := '';
        if FormerSchool.Get(SchoolCode) then begin
            SchoolName := FormerSchool.Description;
        end;

    end;


    procedure GetDegreeName(var DegreeCode: Code[20]; var DegreeName: Text[200])
    var
        Programme: Record "ACA-Programme";
    begin
        /*get the degree name and display the results*/
        Programme.Reset;
        DegreeName := '';
        if Programme.Get(DegreeCode) then begin
            DegreeName := Programme.Description;
        end;

    end;


    procedure GetFacultyName(var DegreeCode: Code[20]; var FacultyName: Text[30])
    var
        Programme: Record "ACA-Programme";
        DimVal: Record "Dimension Value";
    begin
        /*Get the faculty name and return the result*/
        Programme.Reset;
        FacultyName := '';

        if Programme.Get(DegreeCode) then begin
            DimVal.Reset;
            DimVal.SetRange(DimVal."Dimension Code", 'FACULTY');
            DimVal.SetRange(DimVal.Code, Programme.Faculty);
            if DimVal.Find('-') then begin
                FacultyName := DimVal.Name;
            end;
        end;

    end;


    procedure GetReligionName(var ReligionCode: Code[20]; var ReligionName: Text[30])
    var
        Religion: Record "ACA-Academics Central Setups";
    begin
        /*Get the religion name and display the result*/
        Religion.Reset;
        Religion.SetRange(Religion."Title Code", ReligionCode);
        Religion.SetRange(Religion.Category, Religion.Category::Religions);

        ReligionName := '';
        if Religion.Find('-') then begin
            ReligionName := Religion.Description;
        end;

    end;


    procedure GetCurrYear() CurrYear: Text
    var
        acadYear: Record "ACA-Academic Year";
    begin
        acadYear.Reset;
        acadYear.SetRange(acadYear.Current, true);
        if acadYear.Find('-') then begin
            CurrYear := acadYear.Code;
        end else
            Error('No current academic year specified.');
    end;

    local procedure Post(ACAStdPayments: Record "ACA-Std Payments"; User_id: Code[20])
    var
        cust2: Record Customer;
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
        TotalApplied: Decimal;
        Sems: Record "ACA-Semesters";
        DueDate: Date;
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CReg: Record "ACA-Course Registration";
        CustLedg: Record "Cust. Ledger Entry";
        StudentPay: Record "ACA-Std Payments";
        ProgrammeSetUp: Record "ACA-Programme";
        CourseReg: Code[20];
        LastReceiptNo: Code[20];
        "No. Series Line": Record "No. Series Line";
        "Last No": Code[20];
        Prog: Record "ACA-Programme";
        BankRec: Record "Bank Account";
        [InDataSet]
        "Amount to payEnable": Boolean;
        [InDataSet]
        "Cheque NoEnable": Boolean;
        [InDataSet]
        "Drawer NameEnable": Boolean;
        [InDataSet]
        "Bank No.Enable": Boolean;
        [InDataSet]
        "Bank Slip DateEnable": Boolean;
        [InDataSet]
        "Applies to Doc NoEnable": Boolean;
        [InDataSet]
        "Apply to OverpaymentEnable": Boolean;
        [InDataSet]
        "CDF AccountEnable": Boolean;
        [InDataSet]
        "CDF DescriptionEnable": Boolean;
        [InDataSet]
        ApplicationEnable: Boolean;
        [InDataSet]
        "Unref. Entry No.Enable": Boolean;
        [InDataSet]
        "Staff Invoice No.Enable": Boolean;
        [InDataSet]
        "Staff DescriptionEnable": Boolean;
        [InDataSet]
        "Payment ByEnable": Boolean;
        StudHostel: Record "ACA-Students Hostel Rooms";
        HostLedg: Record "ACA-Hostel Ledger";
        BankName: Text[100];
    begin

        ACAStdPayments.Validate("Cheque No");
        if ACAStdPayments.Posted then exit;//ERROR('Already Posted');
        ACAStdPayments.TestField("Transaction Date");

        //IF CONFIRM('Do you want to post the transaction?',TRUE) = FALSE THEN BEGIN
        //EXIT;
        //END;

        if ((ACAStdPayments."Payment Mode" = ACAStdPayments."payment mode"::"Bank Slip") or (ACAStdPayments."Payment Mode" = ACAStdPayments."payment mode"::Cheque)) then begin
            ACAStdPayments.TestField("Bank Slip Date");
            ACAStdPayments.TestField("Bank No.");
        end;
        CustLedg.Reset;
        CustLedg.SetRange(CustLedg."Customer No.", ACAStdPayments."Student No.");
        //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
        CustLedg.SetRange(CustLedg.Open, true);
        CustLedg.SetRange(CustLedg.Reversed, false);
        if CustLedg.Find('-') then begin
            repeat
                TotalApplied := TotalApplied + CustLedg."Amount Applied";
            until CustLedg.Next = 0;
        end;

        if ACAStdPayments."Amount to pay" > TotalApplied then begin
            //IF CONFIRM('There is an overpayment. Do you want to continue?',FALSE) = FALSE THEN BEGIN
            //EXIT;
            //END;

        end;


        if Cust.Get(ACAStdPayments."Student No.") then begin
            Cust."Application Method" := Cust."application method"::"Apply to Oldest";
            Cust.CalcFields(Balance);
            if Cust.Status = Cust.Status::"New Admission" then begin
                if ((Cust.Balance = 0) or (Cust.Balance < 0)) then begin
                    Cust.Status := Cust.Status::Current;
                end else begin
                    Cust.Status := Cust.Status::"New Admission";
                end;
            end else begin
                Cust.Status := Cust.Status::Current;
            end;
            Cust.Modify;
        end;

        if Cust.Get(ACAStdPayments."Student No.") then
            GenJnl.Reset;
        GenJnl.SetRange("Journal Template Name", 'SALES');
        GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
        GenJnl.DeleteAll;

        GenSetUp.Get();


        GenJnl.Reset;
        GenJnl.SetRange("Journal Template Name", 'SALES');
        GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
        GenJnl.DeleteAll;

        GenSetUp.TestField(GenSetUp."Pre-Payment Account");



        //Charge Student if not charged
        StudentCharges.Reset;
        StudentCharges.SetRange(StudentCharges."Student No.", ACAStdPayments."Student No.");
        StudentCharges.SetRange(StudentCharges.Recognized, false);
        if StudentCharges.Find('-') then begin

            repeat

                DueDate := StudentCharges.Date;
                if Sems.Get(StudentCharges.Semester) then begin
                    if Sems.From <> 0D then begin
                        if Sems.From > DueDate then
                            DueDate := Sems.From;
                    end;
                end;


                GenJnl.Init;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := Today;
                GenJnl."Document No." := ACAStdPayments."Cheque No";//StudentCharges."Transacton ID";
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."account type"::Customer;
                //
                if Cust.Get(ACAStdPayments."Student No.") then begin
                    if Cust."Bill-to Customer No." <> '' then
                        GenJnl."Account No." := Cust."Bill-to Customer No."
                    else
                        GenJnl."Account No." := ACAStdPayments."Student No.";
                end;

                GenJnl.Amount := StudentCharges.Amount;
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := StudentCharges.Description;
                GenJnl."Bal. Account Type" := GenJnl."account type"::"G/L Account";

                if (StudentCharges."Transaction Type" = StudentCharges."transaction type"::"Stage Fees") and
                  (StudentCharges.Charge = false) then begin
                    GenJnl."Bal. Account No." := GenSetUp."Pre-Payment Account";

                    CReg.Reset;
                    CReg.SetCurrentkey(CReg."Reg. Transacton ID");
                    CReg.SetRange(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                    CReg.SetRange(CReg."Student No.", StudentCharges."Student No.");
                    if CReg.Find('-') then begin
                        if CReg."Register for" = CReg."register for"::Stage then begin
                            Stages.Reset;
                            Stages.SetRange(Stages."Programme Code", creg.programmes);
                            Stages.SetRange(Stages.Code, CReg.Stage);
                            if Stages.Find('-') then begin
                                if (Stages."Modules Registration" = true) and (Stages."Ignore No. Of Units" = false) then begin
                                    CReg.CalcFields(CReg."Units Taken");
                                    if CReg.Modules <> CReg."Units Taken" then
                                        Error('Units Taken must be equal to the no of modules registered for.');

                                end;
                            end;
                        end;

                        //CReg.Posted:=TRUE;
                        CReg.Modify;
                    end;


                end else if (StudentCharges."Transaction Type" = StudentCharges."transaction type"::"Unit Fees") and
                           (StudentCharges.Charge = false) then begin
                    GenJnl."Bal. Account No." := GenSetUp."Pre-Payment Account";

                    CReg.Reset;
                    CReg.SetCurrentkey(CReg."Reg. Transacton ID");
                    CReg.SetRange(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                    if CReg.Find('-') then begin
                        //CReg.Posted:=TRUE;
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
                    if Charges.Get(StudentCharges.Code) then
                        GenJnl."Bal. Account No." := Charges."G/L Account";
                end;
                GenJnl.Validate(GenJnl."Bal. Account No.");

                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                CReg.SetRange(CReg.Reversed, false);
                if CReg.Find('+') then begin
                    if ProgrammeSetUp.Get(creg.programmes) then begin
                        ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        if cust2.Get(ACAStdPayments."Student No.") then;
                        if cust2."Global Dimension 2 Code" = '' then
                            cust2."Global Dimension 2 Code" := ProgrammeSetUp."Department Code";
                        if cust2."Global Dimension 2 Code" <> '' then begin

                            GenJnl."Shortcut Dimension 2 Code" := cust2."Global Dimension 2 Code"
                        end
                        else
                            GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                        if cust2."Global Dimension 2 Code" = '' then
                            Error('Department code is missing!')

                        //else
                        //GenJnl."Shortcut Dimension 2 Code":=ProgrammeSetUp."Department Code";
                    end;
                end;
                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");


                GenJnl."Due Date" := DueDate;
                GenJnl.Validate(GenJnl."Due Date");
                if StudentCharges."Recovery Priority" <> 0 then
                    GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                else
                    GenJnl."Recovery Priority" := 25;
                if GenJnl.Amount <> 0 then
                    GenJnl.Insert;

                //Distribute Money
                if StudentCharges."Tuition Fee" = true then begin
                    if Stages.Get(StudentCharges.Programme, StudentCharges.Stage) then begin
                        if (Stages."Distribution Full Time (%)" > 0) or (Stages."Distribution Part Time (%)" > 0) then begin
                            Stages.TestField(Stages."Distribution Account");
                            StudentCharges.TestField(StudentCharges.Distribution);
                            if Cust.Get(ACAStdPayments."Student No.") then begin
                                CustPostGroup.Get(Cust."Customer Posting Group");

                                GenJnl.Init;
                                GenJnl."Line No." := GenJnl."Line No." + 10000;
                                GenJnl."Posting Date" := Today;
                                GenJnl."Document No." := ACAStdPayments."Cheque No";//StudentCharges."Transacton ID";
                                                                                    //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                                GenJnl.Validate(GenJnl."Document No.");
                                GenJnl."Journal Template Name" := 'SALES';
                                GenJnl."Journal Batch Name" := 'STUD PAY';
                                GenJnl."Account Type" := GenJnl."account type"::"G/L Account";
                                GenSetUp.TestField(GenSetUp."Pre-Payment Account");
                                GenJnl."Account No." := GenSetUp."Pre-Payment Account";
                                GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                GenJnl.Validate(GenJnl."Account No.");
                                GenJnl.Validate(GenJnl.Amount);
                                GenJnl.Description := 'Fee Distribution';
                                GenJnl."Bal. Account Type" := GenJnl."bal. account type"::"G/L Account";
                                GenJnl."Bal. Account No." := Stages."Distribution Account";
                                GenJnl.Validate(GenJnl."Bal. Account No.");

                                CReg.Reset;
                                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                                CReg.SetRange(CReg.Reversed, false);
                                if CReg.Find('+') then begin
                                    if ProgrammeSetUp.Get(creg.programmes) then begin
                                        ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                                        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                        GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                                    end;
                                end;
                                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                                if GenJnl.Amount <> 0 then
                                    GenJnl.Insert;

                            end;
                        end;
                    end;
                end else begin
                    //Distribute Charges
                    if StudentCharges.Distribution > 0 then begin
                        StudentCharges.TestField(StudentCharges."Distribution Account");
                        if Charges.Get(StudentCharges.Code) then begin
                            Charges.TestField(Charges."G/L Account");
                            GenJnl.Init;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := Today;
                            GenJnl."Document No." := ACAStdPayments."Cheque No";//StudentCharges."Transacton ID";
                            GenJnl.Validate(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."account type"::"G/L Account";
                            GenJnl."Account No." := StudentCharges."Distribution Account";
                            GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                            GenJnl.Validate(GenJnl."Account No.");
                            GenJnl.Validate(GenJnl.Amount);
                            GenJnl.Description := 'Fee Distribution';
                            GenJnl."Bal. Account Type" := GenJnl."bal. account type"::"G/L Account";
                            GenJnl."Bal. Account No." := Charges."G/L Account";
                            GenJnl.Validate(GenJnl."Bal. Account No.");

                            //Stages.TESTFIELD(Stages.Department);
                            CReg.Reset;
                            CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                            CReg.SetRange(CReg.Reversed, false);
                            if CReg.Find('+') then begin
                                if ProgrammeSetUp.Get(creg.programmes) then begin
                                    ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                                    //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                                    GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                    GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                                end;
                            end;
                            GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                            GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                            if GenJnl.Amount <> 0 then
                                GenJnl.Insert;

                        end;
                    end;
                end;
                //End Distribution


                StudentCharges.Recognized := true;
                StudentCharges.Modify;

            until StudentCharges.Next = 0;



            //Post New
            GenJnl.Reset;
            GenJnl.SetRange("Journal Template Name", 'SALES');
            GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
            if GenJnl.Find('-') then begin
                //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B2",GenJnl);
            end;

            //Post New



        end;


        //BILLING

        "Last No" := '';
        "No. Series Line".Reset;
        BankRec.Get(ACAStdPayments."Bank No.");
        BankRec.TestField(BankRec."Receipt No. Series");
        "No. Series Line".SetRange("No. Series Line"."Series Code", BankRec."Receipt No. Series");
        if "No. Series Line".Find('-') then begin

            "Last No" := IncStr("No. Series Line"."Last No. Used");
            "No. Series Line"."Last No. Used" := IncStr("No. Series Line"."Last No. Used");
            "No. Series Line".Modify;
        end;


        GenJnl.Reset;
        GenJnl.SetRange("Journal Template Name", 'SALES');
        GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
        GenJnl.DeleteAll;



        Cust.CalcFields(Balance);
        if Cust.Status = Cust.Status::"New Admission" then begin
            if ((Cust.Balance = 0) or (Cust.Balance < 0)) then begin
                Cust.Status := Cust.Status::Current;
            end else begin
                Cust.Status := Cust.Status::"New Admission";
            end;
        end else begin
            Cust.Status := Cust.Status::Current;
        end;
        //Cust.MODIFY;


        if ACAStdPayments."Payment Mode" = ACAStdPayments."payment mode"::"Applies to Overpayment" then
            Error('Overpayment must be applied manualy.');


        /////////////////////////////////////////////////////////////////////////////////
        //Receive payments
        if ACAStdPayments."Payment Mode" <> ACAStdPayments."payment mode"::"Applies to Overpayment" then begin

            //Over Payment
            TotalApplied := 0;

            CustLedg.Reset;
            CustLedg.SetRange(CustLedg."Customer No.", ACAStdPayments."Student No.");
            //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
            CustLedg.SetRange(CustLedg.Open, true);
            CustLedg.SetRange(CustLedg.Reversed, false);
            if CustLedg.Find('-') then begin
                repeat
                    TotalApplied := TotalApplied + CustLedg."Amount Applied";
                until CustLedg.Next = 0;
            end;

            CReg.Reset;
            CReg.SetCurrentkey(CReg."Reg. Transacton ID");
            //CReg.SETRANGE(CReg."Reg. Transacton ID",StudentCharges."Reg. Transacton ID");
            CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
            if CReg.Find('+') then
                CourseReg := CReg."Reg. Transacton ID";





            Receipt.Init;
            Receipt."Receipt No." := "Last No";
            //Receipt.VALIDATE(Receipt."Receipt No.");
            Receipt."Student No." := ACAStdPayments."Student No.";
            Receipt.Date := ACAStdPayments."Transaction Date";
            Receipt."KCA Rcpt No" := ACAStdPayments."KCA Receipt No";
            Receipt."Bank Slip Date" := ACAStdPayments."Bank Slip Date";
            Receipt."Bank Slip/Cheque No" := ACAStdPayments."Cheque No";
            Receipt.Validate("Bank Slip/Cheque No");
            Receipt."Bank Account" := ACAStdPayments."Bank No.";
            if ACAStdPayments."Payment Mode" = ACAStdPayments."payment mode"::"Bank Slip" then
                Receipt."Payment Mode" := Receipt."payment mode"::"Bank Slip" else
                if ACAStdPayments."Payment Mode" = ACAStdPayments."payment mode"::Cheque then
                    Receipt."Payment Mode" := Receipt."payment mode"::Cheque else
                    if ACAStdPayments."Payment Mode" = ACAStdPayments."payment mode"::Cash then
                        Receipt."Payment Mode" := Receipt."payment mode"::Cash else
                        Receipt."Payment Mode" := ACAStdPayments."Payment Mode";
            Receipt.Amount := ACAStdPayments."Amount to pay";
            Receipt."Payment By" := ACAStdPayments."Payment By";
            Receipt."Transaction Date" := Today;
            Receipt."Transaction Time" := Time;
            Receipt."User ID" := User_id;
            Receipt."Reg ID" := CourseReg;
            Receipt.Insert;

            Receipt.Reset;
            if Receipt.Find('+') then begin


                CustLedg.Reset;
                CustLedg.SetRange(CustLedg."Customer No.", ACAStdPayments."Student No.");
                //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
                CustLedg.SetRange(CustLedg.Open, true);
                CustLedg.SetRange(CustLedg.Reversed, false);
                if CustLedg.Find('-') then begin

                    GenSetUp.Get();


                end;

            end;

            //Bank Entry
            if BankRec.Get(ACAStdPayments."Bank No.") then
                BankName := BankRec.Name;

            if (ACAStdPayments."Payment Mode" <> ACAStdPayments."payment mode"::Unreferenced) and (ACAStdPayments."Payment Mode" <> ACAStdPayments."payment mode"::"Staff Invoice")
            and (ACAStdPayments."Payment Mode" <> ACAStdPayments."payment mode"::Weiver) and (ACAStdPayments."Payment Mode" <> ACAStdPayments."payment mode"::CDF)
            and (ACAStdPayments."Payment Mode" <> ACAStdPayments."payment mode"::HELB) then begin

                GenJnl.Init;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := ACAStdPayments."Bank Slip Date";
                GenJnl."Document No." := "Last No";
                GenJnl."External Document No." := ACAStdPayments."Cheque No";
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."account type"::"Bank Account";
                GenJnl."Account No." := ACAStdPayments."Bank No.";
                GenJnl.Amount := ACAStdPayments."Amount to pay";
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := Format(ACAStdPayments."Payment Mode") + '-' + Format(ACAStdPayments."Bank Slip Date") + '-' + BankName;
                GenJnl."Bal. Account Type" := GenJnl."bal. account type"::Customer;
                if Cust."Bill-to Customer No." <> '' then
                    GenJnl."Bal. Account No." := Cust."Bill-to Customer No."
                else
                    GenJnl."Bal. Account No." := ACAStdPayments."Student No.";


                GenJnl.Validate(GenJnl."Bal. Account No.");

                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                CReg.SetRange(CReg.Reversed, false);
                if CReg.Find('+') then begin
                    if ProgrammeSetUp.Get(creg.programmes) then begin
                        ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                    end;
                end;
                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                if GenJnl.Amount <> 0 then
                    GenJnl.Insert;
            end;
            if ACAStdPayments."Payment Mode" = ACAStdPayments."payment mode"::Unreferenced then begin
                GenJnl.Init;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := ACAStdPayments."Bank Slip Date";
                GenJnl."Document No." := "Last No";
                GenJnl."External Document No." := ACAStdPayments."Drawer Name";
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."account type"::Customer;
                GenJnl."Account No." := 'UNREF';
                GenJnl.Amount := ACAStdPayments."Amount to pay";
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := Cust.Name;
                GenJnl."Bal. Account Type" := GenJnl."bal. account type"::Customer;
                if Cust."Bill-to Customer No." <> '' then
                    GenJnl."Bal. Account No." := Cust."Bill-to Customer No."
                else
                    GenJnl."Bal. Account No." := ACAStdPayments."Student No.";

                GenJnl."Applies-to Doc. No." := ACAStdPayments."Unref Document No.";
                GenJnl.Validate(GenJnl."Applies-to Doc. No.");
                if GenJnl.Amount <> 0 then
                    GenJnl.Insert;

                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                CReg.SetRange(CReg.Reversed, false);
                if CReg.Find('+') then begin
                    if ProgrammeSetUp.Get(creg.programmes) then begin
                        ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                    end;
                end;
                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");


            end;
            // Tripple - T...Staff Invoice
            if ACAStdPayments."Payment Mode" = ACAStdPayments."payment mode"::"Staff Invoice" then begin
                GenJnl.Init;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := ACAStdPayments."Bank Slip Date";
                GenJnl."Document No." := "Last No";
                GenJnl."External Document No." := '';
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."account type"::Customer;
                GenJnl."Account No." := ACAStdPayments."Student No.";
                GenJnl.Amount := -ACAStdPayments."Amount to pay";
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := 'Staff Invoice No. ' + ACAStdPayments."Staff Invoice No.";
                GenJnl."Bal. Account Type" := GenJnl."bal. account type"::"G/L Account";
                GenJnl."Bal. Account No." := '200012';

                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                CReg.SetRange(CReg.Reversed, false);
                if CReg.Find('+') then begin
                    if ProgrammeSetUp.Get(creg.programmes) then begin
                        ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                    end;
                end;
                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                if GenJnl.Amount <> 0 then
                    GenJnl.Insert;


            end;
            // Tripple - T...CDF
            if ACAStdPayments."Payment Mode" = ACAStdPayments."payment mode"::CDF then begin
                GenSetUp.TestField(GenSetUp."CDF Account");
                GenJnl.Init;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := ACAStdPayments."Bank Slip Date";
                GenJnl."Document No." := "Last No";
                GenJnl."External Document No." := 'CDF';
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."account type"::Customer;
                GenJnl."Account No." := ACAStdPayments."Student No.";
                GenJnl.Amount := -ACAStdPayments."Amount to pay";
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := ACAStdPayments."CDF Description";
                //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
                //GenJnl."Bal. Account No.":=;
                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                CReg.SetRange(CReg.Reversed, false);
                if CReg.Find('+') then begin
                    if ProgrammeSetUp.Get(creg.programmes) then begin
                        ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                    end;
                end;
                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                if GenJnl.Amount <> 0 then
                    GenJnl.Insert;

                GenJnl.Init;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := ACAStdPayments."Bank Slip Date";
                GenJnl."Document No." := "Last No";
                GenJnl."External Document No." := 'CDF';
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."account type"::"G/L Account";
                GenJnl."Account No." := GenSetUp."CDF Account";
                GenJnl.Amount := ACAStdPayments."Amount to pay";
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := ACAStdPayments."Student No.";

                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                CReg.SetRange(CReg.Reversed, false);
                if CReg.Find('+') then begin
                    if ProgrammeSetUp.Get(creg.programmes) then begin
                        ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                    end;
                end;
                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                if GenJnl.Amount <> 0 then
                    GenJnl.Insert;


            end;


            if ACAStdPayments."Payment Mode" = ACAStdPayments."payment mode"::HELB then begin
                GenSetUp.TestField(GenSetUp."Helb Account");
                GenJnl.Init;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := ACAStdPayments."Bank Slip Date";
                GenJnl."Document No." := "Last No";
                GenJnl."External Document No." := '';
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."account type"::Customer;
                GenJnl."Account No." := ACAStdPayments."Student No.";
                GenJnl.Amount := -ACAStdPayments."Amount to pay";
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := 'HELB';
                GenJnl."Bal. Account Type" := GenJnl."bal. account type"::"G/L Account";
                GenJnl."Bal. Account No." := GenSetUp."Helb Account";
                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                CReg.SetRange(CReg.Reversed, false);
                if CReg.Find('+') then begin
                    if ProgrammeSetUp.Get(creg.programmes) then begin
                        GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                    end;
                end;

                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                if GenJnl.Amount <> 0 then
                    GenJnl.Insert;


            end;

            //Post

            GenJnl.Reset;
            GenJnl.SetRange("Journal Template Name", 'SALES');
            GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
            IF GenJnl.FindSet() THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnl);

                ACAStdPayments.Posted := true;
                ACAStdPayments.Modify;
                ACAStdPayments.Modify;
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
        VATEntry: Record "Vendor Ledger Entry";
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
                        Error('Please Note That You Must First Clear Your Old Rooms Before You Allocate Another Room')
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
                    Host_Ledger."Space No" := ACAStudentsHostelRooms."Space No";
                    Host_Ledger."Room No" := ACAStudentsHostelRooms."Room No";
                    Host_Ledger."Hostel No" := ACAStudentsHostelRooms."Hostel No";
                    Host_Ledger.No := counts;
                    Host_Ledger.Status := Host_Ledger.Status::"Fully Occupied";
                    Host_Ledger."Room Cost" := StudentHostel.Charges;
                    Host_Ledger."Student No" := StudentHostel.Student;
                    Host_Ledger."Receipt No" := '';
                    Host_Ledger.Semester := StudentHostel.Semester;
                    Host_Ledger.Gender := ACAStudentsHostelRooms.Gender;
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

                    StudentHostel.Billed := false;
                    StudentHostel.Charges := 6500;
                    //  StudentHostel."Billed Date":=TODAY;
                    // StudentHostel."Allocation Date":=TODAY;
                    //  StudentHostel.Allocated:=TRUE;
                    //  StudentHostel."Allocated By":=USERID;
                    //  StudentHostel."Time allocated":=TIME;
                    StudentHostel.Modify;


                end;
            until StudentHostel.Next = 0;
            Message('Room Allocated Successfully');
        end;

        postCharge(ACAStudentsHostelRooms);  // Do not post Hostel Charges
    end;

    local procedure postCharge(ACAStudentsHostelRooms: Record "ACA-Students Hostel Rooms")
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
        VATEntry: Record "Vendor Ledger Entry";
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
        ACAStudentsHostelRooms.Charges := 6500;
        ACAStudentsHostelRooms.Modify;
        /*

      //BILLING
      charges1.RESET;
      charges1.SETRANGE(charges1.Hostel,TRUE);
      IF NOT charges1.FIND('-') THEN BEGIN
        ERROR('The charges Setup does not have an item tagged as Hostel.');
      END;

      AccPayment:=FALSE;
      StudentCharges.RESET;
      StudentCharges.SETRANGE(StudentCharges."Student No.",Student);
      StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
      StudentCharges.SETFILTER(StudentCharges.Code,'=%1',charges1.Code) ;
      IF NOT StudentCharges.FIND('-') THEN BEGIN //3
      // The charge does not exist. Created it, but check first if it exists as unrecognized
      StudentCharges.RESET;
      StudentCharges.SETRANGE(StudentCharges."Student No.",Student);
      //StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
      StudentCharges.SETFILTER(StudentCharges.Code,'=%1',charges1.Code) ;
      IF NOT StudentCharges.FIND('-') THEN BEGIN //4
      // Does not exist hence just create
      CReg.RESET;
      CReg.SETRANGE(CReg."Student No.",Student);
      CReg.SETRANGE(CReg.Semester,Semester);
      IF CReg.FIND('-') THEN BEGIN //5
        GenSetUp.GET();
        IF GenSetUp.FIND('-') THEN
        BEGIN  //6
          NoSeries.RESET;
          NoSeries.SETRANGE(NoSeries."Series Code",GenSetUp."Transaction Nos.");
          IF NoSeries.FIND('-') THEN
          BEGIN // 7
            LastNo:=NoSeries."Last No. Used"
          END;  // 7
        END; // 6
           //message(LastNo);
           LastNo:=INCSTR(LastNo);
           NoSeries."Last No. Used":=LastNo;
           NoSeries.MODIFY;
           StudentCharges.INIT();
           StudentCharges."Transacton ID":=LastNo;
           StudentCharges.VALIDATE(StudentCharges."Transacton ID");
           StudentCharges."Student No.":=Student;
           StudentCharges."Transaction Type":=StudentCharges."Transaction Type"::Charges;
           StudentCharges."Reg. Transacton ID":=CReg."Reg. Transacton ID";
           StudentCharges.Description:='Hostel Charges '+"Space No";
           StudentCharges.Amount:=Charges;
           StudentCharges.Date:=TODAY;
           StudentCharges.Code:=charges1.Code;
           StudentCharges.Charge:=TRUE;
           StudentCharges.INSERT(TRUE);
           Billed:=TRUE;
           "Billed Date":=TODAY;
           MODIFY;
      END; //5

      END ELSE BEGIN//4
      // Charge Exists, Delete from the charges then create a new one
        StudentCharges.DELETE;

      CReg.RESET;
      CReg.SETRANGE(CReg."Student No.",Student);
      CReg.SETRANGE(CReg.Semester,Semester);
      IF CReg.FIND('-') THEN BEGIN //5
        GenSetUp.GET();
        IF GenSetUp.FIND('-') THEN
        BEGIN  //6
          NoSeries.RESET;
          NoSeries.SETRANGE(NoSeries."Series Code",GenSetUp."Transaction Nos.");
          IF NoSeries.FIND('-') THEN
          BEGIN // 7
            LastNo:=NoSeries."Last No. Used"
          END;  // 7
        END; // 6
           //message(LastNo);
           LastNo:=INCSTR(LastNo);
           NoSeries."Last No. Used":=LastNo;
           NoSeries.MODIFY;
           StudentCharges.INIT();
           StudentCharges."Transacton ID":=LastNo;
           StudentCharges.VALIDATE(StudentCharges."Transacton ID");
           StudentCharges."Student No.":=Student;
           StudentCharges."Transaction Type":=StudentCharges."Transaction Type"::Charges;
           StudentCharges."Reg. Transacton ID":=CReg."Reg. Transacton ID";
           StudentCharges.Description:='Hostel Charges '+"Space No";
           StudentCharges.Amount:=Charges;
           StudentCharges.Date:=TODAY;
           StudentCharges.Code:=charges1.Code;
           StudentCharges.Charge:=TRUE;
           StudentCharges.INSERT(TRUE);
          // Billed:=TRUE;
          // "Billed Date":=TODAY;
          // MODIFY;
      END; //5
      END;//4

      END; //3


      CReg.RESET;
      CReg.SETRANGE(CReg."Student No.",Student);
      CReg.SETRANGE(CReg.Semester,Semester);
      IF CReg.FIND('-') THEN BEGIN //10
      END // 10
      ELSE   BEGIN // 10.1
      ERROR('The Settlement Type Does not Exists in the Course Registration for: '+Student);
      END;//10.1



      IF Cust.GET(Student) THEN;

      GenJnl.RESET;
      GenJnl.SETRANGE("Journal Template Name",'SALES');
      GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
      GenJnl.DELETEALL;

      GenSetUp.GET();

      // Charge Student - Accommodation- if not charged
      StudentCharges.RESET;
      StudentCharges.SETRANGE(StudentCharges."Student No.",Student);
      StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
      StudentCharges.SETFILTER(StudentCharges.Code,'=%1',charges1.Code) ;
      IF StudentCharges.FIND('-') THEN BEGIN

      REPEAT

      DueDate:=StudentCharges.Date;
       IF DueDate=0D THEN DueDate:=TODAY;

      GenJnl.INIT;
      GenJnl."Line No." := GenJnl."Line No." + 10000;
      GenJnl."Posting Date":=TODAY;
      GenJnl."Document No.":=StudentCharges."Transacton ID";
      GenJnl.VALIDATE(GenJnl."Document No.");
      GenJnl."Journal Template Name":='SALES';
      GenJnl."Journal Batch Name":='STUD PAY';
      GenJnl."Account Type":=GenJnl."Account Type"::Customer;
      //
      IF Cust.GET(Student) THEN BEGIN
      IF Cust."Bill-to Customer No." <> '' THEN
      GenJnl."Account No.":=Cust."Bill-to Customer No."
      ELSE
      GenJnl."Account No.":=Student;
      END;

      GenJnl.Amount:=StudentCharges.Amount;
      GenJnl.VALIDATE(GenJnl."Account No.");
      GenJnl.VALIDATE(GenJnl.Amount);
      GenJnl.Description:=StudentCharges.Description;
      GenJnl."Bal. Account Type":=GenJnl."Account Type"::"G/L Account";

      IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") AND
         (StudentCharges.Charge = FALSE) THEN BEGIN

      CReg.RESET;
      CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
      CReg.SETRANGE(CReg."Reg. Transacton ID",StudentCharges."Reg. Transacton ID");
      CReg.SETRANGE(CReg."Student No.",StudentCharges."Student No.");
      IF CReg.FIND('-') THEN BEGIN
      IF CReg."Register for"=CReg."Register for"::Stage THEN BEGIN
      Stages.RESET;
      Stages.SETRANGE(Stages."Programme Code",creg.programmes);
      Stages.SETRANGE(Stages.Code,CReg.Stage);
      IF Stages.FIND('-') THEN BEGIN
      IF (Stages."Modules Registration" = TRUE) AND (Stages."Ignore No. Of Units"= FALSE) THEN BEGIN
      CReg.CALCFIELDS(CReg."Units Taken");
      IF CReg. Modules <> CReg."Units Taken" THEN
      ERROR('Units Taken must be equal to the no of modules registered for.');

      END;
      END;
      END;

      CReg.Posted:=TRUE;
      CReg.MODIFY;
      END;


      END ELSE IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") AND
                  (StudentCharges.Charge = FALSE) THEN BEGIN
      StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");


      CReg.RESET;
      CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
      CReg.SETRANGE(CReg."Reg. Transacton ID",StudentCharges."Reg. Transacton ID");
      IF CReg.FIND('-') THEN BEGIN
      CReg.Posted:=TRUE;
      CReg.MODIFY;
      END;



      END ELSE IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" THEN BEGIN
      IF ExamsByStage.GET(StudentCharges.Programme,StudentCharges.Stage,StudentCharges.Semester,StudentCharges.Code) THEN
      GenJnl."Bal. Account No.":=ExamsByStage."G/L Account";

      END ELSE IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" THEN BEGIN
      IF ExamsByUnit.GET(StudentCharges.Programme,StudentCharges.Stage,ExamsByUnit."Unit Code",StudentCharges.Semester,
      StudentCharges.Code) THEN
      GenJnl."Bal. Account No.":=ExamsByUnit."G/L Account";

      END ELSE IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges) OR
                  (StudentCharges.Charge = TRUE) THEN BEGIN
      IF charges1.GET(StudentCharges.Code) THEN
      GenJnl."Bal. Account No.":=charges1."G/L Account";
      END;


      GenJnl.VALIDATE(GenJnl."Bal. Account No.");
      GenJnl."Shortcut Dimension 1 Code":=Cust."Global Dimension 1 Code";
      IF prog.GET(StudentCharges.Programme) THEN BEGIN
      prog.TESTFIELD(prog."Department Code");
      GenJnl."Shortcut Dimension 2 Code":=prog."Department Code";
      END;



      GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
      GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
      GenJnl."Due Date":=DueDate;
      GenJnl.VALIDATE(GenJnl."Due Date");
      IF StudentCharges."Recovery Priority" <> 0 THEN
      GenJnl."Recovery Priority":=StudentCharges."Recovery Priority"
      ELSE
      GenJnl."Recovery Priority":=25;
      GenJnl.INSERT;

      //Distribute Money
      IF StudentCharges."Tuition Fee" = TRUE THEN BEGIN
      IF Stages.GET(StudentCharges.Programme,StudentCharges.Stage) THEN BEGIN
      IF (Stages."Distribution Full Time (%)" > 0) OR (Stages."Distribution Part Time (%)" > 0) THEN BEGIN
      Stages.TESTFIELD(Stages."Distribution Account");
      StudentCharges.TESTFIELD(StudentCharges.Distribution);
      IF Cust.GET(Student) THEN BEGIN
      CustPostGroup.GET(Cust."Customer Posting Group");

      GenJnl.INIT;
      GenJnl."Line No." := GenJnl."Line No." + 10000;
      GenJnl."Posting Date":=TODAY;
      GenJnl."Document No.":=StudentCharges."Transacton ID";
      GenJnl.VALIDATE(GenJnl."Document No.");
      GenJnl."Journal Template Name":='SALES';
      GenJnl."Journal Batch Name":='STUD PAY';
      GenJnl."Account Type":=GenJnl."Account Type"::"G/L Account";
      GenJnl.Amount:=StudentCharges.Amount * (StudentCharges.Distribution/100);
      GenJnl.VALIDATE(GenJnl."Account No.");
      GenJnl.VALIDATE(GenJnl.Amount);
      GenJnl.Description:='Fee Distribution';
      GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";

      StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");

      GenJnl.VALIDATE(GenJnl."Bal. Account No.");
      GenJnl."Shortcut Dimension 1 Code":=Cust."Global Dimension 1 Code";
      IF prog.GET(StudentCharges.Programme) THEN BEGIN
      prog.TESTFIELD(prog."Department Code");
      GenJnl."Shortcut Dimension 2 Code":=prog."Department Code";
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
      IF charges1.GET(StudentCharges.Code) THEN BEGIN
      charges1.TESTFIELD(charges1."G/L Account");
      GenJnl.INIT;
      GenJnl."Line No." := GenJnl."Line No." + 10000;
      GenJnl."Posting Date":=TODAY;
      GenJnl."Document No.":=StudentCharges."Transacton ID";
      GenJnl.VALIDATE(GenJnl."Document No.");
      GenJnl."Journal Template Name":='SALES';
      GenJnl."Journal Batch Name":='STUD PAY';
      GenJnl."Account Type":=GenJnl."Account Type"::"G/L Account";
      GenJnl."Account No.":=StudentCharges."Distribution Account";
      GenJnl.Amount:=StudentCharges.Amount * (StudentCharges.Distribution/100);
      GenJnl.VALIDATE(GenJnl."Account No.");
      GenJnl.VALIDATE(GenJnl.Amount);
      GenJnl.Description:='Fee Distribution';
      GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
      GenJnl."Bal. Account No.":=charges1."G/L Account";
      GenJnl.VALIDATE(GenJnl."Bal. Account No.");
      GenJnl."Shortcut Dimension 1 Code":=Cust."Global Dimension 1 Code";

      IF prog.GET(StudentCharges.Programme) THEN BEGIN
      prog.TESTFIELD(prog."Department Code");
      GenJnl."Shortcut Dimension 2 Code":=prog."Department Code";
      END;
      GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
      GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
      GenJnl.INSERT;

      END;
      END;
      END;
      //End Distribution


      StudentCharges.Recognized:=TRUE;
      //StudentCharges.MODIFY;
      //.......BY Wanjala
      StudentCharges.Posted:=TRUE;
      StudentCharges.MODIFY;


      UNTIL StudentCharges.NEXT = 0;



      //Post New
      GenJnl.RESET;
      GenJnl.SETRANGE("Journal Template Name",'SALES');
      GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
      IF GenJnl.FIND('-') THEN BEGIN
      CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill",GenJnl);
      END;

      //Post New


      Cust."Application Method":=Cust."Application Method"::"Apply to Oldest";
      //Cust.Status:=Cust.Status::Current;
      Cust.MODIFY;

      END;

       END;

       */

    end;

    local procedure SendAdmissionMailsHere(KUCCPSImports2: Record "Kuccps Imports")
    var
        SendMailsEasy: Codeunit "Send Mails Easy";
        ResidentOrNonResidentInfo: Text[450];
        ResidenceInfo: Text[250];
    begin
        Commit;
        Clear(ResidentOrNonResidentInfo);
        Clear(ResidenceInfo);
        //KUCCPSImports2.CALCFIELDS("Assigned Block","Assigned Room");
        if KUCCPSImports2.Accomodation = KUCCPSImports2.Accomodation::Resident then begin
            ResidentOrNonResidentInfo += 'Visit the Hostel manager for allocation of a room and space of residence.';
        end else begin
            ResidentOrNonResidentInfo += 'You have not applied for a hostel allocation. You are therefore adviced to make personal arrangements for accomodation. ' +
          'You can also visit the hostel manager to request for the same.';
        end;
        SendMailsEasy.SendEmailEasy('Dear', KUCCPSImports2.Names,
        COMPANYNAME + ' is glad to inform you that your admission process was successful.', ResidentOrNonResidentInfo,
        'Login in to your portal to Register for the units and access other Services',
        'This Mail is system generated. Please do not reply.',
        KUCCPSImports2.Email, 'ADMISSION INTO ' + COMPANYNAME);
        // Send SMS  TODO
        if KUCCPSImports2.Phone <> '' then begin
            // Mails.Send_SMS_Easy(KUCCPSImports2.Phone, COMPANYNAME + ' is glad to inform you that your admission process was successful.',
            //   ResidentOrNonResidentInfo,
            //   'Login in to your portal to Register for the units and access other Services');
        end;
    end;
}

