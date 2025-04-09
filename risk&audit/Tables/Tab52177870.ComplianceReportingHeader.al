table 51342 "Compliance Reporting Header"
{
    Caption = 'Compliance Reporting Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                if Type = type::Reporting then begin
                    if "No." <> xRec."No." then
                        NoSeriesMgt.TestManual(CompSetup."Reporting Requirements Nos");
                end;

                if Type = type::Capital then begin
                    if "No." <> xRec."No." then
                        NoSeriesMgt.TestManual(CompSetup."Capital Requirements Nos");
                end;
                if Type = type::CBK then begin
                    if "No." <> xRec."No." then
                        NoSeriesMgt.TestManual(CompSetup."CBK Requirements Nos");
                end;
                if Type = type::AFDB then begin
                    if "No." <> xRec."No." then
                        NoSeriesMgt.TestManual(CompSetup."AFDB Requirements Nos");
                end;
                if Type = type::IFC then begin
                    if "No." <> xRec."No." then
                        NoSeriesMgt.TestManual(CompSetup."IFC Requirements Nos");
                end;
                if Type = type::"E&S" then begin
                    if "No." <> xRec."No." then
                        NoSeriesMgt.TestManual(CompSetup."E&S Requirements Nos");
                end;

            end;
        }
        field(2; "Shareholder No."; Code[20])
        {
            Caption = 'Shareholder No.';
            DataClassification = ToBeClassified;
        }
        field(3; Section; Code[20])
        {
            Caption = 'Section';
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Created By"; Code[100])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(6; "Date Created"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Time Created"; Time)
        {
            Caption = 'Time';
            DataClassification = ToBeClassified;
        }
        field(8; Submitted; Boolean)
        {
            Caption = 'Submitted';
            DataClassification = ToBeClassified;
        }
        field(9; "Stakeholder Name"; Text[200])
        {
            Caption = 'Stakeholder Name';
            DataClassification = ToBeClassified;
        }
        field(10; Type; Option)
        {
            OptionMembers = Reporting,Capital,CBK,AFDB,IFC,"E&S";
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", Type)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        CompSetup.Get;
        case Type of
            Type::Reporting:
                begin
                    CompSetup.TestField("Reporting Requirements Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CompSetup."Reporting Requirements Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;

            Type::CBK:
                begin
                    CompSetup.TestField("CBK Requirements Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CompSetup."CBK Requirements Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;

            Type::Capital:
                begin
                    CompSetup.TestField("Capital Requirements Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CompSetup."Capital Requirements Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;

            Type::IFC:
                begin
                    CompSetup.TestField("IFC Requirements Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CompSetup."IFC Requirements Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;

            Type::AFDB:
                begin
                    CompSetup.TestField("AFDB Requirements Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CompSetup."AFDB Requirements Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;

            Type::"E&S":
                begin
                    CompSetup.TestField("E&S Requirements Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CompSetup."E&S Requirements Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;

        end;

        "Date Created" := Today;
        "Time Created" := Time;
        "Created By" := UserId;

    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CompSetup: Record "Compliance Reporting Setup";

}
