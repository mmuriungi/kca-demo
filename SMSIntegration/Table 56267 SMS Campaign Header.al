table 56267 "SMS Campaign Header"
{
    Caption = 'SMS Campaign Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Campaign No." <> xRec."Campaign No." then begin
                    TestNoSeries();
                    NoSeriesMgt.TestManual(GetNoSeriesCode());
                end;
            end;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Message Text"; Text[2048])
        {
            Caption = 'Message Text';
            DataClassification = ToBeClassified;
        }
        field(4; "Schedule Date"; Date)
        {
            Caption = 'Schedule Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Schedule Time"; Time)
        {
            Caption = 'Schedule Time';
            DataClassification = ToBeClassified;
        }
        field(6; "Status"; Enum "SMS Campaign Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Sent Date"; DateTime)
        {
            Caption = 'Sent Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Total Recipients"; Integer)
        {
            Caption = 'Total Recipients';
            FieldClass = FlowField;
            CalcFormula = Count("SMS Campaign Line" where("Campaign No." = field("Campaign No.")));
            Editable = false;
        }
        field(11; "Total Sent"; Integer)
        {
            Caption = 'Total Sent';
            FieldClass = FlowField;
            CalcFormula = Count("SMS Campaign Line" where("Campaign No." = field("Campaign No."), "Status" = const(Sent)));
            Editable = false;
        }
        field(12; "Total Failed"; Integer)
        {
            Caption = 'Total Failed';
            FieldClass = FlowField;
            CalcFormula = Count("SMS Campaign Line" where("Campaign No." = field("Campaign No."), "Status" = const(Failed)));
            Editable = false;
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Campaign No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Campaign No." = '' then begin
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "Campaign No.", "No. Series");
        end;
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
        Status := Status::Draft;
    end;

    trigger OnDelete()
    var
        SMSCampaignLine: Record "SMS Campaign Line";
    begin
        TestField(Status, Status::Draft);
        
        SMSCampaignLine.SetRange("Campaign No.", "Campaign No.");
        SMSCampaignLine.DeleteAll(true);
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;

    local procedure TestNoSeries()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.Get();
        SalesSetup.TestField("SMS Campaign Nos.");
    end;

    local procedure GetNoSeriesCode(): Code[20]
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.Get();
        exit(SalesSetup."SMS Campaign Nos.");
    end;
}