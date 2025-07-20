table 52179100 "Legal Compliance Task"
{
    Caption = 'Legal Compliance Task';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Task No."; Code[20])
        {
            Caption = 'Task No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Task No." <> xRec."Task No." then begin
                    LegalSetup.Get();
                    NoSeriesManagement.TestManual(LegalSetup."Compliance Task Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Compliance Type"; Option)
        {
            Caption = 'Compliance Type';
            OptionMembers = " ","Employment Law","Data Privacy","Health and Safety","Environmental","Financial Reporting","Tax Compliance","Licensing","Corporate Governance","Academic Regulations","Anti-Corruption";
            OptionCaption = ' ,Employment Law,Data Privacy,Health and Safety,Environmental,Financial Reporting,Tax Compliance,Licensing,Corporate Governance,Academic Regulations,Anti-Corruption';
            DataClassification = ToBeClassified;
        }
        field(3; "Task Description"; Text[250])
        {
            Caption = 'Task Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Regulation/Law"; Text[100])
        {
            Caption = 'Regulation/Law';
            DataClassification = ToBeClassified;
        }
        field(5; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = ToBeClassified;
        }
        field(6; "Assigned To"; Code[20])
        {
            Caption = 'Assigned To';
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"In Progress",Completed,Overdue,"Non-Compliant";
            OptionCaption = 'Open,In Progress,Completed,Overdue,Non-Compliant';
            DataClassification = ToBeClassified;
        }
        field(8; Priority; Option)
        {
            Caption = 'Priority';
            OptionMembers = " ",Low,Medium,High,Critical;
            OptionCaption = ' ,Low,Medium,High,Critical';
            DataClassification = ToBeClassified;
        }
        field(9; "Completion Date"; Date)
        {
            Caption = 'Completion Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(11; "Risk Level"; Option)
        {
            Caption = 'Risk Level';
            OptionMembers = " ",Low,Medium,High,Critical;
            OptionCaption = ' ,Low,Medium,High,Critical';
            DataClassification = ToBeClassified;
        }
        field(12; "Penalty Amount"; Decimal)
        {
            Caption = 'Penalty Amount';
            DataClassification = ToBeClassified;
        }
        field(13; "Frequency"; Option)
        {
            Caption = 'Frequency';
            OptionMembers = " ","One-Time",Daily,Weekly,Monthly,Quarterly,"Semi-Annually",Annually;
            OptionCaption = ' ,One-Time,Daily,Weekly,Monthly,Quarterly,Semi-Annually,Annually';
            DataClassification = ToBeClassified;
        }
        field(14; "Next Review Date"; Date)
        {
            Caption = 'Next Review Date';
            DataClassification = ToBeClassified;
        }
        field(15; "Evidence Required"; Text[250])
        {
            Caption = 'Evidence Required';
            DataClassification = ToBeClassified;
        }
        field(16; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Date Created"; DateTime)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(19; "Contract No."; Code[50])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = "Project Header"."No.";
        }
        field(20; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            DataClassification = ToBeClassified;
            TableRelation = "Legal Case"."Case No.";
        }
        field(21; Notes; Blob)
        {
            Caption = 'Notes';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Task No.")
        {
            Clustered = true;
        }
        key(SK1; "Due Date", Status)
        {
        }
        key(SK2; "Assigned To", Status)
        {
        }
        key(SK3; "Compliance Type", "Department Code")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Task No." = '' then begin
            LegalSetup.Get();
            LegalSetup.TestField("Compliance Task Nos.");
            NoSeriesManagement.InitSeries(LegalSetup."Compliance Task Nos.", xRec."No. Series", 0D, "Task No.", "No. Series");
        end;
        
        "Created By" := UserId;
        "Date Created" := CurrentDateTime;
    end;

    var
        LegalSetup: Record "Legal Affairs Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
}