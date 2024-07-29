table 54204 "Actual Maintenance "
{
    DrillDownPageID = "Actual Maintenance List";
    LookupPageID = "Actual Maintenance List";

    fields
    {
        field(1; "Maintenance No."; Code[20])
        {

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                IF "Maintenance No." <> xRec."Maintenance No." THEN BEGIN
                    FASetup.GET;
                    NoSeriesMgt.TestManual(FASetup."Insurance Nos.");
                    "No. Series" := ' ';
                END;
            end;
        }
        field(5; Description; Text[100])
        {
        }
        field(10; "Created By"; Code[30])
        {
        }
        field(15; "Planned Date"; Date)
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
        field(30; "Plan No."; Code[20])
        {
            TableRelation = "Maintenance Plan"."Plan No.";

            trigger OnValidate()
            begin
                MaintPlanLines.RESET;
                MaintPlanLines.SETRANGE(MaintPlanLines."Plan No.", "Plan No.");
                IF MaintPlanLines.FINDSET THEN BEGIN

                    //Remove Existing Maintenance Lines
                    MaintLines.RESET;
                    MaintLines.SETRANGE(MaintLines."Maintenance No.", "Maintenance No.");
                    IF MaintLines.FINDSET THEN MaintLines.DELETEALL;

                                                   REPEAT
                                                       MaintLines.RESET;
                                                       MaintLines.INIT;
                                                       MaintLines."Maintenance No." := "Maintenance No.";
                                                       MaintLines."Line No." := 0;
                                                       MaintLines."Fixed Asset No." := MaintPlanLines."Fixed Asset No.";
                                                       MaintLines.VALIDATE(MaintLines."Fixed Asset No.");
                                                       MaintLines."Dimension 1 Code" := MaintPlanLines."Dimension 1 Code";
                                                       MaintLines."Dimension 2 Code" := MaintPlanLines."Dimension 2 Code";
                                                       MaintLines.INSERT(TRUE);
                                                   UNTIL MaintPlanLines.NEXT = 0;

                END
                ELSE
                    ERROR(Txt0001, "Plan No.");
            end;
        }
        field(35; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(40; Comments; Text[100])
        {
        }
        field(45; "No. Series"; Code[10])
        {
        }
        field(50; "Total Cost"; Decimal)
        {
            CalcFormula = Sum("Actual Maintenance Lines".Cost WHERE("Maintenance No." = FIELD("Maintenance No.")));
            FieldClass = FlowField;
        }
        field(50000; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center".Code; //WHERE (Grouping=FILTER('ADMIN'));
        }
    }

    keys
    {
        key(Key1; "Maintenance No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Maintenance No." = '' THEN BEGIN
            FASetup.GET;
            FASetup.TESTFIELD("Insurance Nos.");
            NoSeriesMgt.InitSeries(FASetup."Insurance Nos.", xRec."No. Series", 0D, "Maintenance No.", "No. Series");
        END;

        "Created By" := USERID;
    end;

    var
        FASetup: Record 5603;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MaintPlanLines: Record "Maintenance Plan Lines";
        MaintLines: Record "Actual Maintenance Lines";
        Txt0001: Label 'There are no Maintenance Plan Lines for Plan No. %1';
}

