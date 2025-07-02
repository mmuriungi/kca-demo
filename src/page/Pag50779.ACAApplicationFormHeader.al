/// <summary>
/// Page ACA-Application Form Header (ID 68467).
/// </summary>
page 50779 "ACA-Application Form Header"
{
    PageType = Document;
    SourceTable = "ACA-Applic. Form Header";

    layout
    {
        area(content)
        {
            field("Application No."; Rec."Application No.")
            {
                Editable = true;
                ApplicationArea = All;
                Caption = 'Application Ref No';
            }
            field("Settlement Type"; Rec."Settlement Type")
            {
                Caption = 'Application Category';
                ApplicationArea = All;
            }
            field("Application Date"; Rec."Application Date")
            {
                ApplicationArea = All;
            }
            field("Receipt Slip No."; Rec."Receipt Slip No.")
            {
                ApplicationArea = All;
            }
            group("Personal Information")
            {

                field("Enquiry No"; Rec."Enquiry No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }


                field(Salutation; Rec.Salutation)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("First Name"; Rec.firstName)
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Other Names")
                {
                    ApplicationArea = All;
                    caption = 'Middle Name';

                }
                field("Last Name"; Rec.Surname)
                {
                    ApplicationArea = All;
                    Caption = 'Last name';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Display the age of the user*/
                        Age := Rec.GetAge(Rec."Date Of Birth");

                    end;
                }
                field(Age; Age)
                {
                    Caption = 'Age';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    Caption = 'Nationality';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Get the name of the country of nationality*/
                        NationalityName := Rec.GetCountry(Rec.Nationality);

                    end;
                }

                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    Caption = 'County of Origin';
                }
                field("ID Number"; Rec."ID Number")
                {
                    Caption = 'ID Number';
                    ApplicationArea = All;
                }
                field("Passport Number"; Rec."Passport Number")
                {
                    ApplicationArea = All;
                }
                field("Birth Cert No"; Rec."Birth Cert No")
                {
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = All;
                }
                field(Denomination; Rec.Denomination)
                {
                    ApplicationArea = All;
                }

                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field(Disability; Rec.Disability)
                {
                    ApplicationArea = All;
                }
                field("Nature of Disability"; Rec."Nature of Disability")
                {
                    ApplicationArea = All;
                    Caption = 'Dissability Type';
                }
                field("Knew College Thru"; Rec."Knew College Thru")
                {
                    Caption = 'Knew College Through';
                    ApplicationArea = All;
                }

                field("Previous Education Level"; Rec."Previous Education Level")
                {
                    ApplicationArea = All;
                }

                field("Process Application"; Rec."Process Application")
                {
                    ApplicationArea = All;
                }




            }
            group("Parents/Guardian/Next of Kin Information")
            {
                field("Next of kin Name"; Rec."Next of kin Name")
                {
                    ApplicationArea = All;
                }
                field("Next of kin Mobile"; Rec."Next of kin Mobile")
                {
                    ApplicationArea = All;
                }
                field("Next of Kin R/Ship"; Rec."Next of Kin R/Ship")
                {
                    ApplicationArea = all;
                }
                field("Next Of Kin Email"; Rec."Next Of Kin Email")
                {
                    ApplicationArea = all;
                }
            }
            group("Emergency Contact Information")
            {
                field("Emergency Contact Name"; Rec."Emergency Contact Name")
                {
                    ApplicationArea = All;
                }
                field("Emergency Contact Telephone"; Rec."Emergency Contact Telephone")
                {
                    Caption = 'Emergency Contact Primary Telephone';
                    ApplicationArea = All;
                }
                field("Emergency Email"; Rec."Emergency Email")
                {
                    Caption = 'Emergency Contact Email';
                    ApplicationArea = All;
                }
                field("R/Ship to Emerg Contact"; Rec."Emergency Relationship")
                {
                    ApplicationArea = all;
                }
            }
            group("Contact Details")
            {
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    Caption = 'Mobile Phone Number';
                    ApplicationArea = All;
                }
                field("Telephone No. 2"; Rec."Telephone No. 2")
                {
                    Caption = 'Alternate Mobile Phone No';
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    Caption = 'Personal Email Adress';
                }
                field("Address for Correspondence1"; Rec."Address for Correspondence1")
                {
                    Caption = 'Postal Address';
                    ApplicationArea = All;
                }
                field("Address for Correspondence2"; Rec."Address for Correspondence2")
                {
                    Caption = 'Postal Code';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Address for Correspondence3"; Rec."Address for Correspondence3")
                {
                    Caption = 'Town';
                    ApplicationArea = All;
                }
                field("Nationality Code"; Rec.Nationality)
                {
                    Caption = 'Country';
                    ApplicationArea = All;
                }


            }


            group("Program Details")
            {
                field("Programme Level"; Rec."Programme Level")
                {
                    ApplicationArea = All;
                }
                field("Intake Code"; Rec."Intake Code")
                {
                    ApplicationArea = All;

                }
                field("First Degree Choice"; Rec."First Degree Choice")
                {
                    Caption = 'Program Applied For';
                    ApplicationArea = All;


                    trigger OnValidate()
                    begin
                        /*Display the name of the programme*/
                        //DegreeName1:=GetDegree("First Degree Choice");
                        recProgramme.RESET;
                        recProgramme.SetRange(Code, Rec."First Degree Choice");
                        if recProgramme.find('-') THEN BEGIN
                            //programName := recProgramme.Description;
                            Rec."Admitted Department" := recProgramme."Department Code";
                            Rec."Programme Faculty" := recProgramme."School Code";
                            FacultyName1 := Rec.GetFaculty(Rec."First Degree Choice");

                        END;

                    end;
                }

                field(programName; Rec.programName)
                {
                    ApplicationArea = All;
                    Caption = 'Program Name';
                }
                field("Programme Faculty"; Rec."Programme Faculty")
                {
                    Caption = 'Programm Faculty Code';
                    ApplicationArea = All;
                    Editable = false;


                }
                field("Admitted Department"; Rec."Admitted Department")
                {
                    ApplicationArea = All;
                }
                field("First Choice Stage"; Rec."First Choice Stage")
                {
                    ApplicationArea = All;
                    Caption = 'First Stage';

                    trigger OnValidate()
                    begin
                        FirstChoiceStageName := GetStageName(Rec."First Choice Stage");
                    end;
                }

                field("Mode of Study"; Rec."Mode of Study")
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                    Caption = 'Preffered Campus';
                }
                field("First Choice Semester"; Rec."First Choice Semester")
                {
                    ApplicationArea = All;
                    Caption = 'Preffered Semester to Commence';

                    trigger OnValidate()
                    begin
                        FirstChoiceSemesterName := GetSemesterName(Rec."First Choice Semester");
                    end;
                }
                field("Second Degree Choice"; Rec."Second Degree Choice")
                {
                    Caption = 'Second Choice';
                    ApplicationArea = All;
                }



            }
            group("Prerequisite Details")
            {
                part("Program Prerequisite"; "Program Prerequisite")
                {
                    SubPageLink = "Application No" = field("Application No.");
                    ApplicationArea = All;
                }
            }


            group("High School Information")
            {
                field("Index Number"; Rec."Index Number")
                {
                    ApplicationArea = All;
                    Caption = 'High School Index No.';
                }
                field("Former School Code"; Rec."Former School Code")
                {
                    ApplicationArea = All;
                    Caption = 'Name Of High School Attended';
                    Visible = false;

                    // trigger OnValidate()
                    // begin
                    //     /*Display the name of the former school*/
                    //     FormerSchoolName := Rec.GetFormerSchool(Rec."Former School Code");

                    // end;
                }
                field(formerSchool; Rec.formerSchool)
                {
                    ApplicationArea = All;
                    Caption = 'Highschool Attended';
                }
                field("Date of Admission"; Rec."Date of Admission")
                {
                    ApplicationArea = All;
                    Caption = 'High School Attended From';
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                    ApplicationArea = All;
                    Caption = 'High School Attended To';
                }
                field("Year of Examination"; Rec."Year of Examination")
                {
                    ApplicationArea = All;
                }
                field("Examination Body"; Rec."Examination Body")
                {
                    ApplicationArea = All;
                }
                field(Examination; Rec.Examination)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (Rec.Examination = Rec.Examination::KCSE) OR (Rec.Examination = Rec.Examination::KCE) OR (Rec.Examination = Rec.Examination::EACE) THEN BEGIN
                            "Principal PassesVisible" := FALSE;
                            "Subsidiary PassesVisible" := FALSE;
                            "Mean Grade AcquiredVisible" := TRUE;
                            "Points AcquiredVisible" := TRUE;
                        END
                        ELSE BEGIN
                            "Principal PassesVisible" := TRUE;
                            "Subsidiary PassesVisible" := TRUE;
                            "Mean Grade AcquiredVisible" := FALSE;
                            "Points AcquiredVisible" := FALSE;
                        END;
                    end;
                }

                field("Mean Grade Acquired"; Rec."Mean Grade Acquired")
                {
                    Visible = "Mean Grade AcquiredVisible";
                    ApplicationArea = All;
                }
                //

                field("High Sch. Cert attched"; Rec."High Sch. Cert attched")
                {
                    ApplicationArea = All;
                }
                field("High Sch. Rslt Slip Attached"; Rec."High Sch. Rslt Slip Attached")
                {
                    ApplicationArea = All;
                }

                field("Transfer Case"; Rec."Transfer Case")
                {
                    ApplicationArea = All;
                }
                field("Transfer Letter Attached"; Rec."Transfer Letter Attached")
                {
                    ApplicationArea = All;
                }
            }
            group("Certificate and Diploma")
            {
                field("Certificate Institution"; Rec."Certificate Institution")
                {
                    ApplicationArea = All;
                }
                field("Certificate Programme"; Rec."Certificate Programme")
                {
                    ApplicationArea = All;
                }
                field("Certificate Grade Attained"; Rec."Certificate Grade Attained")
                {
                    ApplicationArea = All;
                }
                field("Certificate Year of Adm"; Rec."Certificate Year of Adm")
                {
                    Caption = 'Year of Admission';
                    ApplicationArea = All;
                }
                field("Certificate Year of Comp"; Rec."Certificate Year of Comp")
                {
                    Caption = 'Year of completion';
                    ApplicationArea = All;
                }
                field("Diploma Institution"; Rec."Diploma Institution")
                {
                    ApplicationArea = All;
                }
                field("Diploma Programme"; Rec."Diploma Programme")
                {
                    ApplicationArea = All;
                }
                field("Diploma Grade Attained"; Rec."Diploma Grade Attained")
                {
                    ApplicationArea = All;
                }
                field("Diploma Year of Adm"; Rec."Diploma Year of Adm")
                {
                    Caption = 'Year of Admission';
                    ApplicationArea = All;
                }
                field("Diploma Year of Comp"; Rec."Diploma Year of Comp")
                {
                    Caption = 'Year of completion';
                    ApplicationArea = All;
                }
            }
            group("Post Graduate")
            {
                field("Bachelor Institution"; Rec."Bachelor Institution")
                {
                    ApplicationArea = All;
                }
                field("Bachelor Programme"; Rec."Bachelor Programme")
                {
                    ApplicationArea = All;
                }
                field("Bachelor Grade Attained"; Rec."Bachelor Grade Attained")
                {
                    ApplicationArea = All;
                }
                field("Bachelor Year of Adm"; Rec."Bachelor Year of Adm")
                {
                    Caption = 'Year of Admission';
                    ApplicationArea = All;
                }
                field("Bachelor Year of Comp"; Rec."Bachelor Year of Comp")
                {
                    Caption = 'Year of completion';
                    ApplicationArea = All;
                }
                field("Masters Institution"; Rec."Masters Institution")
                {
                    ApplicationArea = All;
                }
                field("Masters Programme"; Rec."Masters Programme")
                {
                    ApplicationArea = All;
                }
                field("Masters Grade Attained"; Rec."Masters Grade Attained")
                {
                    ApplicationArea = All;
                }
                field("Masters Year of Adm"; Rec."Masters Year of Adm")
                {
                    Caption = 'Year of Admission';
                    ApplicationArea = All;
                }
                field("Masters Year of Comp"; Rec."Masters Year of Comp")
                {
                    Caption = 'Year of completion';
                    ApplicationArea = All;
                }
            }

        }
    }

    actions
    {
        area(navigation)
        {
            group("Other Information")
            {


                action("Employement Details")
                {
                    Image = ProfileCalender;
                    RunObject = Page "ACA-Application Form Qualif.";
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action(Attachments1)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';

                    trigger OnAction()
                    var
                        RecRef: RecordRef;
                        DocumentAttachment: Page "Document Attachment Custom";
                    begin
                        Clear(DocumentAttachment);
                        RecRef.GETTABLE(Rec);
                        DocumentAttachment.OpenForRecReference(RecRef);
                        DocumentAttachment.RUNMODAL;
                    end;
                }
                group(Sharepoint)
                {
                    action("Sharepoint Attachments")
                    {
                        ApplicationArea = all;

                        Image = Attach;
                        Promoted = true;
                        PromotedCategory = Category12;
                        trigger OnAction()
                        begin
                            DMS.Reset;
                            DMS.SetRange("Document type", DMS."Document type"::"Students Applications");
                            if DMS.Find('-') then begin
                                Hyperlink(DMS."url" + Rec."Application No.")
                            end else
                                Message('No Link ' + format(DMS."Document Type"::"Students Applications"))
                        end;

                    }
                }





            }
        }
        area(processing)
        {
            action(Attachments2)
            {
                ApplicationArea = All;
                Caption = 'Applicant Attachments';
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    DocumentAttachment: Page "Document Attachment Custom";
                begin
                    Clear(DocumentAttachment);
                    RecRef.GETTABLE(Rec);
                    DocumentAttachment.OpenForRecReference(RecRef);
                    DocumentAttachment.RUNMODAL;
                end;
            }
            action("Proffessionals Qualifications")
            {
                Caption = 'Academics Qualifications';
                Image = ProfileCalender;
                RunObject = Page "ACA-Application Acad Qual";
                RunPageLink = "Application No." = FIELD("Application No.");
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;
            }
            action(sendBack)
            {
                Caption = 'Send Back To Applicant';
                Image = SendTo;
                Promoted = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Send This Application back to the Applicant', TRUE) = FALSE THEN EXIT;
                    Rec.TestField("Student Feedback");
                    Rec."User ID" := UserId;
                    Rec.returned := True;
                    Rec.Modify();
                    SendFeedback();

                end;

            }

            action("Employement Details2")
            {
                Caption = 'Employement Details';
                Image = ProfileCalender;
                RunObject = Page "ACA-Application Form Qualif.";
                RunPageLink = "Application No." = FIELD("Application No.");
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;
            }

            action("Academic Referees")
            {
                Image = ProfileCalender;
                RunObject = Page "ACA-Academic Referees";
                RunPageLink = ApplicationNo = FIELD("Application No.");
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;
            }
            action(sendApproval)
            {
                Caption = 'Send To HOD';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Export F/O Consolidation";
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    tableNo: Integer;
                begin
                    //Release the Application for Approval
                    //Rec.TESTFIELD("First Name");
                    Rec.TESTFIELD(Surname);
                    //Rec.TestField("Admission Staff Recommendation");
                    //Rec.TESTFIELD("First Degree Choice");
                    Rec.TESTFIELD("Settlement Type");
                    Rec.TESTFIELD("Intake Code");
                    Rec.TESTFIELD(Campus);
                    // Rec.TESTFIELD("Next of kin Name");
                    // Rec.TESTFIELD("Next of kin Mobile");
                    // Rec.TESTFIELD("Next of Kin R/Ship");
                    // Rec.TESTFIELD("Fee payer Names");
                    // Rec.TESTFIELD("Fee payer mobile");
                    // Rec.TESTFIELD("Fee payer R/Ship");
                    // Rec.TESTFIELD("Fee payer Email");
                    Rec.TESTFIELD("Telephone No. 1");
                    Rec.TESTFIELD(Email);
                    //Rec.TESTFIELD("First Degree Choice");
                    Rec.TESTFIELD("Programme Level");
                    //Rec.TESTFIELD("First Choice Stage");
                    Rec.TESTFIELD("Mode of Study");
                    //Rec.TESTFIELD("First Choice Semester");

                    //TESTFIELD("Application Form Receipt No.");
                    //TESTFIELD("Address for Correspondence1");
                    //TESTFIELD("Date Of Birth");
                    IF AppSetup.GET() THEN
                        //IF (TODAY-"Date Of Birth")<(AppSetup."Minimum Age"*365) THEN ERROR('The Minimum Required Age for Admission is '+FORMAT(AppSetup."Minimum Age")+' years');

                        IF CONFIRM('Do You Want to Send This Application to The HOD', TRUE) = FALSE THEN EXIT;

                    IF Rec."Application No." = '' THEN
                        ERROR('There are no Applicants Specified.');

                    Apps.RESET;
                    Apps.SETRANGE(Apps."Application No.", Rec."Application No.");

                    IF Rec."Application Date" = 0D THEN
                        ERROR('Provide the Application Date First!');
                    // if Rec."Receipt Slip No." = '' then
                    //     error('Provide a valid receip no.');

                    /* Rec."User ID" := USERID;
                    Rec."Date of Receipt" := TODAY;
                    Rec."Documents Verified" := Rec."Documents Verified"::Yes;
                    Rec.Status := Rec.Status::"Provisional Admission";
                    Rec.MODIFY; */

                    Rec."User ID" := USERID;
                    Rec.Status := Rec.Status::"Pending Approval";
                    //Rec."Date of Receipt" := TODAY;
                    //Rec."Finance Cleared" := True;
                    //Rec."Submission Status" := Rec."Submission Status"::"FAB Submission";
                    //Rec.Status := Rec.Status::"Provisional Admission";
                    Rec.Modify();
                end;
            }
            action(sendApproval2)
            {
                Caption = 'Auto Approve';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Visible = False;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Export F/O Consolidation";
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    tableNo: Integer;
                begin
                    //Release the Application for Approval
                    //Rec.TESTFIELD("First Name");
                    Rec.TESTFIELD(Surname);
                    Rec.TestField("Admission Comments");
                    //Rec.TESTFIELD("First Degree Choice");
                    Rec.TESTFIELD("Settlement Type");
                    Rec.TESTFIELD("Intake Code");
                    Rec.TESTFIELD(Campus);
                    // Rec.TESTFIELD("Next of kin Name");
                    // Rec.TESTFIELD("Next of kin Mobile");
                    // Rec.TESTFIELD("Next of Kin R/Ship");
                    // Rec.TESTFIELD("Fee payer Names");
                    // Rec.TESTFIELD("Fee payer mobile");
                    // Rec.TESTFIELD("Fee payer R/Ship");
                    // Rec.TESTFIELD("Fee payer Email");
                    Rec.TESTFIELD("Telephone No. 1");
                    Rec.TESTFIELD(Email);
                    //Rec.TESTFIELD("First Degree Choice");
                    Rec.TESTFIELD("Programme Level");
                    //Rec.TESTFIELD("First Choice Stage");
                    Rec.TESTFIELD("Mode of Study");
                    //Rec.TESTFIELD("First Choice Semester");

                    //TESTFIELD("Application Form Receipt No.");
                    //TESTFIELD("Address for Correspondence1");
                    //TESTFIELD("Date Of Birth");
                    IF AppSetup.GET() THEN
                        //IF (TODAY-"Date Of Birth")<(AppSetup."Minimum Age"*365) THEN ERROR('The Minimum Required Age for Admission is '+FORMAT(AppSetup."Minimum Age")+' years');

                        IF CONFIRM('Do You Want to auto approve', TRUE) = FALSE THEN EXIT;

                    IF Rec."Application No." = '' THEN
                        ERROR('There are no Applicants Specified.');

                    Apps.RESET;
                    Apps.SETRANGE(Apps."Application No.", Rec."Application No.");

                    IF Rec."Application Date" = 0D THEN
                        ERROR('Provide the Application Date First!');
                    // if Rec."Receipt Slip No." = '' then
                    //     error('Provide a valid receip no.');

                    /* Rec."User ID" := USERID;
                    Rec."Date of Receipt" := TODAY;
                    Rec."Documents Verified" := Rec."Documents Verified"::Yes;
                    Rec.Status := Rec.Status::"Provisional Admission";
                    Rec.MODIFY; */

                    Rec."User ID" := USERID;
                    Rec.Status := Rec.Status::"Provisional Admission";
                    //Rec."Date of Receipt" := TODAY;
                    //Rec."Finance Cleared" := True;
                    //Rec."Submission Status" := Rec."Submission Status"::"FAB Submission";
                    //Rec.Status := Rec.Status::"Provisional Admission";
                    Rec.Modify();
                end;
            }
            action(Reject)
            {
                Caption = 'Reject Application';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Export F/O Consolidation";
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    tableNo: Integer;
                begin
                    //Release the Application for Approval
                    //Rec.TESTFIELD("First Name");
                    Rec.TESTFIELD(Surname);
                    Rec.TestField("Admission Comments");
                    //Rec.TESTFIELD("First Degree Choice");
                    Rec.TESTFIELD("Settlement Type");
                    Rec.TESTFIELD("Intake Code");
                    Rec.TESTFIELD(Campus);
                    // Rec.TESTFIELD("Next of kin Name");
                    // Rec.TESTFIELD("Next of kin Mobile");
                    // Rec.TESTFIELD("Next of Kin R/Ship");
                    // Rec.TESTFIELD("Fee payer Names");
                    // Rec.TESTFIELD("Fee payer mobile");
                    // Rec.TESTFIELD("Fee payer R/Ship");
                    // Rec.TESTFIELD("Fee payer Email");
                    Rec.TESTFIELD("Telephone No. 1");
                    Rec.TESTFIELD(Email);
                    //Rec.TESTFIELD("First Degree Choice");
                    Rec.TESTFIELD("Programme Level");
                    //Rec.TESTFIELD("First Choice Stage");
                    Rec.TESTFIELD("Mode of Study");
                    //Rec.TESTFIELD("First Choice Semester");

                    //TESTFIELD("Application Form Receipt No.");
                    //TESTFIELD("Address for Correspondence1");
                    //TESTFIELD("Date Of Birth");
                    IF AppSetup.GET() THEN
                        //IF (TODAY-"Date Of Birth")<(AppSetup."Minimum Age"*365) THEN ERROR('The Minimum Required Age for Admission is '+FORMAT(AppSetup."Minimum Age")+' years');

                        IF CONFIRM('Are You sure you want to Reject the Application?', TRUE) = FALSE THEN EXIT;

                    IF Rec."Application No." = '' THEN
                        ERROR('There are no Applicants Specified.');

                    Apps.RESET;
                    Apps.SETRANGE(Apps."Application No.", Rec."Application No.");

                    IF Rec."Application Date" = 0D THEN
                        ERROR('Provide the Application Date First!');
                    // if Rec."Receipt Slip No." = '' then
                    //     error('Provide a valid receip no.');

                    /* Rec."User ID" := USERID;
                    Rec."Date of Receipt" := TODAY;
                    Rec."Documents Verified" := Rec."Documents Verified"::Yes;
                    Rec.Status := Rec.Status::"Provisional Admission";
                    Rec.MODIFY; */

                    Rec."User ID" := USERID;
                    Rec.Status := Rec.Status::"Department Rejected";
                    //Rec."Date of Receipt" := TODAY;
                    //Rec."Finance Cleared" := True;
                    //Rec."Submission Status" := Rec."Submission Status"::"FAB Submission";
                    //Rec.Status := Rec.Status::"Provisional Admission";
                    Rec.Modify();
                end;
            }
            action(Ratify)
            {
                Caption = 'Ratify  Application';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Export F/O Consolidation";
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    tableNo: Integer;
                begin
                    //Release the Application for Approval
                    //Rec.TESTFIELD("First Name");
                    Rec.TESTFIELD(Surname);
                    //Rec.TESTFIELD("First Degree Choice");
                    Rec.TESTFIELD("Settlement Type");
                    Rec.TESTFIELD("Intake Code");
                    Rec.TESTFIELD(Campus);
                    // Rec.TESTFIELD("Next of kin Name");
                    // Rec.TESTFIELD("Next of kin Mobile");
                    // Rec.TESTFIELD("Next of Kin R/Ship");
                    // Rec.TESTFIELD("Fee payer Names");
                    // Rec.TESTFIELD("Fee payer mobile");
                    // Rec.TESTFIELD("Fee payer R/Ship");
                    // Rec.TESTFIELD("Fee payer Email");
                    Rec.TESTFIELD("Telephone No. 1");
                    Rec.TESTFIELD(Email);
                    //Rec.TESTFIELD("First Degree Choice");
                    Rec.TESTFIELD("Programme Level");
                    //Rec.TESTFIELD("First Choice Stage");
                    Rec.TESTFIELD("Mode of Study");
                    //Rec.TESTFIELD("First Choice Semester");

                    //TESTFIELD("Application Form Receipt No.");
                    //TESTFIELD("Address for Correspondence1");
                    //TESTFIELD("Date Of Birth");
                    IF AppSetup.GET() THEN
                        //IF (TODAY-"Date Of Birth")<(AppSetup."Minimum Age"*365) THEN ERROR('The Minimum Required Age for Admission is '+FORMAT(AppSetup."Minimum Age")+' years');

                        IF CONFIRM('Do you want to Ratify Application', TRUE) = FALSE THEN EXIT;

                    IF Rec."Application No." = '' THEN
                        ERROR('There are no Applicants Specified.');

                    Apps.RESET;
                    Apps.SETRANGE(Apps."Application No.", Rec."Application No.");

                    IF Rec."Application Date" = 0D THEN
                        ERROR('Provide the Application Date First!');
                    // if Rec."Receipt Slip No." = '' then
                    //     error('Provide a valid receip no.');

                    /* Rec."User ID" := USERID;
                    Rec."Date of Receipt" := TODAY;
                    Rec."Documents Verified" := Rec."Documents Verified"::Yes;
                    Rec.Status := Rec.Status::"Provisional Admission";
                    Rec.MODIFY; */

                    Rec."User ID" := USERID;
                    Rec.Status := Rec.Status::"Provisional Admission";
                    //Rec."Date of Receipt" := TODAY;
                    //Rec."Finance Cleared" := True;
                    //Rec."Submission Status" := Rec."Submission Status"::"FAB Submission";
                    //Rec.Status := Rec.Status::"Provisional Admission";
                    Rec.Modify();
                end;
            }
            action(cancellsApproval)
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Export F/O Consolidation";
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    tableNo: Integer;
                begin
                    DocType := DocType::"Student Applications";
                    showmessage := TRUE;
                    ManualCancel := TRUE;
                    CLEAR(tableNo);
                    tableNo := DATABASE::"ACA-Applic. Form Header";
                    //IF ApprovalMgt.CancelApproval(tableNo, DocType, "Application No.", showmessage, ManualCancel) THEN;
                end;
            }
        }

    }


    trigger OnInit()
    begin
        "Points AcquiredVisible" := TRUE;
        "Mean Grade AcquiredVisible" := TRUE;
        "Subsidiary PassesVisible" := TRUE;
        "Principal PassesVisible" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Settlement Type" := 'SSP';
    end;

    local procedure SendFeedback()
    var
        salutation: Text[50];
        FileMgt: Codeunit "File Management";
        hrEmp: Record "HRM-Employee C";
        progName: Record "ACA-Programme";
        progLeader: text;
        mail: Text;
        EmailSubject: Text[50];
        EmailBody: Text[700];
        EmailRecipient: Text[200];
    begin
        Clear(EmailBody);
        Clear(EmailSubject);
        Clear(mail);
        mail := Rec.Email;
        EmailBody := 'Hello,' + ' ' + Rec.firstName + ' ' + Rec."Student Feedback" + ' This Is a system Generated Email. DO NOT REPLY!';
        EmailSubject := 'APPLICATION REQUIRES YOUR ATTENTION';
        SendMail.Create(mail, EmailSubject, EmailBody);
        emailObj.Send(SendMail, Enum::"Email Scenario"::Notification);
    end;

    var
        DMS: Record "EDMS Setups";
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
        Text19076066: Label 'Personal Details';
        Text19060472: Label 'Degree Choices';
        Text19037194: Label 'Academic Background';
        //UserMgt: Codeunit 50114;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,Admission;

        AppSetup: Record "ACA-Applic. Setup";
        //AdmissionsQualif: Codeunit "50140";
        EnqH: Record "ACA-Enquiry Header";
        SendMail: Codeunit "Email Message";
        emailObj: Codeunit Email;

    /// <summary>
    /// GetDegree.
    /// </summary>
    /// <param name="DegreeCode">VAR Code[20].</param>
    /// <returns>Return variable DegreeName of type Text[200].</returns>
    ///
    ///
    // procedure GetDegree(var DegreeCode: Code[20]) DegreeName: Text[200]
    // var
    //     Programme: Record "ACA-Programme";
    // begin
    //     /*This function gets the programme name and returns the resultant string*/
    //     Programme.RESET;
    //     IF Programme.GET(DegreeCode) THEN BEGIN
    //         DegreeName := Programme.Description;
    //     END
    //     ELSE BEGIN
    //         DegreeName := '';
    //     END;

    // end;

    /// <summary>
    /// GetFaculty.
    /// </summary>
    /// <param name="DegreeCode">VAR Code[20].</param>
    /// <returns>Return variable FacultyName of type Text[200].</returns>
