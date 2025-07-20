table 52179080 "Legal Case"
{
    Caption = 'Legal Case';
    DataClassification = ToBeClassified;
    DrillDownPageID = "Legal Case List";
    LookupPageID = "Legal Case List";

    fields
    {
        field(1; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Case No." <> xRec."Case No." then begin
                    LegalSetup.Get();
                    NoSeriesManagement.TestManual(LegalSetup."Case Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Case Type"; Option)
        {
            Caption = 'Case Type';
            OptionMembers = " ","Internal Legal Issue",Litigation,"Contract Dispute","Intellectual Property","Labor Law","Criminal","Civil","Administrative","Constitutional";
            OptionCaption = ' ,Internal Legal Issue,Litigation,Contract Dispute,Intellectual Property,Labor Law,Criminal,Civil,Administrative,Constitutional';
            DataClassification = ToBeClassified;
        }
        field(3; "Case Title"; Text[100])
        {
            Caption = 'Case Title';
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Case Category"; Option)
        {
            Caption = 'Case Category';
            OptionMembers = " ","Contract Law","Labor Law","Intellectual Property","Regulatory Compliance","Student Affairs","Employment Law","Property Law","Criminal Law","Civil Law";
            OptionCaption = ' ,Contract Law,Labor Law,Intellectual Property,Regulatory Compliance,Student Affairs,Employment Law,Property Law,Criminal Law,Civil Law';
            DataClassification = ToBeClassified;
        }
        field(6; "Filing Date"; Date)
        {
            Caption = 'Filing Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Court Name"; Text[100])
        {
            Caption = 'Court Name';
            DataClassification = ToBeClassified;
        }
        field(8; "Court File Number"; Code[50])
        {
            Caption = 'Court File Number';
            DataClassification = ToBeClassified;
        }
        field(9; "Case Status"; Option)
        {
            Caption = 'Case Status';
            OptionMembers = Open,"In Progress","Awaiting Response",Closed,Ongoing,Settled,"Under Appeal",Withdrawn;
            OptionCaption = 'Open,In Progress,Awaiting Response,Closed,Ongoing,Settled,Under Appeal,Withdrawn';
            DataClassification = ToBeClassified;
        }
        field(10; Priority; Option)
        {
            Caption = 'Priority';
            OptionMembers = " ",Low,Medium,High,Urgent;
            OptionCaption = ' ,Low,Medium,High,Urgent';
            DataClassification = ToBeClassified;
        }
        field(11; "Plaintiff/Claimant"; Text[100])
        {
            Caption = 'Plaintiff/Claimant';
            DataClassification = ToBeClassified;
        }
        field(12; "Defendant/Respondent"; Text[100])
        {
            Caption = 'Defendant/Respondent';
            DataClassification = ToBeClassified;
        }
        field(13; "Lead Counsel"; Code[20])
        {
            Caption = 'Lead Counsel';
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";
        }
        field(14; "External Counsel"; Text[100])
        {
            Caption = 'External Counsel';
            DataClassification = ToBeClassified;
        }
        field(15; "External Counsel Firm"; Text[100])
        {
            Caption = 'External Counsel Firm';
            DataClassification = ToBeClassified;
        }
        field(16; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(17; "Next Court Date"; Date)
        {
            Caption = 'Next Court Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Next Court Date" <> 0D then
                    "Court Date Reminder" := CalcDate('-1W', "Next Court Date");
            end;
        }
        field(18; "Court Date Reminder"; Date)
        {
            Caption = 'Court Date Reminder';
            DataClassification = ToBeClassified;
        }
        field(19; "Case Outcome"; Text[250])
        {
            Caption = 'Case Outcome';
            DataClassification = ToBeClassified;
        }
        field(20; "Settlement Amount"; Decimal)
        {
            Caption = 'Settlement Amount';
            DataClassification = ToBeClassified;
        }
        field(21; "Judgment Date"; Date)
        {
            Caption = 'Judgment Date';
            DataClassification = ToBeClassified;
        }
        field(22; "Appeal Filed"; Boolean)
        {
            Caption = 'Appeal Filed';
            DataClassification = ToBeClassified;
        }
        field(23; "Appeal Date"; Date)
        {
            Caption = 'Appeal Date';
            DataClassification = ToBeClassified;
        }
        field(24; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Date Created"; DateTime)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Date Modified"; DateTime)
        {
            Caption = 'Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(29; "Estimated Costs"; Decimal)
        {
            Caption = 'Estimated Costs';
            DataClassification = ToBeClassified;
        }
        field(30; "Actual Costs"; Decimal)
        {
            Caption = 'Actual Costs';
            FieldClass = FlowField;
            CalcFormula = Sum("Legal Invoice"."Total Amount" WHERE("Case No." = FIELD("Case No.")));
        }
        field(31; "Risk Level"; Option)
        {
            Caption = 'Risk Level';
            OptionMembers = " ",Low,Medium,High,Critical;
            OptionCaption = ' ,Low,Medium,High,Critical';
            DataClassification = ToBeClassified;
        }
        field(32; "Contract Reference No."; Code[50])
        {
            Caption = 'Contract Reference No.';
            DataClassification = ToBeClassified;
            TableRelation = "Project Header"."No.";
        }
        field(33; "Case History"; Blob)
        {
            Caption = 'Case History';
            DataClassification = ToBeClassified;
        }
        field(34; "Internal Notes"; Blob)
        {
            Caption = 'Internal Notes';
            DataClassification = ToBeClassified;
        }
        field(35; "Opposing Counsel"; Text[100])
        {
            Caption = 'Opposing Counsel';
            DataClassification = ToBeClassified;
        }
        field(36; "Opposing Counsel Contact"; Text[100])
        {
            Caption = 'Opposing Counsel Contact';
            DataClassification = ToBeClassified;
        }
        field(37; "Judge/Magistrate"; Text[100])
        {
            Caption = 'Judge/Magistrate';
            DataClassification = ToBeClassified;
        }
        field(38; "Claim Amount"; Decimal)
        {
            Caption = 'Claim Amount';
            DataClassification = ToBeClassified;
        }
        field(39; "Case Closed Date"; Date)
        {
            Caption = 'Case Closed Date';
            DataClassification = ToBeClassified;
        }
        field(40; "Notice Type"; Option)
        {
            Caption = 'Notice Type';
            OptionMembers = " ",Plaint,Claim,"Notice of Motion",Petition,"Counter Claim",Appeal,Application;
            OptionCaption = ' ,Plaint,Claim,Notice of Motion,Petition,Counter Claim,Appeal,Application';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Case No.")
        {
            Clustered = true;
        }
        key(SK1; "Case Status", Priority)
        {
        }
        key(SK2; "Department Code", "Case Type")
        {
        }
        key(SK3; "Next Court Date")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Case No." = '' then begin
            LegalSetup.Get();
            LegalSetup.TestField("Case Nos.");
            NoSeriesManagement.InitSeries(LegalSetup."Case Nos.", xRec."No. Series", 0D, "Case No.", "No. Series");
        end;
        
        "Created By" := UserId;
        "Date Created" := CurrentDateTime;
        "Filing Date" := Today;
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