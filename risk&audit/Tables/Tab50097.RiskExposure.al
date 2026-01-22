table 51322 "Risk Exposure"
{
    Caption = 'Risk Exposure';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Risk Exposure Line No"; Code[90])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Risk Exposure"; Code[150])
        {
            Caption = 'Risk Exposure';

        }
        field(3; "Risk Exposure Description"; Text[2000])
        {
            Caption = 'Risk Exposure Description';
        }
        field(4; "No."; Code[90])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Audit Header";
        }
        field(5; "No.Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Risk Exposure Line No", "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    Var
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RiskSetup: Record "Audit Setup";
    begin
        IF "Risk Exposure Line No" = '' THEN BEGIN
            RiskSetup.GET();
            RiskSetup.TESTFIELD(RiskSetup."Risk Exposure Line No");
            NoSeriesMgt.InitSeries(RiskSetup."Risk Exposure Line No", xRec."No.Series", 0D, "Risk Exposure Line No", "No.Series");

        end;

    end;
}