#pragma warning disable AL0523
    procedure GetFaculty(var DegreeCode: Code[20]) FacultyName: Text[200]
#pragma warning restore AL0523
    var
        Programme: Record "ACA-PROGRAMME";
        DimVal: Record "Dimension Value";
    begin
        /*The function gets and returns the faculty name to the calling client*/
        FacultyName := '';
        Programme.RESET;
        IF Programme.GET(DegreeCode) THEN BEGIN
            DimVal.RESET;
            DimVal.SETRANGE(DimVal."Dimension Code", 'COURSE');
            DimVal.SETRANGE(DimVal.Code, Programme."School Code");
            IF DimVal.FIND('-') THEN BEGIN
                FacultyName := DimVal.Name;
            END;
        END;

    end;

#pragma warning disable AL0523
    procedure GetAge(var StartDate: Date) AgeText: Text[200]
#pragma warning restore AL0523
    var
        HrDates: Codeunit "ACA-Dates";
    begin
        /*This function gets the age of the applicant and returns the resultant age to the calling client*/
        AgeText := '';
        IF StartDate = 0D THEN BEGIN StartDate := TODAY END;
        AgeText := HrDates.DetermineAge(StartDate, TODAY);

    end;

    /// <summary>
    /// getFormerSchool.
    /// </summary>
    /// <param name="FormerSchoolCode">VAR Code[20].</param>
    /// <returns>Return variable FormerSchoolName of type Text[200].</returns>
