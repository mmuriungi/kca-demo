table 54290 "Maintenance Request"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Facility No."; Code[20])
        {
            Caption = 'Facility No.';
            TableRelation = "Fixed Asset" where("FA Subclass Code" = const('BUILDINGS'));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FixedAsset.Reset();
                if FixedAsset.Get("Facility No.") then
                    "Facility Description" := FixedAsset.Description;
            end;
        }
        field(3; "Facility Description"; Text[200])
        {
            Editable = false;
        }
        field(4; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(5; "User ID"; Code[20])
        {
            Caption = 'User ID';
            Editable = false;
        }
        field(6; "E-Mail"; Text[50])
        {
            Caption = 'E-Mail';
            Editable = false;
        }
        field(7; "Phone No."; Code[15])
        {
            Caption = 'Phone No.';
            Editable = false;
        }
        field(8; "Maintenance Description"; Text[500])
        {
            Caption = 'Maintenance Description';
        }
        field(9; Status; Option)
        {
            Editable = false;
            Caption = 'Status';
            OptionMembers = Open,Pending,Approved,Closed,Cancelled,Rejected,Completed,Scheduled,Posted,repair,unClassified;
        }
        field(10; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                MaintenanceConfMsg: Label 'Are you sure this Maintenance started before today?';
                MaintenanceMsg: Label 'Please Input the correct date';
            begin
                if "Start Date" < Today then
                    if not Confirm(StrSubstNo(MaintenanceConfMsg)) then
                        Message(MaintenanceMsg);
                CalPeriods
            end;
        }
        field(11; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                MaintenanceEndDateErr: Label 'Maintenance End Date cannot be before %1';
            begin
                TestField("Start Date");
                if "End Date" < "Start Date" then
                    Error(MaintenanceEndDateErr, "Start Date");
                CalPeriods
            end;
        }
        field(12; "Maintenance Period"; Option)
        {
            OptionMembers = ," ",January,February,March,April,May,June,July,August,September,October,November,December;


        }
        field(13; "Scheduled Date"; Date)
        {
            Editable = false;
        }
        field(89; "Maintenance Year"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Requester; code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";
            NotBlank = true;

            trigger OnValidate()
            var
                hrm: Record "HRM-Employee C";
                FullName: Text[100];
            begin
                if hrm.Get("Requester") then begin
                    // Concatenate First Name, Middle Name, and Last Name with spaces
                    FullName := hrm."First Name";

                    if not IsNullOrEmpty(hrm."Middle Name") then
                        FullName := FullName + ' ' + hrm."Middle Name";

                    if not IsNullOrEmpty(hrm."Last Name") then
                        FullName := FullName + ' ' + hrm."Last Name";

                    rec."Requester Name" := FullName;
                    rec."Department Code" := hrm."Department Code";
                    rec.Department := hrm."Department Name";
                    rec."E-Mail" := hrm."Company E-Mail";
                    rec."Phone No." := hrm."Cellular Phone Number";

                    // No need to call rec.Modify() in OnValidate trigger
                end;
            end;

            // Helper function to check if a string is null or empty

        }
        field(18; "Requester Name"; code[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Department Code"; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; Department; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(16; "Re"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "maintenance Requests"; Code[50])
        {
            Caption = 'maintenance Requests';
            TableRelation = "maintenance Request list2"." Maintenance Descriptions";
        }
        field(31; description; Code[100])
        {
            Caption = 'description';
        }
        field(32; IsRepair; Boolean)
        {
            Caption = 'IsRepair';
        }
        field(33; "Type Of Request"; Option)
        {
            OptionMembers = ," ",Repair,Maintenance;
        }
        field(34; AssignedMo; Code[40])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
            TableRelation = "HRM-Employee C"."No.";// where( = filter(true));
            trigger OnValidate()
            var
                Employee: Record "HRM-Employee C";
            begin

                Employee.Reset();
                if Employee.Get(AssignedMo) then begin
                    Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    email := Employee."E-Mail";

                end;
            end;


        }
        field(35; Name; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(36; email; code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Estimated Cost"; Decimal)
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
    var
        EstateSetup: Record "Estates Setup";
        NoSeriesMgnt: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            EstateSetup.Get();
            EstateSetup.TestField("Maintenance Request No.");
            NoSeriesMgnt.InitSeries(EstateSetup."Maintenance Request No.", EstateSetup."Maintenance Request No.", Today, "No.", EstateSetup."Maintenance Request No.");
            "Request Date" := Today;
            "User ID" := UserId;
        end;
    end;

    procedure CalPeriods()
    var
        myInt: Integer;
    begin
        if ("Start Date" <> 0D) and ("End Date" <> 0D) then
            "Maintenance Period" := "End Date" - "Start Date";
    end;

    procedure IsNullOrEmpty(Value: Text): Boolean;
    begin
        exit(Value = '');
    end;

    var
        FixedAsset: Record "Fixed Asset";
}
