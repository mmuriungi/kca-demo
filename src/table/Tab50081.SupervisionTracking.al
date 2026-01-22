table 50081 "Supervision Tracking"
{
    Caption = 'Supervision Tracking';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = Customer where("Customer Type" = const(Student), "Is Postgraduate" = const(true));
        }
        field(3; "Supervisor Code"; Code[20])
        {
            Caption = 'Supervisor Code';
            DataClassification = CustomerContent;
            TableRelation = "HRM-Employee C" where(Lecturer = const(true));
        }
        field(4; "Date Work Submitted"; Date)
        {
            Caption = 'Date Work Submitted';
            DataClassification = CustomerContent;
        }
        field(5; "Date Met With Supervisor"; Date)
        {
            Caption = 'Date Met With Supervisor';
            DataClassification = CustomerContent;
        }
        field(6; "Stage of Work"; Text[250])
        {
            Caption = 'Stage of Work';
            DataClassification = CustomerContent;
        }
        field(7; "Nature of Feedback"; Text[250])
        {
            Caption = 'Nature of Feedback';
            DataClassification = CustomerContent;
        }
        field(8; "Remarks"; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(9; "Student Signed"; Boolean)
        {
            Caption = 'Student Signed';
            DataClassification = CustomerContent;
        }
        field(10; "Supervisor Signed"; Boolean)
        {
            Caption = 'Supervisor Signed';
            DataClassification = CustomerContent;
        }
        field(11; "Semester Code"; Code[20])
        {
            Caption = 'Semester Code';
            DataClassification = CustomerContent;
            TableRelation = "ACA-Semesters".Code;
        }
        field(12; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(13; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"Pending Approval",Released,Approved,Rejected;
            OptionCaption = 'Open,Pending Approval,Released,Approved,Rejected';
            DataClassification = CustomerContent;
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(15; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
        key(SK1; "Student No.", "Supervisor Code", "Date Met With Supervisor")
        {
        }
    }

    trigger OnInsert()
    var
        NoSeriesmgmt: Codeunit NoSeriesManagement;
        AcaGenSetup: Record "ACA-General Set-Up";
    begin
        if "Document No." = '' then begin
            AcaGenSetup.Get();
            AcaGenSetup.TestField("Supervision Nos");
            NoSeriesmgmt.InitSeries(AcaGenSetup."Supervision Nos", xRec."No. Series", 0D, "Document No.", "No. Series");
        end;
        "Date Created" := Today;
    end;
}