#pragma warning disable AL0523
    procedure getFormerSchool(var FormerSchoolCode: Code[20]) FormerSchoolName: Text[200]
#pragma warning restore AL0523
    var
        FormerSchool: Record "ACA-Applic. Setup Fmr School";
    begin
        /*This function gets the description of the former school and returns the result to the calling client*/
        FormerSchool.RESET;
        FormerSchoolName := '';
        IF FormerSchool.GET(FormerSchoolCode) THEN BEGIN
            FormerSchoolName := FormerSchool.Description;
        END;

    end;

    procedure GetStageName(var StageCode: Code[20]) StageName: Text[200]
    var
        Stage: Record "ACA-Programme Stages";
    begin
        Stage.RESET;
        Stage.SETRANGE(Stage.Code, StageCode);
        IF Stage.FIND('-') THEN BEGIN
            StageName := Stage.Description;
        END;
    end;

    procedure GetSemesterName(var SemesterCode: Code[20]) SemesterName: Text[200]
    var
        Semester: Record "ACA-Semesters";
    begin
        Semester.RESET;
        Semester.SETRANGE(Semester.Code, SemesterCode);
        IF Semester.FIND('-') THEN BEGIN
            SemesterName := Semester.Description;
        END;
    end;

    procedure GetCounty(var CountyCode: Code[20]) CountyName: Text[100]
    var
        CountySetup: Record "ACA-Academics Central Setups";
    begin
        /*This function gets the county name from the database and returns the resultant string value*/
        CountySetup.RESET;
        CountySetup.SETRANGE(CountySetup."Title Code", CountyCode);
        CountySetup.SETRANGE(CountySetup.Category, CountySetup.Category::Countries);
        IF CountySetup.FIND('-') THEN BEGIN
            CountyName := CountySetup.Description;
        END
        ELSE BEGIN
            CountyName := '';
        END;

    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        Age := Rec.GetAge(Rec."Date Of Birth");
        NationalityName := Rec.GetCountry(Rec.Nationality);
        CountryOfOriginName := Rec.GetCountry(Rec."Country of Origin");
        //DegreeName1:=GetDegree("First Degree Choice");
        //DegreeName2:=GetDegree("Second Degree Choice");
        FacultyName1 := Rec.GetFaculty(Rec."First Degree Choice");
        FacultyName2 := Rec.GetFaculty(Rec."Second Degree Choice");
        FormerSchoolName := Rec.GetFormerSchool(Rec."Former School Code");
        IF (Rec.Examination = Rec.Examination::KCSE) OR (Rec.Examination = Rec.Examination::KCE) OR (Rec.Examination = Rec.Examination::EACE) THEN BEGIN
            "Principal PassesVisible" := FALSE;
            "Subsidiary PassesVisible" := FALSE;
            "Mean Grade AcquiredVisible" := TRUE;
            "Points AcquiredVisible" := TRUE;
        END
        ELSE BEGIN
            "Principal PassesVisible" := TRUE;
            "Subsidiary PassesVisible" := TRUE;
            "Mean Grade AcquiredVisible" := FALSE;
            "Points AcquiredVisible" := FALSE;
        END;
    end;

    procedure Testfields()
    begin
        //
        Rec.TESTFIELD("Application Date");
        Rec.TESTFIELD("Date Of Receipt Slip");
        Rec.TESTFIELD("Intake Code");
        Rec.TESTFIELD("Knew College Thru");
        Rec.TESTFIELD("Issued Date");
        Rec.TESTFIELD("Settlement Type");
        Rec.TESTFIELD("Academic Year");
        Rec.TESTFIELD("Programme Level");
        Rec.TESTFIELD("Address for Correspondence1");
        Rec.TESTFIELD("First Degree Choice");
        Rec.TESTFIELD("First Choice Stage");
        Rec.TESTFIELD("First Choice Semester");
        //Personal Details
        Rec.TESTFIELD(Surname);
        Rec.TESTFIELD("Other Names");
        Rec.TESTFIELD("Date Of Birth");
        //TESTFIELD(Gender);
        Rec.TESTFIELD(Nationality);
        //TESTFIELD(Salutation);
        Rec.TESTFIELD("ID Number");
        //TESTFIELD("Marital Status");
    end;

    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;
}

