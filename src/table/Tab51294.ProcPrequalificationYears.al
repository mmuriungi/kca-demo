table 51294 "Proc-Prequalification Years"
{
    DrillDownPageID = "Proc-Prequalification Years";
    LookupPageID = "Proc-Prequalification Years";

    fields
    {
        field(1; "Preq. Year"; Code[20])
        {
        }
        field(2; "Start Date"; Date)
        {

            trigger OnValidate()
            begin

                IF ((Rec."Start Date" <> 0D) AND (Rec."End Date" <> 0D)) THEN BEGIN
                    CLEAR(ProcPrequalificationdates);
                    ProcPrequalificationdates.RESET;
                    ProcPrequalificationdates.SETRANGE("Preq. Year", Rec."Preq. Year");
                    IF ProcPrequalificationdates.FIND('-') THEN BEGIN
                        ProcPrequalificationdates.DELETEALL;
                    END;
                    CLEAR(Datesz);
                    Datesz.RESET;
                    Datesz.SETFILTER("Period Start", '%1..%2', Rec."Start Date", Rec."End Date");
                    Datesz.SETRANGE("Period Type", Datesz."Period Type"::Date);
                    IF Datesz.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            ProcPrequalificationdates.INIT;
                            ProcPrequalificationdates."Preq. Year" := Rec."Preq. Year";
                            ProcPrequalificationdates."Reference Date" := Datesz."Period Start";
                            ProcPrequalificationdates.INSERT(TRUE);
                        END;
                        UNTIL Datesz.NEXT = 0;
                    END;
                END;
            end;
        }
        field(3; "End Date"; Date)
        {

            trigger OnValidate()
            begin

                IF ((Rec."Start Date" <> 0D) AND (Rec."End Date" <> 0D)) THEN BEGIN
                    CLEAR(ProcPrequalificationdates);
                    ProcPrequalificationdates.RESET;
                    ProcPrequalificationdates.SETRANGE("Preq. Year", Rec."Preq. Year");
                    IF ProcPrequalificationdates.FIND('-') THEN BEGIN
                        ProcPrequalificationdates.DELETEALL;
                    END;
                    CLEAR(Datesz);
                    Datesz.RESET;
                    Datesz.SETFILTER("Period Start", '%1..%2', Rec."Start Date", Rec."End Date");
                    Datesz.SETRANGE("Period Type", Datesz."Period Type"::Date);
                    IF Datesz.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            ProcPrequalificationdates.INIT;
                            ProcPrequalificationdates."Preq. Year" := Rec."Preq. Year";
                            ProcPrequalificationdates."Reference Date" := Datesz."Period Start";
                            ProcPrequalificationdates.INSERT(TRUE);
                        END;
                        UNTIL Datesz.NEXT = 0;
                    END;
                END;
            end;
        }
        field(4; "Preq. Categories"; Integer)
        {
            CalcFormula = Count("Proc-Prequalif. Categories" WHERE("Preq Year" = FIELD("Preq. Year")));
            FieldClass = FlowField;
        }
        field(5; "Preq. Dates List"; Integer)
        {
            CalcFormula = Count("Proc-Prequalification dates" WHERE("Preq. Year" = FIELD("Preq. Year")));
            FieldClass = FlowField;
        }
        field(6; "Active Period"; Boolean)
        {

            trigger OnValidate()
            var
                period: Record "Proc-Prequalification Years";
            begin

                period.Reset();
                period.SetRange("Active Period", true);
                if period.Find('-') then begin
                    if rec."Active Period" = true then begin
                        period."Active Period" := false;
                    end;

                end;


            end;

        }
    }

    keys
    {
        key(Key1; "Preq. Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ProcPrequalificationdates: Record "Proc-Prequalification dates";
        ProcPrequalificationYears: Record "Proc-Prequalification Years";
        Datesz: Record Date;

    procedure AddCategory(var preqYr: Record "Proc-Prequalification Years")
    var
        categry: Record "Proc-Prequalif. Categories";
    begin
        if Confirm('Add Category to this period ?', true) = false then Error('Cancelled');
        categry.Init();
        categry."Preq Year" := preqYr."Preq. Year";
        categry.Insert();
        page.Run(Page::"Proc-Prequalif. Categories", categry);

    end;
}

