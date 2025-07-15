#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 99408 "POS Sales Header"
{
    DrillDownPageID = "POS Receipts Header Lst";
    LookupPageID = "POS Receipts Header Lst";

    fields
    {
        field(1; "No."; Code[30])
        {
        }
        field(2; "Posting Description"; Text[100])
        {
        }
        field(3; "Total Amount"; Decimal)
        {
            CalcFormula = sum("POS Sales Lines"."Line Total" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(4; "Posting date"; Date)
        {
        }
        field(5; Cashier; Code[30])
        {
            TableRelation = "User Setup"."User ID" where("Is Cashier" = filter(false));
        }
        field(6; "Customer Type"; Option)
        {
            OptionCaption = 'Student,Staff';
            OptionMembers = Student,Staff;

            trigger OnValidate()
            begin
                PosSetup.Get;
                PosSetup.TestField("Students Cashbook");
                PosSetup.TestField("Students Sales Account");
                PosSetup.TestField("Staff Sales Account");
                PosSetup.TestField("Staff Cashbook");
                if "Customer Type" = "customer type"::Student then begin
                    Rec."Cash Account" := PosSetup."Cash Account";
                    Rec."Income Account" := PosSetup."Students Sales Account";
                end else
                    if "Customer Type" = "customer type"::Staff then begin
                        Rec."Cash Account" := PosSetup."Cash Account";
                        Rec."Income Account" := PosSetup."Staff Sales Account";
                    end;
                clearLines();
            end;
        }
        field(7; "Bank Account"; Code[30])
        {
            TableRelation = "Bank Account";
        }
        field(8; "Income Account"; Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(9; "Amount Paid"; Decimal)
        {

            trigger OnValidate()
            begin
                totamount := 0;
                posLines.Reset();
                posLines.SetRange("Document No.", Rec."No.");
                if posLines.Find('-') then begin
                    repeat
                        totamount := totamount + posLines."Line Total";
                    until posLines.Next() = 0;
                    if "Amount Paid" >= totamount then begin
                        Balance := "Amount Paid" - totamount;
                    end else
                        Error('The Amount Paid is Less');
                end;
            end;
        }
        field(10; Balance; Decimal)
        {
        }
        field(11; "No. Series"; Code[30])
        {
        }
        field(12; Posted; Boolean)
        {

            trigger OnValidate()
            begin
                if UserId <> 'KUCSERVER\ASIMBA' then begin
                    if Confirm('Mark this as posted ?', true) = false then Error('Cancelled');
                    if Rec.Posted = true then begin
                        Rec."Modified after posting" := true;
                        Rec."MAP BY" := UserId;
                        Rec."Date Time" := SYSTEM.CurrentDatetime;
                    end;
                end;
            end;
        }
        field(13; "Current Date Time"; DateTime)
        {
        }
        field(14; "Payment Method"; Option)
        {
            OptionCaption = 'Cash,Mpesa,Credit,ECITIZEN';
            OptionMembers = Cash,Mpesa,Credit,ECITIZEN;
        }
        field(15; "M-Pesa Transaction Number"; Code[100])
        {
            TableRelation = if ("M-pesa Trans Missing" = filter(false)) "PesaFlow Integration".PaymentRefID where(ServiceID = filter('2729111'),
                                                                                                               "Selected And Posted" = filter(false),
                                                                                                               "Date Received" = field("Posting date"));

            trigger OnValidate()
            begin
                if Rec."M-Pesa Transaction Number" = '' then exit;
                if Rec."M-pesa Trans Missing" = false then begin
                    Clear(bnkLedger);
                    bnkLedger.Reset;
                    bnkLedger.SetRange("Document No.", "M-Pesa Transaction Number");
                    if bnkLedger.Find('-') then Error('Mpesa Transaction Code Already Exist');
                    if Rec."Payment Method" = Rec."payment method"::Cash then Error('Cash Payments have no Transaction Code');

                    Rec.CalcFields("Receipt Amount");
                    if Rec."Receipt Amount" = 0 then Error('Details are missing.');
                    Clear(PesaFlowIntergration);
                    PesaFlowIntergration.Reset;
                    PesaFlowIntergration.SetRange(PaymentRefID, Rec."M-Pesa Transaction Number");

                    if PesaFlowIntergration.Find('-') then begin
                        if PesaFlowIntergration.InvoiceAmount < Rec."Receipt Amount" then Error('Receipt amount is less than invoiced amount.');
                    end; //else
                         //Error('Invalid transaction code');
                    Rec.Validate(Rec."Amount Paid", Rec."Receipt Amount");
                end;
            end;
        }
        field(16; "Till Number"; Code[20])
        {
            TableRelation = "Mpesa Bank Accounts Setup"."Mpesa Code";

            trigger OnValidate()
            begin
                bnkAcc.Get("Till Number");
                "Bank Account" := bnkAcc."Bank Account Code";
            end;
        }
        field(17; "Cash Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(18; Location; Code[30])
        {
            TableRelation = Location;
        }
        field(19; "Modified after posting"; Boolean)
        {
        }
        field(20; "MAP BY"; Code[30])
        {
        }
        field(21; "Date Time"; DateTime)
        {
        }
        field(22; Batch_Id; Integer)
        {
        }
        field(23; "Created By"; Code[20])
        {
        }
        field(24; "Created Date"; Date)
        {
        }
        field(25; "Created Time"; Time)
        {
        }
        field(26; "Receipt Amount"; Decimal)
        {
            CalcFormula = sum("POS Sales Lines"."Line Total" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(27; "Preliminary Posted"; Boolean)
        {
        }
        field(28; "Batch Posted"; Boolean)
        {
        }
        field(29; "Batch PostedDate"; Date)
        {
        }
        field(30; "Batch Posted By"; Code[20])
        {
        }
        field(31; "Batch Posted Time"; Time)
        {
        }
        field(32; "Receipt Posted to Ledger"; Boolean)
        {
            CalcFormula = exist("Bank Account Ledger Entry" where("External Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(33; "M-pesa Trans Missing"; Boolean)
        {
        }
        field(34; "Ecitizen Invoice No"; Text[50])
        {
        }
        field(35; "Phone No"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(key2; "M-Pesa Transaction Number")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //IF CONFIRM('Delete This Record ?', TRUE) = FALSE THEN ERROR('Cancelled');
        if UserId <> 'KUCSERVER\ASIMBA' then Error('Permission Denied, Sorry');
        PosLine.Reset();
        PosLine.SetRange("Document No.", Rec."No.");
        PosLine.DeleteAll();
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            PosSetup.Get;
            PosSetup.TestField(PosSetup."Sales No.");
            NoSeriesMgt.InitSeries(PosSetup."Sales No.", xRec."No. Series", 0D, "No.", "No. Series");
            "Posting Description" := 'Cafe Food sales on ' + Format(Today());
            "Posting date" := Today();
            Cashier := UserId;
            "Current Date Time" := SYSTEM.CurrentDatetime();
            "Cash Account" := PosSetup."Cash Account";
            Rec."Bank Account" := PosSetup."Students Cashbook";
            // Rec."Income Account" := PosSetup."Students Sales Account";
        end;
        officeTemp2.Get(UserId);
        officeTemp2.TestField("Default Direct Sales Location");
        Location := officeTemp2."Default Direct Sales Location";
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
        bnkAcc: Record "Mpesa Bank Accounts Setup";
        officeTemp2: Record "FIN-Cash Office User Template";
        salesHeader: Record "POS Sales Header";
        bnkLedger: Record "Bank Account Ledger Entry";
        UserSetup: Record "User Setup";
        CountedRecs: Integer;
        TotLoops: Integer;
        Dialogs: Dialog;
        PesaFlowIntergration: Record "PesaFlow Intergration";


    procedure clearLines()
    begin
    end;


    procedure PostSale()
    var
        Batchids: Integer;
        CafeteriaSalesBatches: Record "Cafeteria Sales Batches";
        PesaFlowIntergration2: Record "PesaFlow Intergration";
    begin
        Rec.Validate("M-Pesa Transaction Number");
        if Rec."M-Pesa Transaction Number" <> '' then Rec.TestField("Till Number");
        Clear(Batchids);
        Clear(bnkLedger);
        bnkLedger.Reset;
        bnkLedger.SetRange("Document No.", Rec."No.");
        if not bnkLedger.Find('-') then begin
            Clear(CafeteriaSalesBatches);
            CafeteriaSalesBatches.Reset;
            CafeteriaSalesBatches.SetRange(Batch_Date, Today);
            CafeteriaSalesBatches.SetRange(User_Id, UserId);
            CafeteriaSalesBatches.SetRange("Batch Status", CafeteriaSalesBatches."batch status"::Posted);
            if CafeteriaSalesBatches.Find('+') then begin
                Batchids := CafeteriaSalesBatches.Batch_Id;
                CafeteriaSalesBatches."Batch Status" := CafeteriaSalesBatches."batch status"::New;
                CafeteriaSalesBatches.Modify;
            end else begin

                Clear(CafeteriaSalesBatches);
                CafeteriaSalesBatches.Reset;
                CafeteriaSalesBatches.SetRange(Batch_Date, Today);
                CafeteriaSalesBatches.SetRange(User_Id, UserId);
                CafeteriaSalesBatches.SetRange("Batch Status", CafeteriaSalesBatches."batch status"::New);
                if CafeteriaSalesBatches.Find('+') then begin
                    Batchids := CafeteriaSalesBatches.Batch_Id;
                    CafeteriaSalesBatches.Modify;
                end;
            end;
            if Batchids = 0 then Batchids := 1;
            CafeteriaSalesBatches.Init;
            CafeteriaSalesBatches.User_Id := UserId;
            CafeteriaSalesBatches.Batch_Date := Today;
            CafeteriaSalesBatches.Batch_Id := Batchids;
            if CafeteriaSalesBatches.Insert then;
            Rec.Batch_Id := Batchids;


            totamount := 0;
            //IF CONFIRM('Post Receipt ?',TRUE)=FALSE THEN ERROR('cancelled');
            if "Payment Method" = "payment method"::Mpesa then begin
                Rec.TestField("M-Pesa Transaction Number");
            end;
            if Rec."Amount Paid" <= 0 then Error('Invalid Amount Paid');

            posLines.Reset();
            posLines.SetRange("Document No.", Rec."No.");
            if posLines.Find('-') then begin
                repeat
                    totamount := totamount + posLines."Line Total";
                until posLines.Next() = 0;
                if "Amount Paid" < totamount then
                    Error('The Amount Paid is Less');
            end;

            posLines.Reset();
            posLines.SetRange("Document No.", "No.");
            if posLines.Find('-') then begin
                repeat
                    itemledger.Init();
                    itemledger."Entry No." := GetLastEntryNo + 1;
                    itemledger."Item No." := posLines."No.";
                    itemledger."Document No." := posLines."No." + posLines."Document No.";
                    itemledger."Entry Type" := itemledger."entry type"::Consumption;
                    itemledger."Posting Date" := "Posting date";
                    itemledger.Quantity := -posLines.Quantity;
                    itemledger.Description := posLines.Description;
                    itemledger.Location := Location;
                    itemledger.Insert(true);

                    posLines.Posted := true;
                    posLines.Modify();
                until posLines.Next() = 0;
                Posted := true;
                "Posting date" := Today;
                Clear(PesaFlowIntergration2);
                PesaFlowIntergration2.Reset;
                PesaFlowIntergration2.SetRange(PesaFlowIntergration2.PaymentRefID, Rec."M-Pesa Transaction Number");
                if PesaFlowIntergration2.Find('-') then begin
                    PesaFlowIntergration2.Posted := true;
                    PesaFlowIntergration2.Modify;
                end;
                Modify(true);

            end;
        end else
            Error('Already posted!');
    end;


    procedure GetLastEntryNo(): Integer
    begin
        PosLedger.Reset();
        if PosLedger.FindLast() then
            exit(PosLedger."Entry No.")
        else
            exit(0);
    end;


    procedure PostReceiptToJournal(CafeteriaSalesBatches: Record "Cafeteria Sales Batches")
    var
        LineNos: Integer;
        POSSalesHeader: Record "POS Sales Header";
        TotalRecords: Integer;
        RemainingRecords: Integer;
        ProcessedRecord: Integer;
        PesaFlowIntergration2: Record "PesaFlow Intergration";
    begin
        //Rec.VALIDATE("M-Pesa Transaction Number");
        Clear(CountedRecs);
        Clear(TotalRecords);
        Clear(ProcessedRecord);
        Clear(RemainingRecords);
        Clear(ProcessedRecord);
        Dialogs.Open('#1#################################################\' +
        '#2#################################################\' +
        '#3#################################################\' +
        '#4#################################################\');
        if not officeTemp2.Get(UserId) then Error('Access denied!');
        if officeTemp2.Find('-') then begin
            officeTemp2.TestField("Receipt Journal Template");
            officeTemp2.TestField("Receipt Journal Batch");
            // Delete Lines Present on the General Journal Line    LineNos
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", officeTemp2."Receipt Journal Template");
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", officeTemp2."Receipt Journal Batch");
            GenJnLine.DeleteAll;

            Batch.Init;
            Batch."Journal Template Name" := officeTemp2."Receipt Journal Template";
            Batch.Name := officeTemp2."Receipt Journal Batch";
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
                Batch.Insert;
        end;
        Clear(UserSetup);
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.Find('-') then begin end else Error('Access denied!');
        Clear(POSSalesHeader);
        POSSalesHeader.Reset;
        POSSalesHeader.SetRange(Batch_Id, CafeteriaSalesBatches.Batch_Id);
        POSSalesHeader.SetRange(Cashier, CafeteriaSalesBatches.User_Id);
        POSSalesHeader.SetRange("Posting date", CafeteriaSalesBatches.Batch_Date);
        //POSSalesHeader.SETRANGE(,FALSE);
        POSSalesHeader.SetRange(Posted, true);
        if POSSalesHeader.Find('-') then begin
            CountedRecs := POSSalesHeader.Count;
            TotalRecords := CountedRecs;
            RemainingRecords := CountedRecs;
            Dialogs.Update(1, 'Posting batch....');
            Dialogs.Update(2, 'Total Record: ' + Format(TotalRecords));
            repeat
            begin
                ProcessedRecord += 1;
                RemainingRecords -= 1;
                Dialogs.Update(3, 'Processed: ' + Format(ProcessedRecord));
                Dialogs.Update(4, 'Remaining: ' + Format(RemainingRecords));
                POSSalesHeader.CalcFields("Receipt Posted to Ledger");
                if POSSalesHeader."Receipt Posted to Ledger" = false then begin

                    LineNo := LineNo + 1000;
                    GenJnLine.Init;
                    GenJnLine."Journal Template Name" := officeTemp2."Receipt Journal Template";
                    GenJnLine."Journal Batch Name" := officeTemp2."Receipt Journal Batch";
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Document Type" := GenJnLine."document type"::Payment;
                    GenJnLine."Shortcut Dimension 1 Code" := '020';

                    GenJnLine."Account Type" := GenJnLine."account type"::"Bank Account";
                    if POSSalesHeader."Payment Method" = POSSalesHeader."payment method"::Cash then begin
                        GenJnLine."Account No." := POSSalesHeader."Cash Account";
                    end else if (POSSalesHeader."Payment Method" = POSSalesHeader."payment method"::Mpesa) then begin
                        GenJnLine."Account No." := POSSalesHeader."Bank Account";
                    end else if (POSSalesHeader."Payment Method" = POSSalesHeader."payment method"::ECITIZEN) then begin
                        GenJnLine."Account No." := POSSalesHeader."Bank Account";
                    end else
                        Error('Option Not Activated');
                    GenJnLine."Posting Date" := POSSalesHeader."Posting date";
                    if POSSalesHeader."M-Pesa Transaction Number" <> '' then
                        GenJnLine."Document No." := POSSalesHeader."M-Pesa Transaction Number"
                    else
                        GenJnLine."Document No." := POSSalesHeader."No.";
                    GenJnLine."External Document No." := POSSalesHeader."No.";
                    GenJnLine.Description := 'Food sales for ' + Format(POSSalesHeader."Customer Type");
                    POSSalesHeader.CalcFields("Total Amount");
                    if ProcessedRecord = 60 then
                        ProcessedRecord := ProcessedRecord;
                    GenJnLine.Amount := POSSalesHeader."Total Amount";
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Bal. Account Type" := GenJnLine."bal. account type"::"G/L Account";
                    GenJnLine."Bal. Account No." := POSSalesHeader."Income Account";
                    GenJnLine."User ID" := POSSalesHeader.Cashier;
                    if GenJnLine.Amount <> 0 then begin
                        GenJnLine.Insert;
                        POSSalesHeader."Batch Posted" := true;
                        POSSalesHeader."Batch PostedDate" := Today;
                        POSSalesHeader."Batch Posted By" := UserId;
                        POSSalesHeader."Batch Posted Time" := Time;
                        POSSalesHeader.Modify;

                        Clear(PesaFlowIntergration2);
                        PesaFlowIntergration2.Reset;
                        PesaFlowIntergration2.SetRange(PesaFlowIntergration2.PaymentRefID, POSSalesHeader."M-Pesa Transaction Number");
                        if PesaFlowIntergration2.Find('-') then begin
                            PesaFlowIntergration2.Posted := true;
                            PesaFlowIntergration2.Modify;
                        end;
                    end;
                end;
            end;
            until POSSalesHeader.Next = 0;
        end;
        Dialogs.Close;
        Clear(GenJnLine);
        GenJnLine.Reset;
        GenJnLine.SetRange(GenJnLine."Journal Template Name", officeTemp2."Receipt Journal Template");
        GenJnLine.SetRange(GenJnLine."Journal Batch Name", officeTemp2."Receipt Journal Batch");
        if GenJnLine.FindSet() then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnLine);
            // Mark Batch as posted
            CafeteriaSalesBatches."Posted By" := UserId;
            CafeteriaSalesBatches."Batch Status" := CafeteriaSalesBatches."batch status"::Posted;
            CafeteriaSalesBatches."Date Posted" := Today;
            CafeteriaSalesBatches."Time Posted" := Time;
            CafeteriaSalesBatches.Modify;
        end else
            Error('Nothing to Post!');
        Message('Receipts batch posted successfully!');
    end;
}

