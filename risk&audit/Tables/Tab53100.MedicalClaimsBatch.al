table 53100 "Medical Claims Batch"
{
    DataClassification = ToBeClassified;
    Caption = 'Medical Claims Batch';
    DrillDownPageId = "Medical Claims Batch List";
    LookupPageId = "Medical Claims Batch List";

    fields
    {
        field(1; "Batch No."; Code[20])
        {
            Caption = 'Batch No.';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                if "Batch No." <> xRec."Batch No." then begin
                    HRSetup.Get();
                    NoSeriesMgt.TestManual(HRSetup."Medical Claims Batch Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Approved,Posted;
            OptionCaption = 'Open,Approved,Posted';
            Editable = false;
        }
        field(6; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("HRM-Medical Claims"."Claim Amount" where("Batch No." = field("Batch No.")));
            Editable = false;
        }
        field(7; "No. of Claims"; Integer)
        {
            Caption = 'No. of Claims';
            FieldClass = FlowField;
            CalcFormula = count("HRM-Medical Claims" where("Batch No." = field("Batch No.")));
            Editable = false;
        }
        field(8; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            
            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if Vendor.Get("Vendor No.") then
                    "Vendor Name" := Vendor.Name
                else
                    "Vendor Name" := '';
            end;
        }
        field(9; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(11; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Posted Invoice No."; Code[20])
        {
            Caption = 'Posted Invoice No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(15; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(16; "Invoice Generated"; Boolean)
        {
            Caption = 'Invoice Generated';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        //pv Generated
        field(18; "Pv Generated"; Boolean)
        {
            Caption = 'Pv Generated';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //pv No
        field(19; "Pv No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    
    keys
    {
        key(PK; "Batch No.")
        {
            Clustered = true;
        }
    }
    
    trigger OnInsert()
    begin
        if "Batch No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Medical Claims Batch Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Medical Claims Batch Nos.", xRec."No. Series", 0D, "Batch No.", "No. Series");
        end;
        
        "Date Created" := Today;
        "Created By" := UserId;
        Status := Status::Open;
    end;
    
    var
        HRSetup: Record  "HRM-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
