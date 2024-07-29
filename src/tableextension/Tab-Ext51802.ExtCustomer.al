tableextension 51802 "ExtCustomer" extends Customer
{
    Caption = 'Customer';
    LookupPageID = "Customer List";
    fields
    {
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

        field(63021; "Total Billed"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges".Amount WHERE("Student No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(63026; "Total Paid"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges"."Amount Paid" WHERE("Student No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(63030; "No. Of Receipts"; Integer)
        {
            CalcFormula = Count("ACA-Receipt" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }

        field(63037; "No Of Charges"; Integer)
        {
            CalcFormula = Count("ACA-Std Charges" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }

        field(63040; "Can Use Library"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'USED BY LIBRARY TO CHECK WETHER STUDENT EXISTS IN LIB SYSTEM - 12TH JUNE 2008 - TONY';

            trigger OnValidate()
            begin
                TESTFIELD("Library Category");
                "Library Security" := 1;
                MODIFY;
            end;
        }

        field(63046; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Semester".Code;
        }
        field(51801; "Senate Classification Based on"; Option)
        {
            CalcFormula = Lookup("Dimension Value"."Senate Classification Based on" WHERE(Code = FIELD("Global Dimension 1 Code")));
            FieldClass = FlowField;
            OptionCaption = ' ,Year of Study,Academic Year';
            OptionMembers = " ","Year of Study","Academic Year";
        }

        field(63050; "Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Enquiry Header"."Enquiry No." WHERE(Status = CONST(Eligible));

            trigger OnValidate()
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
                    //  Rec."Student Type" := FORMAT(Enrollment."Student Type");
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
                    //CourseRegistration."Student Type" := Enrollment."Student Type";
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
                            EducationHistory.From := EnrollmentEducationHistory.From;
                            EducationHistory."To" := EnrollmentEducationHistory."To";
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

        field(63052; "Unbilled Charged"; Integer)
        {
            CalcFormula = Count("ACA-Std Charges" WHERE("Student No." = FIELD("No."),
                                                         Recognized = CONST(false)));
            FieldClass = FlowField;
        }

        field(63098; "No. Of Reg"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }

        field(63100; District; Code[20])
        {
            DataClassification = ToBeClassified;
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
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }

        field(63107; "Settlement Type Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Settlement Type".Code;
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


        field(63138; "Class Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Course Classes".Code;
        }

        field(63145; "Hostel Allocated"; Boolean)
        {
            // CalcFormula = Exist("ACA-Hostel Ledger" WHERE("Student No" = FIELD("No.")));
            // FieldClass = FlowField;
        }
        field(63146; "Hostel No."; Code[20])
        {
            // CalcFormula = Lookup("ACA-Hostel Ledger"."Hostel No" WHERE("Student No" = FIELD("No.")));
            // FieldClass = FlowField;
        }
        field(63147; "Room Code"; Code[20])
        {
            // CalcFormula = Lookup("ACA-Hostel Ledger"."Room No" WHERE("Student No" = FIELD("No.")));
            // FieldClass = FlowField;
        }
        field(63148; "Space Booked"; Code[20])
        {
            // CalcFormula = Lookup("ACA-Hostel Ledger"."Space No" WHERE("Student No" = FIELD("No.")));
            // FieldClass = FlowField;
        }
        field(63149; "Academic Year"; Code[20])
        {
            // CalcFormula = Lookup("ACA-Hostel Ledger"."Academic Year" WHERE("Student No" = FIELD("No.")));
            // FieldClass = FlowField;
        }
        field(63150; Semester; Code[20])
        {
            // CalcFormula = Lookup("ACA-Hostel Ledger".Semester WHERE("Student No" = FIELD("No.")));
            // FieldClass = FlowField;
        }

        field(63153; "Library Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Library Codes"."Lib Code";

            trigger OnValidate()
            begin
                LibCode.GET("Library Category");
                "Library Expiry Date" := TODAY + LibCode."Expiry Duration";
            end;
        }

        field(63160; "Catering Amount"; Decimal)
        {
            // CalcFormula = Sum("CAT-Catering Prepayment Ledger".Amount WHERE("Customer No" = FIELD("No."),
            //                                                                  Date = FIELD("Date Filter")));
            // FieldClass = FlowField;
        }


        field(63165; "Clearance Semester"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Semesters".Code;
        }
        field(63166; "Clearance Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year".Code;
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
            FieldClass = FlowFilter;
            TableRelation = "ACA-Charge".Code;
        }
        field(63180; Programme; Text[200])
        {
            CalcFormula = Lookup("ACA-Course Registration".Programmes where("Student No." = field("No.")));
            FieldClass = FlowField;
        }

        field(63187; "Settlement Type"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Settlement Type" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
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
        field(63201; "Rent Deposit"; Decimal)
        {

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
        Cust: Record Customer;
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
    // ValidateUser: Codeunit "61105";
}

