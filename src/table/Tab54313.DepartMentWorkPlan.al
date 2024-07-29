table 54313 "DepartMent Work Plan"
{
    Caption = 'DepartMent Work Plan';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CorporateAffairsSetup.Get();
                    NoSeriesMgt.TestManual(CorporateAffairsSetup."Work Plan No.");
                    "No. Series" := '';
                end;
            end;

        }
        field(2; Department; Code[20])
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                DimensionValue.SetRange(code, Department);
                if DimensionValue.FindFirst() then "Department Name" := DimensionValue.Name
            end;
        }
        field(3; "Department Name"; Code[20])
        {
            Caption = 'Department Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(11; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Date"; Date)
        {
            Caption = 'Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(6; Status; Option)
        {
            Editable = false;
            Caption = 'Status';
            OptionCaption = 'Open,Pending Approval,Released';
            OptionMembers = Open,"Pending Approval",Released;
        }
        field(12; "Incharge"; Option)
        {
            Editable = false;
            OptionMembers = HOD,PCVET,"Consultative committee","Executive committee",;
        }
        field(7; "Confirmed By Executive 1"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Confirmed By Executive 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Confirmed By Executive 3"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Approved By Consul Committiee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Plan Year"; Code[20])
        {
            TableRelation = "WorkPlan Year";
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
        "Created By" := UserId;
        Date := Today;
        if "No." = '' then begin
            CorporateAffairsSetup.Get();
            CorporateAffairsSetup.TestField("Work Plan No.");
            NoSeriesMgt.InitSeries(CorporateAffairsSetup."Work Plan No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        NoSeriesMgt: codeunit NoSeriesManagement;
        CorporateAffairsSetup: Record "Corporate Affairs Setup";
}
