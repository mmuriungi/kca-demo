table 51122 "HMS-Patient"
{

    LookupPageID = "HMS-Patient List";

    fields
    {
        // field(987; PatientNumber; Integer)
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(1; "Patient No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Patient No." <> xRec."Patient No." THEN BEGIN
                    HMSSetup.GET;
                    NoSeriesMgt.TestManual(HMSSetup."Patient Nos");
                    "No. Series" := '';
                END;
            end;
        }
        field(102; "File No."; Code[50])
        {

        }
        field(2; "Date Registered"; Date)
        {
        }
        field(3; "Patient Type"; Option)
        {
            /* OptionCaption = ' ,Others,Student,Employee,Dependant';
            OptionMembers = " ",Others,Student,Employee,Dependant; */
            OptionMembers = " ",Employee,Student,NSInternship,Dependant,Others;


        }

        field(980; "Patient Type2"; Option)
        {
            Caption = 'Patient Type';
            /* OptionCaption = ' ,Others,Student,Employee,Dependant';
            OptionMembers = " ",Others,Student,Employee,Dependant; */
            OptionMembers = " ",Employee,Student,"New Student",Others;
            OptionCaption = '" ",Employee,Student,"New Student",Others';


        }
        field(4; "Student No."; Code[20])
        {
            TableRelation = Customer."No." WHERE("Customer Posting Group" = CONST('Student'), Status = filter(Current | Registration | "New Admission"));
            trigger OnValidate()
            begin

                if Customer.get("Student No.") then
                    rec."Full Name" := Customer.Name



            end;
        }
        field(5; "Employee No."; Code[20])
        {
            Caption = 'Patient No.';
            TableRelation = if ("Patient Type2" = const(Employee)) "HRM-Employee C" where(Status = const(Active))
            else if ("Patient Type2" = const(Student)) Customer where("Customer Type" = const(Student))
            else if ("Patient Type2" = const("New Student")) "ACA-Applic. Form Header" where(Admitted = const(false));

            trigger OnValidate()
            var
                emp: Record "HRM-Employee C";
                std: Record Customer;
                nw: Record "ACA-Applic. Form Header";
            begin
                if ("Patient Type2" = "Patient Type2"::Employee) then begin
                    if emp.get("Employee No.") then begin
                        emp.CalcFields("Barcode Picture");
                        rec."Full Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
                        rec.Gender := emp.Gender;
                        rec."ID Number" := emp."ID Number";
                        rec."Date Of Birth" := emp."Date Of Birth";
                        rec.Photo := emp."Barcode Picture";
                        rec."Emergency Consent Address 1" := emp."Spouse Email";
                        rec."Emergency Consent Address 2" := emp."Spouse ID/Passport";
                        rec."Emergency Consent Full Name" := emp."Spouse Name";
                        rec.Email := emp."Company E-Mail";
                        rec."Telephone No. 1" := emp."Work Phone Number";

                        rec.Modify();

                    end;
                end else if ("Patient Type2" = "Patient Type2"::Student) then begin
                    if std.get("Employee No.") then begin
                        std.CalcFields("Barcode Picture");
                        rec."Full Name" := std.Name;
                        rec.Gender := std.Gender;
                        rec."ID Number" := std."ID No";
                        rec."Date Of Birth" := std."Date Of Birth";
                        rec.Photo := std."Barcode Picture";
                        rec.Email := std."E-Mail";
                        rec.Email := std."University Email";

                        rec.Modify();
                    end;
                end
                else if ("Patient Type2" = "Patient Type2"::"New Student") then begin
                    if nw.get("Employee No.") then begin
                        nw.CalcFields("Passport Photo");
                        rec."Full Name" := nw."Full Names";
                        rec.Gender := nw.Gender;
                        rec."ID Number" := nw."ID Number";
                        rec."Date Of Birth" := nw."Date Of Birth";
                        rec.Photo := nw."Passport Photo";
                        rec.Email := nw."Student E-mail";
                        rec.Email := nw.Email;
                        rec."Emergency Consent Address 1" := nw."Next Of Kin Email";
                        rec."Emergency Consent Address 2" := nw."Next of kin Name";
                        rec."Emergency Consent Full Name" := nw."Next of kin Mobile";
                        rec."Emergency Consent Address 3" := nw."Next of Kin R/Ship";
                        rec.Email := emp."Company E-Mail";
                        rec."Employee No." := nw."Admission No";
                        rec."Telephone No. 1" := nw."Emergency Telephone";
                        rec.Modify();
                    end;
                end
                else if ("Patient Type2" = "Patient Type2"::Others) then begin
                    // Making the fields editable
                    rec.Modify()
                end;
            end;

        }


        field(6; "Relative No."; Integer)
        {
            TableRelation = "HRM-Proffessional Membership"."Membership No" WHERE("Employee Code" = FIELD("Employee No."));
        }
        field(7; Title; Code[20])
        {
        }
        field(8; Surname; Text[100])
        {
        }
        field(9; "Middle Name"; Text[30])
        {
        }
        field(10; "Last Name"; Text[50])
        {
        }
        field(108; "Full Name"; text[100])
        {
            Editable = false;

        }
        field(11; Gender; Option)
        {

            OptionMembers = "",Male,Female;

            Editable = FALSE;
            //Editable = ( "Patient Type" = "Patient Type"::Others);
        }
        field(12; "Date Of Birth"; Date)
        {
            //Editable = IsPatientTypeOthers;
            Editable = FALSE;
        }
        field(13; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)","Other";
        }
        field(14; "ID Number"; Code[20])
        {
            Editable = FALSE;
        }
        field(546; Age; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(897; IsPatientTypeOthers; Boolean)
        {

            Editable = false;
            InitValue = false;

            trigger OnValidate()
            begin
                Rec.Validate("IsPatientTypeOthers", "Patient Type" = "Patient Type"::Others);
            end;
        }
        field(15; Photo; BLOB)
        {
            Subtype = Bitmap;
        }
        field(16; "Correspondence Address 1"; Text[100])
        {
        }
        field(17; "Correspondence Address 2"; Text[100])
        {
        }
        field(18; "Correspondence Address 3"; Text[100])
        {
        }
        field(19; "Telephone No. 1"; Code[100])
        {
        }
        field(20; "Telephone No. 2"; Code[100])
        {
        }
        field(21; Email; Text[100])
        {
        }
        field(22; "Fax No."; Text[30])
        {
        }
        field(23; "Spouse Name"; Text[30])
        {
        }
        field(24; "Spouse Address 1"; Text[30])
        {
        }
        field(25; "Spouse Address 2"; Text[30])
        {
        }
        field(26; "Spouse Address 3"; Text[30])
        {
        }
        field(27; "Spouse Telephone No. 1"; Text[30])
        {
        }
        field(28; "Spouse Telephone No. 2"; Text[30])
        {
        }
        field(29; "Spouse Email"; Text[100])
        {
        }
        field(30; "Spouse Fax"; Text[30])
        {
        }
        field(31; "Place of Birth Village"; Text[30])
        {
        }
        field(32; "Place of Birth Location"; Text[30])
        {
        }
        field(33; "Place of Birth District"; Code[20])
        {
            //TableRelation = "ACA-Applic. Setup County".Code;
        }
        field(34; "Name of Chief"; Text[100])
        {
        }
        field(35; "Nearest Police Station"; Text[100])
        {
        }
        field(36; Nationality; Code[20])
        {
        }
        field(37; Religion; Code[20])
        {
        }
        field(38; "Mother Alive or Dead"; Option)
        {
            OptionMembers = Alive,Deceased;
        }
        field(39; "Mother Full Name"; Text[100])
        {
        }
        field(40; "Mother Occupation"; Text[30])
        {
        }
        field(41; "Father Alive or Dead"; Option)
        {
            OptionMembers = Alive,Deceased;
        }
        field(42; "Father Full Name"; Text[100])
        {
        }
        field(43; "Father Occupation"; Text[30])
        {
        }
        field(44; "Guardian Name"; Text[100])
        {
        }
        field(45; "Guardian Occupation"; Text[30])
        {
        }
        field(46; "Physical Impairment Details"; Text[200])
        {
        }
        field(567; location; option)
        {
            OptionMembers = "",Observation,Consultation,Pharmacy,Lab;
            DataClassification = ToBeClassified;
        }
        field(47; "Blood Group"; Option)
        {
            OptionMembers = "","A+","A-","B+","B-","AB+","AB-","O+","O-";
        }


        field(48; "Without Glasses R.6"; Decimal)
        {
        }
        field(49; "Without Glasses L.6"; Decimal)
        {
        }
        field(50; "With Glasses R.6"; Decimal)
        {
        }
        field(51; "With Glasses L.6"; Decimal)
        {
        }
        field(52; "Hearing Right Ear"; Decimal)
        {
        }
        field(53; "Hearing Left Ear"; Decimal)
        {
        }
        field(54; "Condition Of Teeth"; Text[30])
        {
        }
        field(55; "Condition Of Throat"; Text[30])
        {
        }
        field(56; "Condition Of Ears"; Text[30])
        {
        }
        field(57; "Condition Of Lymphatic Glands"; Text[30])
        {
        }
        field(58; "Condition Of Nose"; Text[30])
        {
        }
        field(59; "Circulatory System Pulse"; Text[30])
        {
        }
        field(60; "Examining Officer"; Text[30])
        {
            Editable = false;
        }
        field(61; "Medical Exam Date"; Date)
        {
        }
        field(62; "Medical Details Not Covered"; Text[200])
        {
        }
        field(63; "Emergency Consent Relationship"; Code[20])
        {
            NotBlank = true;
            TableRelation = Relative.Code;
        }
        field(64; "Emergency Consent Full Name"; Text[30])
        {
            // NotBlank = true;
            // Editable = false;
        }
        field(65; "Emergency Consent Address 1"; code[56])
        {
            // NotBlank = true;
            // Editable = false;
        }
        field(66; "Emergency Consent Address 2"; code[106])
        {
            // Editable = false;
        }
        field(67; "Emergency Consent Address 3"; Text[30])
        {
        }
        field(68; "Emergency Date of Consent"; Date)
        {
            NotBlank = true;
        }
        field(69; "Emergency National ID Card No."; Code[20])
        {
            Description = 'Stores the national identity card number of the person who consented to the emergency operation';
            NotBlank = true;
        }
        field(70; "No. Series"; Code[20])
        {
        }
        field(678; IsAllergic; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(679; AllergicTo; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Appointments Scheduled"; Integer)
        {
            CalcFormula = Count("HMS-Appointment Form Header" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(72; "Appointments Completed"; Integer)
        {
            CalcFormula = Count("HMS-Appointment Form Header" WHERE("Patient No." = FIELD("Patient No."),
                                                                     Status = CONST(Completed)));
            FieldClass = FlowField;
        }
        field(73; "Appointments Rescheduled"; Integer)
        {
            CalcFormula = Count("HMS-Appointment Form Header" WHERE("Patient No." = FIELD("Patient No."),
                                                                     Status = CONST(Rescheduled)));
            FieldClass = FlowField;
        }
        field(74; "Appointments Cancelled"; Integer)
        {
            CalcFormula = Count("HMS-Appointment Form Header" WHERE("Patient No." = FIELD("Patient No."),
                                                                     Status = CONST(Cancelled)));
            FieldClass = FlowField;
        }
        field(75; Height; Decimal)
        {
            trigger OnValidate()
            var
                H: Decimal;
            begin
                if Weight > 0 then begin
                    H := Height / 100;
                    BMI := Weight / (H * H);
                end;
            end;
        }
        field(76; Weight; Decimal)
        {
            trigger OnValidate()
            var
                H: Decimal;
            begin
                if Height > 0 then begin
                    H := Height / 100;
                    BMI := Weight / (H * H);
                end;
            end;
        }
        field(77; "Drug Reaction"; Text[100])
        {
        }
        field(78; "Customer No."; Code[20])
        {
        }
        field(79; "Customer Created"; Boolean)
        {
        }
        field(80; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(81; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(82; "Immunization Number"; Code[20])
        {
        }
        field(83; Blocked; Boolean)
        {
        }
        field(84; "Request Registration"; Boolean)
        {
        }
        field(85; Registered; Boolean)
        {
        }
        field(86; Status; Option)
        {
            OptionMembers = "Request Made","HOD HR Approved","HOD Medical Approved",Registered,"Request Cancelled","HOD HR Rejected","HOD Medical Rejected";
        }
        field(87; Select; Boolean)
        {
        }
        field(88; "Patient Ref. No."; Code[20])
        {
            TableRelation = IF ("Patient Type" = CONST(Employee)) "HRM-Employee C"."No." where(Status = const(Active))
            ELSE
            IF ("Patient Type" = CONST(Student)) Customer."No." WHERE("Customer Posting Group" = CONST('STUDENT'), Status = filter(Current | Registration | "New Admission"))
            ELSE
            IF ("Patient Type" = CONST(Dependant)) "HRM-Employee Beneficiaries"."Entry No" WHERE("Employee Code" = FIELD("Depandant Principle Member"));

            trigger OnValidate()
            var
                benefic: Record "HRM-Employee Beneficiaries";
            begin
                IF "Patient Type" = "Patient Type"::Student THEN BEGIN
                    IF Customer.GET("Patient Ref. No.") THEN BEGIN
                        "Student No." := "Patient Ref. No.";
                        Title := '';
                        Surname := Customer.Name;
                        "Middle Name" := '';
                        "Last Name" := '';
                        Gender := Customer.Gender;
                        "Date Of Birth" := Customer."Date Of Birth";
                        "Marital Status" := Customer."Marital Status";
                        "ID Number" := Customer."ID No";
                        "Correspondence Address 1" := Customer.Address;
                        "Correspondence Address 2" := Customer."Address 2";
                        "Correspondence Address 3" := Customer.City;
                        "Telephone No. 1" := Customer."Phone No.";
                        "Telephone No. 2" := Customer."Telex No.";
                        Email := Customer."E-Mail";
                        "Fax No." := Customer."Fax No.";
                        "Global Dimension 1 Code" := Customer."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := Customer."Global Dimension 2 Code";
                    END;
                END ELSE
                    IF "Patient Type" = "Patient Type"::Employee THEN BEGIN
                        IF Emp.GET("Patient Ref. No.") THEN BEGIN
                            "Employee No." := "Patient Ref. No.";
                            // Title:=Emp.Title;
                            Surname := Emp."First Name";
                            "Middle Name" := Emp."Middle Name";
                            "Last Name" := Emp."Last Name";
                            Gender := Emp.Gender;
                            Title := FORMAT(Emp.Title);
                            "Date Of Birth" := Emp."Date Of Birth";
                            "Marital Status" := Emp."Marital Status";
                            "ID Number" := Emp."ID Number";
                            "Correspondence Address 1" := Emp."Postal Address";
                            "Correspondence Address 2" := Emp."Residential Address";
                            "Correspondence Address 3" := Emp.City;
                            "Telephone No. 1" := Emp."Cellular Phone Number";
                            "Telephone No. 2" := Emp."Home Phone Number";
                            Email := Emp."E-Mail";
                            "Fax No." := Emp."Fax Number";
                            "Global Dimension 2 Code" := Emp."Department Code";

                        END;

                    END ELSE
                        IF "Patient Type" = "Patient Type"::Dependant THEN BEGIN
                            benefic.RESET;
                            benefic.SETRANGE(benefic."Employee Code", "Depandant Principle Member");
                            IF "Depandant Principle Member" = '' THEN ERROR('Please specify the Principal member number!');
                            benefic.SETRANGE(benefic."Entry No", "Patient Ref. No.");
                            IF benefic.FIND('-') THEN BEGIN
                                IF Emp.GET("Depandant Principle Member") THEN BEGIN
                                    "Employee No." := Emp."No.";
                                    // Title:=Emp.Title;
                                    Surname := benefic.SurName;
                                    "Middle Name" := benefic."Other Names";
                                    //Gender:=;
                                    // Title:=FORMAT(Emp.Title);
                                    "Date Of Birth" := benefic."Date Of Birth";
                                    // "Marital Status":=;
                                    "ID Number" := benefic."ID No/Passport No";
                                    "Correspondence Address 1" := benefic.Address;
                                    "Correspondence Address 2" := Emp."Residential Address";
                                    "Correspondence Address 3" := Emp.City;
                                    "Telephone No. 1" := benefic."Office Tel No";
                                    "Telephone No. 2" := benefic."Home Tel No";
                                    Email := Emp."E-Mail";
                                    "Fax No." := Emp."Fax Number";
                                    "Global Dimension 2 Code" := Emp."Department Code";

                                END;

                            END;
                        END;

                VALIDATE("Date Of Birth");
            end;
        }
        field(89; "Depandant Principle Member"; Code[20])
        {
            TableRelation = IF ("Patient Type" = FILTER(Dependant)) "HRM-Employee C"."No.";
        }
        field(90; "User ID"; Code[20])
        {
        }
        field(91; "Patient Current Location"; Option)
        {
            OptionCaption = 'New,Triage,Appointment,Observation,Doctor List,Laboratory,Radiology Room,Phamacy,Refered,Cleared,Cancelled';
            OptionMembers = New,Triage,Appointment,Observation,"Doctor List",Laboratory,"Radiology Room",Phamacy,Refered,Cleared,Cancelled;
        }
        field(92; "Total Billed"; Decimal)
        {
            CalcFormula = Sum("HMS-Patient Charges".Amount WHERE("Customer No." = FIELD("Patient Ref. No."),
                                                                                      "Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(107; "Mode of Payment"; Option)
        {
            OptionMembers = "",Cash,Insurance,Payroll;
        }
        field(93; "Registration Status"; Option)
        {
            OptionCaption = 'Registration,Cleared';
            OptionMembers = Registration,Cleared;
        }
        field(94; "Triage Status"; Option)
        {
            OptionCaption = ' ,Triage,Cleared';
            OptionMembers = " ",Triage,Cleared;
        }
        field(95; "Appointment Status"; Option)
        {
            OptionCaption = ' ,Appointment,Cleared';
            OptionMembers = " ",Appointment,Cleared;
        }
        field(96; "Observation Status"; Option)
        {
            OptionCaption = ' ,Observation,Cleared';
            OptionMembers = " ",Observation,Cleared;
        }
        field(97; "Doctor Visit Status"; Option)
        {
            OptionCaption = ' ,Doctor,Cleared';
            OptionMembers = " ",Doctor,Cleared;
        }
        field(98; "Laboratory Status"; Option)
        {
            OptionCaption = ' ,Laboratory,Cleared ';
            OptionMembers = " ",Laboratory,"Cleared ";
        }
        field(99; "Radiology Status"; Option)
        {
            OptionCaption = ' ,Radiology,Cleared';
            OptionMembers = " ",Radiology,Cleared;
        }
        field(100; "Pharmacy Status"; Option)
        {
            OptionCaption = ' ,Pharmacy,Cleared';
            OptionMembers = " ",Pharmacy,Cleared;
        }
        field(101; "Hospital Billing Status"; Option)
        {
            OptionCaption = 'Billing,Cleared';
            OptionMembers = Billing,Cleared;
        }
        field(103; "Rhesus Factor"; Option)
        {
            OptionMembers = "","Rh+","Rh-",Rhnull;
        }
        field(104; "Blood Pressure"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(105; "Body Temp."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(106; BMI; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(109; AllergicInfo; code[20])
        {
            DataClassification = ToBeClassified;
        }
        //Is Active
        field(110; "Student Active"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist(Customer WHERE("No." = FIELD("Student No."), Status = filter(Current | Registration | "New Admission")));
        }
        field(111; "Employee Active"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("HRM-Employee C" WHERE("No." = FIELD("Employee No."), Status = filter(Active)));
        }

    }

    keys
    {
        key(Key1; "Patient No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Employee No.", "Full Name", Gender, "Date Of Birth", "ID Number", Photo, "Correspondence Address 1", "Correspondence Address 2", "Correspondence Address 3", "Telephone No. 1", "Telephone No. 2", Email)
        {
        }
    }

    trigger OnInsert()
    begin
        IF "Patient No." = '' THEN BEGIN
            HMSSetup.GET;
            HMSSetup.TESTFIELD("Patient Nos");
            NoSeriesMgt.InitSeries(HMSSetup."Patient Nos", xRec."No. Series", 0D, "Patient No.", "No. Series");
        END;
        "Date Registered" := TODAY;
        "User ID" := USERID;
    end;

    var
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        Customer: Record 18;
        Emp: Record "HRM-Employee C";

    // procedure CreateCustomerAccount()
    // begin
    //     IF "Customer Created" = TRUE THEN BEGIN EXIT END;
    //     Customer.INIT;
    //     Customer."No." := rec."Student No."
    //      Customer.Name  := rec."Full Name"
    //      Customer.Address :=
    //      Customer."Address 2"
    //      Customer."Phone No."
    //      Customer."Global Dimension 1 Code"
    //      Customer."Global Dimension 2 Code"*/
    //     Customer.INSERT();
    // end;

    procedure CreateObservation()
    var
        pat: Record "HMS-Patient";
        Observation: Record "HMS-Observation Form Header";
        Nextno: code[20];
        cust: Record Customer;
    begin
        pat.Reset();
        pat.SetRange("Patient No.", Rec."Patient No.");
        if pat.Find('-') then begin
            HMSSetup.GET;
            HMSSetup.TESTFIELD("Observation Nos");
            Nextno := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", today, true);
            Observation.Init();
            Observation."Observation No." := Nextno;
            Observation."Observation Type" := Observation."Observation Type"::New;
            Observation."Observation Date" := today();
            Observation."Observation Time" := System.Time();
            Observation."Observation User ID" := UserId;
            Observation."Patient No." := Rec."Patient No.";
            Observation."Student No." := Rec."Student No.";
            Observation."Patient Name" := Rec."Full Name";
            Observation."Relative No." := Rec."Relative No.";
            Observation."Rhesus Factor" := Rec."Rhesus Factor";
            Observation."Blood Group" := Rec."Blood Group";
            Observation."Physical Impairment Details" := Rec."Physical Impairment Details";
            Observation."Medical Details Not Covered" := Rec."Medical Details Not Covered";
            Observation.AllergicTo := rec.AllergicTo;

            Observation.Insert(true);
            Message('patient has been moved  to observation');
            //Page.Run(Page::"HMS-Observations Header", Observation);
        end;

        // Message('Patient Observation No.' + Nextno + ' ' + "Full Name" + ' Proceed to Observation');



    end;

}

