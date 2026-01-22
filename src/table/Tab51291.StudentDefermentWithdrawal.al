table 50078 "Student Deferment/Withdrawal"
{
    Caption = 'Student Deferment/Withdrawal';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Customer where("Customer Type" = const(Student));
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.Get("Student No.") then
                    "Student Name" := Customer.Name;
            end;
        }
        field(3; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            Editable = false;
        }
        field(4; "Request Type"; Option)
        {
            Caption = 'Request Type';
            OptionMembers = Deferment,Withdrawal;
        }
        field(5; "Request Date"; Date)
        {
            Caption = 'Request Date';
            Editable = false;
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(7; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(8; "Return Date"; Date)
        {
            Caption = 'Return Date';
            Editable = false;
        }
        field(9; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "ACA-Academic Year";
        }
        field(10; "Semester"; Code[20])
        {
            Caption = 'Semester';
            TableRelation = "ACA-Semesters";
        }
        field(11; "Programme Code"; Code[20])
        {
            Caption = 'Programme Code';
            TableRelation = "ACA-Programme";
        }
        field(12; "Stage"; Code[20])
        {
            Caption = 'Stage';
            TableRelation = "ACA-Programme Stages".Code where("Programme Code" = field("Programme Code"));
        }
        field(13; Reason; Text[250])
        {
            Caption = 'Reason';
        }
        field(14; "Status"; Enum "Custom Approval Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(15; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            Editable = false;
        }
        field(16; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
            Editable = false;
        }
        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "No.", "Request Type")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            AcademicSetup.Get();
            AcademicSetup.TestField("Deferment/Withdrawal Nos");
            NoSeriesMgt.InitSeries(AcademicSetup."Deferment/Withdrawal Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Request Date" := Today;
        Status := Status::Open;

        if "Request Type" = "Request Type"::Deferment then begin
            if "End Date" <> 0D then
                "Return Date" := CalcDate('<1D>', "End Date");
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        AcademicSetup: Record "ACA-General Set-Up";
}
