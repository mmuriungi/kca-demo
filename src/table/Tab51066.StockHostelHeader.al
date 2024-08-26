table 51066 "Stock Hostel Header"
{

    LookupPageId = "Pharmacy Stock Header List";
    DrillDownPageId = "Pharmacy Stock Header List";

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
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            HMSSetup.GET;
            HMSSetup.TESTFIELD(HMSSetup."Pharmacy Stock");
            NoSeriesMgt.InitSeries(HMSSetup."Pharmacy Stock", xRec."No. Series", 0D, "No.", "No. Series");
            "Description" := 'Stock Adjustment on ' + format(Today());
            "Posting Date" := Today();
            "User ID" := UserId;
            "Date and Time" := System.CurrentDateTime();
        END;

    end;

    var
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        stockLines: Record "Pharmacy Stock Lines";
        stocklinesh: record "hostel stock lines";
        itemledger: Record "Pharmacy Item Ledger";
        HitemLedger: record "Hostel Ledger Entries ";
        PharItem: Record "Pharmacy Items";
        hostitem: Record "Hostel Sub-Store";

    procedure postStock()
    begin
        if Posted = false then begin
            stockLines.Reset();
            stockLines.SetRange("Document No.", "No.");
            if stockLines.Find('-') then begin
                repeat
                    itemledger.Init();
                    itemledger."Entry No." := GetLastEntryNo + 1;
                    itemledger."Item No." := stockLines."No.";
                    itemledger."Document No." := stockLines."No." + stockLines."Document No.";
                    itemledger."Entry Type" := itemledger."Entry Type"::"Positive Adjmt.";
                    itemledger."Posting Date" := "Posting Date";
                    itemledger.Quantity := stockLines.Quantity;
                    PharItem.Reset();
                    PharItem.SetRange("No.", stockLines."No.");
                    if PharItem.Find('-') then
                        itemledger.Description := PharItem.Description;
                    itemledger.Insert(true);
                until stockLines.Next() = 0;

                Posted := true;
                Status := Status::Approved;
                Rec.Modify(true);
                Message('Stock Posted')
            end;
        end else
            Error('Already Posted');
    end;

    procedure AdjustHostel()
    begin
        if Posted = false then begin
            stockLinesh.Reset();
            stocklinesh.SetRange("Document No.", "No.");
            if stocklinesh.Find('-') then begin
                repeat
                    hitemledger.Init();
                    hitemledger."Entry No." := GetLastEntryNo + 1;
                    hitemledger."Item No." := stockLinesh."No.";
                    hitemledger."Document No." := stockLinesh."No." + stockLinesh."Document No.";
                    hitemledger."Entry Type" := HitemLedger."Entry Type"::"Positive Adjmt.";
                    hitemledger."Posting Date" := "Posting Date";
                    hitemledger.Quantity := stockLinesh.Quantity;
                    hostitem.Reset();
                    hostitem.SetRange("No.", stockLinesh."No.");
                    if hostitem.Find('-') then
                        hitemledger.Description := hostitem.Description;
                    hitemledger.Insert(true);
                until stockLinesh.Next() = 0;

                Posted := true;
                Status := Status::Approved;
                Rec.Modify(true);
                Message('Stock Posted')
            end;
        end else
            Error('Already Posted');
    end;

    procedure GetLastEntryNo(): Integer;
    var
        PosLedger: Record "Pharmacy Item Ledger";
    begin
        PosLedger.Reset();
        if PosLedger.FindLast() then
            exit(PosLedger."Entry No.")
        else
            exit(0);
    end;

}
