table 52177878 "Interactions Feedback"
{
    Caption = 'Interactions Feedback';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Interaction Code"; Code[10])
        {
            Caption = 'Interaction Code';
            DataClassification = ToBeClassified;
            tablerelation="Client Interaction Header";
        }
        field(3; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(4; "Client Name"; Text[100])
        {
            Caption = 'Client Name';
            DataClassification = ToBeClassified;
        }
        field(5; Feedback; Blob)
        {
            Caption = 'Feedback';
            DataClassification = ToBeClassified;
        }
        field(6; Submitted; Boolean)
        {
            Caption = 'Submitted';
            DataClassification = ToBeClassified;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(8; "No. Series"; Code[20])
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
    begin
        "Created By" := UserId;
        date := today;
        if "No." = '' then begin
            InteractSetup.Get;
            InteractSetup.TestField(Feedback);
            NoSeriesMgt.InitSeries(InteractSetup.Feedback, xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        recUserSetup: Record "User Setup";
        recClient: Record Customer;
        CompanyInformation: Record "Company Information";
        InteractSetup: Record "Marketing Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;



}
