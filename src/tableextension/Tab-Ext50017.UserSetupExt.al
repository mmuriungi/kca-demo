tableextension 50017 UserSetupExt extends "User Setup"
{
    fields
    {
        field(50000; "Can Extend Surrender Period"; Boolean)
        {
            Caption = 'Can Extend Surrender Period';
            DataClassification = ToBeClassified;
        }
        field(500001; "Prn Notification"; Boolean)
        {
            Caption = 'Prn Notification';
            DataClassification = ToBeClassified;
        }
        field(500002; HOD; Boolean)
        {
            Caption = 'is Hod';
            DataClassification = ToBeClassified;
        }
        field(500003; "Accounting Officer"; Boolean)
        {
            Caption = 'Accounting Officer';
            DataClassification = ToBeClassified;
        }
        field(500004; "Proffessional OP"; Boolean)
        {
            Caption = ' Proffessional OP';
            DataClassification = ToBeClassified;
        }
        field(500005; "Raise LPOs"; Boolean)
        {
            Caption = '  "Raise LPOs"';
            DataClassification = ToBeClassified;
        }
        field(56601; "Leave"; Boolean)
        {

        }
        field(56602; "Can Post Customer Refund"; Boolean)
        {

        }
        field(56603; "Can Post Cust. Deposits"; Boolean)
        {

        }
        field(56667; "Allow Open My Settings"; Boolean)
        {
            Caption = 'Allow Open My Settings';
            DataClassification = CustomerContent;
        }
        field(56668; "Allow Change Role"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(56669; "Allow Change Company"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(56670; "Allow Change Work Day"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(56604; "Post Bank Rec"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56605; "Can Stop Reg."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56606; "Cash Advance Staff Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(56607; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "HRM-Employee C"."No.";
            //TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('IMPREST'));
        }
        field(56608; "ReOpen/Release"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",ReOpen,Release;
        }
        field(56609; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(56666; "Can View Payroll"; Boolean)
        {

        }
        field(56610; UserName; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56611; Approvername; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56612; Approvermail; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56613; "Job Tittle"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(56614; Department; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER(= 'DEPARTMENT'));
        }
        field(56615; "Campus Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER(= 'CAMPUS'));
        }
        field(56616; Lecturer; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56617; "Global Dimension 2 Code"; Code[20])
        {

            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(56618; "Responsibility Center"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(56619; "Shortcut Dimension 2 Code"; Code[20])
        {

            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(56620; "Approve Payroll Closure"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56621; "Edit Farmer Central Setup"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56622; "Phone No2."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56623; "Use Two Factor Authentication"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56624; "Can Reverse Sales"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56625; "Is Employee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56626; "Initiate Results Cancellation"; Boolean)
        {
            Editable = true;
        }
        field(56627; "Approve Results Cancellation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56628; "Revoke Results Cancellation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56629; "Can Archive Students"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56630; "Can Edit Semester"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56631; "Can Edit Academic Year"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56632; "Can Process Graduation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56633; "Can Process Senate Marks"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56634; "Can Upload Marks"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56635; "Payroll Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(56636; "Staff No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('IMPREST'));

            trigger OnValidate()
            begin
                /*IF Staff.GET("Staff No")THEN BEGIN
                UserName:=Staff."First Name"+' '+Staff."Middle Name"+' '+Staff."Last Name";
                "E-Mail":=Staff."Company E-Mail";
                "Global Dimension 1 Code":=Staff."Department Code";
                "Job Tittle":=Staff."Job Title";
                END*/

            end;
        }
        field(56637; "Edit Posted Dimensions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56638; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(56639; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(56640; "Unlimited PV Amount Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56641; "PV Amount Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56642; "Unlimited PettyAmount Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56643; "Petty C Amount Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56644; "Unlimited Imprest Amt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56645; "Imprest Amount Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56646; "Unlimited Store RqAmt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56647; "Store Req. Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56648; "Imprest Account"; code[20])
        {
            TableRelation = Customer."No." where("Customer Posting Group" = filter('Imprest'));
        }
        field(56649; "Global Dimension 1 Code"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(56650; tetst; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(56651; "Shortcut Dimension 3 Code"; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(56652; "Shortcut Dimension 4 Code"; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(56653; "User Signature"; Blob)
        {
            Subtype = Bitmap;

        }
        field(56654; "Approval Title"; Text[50])
        {

        }
        field(56665; "Approval Role"; Text[50])
        {

        }
        field(56655; "Create FA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56656; "Create Customer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56657; "Create Employee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56658; "Create Course_Reg"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56659; "Create GL"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56660; "Create Items"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56661; "Create Salary"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56662; "Create Supplier"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56663; "Create Emp. Transactions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56664; "Create PR Transactions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }





    }
}
