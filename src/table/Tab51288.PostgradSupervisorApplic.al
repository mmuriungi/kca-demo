table 51288 "Postgrad Supervisor Applic."
{
    Caption = 'Postgrad Supervisor Application';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[25])
        {
            Caption = 'No.';
        }
        field(2; "Student No."; Code[25])
        {
            Caption = 'Student No.';
            TableRelation = Customer where("Customer Type" = CONST(Student));
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                Customer.Reset();
                Customer.SetRange("No.", Rec."Student No.");
                if Customer.FindFirst() then begin
                    Rec."Student Name" := Customer.Name;
                end;
            end;
        }
        field(3; "Student Name"; Text[150])
        {
            Caption = 'Student Name';
        }
        field(4; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }
        field(5; Status; Enum "Custom Approval Status")
        {
            Caption = 'Status';
        }
        field(6; "Assigned Supervisor Code"; Code[25])
        {
            Caption = 'Assigned Supervisor Code';
            tableRelation = "HRM-Employee C" where(Lecturer = Const(true));
        }
        field(7; "Assigned Supervisor Name"; Text[150])
        {
            Caption = 'Assigned Supervisor Name';
        }
        field(8; "Date Approved"; Date)
        {
            Caption = 'Date Approved';
            editable = false;
        }
        field(9; "No. Series"; Code[20])
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
        Setup.GET;
        setup.TestField("Supervisor Assignment Nos.");
        NoSeries.InitSeries(setup."Supervisor Assignment Nos.", xRec."No. Series", 0D, Rec."No.", xRec."No. Series");
        "Application Date" := today;
    end;

    var
        NoSeries: Codeunit NoSeriesManagement;
        Setup: Record "PostGraduate Setup";
}
