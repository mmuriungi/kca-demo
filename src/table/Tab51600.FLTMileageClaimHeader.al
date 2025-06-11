table 51600 "FLT-Mileage Claim Header"
{
    Caption = 'Transport Mileage Claim Header';
    DrillDownPageID = "FLT-Mileage Claim List";
    LookupPageID = "FLT-Mileage Claim List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Mileage Claim No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date of Request';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                if "Date" = 0D then
                    "Date" := WorkDate();
            end;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";
            
            trigger OnValidate()
            var
                Employee: Record "HRM-Employee C";
            begin
                if Employee.Get("Employee No.") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Last Name";
                    "Department Code" := Employee."Department Code";
                    Designation := Employee."Job Title";
                    "Phone Number" := Employee."Cellular Phone Number";
                end;
            end;
        }
        field(4; "Employee Name"; Text[100])
        {
            Caption = 'Name of Claiming Officer';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Department Code"; Code[20])
        {
            Caption = 'Department/School';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = false;
        }
        field(6; Designation; Text[100])
        {
            Caption = 'Designation';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Phone Number"; Text[30])
        {
            Caption = 'Contact Number';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Posted,Rejected;
            OptionCaption = 'Open,Pending Approval,Approved,Posted,Rejected';
            Editable = false;
        }
        field(9; "Requested By"; Code[50])
        {
            Caption = 'Requested By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Time Created"; Time)
        {
            Caption = 'Time Created';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Total Estimated Mileage"; Decimal)
        {
            Caption = 'Total Estimated Mileage (KM)';
            CalcFormula = Sum("FLT-Mileage Claim Lines"."Distance (KM)" WHERE("Mileage Claim No." = FIELD("No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(13; "Total Estimated Cost"; Decimal)
        {
            Caption = 'Total Estimated Cost';
            CalcFormula = Sum("FLT-Mileage Claim Lines"."Total Cost" WHERE("Mileage Claim No." = FIELD("No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(14; "Approved Rate Per Km"; Decimal)
        {
            Caption = 'Approved Rate Per Km';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Transport Officer"; Code[50])
        {
            Caption = 'Transport Officer';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(16; "Transport Officer Date"; Date)
        {
            Caption = 'Transport Officer Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Transport Officer Time"; Time)
        {
            Caption = 'Transport Officer Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Approver Name"; Text[100])
        {
            Caption = 'Approver Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Approval Stage"; Option)
        {
            Caption = 'Approval Stage';
            DataClassification = ToBeClassified;
            OptionMembers = New,"Transport Officer","VC/DVC/Registrar","Fully Approved";
            OptionCaption = 'New,Transport Officer,VC/DVC/Registrar,Fully Approved';
            Editable = false;
        }
        field(20; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Approved Time"; Time)
        {
            Caption = 'Approved Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(24; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(25; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Posted Time"; Time)
        {
            Caption = 'Posted Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Remarks"; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", "Date")
        {
        }
        key(Key3; Status, "Approval Stage")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Employee Name", "Date", Status)
        {
        }
        fieldgroup(Brick; "No.", "Employee Name", "Total Estimated Cost", Status)
        {
        }
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FltSetup: Record "FLT-Fleet Mgt Setup";
    begin
        if "No." = '' then begin
            FltSetup.Get();
            FltSetup.TestField("Mileage Claim Nos.");
            NoSeriesMgt.InitSeries(FltSetup."Mileage Claim Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        
        "Date" := WorkDate();
        "Date Created" := WorkDate();
        "Time Created" := Time;
        "Requested By" := UserId;
        Status := Status::Open;
        "Approval Stage" := "Approval Stage"::New;
    end;

    trigger OnModify()
    begin
        if Status in [Status::Approved, Status::Posted] then
            Error('You cannot modify a %1 record.', Status);
    end;

    trigger OnDelete()
    begin
        if Status in [Status::Approved, Status::Posted, Status::"Pending Approval"] then
            Error('You cannot delete a %1 record.', Status);
            
        // Delete related lines
        DeleteMileageClaimLines();
    end;

    local procedure DeleteMileageClaimLines()
    var
        MileageClaimLines: Record "FLT-Mileage Claim Lines";
    begin
        MileageClaimLines.Reset();
        MileageClaimLines.SetRange("Mileage Claim No.", "No.");
        MileageClaimLines.DeleteAll();
    end;

    procedure SendForApproval()
    begin
        TestField("Employee No.");
        TestMileageClaimLines();
        
        if Confirm('Send this Mileage Claim for Approval?', true) then begin
            Status := Status::"Pending Approval";
            "Approval Stage" := "Approval Stage"::"Transport Officer";
            Modify();
            Message('Mileage Claim sent for approval successfully.');
        end;
    end;

    procedure ApproveByTransportOfficer()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            Error('User %1 is not setup properly.', UserId);
            
        TestField(Status, Status::"Pending Approval");
        TestField("Approval Stage", "Approval Stage"::"Transport Officer");
        
        if Confirm('Approve this Mileage Claim?', true) then begin
            "Transport Officer" := UserId;
            "Transport Officer Date" := WorkDate();
            "Transport Officer Time" := Time;
            "Approval Stage" := "Approval Stage"::"VC/DVC/Registrar";
            Modify();
            Message('Mileage Claim approved by Transport Officer.');
        end;
    end;

    procedure FinalApproval()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            Error('User %1 is not setup properly.', UserId);
            
        TestField(Status, Status::"Pending Approval");
        TestField("Approval Stage", "Approval Stage"::"VC/DVC/Registrar");
        
        if Confirm('Give Final Approval to this Mileage Claim?', true) then begin
            Status := Status::Approved;
            "Approval Stage" := "Approval Stage"::"Fully Approved";
            "Approved Date" := WorkDate();
            "Approved Time" := Time;
            "Approver Name" := UserId;
            Modify();
            Message('Mileage Claim fully approved.');
        end;
    end;

    local procedure TestMileageClaimLines()
    var
        MileageClaimLines: Record "FLT-Mileage Claim Lines";
    begin
        MileageClaimLines.Reset();
        MileageClaimLines.SetRange("Mileage Claim No.", "No.");
        if MileageClaimLines.IsEmpty then
            Error('You must add at least one mileage claim line before sending for approval.');
    end;
}