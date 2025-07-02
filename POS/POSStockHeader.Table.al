#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 99405 "POS Stock Header"
{

    fields
    {
        field(1; "No."; Code[30])
        {
        }
        field(2; "User ID"; Code[30])
        {
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; "Date and Time"; DateTime)
        {
        }
        field(5; Description; Text[100])
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; Status; Option)
        {
            OptionCaption = 'Pending,Pending Approval,Approved';
            OptionMembers = Pending,"Pending Approval",Approved;
        }
        field(8; "No. Series"; Code[30])
        {
        }
        field(9; Location; Code[30])
        {
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if UserId <> 'KUCSERVER\ASIMBA' then Error('Cancelled');
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            PosSetup.Get;
            PosSetup.TestField(PosSetup."Stock Adjustment");
            NoSeriesMgt.InitSeries(PosSetup."Stock Adjustment", xRec."No. Series", 0D, "No.", "No. Series");
            Description := 'Stock Adjustment on ' + Format(Today());
            "Posting Date" := Today();
            "User ID" := UserId;
            "Date and Time" := SYSTEM.CurrentDatetime();
            officeTemp.Get("User ID");
            Location := officeTemp."Default Direct Sales Location";
        end;
    end;

    var
        PosSetup: Record "POS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        posLines: Record "POS Sales Lines";
        GenJnLine: Record "Gen. Journal Line";
        Batch: Record "Gen. Journal Batch";
        LineNo: Integer;
        itemledger: Record "POS Item Ledger";
        posItems: Record "POS Items";
        PosLedger: Record "POS Item Ledger";
        PosLine: Record "POS Sales Lines";
        totamount: Decimal;
        stockLines: Record "POS Stock Lines";
        posItem: Record "POS Items";
        officeTemp: Record "FIN-Cash Office User Template";


    procedure GetLastEntryNo(): Integer
    begin
        PosLedger.Reset();
        if PosLedger.FindLast() then
            exit(PosLedger."Entry No.")
        else
            exit(0);
    end;


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
                itemledger."Entry Type" := itemledger."entry type"::"Food Upload";
                itemledger."Posting Date" := "Posting Date";
                itemledger.Quantity := stockLines.Quantity;
                itemledger.Location := Location;
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
}

