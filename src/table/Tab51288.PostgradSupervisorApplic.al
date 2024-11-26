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
            trigger OnValidate()
            var
                Employee: Record "HRM-Employee C";
            begin
                Employee.Reset();
                Employee.SetRange("No.", Rec."Assigned Supervisor Code");
                if Employee.FindFirst() then begin
                    Rec."Assigned Supervisor Name" := Employee.FullName();
                end;
            end;
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
        //Assigned by
        field(10; "Assigned By"; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Semester"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", Semester)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeries: Codeunit NoSeriesManagement;
        Setup: Record "PostGraduate Setup";
    begin
        if "No." = '' then begin
            Setup.Get();
            setup.TestField("Supervisor Assignment Nos.");
            NoSeries.InitSeries(setup."Supervisor Assignment Nos.", xRec."No. Series", 0D, Rec."No.", xRec."No. Series");
            "Application Date" := today;
        end
    end;


}
