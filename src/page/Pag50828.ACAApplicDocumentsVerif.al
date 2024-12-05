page 50828 "ACA-Applic. Documents Verif."
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "ACA-Applic. Form Header";
    // SourceTableView = WHERE(Status = FILTER("Provisional Admission"),
    //                        "Documents Verified" = FILTER(false));

    layout
    {
        area(content)
        {
            group("General Information")
            {
                Editable = true;
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

                field("Admission No"; Rec."Admission No")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Application Form Receipt No."; Rec."Application Form Receipt No.")
                {
                    Caption = 'Receipt No.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Check if the receipt number is valid or not
                        EXIT;
                        CustEntry.RESET;
                        //CustEntry.SETRANGE(CustEntry."Source Code",'CASHRECJNL');
                        CustEntry.SETRANGE(CustEntry."Document No.", Rec."Application Form Receipt No.");
                        IF CustEntry.FIND('-') THEN //record has been located in the database
                          BEGIN
                            /*Check if the receipt number has been used by another student*/
                            Apps.RESET;
                            Apps.SETRANGE(Apps."Application Form Receipt No.", Rec."Application Form Receipt No.");
                            IF Apps.FIND('-') THEN BEGIN
                                REPEAT
                                    IF Apps."Application No." <> Rec."Application No." THEN BEGIN
                                        ERROR('Receipt Number already utilised within the System by Application No.' + FORMAT(Apps."Application No."));
                                    END;
                                UNTIL Apps.NEXT = 0;
                            END;
                        END
                        ELSE//record not located within the database
                          BEGIN
                            ERROR('Receipt Number not located within Valid Receipts');
                        END;

                    end;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                }
                field("Intake Code"; Rec."Intake Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Mode of Study"; Rec."Mode of Study")
                {
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                // field("Marital Status"; Rec."Marital Status")
                // {
                //     ApplicationArea = All;
                // }
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
                field(NationalityName; NationalityName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Get the name of the country of nationality*/
                        CountryOfOriginName := GetCounty(Rec.County);

                    end;
                }
                field(CountryOfOriginName; CountryOfOriginName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
                field("Passport Photo"; Rec."Passport Photo")
                {
                    ApplicationArea = All;
                }
            }
            group("Student Feedback")
            {
                field("Student Feedbacks"; Rec."Student Feedback")
                {
                    Caption = 'Feedback for Student';
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
            group("Documents Verification")
            {
                Caption = 'Documents Verification';
                field("Documents Verification Remarks"; Rec."Documents Verification Remarks")
                {
                    ApplicationArea = All;
                }
                field("Medical Verified"; Rec."Medical Verified")
                {
                    ApplicationArea = All;
                }
            }
            group("Correspondence Address")
            {
                Editable = true;
                field("Address for Correspondence1"; Rec."Address for Correspondence1")
                {
                    Caption = 'Address 1';
                    ApplicationArea = All;
                }
                field("Address for Correspondence2"; Rec."Address for Correspondence2")
                {
                    Caption = 'Address 2';
                    ApplicationArea = All;
                }
                field("Address for Correspondence3"; Rec."Address for Correspondence3")
                {
                    Caption = 'Address 3';
                    ApplicationArea = All;
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    ApplicationArea = All;
                }
                field("Telephone No. 2"; Rec."Telephone No. 2")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
            }
            group("Program Details")
            {
                Editable = true;
                field("First Degree Choice"; Rec."First Degree Choice")
                {
                    ApplicationArea = All;
                    Caption = 'Program';

                    trigger OnValidate()
                    begin
                        /*Display the name of the programme*/
                        //DegreeName1:=GetDegree("First Degree Choice");
                        recProgramme.RESET;
                        IF recProgramme.GET(Rec."First Degree Choice") THEN BEGIN
                            DegreeName1 := recProgramme.Description;
                            Rec.School1 := recProgramme."School Code";
                            FacultyName1 := Rec.GetFaculty(Rec."First Degree Choice");
                        END;

                    end;
                }
                field("First Choice Stage"; Rec."First Choice Stage")
                {
                    ApplicationArea = All;
                    Caption = 'Stage';

                    trigger OnValidate()
                    begin
                        FirstChoiceStageName := GetStageName(Rec."First Choice Stage");
                    end;
                }
                field("First Choice Semester"; Rec."First Choice Semester")
                {
                    ApplicationArea = All;
                    Caption = 'Semester';

                    trigger OnValidate()
                    begin
                        FirstChoiceSemesterName := GetSemesterName(Rec."First Choice Semester");
                    end;
                }
            }
            group(Qualifications)
            {
                Editable = true;
                field("Former School Code"; Rec."Former School Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*Display the name of the former school*/
                        FormerSchoolName := Rec.GetFormerSchool(Rec."Former School Code");

                    end;
                }
                field(FormerSchoolName; FormerSchoolName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date of Admission"; Rec."Date of Admission")
                {
                    ApplicationArea = All;
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                    ApplicationArea = All;
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
                field("Index Number"; Rec."Index Number")
                {
                    ApplicationArea = All;
                }
                field("Mean Grade Acquired"; Rec."Mean Grade Acquired")
                {
                    Visible = "Mean Grade AcquiredVisible";
                    ApplicationArea = All;
                }
                field("Principal Passes"; Rec."Principal Passes")
                {
                    Visible = "Principal PassesVisible";
                    ApplicationArea = All;
                }
                field("Subsidiary Passes"; Rec."Subsidiary Passes")
                {
                    Visible = "Subsidiary PassesVisible";
                    ApplicationArea = All;
                }
                field("Points Acquired"; Rec."Points Acquired")
                {
                    Visible = "Points AcquiredVisible";
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Documents)
            {
                Caption = 'Documents';
                // action("Academic Background Subjects")
                // {
                //     Caption = 'Academic Background Subjects';
                //     Image = History;
                //     Promoted = true;
                //     RunObject = Page "ACA-Application Form Academic";
                //     RunPageLink = "Application No." = FIELD("Application No.");
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // action("Professional Qualifications")
                // {
                //     Caption = 'Professional Qualifications';
                //     Image = ProfileCalender;
                //     Promoted = true;
                //     RunObject = Page "ACA-Application Form Qualif.";
                //     RunPageLink = "Application No." = FIELD("Application No.");
                //     ApplicationArea = All;
                // }
                // // action("Employment History")
                // // {
                // //     Caption = 'Employment History';
                //     Image = Employee;
                //     Promoted = true;
                //     RunObject = Page 68469;
                //     RunPageLink = "Application No." = FIELD("Application No.");
                //     ApplicationArea = All;
                // }
                // action("Academic Referees")
                // {
                //     Caption = 'Academic Referees';
                //     Image = CustomerContact;
                //     Promoted = true;
                //     RunObject = Page 68468;
                //     RunPageLink = "Application No." = FIELD("Application No.");
                //     ApplicationArea = All;
                // }
            }
        }
        area(processing)
        {
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
            
            action(GenerateAdmissionNo)
            {
                Caption = 'Generate Admn. No.';
                Image = PostApplication;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF (Rec."Admission No" <> '') THEN ERROR('Admission Number axists: ' + Rec."Admission No");
                    CLEAR(settlementPrefix);
                    degCode := '';
                    IF Rec."Admitted Degree" = '' THEN BEGIN
                        IF Rec."First Degree Choice" <> '' THEN BEGIN
                            Rec."Admitted Degree" := Rec."First Degree Choice";
                            Rec.MODIFY;
                        END;
                    END;
                    AdminSetup.RESET;
                    AdminSetup.SETRANGE(AdminSetup.Degree, Rec."Admitted Degree");
                    IF AdminSetup.FIND('-') THEN BEGIN
                        IF ((Rec."Settlement Type" = 'KUCCPS') OR (Rec."Settlement Type" = 'GOK') OR (Rec."Settlement Type" = 'GSS')) THEN
                            settlementPrefix := AdminSetup."JAB Prefix"
                        ELSE
                            IF ((Rec."Settlement Type" = 'PSSP') OR (Rec."Settlement Type" = 'SSS') OR (Rec."Settlement Type" = 'SELFSPONSORED')) THEN
                                settlementPrefix := AdminSetup."SSP Prefix";
                        CLEAR(NewAdminCode);
                        BEGIN
                            NewAdminCode := NoSeriesMgt.GetNextNo(AdminSetup."No. Series", TODAY, TRUE);
                            Rec."Admission No" := AdminSetup."Programme Prefix" + settlementPrefix + '/' + NewAdminCode + '/' + AdminSetup.Year;
                            Rec.MODIFY;
                        END;
                    END ELSE BEGIN
                        ERROR('The Admission Number Setup For Programme ' + FORMAT(Rec."Admitted Degree") + ' Does Not Exist');
                    END;
                    MESSAGE('Admission number generated successfully!');
                end;
            }
            action("Admission Letter")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    admletter: Record "ACA-Applic. Form Header";
                begin
                    if Rec."Settlement Type" = 'PSSP' then begin
                        admletter.Reset();
                        admletter.SetRange("Application No.", Rec."Application No.");
                        Report.Run(Report::"SSS Admission Letter", true, true, admletter);
                    end else
                        if Rec."Settlement Type" = 'KUCCPS' then begin
                            admletter.Reset();
                            admletter.SetRange("Application No.", Rec."Application No.");
                            Report.Run(Report::"ADM Admission Letter", true, true, admletter);
                        end;
                end;

            }
            action(Admit)
            {
                Caption = 'Admit Student';
                Image = PostApplication;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*Send the current record to the department approval stage*/
                    IF CONFIRM('Mark as Documents Verified?', TRUE) = FALSE THEN BEGIN EXIT END;
                    IF Rec."Admission No" = '' THEN ERROR('Admission Number missiong!');
                    Rec.TESTFIELD("Documents Verification Remarks");
                    //TESTFIELD("Receipt Slip No.");
                    Rec.TESTFIELD(County);
                    Rec.TESTFIELD("ID Number");
                    Rec.TESTFIELD("Date Of Birth");


                    Rec.Admitted := true;
                    Rec.Status := Rec.Status::Admitted;
                    Rec.VALIDATE(Status);
                    Rec."Documents Verified" := TRUE;
                    Rec."Payments Verified" := TRUE;
                    Rec.MODIFY;


                    TransferToAdmission(Rec."Admission No");
                    Rec.Admitted := true;
                    Rec.Status := Rec.Status::Admitted;
                    Rec.VALIDATE(Status);
                    Rec."Documents Verified" := TRUE;
                    Rec."Payments Verified" := TRUE;
                    Rec.MODIFY;
                    MESSAGE('The Application has been Processed');

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

    var
        degCode: Code[20];
        AdminSetup: Record "ACA-Adm. Number Setup";
        NewAdminCode: Code[20];
        settlementPrefix: Code[10];
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
        //UserMgt: Codeunit 50114;
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
        Text19058780: Label 'Acceptance of Offer/Non-Acceptance of Offer';
        Text19071252: Label 'Ever suffered or had symptoms of the following';
        Text19025049: Label 'Reasons for Non-Acceptance of Offer';
        Text19049741: Label 'Medical details not covered by above';
        Text19069419: Label 'Last School Attended and Address of School';
        Text19015920: Label 'Family member ever suffered from';
        Text19012476: Label 'Immunizations received';
        Text19059485: Label 'Declaration Form In The Presence Of Parent/Guardian';
        Text19079474: Label 'Part II (Completed by a medical practioner)';
        SendMail: Codeunit "Email Message";
        emailObj: Codeunit Email;



    /// <summary>
    /// GetDegree1.
    /// </summary>
    /// <param name="DegreeCode">VAR Code[20].</param>
    /// <returns>Return variable DegreeName of type Text[100].</returns>
    procedure GetDegree1(var DegreeCode: Code[20]) DegreeName: Text[100]
    var
        Programme: Record "ACA-Programme";
    begin
        /*This function gets the programme name and returns the resultant string*/
        Programme.RESET;
        IF Programme.GET(DegreeCode) THEN BEGIN
            DegreeName := Programme.Description;
        END
        ELSE BEGIN
            DegreeName := '';
        END;

    end;


    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        Age := Rec.GetAge(Rec."Date Of Birth");
        NationalityName := Rec.GetCountry(Rec.Nationality);
        CountryOfOriginName := Rec.GetCountry(Rec."Country of Origin");
        DegreeName1 := GetDegree1(Rec."First Degree Choice");
        DegreeName2 := GetDegree1(Rec."Second Degree Choice");
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
        CountySetup: Record "ACA-Applic. Setup County";
    begin
        /*This function gets the county name from the database and returns the resultant string value*/
        CountySetup.RESET;
        IF CountySetup.GET(CountyCode) THEN BEGIN
            CountyName := CountySetup.Description;
        END
        ELSE BEGIN
            CountyName := '';
        END;

    end;

    procedure TakeStudentToRegistration(var AdmissNo: Code[20])
    begin
        Admissions.RESET;
        Admissions.SETRANGE("Admission No.", AdmissNo);
        IF Admissions.FIND('-') THEN BEGIN
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
          Cust."ID No":=Rec."ID Number";
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
            AdminKin.RESET;
            AdminKin.SETRANGE(AdminKin."Admission No.", Admissions."Admission No.");
            IF AdminKin.FIND('-') THEN BEGIN
                REPEAT
                    StudentKin.RESET;
                    StudentKin.INIT;
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
                    StudentKin.INSERT;
                UNTIL AdminKin.NEXT = 0;
            END;

            //insert the details in relation to the guardian/sponsor into the database in relation to the current student
            IF Admissions."Mother Alive Or Dead" = Admissions."Mother Alive Or Dead"::Alive THEN BEGIN
                IF Admissions."Mother Full Name" <> '' THEN BEGIN
                    StudentGuardian.RESET;
                    StudentGuardian.INIT;
                    StudentGuardian."Student No." := Admissions."Admission No.";
                    StudentGuardian.Names := Admissions."Mother Full Name";
                    StudentGuardian.INSERT;
                END;
            END;
            IF Admissions."Father Alive Or Dead" = Admissions."Father Alive Or Dead"::Alive THEN BEGIN
                IF Admissions."Father Full Name" <> '' THEN BEGIN
                    StudentGuardian.RESET;
                    StudentGuardian.INIT;
                    StudentGuardian."Student No." := Admissions."Admission No.";
                    StudentGuardian.Names := Admissions."Father Full Name";
                    StudentGuardian.INSERT;
                END;
            END;
            IF Admissions."Guardian Full Name" <> '' THEN BEGIN
                IF Admissions."Guardian Full Name" <> '' THEN BEGIN
                    StudentGuardian.RESET;
                    StudentGuardian.INIT;
                    StudentGuardian."Student No." := Admissions."Admission No.";
                    StudentGuardian.Names := Admissions."Guardian Full Name";
                    StudentGuardian.INSERT;
                END;
            END;

            /*

                    //insert the details in relation to the student history as detailed in the application
                        EnrollmentEducationHistory.RESET;
                        EnrollmentEducationHistory.SETRANGE(EnrollmentEducationHistory."Enquiry No.",Enrollment."Enquiry No.");
                        IF EnrollmentEducationHistory.FIND('-') THEN
                            BEGIN
                                REPEAT
                                    EducationHistory.RESET;
                                    EducationHistory.INIT;
                                        EducationHistory."Student No.":=Rec."No.";
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
                        Enrollment."Registration No":=Rec."No.";
                        Enrollment.Status:=Enrollment.Status::Admitted;
                        Enrollment.MODIFY;

             */
        END;

    end;

    procedure GetSchoolName(var SchoolCode: Code[20]; var SchoolName: Text[30])
    var
        FormerSchool: Record "ACA-Applic. Setup Fmr School";
    begin
        /*Get the former school name and display the results*/
        FormerSchool.RESET;
        SchoolName := '';
        IF FormerSchool.GET(SchoolCode) THEN BEGIN
            SchoolName := FormerSchool.Description;
        END;

    end;

    procedure GetDegreeName(var DegreeCode: Code[20]; var DegreeName: Text[200])
    var
        Programme: Record "ACA-Programme";
    begin
        /*get the degree name and display the results*/
        Programme.RESET;
        DegreeName := '';
        IF Programme.GET(DegreeCode) THEN BEGIN
            DegreeName := Programme.Description;
        END;

    end;

    procedure GetFacultyName(var DegreeCode: Code[20]; var FacultyName: Text[30])
    var
        Programme: Record "ACA-Programme";
        DimVal: Record "Dimension Value";
    begin
        /*Get the faculty name and return the result*/
        Programme.RESET;
        FacultyName := '';

        IF Programme.GET(DegreeCode) THEN BEGIN
            DimVal.RESET;
            DimVal.SETRANGE(DimVal."Dimension Code", 'FACULTY');
            DimVal.SETRANGE(DimVal.Code, Programme.Faculty);
            IF DimVal.FIND('-') THEN BEGIN
                FacultyName := DimVal.Name;
            END;
        END;

    end;

    local procedure Send()
    var
        salutation: Text[50];
        FileMgt: Codeunit "File Management";
        hrEmp: Record "HRM-Employee C";
        progName: Record "ACA-Programme";
        progLeader: text;
        mail: Text;
        EmailSubject: Text[50];
        EmailBody: Text[250];
        EmailRecipient: Text[200];
    begin

        Clear(EmailBody);
        Clear(EmailSubject);
        Clear(mail);

        progName.Reset();
        progName.SetRange(Code, Rec."First Degree Choice");
        if progName.Find('-') then begin
            progLeader := progName."Program Leader";
            hrEmp.Reset();
            hrEmp.SetRange("No.", progLeader);
            if hrEmp.Find('-') then begin
                if hrEmp.Find('-') then begin
                    Error('HOD Must have E-mail')
                end else begin
                    mail := hrEmp."Company E-Mail";
                    EmailBody := 'Hello,' + ' ' + hrEmp."First Name" + ' ' + 'Kindly Log into your staff portal and check Application No.' + ' ' + Rec."Application No." + ' ' + 'that requires your Approval.' + 'This Is a system Generated Email. DO NOT REPLY!!';
                    EmailSubject := 'ADMISSIONS APPROVAL ALERT';
                    SendMail.Create(mail, EmailSubject, EmailBody);
                    emailObj.Send(SendMail, Enum::"Email Scenario"::Notification);
                end;

            end;
        end;
    end;

    


    procedure GetReligionName(var ReligionCode: Code[20]; var ReligionName: Text[30])
    var
        Religion: Record "ACA-Academics Central Setups";
    begin
        /*Get the religion name and display the result*/
        Religion.RESET;
        Religion.SETRANGE(Religion."Title Code", ReligionCode);
        Religion.SETRANGE(Religion.Category, Religion.Category::Religions);

        ReligionName := '';
        IF Religion.FIND('-') THEN BEGIN
            ReligionName := Religion.Description;
        END;

    end;


    procedure TransferToAdmission(var AdmissionNumber: Code[20])
    var
        AdminSetup: Record "ACA-Adm. Number Setup";
        NewAdminCode: Code[20];
    begin
        /*This function transfers the fieldsin the application to the fields in the admissions table*/
        /*Get the new admission code for the selected application*/
        Rec.TESTFIELD("Settlement Type");
        SettlmentType.GET(Rec."Settlement Type");
        IF AdmissionNumber = '' THEN BEGIN
            AdminSetup.RESET;
            AdminSetup.SETRANGE(AdminSetup.Degree, Rec."Admitted Degree");
            IF AdminSetup.FIND('-') THEN BEGIN
                NewAdminCode := NoSeriesMgt.GetNextNo(AdminSetup."No. Series", 0D, TRUE);
                NewAdminCode := AdminSetup."Programme Prefix" + '/' + NewAdminCode + '/' + AdminSetup.Year;

                //If Prefix is Needed add this code <<+ AdminSetup."SSP Prefix" >>
            END
            ELSE BEGIN
                ERROR('The Admission Number Setup For Programme ' + FORMAT(Rec."Admitted Degree") + ' Does Not Exist');
            END;
        END ELSE
            NewAdminCode := AdmissionNumber;
        Cust.INIT;
        Cust."No." := Rec."Admission No";
        Rec.CalcFields("Passport Photo");
        Cust."Barcode Picture" := Rec."Passport Photo";
        Cust.Name := COPYSTR(Rec.firstName + ' ' + Rec."Other Names" + ' ' + Rec.Surname, 1, 80);
        Cust."Search Name" := UPPERCASE(COPYSTR(Rec.firstName + ' ' + Rec."Other Names" + Rec.Surname, 1, 80));
        Cust.Address := Rec."Address for Correspondence1";
        IF Rec."Address for Correspondence3" <> '' THEN
            Cust."Address 2" := COPYSTR(Rec."Address for Correspondence2" + ',' + Rec."Address for Correspondence3", 1, 30);
        IF Rec."Telephone No. 2" <> '' THEN
            Cust."Phone No." := Rec."Telephone No. 1" + ',' + Rec."Telephone No. 2";
        //  Cust."Telex No.":=Rec."Fax No.";
        Cust."E-Mail" := Rec."Student E-mail";
        Cust.Gender := Rec.Gender;
        Cust."Date Of Birth" := Rec."Date Of Birth";
        Cust."Date Registered" := TODAY;
        Cust."Customer Type" := Cust."Customer Type"::Student;
        //        Cust."Student Type":=FORMAT(Enrollment."Student Type");
        Cust."Date Of Birth" := Rec."Date Of Birth";
        // Cust."ID No":=Rec."ID Number";
        Cust."Application No." := Rec."Admission No";
        Cust."Marital Status" := Rec."Marital Status";
        Cust.Citizenship := FORMAT(Rec.Nationality);
        Cust."Current Programme" := Rec."Admitted Degree";
        Cust."Current Semester" := Rec."First Choice Semester";
        Cust."Current Stage" := Rec."Admitted To Stage";
        // Cust.Religion:=FORMAT(Rec.Religion);
        Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
        Cust."Customer Posting Group" := 'STUDENT';
        Cust.VALIDATE(Cust."Customer Posting Group");
        Cust."ID No" := Rec."ID Number";
        Cust."Global Dimension 1 Code" := Rec.Campus;
        Cust.County := Rec.County;
        Cust.INSERT();

        ////////////////////////////////////////////////////////////////////////////////////////


        Cust.RESET;
        Cust.SETRANGE("No.", Rec."Admission No");
        //Customer.SETFILTER("Date Registered",'=%1',TODAY);
        IF Cust.FIND('-') THEN BEGIN
            IF Rec.Gender = Rec.Gender::Female THEN BEGIN
                Cust.Gender := Cust.Gender::Female;
            END ELSE BEGIN
                Cust.Gender := Cust.Gender::Male;
            END;
            Cust.MODIFY;
        END;

        Cust.RESET;
        Cust.SETRANGE("No.", Rec."Admission No");
        Cust.SETFILTER("Date Registered", '=%1', TODAY);
        IF Cust.FIND('-') THEN BEGIN
            CourseRegistration.RESET;
            CourseRegistration.SETRANGE("Student No.", Rec."Admission No");
            CourseRegistration.SETRANGE("Settlement Type", Rec."Settlement Type");
            CourseRegistration.SETRANGE(Programmes, Rec."First Degree Choice");
            CourseRegistration.SETRANGE(Semester, Rec."Admitted Semester");
            IF NOT CourseRegistration.FIND('-') THEN BEGIN
                CourseRegistration.INIT;
                CourseRegistration."Reg. Transacton ID" := '';
                CourseRegistration.VALIDATE(CourseRegistration."Reg. Transacton ID");
                CourseRegistration."Student No." := Rec."Admission No";
                CourseRegistration.Programmes := Rec."First Degree Choice";
                CourseRegistration.Semester := Rec."First Choice Semester";
                CourseRegistration.Stage := Rec."First Choice Stage";
                CourseRegistration."Student Type" := CourseRegistration."Student Type"::"Full Time";
                CourseRegistration."Registration Date" := TODAY;
                CourseRegistration."Settlement Type" := Rec."Settlement Type";
                CourseRegistration."Academic Year" := Rec.GetCurrYear();
                CourseRegistration."Year Of Study" := 1;

                //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                CourseRegistration.INSERT;
                CourseRegistration.RESET;
                CourseRegistration.SETRANGE("Student No.", Rec."Admission No");
                CourseRegistration.SETRANGE("Settlement Type", Rec."Settlement Type");
                CourseRegistration.SETRANGE(Programmes, Rec."First Degree Choice");
                CourseRegistration.SETRANGE(Semester, Rec."Admitted Semester");
                IF CourseRegistration.FIND('-') THEN BEGIN
                    CourseRegistration."Settlement Type" := Rec."Settlement Type";
                    CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                    CourseRegistration."Academic Year" := Rec.GetCurrYear();
                    CourseRegistration."Registration Date" := TODAY;
                    CourseRegistration.VALIDATE(CourseRegistration."Registration Date");
                    CourseRegistration.MODIFY;

                END;
            END ELSE BEGIN
                CourseRegistration.RESET;
                CourseRegistration.SETRANGE("Student No.", Rec."Admission No");
                CourseRegistration.SETRANGE("Settlement Type", Rec."Settlement Type");
                CourseRegistration.SETRANGE(Programmes, Rec."First Degree Choice");
                CourseRegistration.SETRANGE(Semester, Rec."Admitted Semester");
                CourseRegistration.SETFILTER(Posted, '=%1', FALSE);
                IF CourseRegistration.FIND('-') THEN BEGIN
                    CourseRegistration."Settlement Type" := Rec."Settlement Type";
                    CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                    CourseRegistration."Academic Year" := Rec.GetCurrYear();
                    CourseRegistration."Registration Date" := TODAY;
                    CourseRegistration.VALIDATE(CourseRegistration."Registration Date");
                    CourseRegistration.MODIFY;

                END;
            END;
        END;
        /*
                //insert the course registration details
                    CourseRegistration.RESET;
                    CourseRegistration.INIT;
                       CourseRegistration."Reg. Transacton ID":='';
                       CourseRegistration.VALIDATE(CourseRegistration."Reg. Transacton ID");
                       CourseRegistration."Student No.":=Rec."Admission No";
                       CourseRegistration.Programme:=Rec."Admitted Degree";
                       CourseRegistration.Semester:=Rec."First Choice Semester";
                       CourseRegistration.Stage:=Rec."Admitted To Stage";
                       CourseRegistration."Student Type":=CourseRegistration."Student Type"::"Full Time";
                       CourseRegistration."Registration Date":=TODAY;
                       CourseRegistration."Settlement Type":=Rec."Settlement Type";
                       CourseRegistration."Academic Year":=GetCurrYear();
        
                       //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                    CourseRegistration.INSERT;
        
                    CourseRegistration.RESET;
                    CourseRegistration.SETRANGE(CourseRegistration."Student No.",Admissions."Admission No.");
                    IF CourseRegistration.FIND('+') THEN BEGIN
                    CourseRegistration."Settlement Type":=Rec."Settlement Type";
                    CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                    CourseRegistration."Academic Year":=GetCurrYear();
                    CourseRegistration."Registration Date":=TODAY;
                    CourseRegistration.VALIDATE(CourseRegistration."Registration Date");
                    CourseRegistration.MODIFY;
        
                    END;*/
        ////////////////////////////////////////////////////////////////////////////////////////

        /*Get the record and transfer the details to the admissions database*/
        //ERROR('TEST- '+NewAdminCode);
        /*Transfer the details into the admission database table*/
        Rec.INIT;
        Admissions."Admission No." := NewAdminCode;
        Admissions.VALIDATE("Admission No.");
        Admissions.Date := TODAY;
        Admissions."Application No." := Rec."Application No.";
        Admissions."Admission Type" := Rec."Settlement Type";
        Admissions."Academic Year" := Rec."Academic Year";
        Admissions.Surname := Rec.Surname;
        Admissions."Other Names" := Rec."Other Names";
        Admissions.Status := Admissions.Status::Admitted;
        Admissions."Degree Admitted To" := Rec."Admitted Degree";
        Admissions.VALIDATE("Degree Admitted To");
        Admissions."Date Of Birth" := Rec."Date Of Birth";
        Admissions.Gender := Rec.Gender + 1;
        Admissions."Marital Status" := Rec."Marital Status";
        Admissions.County := Rec.County;
        Admissions.Campus := Rec.Campus;
        Admissions.Nationality := Rec.Nationality;
        Admissions."Correspondence Address 1" := Rec."Address for Correspondence1";
        Admissions."Correspondence Address 2" := Rec."Address for Correspondence2";
        Admissions."Correspondence Address 3" := Rec."Address for Correspondence3";
        Admissions."Telephone No. 1" := Rec."Telephone No. 1";
        Admissions."Telephone No. 2" := Rec."Telephone No. 2";
        Admissions."Former School Code" := Rec."Former School Code";
        Admissions."Index Number" := Rec."Index Number";
        Admissions."Stage Admitted To" := Rec."Admitted To Stage";
        Admissions."Semester Admitted To" := Rec."First Choice Semester";
        Admissions."Settlement Type" := Rec."Settlement Type";
        Admissions."Intake Code" := Rec."Intake Code";
        Admissions."ID Number" := Rec."ID Number";
        Admissions."E-Mail" := Rec.Email;
        // Admissions."Telephone No. 1":=Rec."Telephone No. 1";
        // Admissions."Telephone No. 2":=Rec."Telephone No. 1";
        Admissions.INSERT();
        Rec."Admission No" := NewAdminCode;
        /*Get the subject details and transfer the  same to the admissions subject*/
        ApplicationSubject.RESET;
        ApplicationSubject.SETRANGE(ApplicationSubject."Application No.", Rec."Application No.");
        IF ApplicationSubject.FIND('-') THEN BEGIN
            /*Get the last number in the admissions table*/
            AdmissionSubject.RESET;
            IF AdmissionSubject.FIND('+') THEN BEGIN
                LineNo := AdmissionSubject."Line No." + 1;
            END
            ELSE BEGIN
                LineNo := 1;
            END;

            /*Insert the new records into the database table*/
            REPEAT
                AdmissionSubject.INIT;
                AdmissionSubject."Line No." := LineNo + 1;
                AdmissionSubject."Admission No." := NewAdminCode;
                AdmissionSubject."Subject Code" := ApplicationSubject."Subject Code";
                AdmissionSubject.Grade := AdmissionSubject.Grade;
                AdmissionSubject.INSERT();
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

    end;
}

