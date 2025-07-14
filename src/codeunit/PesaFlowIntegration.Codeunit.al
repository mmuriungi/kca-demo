#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50152 "PesaFlow Integration"
{

    trigger OnRun()
    begin
    end;

    var
        PesaFlowIntegration: Record "PesaFlow Integration";
        PesaFlowInvoices: Record "PesaFlow Invoices";

    Procedure PostBatchPesaFlow()
    var
        pflow: Record "PesaFlow Integration";
        bsetup: Record "E-Citizen Services";
        StudPay: Record "ACA-Std Payments";
    begin

        if UserId <> 'FRANKIE' then Error('');

        pflow.RESET;
        pflow.SETRANGE(Posted, FALSE);
        IF pflow.FIND('-') THEN BEGIN
            REPEAT

                StudPay.RESET;
                StudPay.SETRANGE(StudPay."Student No.", pflow.CustomerRefNo);
                IF StudPay.FIND('-') THEN
                    StudPay.DELETEALL;

                StudPay.INIT;
                StudPay."Student No." := pflow.CustomerRefNo;
                StudPay."User ID" := USERID;
                StudPay."Payment Mode" := StudPay."Payment Mode"::"Direct Bank Deposit";
                StudPay."Cheque No" := pflow.PaymentRefID;
                StudPay."Drawer Name" := pflow."Customer Name";
                StudPay."Payment By" := pflow."Customer Name";
                bsetup.RESET;
                bsetup.SETRANGE("Service Code", pflow.ServiceID);
                IF bsetup.FIND('-') THEN
                    StudPay."Bank No." := bsetup."Bank Code"
                ELSE
                    ERROR('%1%2%3', 'Service ID ', pflow.ServiceID, ' has not been setup with an associated bank');
                if pflow.PaidAmount > 50 then
                    StudPay."Amount to pay" := pflow.PaidAmount - 50
                else
                    StudPay."Amount to pay" := pflow.PaidAmount;
                StudPay.VALIDATE(StudPay."Amount to pay");
                StudPay."Transaction Date" := pflow."Date Received";
                StudPay.VALIDATE(StudPay."Auto Post PesaFlow");
                StudPay.INSERT;
                pflow.Posted := TRUE;
                pflow.MODIFY;
            until pflow.Next() = 0;
        end;

        Message('Complete');
    end;

    procedure InsertApplicationFee(paymentrefid: Code[50]; customerrefno: Code[20]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; paymentchannel: Text; paymentdate: Text; status: Text) inserted: Boolean
    var
        applicheader: Record "ACA-Applic. Form Header";
        pesaflowserviceCodes: Record "Pesa-Flow_Service-IDs";
    begin
        applicheader.RESET;
        applicheader.SETRANGE("Application No.", customerrefno);
        IF applicheader.FIND('-') THEN BEGIN
            PesaFlowIntegration.RESET;
            PesaFlowIntegration.SETRANGE(PaymentRefID, paymentrefid);
            IF NOT PesaFlowIntegration.FIND('-') THEN BEGIN
                PesaFlowIntegration.INIT;
                PesaFlowIntegration.PaymentRefID := paymentrefid;
                PesaFlowIntegration.CustomerRefNo := applicheader."Application No.";
                PesaFlowIntegration."Customer Name" := applicheader."Full Names";
                PesaFlowIntegration.InvoiceNo := invoiceno;
                PesaFlowIntegration.InvoiceAmount := invoiceamt;
                PesaFlowIntegration.PaidAmount := paidamt;
                PesaFlowIntegration.ServiceID := GetServiceID(applicheader."Application No.");
                PesaFlowIntegration.Description := 'Payment for course application fee';
                PesaFlowIntegration.PaymentChannel := paymentchannel;
                PesaFlowIntegration.PaymentDate := paymentdate;
                PesaFlowIntegration.Status := status;
                PesaFlowIntegration."Date Received" := TODAY;
                PesaFlowIntegration.INSERT;
                inserted := TRUE;
            END ELSE BEGIN
                ERROR('invalid transaction id');
            END;
            if inserted then begin
                applicheader."Application Fee Paid" := true;
                applicheader.Modify;
            end;
        END ELSE BEGIN
            ERROR('invalid invoice');
        END
    end;

    procedure GetApplicationCategory(applicationNo: code[25]) msg: Text
    var
        Applic: Record "ACA-Applic. Form Header";
        Programme: Record "ACA-Programme";
    begin
        applic.Reset();
        Applic.SetRange("Application No.", applicationNo);
        if applic.FindFirst() then begin
            Programme.Reset();
            Programme.SetRange(Code, Applic."First Degree Choice");
            if programme.FindFirst() then begin
                msg := Format(Programme.Levels);
            end;
        end;
    end;

    procedure GetServiceID(applicationNo: Code[25]): Code[25]
    var
        Applic: Record "ACA-Applic. Form Header";
        Programme: Record "ACA-Programme";
        serviceIDs: Record "Pesa-Flow_Service-IDs";
    begin
        applic.Reset();
        Applic.SetRange("Application No.", applicationNo);
        if applic.FindFirst() then begin
            Programme.Reset();
            Programme.SetRange(Code, Applic."First Degree Choice");
            if programme.FindFirst() then begin
                serviceIDs.Reset();
                serviceIDs.SetRange("Programme Category", Programme.Levels);
                if serviceIDs.FindFirst() then begin
                    exit(serviceIDs.Service_ID);
                end;
            end;
        end;
    end;

    procedure InsertAccomodationFee(paymentrefid: Code[20]; customerref: Code[50]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; channel: Text; paymentdate: Text; status: Text) inserted: Boolean
    var
        KUCCPSRaw: Record "KUCCPS Imports";
        CoreBankingDetails: Record Core_Banking_Details;
        CoreBankingHeader: Record "Core_Banking Header";
        PesaFlow_ServiceIDs: Record "Pesa-Flow_Service-IDs";
        WebPortal: Codeunit webportals;
    begin
        Clear(PesaFlowInvoices);
        PesaFlowInvoices.Reset;
        PesaFlowInvoices.SetRange(BillRefNo, customerref);
        if PesaFlowInvoices.Find('-') then begin
            Clear(PesaFlowIntegration);
            PesaFlowIntegration.Reset;
            PesaFlowIntegration.SetRange(PaymentRefID, paymentrefid);
            if not PesaFlowIntegration.Find('-') then begin
                PesaFlowIntegration.Init;
                PesaFlowIntegration.PaymentRefID := paymentrefid;
                PesaFlowIntegration.CustomerRefNo := PesaFlowInvoices.CustomerRefNo;
                PesaFlowIntegration."Customer Name" := PesaFlowInvoices.CustomerName;
                PesaFlowIntegration.InvoiceNo := invoiceno;
                PesaFlowIntegration.InvoiceAmount := invoiceamt;
                PesaFlowIntegration.PaidAmount := paidamt;
                PesaFlowIntegration.ServiceID := PesaFlowInvoices.ServiceID;
                PesaFlowIntegration.Description := PesaFlowInvoices.Description;
                PesaFlowIntegration.PaymentChannel := channel;
                PesaFlowIntegration.PaymentDate := paymentdate;
                PesaFlowIntegration.Status := status;
                PesaFlowIntegration."Date Received" := Today;
                if PesaFlowIntegration.Insert then begin
                    inserted := true;
                    // Get the Bank Account Mapped to the pesa Flow service Id
                    Clear(PesaFlow_ServiceIDs);
                    PesaFlow_ServiceIDs.Reset;
                    PesaFlow_ServiceIDs.SetRange(Service_ID, PesaFlowInvoices.ServiceID);
                    if not (PesaFlow_ServiceIDs.Find('-')) then Error('Invalid service ID');
                    PesaFlow_ServiceIDs.TestField(Bank_Id);
                    PesaFlow_ServiceIDs.CalcFields("Bank Name");
                    //post to corebanking
                    CoreBankingHeader.Init;
                    CoreBankingHeader."Created By" := UserId;
                    CoreBankingHeader.Bank_Code := PesaFlow_ServiceIDs.Bank_Id;
                    CoreBankingHeader."Created By" := UserId;
                    CoreBankingHeader."Time Created" := Time;
                    CoreBankingHeader."Date Created" := Today;
                    CoreBankingHeader."Statement No" := 'PESAF_INT' + PesaFlow_ServiceIDs.Bank_Id;
                    if CoreBankingHeader.Insert then;
                    Clear(CoreBankingDetails);
                    CoreBankingDetails.Init;
                    CoreBankingDetails.Bank_Code := PesaFlow_ServiceIDs.Bank_Id;
                    CoreBankingDetails."Transaction Number" := paymentrefid;
                    CoreBankingDetails."Statement No" := 'PESAF_INT' + PesaFlow_ServiceIDs.Bank_Id;
                    CoreBankingDetails."Transaction Date" := ConvertToDate(paymentdate);//TODAY;
                    CoreBankingDetails."Trans. Amount" := paidamt;
                    CoreBankingDetails."Transaction Description" := 'Fee Receipt';
                    CoreBankingDetails."Student No." := PesaFlowInvoices.CustomerRefNo;
                    CoreBankingDetails."Posting Status" := CoreBankingDetails."posting status"::New;
                    if CoreBankingDetails.Insert then begin
                        PesaFlowIntegration.Posted := true;
                        PesaFlowIntegration.Modify;
                        CoreBankingDetails.PostReceiptsFromBuffer(CoreBankingDetails);
                    end else
                        Error('Posting error!');
                end;
            end else begin
                Error('invalid transaction id');
            end;
        end else begin
            /*ERROR('invalid invoice');

            END*/
            KUCCPSRaw.Reset;
            KUCCPSRaw.SetRange(Admin, customerref);
            if KUCCPSRaw.Find('-') then begin
                PesaFlowIntegration.Reset;
                PesaFlowIntegration.SetRange(PaymentRefID, paymentrefid);
                if not PesaFlowIntegration.Find('-') then begin
                    PesaFlowIntegration.Init;
                    PesaFlowIntegration.PaymentRefID := paymentrefid;
                    PesaFlowIntegration.CustomerRefNo := customerref;
                    PesaFlowIntegration."Customer Name" := KUCCPSRaw.Names;
                    PesaFlowIntegration.InvoiceNo := invoiceno;
                    PesaFlowIntegration.InvoiceAmount := invoiceamt;
                    PesaFlowIntegration.PaidAmount := paidamt;
                    PesaFlowIntegration.ServiceID := '2729151';
                    PesaFlowIntegration.Description := 'Payment for hostel charges';
                    PesaFlowIntegration.PaymentChannel := channel;
                    PesaFlowIntegration.PaymentDate := paymentdate;
                    PesaFlowIntegration."Date Received" := Today;
                    PesaFlowIntegration.Status := status;
                    if PesaFlowIntegration.Insert then begin
                        inserted := true;
                        // Get the Bank Account Mapped to the pesa Flow service Id
                        Clear(PesaFlow_ServiceIDs);
                        PesaFlow_ServiceIDs.Reset;
                        PesaFlow_ServiceIDs.SetRange(Service_ID, '2729151');
                        if not (PesaFlow_ServiceIDs.Find('-')) then Error('Invalid service ID');
                        PesaFlow_ServiceIDs.TestField(Bank_Id);
                        PesaFlow_ServiceIDs.CalcFields("Bank Name");
                        //post to corebanking
                        CoreBankingHeader.Init;
                        CoreBankingHeader."Created By" := UserId;
                        CoreBankingHeader.Bank_Code := PesaFlow_ServiceIDs.Bank_Id;
                        CoreBankingHeader."Created By" := UserId;
                        CoreBankingHeader."Time Created" := Time;
                        CoreBankingHeader."Date Created" := Today;
                        CoreBankingHeader."Statement No" := 'PESAF_INT' + PesaFlow_ServiceIDs.Bank_Id;
                        if CoreBankingHeader.Insert then;
                        Clear(CoreBankingDetails);
                        CoreBankingDetails.Init;
                        CoreBankingDetails.Bank_Code := PesaFlow_ServiceIDs.Bank_Id;
                        CoreBankingDetails."Transaction Number" := paymentrefid;
                        CoreBankingDetails."Statement No" := 'PESAF_INT' + PesaFlow_ServiceIDs.Bank_Id;
                        CoreBankingDetails."Transaction Date" := ConvertToDate(paymentdate);//TODAY;
                        CoreBankingDetails."Trans. Amount" := paidamt;
                        CoreBankingDetails."Transaction Description" := 'Accomodation Receipt';
                        CoreBankingDetails."Student No." := customerref;
                        CoreBankingDetails."Posting Status" := CoreBankingDetails."posting status"::New;
                        if CoreBankingDetails.Insert then begin
                            PesaFlowIntegration.Posted := true;
                            PesaFlowIntegration.Modify;
                            CoreBankingDetails.PostReceiptsFromBuffer(CoreBankingDetails);
                            WebPortal.MarkKUCCPSDetailsUpdated(customerref);
                        end else
                            Error('Posting error!');
                    end;
                end else begin
                    Error('invalid transaction id');
                end;
            end else begin
                Error('invalid invoice');

            end;
        end;

    end;


    procedure InsertCafeteriaTransaction(paymentrefid: Code[20]; customerref: Code[50]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; channel: Text; paymentdate: Text; status: Text) inserted: Boolean
    var
        KUCCPSRaw: Record "KUCCPS Imports";
        CoreBankingDetails: Record Core_Banking_Details;
        CoreBankingHeader: Record "Core_Banking Header";
        PesaFlow_ServiceIDs: Record "Pesa-Flow_Service-IDs";
        WebPortal: Codeunit webportals;
        posheader: Record "POS Sales Header";
    begin
        posheader.RESET;
        posheader.SETRANGE("No.", customerref);
        IF posheader.FIND('-') THEN BEGIN
            PesaFlowIntegration.Reset;
            PesaFlowIntegration.SetRange(PaymentRefID, paymentrefid);
            if not PesaFlowIntegration.Find('-') then begin
                PesaFlowIntegration.Init;
                PesaFlowIntegration.PaymentRefID := paymentrefid;
                PesaFlowIntegration.CustomerRefNo := customerref;
                PesaFlowIntegration.InvoiceNo := invoiceno;
                PesaFlowIntegration.InvoiceAmount := invoiceamt;
                PesaFlowIntegration.PaidAmount := paidamt;
                PesaFlowIntegration.ServiceID := '2729111';
                PesaFlowIntegration.Description := 'Payment for catering services';
                PesaFlowIntegration.PaymentChannel := channel;
                PesaFlowIntegration.PaymentDate := paymentdate;
                PesaFlowIntegration."Date Received" := Today;
                PesaFlowIntegration.Status := status;
                if PesaFlowIntegration.Insert then begin
                    //  PostCafeSale(PesaflowIntegration);
                    inserted := true;
                end else begin
                    Error(paymentrefid + ' is a duplicate transaction ID!!!');
                end;
            end;
            posheader."Ecitizen Invoice No" := invoiceno;
            posHeader.Posted := True;
            posHeader."Amount Paid" := paidamt;
            posHeader."M-Pesa Transaction Number" := PaymentRefID;
            posHeader.Modify();
        END ELSE BEGIN
            // ERROR('invalid invoice');
            //Insert into PesaFlowIntegration
            PesaFlowIntegration.Init;
            PesaFlowIntegration.PaymentRefID := paymentrefid;
            PesaFlowIntegration.CustomerRefNo := customerref;
            PesaFlowIntegration.InvoiceNo := invoiceno;
            PesaFlowIntegration.InvoiceAmount := invoiceamt;
            PesaFlowIntegration.PaidAmount := paidamt;
            PesaFlowIntegration.ServiceID := '2729111';
            PesaFlowIntegration.Description := 'Payment for catering services';
            PesaFlowIntegration.PaymentChannel := channel;
            PesaFlowIntegration.PaymentDate := paymentdate;
            PesaFlowIntegration."Date Received" := Today;
            PesaFlowIntegration.Status := status;
            PesaFlowIntegration.Insert;
        end;
    end;

    procedure PostCafeSale(var pflow: Record "PesaFlow Integration")
    var
        PosSetup: Record "POS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        posLines: record "POS Sales Lines";
        GenJnLine: Record "Gen. Journal Line";
        Batch: Record "Gen. Journal Batch";
        LineNo: Integer;
        itemledger: Record "POS Item Ledger";
        posItems: Record "POS Items";
        posHeader: Record "POS Sales Header";
        DimValues: record "Dimension Value";
    begin
        DimValues.Reset();
        DimValues.SetRange("Default Receit Dimesnison 1", true);
        if DimValues.FindFirst() then;

        posHeader.Reset();
        posHeader.SetRange("No.", pflow.CustomerRefNo);
        if posHeader.Find('-') then begin
            posLines.Reset();
            posLines.SetRange("Document No.", pflow.CustomerRefNo);
            if posLines.Find('-') then begin
                repeat
                    itemledger.Init();
                    itemledger."Entry No." := GetLastEntryNo + 1;
                    itemledger."Item No." := posLines."No.";
                    itemledger."Document No." := posLines."No." + posLines."Document No.";
                    itemledger."Entry Type" := itemledger."Entry Type"::"Negative Adjmt.";
                    itemledger."Posting Date" := Today;
                    itemledger.Quantity := -posLines.Quantity;
                    itemledger.Description := posLines.Description;
                    itemledger.Insert(true);

                    posLines.Posted := true;
                    posLines.Modify();
                until posLines.Next() = 0;

            end;

            // Delete Lines Present on the General Journal Line
            GenJnLine.RESET;
            GenJnLine.SETRANGE(GenJnLine."Journal Template Name", 'GENERAL');
            GenJnLine.SETRANGE(GenJnLine."Journal Batch Name", pflow.CustomerRefNo);
            GenJnLine.DELETEALL;
            Batch.INIT;
            Batch."Journal Template Name" := 'GENERAL';
            Batch.Name := pflow.CustomerRefNo;
            IF NOT Batch.GET(Batch."Journal Template Name", Batch.Name) THEN
                Batch.INSERT;

            //Debit Post acquisition
            LineNo := LineNo + 1000;
            GenJnLine.INIT;
            GenJnLine."Journal Template Name" := 'GENERAL';
            GenJnLine."Journal Batch Name" := pflow.CustomerRefNo;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Document Type" := GenJnLine."Document Type"::Payment;
            GenJnLine."Shortcut Dimension 1 Code" := DimValues.code;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := posHeader."Bank Account";
            GenJnLine."Posting Date" := pflow."Date Received";
            GenJnLine."Document No." := pflow.CustomerRefNo;
            GenJnLine.Description := 'Food sales for ' + format(posHeader."Customer Type");
            GenJnLine.Amount := pflow.PaidAmount;
            GenJnLine.VALIDATE(GenJnLine.Amount);
            GenJnLine."Bal. Account Type" := GenJnLine."Bal. Account Type"::"G/L Account";
            GenJnLine."Bal. Account No." := posHeader."Income Account";
            IF GenJnLine.Amount <> 0 THEN
                GenJnLine.INSERT;
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnLine);
            Batch.setrange("Journal Template Name", 'GENERAL');
            Batch.setrange(Name, pflow.CustomerRefNo);
            Batch.Delete();

            posHeader.Posted := True;
            posHeader."Amount Paid" := pflow.PaidAmount;
            posHeader."M-Pesa Transaction Number" := pflow.PaymentRefID;
            posHeader.Modify(true);
            if posHeader."Customer Type" = posHeader."Customer Type"::Staff then
                Report.Run(Report::"POS Restaurants PrintOut", true, false, posHeader) else
                Report.Run(Report::"POS Students PrintOut", true, false, posHeader);
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

    procedure PesaFlowTransExists(paymentrefid: Code[20]) exists: Boolean
    begin
        PesaFlowIntegration.Reset;
        PesaFlowIntegration.SetRange(PaymentRefID, paymentrefid);
        if PesaFlowIntegration.Find('-') then begin
            exists := true;
        end
    end;


    procedure PostPesaFlowFeeTrans(paymentrefid: Code[50]; customerrefno: Code[50]; invoiceno: Code[20]; invoiceamt: Decimal; paidamt: Decimal; paymentchannel: Text; paymentdate: Text; status: Text) inserted: Boolean
    var
        Cust: Record Customer;
        // BankIntergration: Record UnknownRecord77762;
        // bank: Record UnknownRecord77762;
        AmountsDecimal: Decimal;
        KUCCPSRaw: Record "KUCCPS Imports";
        CoreBankingDetails: Record Core_Banking_Details;
        CoreBankingHeader: Record "Core_Banking Header";
        PesaFlow_ServiceIDs: Record "Pesa-Flow_Service-IDs";
        WebPortal: Codeunit webportals;
    begin
        Clear(PesaFlowInvoices);
        PesaFlowInvoices.Reset;
        PesaFlowInvoices.SetRange(BillRefNo, customerrefno);
        if PesaFlowInvoices.Find('-') then begin
            Clear(PesaFlowIntegration);
            PesaFlowIntegration.Reset;
            PesaFlowIntegration.SetRange(PaymentRefID, paymentrefid);
            if not PesaFlowIntegration.Find('-') then begin
                PesaFlowIntegration.Init;
                PesaFlowIntegration.PaymentRefID := paymentrefid;
                PesaFlowIntegration.CustomerRefNo := PesaFlowInvoices.CustomerRefNo;
                PesaFlowIntegration."Customer Name" := PesaFlowInvoices.CustomerName;
                PesaFlowIntegration.InvoiceNo := invoiceno;
                PesaFlowIntegration.InvoiceAmount := invoiceamt;
                PesaFlowIntegration.PaidAmount := paidamt;
                PesaFlowIntegration.ServiceID := PesaFlowInvoices.ServiceID;
                PesaFlowIntegration.Description := PesaFlowInvoices.Description;
                PesaFlowIntegration.PaymentChannel := paymentchannel;
                PesaFlowIntegration.PaymentDate := paymentdate;
                PesaFlowIntegration.Status := status;
                PesaFlowIntegration."Date Received" := Today;
                if PesaFlowIntegration.Insert then begin
                    inserted := true;
                    // Get the Bank Account Mapped to the pesa Flow service Id
                    Clear(PesaFlow_ServiceIDs);
                    PesaFlow_ServiceIDs.Reset;
                    PesaFlow_ServiceIDs.SetRange(Service_ID, PesaFlowInvoices.ServiceID);
                    if not (PesaFlow_ServiceIDs.Find('-')) then Error('Invalid service ID');
                    PesaFlow_ServiceIDs.TestField(Bank_Id);
                    PesaFlow_ServiceIDs.CalcFields("Bank Name");
                    //post to corebanking
                    CoreBankingHeader.Init;
                    CoreBankingHeader."Created By" := UserId;
                    CoreBankingHeader.Bank_Code := PesaFlow_ServiceIDs.Bank_Id;
                    CoreBankingHeader."Created By" := UserId;
                    CoreBankingHeader."Time Created" := Time;
                    CoreBankingHeader."Date Created" := Today;
                    CoreBankingHeader."Statement No" := 'PESAF_INT' + PesaFlow_ServiceIDs.Bank_Id;
                    if CoreBankingHeader.Insert then;
                    Clear(CoreBankingDetails);
                    CoreBankingDetails.Init;
                    CoreBankingDetails.Bank_Code := PesaFlow_ServiceIDs.Bank_Id;
                    CoreBankingDetails."Transaction Number" := paymentrefid;
                    CoreBankingDetails."Statement No" := 'PESAF_INT' + PesaFlow_ServiceIDs.Bank_Id;
                    CoreBankingDetails."Transaction Date" := ConvertToDate(paymentdate);//TODAY;
                    CoreBankingDetails."Trans. Amount" := paidamt;
                    CoreBankingDetails."Transaction Description" := 'Fee Receipt';
                    CoreBankingDetails."Student No." := PesaFlowInvoices.CustomerRefNo;
                    CoreBankingDetails."Posting Status" := CoreBankingDetails."posting status"::New;
                    if CoreBankingDetails.Insert then begin
                        PesaFlowIntegration.Posted := true;
                        PesaFlowIntegration.Modify;
                        CoreBankingDetails.PostReceiptsFromBuffer(CoreBankingDetails);
                    end else
                        Error('Posting error!');
                end;
            end else begin
                Error(paymentrefid + ' is a duplicate transaction ID!!!');
            end;
        end else begin
            Error('invalid invoice');

        end

    end;


    procedure ConvertToInt(myText: Text) intValue: Integer
    var
        myInt: Integer;
    begin
        if Evaluate(myInt, myText) then begin
            exit(myInt);
        end else begin
            Error('Cannot convert ' + myText + ' to integer!');
        end;
    end;


    procedure ConvertToDate(myText: Text) dateValue: Date
    begin
        begin
            dateValue := Dmy2date(ConvertToInt(CopyStr(myText, 9, 2)), ConvertToInt(CopyStr(myText, 6, 2)), ConvertToInt(CopyStr(myText, 1, 4)));
            exit(dateValue);
        end;
    end;
}

