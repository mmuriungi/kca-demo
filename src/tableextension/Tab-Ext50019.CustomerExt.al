tableextension 50019 "Customer Ext" extends Customer
{
    fields
    {
        field(10004; "UPS Zone"; Code[2])
        {
            Caption = 'UPS Zone';
            DataClassification = CustomerContent;
        }
        field(10015; "Tax Exemption No."; Text[30])
        {
            Caption = 'Tax Exemption No.';
            DataClassification = CustomerContent;
        }
        field(10017; "Bank Communication"; Option)
        {
            Caption = 'Bank Communication';
            OptionMembers = " ";
            DataClassification = CustomerContent;
        }
        field(10018; "Check Date Format"; Option)
        {
            Caption = 'Check Date Format';
            OptionMembers = " ";
            DataClassification = CustomerContent;
        }
        field(10019; "Check Date Separator"; Option)
        {
            Caption = 'Check Date Separator';
            OptionMembers = " ";
            DataClassification = CustomerContent;
        }
        field(10021; "Balance on Date"; Decimal)
        {
            Caption = 'Balance on Date';
            DataClassification = CustomerContent;
        }
        field(10022; "Balance on Date (LCY)"; Decimal)
        {
            Caption = 'Balance on Date (LCY)';
            DataClassification = CustomerContent;
        }
        field(10023; "RFC No."; Code[13])
        {
            Caption = 'RFC No.';
            DataClassification = CustomerContent;
            trigger onvalidate()
            var
                Customer: Record Customer;
            begin
                CASE "Tax Identification Type" OF
                    "Tax Identification Type"::"Legal Entity":
                        ValidateRFCNo(12);
                    "Tax Identification Type"::"Natural Person":
                        ValidateRFCNo(13);
                END;
                Customer.RESET;
                Customer.SETRANGE("RFC No.", "RFC No.");
                Customer.SETFILTER("No.", '<>%1', "No.");
                IF Customer.FINDFIRST THEN
                    MESSAGE(Text10002, "RFC No.");
            end;
        }
        field(10024; "CURP No."; Code[18])
        {
            Caption = 'CURP No.';
            DataClassification = CustomerContent;
        }
        field(10025; "State Inscription"; Text[30])
        {
            Caption = 'State Inscription';
            DataClassification = CustomerContent;
        }
        field(14020; "Tax Identification Type"; Option)
        {
            Caption = 'Tax Identification Type';
            OptionMembers = "Legal Entity","Natural Person";
            DataClassification = CustomerContent;
        }
        field(50000; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
        }
        field(50001; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            DataClassification = ToBeClassified;
        }
        field(50002; "Account No"; Code[100])
        {
            Caption = 'Account No';
            DataClassification = ToBeClassified;
        }
        field(50050; "Balance (Cafe)"; Decimal)
        {
            Caption = 'Balance (Cafe)';
            FieldClass = FlowField;
            CalcFormula = Sum("CAT-Det. Students Cafe Ledgers".Amount WHERE("Customer No." = FIELD("No.")));
        }
        field(50051; "Debit Amount (Cafe)"; Decimal)
        {
            Caption = 'Debit Amount (Cafe)';
            FieldClass = FlowField;
            CalcFormula = Sum("CAT-Det. Students Cafe Ledgers"."Debit Amount" WHERE("Customer No." = FIELD("No.")));
        }
        field(50052; "Credit Amount (Cafe)"; Decimal)
        {
            Caption = 'Credit Amount (Cafe)';
            FieldClass = FlowField;
            CalcFormula = Sum("CAT-Det. Students Cafe Ledgers"."Credit Amount" WHERE("Customer No." = FIELD("No.")));
        }
        field(63000; Gender; Option)
        {
            Caption = 'Gender';
            OptionMembers = " ",Male,Female;
            DataClassification = CustomerContent;
        }
        field(63001; "Date Of Birth"; Date)
        {
            Caption = 'Date Of Birth';
            DataClassification = CustomerContent;
        }
        field(63002; Age; Decimal)
        {
            Caption = 'Age';
            DataClassification = CustomerContent;
        }
        field(63003; "Marital Status"; Option)
        {
            Caption = 'Marital Status';
            OptionMembers = " ";
            DataClassification = CustomerContent;
        }
        field(63004; "Blood Group"; Text[5])
        {
            Caption = 'Blood Group';
            DataClassification = CustomerContent;
        }
        field(63005; Weight; Decimal)
        {
            Caption = 'Weight';
            DataClassification = CustomerContent;
        }
        field(63006; Height; Decimal)
        {
            Caption = 'Height';
            DataClassification = CustomerContent;
        }
        field(63007; Religion; Code[20])
        {
            Caption = 'Religion';
            DataClassification = CustomerContent;
        }
        field(63008; Citizenship; Text[100])
        {
            Caption = 'Citizenship';
            DataClassification = CustomerContent;
        }
        field(63009; "Payments By"; Code[70])
        {
            Caption = 'Payments By';
            DataClassification = CustomerContent;
        }
        field(63010; "Student Type"; Code[20])
        {
            Caption = 'Student Type';
            DataClassification = CustomerContent;
        }
        field(63011; "ID No"; Code[20])
        {
            Caption = 'ID No';
            trigger OnValidate()
            begin
                Cust.RESET;
                Cust.SETRANGE(Cust."ID No", "ID No");
                IF Cust.FIND('-') THEN;
                //ERROR('Passport/ID No. exists.');
            end;
        }
        field(63012; "Date Registered"; Date)
        {
            Caption = 'Date Registered';
            DataClassification = CustomerContent;
        }
        field(63013; "Membership No"; Text[1])
        {
            Caption = 'Membership No';
            DataClassification = CustomerContent;
        }
        field(63014; "Customer Type"; Option)
        {
            Caption = 'Customer Type';
            OptionMembers = Customer,Student,Hotel;
            DataClassification = CustomerContent;
        }
        field(63015; "Birth Cert"; Code[20])
        {
            Caption = 'Birth Cert';
            trigger OnValidate()
            begin
                Cust.RESET;
                Cust.SETRANGE(Cust."Birth Cert", "Birth Cert");
                IF Cust.FIND('-') THEN
                    ERROR('Birth Cert/KNEC No. exists.');
            end;
        }
        field(63016; "UNISA No"; Code[1])
        {
            Caption = 'UNISA No';
            DataClassification = CustomerContent;
        }
        field(63018; "Old Student Code"; Code[20])
        {
            Caption = 'Old Student Code';
            DataClassification = CustomerContent;
        }
        field(63019; "Name 3"; Text[1])
        {
            Caption = 'Name 3';
            DataClassification = CustomerContent;
        }
        field(63020; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Registration,Current,Alumni,"Dropped Out",Defered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,"Completed not graduated","Graduated no Certificates","Graduated with Certificate","New Admission",Incomplete;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "Status Change Date" := TODAY;
            end;
        }
        field(63021; "Total Billed"; Decimal)
        {
            Caption = 'Total Billed';
            CalcFormula = Sum("ACA-Std Charges".Amount WHERE("Student No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(63022; "Library Code"; Code[1])
        {
            Caption = 'Library Code';
            DataClassification = CustomerContent;
        }
        field(63024; "KNEC No"; Code[30])
        {
            Caption = 'KNEC No';
            DataClassification = CustomerContent;
        }
        field(63025; "Passport No"; Code[1])
        {
            Caption = 'Passport No';
            DataClassification = CustomerContent;
        }
        field(63026; "Total Paid"; Decimal)
        {
            Caption = 'Total Paid';
            CalcFormula = Sum("ACA-Std Charges"."Amount Paid" WHERE("Student No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(63030; "No. Of Receipts"; Integer)
        {
            Caption = 'No. Of Receipts';
            CalcFormula = Count("ACA-Receipt" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63034; "Confirmed Ok"; Boolean)
        {
            Caption = 'Confirmed Ok';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "User ID" := USERID;
            end;
        }
        field(63035; "User ID"; Code[1])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(63037; "No Of Charges"; Integer)
        {
            Caption = 'No Of Charges';
            CalcFormula = Count("ACA-Std Charges" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63038; "Library Membership"; Option)
        {
            Caption = 'Library Membership';
            OptionMembers = " ";
            DataClassification = CustomerContent;
        }
        field(63039; libsecurity; Text[1])
        {
            Caption = 'libsecurity';
            DataClassification = CustomerContent;
        }
        field(63040; "Can Use Library"; Boolean)
        {
            Caption = 'Can Use Library';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TESTFIELD("Library Category");
                "Library Security" := 1;
                MODIFY;

            end;
        }
        field(63041; "Lib Membership"; Text[10])
        {
            Caption = 'Lib Membership';
            DataClassification = CustomerContent;
        }
        field(63042; "No Of Reversals"; Integer)
        {
            Caption = 'No Of Reversals';
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Customer No." = FIELD("No."),
                                                            Reversed = CONST(True)));
            FieldClass = FlowField;
        }
        field(63043; "Document No. Filter"; Code[20])
        {
            Caption = 'Document No. Filter';
            DataClassification = CustomerContent;
        }
        field(63046; "Semester Filter"; Code[20])
        {
            Caption = 'Semester Filter';
            DataClassification = CustomerContent;
            TableRelation = "ACA-Semester".Code;

        }
        field(63047; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            DataClassification = CustomerContent;
        }
        field(63048; "Internal/External"; Option)
        {
            Caption = 'Internal/External';
            OptionMembers = " ";
            DataClassification = CustomerContent;
        }
        field(63050; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
            TableRelation = "ACA-Enquiry Header"."Enquiry No." WHERE(Status = CONST(Eligible));

            trigger onvalidate()
            var
                myInt: Integer;
            begin
                Enrollment.RESET;
                IF Enrollment.GET("Application No.") THEN BEGIN
                    Rec.Name := Enrollment."Name(Surname First)";
                    Rec."Search Name" := UPPERCASE(Rec.Name);
                    Rec.Address := Enrollment."Permanent Home Address";
                    Rec."Address 2" := Rec.Address;
                    Rec."Phone No." := Enrollment."Home Telephone No.";
                    Rec."Telex No." := Enrollment."Fax Number";
                    Rec."E-Mail" := Enrollment."Email Address";
                    Rec.Gender := Enrollment.Gender;
                    Rec."Date Of Birth" := Enrollment."Date of Birth";
                    Rec."Date Registered" := TODAY;
                    Rec."Customer Type" := Rec."Customer Type"::Student;
                    Rec."Student Type" := FORMAT(Enrollment."Student Type");
                    Rec."ID No" := Enrollment."Passport/National ID Number";
                    "Customer Posting Group" := 'STUDENTS';
                    VALIDATE("Customer Posting Group");


                    //insert the course registration details
                    CourseRegistration.RESET;
                    CourseRegistration.INIT;
                    CourseRegistration."Reg. Transacton ID" := '';
                    CourseRegistration.VALIDATE(CourseRegistration."Reg. Transacton ID");
                    CourseRegistration."Student No." := Rec."No.";
                    CourseRegistration.Programmes := Enrollment.Programmes;
                    CourseRegistration.Semester := Enrollment.Semester;
                    CourseRegistration.Stage := Enrollment."Programme Stage";
                    CourseRegistration."Student Type" := Enrollment."Student Type";
                    CourseRegistration."Registration Date" := TODAY;
                    //CourseRegistration."Settlement Type":='FULL PAYMENT';
                    //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                    CourseRegistration.INSERT;

                    CourseRegistration.RESET;
                    CourseRegistration.SETRANGE(CourseRegistration."Student No.", "No.");
                    IF CourseRegistration.FIND('+') THEN BEGIN
                        CourseRegistration."Registration Date" := TODAY;
                        CourseRegistration.VALIDATE(CourseRegistration."Registration Date");
                        //CourseRegistration."Settlement Type":='FULL PAYMENT';
                        //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                        CourseRegistration.MODIFY;

                    END;




                    //insert the details related to the next of kin of the student into the database
                    EnrollmentNextofKin.RESET;
                    EnrollmentNextofKin.SETRANGE(EnrollmentNextofKin."Enquiry No", Enrollment."Enquiry No.");
                    IF EnrollmentNextofKin.FIND('-') THEN BEGIN
                        REPEAT
                            StudentKin.RESET;
                            StudentKin.INIT;
                            StudentKin."Student No" := Rec."No.";
                            StudentKin.Relationship := EnrollmentNextofKin.Relationship;
                            StudentKin.Name := EnrollmentNextofKin.SurName;
                            StudentKin."Other Names" := EnrollmentNextofKin."Other Names";
                            StudentKin."ID No/Passport No" := EnrollmentNextofKin."ID No/Passport No";
                            StudentKin."Date Of Birth" := EnrollmentNextofKin."Date Of Birth";
                            StudentKin.Occupation := EnrollmentNextofKin.Occupation;
                            StudentKin."Office Tel No" := EnrollmentNextofKin."Office Tel No";
                            StudentKin."Home Tel No" := EnrollmentNextofKin."Home Tel No";
                            StudentKin.Remarks := EnrollmentNextofKin.Remarks;
                            StudentKin.INSERT;
                        UNTIL EnrollmentNextofKin.NEXT = 0;
                    END;
                    //insert the details in relation to the guardian/sponsor into the database in relation to the current student
                    EnrollmentGuardian.RESET;
                    EnrollmentGuardian.SETRANGE(EnrollmentGuardian."Enquiry No.", Enrollment."Enquiry No.");
                    IF EnrollmentGuardian.FIND('-') THEN BEGIN
                        REPEAT
                            StudentGuardian.RESET;
                            StudentGuardian.INIT;
                            StudentGuardian."Student No." := Rec."No.";
                            StudentGuardian.Names := EnrollmentGuardian.SurName + ' ' + EnrollmentGuardian."Other Names";
                            StudentGuardian.Address := EnrollmentGuardian.Address;
                            StudentGuardian."Telephone No" := EnrollmentGuardian."Office Tel No";
                            StudentGuardian.INSERT;
                        UNTIL EnrollmentGuardian.NEXT = 0;
                    END;
                    //insert the details in relation to the student history as detailed in the application
                    EnrollmentEducationHistory.RESET;
                    EnrollmentEducationHistory.SETRANGE(EnrollmentEducationHistory."Enquiry No.", Enrollment."Enquiry No.");
                    IF EnrollmentEducationHistory.FIND('-') THEN BEGIN
                        REPEAT
                            EducationHistory.RESET;
                            EducationHistory.INIT;
                            EducationHistory."Student No." := Rec."No.";
                            // EducationHistory.From:=EnrollmentEducationHistory."From";
                            //EducationHistory."To":=EnrollmentEducationHistory."To";
                            EducationHistory.Qualifications := EnrollmentEducationHistory.Qualifications;
                            EducationHistory.Instituition := EnrollmentEducationHistory.Instituition;
                            EducationHistory.Remarks := EnrollmentEducationHistory.Remarks;
                            EducationHistory."Aggregate Result/Award" := EnrollmentEducationHistory."Aggregate Result/Award";
                            EducationHistory.INSERT;
                        UNTIL EnrollmentEducationHistory.NEXT = 0;
                    END;
                    //update the status of the application
                    Enrollment."Registration No" := Rec."No.";
                    Enrollment.Status := Enrollment.Status::Admitted;
                    Enrollment.MODIFY;
                END;
            end;
        }
        field(63051; "Accredited Centre no."; Code[20])
        {
            Caption = 'Accredited Centre no.';
            DataClassification = CustomerContent;
        }
        field(63052; "Unbilled Charged"; Integer)
        {
            Caption = 'Unbilled Charged';
            CalcFormula = Count("ACA-Std Charges" WHERE("Student No." = FIELD("No."),
                                                         Recognized = CONST(false)));
            FieldClass = FlowField;
        }
        field(63055; Adults; Integer)
        {
            Caption = 'Adults';
            DataClassification = CustomerContent;
        }
        field(63056; "Vehicle No."; Code[5])
        {
            Caption = 'Vehicle No.';
            DataClassification = CustomerContent;
        }
        field(63057; "Children Under 12"; Integer)
        {
            Caption = 'Children Under 12';
            DataClassification = CustomerContent;
        }
        field(63058; "Group/Company"; Code[20])
        {
            Caption = 'Group/Company';
            DataClassification = CustomerContent;
        }
        field(63059; "Departure Date"; Date)
        {
            Caption = 'Departure Date';
            DataClassification = CustomerContent;
        }
        field(63060; "Arrival Date"; Date)
        {
            Caption = 'Arrival Date';
            DataClassification = CustomerContent;
        }
        field(63061; Nationality; Text[20])
        {
            Caption = 'Nationality';
            DataClassification = CustomerContent;
        }
        field(63062; "Room no"; Code[6])
        {
            Caption = 'Room no';
            DataClassification = CustomerContent;
        }
        field(63063; "Room Type"; Code[6])
        {
            Caption = 'Room Type';
            DataClassification = CustomerContent;
        }
        field(63064; "Receipt No"; Code[20])
        {
            Caption = 'Receipt No';
            DataClassification = CustomerContent;
        }
        field(63065; Rate; Decimal)
        {
            Caption = 'Rate';
            DataClassification = CustomerContent;
        }
        field(63066; Cashier; Text[1])
        {
            Caption = 'Cashier';
            DataClassification = CustomerContent;
        }
        field(63067; Deposit; Decimal)
        {
            Caption = 'Deposit';
            DataClassification = CustomerContent;
        }
        field(63068; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = CustomerContent;
        }
        field(63069; Remarks; Text[20])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(63071; Singles; Integer)
        {
            Caption = 'Singles';
            DataClassification = CustomerContent;
        }
        field(63073; Doubles; Integer)
        {
            Caption = 'Doubles';
            DataClassification = CustomerContent;
        }
        field(63074; Triples; Integer)
        {
            Caption = 'Triples';
            DataClassification = CustomerContent;
        }
        field(63075; "Taken By"; Text[1])
        {
            Caption = 'Taken By';
            DataClassification = CustomerContent;
        }
        field(63076; "Checked By"; Text[1])
        {
            Caption = 'Checked By';
            DataClassification = CustomerContent;
        }
        field(63078; "Check Out Date"; Date)
        {
            Caption = 'Check Out Date';
            DataClassification = CustomerContent;
        }
        field(63079; "Check In Time"; Time)
        {
            Caption = 'Check In Time';
            DataClassification = CustomerContent;
        }
        field(63080; "HTL Status"; Option)
        {
            Caption = 'HTL Status';
            OptionMembers = " ",Reserved,Current,Old;
            DataClassification = CustomerContent;
        }
        field(63081; "HELB No."; Code[20])
        {
            Caption = 'HELB No.';
            DataClassification = CustomerContent;
        }
        field(63082; "Deferement Period"; DateFormula)
        {
            Caption = 'Deferement Period';
            DataClassification = CustomerContent;
        }
        field(63083; "Status Change Date"; Date)
        {
            Caption = 'Status Change Date';
            DataClassification = CustomerContent;
        }
        field(63084; "Revenue Cash Account"; Code[20])
        {
            Caption = 'Revenue Cash Account';
            DataClassification = CustomerContent;
        }
        field(63085; Password; Text[50])
        {
            Caption = 'Password';
            DataClassification = CustomerContent;
        }
        field(63086; "Gown 1"; Boolean)
        {
            Caption = 'Gown 1';
            DataClassification = CustomerContent;
        }
        field(63087; "Gown 2"; Boolean)
        {
            Caption = 'Gown 2';
            DataClassification = CustomerContent;
        }
        field(63088; "Gown 3"; Boolean)
        {
            Caption = 'Gown 3';
            DataClassification = CustomerContent;
        }
        field(63089; "Date Issued"; Date)
        {
            Caption = 'Date Issued';
            DataClassification = CustomerContent;
        }
        field(63090; "Gown Status"; Option)
        {
            Caption = 'Gown Status';
            OptionMembers = " ",Loaned,Returned;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF "Gown Status" = "Gown Status"::Loaned THEN
                    "Date Issued" := TODAY;

                IF "Gown Status" = "Gown Status"::Returned THEN
                    "Date Returned" := TODAY;
            end;
        }
        field(63091; "Date Returned"; Date)
        {
            Caption = 'Date Returned';
            DataClassification = CustomerContent;
        }
        field(63092; "Certificate Status"; Option)
        {
            Caption = 'Certificate Status';
            OptionMembers = " ",Pending,Collected;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF "Certificate Status" = "Certificate Status"::Collected THEN
                    "Date Collected" := TODAY;

            end;
        }
        field(63093; "Date Collected"; Date)
        {
            Caption = 'Date Collected';
            DataClassification = CustomerContent;
        }
        field(63094; Confirmed; Boolean)
        {
            Caption = 'Confirmed';
            DataClassification = CustomerContent;
        }
        field(63095; "Confirmed Remarks"; Text[50])
        {
            Caption = 'Confirmed Remarks';
            DataClassification = CustomerContent;
        }
        field(63096; "Special Requrements"; Text[20])
        {
            Caption = 'Special Requrements';
            DataClassification = CustomerContent;
        }
        field(63097; "Certificate No."; Text[20])
        {
            Caption = 'Certificate No.';
            DataClassification = CustomerContent;
        }
        field(63098; "No. Of Reg"; Integer)
        {
            Caption = 'No. Of Reg';
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63099; "No Of Creidts"; Integer)
        {
            Caption = 'No Of Creidts';
            CalcFormula = Count("Detailed Cust. Ledg. Entry" WHERE("Customer No." = FIELD("No."),
                                                                    "Entry Type" = CONST("Initial Entry"),
                                                                    "Credit Amount (LCY)" = FILTER(> 0)));
            FieldClass = FlowField;
        }
        field(63100; District; Code[20])
        {
            Caption = 'District';
            DataClassification = CustomerContent;
            TableRelation = "ACA-Applic. Setup County".Code;
            trigger OnValidate()
            begin
                districtrec.RESET;
                Districtname := '';
                districtrec.SETRANGE(districtrec.Code, District);
                IF districtrec.FIND('-') THEN
                    Districtname := districtrec.Description;
            end;
        }
        field(63101; "Student Programme"; Code[20])
        {
            CalcFormula = Max("ACA-Course Registration".Programmes WHERE("Student No." = FIELD("No.")));
            Description = 'flowfield to look up program table';
            FieldClass = FlowField;
            TableRelation = "ACA-Programme".Code;
        }
        field(63102; "Programme Filter"; Code[20])
        {
            Caption = 'Programme Filter';
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;

        }
        field(63103; "Transfer to No."; Code[20])
        {
            Caption = 'Transfer to No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(63104; "Transfer to"; Code[20])
        {
            Caption = 'Transfer to';
            DataClassification = CustomerContent;
        }
        field(63106; "Stage Filter"; Code[20])
        {
            Caption = 'Stage Filter';
            FieldClass = FlowFilter;
        }
        field(63107; "Settlement Type Filter"; Code[20])
        {
            Caption = 'Settlement Type Filter';
            FieldClass = FlowFilter;
            TableRelation = "ACA-Settlement Type".Code;

        }
        field(63108; "Current Programme"; Code[20])
        {
            Caption = 'Current Programme';
            DataClassification = CustomerContent;
        }
        field(63109; "Registered PartTime"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FILTER('*04???*'),
                                                                 Programmes = FIELD("Student Programme")));
            FieldClass = FlowField;
        }
        field(63110; "Registered FullTime"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FILTER('<*04???*'),
                                                                 Programmes = FIELD("Student Programme")));
            FieldClass = FlowField;
        }

        field(63111; "Total Registered"; Integer)
        {
            Caption = 'Total Registered';
            DataClassification = CustomerContent;
        }
        field(63112; "Paid PartTime"; Integer)
        {
            Caption = 'Paid PartTime';
            DataClassification = CustomerContent;
        }
        field(63113; "Hostel Black Listed"; Boolean)
        {
            Caption = 'Hostel Black Listed';
            DataClassification = CustomerContent;
        }
        field(63114; "Black Listed Reason"; Text[20])
        {
            Caption = 'Black Listed Reason';
            DataClassification = CustomerContent;
        }
        field(63115; "Black Listed By"; Code[20])
        {
            Caption = 'Black Listed By';
            DataClassification = CustomerContent;
        }
        field(63116; "Audit Issue"; Boolean)
        {
            Caption = 'Audit Issue';
            DataClassification = CustomerContent;
        }
        field(63117; "Not Billed"; Boolean)
        {
            Caption = 'Not Billed';
            DataClassification = CustomerContent;
        }
        field(63118; "New Stud"; Boolean)
        {
            Caption = 'New Stud';
            DataClassification = CustomerContent;
        }
        field(63119; "Programme Category Filter"; Option)
        {
            Caption = 'Programme Category Filter';
            OptionMembers = " ";
            FieldClass = FlowFilter;
        }
        field(63120; sms_Password; Text[15])
        {
            Caption = 'sms_Password';
            DataClassification = CustomerContent;
        }
        field(63121; "BroadCast Filter"; Code[20])
        {
            Caption = 'BroadCast Filter';
            FieldClass = FlowFilter;
        }
        field(63122; "In Current Sem"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63123; "Current Settlement Type"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Settlement Type" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63124; "Current Stage"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Stage WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63125; "Intake Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Intake".Code;
        }
        field(63126; "Exam Period Filter"; Code[20])
        {
            Caption = 'Exam Period Filter';
            FieldClass = FlowFilter;
        }
        field(63127; "Lock Online Application"; Boolean)
        {
            Caption = 'Lock Online Application';
            DataClassification = CustomerContent;
        }
        field(63128; "PIN No"; Code[20])
        {
            Caption = 'PIN No';
            DataClassification = CustomerContent;
        }
        field(63129; "Allow Reg. With Balance"; Boolean)
        {
            Caption = 'Allow Reg. With Balance';
            DataClassification = CustomerContent;
        }
        field(63130; "Allowed Reg. By"; Code[20])
        {
            Caption = 'Allowed Reg. By';
            DataClassification = CustomerContent;
        }
        field(63131; "Allowed Date"; Date)
        {
            Caption = 'Allowed Date';
            DataClassification = CustomerContent;
        }
        field(63132; "Current Program"; Code[20])
        {
            Caption = 'Current Program';
            DataClassification = CustomerContent;
        }
        field(63133; "Current Semester"; Code[20])
        {
            Caption = 'Current Semester';
            DataClassification = CustomerContent;
        }
        field(63134; "ID Card Expiry Year"; Integer)
        {
            Caption = 'ID Card Expiry Year';
            DataClassification = CustomerContent;
        }
        field(63135; Tribe; Code[20])
        {
            Caption = 'Tribe';
            DataClassification = CustomerContent;
        }
        field(63136; "Barcode Picture"; BLOB)
        {
            Caption = 'Barcode Picture';
            DataClassification = CustomerContent;
        }
        field(63137; "Graduation Date"; Date)
        {
            Caption = 'Graduation Date';
            DataClassification = CustomerContent;
        }
        field(63138; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            DataClassification = CustomerContent;
            TableRelation = "ACA-Course Classes".Code;

        }
        field(63139; "Course Details"; Text[20])
        {
            Caption = 'Course Details';
            DataClassification = CustomerContent;
        }
        field(63140; "Sponsor Name"; Text[20])
        {
            Caption = 'Sponsor Name';
            DataClassification = CustomerContent;
        }
        field(63141; School; Code[20])
        {
            Caption = 'School';
            DataClassification = CustomerContent;
        }
        field(63142; "Study Mode"; Option)
        {
            Caption = 'Study Mode';
            OptionMembers = " ";
            DataClassification = CustomerContent;
        }
        field(63143; "Course Duration"; Integer)
        {
            Caption = 'Course Duration';
            DataClassification = CustomerContent;
        }
        field(63144; "Admission Date"; Date)
        {
            Caption = 'Admission Date';
            DataClassification = CustomerContent;
        }
        field(63145; "Hostel Allocated"; Boolean)
        {
            Caption = 'Hostel Allocated';
            DataClassification = CustomerContent;
        }
        field(63146; "Hostel No."; Code[20])
        {
            Caption = 'Hostel No.';
            DataClassification = CustomerContent;
        }
        field(63147; "Room Code"; Code[20])
        {
            Caption = 'Room Code';
            DataClassification = CustomerContent;
        }
        field(63148; "Space Booked"; Code[20])
        {
            Caption = 'Space Booked';
            DataClassification = CustomerContent;
        }
        field(63149; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(63150; Semester; Code[20])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(63151; "Library Security"; Integer)
        {
            Caption = 'Library Security';
            DataClassification = CustomerContent;
        }
        field(63152; "Library Username"; Text[20])
        {
            Caption = 'Library Username';
            DataClassification = CustomerContent;
        }
        field(63153; "Library Category"; Code[20])
        {
            Caption = 'Library Category';
            DataClassification = CustomerContent;
            TableRelation = "ACA-Library Codes"."Lib Code";

            trigger OnValidate()
            begin
                LibCode.GET("Library Category");
                "Library Expiry Date" := TODAY + LibCode."Expiry Duration";
            end;
        }
        field(63154; "Library Expiry Date"; Date)
        {
            Caption = 'Library Expiry Date';
            DataClassification = CustomerContent;
        }
        field(63155; "Old Status"; Code[20])
        {
            Caption = 'Old Status';
            DataClassification = CustomerContent;
        }
        field(63156; "Sponsor Address"; Text[20])
        {
            Caption = 'Sponsor Address';
            DataClassification = CustomerContent;
        }
        field(63157; "Sponsor Town"; Text[20])
        {
            Caption = 'Sponsor Town';
            DataClassification = CustomerContent;
        }
        field(63158; "Sponsor Phone"; Text[20])
        {
            Caption = 'Sponsor Phone';
            DataClassification = CustomerContent;
        }
        field(63159; "Changed Password"; Boolean)
        {
            Caption = 'Changed Password';
            DataClassification = CustomerContent;
        }
        field(63160; "Catering Amount"; Decimal)
        {
            Caption = 'Catering Amount';
            DataClassification = CustomerContent;
        }
        field(63161; "Clearance Status"; Option)
        {
            Caption = 'Clearance Status';
            OptionMembers = open,Active,Cleared;
            DataClassification = CustomerContent;
        }
        field(63162; "Clearance Initiated by"; Code[20])
        {
            Caption = 'Clearance Initiated by';
            DataClassification = CustomerContent;
        }
        field(63163; "Clearance Initiated Date"; Date)
        {
            Caption = 'Clearance Initiated Date';
            DataClassification = CustomerContent;
        }
        field(63164; "Clearance Initiated Time"; Time)
        {
            Caption = 'Clearance Initiated Time';
            DataClassification = CustomerContent;
        }
        field(63165; "Clearance Semester"; Code[20])
        {
            Caption = 'Clearance Semester';
            DataClassification = CustomerContent;
            TableRelation = "ACA-Semesters".Code;

        }
        field(63166; "Clearance Academic Year"; Code[20])
        {
            Caption = 'Clearance Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "ACA-Academic Year".Code;

        }
        field(63167; "Intake Code"; Code[20])
        {
            Caption = 'Intake Code';
            DataClassification = CustomerContent;
        }
        field(63168; "Programme End Date"; Date)
        {
            Caption = 'Programme End Date';
            DataClassification = CustomerContent;
        }
        field(63169; "Applied for Clearance"; Boolean)
        {
            Caption = 'Applied for Clearance';
            DataClassification = CustomerContent;
        }
        field(63170; "Clearance Reason"; Option)
        {
            Caption = 'Clearance Reason';
            OptionMembers = " ",Graduation,Suspension,Transfer;
            DataClassification = CustomerContent;
        }
        field(63171; "Refund on PV"; Decimal)
        {
            Caption = 'Refund on PV';
            DataClassification = CustomerContent;
        }
        field(63175; "Library Gender"; Code[20])
        {
            Caption = 'Library Gender';
            DataClassification = CustomerContent;
        }
        field(63176; "Library Branch"; Code[20])
        {
            Caption = 'Library Branch';
            DataClassification = CustomerContent;
        }
        field(63177; "Current Faculty"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."School Code" WHERE(Code = FIELD("Current Programme")));
            FieldClass = FlowField;
        }
        field(63178; "Charges Amount"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges".Amount WHERE("Student No." = FIELD("No."),
                                                              Semester = FIELD("Semester Filter"),
                                                              Code = FIELD("Charge Filter")));
            FieldClass = FlowField;
        }
        field(63179; "Charge Filter"; Code[20])
        {
            Caption = 'Charge Filter';
            FieldClass = FlowFilter;
            TableRelation = "ACA-Charge".Code;

        }
        field(63180; Programme; Text[200])
        {
            CalcFormula = Lookup("ACA-Course Registration".Programmes where("Student No." = field("No.")));
            FieldClass = FlowField;
        }
        field(63181; "Student Balance"; Decimal)
        {
            Caption = 'Student Balance';
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            FieldClass = FlowField;
        }
        field(63182; "Comp No"; Code[20])
        {
            Caption = 'Comp No';
            DataClassification = CustomerContent;
        }
        field(63183; "Spouce Name"; Text[70])
        {
            Caption = 'Spouce Name';
            DataClassification = CustomerContent;
        }
        field(63184; "Spouse Id"; Code[20])
        {
            Caption = 'Spouse Id';
            DataClassification = CustomerContent;
        }
        field(63185; "Spouse Phone"; Code[20])
        {
            Caption = 'Spouse Phone';
            DataClassification = CustomerContent;
        }
        field(63186; Countings; Integer)
        {
            Caption = 'Countings';
            DataClassification = CustomerContent;
        }
        field(63187; "Settlement Type"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Settlement Type" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63188; "First Name"; Text[50])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
        }
        field(63189; "Middle Name"; Text[50])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;
        }
        field(63190; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
        }
        field(63191; "Updated Profile"; Boolean)
        {
            Caption = 'Updated Profile';
            DataClassification = CustomerContent;
        }
        field(63192; "Disability Status"; option)
        {
            Caption = 'Disability Status';
            OptionMembers = " ",Yes,No;
        }
        field(63193; "Disability Description"; Text[30])
        {
            Caption = 'Disability Description';
            DataClassification = CustomerContent;
        }
        field(63194; "Campus Code"; Code[50])
        {
            Caption = 'Campus Code';
            DataClassification = CustomerContent;
        }
        field(63195; "Senate Classification Based on"; Option)
        {
            Caption = 'Senate Classification Based on';
            FieldClass = FlowField;
            calcformula = Lookup("Dimension Value"."Senate Classification Based on" WHERE(Code = FIELD("Global Dimension 1 Code")));
            OptionMembers = " ","Year of Study","Academic Year";
        }
        field(63196; "Programme Category"; Option)
        {
            Caption = 'Programme Category';
            OptionMembers = " ";
            DataClassification = CustomerContent;
        }
        field(63197; "In Graduation"; Boolean)
        {
            Caption = 'In Graduation';
            DataClassification = CustomerContent;
        }
        field(63198; "Tagged as Graduating"; Boolean)
        {
            CalcFormula = Lookup("ACA-Classification Students".Graduating WHERE("Student Number" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63199; "Graduating Academic Year"; Code[20])
        {
            CalcFormula = Lookup("ACA-Classification Students"."Graduation Academic Year" WHERE("Student Number" = FIELD("No."),
                                                                                                 Graduating = FILTER(true)));
            FieldClass = FlowField;
        }
        field(63200; "Cumm. Failed Courses"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Passed Unit" = FILTER(false),
                                                           "Reg. Reversed" = FILTER(false),
                                                           "Student No." = FIELD("No."),
                                                           "EXAMs Marks Exists" = FILTER(true),
                                                           "Pass Exists" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(63202; studentType; Option)
        {
            OptionMembers = KUCCPS,SSP;
        }
        field(63203; "Registar Cleared"; Boolean)
        {

        }
        field(63204; "Cafe Balance"; Decimal)
        {
            CalcFormula = sum("CAFE Studentledger".Amount where(StudentId = field("No.")));
            FieldClass = FlowField;
        }
        field(63205; "University Email"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(63206; "Email Password"; Text[200])
        {
            DataClassification = ToBeClassified;

        }
        //Club Engagement Score
        field(63207; "Club Engagement Score"; Decimal)
        {
        }
        field(63208; "Leave Usage"; Decimal)
        {
            Caption = 'Leave Usage (Days)';
            Editable = false;
        }
        field(63209; "Counseling Sessions"; Integer)
        {
            Caption = 'Counseling Sessions';
            Editable = false;
        }

        field(63210; "Last Engagement Date"; Date)
        {
            Caption = 'Last Engagement Date';
        }
        field(63211; "Total Donations"; Decimal)
        {
            Caption = 'Total Donations';
            FieldClass = FlowField;
            CalcFormula = sum(Donation.Amount where("Donor No." = field("No.")));
        }
        field(63212; "Supervisor No."; Code[25])
        {
            TableRelation = "HRM-Employee C" where(Lecturer = const(true));

        }


        modify("No.")
        {
            Caption = 'No.';
        }
        modify(Name)
        {

            //Unsupported feature: Property Modification (Data type) on "Name(Field 2)".

            Caption = 'Name';
        }
        modify("Search Name")
        {

            //Unsupported feature: Property Modification (Data type) on ""Search Name"(Field 3)".

            Caption = 'Search Name';
        }
        modify("Name 2")
        {
            Caption = 'Name 2';
        }
        modify(Address)
        {

            //Unsupported feature: Property Modification (Data type) on "Address(Field 5)".

            Caption = 'Address';
        }
        modify("Address 2")
        {
            Caption = 'Address 2';
        }
        modify(City)
        {
            Caption = 'City';
        }
        modify(Contact)
        {

            //Unsupported feature: Property Modification (Data type) on "Contact(Field 8)".

            Caption = 'Contact';
        }
        modify("Phone No.")
        {
            Caption = 'Phone No.';
        }
        modify("Telex No.")
        {
            Caption = 'Telex No.';
        }
        modify("Document Sending Profile")
        {
            Caption = 'Document Sending Profile';
        }
        modify("Our Account No.")
        {
            Caption = 'Our Account No.';
        }
        modify("Territory Code")
        {
            Caption = 'Territory Code';
        }
        modify("Global Dimension 1 Code")
        {
            TableRelation = "Dimension Value".Code; //WHERE ("Dimension Code"=FILTER("Department Code"));
            Caption = 'Global Dimension 1 Code';
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
        }
        modify("Chain Name")
        {
            Caption = 'Chain Name';
        }
        modify("Budgeted Amount")
        {
            Caption = 'Budgeted Amount';
        }
        modify("Credit Limit (LCY)")
        {
            Caption = 'Credit Limit ($)';
        }
        modify("Customer Posting Group")
        {
            Caption = 'Customer Posting Group';
        }
        modify("Currency Code")
        {
            Caption = 'Currency Code';
        }
        modify("Customer Price Group")
        {
            Caption = 'Customer Price Group';
        }
        modify("Language Code")
        {
            Caption = 'Language Code';
        }
        modify("Statistics Group")
        {
            Caption = 'Statistics Group';
        }
        modify("Payment Terms Code")
        {
            Caption = 'Payment Terms Code';
        }
        modify("Fin. Charge Terms Code")
        {
            Caption = 'Fin. Charge Terms Code';
        }
        modify("Salesperson Code")
        {
            Caption = 'Salesperson Code';
        }
        modify("Shipment Method Code")
        {
            Caption = 'Shipment Method Code';
        }
        modify("Shipping Agent Code")
        {
            Caption = 'Shipping Agent Code';
        }
        modify("Place of Export")
        {
            Caption = 'Place of Export';
        }
        modify("Invoice Disc. Code")
        {
            Caption = 'Invoice Disc. Code';
        }
        modify("Customer Disc. Group")
        {
            Caption = 'Customer Disc. Group';
        }
        modify("Country/Region Code")
        {
            Caption = 'Country/Region Code';
        }
        modify("Collection Method")
        {
            Caption = 'Collection Method';
        }
        modify(Amount)
        {
            Caption = 'Amount';
        }
        modify(Comment)
        {
            Caption = 'Comment';
        }
        modify(Blocked)
        {
            Caption = 'Blocked';

            // OptionCaption = 'Ship Invoice All';

        }
        modify("Invoice Copies")
        {
            Caption = 'Invoice Copies';
        }
        modify("Last Statement No.")
        {
            Caption = 'Last Statement No.';
        }
        modify("Print Statements")
        {
            Caption = 'Print Statements';
        }
        modify("Bill-to Customer No.")
        {
            Caption = 'Bill-to Customer No.';
        }
        modify(Priority)
        {
            Caption = 'Priority';
        }
        modify("Payment Method Code")
        {
            Caption = 'Payment Method Code';
        }
        modify("Last Modified Date Time")
        {
            Caption = 'Last Modified Date Time';
        }
        modify("Last Date Modified")
        {
            Caption = 'Last Date Modified';
        }
        modify("Date Filter")
        {
            Caption = 'Date Filter';
        }
        modify("Global Dimension 1 Filter")
        {
            Caption = 'Global Dimension 1 Filter';
        }
        modify("Global Dimension 2 Filter")
        {
            Caption = 'Global Dimension 2 Filter';
        }
        modify(Balance)
        {
            Caption = 'Balance';
        }
        modify("Balance (LCY)")
        {
            Caption = 'Balance ($)';
        }
        modify("Net Change")
        {
            Caption = 'Net Change';
        }
        modify("Net Change (LCY)")
        {
            Caption = 'Net Change ($)';
        }
        modify("Sales (LCY)")
        {
            Caption = 'Sales ($)';
        }
        modify("Profit (LCY)")
        {
            Caption = 'Profit ($)';
        }
        modify("Inv. Discounts (LCY)")
        {
            Caption = 'Inv. Discounts ($)';
        }
        modify("Pmt. Discounts (LCY)")
        {
            Caption = 'Pmt. Discounts ($)';
        }
        modify("Balance Due")
        {
            Caption = 'Balance Due';
        }
        modify("Balance Due (LCY)")
        {
            Caption = 'Balance Due ($)';
        }
        modify(Payments)
        {
            Caption = 'Payments';
        }
        modify("Invoice Amounts")
        {
            Caption = 'Invoice Amounts';
        }
        modify("Cr. Memo Amounts")
        {
            Caption = 'Cr. Memo Amounts';
        }
        modify("Finance Charge Memo Amounts")
        {
            Caption = 'Finance Charge Memo Amounts';
        }
        modify("Payments (LCY)")
        {
            Caption = 'Payments ($)';
        }
        modify("Inv. Amounts (LCY)")
        {
            Caption = 'Inv. Amounts ($)';
        }
        modify("Cr. Memo Amounts (LCY)")
        {
            Caption = 'Cr. Memo Amounts ($)';
        }
        modify("Fin. Charge Memo Amounts (LCY)")
        {
            Caption = 'Fin. Charge Memo Amounts ($)';
        }
        modify("Outstanding Orders")
        {
            Caption = 'Outstanding Orders';
        }
        modify("Shipped Not Invoiced")
        {
            Caption = 'Shipped Not Invoiced';
        }
        modify("Application Method")
        {
            Caption = 'Application Method';
#pragma warning disable AL0600
            OptionCaption = 'Manual,Apply to Oldest';
#pragma warning restore AL0600
        }
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including Tax';
        }
        modify("Location Code")
        {
            Caption = 'Location Code';
        }
        modify("Fax No.")
        {
            Caption = 'Fax No.';
        }
        modify("Telex Answer Back")
        {
            Caption = 'Telex Answer Back';
        }
        modify("VAT Registration No.")
        {
            Caption = 'Tax Registration No.';
        }
        modify("Combine Shipments")
        {
            Caption = 'Combine Shipments';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        /* modify(Picture)
        {
            Caption = 'Picture';
        } */
        modify(GLN)
        {
            Caption = 'GLN';
        }
        modify("Post Code")
        {
            Caption = 'ZIP Code';
        }
        modify(County)
        {

            //Unsupported feature: Property Modification (Data type) on "County(Field 92)".

            Caption = 'State';
        }
        modify("Debit Amount")
        {
            Caption = 'Debit Amount';
        }
        modify("Credit Amount")
        {
            Caption = 'Credit Amount';
        }
        modify("Debit Amount (LCY)")
        {
            Caption = 'Debit Amount ($)';
        }
        modify("Credit Amount (LCY)")
        {
            Caption = 'Credit Amount ($)';
        }
        modify("E-Mail")
        {
            Caption = 'Email';
        }
        modify("Home Page")
        {
            Caption = 'Home Page';
        }
        modify("Reminder Terms Code")
        {
            Caption = 'Reminder Terms Code';
        }
        modify("Reminder Amounts")
        {
            Caption = 'Reminder Amounts';
        }
        modify("Reminder Amounts (LCY)")
        {
            Caption = 'Reminder Amounts ($)';
        }
        modify("No. Series")
        {
            Caption = 'No. Series';
        }
        modify("Tax Area Code")
        {
            Caption = 'Tax Area Code';
        }
        modify("Tax Liable")
        {
            Caption = 'Tax Liable';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Tax Bus. Posting Group';
        }
        modify("Currency Filter")
        {
            Caption = 'Currency Filter';
        }
        modify("Outstanding Orders (LCY)")
        {
            Caption = 'Outstanding Orders ($)';
        }
        modify("Shipped Not Invoiced (LCY)")
        {
            Caption = 'Shipped Not Invoiced ($)';
        }
        modify(Reserve)
        {
            Caption = 'Reserve';
#pragma warning disable AL0600
            OptionCaption = 'Never,Optional,Always';
#pragma warning restore AL0600
        }
        modify("Block Payment Tolerance")
        {
            Caption = 'Block Payment Tolerance';
        }
        modify("Pmt. Disc. Tolerance (LCY)")
        {
            Caption = 'Pmt. Disc. Tolerance ($)';
        }
        modify("Pmt. Tolerance (LCY)")
        {
            Caption = 'Pmt. Tolerance ($)';
        }
        modify("IC Partner Code")
        {
            Caption = 'IC Partner Code';
        }
        modify(Refunds)
        {
            Caption = 'Refunds';
        }
        modify("Refunds (LCY)")
        {
            Caption = 'Refunds ($)';
        }
        modify("Other Amounts")
        {
            Caption = 'Other Amounts';
        }
        modify("Other Amounts (LCY)")
        {
            Caption = 'Other Amounts ($)';
        }
        modify("Prepayment %")
        {
            Caption = 'Prepayment %';
        }
        modify("Outstanding Invoices (LCY)")
        {
            Caption = 'Outstanding Invoices ($)';
        }
        modify("Outstanding Invoices")
        {
            Caption = 'Outstanding Invoices';
        }
        modify("Bill-to No. Of Archived Doc.")
        {
            Caption = 'No. Of Archived Doc.';
        }
        modify("Sell-to No. Of Archived Doc.")
        {
            Caption = 'Sell-to No. Of Archived Doc.';
        }
        modify("Partner Type")
        {
            Caption = 'Partner Type';
#pragma warning disable AL0600
            OptionCaption = ' ,Company,Person';
#pragma warning restore AL0600
        }
        modify(Image)
        {
            Caption = 'Image';
        }
        modify("Privacy Blocked")
        {
            Caption = 'Privacy Blocked';
        }
        modify("Preferred Bank Account Code")
        {
            Caption = 'Preferred Bank Account Code';
        }
        modify("Cash Flow Payment Terms Code")
        {
            Caption = 'Cash Flow Payment Terms Code';
        }
        modify("Primary Contact No.")
        {
            Caption = 'Primary Contact No.';
        }
        modify("Contact Type")
        {
            Caption = 'Contact Type';
#pragma warning disable AL0600
            OptionCaption = 'Company,Person';
#pragma warning restore AL0600
        }
        modify("Responsibility Center")
        {
            Caption = 'Responsibility Center';
        }
        modify("Shipping Advice")
        {
            Caption = 'Shipping Advice';
#pragma warning disable AL0600
            OptionCaption = 'Partial,Complete';
#pragma warning restore AL0600
        }
        modify("Shipping Time")
        {
            Caption = 'Shipping Time';
        }
        modify("Shipping Agent Service Code")
        {
            Caption = 'Shipping Agent Service Code';
        }
        modify("Service Zone Code")
        {
            Caption = 'Service Zone Code';
        }
        modify("Contract Gain/Loss Amount")
        {
            Caption = 'Contract Gain/Loss Amount';
        }
        modify("Ship-to Filter")
        {
            Caption = 'Ship-to Filter';
        }
        modify("Outstanding Serv. Orders (LCY)")
        {
            Caption = 'Outstanding Serv. Orders ($)';
        }
        modify("Serv Shipped Not Invoiced(LCY)")
        {
            Caption = 'Serv Shipped Not Invoiced($)';
        }
        modify("Outstanding Serv.Invoices(LCY)")
        {
            Caption = 'Outstanding Serv.Invoices($)';
        }
        modify("Allow Line Disc.")
        {
            Caption = 'Allow Line Disc.';
        }
        modify("No. of Quotes")
        {
            Caption = 'No. of Quotes';
        }
        modify("No. of Blanket Orders")
        {
            Caption = 'No. of Blanket Orders';
        }
        modify("No. of Orders")
        {
            Caption = 'No. of Orders';
        }
        modify("No. of Invoices")
        {
            Caption = 'No. of Invoices';
        }
        modify("No. of Return Orders")
        {
            Caption = 'No. of Return Orders';
        }
        modify("No. of Credit Memos")
        {
            Caption = 'No. of Credit Memos';
        }
        modify("No. of Pstd. Shipments")
        {
            Caption = 'No. of Pstd. Shipments';
        }
        modify("No. of Pstd. Invoices")
        {
            Caption = 'No. of Pstd. Invoices';
        }
        modify("No. of Pstd. Return Receipts")
        {
            Caption = 'No. of Pstd. Return Receipts';
        }
        modify("No. of Pstd. Credit Memos")
        {
            Caption = 'No. of Pstd. Credit Memos';
        }
        modify("No. of Ship-to Addresses")
        {
            Caption = 'No. of Ship-to Addresses';
        }
        modify("Bill-To No. of Quotes")
        {
            Caption = 'Bill-To No. of Quotes';
        }
        modify("Bill-To No. of Blanket Orders")
        {
            Caption = 'Bill-To No. of Blanket Orders';
        }
        modify("Bill-To No. of Orders")
        {
            Caption = 'Bill-To No. of Orders';
        }
        modify("Bill-To No. of Invoices")
        {
            Caption = 'Bill-To No. of Invoices';
        }
        modify("Bill-To No. of Return Orders")
        {
            Caption = 'Bill-To No. of Return Orders';
        }
        modify("Bill-To No. of Credit Memos")
        {
            Caption = 'Bill-To No. of Credit Memos';
        }
        modify("Bill-To No. of Pstd. Shipments")
        {
            Caption = 'Bill-To No. of Pstd. Shipments';
        }
        modify("Bill-To No. of Pstd. Invoices")
        {
            Caption = 'Bill-To No. of Pstd. Invoices';
        }
        modify("Bill-To No. of Pstd. Return R.")
        {
            Caption = 'Bill-To No. of Pstd. Return R.';
        }
        modify("Bill-To No. of Pstd. Cr. Memos")
        {
            Caption = 'Bill-To No. of Pstd. Cr. Memos';
        }
        modify("Base Calendar Code")
        {
            Caption = 'Base Calendar Code';
        }
        /*  modify("Copy Sell-to Addr. to Qte From")
         {
             Caption = 'Copy Sell-to Addr. to Qte From';
             OptionCaption = 'Company,Person';
         } */
        modify("Validate EU Vat Reg. No.")
        {
            Caption = 'Validate EU Tax Reg. No.';
        }
        /*  modify(Id)
         {
             Caption = 'Id';
         } */
        modify("Currency Id")
        {
            Caption = 'Currency Id';
        }
        modify("Payment Terms Id")
        {
            Caption = 'Payment Terms Id';
        }
        modify("Shipment Method Id")
        {
            Caption = 'Shipment Method Id';
        }
        modify("Payment Method Id")
        {
            Caption = 'Payment Method Id';
        }
        modify("Tax Area ID")
        {
            Caption = 'Tax Area ID';
        }
        // modify("Tax Area Display Name")
        // {
        //     Caption = 'Tax Area Display Name';
        // }
        modify("Contact ID")
        {
            Caption = 'Contact ID';
        }
        modify("Contact Graph Id")
        {
            Caption = 'Contact Graph Id';
        }


    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Primary Contact No."(Key)".

        //key(Key1;"Salesperson Code")
        // {
        // }
    }


    var
        Text10000: Label '%1 is not a valid RFC No.';
        Text10001: Label '%1 is not a valid CURP No.';
        Text10002: Label 'The RFC number %1 is used by another company.';

    var
        RecType: Option " ",GL,Cust,Item,Supp,FA,Emp,Sal,CourseReg,prTrans,EmpTrans;
        Cust: Record 18;

        GenSetUp: Record "ACA-General Set-Up";
        EducationHistory: Record "ACA-Student Education History";
        EnrollmentEducationHistory: Record "ACA-Enquiry Education History";
        StudentGuardian: Record "ACA-Student Sponsors Details";
        EnrollmentGuardian: Record "ACA-Enquiry Guardian/Sponsor";
        StudentKin: Record "ACA-Student Kin";
        EnrollmentNextofKin: Record "ACA-Enquiry Next Of Kin";
        CourseRegistration: Record "ACA-Course Registration";
        Enrollment: Record "ACA-Enquiry Header";
        PictureExists: Boolean;
        StudentRec: Record Customer;
        districtrec: Record "ACA-Applic. Setup County";
        Districtname: Text[50];
        LibCode: Record "ACA-Library Codes";
        SalesSetup: Record "Sales & Receivables Setup";
        ACAApplicFormHeader: Record "ACA-Applic. Form Header";
        CommentLine: Record "Order Address";
        SalesOrderLine: Record "Sales Line";
        CustBankAcc: Record "Customer Bank Account";
        ShipToAddr: Record "Ship-to Address";
        PostCode: Record "Post Code";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ShippingAgentService: Record "Shipping Agent Services";
        RMSetup: Record "Marketing Setup";
        SalesPrice: Record "Sales Price";
        SalesLineDisc: Record "Sales Line Discount";
        SalesPrepmtPct: Record "Sales Prepayment %";
        ServContract: Record "Service Contract Header";
        ServiceItem: Record "Service Item";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromCust: Codeunit "CustCont-Update";
        DimMgt: Codeunit DimensionManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InsertFromContact: Boolean;
        InsertFromTemplate: Boolean;
        LookupRequested: Boolean;
        ValidateUser: Codeunit "Validate User Permissions";

    procedure ValidateRFCNo(Length: Integer)
    begin
        IF STRLEN("RFC No.") <> Length THEN
            ERROR(Text10000, "RFC No.");
    end;

}
