table 54307 "Feedback Header"
{
    Caption = 'Feedback Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CorporateAffairsSetup.Get();
                    NoSeriesMgt.TestManual(CorporateAffairsSetup."Feedback No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Is Internal"; Boolean)
        {
            Caption = 'Is Internal';
            DataClassification = ToBeClassified;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee (D)";
            trigger OnValidate()
            var
                Employee: Record "HRM-Employee (D)";
            begin
                if Employee.Get("Employee No.") then begin
                    "Employee Name" := Employee.FullName();
                    "Contact No." := Employee."Company E-Mail";
                end;
            end;
        }
        field(4; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; "FeedBack Summary "; Text[250])
        {
            Caption = 'FeedBack Summary ';
            DataClassification = ToBeClassified;
        }
        field(6; "Document Attacheed "; Boolean)
        {
            Caption = 'Document Attacheed ';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Document Attachment" where("No." = field("No.")));
        }
        field(7; "Created By"; Code[20])
        {
            Caption = 'Created By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
        }
        field(9; "Complaint Date"; Date)
        {
            Caption = 'Complaint Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Incharge Summary comment"; Text[250])
        {
            Caption = 'Incharge Summary comment';
            DataClassification = ToBeClassified;
        }
        field(11; "Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            DataClassification = ToBeClassified;
        }
        field(12; "Contact No."; Text[20])
        {

        }
        field(13; "Customer Name"; Text[100])
        {
            Editable = true;
            DataClassification = ToBeClassified;
        }
        field(14; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(15; "Satisfactory Level"; Option)
        {
            OptionMembers = "1","2","3","4","5";
            DataClassification = ToBeClassified;

        }
        field(16; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin

        "Created By" := UserId;
        if "No." = '' then begin
            CorporateAffairsSetup.Get();
            CorporateAffairsSetup.TestField("Feedback No.");
            NoSeriesMgt.InitSeries(CorporateAffairsSetup."Feedback No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        NoSeriesMgt: codeunit NoSeriesManagement;
        CorporateAffairsSetup: Record "Corporate Affairs Setup";
}
