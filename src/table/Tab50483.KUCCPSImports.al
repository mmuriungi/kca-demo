/// <summary>
/// Table KUCCPS Imports (ID 70082).
/// </summary>
table 50483 "KUCCPS Imports"
{

    fields
    {
        field(1; ser; Integer)
        {

            trigger OnValidate()
            begin
                CLEAR(ACAAcademicYear);
                ACAAcademicYear.RESET;
                ACAAcademicYear.SETRANGE(Current, TRUE);
                IF ACAAcademicYear.FIND('-') THEN BEGIN

                END;
                Rec."Current Approval Level" := 'APPROVAL INITIATED';
                CLEAR(ACANewStudDocSetup);
                ACANewStudDocSetup.RESET;
                ACANewStudDocSetup.SETRANGE("Academic Year", Rec."Academic Year");
                IF ACANewStudDocSetup.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        ACANewStudDocuments.INIT;
                        ACANewStudDocuments."Academic Year" := ACANewStudDocSetup."Academic Year";
                        ACANewStudDocuments."Index Number" := Rec.Index;
                        ACANewStudDocuments."Document Code" := ACANewStudDocSetup."Document Code";
                        ACANewStudDocuments."Approval Sequence" := ACANewStudDocSetup.Sequence;
                        IF ACANewStudDocSetup.Sequence = 1 THEN
                            ACANewStudDocuments."Approval Status" := ACANewStudDocuments."Approval Status"::Open
                        ELSE
                            ACANewStudDocuments."Approval Status" := ACANewStudDocuments."Approval Status"::Created;
                        IF ACANewStudDocuments.INSERT THEN;
                    END;
                    UNTIL ACANewStudDocSetup.NEXT = 0;
                END;
            end;
        }
        field(2; Index; Code[20])
        {

            trigger OnValidate()
            begin
                CLEAR(ACAAcademicYear);
                ACAAcademicYear.RESET;
                ACAAcademicYear.SETRANGE(Current, TRUE);
                IF ACAAcademicYear.FIND('-') THEN BEGIN
                END;
                Rec."Current Approval Level" := 'APPROVAL INITIATED';
                CLEAR(ACANewStudDocSetup);
                ACANewStudDocSetup.RESET;
                ACANewStudDocSetup.SETRANGE("Academic Year", Rec."Academic Year");
                IF ACANewStudDocSetup.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        ACANewStudDocuments.INIT;
                        ACANewStudDocuments."Academic Year" := ACANewStudDocSetup."Academic Year";
                        ACANewStudDocuments."Index Number" := Rec.Index;
                        ACANewStudDocuments."Document Code" := ACANewStudDocSetup."Document Code";
                        ACANewStudDocuments."Approval Sequence" := ACANewStudDocSetup.Sequence;
                        IF ACANewStudDocSetup.Sequence = 1 THEN
                            ACANewStudDocuments."Approval Status" := ACANewStudDocuments."Approval Status"::Open
                        ELSE
                            ACANewStudDocuments."Approval Status" := ACANewStudDocuments."Approval Status"::Created;
                        IF ACANewStudDocuments.INSERT THEN;
                    END;
                    UNTIL ACANewStudDocSetup.NEXT = 0;
                END;
            end;
        }
        field(3; Admin; Code[50])
        {
        }
        field(4; Prog; Code[20])
        {
            TableRelation = "ACA-Programme";
        }
        field(5; Names; Text[100])
        {
        }
        field(6; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(7; Phone; Code[20])
        {
        }
        field(8; "Alt. Phone"; Code[20])
        {
        }
        field(9; Box; Code[50])
        {
        }
        field(10; Codes; Code[20])
        {
        }
        field(11; Town; Code[40])
        {
        }
        field(12; Email; Text[100])
        {
        }
        field(13; "Slt Mail"; Text[100])
        {
        }
        field(14; Processed; Boolean)
        {
        }
        field(15; County; Code[50])
        {
            TableRelation = "ACA-Applic. Setup County".Code;
        }
        field(16; "Date of Birth"; Date)
        {
        }
        field(17; "ID Number/BirthCert"; Text[50])
        {
        }
        field(19; "Intake Code"; Code[10])
        {
        }
        field(22; Updated; Boolean)
        {
        }
        field(23; "NIIMS No"; Text[30])
        {
        }
        field(24; "Physical Impairments"; Boolean)
        {
        }
        field(25; "Physical impairments Details"; Text[150])
        {
        }
        field(26; "NHIF No"; Text[30])
        {
        }
        field(27; Religion; Code[10])
        {
            TableRelation = "ACA-Religions".Religion;
        }
        field(28; Nationality; Code[10])
        {
        }
        field(29; "Marital Status"; Option)
        {
            OptionCaption = 'Single,Married,Divorced,Widowed';
            OptionMembers = Single,Married,Divorced,Widowed;
        }
        field(30; "Name of Spouse"; Text[100])
        {
        }
        field(31; "Occupation of Spouse"; Text[100])
        {
        }
        field(32; "Spouse Phone No"; Code[30])
        {
        }
        field(33; "Number of Children"; Text[30])
        {
        }
        field(34; "Full Name of Father"; Text[100])
        {
        }
        field(35; "Father Status"; Option)
        {
            OptionCaption = 'Alive,Deceased';
            OptionMembers = Alive,Deceased;
        }
        field(36; "Father Occupation"; Text[100])
        {
        }
        field(37; "Father Date of Birth"; Date)
        {
        }
        field(38; "Name of Mother"; Text[100])
        {
        }
        field(39; "Mother Status"; Option)
        {
            OptionCaption = 'Alive,Deceased';
            OptionMembers = Alive,Deceased;
        }
        field(40; "Mother Occupation"; Text[100])
        {
        }
        field(41; "Mother Date of Birth"; Date)
        {
        }
        field(42; "Number of brothers and sisters"; Code[20])
        {
        }
        field(43; "Place of Birth"; Text[100])
        {
        }
        field(44; "Permanent Residence"; Text[30])
        {
        }
        field(45; "Nearest Town"; Text[100])
        {
        }
        field(46; Location; Text[100])
        {
        }
        field(47; "Name of Chief"; Text[100])
        {
        }
        field(48; "Sub-County"; Text[100])
        {
        }
        field(49; Constituency; Text[100])
        {
        }
        field(50; "Nearest Police Station"; Text[100])
        {
        }
        field(51; "Emergency Name1"; Text[100])
        {
        }
        field(52; "Emergency Relationship1"; Text[100])
        {
        }
        field(53; "Emergency P.O. Box1"; Text[50])
        {
        }
        field(54; "Emergency Phone No1"; Code[30])
        {
        }
        field(55; "Emergency Email1"; Text[50])
        {
        }
        field(56; "Emergency Name2"; Text[50])
        {
        }
        field(57; "Emergency Relationship2"; Text[50])
        {
        }
        field(58; "Emergency P.O. Box2"; Text[50])
        {
        }
        field(59; "Emergency Phone No2"; Code[30])
        {
        }
        field(60; "Emergency Email2"; Text[50])
        {
        }
        field(61; "OLevel School"; Text[100])
        {
        }
        field(63; "OLevel Year Completed"; Code[20])
        {
        }
        field(64; "Primary School"; Text[50])
        {
        }
        field(65; "Primary Index no"; Code[30])
        {
        }
        field(66; "Primary Year Completed"; Code[20])
        {
        }
        field(67; "K.C.P.E. Results"; Text[10])
        {
        }
        field(68; "Any Other Institution Attended"; Text[50])
        {
        }
        field(69; Results; Boolean)
        {
        }
        field(70; Selected; Boolean)
        {
        }
        field(71; "Medical Doc Verified"; Boolean)
        {
        }
        field(72; "Result Slip Verified"; Boolean)
        {
        }
        field(73; "Bank Slip Verified"; Boolean)
        {
        }
        field(74; "Id Verified"; Boolean)
        {
        }
        field(75; "Bank Slip Number"; Boolean)
        {
        }
        field(76; "Medical Doc Uploaded"; Boolean)
        {
        }
        field(77; "Result Slip Uploaded"; Boolean)
        {
        }
        field(78; "Bank Slip Uploaded"; Boolean)
        {
        }
        field(79; "Id Uploaded"; Boolean)
        {
        }
        field(80; "Medical Url"; Text[50])
        {
        }
        field(81; "Result Slip Url"; Text[50])
        {
        }
        field(82; "Bank Slip Url"; Text[50])
        {
        }
        field(83; "Id Url"; Text[50])
        {
        }
        field(84; "Email Notification Send"; Boolean)
        {
        }
        field(85; "SMS Notification Send"; Boolean)
        {
        }
        field(86; Include_Hostel; Boolean)
        {
        }
        field(87; "Academic Year"; Code[20])
        {
        }
        field(88; OTP; Code[10])
        {
        }
        field(89; "OTP Last Send Date"; Date)
        {
        }
        field(90; "OTP Last Send Time"; Time)
        {
        }
        field(91; "OTP Expiry Date"; Date)
        {
        }
        field(92; "OTP Expiry Time"; Time)
        {
        }
        field(93; Accomodation; Option)
        {
            OptionCaption = ' ,Resident,Non-resident';
            OptionMembers = " ",Resident,"Non-resident";
        }
        field(94; "Non-Resident Owner"; Text[50])
        {
        }
        field(95; "Non-Resident Address"; Text[50])
        {
        }
        field(96; "Residential Owner Phone"; Text[20])
        {
        }
        field(97; "Assigned Room"; Code[20])
        {
        }
        field(98; "Assigned Space"; Code[20])
        {
        }
        field(99; "Assigned Block"; Code[20])
        {
        }
        field(100; "Funding Category"; Code[20])
        {
            TableRelation = "Student Funding Categories"."Category Code";
        }
        field(101; "Funding %"; Decimal)
        {
            CalcFormula = sum("Category Funding Sources"."Funding %" where("Category Code" = field("Funding Category")));
            FieldClass = FlowField;
        }
        field(102; Billable_Amount; Decimal)
        {
            CalcFormula = sum("Admissions Billable Items"."Charge Amount" where(Index = field(Index),
                                                                                 Admin = field(Admin)));
            FieldClass = FlowField;
        }
        field(103; Confirmed; Boolean)
        {

            trigger OnValidate()
            var
                HostelCode: Code[20];
                Customs: Record Customer;
                KUCCPSImports: Record "KUCCPS Imports";
                ACAAdmissionAccomRooms: Record "ACA-Admission Accom. Rooms";
                ACACharge: Record "ACA-Charge";
                AdmissionsBillableItems: Record "Admissions Billable Items";
                ACAStageCharges: Record "ACA-Stage Charges";
                ACAFeeByStage: Record "ACA-Fee By Stage";
                TuitionFeesAmount: Decimal;
                CategoryFundingSources: Record "Category Funding Sources";
                ACARoomSpaces: Record "ACA-Room Spaces";
                KUCCPSImports2: Record "KUCCPS Imports";
                accomChargeCode: Code[20];
                SendMail: Codeunit "Notifications Handler";
                RptFileName: Text;
                MailBody: Text;
                FileBase64: Text;
            begin
                // Confirmation by the student triggers generation of proforma Bill
                if Confirmed = true then begin
                    // if "Academic Year" <> '2024/2025' then
                    //     Error('Academic year ' + "Academic Year" + 'is not allowed');
                    if Rec.Accomodation = Rec.Accomodation::Resident then begin
                        Rec.CalcFields("Total Resident Students", "Available Room Spaces (M)", "Available Room Spaces (F)");
                        if Rec.Gender = Rec.Gender::Male then begin
                            if "Total Resident Students" > "Available Room Spaces (M)" then begin
                                Error('Accomodation spaces are exhausted.\Kindly make private arrangements for accomodation.');
                            end;
                        end else if Rec.Gender = Rec.Gender::Female then begin
                            if "Total Resident Students" > "Available Room Spaces (F)" then begin
                                Error('Accomodation spaces are exhausted.\Kindly make private arrangements for accomodation.');
                            end;
                        end;
                    end;
                    Clear(KUCCPSImports);
                    KUCCPSImports.Reset;
                    KUCCPSImports.SetRange(ser, Rec.ser);
                    KUCCPSImports.SetRange("Academic Year", Rec."Academic Year");
                    if KUCCPSImports.Find('-') then;
                    if Rec.Confirmed then begin
                        Clear(ACAAcademicYear);
                        ACAAcademicYear.Reset;
                        //ACAAcademicYear.SETRANGE(Current,TRUE);
                        ACAAcademicYear.SetRange(Code, '2025/2026');
                        if ACAAcademicYear.Find('-') then begin
                        end;
                        Rec."Current Approval Level" := 'APPROVAL INITIATED';
                        Clear(ACANewStudDocSetup);
                        ACANewStudDocSetup.Reset;
                        ACANewStudDocSetup.SetRange("Academic Year", Rec."Academic Year");
                        if ACANewStudDocSetup.Find('-') then begin
                            repeat
                            begin
                                Clear(AdmissionDocumentApprovers);
                                AdmissionDocumentApprovers.Reset;
                                AdmissionDocumentApprovers.SetRange("Academic Year", Rec."Academic Year");
                                AdmissionDocumentApprovers.SetRange("Document Code", ACANewStudDocSetup."Document Code");
                                if AdmissionDocumentApprovers.Find('-') then begin
                                    repeat
                                    begin
                                        AdmissionApprovalEntries.Init;
                                        AdmissionApprovalEntries.ser := Rec.ser;
                                        AdmissionApprovalEntries.Index := Rec.Index;
                                        AdmissionApprovalEntries.Admin := Rec.Admin;
                                        AdmissionApprovalEntries.Prog := Rec.Prog;
                                        AdmissionApprovalEntries.Names := Rec.Names;
                                        AdmissionApprovalEntries.Gender := Rec.Gender;
                                        AdmissionApprovalEntries.Phone := Rec.Phone;
                                        if ACANewStudDocSetup.Sequence = 1 then
                                            AdmissionApprovalEntries."Approval Status" := AdmissionApprovalEntries."approval status"::Open
                                        else
                                            AdmissionApprovalEntries."Approval Status" := AdmissionApprovalEntries."approval status"::Created;
                                        AdmissionApprovalEntries."Alt. Phone" := Rec."Alt. Phone";
                                        AdmissionApprovalEntries.Box := Rec.Box;
                                        AdmissionApprovalEntries.Codes := Rec.Codes;
                                        AdmissionApprovalEntries.Town := Rec.Town;
                                        AdmissionApprovalEntries.Email := Rec.Email;
                                        AdmissionApprovalEntries."Slt Mail" := Rec."Slt Mail";
                                        AdmissionApprovalEntries.Processed := Rec.Processed;
                                        AdmissionApprovalEntries.County := Rec.County;
                                        AdmissionApprovalEntries."Date of Birth" := Rec."Date of Birth";
                                        AdmissionApprovalEntries."ID Number/BirthCert" := Rec."ID Number/BirthCert";
                                        AdmissionApprovalEntries."Intake Code" := Rec."Intake Code";
                                        AdmissionApprovalEntries.Updated := Rec.Updated;
                                        AdmissionApprovalEntries."NIIMS No" := Rec."NIIMS No";
                                        AdmissionApprovalEntries."Physical Impairments" := Rec."Physical Impairments";
                                        AdmissionApprovalEntries."Physical impairments Details" := Rec."Physical impairments Details";
                                        AdmissionApprovalEntries."NHIF No" := Rec."NHIF No";
                                        AdmissionApprovalEntries.Religion := Rec.Religion;
                                        AdmissionApprovalEntries.Nationality := Rec.Nationality;
                                        AdmissionApprovalEntries."Marital Status" := Rec."Marital Status";
                                        AdmissionApprovalEntries."Name of Spouse" := Rec."Name of Spouse";
                                        AdmissionApprovalEntries."Occupation of Spouse" := Rec."Occupation of Spouse";
                                        AdmissionApprovalEntries."Spouse Phone No" := Rec."Spouse Phone No";
                                        AdmissionApprovalEntries."Number of Children" := Rec."Number of Children";
                                        AdmissionApprovalEntries."Full Name of Father" := Rec."Full Name of Father";
                                        AdmissionApprovalEntries."Father Status" := Rec."Father Status";
                                        AdmissionApprovalEntries."Father Occupation" := Rec."Father Occupation";
                                        AdmissionApprovalEntries."Father Date of Birth" := Rec."Father Date of Birth";
                                        AdmissionApprovalEntries."Name of Mother" := Rec."Name of Mother";
                                        AdmissionApprovalEntries."Mother Status" := Rec."Mother Status";
                                        AdmissionApprovalEntries."Mother Occupation" := Rec."Mother Occupation";
                                        AdmissionApprovalEntries."Mother Date of Birth" := Rec."Mother Date of Birth";
                                        AdmissionApprovalEntries."Number of brothers and sisters" := Rec."Number of brothers and sisters";
                                        AdmissionApprovalEntries."Place of Birth" := Rec."Place of Birth";
                                        AdmissionApprovalEntries."Permanent Residence" := Rec."Permanent Residence";
                                        AdmissionApprovalEntries."Nearest Town" := Rec."Nearest Town";
                                        AdmissionApprovalEntries.Location := Rec.Location;
                                        AdmissionApprovalEntries."Name of Chief" := Rec."Name of Chief";
                                        AdmissionApprovalEntries."Sub-County" := Rec."Sub-County";
                                        AdmissionApprovalEntries.Constituency := Rec.Constituency;
                                        AdmissionApprovalEntries."Nearest Police Station" := Rec."Nearest Police Station";
                                        AdmissionApprovalEntries."Emergency Name1" := Rec."Emergency Name1";
                                        AdmissionApprovalEntries."Emergency Relationship1" := Rec."Emergency Relationship1";
                                        AdmissionApprovalEntries."Emergency P.O. Box1" := Rec."Emergency P.O. Box1";
                                        AdmissionApprovalEntries."Emergency Phone No1" := Rec."Emergency Phone No1";
                                        AdmissionApprovalEntries."Emergency Email1" := Rec."Emergency Email1";
                                        AdmissionApprovalEntries."Emergency Name2" := Rec."Emergency Name2";
                                        AdmissionApprovalEntries."Emergency Relationship2" := Rec."Emergency Relationship2";
                                        AdmissionApprovalEntries."Emergency P.O. Box2" := Rec."Emergency P.O. Box2";
                                        AdmissionApprovalEntries."Emergency Phone No2" := Rec."Emergency Phone No2";
                                        AdmissionApprovalEntries."Emergency Email2" := Rec."Emergency Email2";
                                        AdmissionApprovalEntries."OLevel School" := Rec."OLevel School";
                                        AdmissionApprovalEntries."OLevel Year Completed" := Rec."OLevel Year Completed";
                                        AdmissionApprovalEntries."Primary School" := Rec."Primary School";
                                        AdmissionApprovalEntries."Primary Index no" := Rec."Primary Index no";
                                        AdmissionApprovalEntries."Primary Year Completed" := Rec."Primary Year Completed";
                                        AdmissionApprovalEntries."K.C.P.E. Results" := Rec."K.C.P.E. Results";
                                        AdmissionApprovalEntries."Any Other Institution Attended" := Rec."Any Other Institution Attended";
                                        AdmissionApprovalEntries.Results := Rec.Results;
                                        AdmissionApprovalEntries.Selected := Rec.Selected;
                                        AdmissionApprovalEntries."Medical Doc Verified" := Rec."Medical Doc Verified";
                                        AdmissionApprovalEntries."Result Slip Verified" := Rec."Result Slip Verified";
                                        AdmissionApprovalEntries."Bank Slip Verified" := Rec."Bank Slip Verified";
                                        AdmissionApprovalEntries."Id Verified" := Rec."Id Verified";
                                        AdmissionApprovalEntries."Bank Slip Number" := Rec."Bank Slip Number";
                                        AdmissionApprovalEntries."Medical Doc Uploaded" := Rec."Medical Doc Uploaded";
                                        AdmissionApprovalEntries."Result Slip Uploaded" := Rec."Result Slip Uploaded";
                                        AdmissionApprovalEntries."Bank Slip Uploaded" := Rec."Bank Slip Uploaded";
                                        AdmissionApprovalEntries."Id Uploaded" := Rec."Id Uploaded";
                                        AdmissionApprovalEntries."Medical Url" := Rec."Medical Url";
                                        AdmissionApprovalEntries."Result Slip Url" := Rec."Result Slip Url";
                                        AdmissionApprovalEntries."Bank Slip Url" := Rec."Bank Slip Url";
                                        AdmissionApprovalEntries."Id Url" := Rec."Id Url";
                                        AdmissionApprovalEntries."Email Notification Send" := Rec."Email Notification Send";
                                        AdmissionApprovalEntries."SMS Notification Send" := Rec."SMS Notification Send";
                                        AdmissionApprovalEntries.Include_Hostel := Rec.Include_Hostel;
                                        AdmissionApprovalEntries."Academic Year" := Rec."Academic Year";
                                        AdmissionApprovalEntries.OTP := Rec.OTP;
                                        AdmissionApprovalEntries."OTP Last Send Date" := Rec."OTP Last Send Date";
                                        AdmissionApprovalEntries."OTP Last Send Time" := Rec."OTP Last Send Time";
                                        AdmissionApprovalEntries."OTP Expiry Date" := Rec."OTP Expiry Date";
                                        AdmissionApprovalEntries."OTP Expiry Time" := Rec."OTP Expiry Time";
                                        AdmissionApprovalEntries.Accomodation := Rec.Accomodation;
                                        AdmissionApprovalEntries."Non-Resident Owner" := Rec."Non-Resident Owner";
                                        AdmissionApprovalEntries."Non-Resident Address" := Rec."Non-Resident Address";
                                        AdmissionApprovalEntries."Residential Owner Phone" := Rec."Residential Owner Phone";
                                        AdmissionApprovalEntries."Asigned Room" := Rec."Assigned Room";
                                        AdmissionApprovalEntries."Assigned Space" := Rec."Assigned Space";
                                        AdmissionApprovalEntries."Asigned Block" := Rec."Assigned Block";
                                        AdmissionApprovalEntries."Funding Category" := Rec."Funding Category";
                                        AdmissionApprovalEntries."Funding %" := Rec."Funding %";
                                        AdmissionApprovalEntries.Billable_Amount := Rec.Billable_Amount;
                                        AdmissionApprovalEntries.Confirmed := Rec.Confirmed;
                                        AdmissionApprovalEntries."Last Booked Date/Time" := Rec."Last Booked Date/Time";
                                        AdmissionApprovalEntries."Booking Expiry Date/Time" := Rec."Booking Expiry Date/Time";
                                        AdmissionApprovalEntries.Approver_Id := AdmissionDocumentApprovers."Approved ID";
                                        AdmissionApprovalEntries."Document Code" := ACANewStudDocSetup."Document Code";
                                        AdmissionApprovalEntries."Approval Sequence" := ACANewStudDocSetup.Sequence;
                                        if AdmissionApprovalEntries.Insert then;
                                    end;
                                    until AdmissionDocumentApprovers.Next = 0;
                                end;
                            end;
                            until ACANewStudDocSetup.Next = 0;
                        end;
                    end;

                    //- Check if Student has Booked for a room, if yes, check if billing for room is done if room still exists
                    // - If Resident, Check if Payment allow for allocation, pick a room if exists
                    Clear(HostelCode);
                    Clear(ACACharge);
                    ACACharge.Reset;
                    ACACharge.SetRange(Hostel, true);
                    if ACACharge.Find('-') then;// HostelCode := ACACharge.Code;
                    if KUCCPSImports.Accomodation = KUCCPSImports.Accomodation::Resident then begin
                        // // // // // // // // // // // //      // Clear Over Stayed Rooms............................................................................................
                        // // // // // // // // // // // //      CLEAR(KUCCPSImports2);
                        // // // // // // // // // // // //      CLEAR(ACARoomSpaces);
                        // // // // // // // // // // // //      ACARoomSpaces.SETRANGE(Status,ACARoomSpaces.Status::Vaccant);
                        // // // // // // // // // // // //      CLEAR(ACAAdmissionAccomRooms);
                        // // // // // // // // // // // //      ACAAdmissionAccomRooms.RESET;
                        // // // // // // // // // // // //        ACAAdmissionAccomRooms.SETRANGE("Academic Year",KUCCPSImports."Academic Year");
                        //KUCCPSImports."Assigned Space" := '';
                        // Check if Room asigned still exists
                        if KUCCPSImports."Assigned Space" = '' then begin
                            //Student Wanted accomodation but delayted in payment and the routine removed the booking, if rooms still exists, check if fee paid meets the requirement
                            Clear(ACAAdmissionAccomRooms);
                            ACAAdmissionAccomRooms.Reset;
                            ACAAdmissionAccomRooms.SetRange("Allocation Status", ACAAdmissionAccomRooms."allocation status"::Vaccant);
                            ACAAdmissionAccomRooms.SetRange("Academic Year", KUCCPSImports."Academic Year");
                            ACAAdmissionAccomRooms.SetAutocalcFields("Hostel Exists", "Assignment Sequence");
                            ACAAdmissionAccomRooms.SetRange(Gender, KUCCPSImports.Gender);
                            ACAAdmissionAccomRooms.SetRange("Hostel Exists", true);
                            ACAAdmissionAccomRooms.SetCurrentkey("Assignment Sequence");
                            ACAAdmissionAccomRooms.SetAscending("Assignment Sequence", true);
                            if ACAAdmissionAccomRooms.Find('-') then begin
                                // A room exists, create a booking for the student
                                KUCCPSImports."Assigned Space" := ACAAdmissionAccomRooms."Space Code";
                                KUCCPSImports."Assigned Block" := ACAAdmissionAccomRooms."Block Code";
                                KUCCPSImports."Assigned Room" := ACAAdmissionAccomRooms."Room Code";
                                KUCCPSImports."Last Booked Date/Time" := CreateDatetime(Today, Time);
                                if KUCCPSImports.Modify then begin
                                    ACAAdmissionAccomRooms."Allocation Status" := ACAAdmissionAccomRooms."allocation status"::Booked;
                                    ACAAdmissionAccomRooms.Modify;
                                end;
                            end;
                        end;
                    end else begin
                        KUCCPSImports.Selected := true;
                        KUCCPSImports.Modify;
                        Report.Run(Report::"Process JAB Admissions", false, false, KUCCPSImports);
                        Commit;
                        //Send Non-Resident Email  TODO
                        MailBody := 'You have not applied for a hostel allocation. You are therefore adviced to make personal arrangements for accomodation. Find Attached Form.';
                        RptFileName := 'G:\Non-Resident Form\5b.-Non-Resident-Form (1)' + '.pdf';
                        FileBase64 := SendMail.ConvertFileToBase64(RptFileName);
                        SendMail.fnSendemail(Names, 'HOSTEL ALERT TO NON RESIDENT', MailBody, Email, '', '', true, FileBase64, '5b.-Non-Resident-Form (1)', 'pdf');
                        //SendMail.SendEmailEasy_WithAttachment('Dear ', Names, MailBody, '', 'Karatina University', 'Hostel Manager', Email, ' HOSTEL ALERT TO NON RESIDENT', RptFileName, RptFileName);
                    end;
                    if KUCCPSImports."Assigned Space" <> '' then begin
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
                        //     IF AdmissionsBillableItems.INSERT THEN;     Allow students to be admitted without billing other items save for accomodation
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
                            //    IF AdmissionsBillableItems.INSERT THEN;  Allow students to be admitted without billing other items save for accomodation
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
                                    ///      IF AdmissionsBillableItems.INSERT THEN;    Allow students to be admitted without billing other items save for accomodation
                                end;
                            end;
                            until CategoryFundingSources.Next = 0;
                        end;
                    end
                    // Generate Bill for the student and poulate the Billable Charges Table.
                end else begin
                    Clear(AdmissionsBillableItems);
                    AdmissionsBillableItems.Reset;
                    AdmissionsBillableItems.SetRange(Index, KUCCPSImports.Index);
                    AdmissionsBillableItems.SetRange(Admin, KUCCPSImports.Admin);
                    if AdmissionsBillableItems.Find('-') then begin
                        // Clear the funding entries
                        AdmissionsBillableItems.DeleteAll;
                    end;
                    Clear(AdmissionApprovalEntries);
                    AdmissionApprovalEntries.Reset;
                    AdmissionApprovalEntries.SetRange(ser, Rec.ser);
                    AdmissionApprovalEntries.SetRange("Academic Year", Rec."Academic Year");
                    if AdmissionApprovalEntries.Find('-') then AdmissionApprovalEntries.DeleteAll;
                end;


                // Approve and Admin Student
                Clear(ACAAcademicYear);
                ACAAcademicYear.Reset;
                ACAAcademicYear.SetRange(Current, true);
                if ACAAcademicYear.Find('-') then begin
                end;
                Rec."Current Approval Level" := 'APPROVAL INITIATED';
                Clear(ACANewStudDocSetup);
                ACANewStudDocSetup.Reset;
                ACANewStudDocSetup.SetRange("Academic Year", Rec."Academic Year");
                ACANewStudDocSetup.SetRange("Final Stage", true);
                if ACANewStudDocSetup.Find('-') then begin
                    repeat
                    begin
                        Clear(ACANewStudDocuments);
                        ACANewStudDocuments.Reset;
                        ACANewStudDocuments.SetRange("Index Number", Rec.Index);
                        ACANewStudDocuments.SetRange("Document Code", ACANewStudDocSetup."Document Code");
                        if ACANewStudDocuments.Find('-') then begin
                            ACANewStudDocuments."Approval Status" := ACANewStudDocuments."approval status"::Approved;
                            ACANewStudDocuments.ApproveDocument(ACANewStudDocuments, UserId);
                        end;
                    end;
                    until ACANewStudDocSetup.Next = 0;
                end;
                //begin create customer in order to bill hostel 
                //process admission
                if KUCCPSImports.Accomodation = KUCCPSImports.Accomodation::Resident then begin
                    Selected := true;
                    Report.Run(Report::"Process JAB Admissions", false, false, Rec);
                    Commit;
                    //Admit student from the applic form header
                    ApplicHeader.Reset;
                    ApplicHeader.SetRange("Admission No", Rec.Admin);
                    if ApplicHeader.FindFirst then begin
                        ApplicHeader.TestField(County);
                        ApplicHeader.TestField("ID Number");
                        ApplicHeader.TestField("Date Of Birth");
                        ApplicHeader."Settlement Type" := 'NFM';
                        ApplicHeader.Status := ApplicHeader.Status::Approved;
                        ApplicHeader.Validate(Status);
                        ApplicHeader."Documents Verified" := true;
                        ApplicHeader."Payments Verified" := true;
                        ApplicHeader.Modify;
                        Commit;
                        applicPage.SetRecord(ApplicHeader);
                        applicPage.TransferToAdmission(ApplicHeader."Admission No");
                    end;
                    //ENd hostel billing
                end;
            end;
        }
        field(104; "Last Booked Date/Time"; DateTime)
        {
        }
        field(106; "Booking Expiry Date/Time"; DateTime)
        {
        }
        field(107; "Receipt Amount"; Decimal)
        {
            CalcFormula = sum(Core_Banking_Details."Trans. Amount" where("Student No." = field(Admin)));
            FieldClass = FlowField;
        }
        field(108; "Current Approval Level"; Code[50])
        {
        }
        field(109; "Documents Count"; Integer)
        {
            CalcFormula = count("ACA-New Stud. Documents" where("Academic Year" = field("Academic Year"),
                                                                 "Index Number" = field(Index)));
            FieldClass = FlowField;
        }
        field(110; "Settlement Type"; Code[20])
        {
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(111; Tribe; Code[20])
        {
            TableRelation = Tribes."Tribe Code";
        }
        field(112; "Father Telephone"; Code[20])
        {
        }
        field(113; "Mother Telephone"; Code[20])
        {
        }
        field(114; AcommSubmitted; Boolean)
        {
        }
        field(115; "Available Room Spaces (M)"; Integer)
        {
            CalcFormula = lookup("ACA-General Set-Up"."Available Accom. Spaces (Male)");
            FieldClass = FlowField;
        }
        field(116; "Available Room Spaces (F)"; Integer)
        {
            CalcFormula = lookup("ACA-General Set-Up"."Available Acc. Spaces(Female)");
            FieldClass = FlowField;
        }
        field(117; "Total Resident Students"; Integer)
        {
            CalcFormula = count("KUCCPS Imports" where("Academic Year" = field("Academic Year"),
                                                        Accomodation = filter(Resident),
                                                        Gender = field(Gender)));
            FieldClass = FlowField;
        }
        //Reported,Notified,Campus Location,,Faculty,Surname
        field(118; Reported; Boolean)
        {
        }
        field(119; Notified; Boolean)
        {
        }
        field(120; "Campus Location"; Code[20])
        {
        }
        field(121; Faculty; Code[20])
        {
        }
        field(122; Surname; Text[50])
        {
        }
        field(123; "Student No"; Code[20])
        {
        }
        field(124; "KUCCPS Batch"; Code[20])
        {
        }
        field(125; "Middle Name"; Text[50])
        {
        }
        field(126; "Resent E-mail"; Boolean)
        {
        }
        //Generated
        field(127; Generated; Boolean)
        {
        }
        //"Disability Status"
        field(128; "Disability Status"; option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(129; "Disability Description"; Text[250])
        {
        }
        //"Ethnic Background"
        field(130; "Ethnic Background"; Code[20])
        {
            // TableRelation = 
        }
    }

    keys
    {
        key(Key1; ser, "Academic Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        CLEAR(ACAAcademicYear);
        ACAAcademicYear.RESET;
        ACAAcademicYear.SETRANGE(Current, TRUE);
        IF ACAAcademicYear.FIND('-') THEN BEGIN
            "Academic Year" := ACAAcademicYear.Code;
        END;
        Rec."Current Approval Level" := 'APPROVAL INITIATED';
        CLEAR(ACANewStudDocSetup);
        ACANewStudDocSetup.RESET;
        ACANewStudDocSetup.SETRANGE("Academic Year", Rec."Academic Year");
        IF ACANewStudDocSetup.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                ACANewStudDocuments.INIT;
                ACANewStudDocuments."Academic Year" := ACANewStudDocSetup."Academic Year";
                ACANewStudDocuments."Index Number" := Rec.Index;
                ACANewStudDocuments."Document Code" := ACANewStudDocSetup."Document Code";
                ACANewStudDocuments."Approval Sequence" := ACANewStudDocSetup.Sequence;
                IF ACANewStudDocSetup.Sequence = 1 THEN
                    ACANewStudDocuments."Approval Status" := ACANewStudDocuments."Approval Status"::Open
                ELSE
                    ACANewStudDocuments."Approval Status" := ACANewStudDocuments."Approval Status"::Created;
                IF ACANewStudDocuments.INSERT THEN;
            END;
            UNTIL ACANewStudDocSetup.NEXT = 0;
        END;
    end;

    var
        ACAAcademicYear: Record "ACA-Academic Year";
        ACANewStudDocSetup: Record "ACA-New Stud. Doc. Setup";
        ACANewStudDocuments: Record "ACA-New Stud. Documents";
        AdmissionDocumentApprovers: Record "Admission Document Approvers";
        AdmissionApprovalEntries: Record "Admission Approval Entries";
        KuccpsAdminPage: Page "KUCCPS Imports";
        ApplicHeader: Record "ACA-Applic. Form Header";
        applicPage: Page "ACA-Pending Admissions List";
}
