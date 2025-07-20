table 52179082 "Legal Document"
{
    Caption = 'Legal Document';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Document No." <> xRec."Document No." then begin
                    LegalSetup.Get();
                    NoSeriesManagement.TestManual(LegalSetup."Document Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = " ",Charter,Statute,Policy,Procedure,Contract,"Court Filing","Legal Opinion",Settlement,Judgment,"Court Order",Correspondence,Evidence,Memorandum,Agreement,"Power of Attorney";
            OptionCaption = ' ,Charter,Statute,Policy,Procedure,Contract,Court Filing,Legal Opinion,Settlement,Judgment,Court Order,Correspondence,Evidence,Memorandum,Agreement,Power of Attorney';
            DataClassification = ToBeClassified;
        }
        field(3; "Document Title"; Text[100])
        {
            Caption = 'Document Title';
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            DataClassification = ToBeClassified;
            TableRelation = "Legal Case"."Case No.";
        }
        field(6; "Contract No."; Code[50])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = "Project Header"."No.";
        }
        field(7; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(8; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            DataClassification = ToBeClassified;
        }
        field(9; "Filed By"; Code[50])
        {
            Caption = 'Filed By';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(10; "File Path"; Text[250])
        {
            Caption = 'File Path';
            DataClassification = ToBeClassified;
        }
        field(11; "File Name"; Text[100])
        {
            Caption = 'File Name';
            DataClassification = ToBeClassified;
        }
        field(12; "File Extension"; Code[10])
        {
            Caption = 'File Extension';
            DataClassification = ToBeClassified;
        }
        field(13; "File Size (KB)"; Decimal)
        {
            Caption = 'File Size (KB)';
            DataClassification = ToBeClassified;
        }
        field(14; Keywords; Text[250])
        {
            Caption = 'Keywords';
            DataClassification = ToBeClassified;
        }
        field(15; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = ToBeClassified;
            InitValue = 1;
        }
        field(16; "Is Latest Version"; Boolean)
        {
            Caption = 'Is Latest Version';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(17; "Previous Version No."; Code[20])
        {
            Caption = 'Previous Version No.';
            DataClassification = ToBeClassified;
        }
        field(18; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(19; "Access Level"; Option)
        {
            Caption = 'Access Level';
            OptionMembers = Public,Internal,Confidential,"Highly Confidential";
            OptionCaption = 'Public,Internal,Confidential,Highly Confidential';
            DataClassification = ToBeClassified;
        }
        field(20; "Review Date"; Date)
        {
            Caption = 'Review Date';
            DataClassification = ToBeClassified;
        }
        field(21; "Reviewed By"; Code[50])
        {
            Caption = 'Reviewed By';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(22; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            OptionMembers = " ",Draft,"Pending Review",Approved,Rejected,Archived;
            OptionCaption = ' ,Draft,Pending Review,Approved,Rejected,Archived';
            DataClassification = ToBeClassified;
        }
        field(23; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Date Created"; DateTime)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Date Modified"; DateTime)
        {
            Caption = 'Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(28; "Document Blob"; Blob)
        {
            Caption = 'Document Blob';
            DataClassification = ToBeClassified;
        }
        field(29; "Is View Only"; Boolean)
        {
            Caption = 'Is View Only';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(30; Notes; Blob)
        {
            Caption = 'Notes';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
        key(SK1; "Case No.", "Document Type")
        {
        }
        key(SK2; "Contract No.")
        {
        }
        key(SK3; Keywords)
        {
        }
        key(SK4; "Document Date")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Document No." = '' then begin
            LegalSetup.Get();
            LegalSetup.TestField("Document Nos.");
            NoSeriesManagement.InitSeries(LegalSetup."Document Nos.", xRec."No. Series", 0D, "Document No.", "No. Series");
        end;
        
        "Created By" := UserId;
        "Date Created" := CurrentDateTime;
        "Document Date" := Today;
        "Is View Only" := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Date Modified" := CurrentDateTime;
    end;

    var
        LegalSetup: Record "Legal Affairs Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
}