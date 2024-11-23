codeunit 60001 VendorsWebportals
{
    trigger OnRun()
    begin
    end;

    var
        Seq: Integer;
        TenderApplicants: Record "Tender Applicants Registration";
        tblBidder: Record "Tender Applicants Registration";
        tblTenderBidFinReq: Record "Tender Bidder Fin Reqs";
        vendors: Record Vendor;
        reqvendors: Record "PROC-Quotation Request Vendors";
        preqcategories: Record "Proc-Prequalif. Categories";
        preqapp: Record "Prequalification Application";
        years: Record "Proc-Prequalification Years";
        preqappcat: Record "Preq Application categories";
        procheader: Record "PROC-Purchase Quote Header";
        proclines: Record "PROC-Purchase Quote Line";
        tenderheader: Record "Purchase Header";
        //tenderheader: Record "Tender Submission Header";
        // tenderlines: Record "Tender Submission Lines";
        tenderlines: Record "Purchase Line";
        purpay: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        nextapplicno: Code[20];
        FILESPATH: Label 'C:\inetpub\wwwroot\NDMAVendors\Downloads\';
        purchaseheader: Record "Purchase Header";
        purchaseline: Record "Purchase Line";

    procedure GenerateRFQReport(tenderNo: Code[20]; filenameFromApp: Text; var bigtext: BigText) rtnmsg: Text
    var
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        recRef: RecordRef;
        filename: Text;
    begin
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        procheader.RESET;
        procheader.SETRANGE("No.", tenderNo);
        IF procheader.FIND('-') THEN BEGIN
            recRef.GetTable(procheader);
            tmpBlob.CreateOutStream(OutStr);
            Report.SaveAs(Report::"RFQ Report 1", '', format::Pdf, OutStr, recRef);
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            bigtext.AddText(txtB64);
        END;
        EXIT(filename);
    end;


    procedure CreateBidderAccount(KRAPin: Code[20]; CompName: Text; PostalAddress: Text; CompPhone: Text; CompEmail: Text; ContactPerson: Text; ContactPersonPhone: Text; ContactPersonEmail: Text; activationCode: Code[20]) msg: boolean
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE(tblBidder."No.", KRAPin);
        IF NOT tblBidder.FIND('-') THEN BEGIN
            tblBidder."No." := KRAPin;
            tblBidder.Name := CompName;
            tblBidder."E-Mail" := CompEmail;
            tblBidder."Company Contact" := CompPhone;
            tblBidder.Address := PostalAddress;
            tblBidder."Contact Person" := ContactPerson;
            tblBidder."Phone No." := ContactPersonPhone;
            tblBidder."Contact Person Email" := ContactPersonEmail;
            tblBidder."VAT Registration No." := KRAPin;
            tblBidder.OTP := activationCode;
            tblBidder.INSERT;
            vendors.Reset();
            vendors.SetRange("No.", KRAPin);
            if not vendors.Find('-') then begin
                vendors."No." := KRAPin;
                vendors.Name := CompName;
                vendors."E-Mail" := CompEmail;
                vendors."Email 1" := CompEmail;
                vendors."Email 2" := CompEmail;
                vendors."VAT Registration No." := KRAPin;
                vendors.Validate("VAT Registration No.");
                tblBidder.Reset();
                tblBidder.SetRange("VAT Registration No.", KRAPin);
                if tblBidder.Find('-') then
                    vendors.Password := tblBidder.Password;
                vendors."Gen. Bus. Posting Group" := 'DOMESTIC';
                vendors.Validate("Gen. Bus. Posting Group");
                vendors."VAT Bus. Posting Group" := 'ZERO VAT';
                vendors.Validate("VAT Bus. Posting Group");
                vendors."Vendor Posting Group" := 'TCREDITOR';
                vendors.Validate("Vendor Posting Group");
                vendors.Insert();
            end;
            msg := True;
        END
        ELSE BEGIN
            Error('KRA Pin already registered!');
        END;
    end;

    procedure prequalificationapplied(krapin: Code[20]) msg: Boolean
    begin
        preqapp.Reset;
        preqapp.SetRange("VAT Registration No.", krapin);
        preqapp.SetRange(Period, GetCurrentPeriod());
        if preqapp.Find('-') then begin
            msg := true;
        end;
    end;

    procedure BidHeaderCreate(krapin: Code[20]; tenderno: Code[20]) msg: Text
    begin
        procheader.Reset;
        procheader.SetRange("No.", tenderno);
        if procheader.Find('-') then begin
            tenderheader.Reset;
            tenderheader.SetRange("Request for Quote No.", tenderno);
            tenderheader.SetRange("Bidder No.", krapin);
            if not tenderheader.Find('-') then begin
                nextapplicno := NoSeriesMgt.GetNextNo('BID', 0D, True);
                tenderheader.init;
                tenderheader."No." := nextapplicno;
                tenderheader."Quote No." := procheader."Requisition No.";
                tenderheader."Bidder No." := krapin;
                tenderheader."Request for Quote No." := tenderno;
                tenderheader."Document Type" := tenderheader."Document Type"::Quote;
                tenderheader."Buy-from Vendor No." := krapin;
                tenderheader.Validate("Buy-from Vendor No.");
                tenderheader."Pay-to Vendor No." := krapin;
                tenderheader."Buy-from Vendor Name" := GetVendorName(krapin);
                tenderheader."Pay-to Name" := GetVendorName(krapin);
                tenderheader.Validate("Pay-to Vendor No.");
                tenderheader.DocApprovalType := tenderheader.DocApprovalType::Quote;
                tenderheader."Document Type 2" := tenderheader."Document Type 2"::Quote;
                tenderheader."Procurement method" := procheader."Procurement methods";
                purchaseheader."Posting Description" := CopyStr(procheader.Description, 1, 100);
                tenderheader."Quote Status" := tenderheader."Quote Status"::pending;
                tenderheader."RFQ No." := procheader."Requisition No.";
                tenderheader."Document Date" := Today;
                tenderheader."Expected Opening Date" := procheader."Expected Opening Date";
                tenderheader."Expected Closing Date" := procheader."Expected Closing Date";
                tenderheader.insert;
                msg := nextapplicno;
            end else begin
                msg := tenderheader."No.";
            end;
        end;
    end;

    procedure RFQHeaderCreate(krapin: Code[20]; tenderno: Code[20]) msg: Text
    begin
        procheader.Reset;
        procheader.SetRange("No.", tenderno);
        if procheader.Find('-') then begin
            purchaseheader.Reset;
            purchaseheader.SetRange("Request for Quote No.", tenderno);
            purchaseheader.SetRange("Buy-from Vendor No.", krapin);
            if not purchaseheader.Find('-') then begin
                nextapplicno := NoSeriesMgt.GetNextNo('BID', 0D, True);
                purchaseheader.init;
                purchaseheader."No." := nextapplicno;
                purchaseheader."Buy-from Vendor No." := krapin;
                purchaseheader.Validate("Buy-from Vendor No.");
                purchaseheader."Pay-to Vendor No." := krapin;
                purchaseheader.Validate("Pay-to Vendor No.");
                purchaseheader."Bidder No." := krapin;
                purchaseheader."Buy-from Vendor Name" := GetVendorName(krapin);
                purchaseheader."Pay-to Name" := GetVendorName(krapin);
                purchaseheader."Request for Quote No." := tenderno;
                purchaseheader."Document Type 2" := purchaseheader."Document Type 2"::Quote;
                purchaseheader.DocApprovalType := purchaseheader.DocApprovalType::Quote;
                purchaseheader."Posting Description" := CopyStr(procheader.Description, 1, 100);
                purchaseheader."Quote Status" := purchaseheader."Quote Status"::Pending;
                purchaseheader."Document Date" := Today;
                purchaseheader."Expected Opening Date" := procheader."Expected Opening Date";
                purchaseheader."Expected Closing Date" := procheader."Expected Closing Date";
                purchaseheader.insert;
                msg := nextapplicno;
            end;
        end;
    end;



    procedure BidLineCreate(krapin: Code[20]; tenderno: Code[20]; bidno: code[20]; itemno: Code[20]; quoteamt: Decimal) msg: Boolean
    var
        tlines: Record "Purchase Line";
    begin
        tlines.Reset;
        tlines.SetCurrentKey("Line No.");
        if tlines.Findlast() then begin
            Seq := tlines."Line No." + 1;
        end else begin
            seq := 1;
        end;

        tenderheader.Reset;
        tenderheader.SetRange("No.", bidno);
        tenderheader.SetRange("Request for Quote No.", tenderno);
        tenderheader.SetRange("Bidder No.", krapin);
        if tenderheader.Find('-') then begin
            proclines.Reset;
            // proclines.SetRange("Document Type", tenderheader."Document Type");
            proclines.SetRange("No.", itemno);
            proclines.SetRange("Document No.", tenderno);
            if proclines.Find('-') then begin
                tenderlines.Reset;
                tenderlines.SetRange("Document Type", tenderheader."Document Type");
                tenderlines.SetRange("Request for Quote No.", tenderno);
                tenderlines.SetRange("Document No.", bidno);
                tenderlines.SetRange("No.", itemno);
                if not tenderlines.Find('-') then begin
                    tenderlines.init;
                    tenderlines.Type := proclines.Type;
                    tenderlines."Line No." := SEQ;
                    tenderlines."Location Code" := 'MAIN STORE';
                    tenderlines."No." := itemno;
                    tenderlines."Request for Quote No." := tenderno;
                    tenderlines."Document No." := bidno;
                    tenderlines.Validate("No.");
                    tenderlines."RFQ No." := tenderheader."RFQ No.";
                    tenderlines."Buy-from Vendor No." := krapin;
                    tenderlines."Document Type" := tenderheader."Document Type";
                    tenderlines."Direct Unit Cost" := quoteamt;
                    tenderlines."Unit of Measure" := proclines."Unit of Measure";
                    tenderlines.Quantity := proclines.Quantity;
                    tenderlines.Validate(Quantity);
                    tenderlines.Validate("Direct Unit Cost");
                    tenderlines.insert;
                    msg := true;
                end else begin
                    Error('Tender line already added!');
                end;
            end else begin
                Error('Procurement header not found!')
            end;
        end else begin
            Error('Tender submission header not found!');
        end;
    end;

    procedure RFQLineCreate(krapin: Code[20]; tenderno: Code[20]; bidno: code[20]; itemno: Code[20]; quoteamt: Decimal) msg: Boolean
    var
        tlines: Record "Purchase Line";
    begin
        tlines.Reset;
        tlines.SetCurrentKey("Line No.");
        if tlines.Findlast() then begin
            Seq := tlines."Line No." + 1;
        end else begin
            seq := 1;
        end;
        purchaseheader.Reset;
        purchaseheader.SetRange("No.", bidno);
        purchaseheader.SetRange("Request for Quote No.", tenderno);
        purchaseheader.SetRange("Buy-from Vendor No.", krapin);
        if purchaseheader.Find('-') then begin
            proclines.Reset;
            proclines.SetRange("Document Type", tenderheader."Document Type");
            proclines.SetRange("No.", itemno);
            proclines.SetRange("Document No.", tenderno);
            if proclines.Find('-') then begin
                purchaseline.Reset;
                purchaseline.SetRange("Document Type", tenderheader."Document Type");
                purchaseline.SetRange("Request for Quote No.", tenderno);
                purchaseline.SetRange("Document No.", bidno);
                purchaseline.SetRange("No.", itemno);
                if not purchaseline.Find('-') then begin

                    Seq := purchaseline."Line No.";
                    purchaseline.init;
                    purchaseline.Type := proclines.Type;
                    purchaseline."Document No." := bidno;
                    purchaseline."Line No." := Seq;
                    purchaseline."No." := itemno;
                    purchaseline.Validate("No.");
                    purchaseline."Request for Quote No." := tenderno;
                    purchaseline."Buy-from Vendor No." := krapin;
                    purchaseline.Validate("Buy-from Vendor No.");
                    purchaseline."Pay-to Vendor No." := krapin;
                    purchaseline.Validate("Pay-to Vendor No.");
                    purchaseline."Document Type" := tenderheader."Document Type";
                    purchaseline."Direct Unit Cost" := quoteamt;
                    purchaseline."Unit of Measure" := proclines."Unit of Measure";
                    purchaseline."Location Code" := 'MAIN STORE';
                    purchaseline.Quantity := proclines.Quantity;
                    purchaseline.Validate(Quantity);
                    purchaseline.Validate("Direct Unit Cost");
                    purchaseline.insert;
                    msg := true;
                end else begin
                    Error('Tender line already added!');
                end;
            end else begin
                Error('Procurement header not found!')
            end;
        end else begin
            Error('Purchase header not found!');
        end;
    end;

    procedure SubmitBid(krapin: Code[20]; bidno: code[20]) msg: Boolean
    begin
        tenderheader.Reset;
        tenderheader.SetRange("Bidder No.", krapin);
        tenderheader.SetRange("No.", bidno);
        if tenderheader.Find('-') then begin
            tenderheader."Quote Status" := tenderheader."Quote Status"::Submitted;
            tenderheader.Modify;
            msg := true;
        end;
    end;

    procedure DeleteQuote(no: code[20]; vendor: code[20]) msg: Boolean
    begin
        purchaseheader.Reset;
        purchaseheader.SetRange("Buy-from Vendor No.", vendor);
        purchaseheader.SetRange("No.", no);
        if purchaseheader.Find('-') then begin
            purchaseheader.delete;
            msg := true;
        end;
    end;

    procedure DeleteQuoteLine(no: code[20]; vendor: code[20]) msg: Boolean
    begin
        purchaseline.Reset;
        purchaseline.SetRange("Document No.", no);
        purchaseline.SetRange("Buy-from Vendor No.", vendor);
        if purchaseline.Find('-') then begin
            purchaseline.deleteall;
            msg := true;
        end;
    end;

    procedure SubmitRFQ(krapin: Code[20]; bidno: code[20]) msg: Boolean
    begin
        purchaseheader.Reset;
        purchaseheader.SetRange("Buy-from Vendor No.", krapin);
        purchaseheader.SetRange("No.", bidno);
        if purchaseheader.Find('-') then begin
            purchaseheader."Quote Status" := purchaseheader."Quote Status"::Submitted;
            purchaseheader.Modify;
            msg := true;
        end;
    end;

    procedure TenderApplied(krapin: Code[20]; tenderno: Code[20]) msg: Boolean
    begin
        tenderheader.Reset;
        tenderheader.SetRange("Bidder No.", krapin);
        tenderheader.SetRange("Request for Quote No.", tenderno);
        if tenderheader.find('-') then begin
            msg := true;
        end;
    end;

    procedure RFQApplied(krapin: Code[20]; tenderno: Code[20]) msg: Boolean
    begin
        purchaseheader.Reset;
        purchaseheader.SetRange("Buy-from Vendor No.", krapin);
        purchaseheader.SetRange("Request for Quote No.", tenderno);
        if purchaseheader.find('-') then begin
            msg := true;
        end;
    end;

    procedure GetMyBids(krapin: Code[20]) msg: Text
    begin
        tenderheader.Reset;
        tenderheader.SetCurrentKey("No.");
        tenderheader.SetRange("Bidder No.", krapin);
        if tenderheader.Find('-') then begin
            repeat
                Msg += tenderheader."No." + ' ::' + tenderheader."Request for Quote No." + ' ::' + tenderheader."Posting Description" + ' ::' + Format(tenderheader."Document Date") + ' ::' + Format(tenderheader."Expected Opening Date") + ' ::' + Format(tenderheader."Expected Closing Date") + ' ::' + Format(tenderheader."Quote Status") + ' :::';
            until tenderheader.next = 0;
        end;
    end;

    procedure GetMyQuotes(krapin: Code[20]) msg: Text
    begin
        purchaseheader.Reset;
        purchaseheader.SetCurrentKey("No.");
        purchaseheader.SetRange("Buy-from Vendor No.", krapin);
        if purchaseheader.Find('-') then begin
            repeat
                Msg += purchaseheader."No." + ' ::' + purchaseheader."Request for Quote No." + ' ::' + purchaseheader."Posting Description" + ' ::' + Format(purchaseheader."Document Date") + ' ::' + Format(purchaseheader."Expected Opening Date") + ' ::' + Format(purchaseheader."Expected Closing Date") + ' ::' + Format(purchaseheader.Status) + ' :::';
            until purchaseheader.next = 0;
        end;
    end;

    procedure GetMyBidLines(krapin: Code[20]; docno: Code[20]) msg: Text
    begin
        tenderlines.Reset;
        tenderlines.SetRange("Buy-from Vendor No.", krapin);
        tenderlines.SetRange("Document No.", docno);
        if tenderlines.Find('-') then begin
            repeat
                Msg += tenderlines."No." + ' ::' + tenderlines.Description + ' ::' + tenderlines."Unit of Measure" + ' ::' + Format(tenderlines."Direct Unit Cost") + ' ::' + Format(tenderlines.Quantity) + ' ::' + Format(tenderlines.Amount) + ' :::';
            until tenderlines.next = 0;
        end;
    end;

    procedure GetMyQuoteLines(krapin: Code[20]; docno: Code[20]) msg: Text
    begin
        purchaseline.Reset;
        purchaseline.SetRange("Buy-from Vendor No.", krapin);
        purchaseline.SetRange("Document No.", docno);
        if purchaseline.Find('-') then begin
            repeat
                Msg += purchaseline."No." + ' ::' + purchaseline.Description + ' ::' + purchaseline."Unit of Measure" + ' ::' + Format(purchaseline."Direct Unit Cost") + ' ::' + Format(purchaseline.Quantity) + ' ::' + Format(purchaseline.Amount) + ' :::';
            until purchaseline.next = 0;
        end;
    end;

    procedure PreqApplicHeaderCreate(krapin: Code[20]) msg: boolean
    begin
        tblBidder.Reset;
        tblBidder.SetRange("No.", krapin);
        IF tblBidder.Find('-') then begin
            years.Reset;
            years.SetRange("Active Period", true);
            if years.Find('-') then begin
                preqapp.Reset;
                preqapp.SetRange("VAT Registration No.", tblBidder."No.");
                preqapp.SetRange(Period, years."Preq. Year");
                if not preqapp.Find('-') then begin
                    preqapp.init;
                    preqapp."VAT Registration No." := tblBidder."No.";
                    preqapp.Period := years."Preq. Year";
                    preqapp.Name := tblBidder.Name;
                    preqapp.Phone := tblBidder."Company Contact";
                    preqapp.Address := tblBidder.Address;
                    preqapp."Contact Person" := tblBidder."Contact Person";
                    preqapp."Contact Telephone" := tblBidder."Phone No.";
                    preqapp.Email := tblBidder."E-Mail";
                    preqapp.Status := preqapp.Status::New;
                    preqapp."Document Date" := Today;
                    preqapp.Insert;
                    msg := true;
                end else begin
                    error('You have already made a prequalification application for the current period!')
                end;
            end;
        end;
    end;

    procedure SubmitPreqApp(KRAPin: Code[20]) msg: Boolean
    begin
        preqapp.Reset;
        preqapp.Setrange("VAT Registration No.", KRAPin);
        preqapp.SetRange(Status, preqapp.Status::New);
        preqapp.SetRange(Period, GetCurrentPeriod());
        if preqapp.Find('-') then begin
            preqapp.Status := preqapp.Status::Submitted;
            preqapp.Modify;
            msg := true;
        end;
    end;

    procedure GetPrequalificationApps(krapin: Code[20]) msg: Text
    begin
        preqapp.Reset;
        preqapp.SetRange("VAT Registration No.", krapin);
        if preqapp.Find('-') then begin
            repeat
                msg += preqapp.Period + '::' + Format(preqapp.Prequalified) + ':::';
            until preqapp.Next = 0;
        end;
    end;

    procedure GetOpenTenders() msg: Text
    begin
        procheader.Reset;
        //jeffer
        procheader.SetRange("Procurement methods", procheader."Procurement methods"::"Open Tendering");
        procheader.SetRange(Status, procheader.Status::Released);
        procheader.SetFilter("Expected Closing Date", '>%1', CurrentDateTime);
        if procheader.Find('-') then begin
            repeat
                msg += procheader."No." + ' ::' + procheader."Requisition No." + ' ::' + procheader.Description + ' ::' + Format(procheader."Expected Opening Date") + ' ::' + Format(procheader."Expected Closing Date") + ' :::';
            until procheader.Next = 0;
        end;
    end;

    procedure GetOpenTenderLines(no: Code[20]) msg: Text
    begin
        proclines.Reset;
        proclines.SetRange("Document No.", no);
        if proclines.Find('-') then begin
            repeat
                msg += proclines."No." + ' ::' + proclines.Description + ' ::' + proclines."Unit of Measure" + ' ::' + Format(proclines.Quantity) + ' :::';
            until proclines.Next = 0;
        end;
    end;

    procedure GetPreAppCategories(krapin: Code[20]; period: Code[20]) msg: Text
    begin
        preqappcat.Reset;
        preqappcat.SetRange("VAT Registration", krapin);
        preqappcat.SetRange(period, period);
        if preqappcat.Find('-') then begin
            repeat
                msg += preqappcat.Category + ' ::' + Format(preqappcat.Prequalified) + ' :::';
            until preqappcat.Next = 0;
        end;
    end;

    procedure GetCurrentPeriod() msg: Text
    begin
        years.Reset;
        years.SetRange("Active Period", true);
        if years.Find('-') then begin
            msg := years."Preq. Year";
        end;
    end;

    procedure PreqAppLinesCreate(krapin: Code[20]; category: Code[20]) msg: Boolean
    begin
        preqapp.Reset;
        preqapp.SetRange("VAT Registration No.", krapin);
        preqapp.SetRange(Period, GetCurrentPeriod());
        if preqapp.Find('-') then begin
            preqappcat.Reset;
            preqappcat.SetRange("VAT Registration", preqapp."VAT Registration No.");
            preqappcat.SetRange(Period, preqapp.Period);
            preqappcat.SetRange(Category, category);
            if not preqappcat.Find('-') then begin
                preqappcat.init;
                preqappcat."VAT Registration" := preqapp."VAT Registration No.";
                preqappcat.Period := preqapp.Period;
                preqappcat.Category := category;
                preqappcat.Insert;
                msg := true;
            end else begin
                Error('Prequalification application already submitted for this category!');
            end;
        end;
    end;

    procedure ValidateKRAPin(pin: Code[20]) msg: Boolean
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE(tblBidder."No.", pin);
        if tblBidder.Find('-') then begin
            msg := true;
        end;
    end;

    procedure AccountActivated(pin: Code[20]) msg: Boolean
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE(tblBidder."No.", pin);
        tblBidder.SETRANGE(tblBidder."Account Activated", true);
        if tblBidder.Find('-') then begin
            msg := true;
        end;
    end;

    procedure GetBidderEmail(pin: Code[20]) msg: Text
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE(tblBidder."No.", pin);
        if tblBidder.Find('-') then begin
            msg := tblBidder."E-Mail";
        end;
    end;

    procedure ActivateBidderOnlineAccount(pin: Code[20]; activationcode: Code[20]) msg: boolean
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE(tblBidder."No.", pin);
        tblBidder.SETRANGE(tblBidder.OTP, activationcode);
        if tblBidder.Find('-') then begin
            tblBidder."Account Activated" := true;
            tblBidder.Modify;
            msg := true;
        end;
    end;

    procedure ChangeBidderPassword(pin: Code[20]; password: Text) msg: boolean
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE(tblBidder."No.", pin);
        if tblBidder.Find('-') then begin
            tblBidder.Password := password;
            tblBidder.Modify;
            msg := true;
        end;
    end;

    procedure SaveBidderOTP(pin: Code[20]; otp: Code[20]) msg: boolean
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE(tblBidder."No.", pin);
        if tblBidder.Find('-') then begin
            tblBidder.OTP := otp;
            tblBidder.Modify;
            msg := true;
        end;
    end;

    procedure GetBidderDetails(pin: Code[20]) msg: Text
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE(tblBidder."No.", pin);
        if tblBidder.Find('-') then begin
            msg := tblBidder.Name + ' ::' + tblbidder."E-Mail" + ' ::' + tblbidder."Company Contact" + ' ::' + tblBidder.Address + ' ::' + tblBidder."Contact Person" + ' ::' + tblBidder."Contact Person Email" + ' ::' + tblBidder."Phone No.";
        end;
    end;

    procedure GetPreqCategories() msg: Text
    begin
        preqcategories.Reset;
        preqCategories.SetFilter("Category Code", '<>%1', '');
        if preqcategories.Find('-') then begin
            repeat
                msg += preqcategories."Category Code" + ' ::' + preqcategories.Description + ' :::';
            until preqcategories.Next = 0;
        end;
    end;

    procedure VerifyBidderOTP(pin: Code[20]; otp: Code[20]) msg: boolean
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE(tblBidder."No.", pin);
        tblBidder.SetRange(tblBidder.OTP, otp);
        if tblBidder.Find('-') then begin
            msg := true;
        end;
    end;

    procedure CheckBidderLogin(username: Text; userpassword: Text) msg: boolean
    var
        FullNames: Text;
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE("No.", username);
        IF tblBidder.FIND('-') THEN BEGIN
            IF (tblBidder.Password = userpassword) THEN BEGIN
                msg := true
            END ELSE BEGIN
                Error('Invalid Password');
            END
        END ELSE BEGIN
            Error('Invalid Username');
        END
    end;

    procedure GetBidderName(krapin: Code[20]) name: Text
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE("No.", krapin);
        if tblBidder.FIND('-') then begin
            name := tblBidder.Name;
        end;
    end;

    procedure CheckValidBidder(username: Text) Msg: Boolean
    begin
        tblBidder.RESET;
        tblBidder.SETRANGE(tblBidder."No.", username);
        IF tblBidder.FIND('-') THEN BEGIN
            Msg := true;
        END ELSE BEGIN
            Msg := false;
        END
    end;

    procedure FnApplicationAttachement(retNo: Code[50]; fileName: Text; attachment: BigText; tableId: Integer) return_value: Boolean
    var
        DocAttachment: Record "Document Attachment";
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
        tableFound: Boolean;
        ObjAppliRec: Record "Tender Applicants Registration";

    begin

        tableFound := false;
        return_value := false;
        if TableID = Database::"Tender Applicants Registration" then begin
            ObjAppliRec.RESET;
            ObjAppliRec.SETRANGE(ObjAppliRec."No.", retNo);
            if ObjAppliRec.FIND('-') then begin
                FromRecRef.GETTABLE(ObjAppliRec);
            end;
            tableFound := true;
        end;

        if tableFound = true then begin
            if FileName <> '' then begin
                Clear(DocAttachment);
                DocAttachment.Init();
                DocAttachment.Validate("File Extension", FileManagement.GetExtension(FileName));
                DocAttachment.Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(FileName)));
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("No.", retNo);
                Bytes := Convert.FromBase64String(Attachment);
                MemoryStream := MemoryStream.MemoryStream(Bytes);
                DocAttachment."Document Reference ID".ImportStream(MemoryStream, '', FileName);
                DocAttachment.Insert(true);
                return_value := true;
            end else
                Error('No file to upload');
        end else
            Error('File not uploaded. No table filter found');

    end;

    procedure FnPreqApplicationAttachement(retNo: Code[50]; fileName: Text; attachment: BigText; tableId: Integer) return_value: Boolean
    var
        DocAttachment: Record "Document Attachment";
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
        tableFound: Boolean;
        ObjAppliRec: Record "Prequalification Application";

    begin

        tableFound := false;
        return_value := false;
        if TableID = Database::"Prequalification Application" then begin
            ObjAppliRec.RESET;
            ObjAppliRec.SETRANGE(ObjAppliRec."VAT Registration No.", retNo);
            if ObjAppliRec.FIND('-') then begin
                FromRecRef.GETTABLE(ObjAppliRec);
            end;
            tableFound := true;
        end;

        if tableFound = true then begin
            if FileName <> '' then begin
                Clear(DocAttachment);
                DocAttachment.Init();
                DocAttachment.Validate("File Extension", FileManagement.GetExtension(fileName));
                DocAttachment.Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(fileName), 1, MaxStrLen(fileName)));
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("No.", retNo);
                Bytes := Convert.FromBase64String(Attachment);
                MemoryStream := MemoryStream.MemoryStream(Bytes);
                DocAttachment."Document Reference ID".ImportStream(MemoryStream, '', FileName);
                DocAttachment.Insert(true);
                return_value := true;
            end else
                Error('No file to upload');
        end else
            Error('File not uploaded. No table filter found');
    end;

    procedure FnRFQApplicationAttachement(retNo: Code[50]; fileName: Text; attachment: BigText; tableId: Integer) return_value: Boolean
    var
        DocAttachment: Record "Document Attachment";
        DocAttachment1: Record "Document Attachment";
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
        tableFound: Boolean;
        ObjAppliRec: Record "Purchase Header";

    begin

        tableFound := false;
        return_value := false;
        if TableID = Database::"Purchase Header" then begin
            ObjAppliRec.RESET;
            ObjAppliRec.SETRANGE(ObjAppliRec."No.", retNo);
            if ObjAppliRec.FIND('-') then begin
                FromRecRef.GETTABLE(ObjAppliRec);
            end;
            tableFound := true;
        end;

        if tableFound = true then begin
            if FileName <> '' then begin
                Clear(DocAttachment);
                DocAttachment.Init();
                DocAttachment.Validate("File Extension", FileManagement.GetExtension(fileName));
                DocAttachment.Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(fileName), 1, MaxStrLen(fileName)));
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("No.", retNo);
                Bytes := Convert.FromBase64String(Attachment);
                MemoryStream := MemoryStream.MemoryStream(Bytes);
                DocAttachment."Document Reference ID".ImportStream(MemoryStream, '', FileName);
                DocAttachment.Insert(true);
                return_value := true;
            end else
                Error('No file to upload');
        end else
            Error('File not uploaded. No table filter found');
    end;

    procedure FnTenderApplicationAttachement(retNo: Code[50]; fileName: Text; attachment: BigText; tableId: Integer) return_value: Boolean
    var
        DocAttachment: Record "Document Attachment";
        DocAttachment1: Record "Document Attachment";
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
        tableFound: Boolean;
        ObjAppliRec: Record "Purchase Header";

    begin

        tableFound := false;
        return_value := false;
        if TableID = Database::"Purchase Header" then begin
            ObjAppliRec.RESET;
            ObjAppliRec.SETRANGE(ObjAppliRec."No.", retNo);
            if ObjAppliRec.FIND('-') then begin
                FromRecRef.GETTABLE(ObjAppliRec);
            end;
            tableFound := true;
        end;

        if tableFound = true then begin
            if FileName <> '' then begin
                DocAttachment1.Reset();
                DocAttachment1.SetRange("No.", retNo);
                DocAttachment1.SetRange("Table ID", FromRecRef.Number);
                DocAttachment1.SetRange("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(FileName)));
                if DocAttachment1.Find('-') then begin
                    DocAttachment1.DeleteAll;
                end;
                Clear(DocAttachment);
                DocAttachment.Init();
                DocAttachment.Validate("File Extension", FileManagement.GetExtension(fileName));
                DocAttachment.Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(fileName), 1, MaxStrLen(fileName)));
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("No.", retNo);
                Bytes := Convert.FromBase64String(Attachment);
                MemoryStream := MemoryStream.MemoryStream(Bytes);
                DocAttachment."Document Reference ID".ImportStream(MemoryStream, '', FileName);
                DocAttachment.Insert(true);
                return_value := true;
            end else
                Error('No file to upload');
        end else
            Error('File not uploaded. No table filter found');
    end;

    procedure GetOpenVendorTenders(vendorno: Code[20]) msg: Text
    begin
        procheader.Reset;
        procheader.SetFilter("Procurement methods", '<>%1', procheader."Procurement methods"::"Open Tendering");
        procheader.SetRange(Status, procheader.Status::Released);
        if procheader.Find('-') then begin
            repeat
                if NOT RFQApplied(vendorno, procheader."No.") then begin
                    reqvendors.Reset;
                    reqvendors.SetRange("Document No.", procheader."No.");
                    reqvendors.SetRange("Vendor No.", vendorno);
                    if reqvendors.Find('-') then begin
                        msg += procheader."No." + '::' + procheader."Requisition No." + '::' + procheader.Description + '::' + Format(procheader."Expected Opening Date") + '::' + Format(procheader."Expected Closing Date") + ':::';
                    end;
                end;
            until procheader.Next = 0;
        end;
    end;

    procedure ValidateVendorNo(pin: Code[20]) msg: Boolean
    begin
        vendors.RESET;
        vendors.SETRANGE("No.", pin);
        if vendors.Find('-') then begin
            msg := true;
        end;
    end;

    procedure GetVendorEmail(pin: Code[20]) msg: Text
    begin
        vendors.RESET;
        vendors.SETRANGE("No.", pin);
        if vendors.Find('-') then begin
            msg := vendors."E-Mail";
        end;
    end;

    procedure ChangeVendorPassword(pin: Code[20]; password: Text) msg: boolean
    begin
        vendors.RESET;
        vendors.SETRANGE("No.", pin);
        if vendors.Find('-') then begin
            vendors.Password := password;
            vendors.Modify;
            msg := true;
        end;
    end;

    procedure SaveVendorOTP(pin: Code[20]; otp: Code[20]) msg: boolean
    begin
        vendors.RESET;
        vendors.SETRANGE("No.", pin);
        if vendors.Find('-') then begin
            vendors.OTP := otp;
            vendors.Modify;
            msg := true;
        end;
    end;

    procedure GetVendorDetails(pin: Code[20]) msg: Text
    begin
        vendors.RESET;
        vendors.SETRANGE("No.", pin);
        if vendors.Find('-') then begin
            msg := vendors.Name + ' ::' + vendors."E-Mail" + ' ::' + vendors.Contact + ' ::' + vendors.Address + ' ::' + vendors."Contact Person" + ' ::' + vendors."Email 2" + ' ::' + vendors."Phone No.";
        end;
    end;

    procedure VerifyVendorOTP(pin: Code[20]; otp: Code[20]) msg: boolean
    begin
        vendors.RESET;
        vendors.SETRANGE(vendors."No.", pin);
        vendors.SetRange(vendors.OTP, otp);
        if vendors.Find('-') then begin
            msg := true;
        end;
    end;

    procedure CheckVendorLogin(username: Code[100]; userpassword: Text) msg: boolean
    begin
        vendors.RESET;
        vendors.SETRANGE("No.", username);
        IF vendors.FIND('-') THEN BEGIN
            IF (vendors.Password = userpassword) THEN BEGIN
                msg := true
            END ELSE BEGIN
                Error('Invalid Password');
            END
        END ELSE BEGIN
            Error('Invalid Username');
        END
    end;

    procedure GetVendorPassword(username: Code[100]) msg: text
    begin
        vendors.RESET;
        vendors.SETRANGE("No.", username);
        IF vendors.FIND('-') THEN BEGIN
            msg := vendors.Password;
        END;
    end;

    procedure GetVendorName(krapin: Code[20]) name: Text
    begin
        vendors.RESET;
        vendors.SETRANGE("No.", krapin);
        if vendors.FIND('-') then begin
            name := vendors.Name;
        end;
    end;
}
