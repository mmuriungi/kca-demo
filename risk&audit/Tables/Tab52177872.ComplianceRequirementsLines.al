table 50140 "Compliance Requirements Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; Requirements; Text[2048])
        {
            Caption = 'Requirements';
            DataClassification = ToBeClassified;
        }
        field(4; Notes; Text[2048])
        {
            Caption = 'Notes';
            DataClassification = ToBeClassified;
        }
        field(5; "Month of Reporting"; Text[200])
        {
            Caption = 'Month of Reporting';
            DataClassification = ToBeClassified;
        }
        field(6; Responsibility; Text[200])
        {
            Caption = 'Responsibility';
            DataClassification = ToBeClassified;
        }
        field(7; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            trigger OnValidate()
            var
                Emp: record Employee;
            begin
                if Emp.Get("Employee No.") then
                    Responsibility := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(8; "Issue Line No."; integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(9; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Issue Line No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        GetNextLineNo();
    end;

    procedure GetNextLineNo()
    var
        Req: Record "Compliance Requirements Lines";
    begin
        Req.reset;
        Req.SetRange("No.", "No.");
        Req.SetRange("Issue Line No.", "Issue Line No.");
        if Req.FindLast() then
            "Line No." := Req."Line No." + 1
        else
            "Line No." := 1;
        exit;
    end;

}
