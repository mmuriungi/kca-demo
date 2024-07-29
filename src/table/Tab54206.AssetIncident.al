table 54206 "Asset Incident"
{
    DrillDownPageID = "Asset Incident List";
    LookupPageID = "Asset Incident List";

    fields
    {
        field(1; "Incident No."; Code[20])
        {

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                IF "Incident No." <> xRec."Incident No." THEN BEGIN
                    FASetup.GET;
                    NoSeriesMgt.TestManual(FASetup."Asset Incident Nos");
                    "No. Series" := ' ';
                END;
            end;
        }
        field(5; Description; Text[100])
        {
        }
        field(10; "Reported By"; Code[30])
        {
        }
        field(15; "Date Reported"; Date)
        {
        }
        field(20; "Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(25; "Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(30; Location; Code[20])
        {
            TableRelation = "FA Location";
        }
        field(35; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(40; Recommendations; Text[100])
        {
        }
        field(45; "Incident Type"; Option)
        {
            OptionMembers = " ",Minor,Major;
        }
        field(50; "No. Series"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Incident No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Incident No." = '' THEN BEGIN
            FASetup.GET;
            FASetup.TESTFIELD("Asset Incident Nos");
            NoSeriesMgt.InitSeries(FASetup."Asset Incident Nos", xRec."No. Series", 0D, "Incident No.", "No. Series");
        END;

        "Reported By" := USERID;
        "Date Reported" := TODAY;
    end;

    var
        FASetup: Record "FLT-Fleet Mgt Setup";
        NoSeriesMgt: Codeunit 396;
}

