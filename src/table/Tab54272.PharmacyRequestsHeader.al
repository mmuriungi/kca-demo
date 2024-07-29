table 54272 "Pharmacy Requests Header"
{
    LookupPageId = "Pharmacy Request List";
    DrillDownPageId = "Pharmacy Request List";

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
            HMSSetup.TESTFIELD(HMSSetup."Pharmacy Requisition");
            NoSeriesMgt.InitSeries(HMSSetup."Pharmacy Requisition", xRec."No. Series", 0D, "No.", "No. Series");
            "Description" := 'Pharmacy Requisitions on ' + format(Today());
            "Posting Date" := Today();
            "User ID" := UserId;
            "Date and Time" := System.CurrentDateTime();
        END;

    end;

    var
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RequestLines: Record "Pharmacy Requests Lines";
        itemledger: Record "Pharmacy Item Ledger";
        PharItem: Record "Pharmacy Items";

    procedure postRequisition()
    begin
        if Posted = false then begin
            //if Status = Status::Approved then begin
            RequestLines.Reset();
            RequestLines.SetRange("Document No.", "No.");
            if RequestLines.Find('-') then begin
                repeat
                    itemledger.Init();
                    itemledger."Entry No." := GetLastEntryNo + 1;
                    itemledger."Item No." := RequestLines."No.";
                    itemledger."Document No." := RequestLines."No." + RequestLines."Document No.";
                    itemledger."Entry Type" := itemledger."Entry Type"::"Negative Adjmt.";
                    itemledger."Posting Date" := "Posting Date";
                    itemledger.Quantity := -RequestLines.Quantity;
                    PharItem.Reset();
                    PharItem.SetRange("No.", RequestLines."No.");
                    if PharItem.Find('-') then
                        itemledger.Description := PharItem.Description;
                    itemledger.Insert(true);
                until RequestLines.Next() = 0;

                Posted := true;
                Status := Status::Approved;
                Rec.Modify(true);
                Message('Stock Posted')
                //end;
            end;

        end else
            Error('Already Posted');
    end;

    procedure GetLastEntryNo(): Integer;
    var
        PharLedger: Record "Pharmacy Item Ledger";
    begin
        PharLedger.Reset();
        if PharLedger.FindLast() then
            exit(PharLedger."Entry No.")
        else
            exit(0);
    end;

}