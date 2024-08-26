table 50990 "POS Stock Header"
{
    LookupPageId = "POS Stock Header List";
    DrillDownPageId = "POS Stock Header List";
    fields
    {
        field(1; "No."; Code[20])
        {

        }
        field(2; "User ID"; Code[30])
        {

        }
        field(3; "Posting Date"; date)
        {

        }
        field(4; "Date and Time"; DateTime)
        {

        }
        field(5; "Description"; Text[150])
        {

        }

        field(6; Posted; Boolean)
        {

        }
        field(7; "Status"; Option)
        {
            OptionMembers = Pending,"Pending Approval",Approved;

        }
        field(50; "No. Series"; code[20])
        {

        }
        field(8; "Entry Type"; Enum "Item Ledger Entry Type")
        {
            Caption = 'Adjustment Type';
        }
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            PosSetup.GET;
            PosSetup.TESTFIELD(PosSetup."Stock Adjustment");
            NoSeriesMgt.InitSeries(PosSetup."Stock Adjustment", xRec."No. Series", 0D, "No.", "No. Series");
            "Description" := 'Stock Adjustment on ' + format(Today());
            "Posting Date" := Today();
            "User ID" := UserId;
            "Date and Time" := System.CurrentDateTime();
        END;

    end;

    trigger OnDelete()
    begin
        if Posted then
            Error('Sorry, you cannot detete posted items');
    end;

    var
        PosSetup: Record "POS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        stockLines: Record "POS Stock Lines";
        itemledger: Record "POS Item Ledger";
        posItem: Record "POS Items";

    procedure postStock()
    begin
        stockLines.Reset();
        stockLines.SetRange("Document No.", "No.");
        if stockLines.Find('-') then begin
            repeat
                itemledger.Init();
                itemledger."Entry No." := GetLastEntryNo + 1;
                itemledger."Item No." := stockLines."No.";
                itemledger."Document No." := stockLines."No." + stockLines."Document No.";
                itemledger."Entry Type" := "Entry Type";
                itemledger."Posting Date" := "Posting Date";
                itemledger.Quantity := stockLines.Quantity;
                posItem.Reset();
                posItem.SetRange("No.", stockLines."No.");
                if posItem.Find('-') then
                    itemledger.Description := posItem.Description;
                itemledger.Insert(true);
            until stockLines.Next() = 0;

            Posted := true;
            Status := Status::Approved;
            Rec.Modify(true);

        end;

    end;

    procedure clearStock()
    begin
        stockLines.Reset();
        stockLines.SetRange("Document No.", "No.");
        if stockLines.Find('-') then begin
            repeat
                itemledger.Init();
                itemledger."Entry No." := GetLastEntryNo + 1;
                itemledger."Item No." := stockLines."No.";
                itemledger."Document No." := stockLines."No." + stockLines."Document No.";
                itemledger."Entry Type" := itemledger."Entry Type"::"Stock Clearance";
                itemledger."Posting Date" := "Posting Date";
                stockLines.CalcFields(Inventory);
                itemledger.Quantity := (stockLines.Inventory) * -1;
                posItem.Reset();
                posItem.SetRange("No.", stockLines."No.");
                if posItem.Find('-') then
                    itemledger.Description := posItem.Description;
                itemledger.Insert(true);
            until stockLines.Next() = 0;

            Posted := true;
            Status := Status::Approved;
            Rec.Modify(true);

        end;

    end;

    procedure GetLastEntryNo(): Integer;
    var
        PosLedger: Record "POS Item Ledger";
    begin
        PosLedger.Reset();
        if PosLedger.FindLast() then
            exit(PosLedger."Entry No.")
        else
            exit(0);
    end;

}