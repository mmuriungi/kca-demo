table 50133 "Credit Management Setup"
{
    Caption = 'Credit Management Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Assumption Nos"; Code[20])
        {
            Caption = 'Assumption Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(3; "Application Nos"; Code[20])
        {
            Caption = 'Application Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(4; "Loan Nos"; Code[20])
        {
            Caption = 'Loan Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(5; "Loan Disbursement Nos"; Code[20])
        {
            Caption = 'Loan Disbursement Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6; "Credit Scoring Nos"; Code[20])
        {
            Caption = 'Credit Scoring Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(7; "Loan Interest Nos"; Code[20])
        {
            Caption = 'Loan Interest Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(8; "Loan Penalty Nos"; Code[20])
        {
            Caption = 'Loan Penalty Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(9; "No. of Days in Year"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Loan Disbursement Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(11; "Loan Interest Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(12; "Loan Penalty Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(13; "Loan Receipt Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(14; "Default PML Posting Group"; Code[20])
        {
            TableRelation = "Customer Posting Group";
        }
        field(15; "Statement Template Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(16; "Shareholding Setup Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(17; "Risk Profile Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(18; "Enforce Credit Limit"; Boolean)
        {
        }
        field(19; "Max Phone No Characters"; Integer)
        {

        }
        field(20; "Credit Limit Amount Type"; enum "Credit Limit Amount Type")
        {

        }
        field(21; "Check Collateral Commitment"; Boolean)
        {

        }
        field(22; "Residential Mortgage Nos"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(23; "Loan Collateral Nos"; code[10])
        {
            TableRelation = "No. Series";
        }
        field(24; "Loan Offer Letter"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Loan ESR"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Signatory 1 No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            trigger Onvalidate()
            var
                Emp: Record Employee;
            begin
                Emp.Reset();
                Emp.SetRange("No.", "Signatory 1 No.");
                if emp.Find('-') then begin
                    "Signatory 1 designation" := Emp."Job Position Title";
                    "Signatory 1 Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                end;
            end;
        }
        field(27; "Signatory 1 Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Signatory 1 designation"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Signatory 2 No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            trigger Onvalidate()
            var
                Emp: Record Employee;
            begin
                Emp.Reset();
                Emp.SetRange("No.", "Signatory 2 No.");
                if emp.Find('-') then begin
                    "Signatory 2 designation" := Emp."Job Position Title";
                    "Signatory 2 Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                end;
            end;
        }
        field(30; "Signatory 2 Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Signatory 2 designation"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Statement Notes"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "PML Change Request Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(34; "Automatically Post Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "VAT Product Posting Group"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
            DataClassification = ToBeClassified;
        }
        field(36; "Receipt Amounts Exclusive VAT"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}
