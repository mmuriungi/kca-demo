table 50979 "Visitors Ledger"
{
    Caption = 'Visitors Ledger';

    fields
    {
        field(1; "Visit No."; Code[250])
        {
        }
        field(2; "ID No."; Code[10])
        {

            trigger OnValidate()
            begin
                VisitorsLedger.RESET;
                VisitorsLedger.SETRANGE(VisitorsLedger."ID No.", "ID No.");
                VisitorsLedger.SETRANGE(VisitorsLedger."Checked Out", FALSE);
                IF VisitorsLedger.COUNT > 0 THEN ERROR('The Visitor must be checked out first');

                // Pick the details from the Visitor Card
                IF VisitorCard.GET("ID No.") THEN BEGIN
                    "Full Name" := VisitorCard."Full Names";
                    Company := VisitorCard."Company Name";
                    "Phone No." := VisitorCard."Phone No.";
                    Email := VisitorCard.Email;

                END;
            end;
        }
        field(3; "Full Name"; Text[150])
        {
        }
        field(4; "Phone No."; Code[150])
        {
        }
        field(5; Email; Text[150])
        {

            trigger OnValidate()
            var
                atExists: Boolean;
                CountedXters: Integer;
            begin
                CLEAR(atExists);
                CLEAR(CountedXters);
                IF Email <> '' THEN BEGIN
                    REPEAT
                    BEGIN
                        CountedXters := CountedXters + 1;
                        IF (COPYSTR(Email, CountedXters, 1)) = '@' THEN atExists := TRUE;
                    END;
                    UNTIL ((CountedXters = STRLEN(Email)) OR atExists);

                    IF atExists = FALSE THEN ERROR('Provide a valid email address!');
                END;
            end;
        }
        field(6; Company; Text[150])
        {
        }
        field(7; "Office Station/Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code; //WHERE ("Dimension Code"=FILTER(Code));
        }
        field(8; "Department Name"; Text[150])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Office Station/Department")));
            //   "Dimension Code"=FILTER("Code")));
            FieldClass = FlowField;
        }
        field(9; "Signed in by"; Code[50])
        {
        }
        field(10; "Transaction Date"; Date)
        {
        }
        field(60; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(11; "Time In"; Time)
        {
        }
        field(12; "Time Out"; Time)
        {
        }
        field(13; "Signed Out By"; Code[50])
        {
        }
        field(14; "Checked Out"; Boolean)
        {
        }
        field(15; Comment; Text[250])
        {

            trigger OnValidate()
            begin
                "Comment By" := USERID;
            end;
        }
        field(16; "Comment By"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Visit No.")
        {
        }
        key(Key2; "ID No.", "Visit No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        VisitorsLedger.RESET;
        VisitorsLedger.SETRANGE(VisitorsLedger."ID No.", '');
        IF VisitorsLedger.COUNT > 10 THEN ERROR('There are some unused records');

        IF "Visit No." = '' THEN BEGIN
            IF GenLedgerSet.GET() THEN
                GenLedgerSet.TestField(GenLedgerSet."Visitor No.");
            NoSeriesMgt.InitSeries(GenLedgerSet."Visitor No.", xRec."No. Series", 0D, "Visit No.", "No. Series");
        END;
        "Transaction Date" := TODAY;
    end;



    var
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        GenLedgerSet: Record "FLT-Fleet Mgt Setup";
        VisitorsLedger: Record "Visitors Ledger";
        VisitorCard: Record "Visitor Card";
}

