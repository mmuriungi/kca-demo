table 54288 "Maintenance Schedule"
{
    Caption = 'Maintenance Schedule';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; Desciption; Text[290])
        {
            Caption = 'Desciption';
        }
        field(3; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(4; "Created By"; Code[20])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Pending,Closed,Posted,Approved,Cancelled,Completed;
            Editable = false;
        }
        field(6; Maintenance; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Maintenance Schedule Line" where("Maintence No." = field("No."),"Repair Request Generated" = const(True)));
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
            EstateSetup.TestField("Maintenance No.");
            NoSeriesMgnt.InitSeries(EstateSetup."Maintenance No.", EstateSetup."Maintenance No.", Today, "No.", EstateSetup."Maintenance No.");
            "Created Date" := Today;
            "Created By" := UserId;
        end;
    end;
}
