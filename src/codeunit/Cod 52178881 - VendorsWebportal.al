codeunit 50203 "VendorsWebportal"
{
    trigger OnRun()
    begin
    end;

    var
        TenderApplicantsRegister: Record "Tender Applicants Registration";
        tblTenderBidFinReq: Record "Tender Bidder Fin Reqs";
        vendors: Record Vendor;
        preqcategories: Record "Proc-Prequalif. Categories";
        preqapp: Record "Prequalification Application";
        years: Record "Proc-Prequalification Years";
        preqappcat: Record "Preq Application categories";
        ProcurementPurchaseHeader: Record "PROC-Purchase Quote Header";
        proclines: Record "PROC-Purchase Quote Line";
        TenderSubmissionHeader: Record "Tender Submission Header";
        tenderlines: Record "Tender Submission Lines";
        purpay: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        nextapplicno: Code[20];
        procheader: Record "PROC-Purchase Quote Header";

        FILESPATH: Label 'C:\inetpub\wwwroot\NDMAVendors\Downloads\';
        purchaseheader: Record "Purchase Header";
        purchaseline: Record "Purchase Line";

        tenderheader: Record "Tender Submission Header";
        reqvendors: Record "PROC-Quotation Request Vendors";
        catrequirements: Record "Proc Classification Requiremnt";

    [ServiceEnabled]
    procedure CreateBidderAccount(
        KRAPin: Code[20];
        CompName: Text; PostalAddress: Text;
        CompPhone: Text; CompEmail: Text;
        ContactPerson: Text; ContactPersonPhone: Text;
        ContactPersonEmail: Text; activationCode: Code[20]) msg: boolean
    begin
        TenderApplicantsRegister.RESET;
        TenderApplicantsRegister.SETRANGE(TenderApplicantsRegister."No.", KRAPin);

        IF NOT TenderApplicantsRegister.FIND('-') THEN BEGIN
            TenderApplicantsRegister."No." := KRAPin;
            TenderApplicantsRegister.Name := CompName;
            TenderApplicantsRegister."E-Mail" := CompEmail;
            TenderApplicantsRegister."Company Contact" := CompPhone;
            TenderApplicantsRegister.Address := PostalAddress;
            TenderApplicantsRegister."Contact Person" := ContactPerson;
            TenderApplicantsRegister."Phone No." := ContactPersonPhone;
            TenderApplicantsRegister."Contact Person Email" := ContactPersonEmail;
            TenderApplicantsRegister."VAT Registration No." := KRAPin;
            TenderApplicantsRegister.OTP := activationCode;
            TenderApplicantsRegister.INSERT;
            msg := True;
        END
        ELSE BEGIN
            Error('KRA Pin already registered!');
        END;
    end;

    procedure prequalificationapplied(krapin: Code[30]) msg: Boolean
    begin
        preqapp.Reset;
        preqapp.SetRange("VAT Registration No.", krapin);
        preqapp.SetRange(Period, GetCurrentPeriod());
        if preqapp.Find('-') then begin
            msg := true;
        end;
    end;

    [ServiceEnabled]
    procedure BidHeaderCreate(
        krapin: Code[20];
        tenderno: Code[20]) msg: Text
    begin
        ProcurementPurchaseHeader.Reset;
        ProcurementPurchaseHeader.SetRange("No.", tenderno);
        if ProcurementPurchaseHeader.Find('-') then begin
            TenderSubmissionHeader.Reset;
            TenderSubmissionHeader.SetRange("Tender No.", tenderno);
            TenderSubmissionHeader.SetRange("Bidder No", krapin);
            if not TenderSubmissionHeader.Find('-') then begin
                nextapplicno := NoSeriesMgt.GetNextNo('BID', 0D, True);
                TenderSubmissionHeader.init;
                TenderSubmissionHeader."No." := nextapplicno;
                TenderSubmissionHeader."Bidder No" := krapin;
                TenderSubmissionHeader."Tender No." := tenderno;
                TenderSubmissionHeader."Request for Quote No." := ProcurementPurchaseHeader."No.";
                TenderSubmissionHeader."Document Type" := ProcurementPurchaseHeader."Document Type";
                TenderSubmissionHeader."Procurement methods" := ProcurementPurchaseHeader."Procurement methods";
                TenderSubmissionHeader."Posting Description" := ProcurementPurchaseHeader.Description;
                TenderSubmissionHeader."Bid Status" := TenderSubmissionHeader."Bid Status"::pending;
                TenderSubmissionHeader."RFQ No." := ProcurementPurchaseHeader."Requisition No.";
                TenderSubmissionHeader."Document Date" := Today;
                TenderSubmissionHeader."Expected Opening Date" := CreateDateTime(ProcurementPurchaseHeader."Expected Opening Date", 0T);
                TenderSubmissionHeader."Expected Closing Date" := CreateDateTime(ProcurementPurchaseHeader."Expected Closing Date", 0T);
                if (TenderSubmissionHeader.insert) then
                    msg := nextapplicno
                else
                    msg := 'Error while saving header'
            end;
        end;
    end;

    procedure BidLineCreate(krapin: Code[20]; tenderno: Code[20]; bidno: code[20]; itemno: Code[20]; quoteamt: Decimal) msg: Boolean
    begin
        TenderSubmissionHeader.Reset;
        TenderSubmissionHeader.SetRange("No.", bidno);
        TenderSubmissionHeader.SetRange("Tender No.", tenderno);
        TenderSubmissionHeader.SetRange("Bidder No", krapin);
        if TenderSubmissionHeader.Find('-') then begin
            proclines.Reset;
            proclines.SetRange("Document Type", TenderSubmissionHeader."Document Type");
            proclines.SetRange("No.", itemno);
            proclines.SetRange("Document No.", tenderno);
            if proclines.Find('-') then begin
                tenderlines.Reset;
                tenderlines.SetRange("Document Type", TenderSubmissionHeader."Document Type");
                tenderlines.SetRange("Tender No.", tenderno);
                tenderlines.SetRange("Document No.", bidno);
                tenderlines.SetRange("No.", itemno);
                if not tenderlines.Find('-') then begin
                    tenderlines.init;
                    tenderlines.Type := proclines.Type;
                    tenderlines."No." := itemno;
                    tenderlines.Validate("No.");
                    tenderlines."Document Date" := Today;
                    tenderlines."Document No." := bidno;
                    tenderlines."Tender No." := tenderno;
                    tenderlines."RFQ No." := TenderSubmissionHeader."RFQ No.";
                    tenderlines."Buy-from Bidder No." := krapin;
                    tenderlines."Document Type" := TenderSubmissionHeader."Document Type";
                    tenderlines."Buy-from Bidder No." := krapin;
                    tenderlines."Direct Unit Cost" := quoteamt;
                    tenderlines."Unit of Measure" := proclines."Unit of Measure";
                    tenderlines.Quantity := proclines.Quantity;
                    tenderlines.Validate(Quantity);
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

    procedure SubmitBid(krapin: Code[20]; bidno: code[20]) msg: Boolean
    begin
        TenderSubmissionHeader.Reset;
        TenderSubmissionHeader.SetRange("Bidder No", krapin);
        TenderSubmissionHeader.SetRange("No.", bidno);
        if TenderSubmissionHeader.Find('-') then begin
            TenderSubmissionHeader."Bid Status" := TenderSubmissionHeader."Bid Status"::Submitted;
            TenderSubmissionHeader.Modify;
            msg := true;
        end;
    end;

    [ServiceEnabled]
    procedure TenderApplied(krapin: Code[20]; tenderno: Code[20]) returnText: Boolean
    begin
        TenderSubmissionHeader.Reset;
        TenderSubmissionHeader.SetRange("Bidder No", krapin);
        TenderSubmissionHeader.SetRange("Tender No.", tenderno);
        if TenderSubmissionHeader.find('-') then begin
            returnText := true;
        end else begin
            returnText := false;
        end;
    end;

    procedure GetMyBids(krapin: Code[20]) msg: Text
    begin
        TenderSubmissionHeader.Reset;
        TenderSubmissionHeader.SetCurrentKey("No.");
        TenderSubmissionHeader.SetRange("Bidder No", krapin);
        if TenderSubmissionHeader.Find('-') then begin
            repeat
                Msg += TenderSubmissionHeader."No." + ' ::' + TenderSubmissionHeader."Tender No." + ' ::' + TenderSubmissionHeader."Posting Description" + ' ::' + Format(TenderSubmissionHeader."Document Date") + ' ::' + Format(TenderSubmissionHeader."Expected Opening Date") + ' ::' + Format(TenderSubmissionHeader."Expected Closing Date") + ' ::' + Format(TenderSubmissionHeader."Bid Status") + ' :::';
            until TenderSubmissionHeader.next = 0;
        end;
    end;

    procedure GetMyBidLines(krapin: Code[20]; docno: Code[20]) msg: Text
    begin
        tenderlines.Reset;
        tenderlines.SetRange("Buy-from Bidder No.", krapin);
        tenderlines.SetRange("Document No.", docno);
        if tenderlines.Find('-') then begin
            repeat
                Msg += tenderlines."No." + ' ::' + tenderlines.Description + ' ::' + tenderlines."Unit of Measure" + ' ::' + Format(tenderlines."Direct Unit Cost") + ' ::' + Format(tenderlines.Quantity) + ' ::' + Format(tenderlines.Amount) + ' :::';
            until tenderlines.next = 0;
        end;
    end;

    procedure PreqApplicHeaderCreate(krapin: Code[30]) msg: boolean
    begin
        TenderApplicantsRegister.Reset;
        TenderApplicantsRegister.SetRange("No.", krapin);
        IF TenderApplicantsRegister.Find('-') then begin
            years.Reset;
            years.SetRange("Active Period", true);
            if years.Find('-') then begin
                preqapp.Reset;
                preqapp.SetRange("VAT Registration No.", TenderApplicantsRegister."No.");
                preqapp.SetRange(Period, years."Preq. Year");
                if not preqapp.Find('-') then begin
                    preqapp.init;
                    preqapp."VAT Registration No." := TenderApplicantsRegister."No.";
                    preqapp.Period := years."Preq. Year";
                    preqapp.Name := TenderApplicantsRegister.Name;
                    preqapp.Phone := TenderApplicantsRegister."Company Contact";
                    preqapp.Address := TenderApplicantsRegister.Address;
                    preqapp."Contact Person" := TenderApplicantsRegister."Contact Person";
                    preqapp."Contact Telephone" := TenderApplicantsRegister."Phone No.";
                    preqapp.Email := TenderApplicantsRegister."E-Mail";
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

    procedure SubmitPreqApp(KRAPin: Code[30]) msg: Boolean
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

    procedure GetPrequalificationApps(krapin: Code[30]) msg: Text
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
        ProcurementPurchaseHeader.Reset;
        ProcurementPurchaseHeader.SetRange("Procurement methods", ProcurementPurchaseHeader."Procurement methods"::"Open Tendering");
        ProcurementPurchaseHeader.SetRange(Status, ProcurementPurchaseHeader.Status::Open);
        if ProcurementPurchaseHeader.Find('-') then begin
            repeat
                msg += ProcurementPurchaseHeader."No." + ' ::' + ProcurementPurchaseHeader."Requisition No." + ' ::' + ProcurementPurchaseHeader.Description + ' ::' + Format(ProcurementPurchaseHeader."Expected Opening Date") + ' ::' + Format(ProcurementPurchaseHeader."Expected Closing Date") + ' :::';
            until ProcurementPurchaseHeader.Next = 0;
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

    procedure GetPreAppCategories(krapin: Code[30]; period: Code[30]) msg: Text
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

    procedure GetAppliedCategories(krapin: Code[30]) msg: Text
    begin
        preqappcat.Reset;
        preqappcat.SetRange("VAT Registration", krapin);
        preqappcat.SetRange(period, GetCurrentPeriod());
        if preqappcat.Find('-') then begin
            repeat
                preqcategories.Reset;
                preqCategories.SetRange("Category Code", preqappcat.Category);
                preqCategories.SetRange("Preq Year", GetPrequalifyear());
                if preqcategories.Find('-') then begin
                    msg += preqappcat.Category + ' ::' + preqCategories.Description + ' :::';
                end;
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

    procedure PreqAppLinesCreate(krapin: Code[30]; category: Code[30]) msg: Boolean
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

    [ServiceEnabled]
    procedure ValidateKRAPin(pin: Code[20]) isValidOrNot: Boolean
    begin
        TenderApplicantsRegister.RESET;
        TenderApplicantsRegister.SETRANGE(TenderApplicantsRegister."No.", pin);
        if TenderApplicantsRegister.Find('-') then begin
            isValidOrNot := true;
        end
        else begin
            isValidOrNot := false;
        end;
    end;

    procedure AccountActivated(pin: Code[20]) msg: Boolean
    begin
        TenderApplicantsRegister.RESET;
        TenderApplicantsRegister.SETRANGE(TenderApplicantsRegister."No.", pin);
        TenderApplicantsRegister.SETRANGE(TenderApplicantsRegister."Account Activated", true);
        if TenderApplicantsRegister.Find('-') then begin
            msg := true;
        end;
    end;

    procedure GetBidderEmail(pin: Code[20]) msg: Text
    begin
        TenderApplicantsRegister.RESET;
        TenderApplicantsRegister.SETRANGE(TenderApplicantsRegister."No.", pin);
        if TenderApplicantsRegister.Find('-') then begin
            msg := TenderApplicantsRegister."E-Mail";
        end;
    end;

    procedure ActivateBidderOnlineAccount(pin: Code[20]; activationcode: Code[20]) msg: boolean
    begin
        TenderApplicantsRegister.RESET;
        TenderApplicantsRegister.SETRANGE(TenderApplicantsRegister."No.", pin);
        TenderApplicantsRegister.SETRANGE(TenderApplicantsRegister.OTP, activationcode);
        if TenderApplicantsRegister.Find('-') then begin
            TenderApplicantsRegister."Account Activated" := true;
            TenderApplicantsRegister.Modify;
            msg := true;
        end;
    end;

    procedure ChangeBidderPassword(pin: Code[20]; password: Text) msg: boolean
    begin
        TenderApplicantsRegister.RESET;
        TenderApplicantsRegister.SETRANGE(TenderApplicantsRegister."No.", pin);
        if TenderApplicantsRegister.Find('-') then begin
            TenderApplicantsRegister.Password := password;
            TenderApplicantsRegister.Modify;
            msg := true;
        end;
    end;

    procedure SaveBidderOTP(pin: Code[20]; otp: Code[20]) msg: boolean
    begin
        TenderApplicantsRegister.RESET;
        TenderApplicantsRegister.SETRANGE(TenderApplicantsRegister."No.", pin);
        if TenderApplicantsRegister.Find('-') then begin
            TenderApplicantsRegister.OTP := otp;
            TenderApplicantsRegister.Modify;
            msg := true;
        end;
    end;

    procedure GetBidderDetails(pin: Code[20]) msg: Text
    begin
        TenderApplicantsRegister.RESET;
        TenderApplicantsRegister.SETRANGE(TenderApplicantsRegister."No.", pin);
        if TenderApplicantsRegister.Find('-') then begin
            msg := TenderApplicantsRegister.Name + ' ::' + TenderApplicantsRegister."E-Mail" + ' ::' + TenderApplicantsRegister."Company Contact" + ' ::' + TenderApplicantsRegister.Address + ' ::' + TenderApplicantsRegister."Contact Person" + ' ::' + TenderApplicantsRegister."Contact Person Email" + ' ::' + TenderApplicantsRegister."Phone No.";
        end;
    end;

    procedure GetPreqCategories() msg: Text
    begin
        preqcategories.Reset;
        preqCategories.SetFilter("Category Code", '<>%1', '');
        preqCategories.SetRange("Preq Year", GetPrequalifyear());
        if preqcategories.Find('-') then begin
            repeat
                msg += preqcategories."Category Code" + ' ::' + preqcategories.Description + ' :::';
            until preqcategories.Next = 0;
        end;
    end;

    procedure GetUnappliedPreqCategories(username: Code[20]) msg: Text
    begin
        preqcategories.Reset;
        preqCategories.SetFilter("Category Code", '<>%1', '');
        preqCategories.SetRange("Preq Year", GetPrequalifyear());
        if preqcategories.Find('-') then begin
            repeat
                preqappcat.Reset;
                preqappcat.SetRange("VAT Registration", username);
                preqappcat.SetRange(Period, GetCurrentPeriod());
                preqappcat.SetRange(Category, preqcategories."Category Code");
                if not preqappcat.Find('-') then begin
                    msg += preqcategories."Category Code" + ' ::' + preqcategories.Description + ' :::';
                end;
            until preqcategories.Next = 0;
        end;
    end;

    procedure AddedCategories(username: Code[50]) msg: Boolean
    begin
        preqappcat.Reset;
        preqappcat.SetRange("VAT Registration", username);
        preqappcat.SetRange(Period, GetCurrentPeriod());
        if preqappcat.Find('-') then begin
            msg := true;
        end;
    end;

    procedure GetPrequalifyear() prequalyear: Code[30];
    var
        preqyears: Record "Proc-Prequalification Years";
    begin
        preqyears.Reset;
        preqyears.SetRange("Active Period", TRUE);
        IF preqyears.FIND('-') THEN BEGIN
            prequalyear := preqyears."Preq. Year";
        END
    end;

    procedure VerifyBidderOTP(pin: Code[20]; otp: Code[20]) msg: boolean
    begin
        TenderApplicantsRegister.RESET;
        TenderApplicantsRegister.SETRANGE(TenderApplicantsRegister."No.", pin);
        TenderApplicantsRegister.SetRange(TenderApplicantsRegister.OTP, otp);
        if TenderApplicantsRegister.Find('-') then begin
            msg := true;
        end;
    end;

    procedure CheckBidderLogin(username: Text; userpassword: Text) msg: boolean
    var
        FullNames: Text;
    begin
        TenderApplicantsRegister.RESET;
        TenderApplicantsRegister.SETRANGE("No.", username);
        IF TenderApplicantsRegister.FIND('-') THEN BEGIN
            IF (TenderApplicantsRegister.Password = userpassword) THEN BEGIN
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
        TenderApplicantsRegister.RESET;
        TenderApplicantsRegister.SETRANGE("No.", krapin);
        if TenderApplicantsRegister.FIND('-') then begin
            name := TenderApplicantsRegister.Name;
        end;
    end;

    procedure CheckValidBidder(username: Text) Msg: Boolean
    begin
        TenderApplicantsRegister.RESET;
        TenderApplicantsRegister.SETRANGE(TenderApplicantsRegister."No.", username);
        IF TenderApplicantsRegister.FIND('-') THEN BEGIN
            Msg := true;
        END ELSE BEGIN
            Msg := false;
        END
    end;

    procedure FnApplicationAttachement(retNo: Code[50]; fileName: Text; attachment: BigText; tableId: Integer) return_value: Boolean
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
                DocAttachment1.Reset();
                DocAttachment1.SetRange("No.", retNo);
                DocAttachment1.SetRange("Table ID", FromRecRef.Number);
                DocAttachment1.SetRange("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(FileName)));
                if DocAttachment1.Find('-') then begin
                    DocAttachment1.DeleteAll;
                end;
                Clear(DocAttachment);
                DocAttachment.Init();
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("No.", retNo);
                DocAttachment.Validate("File Extension", FileManagement.GetExtension(FileName));
                DocAttachment.Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(FileName)));
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
        DocAttachment1: Record "Document Attachment";
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
                DocAttachment1.Reset();
                DocAttachment1.SetRange("No.", retNo);
                DocAttachment1.SetRange("Table ID", FromRecRef.Number);
                DocAttachment1.SetRange("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(FileName)));
                if DocAttachment1.Find('-') then begin
                    DocAttachment1.DeleteAll;
                end;
                Clear(DocAttachment);
                DocAttachment.Init();
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("No.", retNo);
                DocAttachment.Validate("File Extension", FileManagement.GetExtension(FileName));
                DocAttachment.Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(FileName)));
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

    procedure fileattached(username: code[50]; filename: Text) exists: Boolean
    var
        DocAttachment1: Record "Document Attachment";
    begin
        DocAttachment1.Reset();
        DocAttachment1.SetRange("No.", username);
        DocAttachment1.SetRange("Table ID", Database::"Prequalification Application");
        DocAttachment1.SetRange("File Name", filename);
        if DocAttachment1.Find('-') then begin
            exists := true;
        end;
    end;

    procedure GetCategoryRequirements(category: Code[30]; username: Code[50]) msg: Text
    begin
        catrequirements.Reset;
        catrequirements.SetRange(Code, category);
        catrequirements.SetFilter(Description, '<>%1', '');
        catrequirements.SetFilter(Mandatory, '<>%1', catrequirements.Mandatory::" ");
        if catrequirements.Find('-') then begin
            repeat
                msg += catrequirements.Description + '::' + Format(catrequirements.Mandatory) + '::' + Format(fileattached(username, catrequirements.Description)) + ':::';
            until catrequirements.Next = 0;
        end;
    end;

    procedure NotAllMandatoryDocsAttachment(username: code[50]; category: code[30]) msg: Boolean
    begin
        catrequirements.Reset;
        catrequirements.SetRange(Code, category);
        catrequirements.SetRange(Mandatory, catrequirements.Mandatory::Yes);
        if catrequirements.Find('-') then begin
            repeat
                if not fileattached(username, catrequirements.Description) then begin
                    msg := true;
                    break;
                end;
            until catrequirements.next = 0;
        end;
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
        ObjAppliRec: Record "Tender Submission Header";

    begin

        tableFound := false;
        return_value := false;
        if TableID = Database::"Tender Submission Header" then begin
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
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("No.", retNo);
                DocAttachment.Validate("File Extension", FileManagement.GetExtension(FileName));
                DocAttachment.Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(FileName)));
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
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

    procedure RFQLineCreate(krapin: Code[20]; tenderno: Code[20]; bidno: code[20]; itemno: Code[20]; quoteamt: Decimal) msg: Boolean
    begin
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
                    purchaseline.init;
                    purchaseline.Type := proclines.Type;
                    purchaseline."Document No." := bidno;
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
                    purchaseline."Location Code" := 'General';
                    purchaseline.Quantity := proclines.Quantity;
                    purchaseline.Validate(Quantity);
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

    procedure RFQApplied(krapin: Code[20]; tenderno: Code[20]) msg: Boolean
    begin
        purchaseheader.Reset;
        purchaseheader.SetRange("Buy-from Vendor No.", krapin);
        purchaseheader.SetRange("Request for Quote No.", tenderno);
        if purchaseheader.find('-') then begin
            msg := true;
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
                DocAttachment1.Reset();
                DocAttachment1.SetRange("No.", retNo);
                DocAttachment1.SetRange("Table ID", FromRecRef.Number);
                DocAttachment1.SetRange("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(FileName)));
                if DocAttachment1.Find('-') then begin
                    DocAttachment1.DeleteAll;
                end;
                Clear(DocAttachment);
                DocAttachment.Init();
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("File Extension", FileManagement.GetExtension(fileName));
                DocAttachment.Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(fileName), 1, MaxStrLen(fileName)));
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

    procedure CheckVendorLogin(username: Code[20]; userpassword: Text) msg: boolean
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

    procedure GetVendorName(krapin: Code[20]) name: Text
    begin
        vendors.RESET;
        vendors.SETRANGE("No.", krapin);
        if vendors.FIND('-') then begin
            name := vendors.Name;
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
                nextapplicno := NoSeriesMgt.GetNextNo('RFQ', 0D, True);
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
                purchaseheader."Posting Description" := procheader.Description;
                purchaseheader."Quote Status" := purchaseheader."Quote Status"::Pending;
                purchaseheader."Document Date" := Today;
                purchaseheader."Expected Opening Date" := CreateDateTime(procheader."Expected Opening Date", 0T);
                purchaseheader."Expected Closing Date" := CreateDateTime(procheader."Expected Closing Date", 0T);
                purchaseheader.insert;
                msg := nextapplicno;
            end;
        end;
    end;

}
