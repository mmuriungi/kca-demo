table 54202 "Maintenance Plan"
{
    DrillDownPageID = "Maintenance Plan List";
    LookupPageID = "Maintenance Plan List";

    fields
    {
        field(1; "Plan No."; Code[20])
        {

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                IF "Plan No." <> xRec."Plan No." THEN BEGIN
                    FASetup.GET;
                    //NoSeriesMgt.TestManual(FASetup."Maintenance Plan Nos.");
                    "No. Series" := ' ';
                END;
            end;
        }
        field(5; Description; Text[100])
        {
        }
        field(10; "Planned Date"; Date)
        {
        }
        field(15; "Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                         "Dimension Value Type" = CONST(Standard));
        }
        field(20; "Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(25; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(30; Comments; Text[100])
        {
        }
        field(35; "No. Series"; Code[10])
        {
        }
        field(36; "Created By"; Code[30])
        {
            Editable = false;
        }
        field(40; "Total Estimated Cost"; Decimal)
        {
            CalcFormula = Sum("Maintenance Plan Lines"."Estimated Cost" WHERE("Plan No." = FIELD("Plan No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Plan No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Plan No." = '' THEN BEGIN
            FASetup.GET;
            FASetup.TESTFIELD("Insurance Nos.");
            NoSeriesMgt.InitSeries(FASetup."Maintenance Plan Nos.", xRec."No. Series", 0D, "Plan No.", "No. Series");
        END;

        "Created By" := USERID;
    end;

    var
        FASetup: Record "FLT-Fleet Mgt Setup";
        NoSeriesMgt: Codeunit 396;
}

