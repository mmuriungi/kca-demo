table 54283 "Repair Request"
{
    Caption = 'Repair Request';
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
        }
        field(7; "Phone No."; Code[15])
        {
            Caption = 'Phone No.';
        }
        field(8; "Repair Description"; Text[500])
        {
            Caption = 'Repair Description';
        }
        field(9; Status; Option)
        {
            //Editable = false;
            Caption = 'Status';
            OptionMembers = Open,Pending,Approved,Closed,Cancelled,Rejected,Completed,Scheduled;
        }
        field(10; "Start Date"; Date)
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
                CalPeriods
            end;
        }
        field(11; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                RepairEndDateErr: Label 'Repair End Date cannot be before %1';
            begin
                TestField("Start Date");
                if "End Date" < "Start Date" then
                    Error(RepairEndDateErr, "Start Date");
                CalPeriods
            end;
        }
        field(12; "Repair Period"; Decimal)
        {
            Editable = false;
            Caption = 'Repair Period(Days)';

        }
        field(13; "Room No."; Code[20])
        {
            Editable = true;
            Caption = 'House/Room/Building';

        }
        field(14; "VoIP No"; Code[20])
        {

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
            EstateSetup.TestField("Repair No.");
            NoSeriesMgnt.InitSeries(EstateSetup."Repair No.", EstateSetup."Repair No.", Today, "No.", EstateSetup."Repair No.");
            "Request Date" := Today;
            "User ID" := UserId;
        end;
    end;

    procedure CalPeriods()
    var
        myInt: Integer;
    begin
        if ("Start Date" <> 0D) and ("End Date" <> 0D) then
            "Repair Period" := "End Date" - "Start Date";
    end;

    var
        FixedAsset: Record "Fixed Asset";
}
