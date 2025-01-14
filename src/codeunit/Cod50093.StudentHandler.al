codeunit 50093 "Student Handler"
{
    procedure CreateStudentSalesInvoiceHeader(StudentNo: code[20]; ExternalDocumentNo: Code[20]; BillToCustomerNo: Code[20]; Dim1Code: Code[20]; Dim2Code: Code[20]) No: code[20]
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.INIT;
        SalesHeader."No." := '';
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader."Sell-to Customer No." := StudentNo;
        SalesHeader.Validate("Sell-to Customer No.");
        SalesHeader."External Document No." := ExternalDocumentNo;
        SalesHeader.Validate("External Document No.");
        if BillToCustomerNo <> '' then begin
            SalesHeader."Bill-to Customer No." := BillToCustomerNo;
            SalesHeader.Validate("Bill-to Customer No.");
        end;
        SalesHeader."Shortcut Dimension 1 Code" := Dim1Code;
        SalesHeader.Validate("Shortcut Dimension 1 Code");
        SalesHeader."Shortcut Dimension 2 Code" := Dim2Code;
        SalesHeader.Validate("Shortcut Dimension 2 Code");
        if SalesHeader.Insert(true) then
            exit(SalesHeader."No.");
    end;

    procedure CreateStudentSalesInvoiceHeader(StudentNo: code[20]; ExternalDocumentNo: Code[20]; BillToCustomerNo: Code[20]; Dim1Code: Code[20]; Dim2Code: Code[20]; var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.INIT;
        SalesHeader."No." := '';
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader."Sell-to Customer No." := StudentNo;
        SalesHeader.Validate("Sell-to Customer No.");
        SalesHeader."External Document No." := ExternalDocumentNo;
        SalesHeader.Validate("External Document No.");
        if BillToCustomerNo <> '' then begin
            SalesHeader."Bill-to Customer No." := BillToCustomerNo;
            SalesHeader.Validate("Bill-to Customer No.");
        end;
        SalesHeader."Shortcut Dimension 1 Code" := Dim1Code;
        SalesHeader.Validate("Shortcut Dimension 1 Code");
        SalesHeader."Shortcut Dimension 2 Code" := Dim2Code;
        SalesHeader.Validate("Shortcut Dimension 2 Code");
        SalesHeader.Insert(true);
    end;

    procedure CreateStudentSalesInvoiceLine(SalesHeaderNo: code[20]; AccType: Enum "Sales Line Type"; AccNo: Code[20]; Quantity: Decimal; UnitPrice: Decimal; Dim1Code: Code[20]; Dim2Code: Code[20]) LineNo: Integer
    var
        SalesLine: Record "Sales Line";
    begin
        if Quantity <= 0 then
            Quantity := 1;
        SalesLine.INIT;
        SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
        SalesLine."Document No." := SalesHeaderNo;
        SalesLine."Type" := AccType;
        SalesLine.Validate("Type");
        SalesLine."No." := AccNo;
        SalesLine.Validate("No.");
        SalesLine.Quantity := Quantity;
        SalesLine.Validate(Quantity);
        SalesLine."Unit Price" := UnitPrice;
        SalesLine.Validate("Unit Price");
        SalesLine."Shortcut Dimension 1 Code" := Dim1Code;
        SalesLine.Validate("Shortcut Dimension 1 Code");
        SalesLine."Shortcut Dimension 2 Code" := Dim2Code;
        SalesLine.Validate("Shortcut Dimension 2 Code");
        if SalesLine.Insert(true) then
            exit(SalesLine."Line No.");
    end;

    procedure PostSalesInvoice(SalesHeaderNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesCard: Page "Sales Invoice";
    begin
        SalesHeader.GET(SalesHeaderNo);
        SalesCard.SetRecord(SalesHeader);
        SalesCard.CallPostDocument(CODEUNIT::"Sales-Post (Yes/No)", Enum::"Navigate After Posting"::"Do Nothing");
    end;

    procedure findCustomer(custNo: Code[20]; var Cust: record Customer)
    begin
        Cust.Reset();
        Cust.SetRange("No.", custNo);
        Cust.FindFirst();
    end;

    procedure handleStudentCertificateApplicationBilling(var CertApp: Record "Certificate Application"): Boolean
    var
        Cust: Record Customer;
        SalesHeader: Record "Sales Header";
    begin
        case
            CertApp."Application Type" of
            certapp."Application Type"::"New Certificate",
            certapp."Application Type"::"Special Examination":
                exit(false);
        end;
        findCustomer(CertApp."Student No.", Cust);
        CreateStudentSalesInvoiceHeader(CertApp."Student No.", CertApp."No.", CertApp."No.", Cust."Global Dimension 1 Code", Cust."Global Dimension 2 Code", SalesHeader);
        CreateStudentSalesInvoiceLine(SalesHeader."No.", Enum::"Sales Line Type"::"G/L Account", fnGetCertApplicChargeAccount(CertApp), 1, fnGetCertApplicChargeAmount(CertApp), Cust."Global Dimension 1 Code", Cust."Global Dimension 2 Code");
        PostSalesInvoice(SalesHeader."No.");
        CertApp."Invoice Date" := Today;
        CertApp.Invoiced := true;
    end;

    procedure fnGetCertApplicChargeAmount(var CertApp: Record "Certificate Application"): Decimal
    var
        CertSetup: Record "Certificate Issuance Setup";
    begin
        CertSetup.Get();
        case
            CertApp."Application Type" of
            CertApp."Application Type"::"Copy of Certificate":
                exit(CertSetup."Replacement Fee");
            CertApp."Application Type"::"Reissue Transcript":
                exit(CertSetup."Transcript Re-issuance Fee");
            CertApp."Application Type"::"Special Examination":
                exit(0);
        end;
    end;

    procedure fnGetCertApplicChargeAccount(var CertApp: Record "Certificate Application"): Code[20]
    var
        CertSetup: Record "Certificate Issuance Setup";
    begin
        CertSetup.Get();
        case
            CertApp."Application Type" of
            CertApp."Application Type"::"Copy of Certificate":
                exit(CertSetup."Replacement Fee Account");
            CertApp."Application Type"::"Reissue Transcript":
                exit(CertSetup."Transcript Re-issuance Fee Acc.");
            CertApp."Application Type"::"Special Examination":
                exit('');
        end;
    end;

}
