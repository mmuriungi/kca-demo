table 50073 "Item Disposal Header"
{
    DataClassification = CustomerContent;

    FIELDS
    {
        FIELD(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';

            TRIGGER OnValidate()
            BEGIN
                IF "No." <> xRec."No." THEN BEGIN
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            END;
        }
        FIELD(2; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date';
        }
        FIELD(3; "Disposal Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Disposal Date';
        }
        FIELD(4; "Disposal Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Disposal Reason Code';
            TableRelation = "Reason Code";
        }
        FIELD(5; "Disposal Method"; Enum "Disposal Method")
        {
            DataClassification = CustomerContent;
            Caption = 'Disposal Method';
        }
        FIELD(6; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Location Code';
            TableRelation = Location;
        }
        FIELD(7; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            TableRelation = "No. Series";
            Editable = false;
        }
        FIELD(8; "Status"; Enum "Disposal Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            Editable = false;
        }
        FIELD(9; "User ID"; Code[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'User ID';
            Editable = false;
        }
        FIELD(10; "Created DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Created DateTime';
            Editable = false;
        }
        FIELD(11; "Approved By"; Code[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Approved By';
            Editable = false;
        }
        FIELD(12; "Approval DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Approval DateTime';
            Editable = false;
        }
        FIELD(13; "Disposal Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Disposal Account';
            TableRelation = "G/L Account";
        }
    }

    KEYS
    {
        KEY(PK; "No.")
        {
            Clustered = true;
        }
    }

    TRIGGER OnInsert()
    BEGIN
        IF "No." = '' THEN BEGIN
            GetInventorySetup;
            InventorySetup.TESTFIELD("Item Disposal Nos.");
            NoSeriesMgt.InitSeries(InventorySetup."Item Disposal Nos.", xRec."No. Series", "Document Date", "No.", "No. Series");
        END;

        "User ID" := USERID;
        "Created DateTime" := CURRENTDATETIME;
        "Status" := "Status"::Open;
    END;

    VAR
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    LOCAL PROCEDURE GetInventorySetup()
    BEGIN
        IF NOT InventorySetup.GET THEN
            InventorySetup.INSERT;
    END;

    LOCAL PROCEDURE GetNoSeriesCode(): Code[20]
    BEGIN
        GetInventorySetup;
        EXIT(InventorySetup."Item Disposal Nos.");
    END;
}