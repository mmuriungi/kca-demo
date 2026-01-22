table 52179084 "Legal Invoice"
{
    Caption = 'Legal Invoice';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Invoice No." <> xRec."Invoice No." then begin
                    LegalSetup.Get();
                    NoSeriesManagement.TestManual(LegalSetup."Legal Invoice Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Invoice Date"; Date)
        {
            Caption = 'Invoice Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            DataClassification = ToBeClassified;
            TableRelation = "Legal Case"."Case No.";
        }
        field(4; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if Vendor.Get("Vendor No.") then begin
                    "Vendor Name" := Vendor.Name;
                    "External Counsel" := Vendor.Name;
                end;
            end;
        }
        field(5; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
        }
        field(6; "External Counsel"; Text[100])
        {
            Caption = 'External Counsel';
            DataClassification = ToBeClassified;
        }
        field(7; "Service Type"; Option)
        {
            Caption = 'Service Type';
            OptionMembers = " ","Legal Consultation","Court Representation","Document Preparation","Research","Mediation","Arbitration","Expert Witness","Court Fees","Filing Fees","Other";
            OptionCaption = ' ,Legal Consultation,Court Representation,Document Preparation,Research,Mediation,Arbitration,Expert Witness,Court Fees,Filing Fees,Other';
            DataClassification = ToBeClassified;
        }
        field(8; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(9; "Hours Worked"; Decimal)
        {
            Caption = 'Hours Worked';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Amount (LCY)" := "Hours Worked" * "Hourly Rate";
                CalculateTotalAmount();
            end;
        }
        field(10; "Hourly Rate"; Decimal)
        {
            Caption = 'Hourly Rate';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Amount (LCY)" := "Hours Worked" * "Hourly Rate";
                CalculateTotalAmount();
            end;
        }
        field(11; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalculateTotalAmount();
            end;
        }
        field(12; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalculateTotalAmount();
            end;
        }
        field(13; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Payment Status"; Option)
        {
            Caption = 'Payment Status';
            OptionMembers = Pending,Approved,Posted,Paid,Cancelled;
            OptionCaption = 'Pending,Approved,Posted,Paid,Cancelled';
            DataClassification = ToBeClassified;
        }
        field(15; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = ToBeClassified;
        }
        field(16; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(17; "Budget Code"; Code[20])
        {
            Caption = 'Budget Code';
            DataClassification = ToBeClassified;
        }
        field(18; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Date Created"; DateTime)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(21; "Posted"; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(22; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
            DataClassification = ToBeClassified;
        }
        field(23; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(24; "General Ledger Entry No."; Integer)
        {
            Caption = 'General Ledger Entry No.';
            DataClassification = ToBeClassified;
        }
        field(25; "Expense Code"; Code[50])
        {
            Caption = 'Expense Code';
            DataClassification = ToBeClassified;
            TableRelation = "Expense Code".Code;
        }
    }

    keys
    {
        key(PK; "Invoice No.")
        {
            Clustered = true;
        }
        key(SK1; "Case No.", "Invoice Date")
        {
        }
        key(SK2; "Vendor No.", "Payment Status")
        {
        }
        key(SK3; "Department Code", "Invoice Date")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Invoice No." = '' then begin
            LegalSetup.Get();
            LegalSetup.TestField("Legal Invoice Nos.");
            NoSeriesManagement.InitSeries(LegalSetup."Legal Invoice Nos.", xRec."No. Series", 0D, "Invoice No.", "No. Series");
        end;
        
        "Created By" := UserId;
        "Date Created" := CurrentDateTime;
        "Invoice Date" := Today;
        "Due Date" := CalcDate('<30D>', "Invoice Date");
    end;

    local procedure CalculateTotalAmount()
    begin
        "Total Amount" := "Amount (LCY)" + "VAT Amount";
    end;

    var
        LegalSetup: Record "Legal Affairs Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
}