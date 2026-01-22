table 50981 "Visits Ledger"
{
    Caption = 'Visits Ledger';

    fields
    {
        field(1; "Visit No."; Code[250])
        {
        }
        field(2; "Staff No."; Code[10])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin
                StaffLedger.RESET;
                StaffLedger.SETRANGE(StaffLedger."Staff No.", "Staff No.");
                StaffLedger.SETRANGE(StaffLedger."Checked Out", FALSE);
                IF StaffLedger.COUNT > 0 THEN ERROR('Staff must be checked out first');

                // Pick the details from the Visitor Card
                IF StaffCard.GET("Staff No.") THEN BEGIN
                    "Full Name" := StaffCard."First Name" + ' ' + StaffCard."Middle Name" + ' ' + StaffCard."Last Name";
                    Company := 'Mukurweini Wakulima Dairy';
                    "Phone No." := StaffCard."Cellular Phone Number";
                    Email := StaffCard."Company E-Mail";
                    //Category := StaffCard."Terms of Service";
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
            TableRelation = "Dimension Value".Code; //WHERE(Dimension Code=FILTER(DEPARTMENT));
        }
        field(8; "Department Name"; Text[150])
        {
            CalcFormula = Lookup("Dimension Value".Name); //WHERE (Code=FIELD(Office Station/Department),
                                                          //    Dimension Code=FILTER(DEPARTMENTS)));
            FieldClass = FlowField;
        }
        field(9; "Signed in by"; Code[50])
        {
        }
        field(10; "Transaction Date"; Date)
        {
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
        field(17; Category; Code[20])
        {
            //TableRelation = "HRM-Staff Categories"."Category Code";
        }
        field(60; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
    }

    keys
    {
        key(Key1; "Visit No.")
        {
        }
        key(Key2; "Staff No.", "Visit No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        StaffLedger.RESET;
        StaffLedger.SETRANGE(StaffLedger."Staff No.", '');
        IF StaffLedger.COUNT > 1 THEN ERROR('There are some unused records');

        IF "Visit No." = '' THEN BEGIN
            IF GenLedgerSet.GET() THEN
                GenLedgerSet.TESTFIELD(GenLedgerSet."Staff Register Nos");
            NoSeriesMgt.InitSeries(GenLedgerSet."Staff Register Nos", xRec."No. Series", 0D, "Visit No.", "No. Series");
        END;
        "Transaction Date" := TODAY;
    end;

    var
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        GenLedgerSet: Record "FLT-Fleet Mgt Setup";
        StaffLedger: Record "Visits Ledger";
        StaffCard: Record "HRM-Employee C";
}

