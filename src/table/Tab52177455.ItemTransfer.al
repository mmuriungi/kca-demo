table 51378 "Item Transfer Header"
{
    Caption = 'Item Transfer Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GetInventorySetup();
                    NoSeriesMgt.TestManual(InventorySetup."Item Transfer Nos.");
                    "No. Series" := '';
                end;
            end;
        }

        field(2; "Transfer Date"; Date)
        {
            Caption = 'Transfer Date';
            DataClassification = ToBeClassified;
        }

        field(3; "Location From Code"; Code[10])
        {
            Caption = 'Location From Code';
            TableRelation = Location.Code;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                UpdateLines();
            end;
        }

        field(4; "Location To Code"; Code[10])
        {
            Caption = 'Location To Code';
            TableRelation = Location.Code;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                UpdateLines();
            end;
        }

        field(5; "Reference No."; Code[35])
        {
            Caption = 'Reference No.';
            DataClassification = ToBeClassified;
        }

        field(6; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(7; Status; Enum "Transfer Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }

        field(8; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(9; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(10; "Posted"; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(11; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(12; "Posted Date"; DateTime)
        {
            Caption = 'Posted Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //Approval Status
        field(14; "Approval Status"; Enum "Custom Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = ToBeClassified;
            Editable = false;
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
        GetInventorySetup();
        if "No." = '' then begin
            InventorySetup.TestField("Item Transfer Nos.");
            NoSeriesMgt.InitSeries(InventorySetup."Item Transfer Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Transfer Date" := WorkDate();
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
        Status := Status::Open;
    end;

    trigger OnDelete()
    var
        ItemTransferLine: Record "Item Transfer Line";
    begin
        if Posted then
            Error('Cannot delete posted transfer.');

        ItemTransferLine.SetRange("Transfer No.", "No.");
        ItemTransferLine.DeleteAll(true);
    end;

    var
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    local procedure GetInventorySetup()
    begin
        InventorySetup.Get();
    end;

    local procedure UpdateLines()
    var
        ItemTransferLine: Record "Item Transfer Line";
    begin
        ItemTransferLine.SetRange("Transfer No.", "No.");
        if ItemTransferLine.FindSet() then
            repeat
                ItemTransferLine."Location From Code" := "Location From Code";
                ItemTransferLine."Location To Code" := "Location To Code";
                ItemTransferLine.Modify();
            until ItemTransferLine.Next() = 0;
    end;
}