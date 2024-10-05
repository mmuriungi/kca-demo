table 51009 "Maintenance Officer"
{
    Caption = 'Maintenance Officer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "HRM-Employee C"."No.";//where("Maint Officer" = filter(true));
            trigger OnValidate()
            var
                Employee: Record "HRM-Employee C";
            begin
                if EstateMgnt.IsOpen("Repair No.") then
                    //if EstateMgnt.IsMaintenanceOfficer("Repair No.", UserId) then begin
                        Employee.Reset();
                if Employee.Get("No.") then begin
                    "Officer Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Phone No." := Employee."Phone Number";
                    "E-Mail" := Employee."E-Mail";
                    "Date Assigned" := Today;
                end;
            end;
            //end;
        }
        field(2; "Officer Name"; Text[500])
        {
            Caption = 'Officer Name';
        }
        field(3; "Phone No."; Code[20])
        {
            Caption = 'Phone No.';
        }
        field(4; "E-Mail"; Text[200])
        {
            Caption = 'E-Mail';
        }
        field(5; "Repair No."; Code[20])
        {
            Caption = 'Repair No.';
        }
        field(6; "Date Assigned"; Date)
        {
            Caption = 'Date Assigned';
        }
        field(7; "Repair Feedback"; Text[750])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                RepairConfMsg: Label 'Are you sure this repair started before today?';
                RepairMsg: Label 'Please Input the correct date';
            begin
                if "Start Date" < Today then
                    if not Confirm(StrSubstNo(RepairConfMsg)) then
                        Message(RepairMsg);
                CalPeriods;
            end;
        }
        field(9; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                RepairEndDateErr: Label 'Repair End Date cannot be before %1';
            begin
                TestField("Start Date");
                if "End Date" < "Start Date" then
                    Error(RepairEndDateErr, "Start Date");
                CalPeriods;
            end;
        }
        field(10; "Repair Period"; Decimal)
        {
            Editable = false;
            Caption = 'Repair Period(Days)';

        }
        field(11; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,Compeleted,Overdue;
            trigger OnValidate()
            var
                CompleteErr: Label 'This line must be complete to mark is has complete';
            begin
                if Status = Status::Compeleted then
                    if not Completed then
                        Error(CompleteErr);
            end;
        }
        field(12; Completed; Boolean)
        {
            Editable = true;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Completed then
                    Status := Status::Compeleted else
                    Status := Status::Pending;
            end;
        }
        field(13; Description; text[200])
        {
            TableRelation = "Repair Request Lines"."Repair Types" where("No." = field("Repair No."));
        }
        field(14; "Estimated End Date"; Date)
        {

        }
        field(15; "Completion FeedBack"; Code[160])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "client feedback"; code[160])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "client Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //User ID
        field(18; "User ID"; Code[20])
        {
            Caption = 'User ID';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("User Setup"."User ID" where("Employee No." = field("No.")));
        }
    }
    keys
    {
        key(PK; "No.", "Repair No.")
        {
            Clustered = true;
        }
    }
    procedure CalPeriods()
    var
        myInt: Integer;
    begin
        if ("Start Date" <> 0D) and ("End Date" <> 0D) then
            "Repair Period" := "End Date" - "Start Date";
    end;

    var
        EstateMgnt: Codeunit "Estates Management";

}
