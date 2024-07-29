tableextension 56601 "Customer Extension" extends Customer
{
    fields
    {
        // Add changes to table fields here

        field(56602; Age; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(56603; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(56604; Gender; Option)
        {
            //OptionCaption = 'Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(56605; "Marital Status"; Option)
        {
            OptionCaption = 'Single,Married';
            OptionMembers = Single,Married;
        }
        field(56606; "Blood Group"; Text[5])
        {
            DataClassification = ToBeClassified;
        }
        field(56607; Weight; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56608; Height; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56609; Religion; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(56610; Citizenship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(56611; "Payments By"; Text[150])
        {
            DataClassification = ToBeClassified;
        }

        field(56613; "Birth Cert"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56614; "Staff No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }


        field(56617; Password; Text[50])
        {

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

        field(63011; "ID No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Cust.RESET;
                Cust.SETRANGE(Cust."ID No", "ID No");
                IF Cust.FIND('-') THEN
                    ERROR('Passport/ID No. exists.');
            end;
        }
        field(63012; "Date Registered"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63013; "Membership No"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63014; "Customer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Customer,Student';
            OptionMembers = Customer,Student,Hotel;
        }

        field(63016; "UNISA No"; Code[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63018; "Old Student Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63019; "Name 3"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63020; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deferred,Suspended,Expulsion,Discontinued,Deceased,Transferred,Disciplinary,Unknown,Completed not graduated,Graduated no Certificates,Graduated with Certificate,Did Not Report,Absconded,Transferred from TMUC,Resit,Halt';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deferred,Suspended,Expulsion,Discontinued,Deceased,Transferred,Disciplinary,Unknown,"Completed not graduated","Graduated no Certificates","Graduated with Certificate","Did Not Report",Absconded,"Transferred from TMUC",Resit,Halt;


            trigger OnValidate()
            begin
                "Status Change Date" := TODAY;
            end;
        }

        field(63022; "Library Code"; Code[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63024; "KNEC No"; Code[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63025; "Passport No"; Code[1])
        {
            DataClassification = ToBeClassified;
        }

        field(63034; "Confirmed Ok"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "User ID" := USERID;
            end;
        }
        field(63035; "User ID"; Code[1])
        {
            DataClassification = ToBeClassified;
        }

        field(63038; "Library Membership"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'DIP IT,BSC IT,IMIS,KATC,CPACPS,ACCA,ABE,UNISA,BCOM,TEACHING STAFF,DIRECTORS,ADMIN STAFF,BR MATHS,IT,PACKAGES,DCEDHM';
            OptionMembers = "DIP IT","BSC IT",IMIS,KATC,CPACPS,ACCA,ABE,UNISA,BCOM,"TEACHING STAFF",DIRECTORS,"ADMIN STAFF","BR MATHS",IT,PACKAGES,DCEDHM;
        }
        field(63039; libsecurity; Text[1])
        {
            DataClassification = ToBeClassified;
        }

        field(63041; "Lib Membership"; Text[1])
        {
            DataClassification = ToBeClassified;
            Description = 'STORES THE STUDENTS LATEST LIBRARY MEMBSERSHIP CATEGORY - 12TH JUNE 2008 - TONY';
        }
        field(63042; "No Of Reversals"; Integer)
        {
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Customer No." = FIELD("No."),
                                                            Reversed = CONST(True)));
            FieldClass = FlowField;
        }
        field(63043; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Cust. Ledger Entry"."Document No.";
        }


        field(63048; "Programme Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }

        field(63051; "Accredited Centre no."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(63055; Adults; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 1;
        }
        field(63056; "Vehicle No."; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(63057; "Children Under 12"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63058; "Group/Company"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63059; "Departure Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63060; "Arrival Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63061; Nationality; Text[20])
        {
            DataClassification = ToBeClassified;
            InitValue = 'KENYAN';
        }
        field(63062; "Room no"; Code[6])
        {
            DataClassification = ToBeClassified;
        }
        field(63063; "Room Type"; Code[6])
        {
            DataClassification = ToBeClassified;
        }
        field(63064; "Receipt No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63065; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63066; Cashier; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63067; Deposit; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63068; "Payment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63069; Remarks; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63071; Singles; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63073; Doubles; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63074; Triples; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63075; "Taken By"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63076; "Checked By"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63078; "Check Out Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63079; "Check In Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(63080; "HTL Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,,Reserved,Current,Old;
        }
        field(63081; "HELB No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63082; "Deferement Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(63083; "Status Change Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63084; "Revenue Cash Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No." WHERE("Bank Acc. Posting Group" = CONST('CASH'));
        }

        field(63086; "Gown 1"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63087; "Gown 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63088; "Gown 3"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63089; "Date Issued"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63090; "Gown Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Loaned,Returned';
            OptionMembers = " ",Loaned,Returned;

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
            DataClassification = ToBeClassified;
        }
        field(63092; "Certificate Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Pending,Collected';
            OptionMembers = " ",Pending,Collected;

            trigger OnValidate()
            begin
                IF "Certificate Status" = "Certificate Status"::Collected THEN
                    "Date Collected" := TODAY;
            end;
        }
        field(63093; "Date Collected"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63094; Confirmed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63095; "Confirmed Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(63096; "Special Requrements"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63097; "Certificate No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(63099; "No Of Creidts"; Integer)
        {
            CalcFormula = Count("Detailed Cust. Ledg. Entry" WHERE("Customer No." = FIELD("No."),
                                                                    "Entry Type" = CONST("Initial Entry"),
                                                                    "Credit Amount (LCY)" = FILTER(> 0)));
            FieldClass = FlowField;
        }


        field(63103; "Transfer to No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63104; "Transfer to"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Transfer to';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(63106; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }

        field(63108; "Current Programme"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Auto populated on Billing';
        }

        field(63111; "Total Registered"; Integer)
        {
            FieldClass = Normal;
        }
        field(63112; "Paid PartTime"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63113; "Hostel Black Listed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63114; "Black Listed Reason"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63115; "Black Listed By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63116; "Audit Issue"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63117; "Not Billed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63118; "New Stud"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63119; "Programme Category Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ',Diploma,Undergraduate,Postgraduate,Course List';
            OptionMembers = ,Diploma,Undergraduate,Postgraduate,"Course List";
        }
        field(63120; sms_Password; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(63121; "BroadCast Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = GEN-sms_BroadCast.Code;
        }

        field(63127; "Lock Online Application"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63128; "PIN No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63129; "Allow Reg. With Balance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63130; "Allowed Reg. By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63131; "Allowed Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63132; "Current Program"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63133; "Current Semester"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63134; "ID Card Expiry Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63135; Tribe; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Tribes."Tribe Code";
        }
        field(63136; "Barcode Picture"; BLOB)
        {
            Caption = 'Picture';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(63137; "Graduation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(63139; "Course Details"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63140; "Sponsor Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63141; School; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('SCHOOL'));
        }
        field(63142; "Study Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Full Time,Part Time,Weekend,ODL,School Based,Evening';
            OptionMembers = " ","Full Time","Part Time",Weekend,ODL,"School Based",Evening;
        }
        field(63143; "Course Duration"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63144; "Admission Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(63151; "Library Security"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63152; "Library Username"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(63154; "Library Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63155; "Old Status"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63156; "Sponsor Address"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63157; "Sponsor Town"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63158; "Sponsor Phone"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63159; "Changed Password"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(63161; "Clearance Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'open,Active,Cleared';
            OptionMembers = open,Active,Cleared;
        }
        field(63162; "Clearance Initiated by"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63163; "Clearance Initiated Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63164; "Clearance Initiated Time"; Time)
        {
            DataClassification = ToBeClassified;
        }

        field(63167; "Intake Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63168; "Programme End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63169; "Applied for Clearance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63170; "Clearance Reason"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Graduation,Suspension,Transfer';
            OptionMembers = " ",Graduation,Suspension,Transfer;
        }
#pragma warning disable AL0717
        field(63171; "Refund on PV"; Decimal)
#pragma warning restore AL0717
        {
            //CalcFormula = Sum("FIN-Payment Line"."Net Amount" WHERE ("Account No."=FIELD("No."),
            //  Posted=CONST(No),
            //  "Payment Status"=CONST(Approved)));
            FieldClass = FlowField;
        }
        field(63175; "Library Gender"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63176; "Library Branch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }


        field(63181; "Student Balance"; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            FieldClass = FlowField;
        }
        field(63182; "Comp No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63183; "Spouce Name"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(63184; "Spouse Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63185; "Spouse Phone"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63186; Countings; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(63188; "Barcode/QR Code"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(63189; "Disability Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',None,Disabled';
            OptionMembers = ,"None",Disabled;
        }
        field(63190; "Updated Profile"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63191; "Disability Description"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63192; "Email Password"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63193; "University Email"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(63194; "Campus Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        /* field(63196; "Programme Category"; Option)
        {
            CalcFormula = Lookup("ACA-Course Registration"."Programme Category" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
            OptionCaption = ',Certificate ,Diploma,Undergraduate,Postgraduate,Professional,Course List';
            OptionMembers = ,"Certificate ",Diploma,Undergraduate,Postgraduate,Professional,"Course List";
        } */
        field(63197; "County of Origin"; Text[30])
        {
            DataClassification = ToBeClassified;
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

    // ValidateUser: Codeunit "61105";
}





