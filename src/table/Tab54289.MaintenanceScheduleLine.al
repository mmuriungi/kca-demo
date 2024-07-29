table 54289 "Maintenance Schedule Line"
{
    Caption = 'Maintenance Schedule Line';
    DataClassification = ToBeClassified;
    LookupPageId = "Maintenance Schedule Lines";

    fields
    {
        field(1; "Request No."; Code[20])
        {
            Caption = 'Request No.';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                RepairRequest.Reset();
                if RepairRequest.Get("Request No.") then begin
                    "Request Description" := RepairRequest."Repair Description";
                    CalcFields("Maintenance Officers");
                    CalcFields("Requested Items/Assets");
                    "Expected Start Date" := RepairRequest."Start Date";
                    "Expected End Date" := RepairRequest."End Date";
                    Status := RepairRequest.Status::Scheduled;
                end;
            end;
        }
        field(2; "Request Description"; Text[500])
        {
            Caption = 'Request Description';
        }
        field(3; "Maintenance Officers"; Integer)
        {
            Caption = 'Maintenance Officers';
        }
        field(4; "Requested Items/Assets"; Integer)
        {
            Caption = 'Requested Items/Assets';
        }
        field(86; "maintenance status"; Option)
        {
            OptionMembers = Open,Pending,Completed;
            Caption = 'Status';
        }
        field(5; Status; Option)
        {
            OptionMembers = Open,Pending,Approved,Closed,Cancelled,Rejected,Completed;
            Caption = 'Status';
        }
        field(6; "Expected Start Date"; Date)
        {
            Caption = 'Expected Start Date';
        }
        field(7; "Expected End Date"; Date)
        {
            Caption = 'Expected End Date';
        }
        field(8; "Maintence No."; Code[20])
        {
            Caption = 'Maintence No.';
        }
        field(9; "E-Mail"; Text[250])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                EstatesMgnt.ValidateEmail("E-Mail");
            end;
        }
        field(10; Notified; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Repair Request Generated"; Boolean)
        {

        }
        field(30; "maintenance Requests"; Code[50])
        {
            Caption = 'maintenance Requests';

        }
        field(31; description; Code[100])
        {
            Caption = 'description';
        }

        field(33; "Type Of Request"; Option)
        {
            OptionMembers = ," ",Repair,Maintenance;
        }
        field(34; AssignedMo; Code[40])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';


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
        field(38; "Facility No."; Code[20])
        {
            Caption = 'Facility No.';

        }
        field(12; "Maintenance Period"; Option)
        {
            OptionMembers = ," ",January,February,March,April,May,June,July,August,September,October,November,December;


        }
        field(89; "Maintenance Year"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Facility Description"; Text[200])
        {
            Editable = false;
        }
        field(40; "Maintenance Description"; Text[500])
        {
            Caption = 'Maintenance Description';
        }



    }
    keys
    {
        key(PK; "Request No.", "Maintence No.")
        {
            Clustered = true;
        }
    }
    var
        RepairRequest: Record "Repair Request";
        EstatesMgnt: Codeunit "Estates Management";
}
