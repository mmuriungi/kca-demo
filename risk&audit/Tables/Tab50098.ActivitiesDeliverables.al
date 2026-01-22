table 51323 "Activities & Deliverables"
{
    Caption = 'Activities & Deliverables';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "A & D No"; Code[90])
        {
            Caption = 'A & D No';
        }
        field(2; "Activities And Deliverables"; Text[200])
        {
            Caption = 'Activities And Deliverables';
        }
        field(3; "Prelimary Dates"; Date)
        {
            Caption = 'Prelimary Dates';
        }
        field(4; "No.Series"; Code[10])
        {
            Caption = 'No.Series';
        }
        field(5; "No."; Code[90])
        {
            Caption = 'No.';
        }
    }
    keys
    {
        key(PK; "A & D No", "No.")
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
        IF "A & D No" = '' THEN BEGIN
            RiskSetup.GET();
            RiskSetup.TESTFIELD(RiskSetup."A & D No");
            NoSeriesMgt.InitSeries(RiskSetup."A & D No", xRec."No.Series", 0D, "A & D No", "No.Series");

        end;

    end;
}
